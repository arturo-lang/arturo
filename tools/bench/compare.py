#!/usr/bin/env python3
## Compare two Arturo binaries (base vs head) on a set of benchmarks
##
## usage: compare.py <base> <head> [options]
##
## Two modes:
##
##  * time (default): every benchmark runs many times per binary -
##    interleaved, in rotating order - and we keep the best CPU time
##    (user+sys). The base binary runs twice per round: the second set
##    ("control") shows how much of a difference is just noise.
##
##  * instructions: every benchmark runs once per binary under
##    valgrind (cachegrind), counting executed instructions. That's
##    (almost) deterministic, so there's virtually no noise - but it
##    says nothing about caches or branch prediction.
##
## Groups:
##
##  * ops           tools/pgo/train/*.art - one operation each, in a loop
##  * programs      tools/bench/*.art - small programs
##  * real-world    tools/bench/long_*.art - longer, more realistic ones
##  * rosetta       the examples repo (--examples), the ones that are
##                  deterministic (their output matches their .res) and
##                  take long enough to measure
##  * var-names     the same loop, for many different variable names
##  * param-names   the same function call, for many parameter names

import argparse, json, math, os, random, re, resource, shutil
import statistics, subprocess, sys, tempfile, time
import urllib.parse
from concurrent.futures import ThreadPoolExecutor

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))

# names with no meaning to Arturo: where each one lands
# in the symbol table is pure luck
NAMES = list("abcdefghijklmnopqrstuvwxyz") + [
    "idx", "count", "total", "result", "value", "item", "acc", "tmp",
    "data", "num", "pos", "cur", "res", "lst", "arr", "str", "ret",
    "counter", "current", "node", "word", "myVariable", "aVeryLongVariableName"
]

VAR_TEMPLATE = "{n}: 0\nloop 1..300000 'it [ {n}: {n} + 1 ]\nprint {n}\n"
PARAM_TEMPLATE = "f: function [{n}][ {n} + 1 ]\nr: 0\nloop 1..150000 'it [ r: f it ]\nprint r\n"

ALL_GROUPS = ["ops", "programs", "real-world", "rosetta", "var-names", "param-names"]

#=======================================
# Helpers
#=======================================

class Bench:
    def __init__(self, group, name, path, expected=None):
        self.group = group
        self.name = name
        self.path = path
        self.expected = expected    # normalized .res contents, if any
        self.estimate = None        # rough time of one run (seconds)
        self.best = {}              # which -> best cpu time / instructions
        self.median = {}
        self.rss = {}
        self.rounds = 0

    @property
    def id(self):
        return self.group + "/" + self.name

def normalize(output):
    return [l.rstrip() for l in output.decode("utf-8", "replace").strip().splitlines()]

def runTimed(binary, bench, timeout):
    ## run sequentially, measuring the child's CPU time;
    ## returns (cpu seconds, max RSS, stdout, ok)
    before = resource.getrusage(resource.RUSAGE_CHILDREN)
    try:
        proc = subprocess.run([binary, os.path.basename(bench.path)],
                              cwd=os.path.dirname(bench.path),
                              stdin=subprocess.DEVNULL,
                              stdout=subprocess.PIPE, stderr=subprocess.DEVNULL,
                              timeout=timeout)
        out, ok = proc.stdout, proc.returncode == 0
    except subprocess.TimeoutExpired:
        out, ok = b"", False
    after = resource.getrusage(resource.RUSAGE_CHILDREN)
    cpu = (after.ru_utime - before.ru_utime) + (after.ru_stime - before.ru_stime)
    return cpu, after.ru_maxrss, out, ok

IREFS = re.compile(r"I\s+refs:\s+([\d,]+)")

def runCounted(binary, bench, timeout):
    ## run under cachegrind; returns (instructions, None, stdout, ok)
    try:
        proc = subprocess.run(["valgrind", "--tool=cachegrind", "--cache-sim=no",
                               "--cachegrind-out-file=/dev/null",
                               binary, os.path.basename(bench.path)],
                              cwd=os.path.dirname(bench.path),
                              stdin=subprocess.DEVNULL,
                              stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                              timeout=timeout)
    except subprocess.TimeoutExpired:
        return None, None, b"", False
    m = IREFS.search(proc.stderr.decode("utf-8", "replace"))
    if not m:
        return None, None, proc.stdout, False
    return int(m.group(1).replace(",", "")), None, proc.stdout, proc.returncode == 0

