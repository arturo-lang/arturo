# Temporary: runs the iterators benchmark with 2 binaries (interleaved,
# a few rounds each), and prints the best time per test, side by side,
# with the geometric mean of the speedups per section
import math, subprocess, sys

base, new, script = sys.argv[1], sys.argv[2], sys.argv[3]
extra = sys.argv[4:5]
rounds = 5

times = {"base": {}, "new": {}}
sections = []                       # [(title, [names])]
for r in range(rounds):
    for label, binary in (("base", base), ("new", new)):
        out = subprocess.run([binary, script] + extra, capture_output=True, text=True)
        if out.returncode != 0:
            print(out.stdout); print(out.stderr)
            sys.exit(f"{label} failed")
        current = None
        for line in out.stdout.splitlines():
            if line.startswith("## "):
                title = line[3:]
                current = next((s for s in sections if s[0] == title), None)
                if current is None:
                    current = (title, [])
                    sections.append(current)
                continue
            if "\t" not in line: continue
            name, ms = line.split("\t")
            if name not in current[1]: current[1].append(name)
            times[label].setdefault((current[0], name), []).append(float(ms))

def geomean(xs):
    return math.exp(sum(math.log(x) for x in xs) / len(xs)) if xs else None

floor = 0.05                        # ms: below this, we cannot really measure
summary = []
for title, names in sections:
    print(f"\n### {title}\n")
    print(f"{'test':<34}{'base ms':>10}{'new ms':>10}{'new/base':>10}{'speedup':>10}")
    speedups = []
    for name in names:
        b, n = min(times["base"][(title, name)]), min(times["new"][(title, name)])
        if n < floor:
            ratio, speedup = "~0", f">{b/floor:.0f}x" if b >= floor else "-"
        else:
            ratio, speedup = f"{n/b:.2f}", f"{b/n:.2f}x"
            speedups.append(b / n)
        print(f"{name:<34}{b:>10.2f}{n:>10.2f}{ratio:>10}{speedup:>10}")
    summary.append((title, geomean(speedups), len(speedups), len(names)))

print("\n### summary (geometric mean of the speedups)\n")
for title, g, measured, total in summary:
    g = f"{g:.2f}x" if g else "-"
    note = "" if measured == total else f"  ({total - measured} too fast to measure, left out)"
    print(f"{title:<50}{g:>8}{note}")
