#!/usr/bin/env python3
# TEMPORARY (parallel-fibers): times .parallel & friends with several
# Arturo binaries (median wall time + peak memory), making sure they all
# print the same thing - and, with --check, runs the correctness checks

import argparse, json, os, statistics, subprocess, sys, threading, time

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
WINDOWS = os.name == "nt"

# master never frees a fiber (~1MB each): without a cap, it can take a
# whole runner down with it (on Linux - macOS kills it by itself)
REFERENCE_MEMORY = 6 * 1024 ** 3

# (name, script, argument, only for these binaries - None: all of them)
# sizes are kept low enough for master, which needs ~1MB per fiber
CASES = [
    ("map 2.5k",            "map",              2500,   None),
    ("map 10k",             "map",              10000,  None),
    ("map 50k",             "map",              50000,  ["branch"]),
    ("map:8 5k",            "map-capped",       5000,   None),
    ("map, suspended 2k",   "map-suspended",    2000,   None),
    ("select 5k",           "select",           5000,   None),
    ("some? 2k",            "some",             2000,   None),
    ("do.async 3k",         "async",            3000,   None),
    ("channel 5k",          "channel",          5000,   None),
    ("rounds 4x1k",         "rounds",           4,      None),
    ("rounds 100x1k",       "rounds",           100,    ["branch"]),
    ("no fibers",           "no-fibers",        30,     None),
]

#---------------------------------------
# Running
#---------------------------------------

def peakOf(p):
    """Wait for given process; its peak memory, in bytes"""
    if WINDOWS:
        import ctypes
        from ctypes import wintypes
        class Counters(ctypes.Structure):
            _fields_ = [("cb", wintypes.DWORD), ("PageFaultCount", wintypes.DWORD),
                        ("PeakWorkingSetSize", ctypes.c_size_t), ("WorkingSetSize", ctypes.c_size_t),
                        ("QuotaPeakPagedPoolUsage", ctypes.c_size_t), ("QuotaPagedPoolUsage", ctypes.c_size_t),
                        ("QuotaPeakNonPagedPoolUsage", ctypes.c_size_t), ("QuotaNonPagedPoolUsage", ctypes.c_size_t),
                        ("PagefileUsage", ctypes.c_size_t), ("PeakPagefileUsage", ctypes.c_size_t)]
        p.wait()
        c = Counters(); c.cb = ctypes.sizeof(c)
        ctypes.windll.psapi.GetProcessMemoryInfo(wintypes.HANDLE(int(p._handle)), ctypes.byref(c), c.cb)
        return p.returncode, c.PeakWorkingSetSize
    _, status, usage = os.wait4(p.pid, 0)
    p.returncode = os.waitstatus_to_exitcode(status)
    # (Linux says KB, macOS bytes)
    return p.returncode, usage.ru_maxrss * (1 if sys.platform == "darwin" else 1024)

def capped(limit):
    """Something to run in the child, capping its memory (where we can)"""
    if WINDOWS or not limit or sys.platform == "darwin": return None
    def cap():
        import resource
        resource.setrlimit(resource.RLIMIT_AS, (limit, limit))
    return cap

def run(binary, script, args, prefix, timeout, cwd=None, limit=None):
    """Run script once: (exit code, output, seconds, peak bytes)"""
    cmd = (prefix.split() if prefix else []) + [binary, script] + [str(a) for a in args]
    out = os.path.join(HERE, ".out-%d" % os.getpid())
    with open(out, "wb") as f:
        start = time.perf_counter()
        p = subprocess.Popen(cmd, stdout=f, stderr=subprocess.STDOUT, cwd=cwd, preexec_fn=capped(limit))
        killer = threading.Timer(timeout, p.kill)
        killer.start()
        try:
            code, peak = peakOf(p)
        finally:
            killer.cancel()
        secs = time.perf_counter() - start
    with open(out, "rb") as f:
        text = f.read().decode("utf-8", "replace").replace("\r\n", "\n").strip()
    os.remove(out)
    if secs >= timeout: code = "timeout"
    return code, text, secs, peak

#---------------------------------------
# Benchmarks
#---------------------------------------

