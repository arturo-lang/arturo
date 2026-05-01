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

import tables

import vm/[globals, stack]
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

#=======================================
# Methods
#=======================================

proc newVMContext*(parentSyms: SymTable): VMContext =
    ## Build a fresh `VMContext` for a newly-spawned fiber.
    ##
    ## **Closure capture (locked decision, see CONCURRENCY_NOTES):**
    ## the parent's symbol table is **shallow-copied**. The child
    ## fiber sees parent symbols at spawn time and writes don't
    ## leak back. Values are refs, so the copy is just the bucket
    ## array — sub-ms even for large namespaces.
    ##
    ## Everything else starts fresh:
    ##
    ## - `stack` is pre-allocated to `StackSize` to match
    ##   `createMainStack`. Per-fiber operand stacks are independent.
    ## - `attrs`, `dictSyms`, `scopeStack` start empty — the child
    ##   block runs as a top-level execution, not a continuation of
    ##   the parent's in-flight call/dictionary construction.
    result = VMContext(
        sp: 0,
        attrs: initTable[string, Value](),
        syms: parentSyms,           # shallow copy via Nim's =copy
        dictSyms: @[],
        scopeStack: @[],
        cancelRequested: false
    )
    newSeq(result.stack, StackSize)

proc swapOutTo*(ctx: VMContext) =
    ## Save the live VM globals into `ctx` and leave the live slots
    ## in a consistent empty state. The next `swapInFrom` repopulates
    ## them; nothing else should touch the globals in between.
    ##
    ## `move` everywhere for the seq/Table fields — those headers
    ## move in O(1) under ORC and the source ends up default-empty.
    ## `SP` is a plain `int`, so we reset it explicitly to keep it
    ## consistent with the now-empty `Stack` (`Stack[SP-1]` would
    ## otherwise index into a length-0 seq).
    ctx.stack       = move Stack
    ctx.sp          = SP
    ctx.attrs       = move Attrs
    ctx.syms        = move Syms
    ctx.dictSyms    = move DictSyms
    ctx.scopeStack  = move ScopeStack
    SP = 0

proc swapInFrom*(ctx: VMContext) =
    ## Restore the live VM globals from `ctx`. The reverse of
    ## `swapOutTo`. After this call the VM is ready to execute
    ## code in the fiber `ctx` belongs to.
    Stack       = move ctx.stack
    SP          = ctx.sp
    Attrs       = move ctx.attrs
    Syms        = move ctx.syms
    DictSyms    = move ctx.dictSyms
    ScopeStack  = move ctx.scopeStack
