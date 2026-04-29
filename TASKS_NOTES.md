# `:task` & async — handoff notes

> Self-note for future Claude sessions on the **`add-new-Task-value`** branch.
> Read this end-to-end before doing anything; it captures decisions you'll
> otherwise re-derive (and probably re-regret).

## What's on this branch

A new `:task` value type, a `Tasks` stdlib module, a subprocess-backed
`do.async` builtin, and a draft `request.async` for HTTP. Plus all the
plumbing each new ValueKind requires.

User wants: **real "background" work**. Not deferred-sync, not cooperative
async-only. So `do.async [block]` truly runs in parallel with whatever the
main code is doing. Architecture choice: **subprocesses, not threads**
(see "why subprocesses" below).

### Final commit count: ~24, on top of `ed859e565` (master / "Bump revision to 36").

## Build & test

```sh
./build.nims --dev --as arturo-tasks
bin/arturo-tasks /tmp/marshal_test.art    # the marshalling regression test
bin/arturo-tasks /tmp/tasks_playground.art # the user-facing demo
```

(Don't write to `bin/arturo` — that's the user's main install. Always use
`--as <id>` for test builds.)

## What works today

| feature | example | status |
|---|---|---|
| `:task` value type | `t: do.async [40 + 2]` → `<task>(0xPTR)` | ✅ |
| genuine background execution | bg subprocess actually runs while main does other work | ✅ proven, ~max(bg,main) wall-clock |
| `wait t` | blocks until child exits, returns Value | ✅ |
| `do t` | sugar for `wait t` | ✅ |
| `done? t` | non-blocking poll | ✅ |
| `cancel t` | flips state + terminates the child process | ✅ |
| value marshalling | `:integer`, `:block`, `:dictionary`, `:string` round-trip via Arturo source | ✅ |
| void-safe (block ends with `print`) | result = `:null`, no crash/hang | ✅ |
| live stdout from child | `print` inside `do.async [...]` flows to user's terminal in real-time | ✅ |
| fan-out parallelism | 5 × `pause 1000` tasks finish in ~1s, not ~5s | ✅ |
| `request.async` | full parity with sync `request` (POST, headers, proxy, etc.) via subprocess | ✅ |
| `read.async` | local files: in-process via `asyncfile` + sync post-process closure (preserves `.lines`/`.json`/`.csv`/`.binary`/parsers); URLs & `.bytecode` stay on subprocess | ✅ |
| `write.async` | text/json/binary: in-process via `asyncfile` (`.append` preserved); `.directory`/`:bytecode`/null path stay on subprocess | ✅ |
| `download.async` | in-process via `AsyncHttpClient.downloadFile`; preserves `.as` | ✅ |
| `serve.async` | runs HTTP server in a child process; preserves `.port`/`.silent`/`.chrome` — `cancel` to stop | ✅ |
| printing matches Database convention | `print t` → `<task>(0x...)`, `inspect t` → `[pending] 0x... :task` | ✅ |

## Architecture — read before changing anything

### Why subprocesses, not threads

Arturo's VM holds its **entire state** in module-level `var`:
- [`src/vm/stack.nim:33`](src/vm/stack.nim) — `Stack`, `SP`, `Attrs`
- [`src/vm/globals.nim`](src/vm/globals.nim) — `Syms`
- [`src/vm/exec.nim`](src/vm/exec.nim) — call frames, etc.
- [`config.nims:135`](config.nims) — `--threads:off` (default)

Real OS threads would require thread-local-izing all of that. Sweeping
multi-file change, plus solving Value-across-thread GC. **Don't go down
that path without explicit user request.**

Subprocess approach (what Ruby's `parallel` gem does, what Python's
`multiprocessing` does — both for the same reason: GIL-equivalent global
state):

- Each task = one OS process running its own arturo binary.
- Real parallelism (multiple cores), no VM surgery, every platform.
- ~30ms startup overhead per task — fine for most use cases.
- Communication via temp file (Arturo source as the wire format).

### Why Arturo source as the wire format (not JSON)

