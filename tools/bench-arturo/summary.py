#!/usr/bin/env python3
"""
Combines the JSON reports of run.py (one per platform) into one Markdown summary.

    summary.py report1.json [report2.json ...]
"""

import json
import sys

from run import CATEGORIES, fmt_ratio, geomean, pairs, speedup


def main():
    reports = [json.load(open(f)) for f in sys.argv[1:]]
    reports.sort(key=lambda r: r["platform"])
    names = reports[0]["bins"]
    ps = pairs(names)
    out = ["## Arturo benchmarks: " + " / ".join(names), ""]
    out += ["Speedups (old time / new time: above 1 = faster), geometric means per category;"
            " every script's output is checked to be the same with every binary.", ""]

    for i, (a, b) in enumerate(ps):
        out += [f"### {b} vs {a}", "", "| platform | " + " | ".join(CATEGORIES + ["all"]) + " |",
                "|---|" + "---:|" * (len(CATEGORIES) + 1)]
        for r in reports:
            cells = []
            for cat in CATEGORIES + [None]:
                xs = [speedup(e, a, b) for e in r["results"] if cat is None or e["category"] == cat]
                cells.append(fmt_ratio(geomean(xs)))
            out.append(f"| {r['platform']} | " + " | ".join(cells) + " |")
        out.append("")

    out += ["### Every script", "", "| script | " +
            " | ".join(f"{r['platform']}<br>{b} vs {a}" for r in reports for a, b in ps) + " |",
            "|---|" + "---:|" * (len(reports) * len(ps))]
    scripts = [e["script"] for e in reports[0]["results"]]
    for s in scripts:
        cells = []
        for r in reports:
            e = next((x for x in r["results"] if x["script"] == s), None)
            for a, b in ps:
                cells.append(fmt_ratio(speedup(e, a, b)) if e else "-")
        out.append(f"| {s} | " + " | ".join(cells) + " |")
    out.append("")

    problems = [(r["platform"], e["script"], n, e["bins"][n]["status"])
                for r in reports for e in r["results"] for n in names if e["bins"][n]["status"] != "ok"]
    if problems:
        out += ["### Not timed", "", "| platform | script | binary | why |", "|---|---|---|---|"]
        out += [f"| {p} | {s} | {n} | {st} |" for p, s, n, st in problems]
        out.append("")

    out += ["### Versions", ""]
    for r in reports:
        out.append(f"- **{r['platform']}** ({r['cpu']}): " + ", ".join(f"{n} `{r['versions'][n]}`" for n in names))
    print("\n".join(out))


if __name__ == "__main__":
    main()
