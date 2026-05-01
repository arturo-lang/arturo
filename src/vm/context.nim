#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: vm/context.nim
#=======================================================

## Per-fiber slice of the VM globals.
##
## Arturo's interpreter keeps its working state in module-level
## `var ... {.global.}` slots (see [`vm/stack.nim`](stack.nim) and
## [`vm/globals.nim`](globals.nim)). To run a user block on a
## fiber, we save those slots into a `VMContext` when the fiber
## suspends and restore them when it resumes. The interpreter
## itself never learns about fibers — it just sees globals that
## change shape between switches.
##
## ## What gets swapped (per-fiber)
##
## - `Stack`, `SP`, `Attrs` (vm/stack.nim) — operand stack and
##   attributes table for the in-flight expression.
## - `Syms` (vm/globals.nim) — the symbol table the user block
##   reads and writes against. Shallow-copied at spawn (per the
##   closure-capture decision in CONCURRENCY_NOTES.md); writes from
##   one fiber don't leak into others.
## - `DictSyms` (vm/globals.nim) — the dictionary-construction
##   stack used by `execDictionary`. Per-fiber so a
##   `make :dictionary` running concurrently doesn't stomp another
##   fiber's frame.
## - `ScopeStack` (vm/globals.nim) — the per-call undo log of
##   touched symbols. Per-fiber so function unwind on one fiber
##   doesn't roll back another fiber's writes.
##
## ## What stays shared (truly global, do NOT swap)
##
## - `Aliases` — symbol-aliasing rules. Configuration, set at
##   startup, read everywhere. Sharing is the point.
## - `LibraryModules` — the registry of builtin libraries.
##   Read-only after init.
## - `ScopeFramePool` — pool of recycled `SymTable`s used by
##   `pushScopeFrame` / `releaseScopeFrame`. Allocator-shaped
##   infrastructure; sharing it across fibers gives us a strictly
##   larger pool. Cooperative scheduling means concurrent access
##   isn't a race.
## - `Stores` — list of active stores to flush at exit. Shared by
##   design — a fiber writing to a store should land in the same
##   place the parent reads from.
## - `Config` — global configuration value. Read-only at runtime.
## - `Dumper` — value-printing callback. Pure infrastructure.

#=======================================
# Libraries
#=======================================

import vm/values/value

#=======================================
# Types
#=======================================

type
    VMContext* = ref object
        ## A snapshot of the per-fiber subset of VM globals. Lives
        ## as long as the fiber it belongs to. Filled by
        ## `swapOutTo` and drained by `swapInFrom` (Phase 2.2).
        stack*: ValueArray
        sp*: int
        attrs*: SymTable
        syms*: SymTable
        dictSyms*: seq[ValueDict]
        scopeStack*: seq[SymTable]
        cancelRequested*: bool
            ## Flipped by `cancel` from outside; checked by the
            ## scheduler at every cooperative yield (Phase 5).