User's call. We're in a homoiconic language — `express` (a.k.a. `codify`)
gives source-faithful serialization that preserves Label colons (`name:`),
Literal quotes (`'i`), Word vs Symbol vs String distinctions, etc.

Round-trip protocol:
- **Child**: `try [ res: do [null <user-block>] ]` then `write express res "<tempfile>"`
- **Parent**: `doParse(readFile(tempfile))`, then `execUnscoped(parsed)`,
  then `stack.pop()` to get the Value

All in [`src/library/Core.nim`](src/library/Core.nim) `runInChildProcess` proc.

### The `[null <src>]` trick

Arturo crashes/hangs on `x: do [block-that-doesnt-push-a-value]` (e.g.
when last expr is `print`). To make `do.async` void-safe, the wrapper
prepends `null` *inside* the block:

```
do [null <user-source>]
```

- If user's block pushes a value, that value supersedes the leading `null`
  on the stack — `do` returns the user's value. ✓
- If user's block doesn't push, only the leading `null` is on the stack —
  `do` returns null. ✓ no crash

### Where the `:task` type lives

It needed to hold a `Future[Value]`, which means the type definition must
see `Value`. So:

- **Type definition**: `VTask` in [`src/vm/values/types.nim`](src/vm/values/types.nim)
  (alongside `VStore`, for the same reason). Imports `std/asyncfutures`
  gated under `when not defined(WEB)`.
- **State enum**: `VTaskState` in [`src/vm/values/custom/vtask.nim`](src/vm/values/custom/vtask.nim) — slim enum-only file.
- **Constructors / `$` / `hash`**: [`src/vm/values/value.nim`](src/vm/values/value.nim) (`newTask`, `initTask`).

### `:task` printing convention

Matches `:database`:
- `print t` → `<task>(0xPTR)`
- `inspect t` → `[pending|done|failed|cancelled] 0xPTR :task`

Pointer is the address of the `VTask` ref — stable across state transitions,
useful for identity. See [`src/vm/values/printable.nim`](src/vm/values/printable.nim).

## Two execution mechanisms, one `:task` handle

The branch now has both tiers from the v2 plan in place for several builtins.
The `:task` value is mechanism-agnostic — `wait` / `done?` / `cancel` work on
both, distinguished only by whether `tsk.process` is set:

| mechanism | who uses it | helper |
|---|---|---|
| **subprocess** (fork+exec a child arturo) | `do.async`, `request.async`, `serve.async`, the URL/bytecode legs of `read.async`, the `.directory`/bytecode/null-path legs of `write.async` | `spawnAsTask(src) -> Value` |
| **in-process** (Nim `asyncdispatch` + `asyncfile` / `AsyncHttpClient`) | `download.async`, local-file `read.async`, plain-bytes `write.async` | `spawnAsyncDownload`, `spawnAsyncRead`, `spawnAsyncWrite` |

Helpers in [`src/helpers/parallelism.nim`](src/helpers/parallelism.nim) all
**return** a `Value` (the `:task`) rather than pushing — callers `push` the
result themselves. Same for `drainTask`, which returns the resolved Value.
Keeps the helper module free of stack-discipline concerns.

### Caveats specific to the in-process tier

- futures only progress while the dispatcher is being driven. fire-and-forget
  without a `wait` won't actually transfer bytes / write to disk. typical
  flow (launch, do other work, then `wait`) gives genuine concurrency
  between in-flight in-process tasks during the first `waitFor`.
- `cancel` flips the `taskCancelled` state but can't yet abort an in-flight
  in-process operation. follow-up: stash the underlying handle (the
  `AsyncHttpClient`, the `AsyncFile`) on `VTask` and close it on cancel.
- `AsyncHttpClient` over https requires an explicit `sslContext` (default
  `getDefaultSSL()` doesn't kick in the same way it does for the sync client
  — the dispatcher will spin forever otherwise). currently passing
  `newContext(verifyMode = CVerifyNone)` to match the sync builtin's verify
  mode.
