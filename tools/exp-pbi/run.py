# EXPERIMENTAL: Arturo builds compared on `+` (ns per op, loop overhead subtracted)
# usage: run.py <base-binary> <other-binary>... [--reps N]   (RUNNER="taskset -c 1" to pin)
import subprocess, sys, time, statistics, os
os.chdir(os.path.dirname(os.path.abspath(__file__)))
prefix = os.environ.get("RUNNER", "").split()
args = sys.argv[1:]
reps = 5
if "--reps" in args:
    k = args.index("--reps"); reps = int(args[k + 1]); del args[k:k + 2]
bins = args
cases = os.environ.get("CASES","").split(",") if os.environ.get("CASES") else \
    ["empty","small","int","int-inplace","overflow","big1+small","big2+big2","big+big2small","big32+big32"]
res = {b:{c:[] for c in cases} for b in bins}
for r in range(reps):
    for c in cases:
        for b in (bins if r % 2 == 0 else bins[::-1]):      # alternate the order
            t = time.perf_counter(); subprocess.run(prefix + [b, c + ".art"], check=True); res[b][c].append(time.perf_counter() - t)
N = 3_000_000
med = {b:{c:statistics.median(res[b][c]) for c in cases} for b in bins}
names = [os.path.basename(b) for b in bins]
print("| case | " + " | ".join(f"{n} ns/op" for n in names) + " | " + " | ".join(f"{n} vs base" for n in names[1:]) + " |")
print("|---" * (1 + 2 * len(bins) - 1) + "|")
for c in cases:
    if c == "empty":
        print("| (loop overhead) | " + " | ".join(f"{med[b][c]/N*1e9:.1f}" for b in bins) + " |" + " |" * (len(bins) - 1)); continue
    v = [(med[b][c] - med[b]["empty"]) / N * 1e9 for b in bins]
    print(f"| {c} | " + " | ".join(f"{x:.1f}" for x in v) + " | " + " | ".join(f"{v[0]/x:.2f}x" for x in v[1:]) + " |")