def geomean(xs):
    return math.exp(sum(math.log(x) for x in xs) / len(xs)) if xs else 1.0

def bootstrap(ratios, n=2000):
    ## 95% confidence interval of the geometric mean, resampling benchmarks
    if len(ratios) < 2:
        return (geomean(ratios), geomean(ratios))
    rng = random.Random(1)
    logs = [math.log(r) for r in ratios]
    means = sorted(math.exp(sum(rng.choice(logs) for _ in logs) / len(logs)) for _ in range(n))
    return (means[int(0.025 * n)], means[int(0.975 * n) - 1])

def pct(ratio):
    return "%+.1f%%" % ((ratio - 1.0) * 100)

def fmt(v, mode):
    if mode == "instructions":
        return "%.1fM" % (v / 1e6)
    return "%.3fs" % v

#=======================================
# Collecting benchmarks
#=======================================

def collect(args, tmp):
    benches = []
    groups = set(args.groups)

    if "ops" in groups:
        d = os.path.join(ROOT, "tools", "pgo", "train")
        for f in sorted(os.listdir(d)):
            if f.endswith(".art"):
                benches.append(Bench("ops", f[:-4], os.path.join(d, f)))

    for f in sorted(os.listdir(HERE)):
        if not f.endswith(".art"):
            continue
        group = "real-world" if f.startswith("long_") else "programs"
        if group in groups:
            benches.append(Bench(group, f[:-4], os.path.join(HERE, f)))

    for group, template in (("var-names", VAR_TEMPLATE), ("param-names", PARAM_TEMPLATE)):
        if group not in groups:
            continue
        for n in NAMES:
            path = os.path.join(tmp, group + "_" + n + ".art")
            with open(path, "w") as f:
                f.write(template.format(n=n))
            benches.append(Bench(group, n, path))

    if "rosetta" in groups and args.examples:
        for f in sorted(os.listdir(args.examples)):
            if not f.endswith(".res"):
                continue
            script = os.path.join(args.examples, f[:-4] + ".art")
            if not os.path.exists(script):
                continue
            with open(os.path.join(args.examples, f), "rb") as r:
                expected = normalize(r.read())
            benches.append(Bench("rosetta", urllib.parse.unquote(f[:-4]), script, expected))

    if args.filter:
        benches = [b for b in benches if args.filter in b.id]

    return benches

def calibrate(benches, args, base):
    ## one run with the base binary: how long does each one take,
    ## and - for the examples - is it deterministic & long enough?
    kept, dropped = [], 0
    rosetta = []
    for b in benches:
        cpu, _, out, ok = runTimed(base, b, args.timeout)
        b.estimate = cpu
        if b.group == "rosetta":
            if ok and normalize(out) == b.expected and args.min_example <= cpu <= args.max_example:
                rosetta.append(b)
            else:
                dropped += 1
        else:
            kept.append(b)
    # an even spread, from the shortest to the longest ones
    rosetta.sort(key=lambda b: b.estimate)
    if len(rosetta) > args.max_examples:
        step = len(rosetta) / args.max_examples
        picked = [rosetta[int(i * step)] for i in range(args.max_examples)]
        dropped += len(rosetta) - len(picked)
        rosetta = picked
    kept += sorted(rosetta, key=lambda b: b.name)
    return kept, dropped

#=======================================
# Measuring
#=======================================