- `AsyncHttpClient` has known quirks with some hosts (e.g. `raw.githubusercontent.com`
  hangs on redirect under the async client; sync works fine). independent of
  this branch — the sync `download` is unaffected.

## Open issues / next-up work

In rough priority order:

### 1. Error propagation from child

If the child errors, currently the parent gets `:null` back (we just check
exit code). Should:
- detect non-zero exit / temp file with error sentinel
- transition the `VTask` to `taskFailed` state
- `wait` on a failed task should return an `:error` value (or rethrow)

### 2. Database has the same `:db` type-suffix bug

Pre-existing on master, not part of this branch's scope. The fix is
identical to what we did for Task — route through `dumpPrimitive`.
Worth flagging in a separate PR.

### 3. Process startup overhead (~30ms)

For tiny blocks the overhead dominates. A worker pool / process reuse
could mitigate but adds significant complexity. Wait for real usage to
justify before doing this.

### 4. `execute.async` should return a `:task`

[`src/library/System.nim:246`](src/library/System.nim) acknowledges its
current implementation is broken. It should be reworked to return a real
`:task` consistent with the `.async` family.

## Files touched (for orientation)

- New file: [`src/library/Tasks.nim`](src/library/Tasks.nim) — `wait`, `done?`, `cancel`
- New file: [`src/helpers/parallelism.nim`](src/helpers/parallelism.nim) — `runInChildProcess`, `spawnAsTask`, `drainTask`
- New file: [`src/vm/values/custom/vtask.nim`](src/vm/values/custom/vtask.nim) — state enum
- Modified: [`src/vm/values/types.nim`](src/vm/values/types.nim) — `Task` ValueKind, `VTask` ref, asyncfutures import
- Modified: [`src/vm/values/value.nim`](src/vm/values/value.nim) — `newTask`, `$(VTask)`, `hash(VTask)`, copy/hash branches
- Modified: [`src/vm/values/printable.nim`](src/vm/values/printable.nim) — `$`/dump branches
- Modified: [`src/library/Core.nim`](src/library/Core.nim) — `do.async` attr, `runInChildProcess` helper
- Modified: [`src/library/Net.nim`](src/library/Net.nim) — `request.async`
- Modified: [`src/vm/vm.nim`](src/vm/vm.nim) — register Tasks module
- Modified: [`src/helpers/jsonobject.nim`](src/helpers/jsonobject.nim), [`src/helpers/conversion.nim`](src/helpers/conversion.nim) — cover `Task` in case statements

## Commit-style reminders

- bite-sized commits, one logical change each
- lowercase natural prose, single-segment `[scope]` tags (`[Tasks]`, `[Core]`, `[values]`, `[vm]`, `[helpers]`, `[Net]`)
- backtick function/builtin names in messages: `` `do.async` ``, `` `wait` ``
- **never** `Co-Authored-By: Claude` or any AI signature

## How user wants this conversation to go

- ask before guessing — they've explicitly said "if there is anything to ask me re: Arturo, just ask me"
- match their voice in commits and prose
- when in doubt about Arturo semantics, run a small test against `bin/arturo-tasks -e '...'` to verify before assuming

## Lessons & architectural reflection

> Read this before doing the next round of work. Saves re-deriving what we
> already learned the hard way.

### The subprocess approach is overkill for I/O builtins

Originally **everything** routed through `runInChildProcess` (~30ms fork+exec
per task, no closure capture, separate VM). For `do.async` that's the
only honest option — Arturo's VM holds global mutable state, can't
re-enter. But for the I/O builtins (`serve`, `read`, `write`, `download`,
`request`), it's wrong:

- subprocess can't see the parent's vars/functions
- 30ms startup dwarfs the actual work for small operations
- each subprocess is a full Arturo VM — tens of MB of memory

**Two tiers, same `:task` handle** — partially landed already:

