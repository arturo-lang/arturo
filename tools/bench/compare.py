#!/usr/bin/env python3
## Compare two or more Arturo binaries on a set of benchmarks
##
## usage: compare.py <name>=<binary> <name>=<binary> ... [options]
##
## The first one is the reference: every other one is compared
## to it, and to the one right before it.
##
## Two modes:
##
##  * time (default): every benchmark runs many times per binary -
##    interleaved, in rotating order - and we keep the best CPU time
##    (user+sys). The reference binary runs twice per round: the second
##    set ("control") shows how much of a difference is just noise.
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

def calibrate(benches, args, binaries, names):
    ## one run with every binary: how long does each one take (with
    ## the reference), and - for the examples - is it deterministic
    ## & long enough, with all of them?
    kept, dropped = [], 0
    rosetta = []
    for b in benches:
        cpu, _, out, ok = runTimed(binaries[names[0]], b, args.timeout)
        b.estimate = cpu
        if b.group == "rosetta":
            fine = ok and normalize(out) == b.expected and args.min_example <= cpu <= args.max_example
            for name in names[1:]:
                if not fine:
                    break
                _, _, out, ok = runTimed(binaries[name], b, args.timeout)
                fine = ok and normalize(out) == b.expected
            if fine:
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

def line(b, names, mode):
    ref = names[0]
    parts = ["%s %s" % (ref, fmt(b.best[ref], mode))]
    for name in names[1:]:
        parts.append("%s %s (%s)" % (name, fmt(b.best[name], mode), pct(b.best[name] / b.best[ref])))
    parts.append("control %s" % pct(b.best["control"] / b.best[ref]))
    return "%-12s %-34s x%-3d %s" % (b.group, b.name[:34], b.rounds, "  ".join(parts))

def measureTime(benches, binaries, names, args):
    order = names + ["control"]
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
            k = r % len(order)
            for which in order[k:] + order[:k]:
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
        print(line(b, names, "time"), flush=True)

    return [b for b in benches if b.best], broken

def measureInstructions(benches, binaries, names, args):
    order = names + ["control"]
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
            print(line(b, names, "instructions"), flush=True)

    return [b for b in benches if b.best], broken

#=======================================
# Reporting
#=======================================