def measureTime(benches, binaries, args):
    order = ["base", "head", "control"]
    broken = []
    for b in benches:
        rounds = max(args.min_rounds, min(args.max_rounds, math.ceil(args.target / max(b.estimate, 0.001))))
        samples = {k: [] for k in order}
        rss = {k: 0 for k in order}
        outputs = set()
        failed = False

        for which in order:     # warm-up
            runTimed(binaries[which], b, args.timeout)

        for r in range(rounds):
            for which in order[r % 3:] + order[:r % 3]:
                cpu, mem, out, ok = runTimed(binaries[which], b, args.timeout)
                samples[which].append(cpu)
                rss[which] = max(rss[which], mem)
                outputs.add(out)
                failed = failed or not ok

        if failed or len(outputs) != 1:
            broken.append(b.id)
            continue

        b.rounds = rounds
        b.best = {k: min(v) for k, v in samples.items()}
        b.median = {k: statistics.median(v) for k, v in samples.items()}
        b.rss = rss
        print("%-12s %-36s x%-3d base %s  head %s  %s  (control %s)" % (
            b.group, b.name[:36], rounds, fmt(b.best["base"], "time"), fmt(b.best["head"], "time"),
            pct(b.best["head"] / b.best["base"]), pct(b.best["control"] / b.best["base"])), flush=True)

    return [b for b in benches if b.best], broken

def measureInstructions(benches, binaries, args):
    order = ["base", "head", "control"]
    broken = []

    def job(b):
        res = {}
        outs = set()
        for which in order:
            n, _, out, ok = runCounted(binaries[which], b, args.timeout * 60)
            if n is None or not ok:
                return b, None, None
            res[which] = n
            outs.add(out)
        return b, res, len(outs) == 1

    with ThreadPoolExecutor(max_workers=args.jobs) as pool:
        for b, res, same in pool.map(job, benches):
            if res is None or not same:
                broken.append(b.id)
                continue
            b.rounds = 1
            b.best = b.median = res
            print("%-12s %-36s base %s  head %s  %s  (control %s)" % (
                b.group, b.name[:36], fmt(res["base"], "instructions"), fmt(res["head"], "instructions"),
                pct(res["head"] / res["base"]), pct(res["control"] / res["base"])), flush=True)

    return [b for b in benches if b.best], broken

#=======================================
# Reporting
#=======================================

def report(results, broken, dropped, args, elapsed):
    mode = args.mode
    what = "instructions executed (valgrind)" if mode == "instructions" else "best CPU time"
    lines = []
    lines.append("## Benchmark: head vs base" + (" (" + args.label + ")" if args.label else ""))
    lines.append("")
    lines.append("%d benchmarks, %s, %.0f minutes in total. Negative = head is faster." % (
        len(results), what, elapsed / 60))
    if dropped:
        lines.append("")
        lines.append("Examples considered but not used (not deterministic, failing, too short or too long, or over the limit): %d." % dropped)
    lines.append("")
    lines.append("| group | benchmarks | head vs base | 95% CI | control vs base (noise) | faster (>2%) | slower (>2%) |")
    lines.append("|---|---|---|---|---|---|---|")

    overall = {}
    def row(label, rs):
        ratios = [b.best["head"] / b.best["base"] for b in rs]
        noise = [b.best["control"] / b.best["base"] for b in rs]
        lo, hi = bootstrap(ratios)
        lines.append("| %s | %d | **%s** | %s .. %s | %s | %d | %d |" % (
            label, len(rs), pct(geomean(ratios)), pct(lo), pct(hi), pct(geomean(noise)),
            sum(1 for x in ratios if x < 0.98), sum(1 for x in ratios if x > 1.02)))
        return geomean(ratios)

    for group in ALL_GROUPS:
        rs = [b for b in results if b.group == group]
        if rs:
            row(group, rs)
    overall = row("**all**", results)

    total = {k: sum(b.best[k] for b in results) for k in ("base", "head", "control")}
    lines.append("")
    lines.append("Sum over all benchmarks: base %s, head %s (%s), control %s (%s)." % (
        fmt(total["base"], mode), fmt(total["head"], mode), pct(total["head"] / total["base"]),
        fmt(total["control"], mode), pct(total["control"] / total["base"])))

    if mode == "time":
        med = geomean([b.median["head"] / b.median["base"] for b in results])
        medNoise = geomean([b.median["control"] / b.median["base"] for b in results])
        lines.append("")
        lines.append("Using medians instead of best times: head %s, control %s." % (pct(med), pct(medNoise)))
        mem = geomean([b.rss["head"] / b.rss["base"] for b in results if b.rss.get("base")])
        lines.append("")
        lines.append("Peak memory (geometric mean): %s." % pct(mem))

    byRatio = sorted(results, key=lambda b: b.best["head"] / b.best["base"])

    def table(title, rs):
        lines.append("")
        lines.append("<details><summary>%s</summary>" % title)
        lines.append("")
        lines.append("| benchmark | runs | base | head | head vs base | control vs base |")
        lines.append("|---|---|---|---|---|---|")
        for b in rs:
            lines.append("| %s | %d | %s | %s | %s | %s |" % (
                b.id, b.rounds, fmt(b.best["base"], mode), fmt(b.best["head"], mode),
                pct(b.best["head"] / b.best["base"]), pct(b.best["control"] / b.best["base"])))
        lines.append("")
        lines.append("</details>")

    table("15 biggest wins", byRatio[:15])
    table("15 biggest losses", byRatio[::-1][:15])
    for group in ALL_GROUPS:
        rs = [b for b in results if b.group == group]
        if rs:
            table("all: " + group, rs)

    if broken:
        lines.append("")
        lines.append("Failed, or with different output between runs/binaries: " + ", ".join(broken))

    verdict = "OK" if overall <= args.max_ratio and not broken else "FAILED"
    lines.append("")
    lines.append("Result: **%s** (limit: head no more than %s slower overall)" % (verdict, pct(args.max_ratio)))
    return "\n".join(lines) + "\n", verdict