def bench(bins, runs, prefix, timeout):
    results = []
    failed = False
    for name, script, arg, only in CASES:
        path = os.path.join(HERE, "cases", script + ".art")
        row = {"case": name, "bins": {}}
        outputs = {}
        for bname, bpath in bins:
            if only and bname not in only: continue
            tested = bname == bins[-1][0]
            times, peaks, status = [], [], "ok"
            for _ in range(runs):
                code, text, secs, peak = run(bpath, path, [arg], prefix, timeout,
                                             limit=None if tested else REFERENCE_MEMORY)
                if code != 0:
                    status = "failed (%s)" % code
                    print("  %s / %s: %s\n%s" % (name, bname, status, text[-2000:]), flush=True)
                    if tested: failed = True
                    break
                outputs[bname] = text
                times.append(secs); peaks.append(peak)
            row["bins"][bname] = {
                "status": status,
                "time": statistics.median(times) if times else None,
                "peak": max(peaks) if peaks else None,
                "output": outputs.get(bname),
            }
            print("  %-20s %-8s %s" % (name, bname, fmt(row["bins"][bname])), flush=True)
        if len(set(outputs.values())) > 1:
            print("  %s: DIFFERENT OUTPUT %r" % (name, outputs), flush=True)
            row["mismatch"] = True
            failed = True
        results.append(row)
    return results, failed

def fmt(b):
    if b["status"] != "ok": return b["status"]
    return "%8.3fs %9.1fMB" % (b["time"], b["peak"] / 1048576)

def markdown(results, bins, platform):
    names = [b for b, _ in bins]
    lines = ["### %s" % platform, "",
             "| case | " + " | ".join("%s time | %s memory" % (n, n) for n in names) + " | speedup |",
             "|---|" + "---:|---:|" * len(names) + "---:|"]
    for row in results:
        cells = []
        for n in names:
            b = row["bins"].get(n)
            if b is None:                   cells += ["-", "-"]
            elif b["status"] != "ok":       cells += [b["status"], "-"]
            else:                           cells += ["%.3fs" % b["time"], "%.1fMB" % (b["peak"] / 1048576)]
        sp = "-"
        a, z = row["bins"].get(names[0]), row["bins"].get(names[-1])
        if a and z and a["time"] and z["time"]:
            sp = "%.1fx" % (a["time"] / z["time"])
        flag = " ⚠️ different output" if row.get("mismatch") else ""
        lines.append("| %s%s | %s | %s |" % (row["case"], flag, " | ".join(cells), sp))
    return "\n".join(lines) + "\n"

#---------------------------------------
# Correctness
#---------------------------------------

def check(bins, repeat, timeout):
    """Every binary against what's expected - only the last one (the one
    being tested) can fail it: the others may not even finish (master
    never frees a fiber), which we just report"""
    failed = False
    tests = os.path.join(ROOT, "tests", "unittests")
    checks = [
        # (name, script, expected, where to run it)
        ("fibers.art", os.path.join(HERE, "check", "fibers.art"), os.path.join(HERE, "check", "fibers.res"), None),
        ("parallelism.art", "parallelism.art", os.path.join(tests, "parallelism.res"), tests),
    ]
    for name, script, res, cwd in checks:
        expected = open(res, encoding="utf-8").read().replace("\r\n", "\n").strip().splitlines()
        for bname, bpath in bins:
            tested = bname == bins[-1][0]
            for i in range(repeat if tested else 1):
                code, text, secs, peak = run(bpath, script, [], "", timeout, cwd=cwd,
                                             limit=None if tested else REFERENCE_MEMORY)
                ok = code == 0 and text.splitlines() == expected
                verdict = "passed" if ok else ("FAILED" if tested else "couldn't finish - not counted" if code != 0 else "DIFFERENT")
                print("  %s / %s #%d: %s (exit %s), %.2fs, %.1fMB" % (name, bname, i + 1, verdict, code, secs, peak / 1048576), flush=True)
                if not ok:
                    print(text[-3000:])
                    # (a reference that finishes has to agree too)
                    if tested or code == 0: failed = True
    return failed

#---------------------------------------
# Main
#---------------------------------------

if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--bin", action="append", required=True, help="name=path (the last one is the one being tested)")
    ap.add_argument("--runs", type=int, default=5)
    ap.add_argument("--repeat", type=int, default=3, help="--check: how many times each check runs")
    ap.add_argument("--prefix", default="")
    ap.add_argument("--timeout", type=float, default=300)
    ap.add_argument("--platform", default=sys.platform)
    ap.add_argument("--check", action="store_true")
    ap.add_argument("--json"); ap.add_argument("--md")
    a = ap.parse_args()
    bins = [(n, os.path.abspath(b)) for n, b in (b.split("=", 1) for b in a.bin)]

    if a.check:
        sys.exit(1 if check(bins, a.repeat, a.timeout) else 0)

    results, failed = bench(bins, a.runs, a.prefix, a.timeout)
    if a.json:
        json.dump({"platform": a.platform, "bins": [b for b, _ in bins], "results": results}, open(a.json, "w"), indent=1)
    md = markdown(results, bins, a.platform)
    if a.md: open(a.md, "w", encoding="utf-8").write(md)
    print(md)
    sys.exit(1 if failed else 0)
