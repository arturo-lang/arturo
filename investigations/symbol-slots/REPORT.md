# Symbol table performance: findings and slots prototype

Hand-over notes. Written 2026-11-13, on branch `investigate-symbol-slots`.

## Summary

Variable access is the single biggest cost in the VM hot loop. Three changes, in
increasing size:

| change | status | effect |
|---|---|---|
| Pre-size `Syms` | PR arturo-lang/arturo#2290, CI green | -4.2% Linux, -5.1% macOS (186 benchmarks, CI) |
| Don't copy the name on every write | commit `22aedb4f5`, this branch | -4.3% on the 13 programs (local) |
| Slot-based symbol table | commit `f18e52c20`, this branch, prototype | -17.8% on all 186 benchmarks (local, includes the previous row) |

Local numbers: Intel Mac, non-LTO build, best of 5 runs, compared against a
build of master + the pre-size change.

## How we got here

Profiling (`sample` on macOS) a recursive `fib` showed `getOrDefault` and `[]=`
on `Syms` right below `ExecLoop`, with the samples sitting in the probe loop.

1. **Clustering.** `Syms` is a Nim `Table[string, Value]` with linear probing.
   The ~533 builtins fill it to about 52%, and user symbols are added afterwards,
   so they land at the end of whatever cluster they hash into. Simulated with the
   real names: `n` needed 17 probes per lookup, `add3` 14, `x` 12, `a` 1.
   Renaming fib's parameter from `n` to `a` made it 23% faster. Fixed by
   pre-sizing the table (PR 2290).

2. **Name copied on every write.** `Table.[]=` takes its key as `sink`, so
   `Syms[s] = v` copies (allocates and frees) the name string each time.
   `setIterSym` in `library/Iterators.nim` already worked around this with
   `withValue`; `SetSym` and the scope-restore paths did not. Commit `22aedb4f5`
   adds `putSym` and uses it there. No behaviour change, two files.

