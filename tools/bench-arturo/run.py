#!/usr/bin/env python3
"""
Times every tools/bench-arturo/<category>/*.art script with several Arturo binaries.

    run.py --bin NAME=PATH [--bin NAME=PATH ...] [--runs N] [--prefix "taskset -c 1"]
           [--json out.json] [--md out.md] [--platform NAME]

Every script is first run once with each binary (also a warm-up): only binaries
that print the same output as the first one are timed. Then N rounds, each
running every binary once, the order rotating from round to round. Reported:
the median (and minimum) wall time, and speedups between the binaries
(old time / new time: above 1 = faster), with their geometric mean per category.
"""

import argparse
import json
import math
import os
import platform
import shlex
import statistics
import subprocess
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
CATEGORIES = ["micro", "bignum", "real"]


def run(cmd, timeout):
    t0 = time.perf_counter()
    p = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, timeout=timeout)
    return time.perf_counter() - t0, p.returncode, p.stdout.decode("utf-8", "replace")


def normalize(out):
    return "\n".join(line.rstrip() for line in out.strip().splitlines())


def cpu_name():
    try:
        if sys.platform.startswith("linux"):
            for line in open("/proc/cpuinfo"):
                if line.lower().startswith(("model name", "cpu model")):
                    return line.split(":", 1)[1].strip()
            out = subprocess.run(["lscpu"], stdout=subprocess.PIPE).stdout.decode()
            for line in out.splitlines():
                if line.startswith("Model name"):
                    return line.split(":", 1)[1].strip()
        if sys.platform == "darwin":
            return subprocess.run(["sysctl", "-n", "machdep.cpu.brand_string"],
                                  stdout=subprocess.PIPE).stdout.decode().strip()
    except Exception:
        pass
    return platform.processor() or platform.machine()


def geomean(xs):
    xs = [x for x in xs if x and x > 0]
    return math.exp(sum(math.log(x) for x in xs) / len(xs)) if xs else None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--bin", action="append", required=True, help="NAME=PATH")
    ap.add_argument("--runs", type=int, default=10)
    ap.add_argument("--prefix", default="")
    ap.add_argument("--timeout", type=int, default=300)
    ap.add_argument("--json")
    ap.add_argument("--md")
    ap.add_argument("--platform", default=f"{sys.platform}-{platform.machine()}")
    args = ap.parse_args()

    bins = [b.split("=", 1) for b in args.bin]
    names = [n for n, _ in bins]
    prefix = shlex.split(args.prefix)

    versions = {}
    for name, path in bins:
        _, _, out = run(prefix + [path, "-v"], 60)
        versions[name] = out.strip().splitlines()[0] if out.strip() else "?"
        print(f"{name}: {versions[name]}", flush=True)

    results = []
    for cat in CATEGORIES:
        d = os.path.join(HERE, cat)
        for f in sorted(x for x in os.listdir(d) if x.endswith(".art")):
            script = os.path.join(d, f)
            name = f"{cat}/{f[:-4]}"
            entry = {"script": name, "category": cat, "bins": {}}
            # check run (and warm-up): same output as the first binary that runs fine
            ref = None
            for bname, path in bins:
                try:
                    _, rc, out = run(prefix + [path, script], args.timeout)
                except subprocess.TimeoutExpired:
                    entry["bins"][bname] = {"status": "timeout"}
                    continue
                out = normalize(out)
                if rc != 0:
                    entry["bins"][bname] = {"status": "error", "output": out[-400:]}
                elif ref is None:
                    ref = out
                    entry["bins"][bname] = {"status": "ok", "times": []}
                elif out != ref:
                    entry["bins"][bname] = {"status": "different output", "output": out[-400:]}
                else:
                    entry["bins"][bname] = {"status": "ok", "times": []}
            ok = [(n, p) for n, p in bins if entry["bins"][n]["status"] == "ok"]
            for r in range(args.runs):
                k = r % len(ok) if ok else 0
                for bname, path in ok[k:] + ok[:k]:
                    t, _, _ = run(prefix + [path, script], args.timeout)
                    entry["bins"][bname]["times"].append(t)
            for bname, _ in ok:
                ts = entry["bins"][bname]["times"]
                entry["bins"][bname]["median"] = statistics.median(ts)
                entry["bins"][bname]["min"] = min(ts)
            line = "  ".join(f"{n} {entry['bins'][n].get('median', float('nan')):7.3f}s"
                             if entry["bins"][n]["status"] == "ok" else f"{n} {entry['bins'][n]['status']}"
                             for n in names)
            print(f"{name:28} {line}", flush=True)
            results.append(entry)

    report = {"platform": args.platform, "cpu": cpu_name(), "runs": args.runs,
              "bins": names, "versions": versions, "results": results}
    if args.json:
        with open(args.json, "w") as fp:
            json.dump(report, fp, indent=1)
    md = markdown(report)
    if args.md:
        with open(args.md, "w") as fp:
            fp.write(md)
    print(md)


def speedup(entry, old, new):
    a, b = entry["bins"].get(old, {}), entry["bins"].get(new, {})
    if a.get("status") == "ok" and b.get("status") == "ok":
        return a["median"] / b["median"]
    return None


def fmt_ratio(x):
    if x is None:
        return "-"
    mark = " 🟢" if x >= 1.05 else " 🔴" if x <= 0.95 else ""
    return f"{x:.2f}×{mark}"


def pairs(names):
    # (old, new) comparisons: each against the previous one, and the last against the first
    ps = [(names[i - 1], names[i]) for i in range(1, len(names))]
    if len(names) > 2:
        ps.append((names[0], names[-1]))
    return ps


def markdown(report):
    names = report["bins"]
    ps = pairs(names)
    out = [f"### {report['platform']} ({report['cpu']})", ""]
    out += [f"- **{n}**: `{report['versions'][n]}`" for n in names]
    out += ["", f"Median of {report['runs']} runs (s); speedup = old / new time (above 1: faster).", ""]
    head = "| script | " + " | ".join(names) + " | " + " | ".join(f"{b} vs {a}" for a, b in ps) + " |"
    out += [head, "|---|" + "---:|" * (len(names) + len(ps))]
    per_cat = {}
    for e in report["results"]:
        cells = []
        for n in names:
            b = e["bins"][n]
            cells.append(f"{b['median']:.3f}" if b["status"] == "ok" else b["status"])
        sps = [speedup(e, a, b) for a, b in ps]
        for i, x in enumerate(sps):
            per_cat.setdefault((e["category"], i), []).append(x)
            per_cat.setdefault(("all", i), []).append(x)
        out.append(f"| {e['script']} | " + " | ".join(cells) + " | " + " | ".join(fmt_ratio(x) for x in sps) + " |")
    out += ["", "| geometric mean | " + " | ".join(f"{b} vs {a}" for a, b in ps) + " |",
            "|---|" + "---:|" * len(ps)]
    for cat in CATEGORIES + ["all"]:
        out.append(f"| **{cat}** | " + " | ".join(fmt_ratio(geomean(per_cat.get((cat, i), []))) for i in range(len(ps))) + " |")
    out.append("")
    return "\n".join(out)


if __name__ == "__main__":
    main()
