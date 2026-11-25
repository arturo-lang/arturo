# EXPERIMENTAL: Arturo builds compared - per-op cost of loop cases (ns, loop overhead subtracted)
# and whole-program times (ms). usage: run.py <base> <other>... [--reps N]  (RUNNER="taskset -c 1" to pin)
import subprocess, sys, time, statistics, os
os.chdir(os.path.dirname(os.path.abspath(__file__)))
prefix = os.environ.get("RUNNER", "").split()
args = sys.argv[1:]; reps = 5
if "--reps" in args:
    k = args.index("--reps"); reps = int(args[k + 1]); del args[k:k + 2]
bins = args
loops = ["empty","small","int","int-acc","float","float-acc","mixed","big"]
progs = ["prog-fib","prog-numeric"]
res = {b:{c:[] for c in loops + progs} for b in bins}
for r in range(reps):
    for c in loops + progs:
        for b in (bins if r % 2 == 0 else bins[::-1]):
            t = time.perf_counter(); subprocess.run(prefix + [b, c + ".art"], check=True, stdout=subprocess.DEVNULL); res[b][c].append(time.perf_counter() - t)
N = 3_000_000
med = {b:{c:statistics.median(res[b][c]) for c in loops + progs} for b in bins}
names = [os.path.basename(b) for b in bins]
print("| case | " + " | ".join(names) + " | " + " | ".join(f"{n} vs {names[0]}" for n in names[1:]) + " |")
print("|---" * (2 * len(bins)) + "|")
for c in loops + progs:
    if c in progs: v = [med[b][c] * 1e3 for b in bins]; unit = "ms"
    elif c == "empty": v = [med[b][c] / N * 1e9 for b in bins]; unit = "ns (loop)"
    else: v = [(med[b][c] - med[b]["empty"]) / N * 1e9 for b in bins]; unit = "ns/op"
    print(f"| {c} ({unit}) | " + " | ".join(f"{x:.1f}" for x in v) + " | " + " | ".join(f"{v[0]/x:.2f}x" for x in v[1:]) + " |")
