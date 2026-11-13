#!/usr/bin/env python3
## Compare two Arturo binaries (base vs head) on a set of benchmarks
##
## usage: compare.py <base> <head> [--rounds N] [--filter STR] [--max-ratio X]
##
## Every benchmark is run N times per binary - interleaved, in rotating
## order - and we keep the best CPU time (user+sys) of each. The base binary
## runs twice per round: the second set ("control") shows how much of
## the difference is just noise.

import argparse, math, os, shutil, subprocess, sys, tempfile, time

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

def collect(tmp):
    groups = {}

    def add(group, path):
        groups.setdefault(group, []).append(path)

    for name in sorted(os.listdir(os.path.join(ROOT, "tools", "pgo", "train"))):
        if name.endswith(".art"):
            add("ops", os.path.join(ROOT, "tools", "pgo", "train", name))

    for name in sorted(os.listdir(HERE)):
        if name.endswith(".art"):
            add("programs", os.path.join(HERE, name))

    for group, template in (("var-names", VAR_TEMPLATE), ("param-names", PARAM_TEMPLATE)):
        for n in NAMES:
            path = os.path.join(tmp, group + "_" + n + ".art")
            with open(path, "w") as f:
                f.write(template.format(n=n))
            add(group, path)

    return groups

def run(binary, script):
    ## returns (cpu seconds, max RSS, stdout)
    with tempfile.TemporaryFile() as out:
        proc = subprocess.Popen([binary, os.path.basename(script)],
                                cwd=os.path.dirname(script),
                                stdout=out, stderr=subprocess.DEVNULL)
        _, status, usage = os.wait4(proc.pid, 0)
        proc.returncode = status
        out.seek(0)
        return (usage.ru_utime + usage.ru_stime, usage.ru_maxrss, out.read(), status)

def geomean(xs):
    return math.exp(sum(math.log(x) for x in xs) / len(xs)) if xs else 1.0

def pct(ratio):
    return "%+.1f%%" % ((ratio - 1.0) * 100)

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("base")
    ap.add_argument("head")
    ap.add_argument("--rounds", type=int, default=7)
    ap.add_argument("--filter", default="")
    ap.add_argument("--max-ratio", type=float, default=1.02,
                    help="fail if head is overall slower than this")
    args = ap.parse_args()

    tmp = tempfile.mkdtemp(prefix="artbench")
    # same binary, different path: so that the control
    # doesn't share anything the head doesn't
    control = os.path.join(tmp, "arturo-control")
    shutil.copy2(args.base, control)

    binaries = {"base": os.path.abspath(args.base),
                "head": os.path.abspath(args.head),
                "control": control}
    order = ["base", "head", "control"]

    groups = collect(tmp)
    results = []   # (group, name, {which: best cpu}, {which: rss})
    broken = []
    started = time.time()

    for group, scripts in groups.items():
        for script in scripts:
            name = os.path.splitext(os.path.basename(script))[0]
            if args.filter and args.filter not in group + "/" + name:
                continue

            best = {k: float("inf") for k in order}
            rss = {k: 0 for k in order}
            outputs = {}
            failed = False

            for which in order:     # warm-up
                run(binaries[which], script)

            for r in range(args.rounds):
                for which in order[r % 3:] + order[:r % 3]:
                    cpu, mem, out, status = run(binaries[which], script)
                    best[which] = min(best[which], cpu)
                    rss[which] = max(rss[which], mem)
                    outputs[which] = out
                    if status != 0:
                        failed = True

            if failed or outputs["base"] != outputs["head"]:
                broken.append(group + "/" + name)
                continue

            results.append((group, name, best, rss))
            print("%-12s %-28s base %.3fs  head %.3fs  %s  (control %s)" % (
                group, name, best["base"], best["head"],
                pct(best["head"] / best["base"]),
                pct(best["control"] / best["base"])), flush=True)

    shutil.rmtree(tmp, ignore_errors=True)

    if not results:
        print("no benchmarks ran")
        return 1

    lines = []
    lines.append("## Benchmark: head vs base")
    lines.append("")
    lines.append("%d benchmarks, best of %d runs each (CPU time), %.0fs in total. Negative = head is faster." % (
        len(results), args.rounds, time.time() - started))
    lines.append("")
    lines.append("| group | benchmarks | head vs base | control vs base (noise) | faster (>3%) | slower (>3%) |")
    lines.append("|---|---|---|---|---|---|")

    def row(label, rs):
        ratios = [r[2]["head"] / r[2]["base"] for r in rs]
        noise = [r[2]["control"] / r[2]["base"] for r in rs]
        lines.append("| %s | %d | **%s** | %s | %d | %d |" % (
            label, len(rs), pct(geomean(ratios)), pct(geomean(noise)),
            sum(1 for x in ratios if x < 0.97), sum(1 for x in ratios if x > 1.03)))
        return geomean(ratios)

    for group in groups:
        rs = [r for r in results if r[0] == group]
        if rs:
            row(group, rs)
    overall = row("**all**", results)

    total = {k: sum(r[2][k] for r in results) for k in order}
    lines.append("")
    lines.append("Total CPU time: base %.2fs, head %.2fs (%s), control %.2fs (%s)." % (
        total["base"], total["head"], pct(total["head"] / total["base"]),
        total["control"], pct(total["control"] / total["base"])))

    mem = geomean([r[3]["head"] / r[3]["base"] for r in results if r[3]["base"] > 0])
    lines.append("")
    lines.append("Peak memory (geometric mean): %s." % pct(mem))

    byRatio = sorted(results, key=lambda r: r[2]["head"] / r[2]["base"])

    def table(title, rs):
        lines.append("")
        lines.append("<details><summary>%s</summary>" % title)
        lines.append("")
        lines.append("| benchmark | base | head | head vs base | control vs base |")
        lines.append("|---|---|---|---|---|")
        for r in rs:
            lines.append("| %s/%s | %.3fs | %.3fs | %s | %s |" % (
                r[0], r[1], r[2]["base"], r[2]["head"],
                pct(r[2]["head"] / r[2]["base"]), pct(r[2]["control"] / r[2]["base"])))
        lines.append("")
        lines.append("</details>")

    table("10 biggest wins", byRatio[:10])
    table("10 biggest losses", byRatio[::-1][:10])
    table("everything", results)

    if broken:
        lines.append("")
        lines.append("Failed, or with different output between base and head: " + ", ".join(broken))

    verdict = "OK" if overall <= args.max_ratio and not broken else "FAILED"
    lines.append("")
    lines.append("Result: **%s** (limit: head no more than %s slower overall)" % (verdict, pct(args.max_ratio)))

    report = "\n".join(lines) + "\n"
    print()
    print(report)
    if os.environ.get("GITHUB_STEP_SUMMARY"):
        with open(os.environ["GITHUB_STEP_SUMMARY"], "a") as f:
            f.write(report)

    return 0 if verdict == "OK" else 1

if __name__ == "__main__":
    sys.exit(main())