#=======================================
# Main
#=======================================

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("base")
    ap.add_argument("head")
    ap.add_argument("--mode", choices=["time", "instructions"], default="time")
    ap.add_argument("--groups", default=",".join(ALL_GROUPS))
    ap.add_argument("--filter", default="")
    ap.add_argument("--examples", default="", help="examples directory (e.g. examples/src/rosetta)")
    ap.add_argument("--max-examples", type=int, default=50)
    ap.add_argument("--min-example", type=float, default=0.2, help="seconds")
    ap.add_argument("--max-example", type=float, default=6.0, help="seconds")
    ap.add_argument("--target", type=float, default=4.0, help="seconds of measuring per benchmark & binary")
    ap.add_argument("--min-rounds", type=int, default=5)
    ap.add_argument("--max-rounds", type=int, default=25)
    ap.add_argument("--timeout", type=float, default=30.0)
    ap.add_argument("--jobs", type=int, default=os.cpu_count() or 2, help="parallel runs (instructions mode)")
    ap.add_argument("--max-ratio", type=float, default=1.02, help="fail if head is overall slower than this")
    ap.add_argument("--label", default="")
    ap.add_argument("--json", default="")
    args = ap.parse_args()
    args.groups = [g for g in args.groups.split(",") if g]
    if args.examples:
        args.examples = os.path.abspath(args.examples)

    tmp = tempfile.mkdtemp(prefix="artbench")
    # same binary, different path: so that the control
    # doesn't share anything the head doesn't
    control = os.path.join(tmp, "arturo-control")
    shutil.copy2(args.base, control)
    binaries = {"base": os.path.abspath(args.base),
                "head": os.path.abspath(args.head),
                "control": control}

    started = time.time()
    benches = collect(args, tmp)
    print("calibrating %d benchmarks..." % len(benches), flush=True)
    benches, dropped = calibrate(benches, args, binaries["base"])
    print("measuring %d benchmarks (%s)..." % (len(benches), args.mode), flush=True)

    if args.mode == "instructions":
        results, broken = measureInstructions(benches, binaries, args)
    else:
        results, broken = measureTime(benches, binaries, args)

    shutil.rmtree(tmp, ignore_errors=True)

    if not results:
        print("no benchmarks ran")
        return 1

    text, verdict = report(results, broken, dropped, args, time.time() - started)
    print()
    print(text)
    if os.environ.get("GITHUB_STEP_SUMMARY"):
        with open(os.environ["GITHUB_STEP_SUMMARY"], "a") as f:
            f.write(text)
    if args.json:
        with open(args.json, "w") as f:
            json.dump([{"id": b.id, "rounds": b.rounds, "best": b.best, "median": b.median}
                       for b in results], f, indent=1)

    return 0 if verdict == "OK" else 1

if __name__ == "__main__":
    sys.exit(main())
