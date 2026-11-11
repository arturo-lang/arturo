# Temporary: runs the iterators benchmark with 2 binaries (interleaved,
# a few rounds each), and prints the best time per test, side by side
import subprocess, sys

base, new, script = sys.argv[1], sys.argv[2], sys.argv[3]
rounds = 4

times = {"base": {}, "new": {}}
order = []
for r in range(rounds):
    for label, binary in (("base", base), ("new", new)):
        out = subprocess.run([binary, script], capture_output=True, text=True)
        if out.returncode != 0:
            print(out.stdout); print(out.stderr)
            sys.exit(f"{label} failed")
        for line in out.stdout.splitlines():
            if "\t" not in line: continue
            name, ms = line.split("\t")
            if name not in order: order.append(name)
            times[label].setdefault(name, []).append(float(ms))

print(f"{'test':<28}{'base':>10}{'new':>10}{'new/base':>10}")
for name in order:
    b, n = min(times["base"][name]), min(times["new"][name])
    ratio = f"{n/b:.2f}" if b > 0 else "-"
    print(f"{name:<28}{b:>10.1f}{n:>10.1f}{ratio:>10}")
