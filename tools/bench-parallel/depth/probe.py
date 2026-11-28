#!/usr/bin/env python3
# TEMPORARY (fiber-stacks): how deep a recursion can go - on the main thread
# & in a fiber - and how it fails beyond that: a regular error (the stack
# check), or a crash (the guard page, or anything else)

import os, subprocess, sys

HERE = os.path.dirname(os.path.abspath(__file__))

def probe(binary, n, where):
    p = subprocess.run([binary, os.path.join(HERE, "probe.art"), str(n), where],
                       capture_output=True, text=True, timeout=120)
    out = (p.stdout + p.stderr).strip()
    if p.returncode == 0 and out.endswith("ok"): return "ok"
    if p.returncode == 0 and out.endswith("error"): return "error"
    return "crash (%s)" % p.returncode

def deepest(binary, where, hi):
    """Binary search for the deepest recursion that's still fine"""
    lo = 1
    while lo < hi:
        mid = (lo + hi + 1) // 2
        if probe(binary, mid, where) == "ok": lo = mid
        else: hi = mid - 1
    return lo

for spec in sys.argv[1:]:
    name, binary = spec.split("=", 1)
    binary = os.path.abspath(binary)
    for where, hi in (("fiber", 50000), ("main", 400000)):
        d = deepest(binary, where, hi)
        beyond = [(k, probe(binary, k, where)) for k in (d + 1, d * 2, d * 10)]
        print("%-8s %-6s deepest: %7d   beyond: %s" % (name, where, d,
              ", ".join("%d -> %s" % kv for kv in beyond)), flush=True)