def report(results, broken, dropped, names, args, elapsed):
    mode = args.mode
    what = "instructions executed (valgrind)" if mode == "instructions" else "best CPU time"
    ref = names[0]

    # what we compare: everyone to the reference,
    # and everyone to the one right before it
    pairs = [(n, ref) for n in names[1:]]
    pairs += [(names[i], names[i-1]) for i in range(2, len(names))]

    def ratios(rs, a, b, key="best"):
        return [getattr(x, key)[a] / getattr(x, key)[b] for x in rs]

    lines = []
    lines.append("## Benchmark: " + " vs ".join(names) + (" (" + args.label + ")" if args.label else ""))
    lines.append("")
    lines.append("%d benchmarks, %s, %.0f minutes in total. Negative = the first one of the two is faster." % (
        len(results), what, elapsed / 60))
    if dropped:
        lines.append("")
        lines.append("Examples considered but not used (not deterministic, failing, too short or too long, or over the limit): %d." % dropped)
    lines.append("")
    lines.append("| group | benchmarks | " + " | ".join("%s vs %s" % p for p in pairs) + " | control vs %s (noise) |" % ref)
    lines.append("|---|---|" + "---|" * (len(pairs) + 1))

    def row(label, rs):
        cells = []
        for a, b in pairs:
            xs = ratios(rs, a, b)
            lo, hi = bootstrap(xs)
            cells.append("**%s** (%s .. %s)" % (pct(geomean(xs)), pct(lo), pct(hi)))
        lines.append("| %s | %d | %s | %s |" % (label, len(rs), " | ".join(cells), pct(geomean(ratios(rs, "control", ref)))))

    for group in ALL_GROUPS:
        rs = [b for b in results if b.group == group]
        if rs:
            row(group, rs)
    row("**all**", results)

    lines.append("")
    lines.append("In parentheses: the 95% confidence interval of each (geometric) mean.")

    total = {k: sum(b.best[k] for b in results) for k in names + ["control"]}
    lines.append("")
    lines.append("Sum over all benchmarks: " + ", ".join(
        ["%s %s" % (ref, fmt(total[ref], mode))] +
        ["%s %s (%s)" % (n, fmt(total[n], mode), pct(total[n] / total[ref])) for n in names[1:] + ["control"]]) + ".")

    lines.append("")
    lines.append("| | faster (>2%) | slower (>2%) |")
    lines.append("|---|---|---|")
    for a, b in pairs:
        xs = ratios(results, a, b)
        lines.append("| %s vs %s | %d | %d |" % (a, b, sum(1 for x in xs if x < 0.98), sum(1 for x in xs if x > 1.02)))

    if mode == "time":
        lines.append("")
        lines.append("Using medians instead of best times: " + ", ".join(
            "%s vs %s %s" % (a, b, pct(geomean(ratios(results, a, b, "median")))) for a, b in pairs) +
            ", control %s." % pct(geomean(ratios(results, "control", ref, "median"))))

    def table(title, rs):
        lines.append("")
        lines.append("<details><summary>%s</summary>" % title)
        lines.append("")
        lines.append("| benchmark | runs | " + " | ".join(names) + " | " + " | ".join("%s vs %s" % p for p in pairs) + " | control |")
        lines.append("|---|---|" + "---|" * (len(names) + len(pairs) + 1))
        for x in rs:
            lines.append("| %s | %d | %s | %s | %s |" % (
                x.id, x.rounds, " | ".join(fmt(x.best[n], mode) for n in names),
                " | ".join(pct(x.best[a] / x.best[b]) for a, b in pairs),
                pct(x.best["control"] / x.best[ref])))
        lines.append("")
        lines.append("</details>")

    last = names[-1]
    byRatio = sorted(results, key=lambda x: x.best[last] / x.best[ref])
    table("15 biggest wins (%s vs %s)" % (last, ref), byRatio[:15])
    table("15 biggest losses (%s vs %s)" % (last, ref), byRatio[::-1][:15])
    for group in ALL_GROUPS:
        rs = [b for b in results if b.group == group]
        if rs:
            table("all: " + group, rs)

    if broken:
        lines.append("")
        lines.append("Failed, or with different output between runs/binaries (not counted): " + ", ".join(broken))

    return "\n".join(lines) + "\n"

#=======================================
# Main
#=======================================

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("binaries", nargs="+", metavar="name=binary")
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
    ap.add_argument("--label", default="")
    ap.add_argument("--json", default="")
    args = ap.parse_args()
    args.groups = [g for g in args.groups.split(",") if g]
    if args.examples:
        args.examples = os.path.abspath(args.examples)

    names, binaries = [], {}
    for spec in args.binaries:
        name, _, path = spec.partition("=")
        if not path or name in binaries or name == "control":
            ap.error("expected unique <name>=<binary> pairs, got: " + spec)
        names.append(name)
        binaries[name] = os.path.abspath(path)
    if len(names) < 2:
        ap.error("at least two binaries needed")

    tmp = tempfile.mkdtemp(prefix="artbench")
    # same binary as the reference, different path: so that
    # the control doesn't share anything the others don't
    binaries["control"] = os.path.join(tmp, "arturo-control")
    shutil.copy2(binaries[names[0]], binaries["control"])

    started = time.time()
    benches = collect(args, tmp)
    print("calibrating %d benchmarks..." % len(benches), flush=True)
    benches, dropped = calibrate(benches, args, binaries, names)
    print("measuring %d benchmarks (%s)..." % (len(benches), args.mode), flush=True)

    if args.mode == "instructions":
        results, broken = measureInstructions(benches, binaries, names, args)
    else:
        results, broken = measureTime(benches, binaries, names, args)

    shutil.rmtree(tmp, ignore_errors=True)

    if not results:
        print("no benchmarks ran")
        return 1

    text = report(results, broken, dropped, names, args, time.time() - started)
    print()
    print(text)
    if os.environ.get("GITHUB_STEP_SUMMARY"):
        with open(os.environ["GITHUB_STEP_SUMMARY"], "a") as f:
            f.write(text)
    if args.json:
        with open(args.json, "w") as f:
            json.dump({"binaries": names,
                       "broken": broken,
                       "results": [{"id": b.id, "rounds": b.rounds, "best": b.best, "median": b.median}
                                   for b in results]}, f, indent=1)

    return 0

if __name__ == "__main__":
    sys.exit(main())