| builtin | mechanism | status |
|---|---|---|
| `do.async`, `execute.async` | subprocess | only honest option |
| `download.async` | in-process `AsyncHttpClient` | ✅ done |
| local-file `read.async` | in-process `asyncfile` + sync post-process closure | ✅ done |
| text/json/binary `write.async` | in-process `asyncfile` | ✅ done |
| `serve.async` | in-process `asynchttpserver` | ⏳ still subprocess |
| `request.async` | in-process `AsyncHttpClient` | ⏳ still subprocess |
| URL `read.async`, `:bytecode` legs | in-process `AsyncHttpClient` / async bytecode reader | ⏳ still subprocess |

The `:task` value type didn't need changing — it's just a handle. `wait` /
`done?` / `cancel` work uniformly across both mechanisms; the only
discriminator today is whether `tsk.process` is `nil` (in-process) or set
(subprocess). `cancel` already routes correctly (`process.terminate()` for
subprocess, state-flip for in-process). Closing the underlying async
handle to genuinely abort in-process operations is the next step.

### How other VMs handle the closure-capture problem

For context when the user comes back wondering "why can't `do.async`
see my variables":

- **JS Workers** — structured cloning of values, no closures. Same
  problem we have.
- **Python `multiprocessing.spawn`** — pickle serialization, no closures.
  Same problem.
- **Python `multiprocessing.fork`** — Linux-only, exploits copy-on-write
  fork() to inherit *everything*. Not available cross-platform.
- **Ruby `Process.fork`** — same as Python fork. Linux/macOS only.
- **Ruby Ractors** — forbid mutable sharing at language level.
- **Erlang/Elixir** — actor-VM with lightweight processes inside one VM
  heap (huge engineering effort, ~not realistic for Arturo).
- **Clojure `future` / `pmap`** — JVM threads with full shared memory.

So the subprocess pattern with no closure capture is consistent with most
mainstream VM languages. It's not a defect, but the user should know
about it explicitly. **In-process async for I/O builtins is the natural
fix because it preserves closures** (handlers run in the same VM with
the same Symtable).

### Other open caveats

1. **No error propagation** — child crashes/throws return `null`. Should
   detect non-zero exit, set `taskFailed`, surface as `:error` on `wait`.
2. **Marshalling holes** — `express.safe` handles strings/numbers/blocks/
   dicts/null/logical fine. Functions/Methods/Objects with magic methods
   don't round-trip. Probably can't be made to without serializing
   bytecode (heavy).
3. **Startup cost ~30ms** — bad for fan-out > ~100 tasks. A worker pool
   could amortize but adds complexity. Not worth it until real usage
   justifies.
4. **Stdout interleaving** — multiple parallel tasks `print` into the
   same terminal, output mixes. No good fix; users should write to logs
   or pass results through `wait` if they need ordered output.
5. **Temp-file race** — `epochTime+pid` is *probably* unique but not
   guaranteed. Should use `genTempPath` from `os` or a UUID-style helper.
6. **Process leak on parent SIGKILL** — children may outlive parent.
   Standard Unix issue. Mitigation: `setpgid` on spawn + `killpg` on
   cleanup. Not done today.
7. **No fan-in helpers** — `wait.all`, `race`, `on.done` are useful and
   small to add. Postponed in v1 by user choice.
8. **`execute.async` not yet ported** — still uses the old broken
   global-table approach in System.nim. Should return a `:task` like
   everything else.

### What I'd ship next, in order

1. **In-process async for I/O builtins** — biggest UX win (closure capture
   works), real perf win, removes the surprise.
2. **Error propagation** — currently silent failure is unfriendly.
3. **`wait.all` / `race` / `on.done`** — small additions, big DX.
4. **`execute.async` returns a `:task`** — consistency.
5. **Database `:db` type-suffix bug** — pre-existing, trivial fix.
6. **Process group / leak hygiene** — defensive.

## Quick smoke test on cold start

```sh
git checkout add-new-Task-value
./build.nims --dev --as arturo-tasks
bin/arturo-tasks -e 't: do.async [40 + 2]
print t
print wait t'
```

Expected:
```
<task>(0x...)
42
```

If that works, the branch is healthy and you can pick up wherever the user
wants to go next (most likely #1 — real `cancel` — or #2 — error propagation).
