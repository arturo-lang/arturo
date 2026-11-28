#!/usr/bin/env python3
# TEMPORARY (parallel-fibers): every platform's results, side by side

import json, sys

reports = [json.load(open(p)) for p in sorted(sys.argv[1:])]
if not reports:
    print("no results"); sys.exit(0)

def cell(b):
    if b is None: return "-"
    if b["status"] != "ok": return b["status"]
    return "%.3fs · %.0fMB" % (b["time"], b["peak"] / 1048576)

base, tested = reports[0]["bins"][0], reports[0]["bins"][-1]
print("## .parallel: %s vs %s\n" % (base, tested))
print("time (median) · peak memory\n")
cases = [r["case"] for r in reports[0]["results"]]
for case in cases:
    print("#### %s\n" % case)
    print("| platform | %s | %s | speedup | memory |" % (base, tested))
    print("|---|---:|---:|---:|---:|")
    for rep in reports:
        row = next((r for r in rep["results"] if r["case"] == case), None)
        if row is None: continue
        m, b = row["bins"].get(base), row["bins"].get(tested)
        sp = mem = "-"
        if m and b and m["time"] and b["time"]:
            sp = "%.1fx" % (m["time"] / b["time"])
            mem = "%.1fx less" % (m["peak"] / b["peak"])
        flag = " ⚠️" if row.get("mismatch") else ""
        print("| %s%s | %s | %s | %s | %s |" % (rep["platform"], flag, cell(m), cell(b), sp, mem))
    print()