3. **Everything else about the lookup.** After 1 and 2, a load still hashes the
   name (`hashFarm` was about 10% of fib's profile), probes, and compares
   strings. Inside a function, a store did up to four hash lookups (`hasKey` on
   the scope frame, `getOrDefault` on `Syms`, frame `[]=`, `Syms[]=`).

## Ideas considered

- **Slots (done as prototype).** See below.
- **Fixed storage for one-letter variables, with dedicated opcodes.** Rejected:
  slots give the same speed to every name without special cases, and only about
  31 opcodes are free, not enough for load/store/call times 26.
- **Tuning the hash function.** Not worth it on its own. Slots remove hashing
  from the hot path; what is still hashed (dynamic names, see "left on the slow
  path") is better fixed by caching ids.
- **Own hash table with cached hashes.** Same integration surface as slots (a
  custom type with a Table-like API, a cached integer on Word values, by-id fast
  paths in exec) but strictly slower, so not pursued.
- **Inline caching of table slots.** Not workable with Nim's `Table`: entries
  move on growth and on deletion, and locals are deleted on every function
  return.

## The slots prototype (`f18e52c20`)

- `src/vm/symslots.nim` (new): a global interner (`SymIds`: name to id,
  `SymNames`: id to name; id 0 means "none") and `SymSlots`, an array of values
  indexed by id, nil meaning "not defined". It keeps a Table-like string API
  (`[]`, `[]=`, `getOrDefault`, `hasKey`, `del`, `pairs`, `keys`), so the
  roughly 50 other `Syms` call sites compile unchanged, plus by-id access
  (`getById`, `setById`, `delById`, `addrById`).
- `src/vm/values/types.nim`: `sid: int32` added next to `s` on
  String/Word/Literal/Label/Attribute/AttributeLabel values (no size increase).
  `symIdOf(v)` fills it lazily. Also the `SymSlots`, `ScopeEntry`, `ScopeFrame`
  types.
- `src/vm/exec.nim`: `loadByIndex`, `storeByIndex`, `callByIndex` go by id.
- `src/vm/globals.nim`: `FetchSymById`, `SetSymById`; `ensureInPlace` and
  `ensureInPlaceAny` use `addrById`. Scope frames are now a list of
  `(id, previous value, previous stamp)` instead of a table per call.
  "Already recorded in this frame?" is answered by `ScopeStamps[id] ==
  frame.serial`. Frames are restored last entry first, because a symbol can be
  recorded twice (after a nested call, or when fibers interleave).
- `context.nim`, `helpers/parallelism.nim`, `vm.nim`, `library/Iterators.nim`:
  type changes only. Each fiber context still owns its own table; ids are
  global.

### Results (186 benchmarks, vs pre-sized build)

| group | slots vs base | noise |
|---|---|---|
| ops (75) | -17.7% | +0.4% |
| programs (13) | -18.7% | -0.1% |
| var-names (49) | -18.3% | +0.0% |
| param-names (49) | -17.4% | +0.2% |
| all | -17.8% | +0.2% |

Biggest: `fn_locals` -50%, `while_loop` -36%, `collatz` -28%, `nested_loops`
-24%, `fn_args` -23%. Peak memory +0.4%. Output identical on all 186.

## Open questions before slots can ship

1. **`symbols` ordering.** `pairs` now yields in definition order, not hash
   order. Visible through `symbols` and anything else iterating `Syms`
   (`Reflection.nim`, `printable.nim`, `execScopedModule`). The pre-size change
   already altered that order and the test suite passed, so tests do not seem to
   depend on it, but it is a visible difference.
2. **The interner never shrinks.** A program creating unbounded dynamic names
   (`let ~"v|i|"` in a loop) grows `SymNames`, every context's `vals`, and
   `ScopeStamps` forever. Before: the entry was freed when the symbol was.
   Options: accept it, or recycle ids with a free list (needs care with cached
   `sid`s).
3. **Cached `sid` assumes the value's `s` never changes afterwards.** Constants
   are read-only and get copied before modification, but this has not been
   checked for every in-place builtin that accepts a Word or Literal. If one
   mutates `s` on an object whose `sid` is already set, lookups go to the wrong
   symbol. Either clear `sid` wherever `s` is assigned, or prove it cannot
   happen.
4. **Bytecode files.** Constants loaded from `.bcode` get their `sid` lazily
   like any other; not tested.
5. **Fibers.** Stamps are global while frames are per fiber. Reasoned to be
   correct (serials are unique, restore is last-first; worst case is a duplicate
   entry), not tested under real interleaving.
6. **Tests.** Only verified with the 186 benchmark scripts and one scoping
   script. The unit tests have not been run on this branch (they run on CI).

## Left on the slow path (more to gain)

Each of these still does one interner lookup (a hash) per use:

- Function and method parameters: `fun.params` is `seq[string]`. Cache the ids
  on the function (a parallel `seq[int32]`).
- `prepareLeakless` / `finalizeLeakless` and the `...One` variants in
  `exec.nim`: three lookups per protected name per call.
- Iteration variables: `setIterSym` in `library/Iterators.nim` (resolve the id
  once per loop).
- `fun.imports`, `fun.exports` handling in `execFunction`.

Not symbol-related, next in the profile: one allocation per integer result
(`mi_malloc`/`mi_free`), and builds without `--release` have no LTO, which costs
another 10 to 20% (Value hooks such as `eqsink`/`eqdestroy` stay cross-file
calls).

## How to measure

`tools/bench/` (on this branch only):

    python3 tools/bench/compare.py <base binary> <head binary> [--rounds N] [--filter STR]

It runs `tools/pgo/train/*.art`, the programs in `tools/bench/*.art`, and two
generated groups (the same loop for 49 different variable and parameter names).
Runs are interleaved, best CPU time is kept, the base binary is run twice per
round as a noise control, and outputs are compared. It exits non-zero if head
is more than 2% slower overall or any output differs.

Build a named binary without touching `bin/arturo` (note the space, not a
colon):

    ./build.nims --as arturo-something

A CI version existed temporarily on PR 2290 (commit `f613b753d`,
`.github/workflows/benchmark.yml`): it builds base and head with `--release` on
Linux amd64 and macOS arm64 and runs the same script.

## Branch layout

`investigate-symbol-slots` is stacked on `presize-symbol-table` (PR 2290):

- `22aedb4f5` copy-free writes. Independent of everything else; can be
  cherry-picked onto master as its own PR.
- `f18e52c20` slots prototype. Replaces `putSym`'s body, so it sits on top of
  the previous commit.
- Later commits: these notes, the benchmark tooling, and a temporary change to
  `ci.yml` so that CI runs on this branch without a PR. None of those belong in
  a real PR.

## Unrelated, noticed on the way

`'x ++ 5` with `x` holding an integer ends in "Invalid memory access" instead of
a type error. Same on master.
