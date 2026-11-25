# EXPERIMENTAL: base vs pbi Arturo on `+` (ns per op, loop overhead subtracted)
# usage: run.py <base-binary> <pbi-binary> [reps]   (RUNNER="taskset -c 1" to pin)
import subprocess, sys, time, statistics, os
os.chdir(os.path.dirname(os.path.abspath(__file__)))
prefix = os.environ.get("RUNNER", "").split()
bins = sys.argv[1:3]; reps = int(sys.argv[3]) if len(sys.argv) > 3 else 5
cases = os.environ.get("CASES","").split(",") if os.environ.get("CASES") else ["empty","int","int-inplace","overflow","big1+small","big2+big2","big+big2small","big32+big32"]
res = {b:{c:[] for c in cases} for b in bins}
for r in range(reps):
    for c in cases:
        for b in (bins if r % 2 == 0 else bins[::-1]):      # alternate order
            t = time.perf_counter(); subprocess.run(prefix + [b, c + ".art"], check=True); res[b][c].append(time.perf_counter() - t)
N = 3_000_000
med = {b:{c:statistics.median(res[b][c]) for c in cases} for b in bins}
print(f"{'case':16} {'base ns/op':>11} {'pbi ns/op':>10} {'speedup':>8}")
for c in cases:
    if c == "empty":
        print(f"{'(loop overhead)':16} {med[bins[0]][c]/N*1e9:11.1f} {med[bins[1]][c]/N*1e9:10.1f}"); continue
    a = (med[bins[0]][c] - med[bins[0]]["empty"]) / N * 1e9
    p = (med[bins[1]][c] - med[bins[1]]["empty"]) / N * 1e9
    print(f"{c:16} {a:11.1f} {p:10.1f} {a/p:7.2f}x")
