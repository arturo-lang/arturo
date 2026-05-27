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
## Other shared globals (`Aliases`, `LibraryModules`, `ScopeFramePool`,
## `Stores`, `Config`, `Dumper`) stay truly global, never swapped.

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
        stack*: ValueArray
        sp*: int
        attrs*: SymTable
        syms*: SymTable
        dictSyms*: seq[ValueDict]
        scopeStack*: seq[SymTable]
        cancelRequested*: bool      ## flipped by `cancel`; checked at each yield

#=======================================
# Methods
#=======================================

proc newVMContext*(parentSyms: SymTable): VMContext =
    ## Fresh context for a new fiber. `parentSyms` shallow-copied.
    result = VMContext(
        sp: 0,
        attrs: initTable[string, Value](),
        syms: parentSyms,
        dictSyms: @[],
        scopeStack: @[],
        cancelRequested: false
    )
    newSeq(result.stack, StackSize)

proc swapOutTo*(ctx: VMContext) =
    ## Save live VM globals into `ctx`, leave slots empty.
    ctx.stack       = move Stack
    ctx.sp          = SP
    ctx.attrs       = move Attrs
    ctx.syms        = move Syms
    ctx.dictSyms    = move DictSyms
    ctx.scopeStack  = move ScopeStack
    SP = 0

proc swapInFrom*(ctx: VMContext) =
    ## Restore live VM globals from `ctx`. Reverse of `swapOutTo`.
    Stack       = move ctx.stack
    SP          = ctx.sp
    Attrs       = move ctx.attrs
    Syms        = move ctx.syms
    DictSyms    = move ctx.dictSyms
    ScopeStack  = move ctx.scopeStack
