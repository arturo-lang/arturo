#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: vm/context.nim
#=======================================================

## Per-fiber slice of the VM globals.
##
## Swapped in/out by the scheduler around each fiber resume/suspend.
## Shallow-copies `Syms` at spawn (closure capture); writes don't leak.
## Frames are copied at spawn too: fibers interleave, so they can't share a stack.
## Other shared globals (`Aliases`, `LibraryModules`, `ScopeFramePool`,
## `Stores`, `Config`, `Dumper`) stay truly global, never swapped.

#=======================================
# Libraries
#=======================================

import tables

import vm/[errors, globals, runtime, stack]
import vm/values/value

#=======================================
# Types
#=======================================

type
    VMContext* = ref object
        stack*: ValueArray
        sp*: int
        attrs*: SymTable
        syms*: SymSlots
        dictSyms*: seq[ValueDict]
        scopeStack*: seq[ScopeFrame]
        frames*: seq[Frame]         ## inherited at spawn
        imports*: seq[string]
        line*: int
        cancelRequested*: bool      ## flipped by `cancel`; checked at each yield

#=======================================
# Variables
#=======================================

var
    StackPool: seq[ValueArray]      ## stacks of finished fibers, to be reused

#=======================================
# Methods
#=======================================

proc newVMContext*(parentSyms: SymSlots): VMContext =
    ## Fresh context for a new fiber. `parentSyms` shallow-copied.
    result = VMContext(
        sp: 0,
        attrs: initTable[string, Value](),
        syms: parentSyms,
        dictSyms: @[],
        scopeStack: @[],
        frames: FrameStack[0..<FSP],
        imports: ImportsInProgress,
        line: CurrentLine,
        cancelRequested: false
    )
    # (no stack yet: it's only needed once the fiber runs)

proc swapOutTo*(ctx: VMContext) =
    ## Save live VM globals into `ctx`, leave slots empty.
    ctx.stack       = move Stack
    ctx.sp          = SP
    ctx.attrs       = move Attrs
    ctx.syms        = move Syms
    ctx.dictSyms    = move DictSyms
    ctx.scopeStack  = move ScopeStack
    ctx.imports     = move ImportsInProgress
    ctx.line        = CurrentLine
    ctx.frames.setLen(FSP)
    for i in 0..<FSP:
        ctx.frames[i] = move FrameStack[i]
    SP = 0

proc swapInFrom*(ctx: VMContext) =
    ## Restore live VM globals from `ctx`. Reverse of `swapOutTo`.
    if ctx.stack.len == 0:
        # first run: a stack from a finished fiber, or a new one
        if StackPool.len > 0:   ctx.stack = StackPool.pop()
        else:                   newSeq(ctx.stack, StackSize)
    Stack       = move ctx.stack
    SP          = ctx.sp
    Attrs       = move ctx.attrs
    Syms        = move ctx.syms
    DictSyms    = move ctx.dictSyms
    ScopeStack  = move ctx.scopeStack
    ImportsInProgress = move ctx.imports
    CurrentLine = ctx.line
    FSP         = ctx.frames.len
    for i in 0..<FSP:
        FrameStack[i] = move ctx.frames[i]

proc release*(ctx: VMContext) =
    ## Let go of everything a finished fiber had,
    ## keeping its stack for the next ones
    ##
    ## (we keep all of them: they're never more than the most
    ## fibers there have been at the same time - and freeing one
    ## means going through all of its slots, only to have to
    ## clear a new one, a bit later)
    if ctx.stack.len > 0:
        StackPool.add(move ctx.stack)
    reset(ctx.stack)
    reset(ctx.attrs)
    reset(ctx.syms)
    reset(ctx.dictSyms)
    reset(ctx.scopeStack)
    reset(ctx.frames)
    reset(ctx.imports)
