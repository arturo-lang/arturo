#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/values/clean.nim
#=======================================================

## This module has helper used to clean blocks
## Blocks may have `Newline` Values,
## so when you want to actually use its contents, we make sure that there will be none

import macros, sequtils, strutils, sugar

import vm/values/types

#=======================================
# Helpers
#=======================================

template cleanBlock*(v: Value) =
    ## remove all Newline values from a Block value, in-place 
    ## 
    ## **Hint**: ``v`` must be a Value, not a ValueArray ( 
    ## This is an optimization, as Block values have a 
    ## `.dirty` attribute: if `.dirty` is false it'll do 
    ## nothing.). When done, `.dirty`'ll be set to *false*.

    when not defined(NOERRORLINES):
        if v.dirty:
            v.a.keepIf((vv) => vv.kind != Newline)
            v.dirty = false     # Updates `.dirty` value
    else:
        discard

func cleanedBlockImpl*(va: ValueArray): ValueArray {.inline,enforceNoRaises.} =
    result = collect(newSeqOfCap(va.len)):
        for vv in va:
            if vv.kind != Newline:
                vv

template cleanedBlock*(va: ValueArray, inplace=false): untyped =
    when not defined(NOERRORLINES):
        cleanedBlockImpl(va)
    else:
        va

template cleanedBlockValuesCopy*(v: Value): untyped =
    when not defined(NOERRORLINES):
        if v.dirty:
            cleanedBlockImpl(v.a)
        else:
            v.a
    else:
        v.a

iterator cleanedBlockValues*(v: Value, L: int): lent Value =
    ## yield a Value object per iteration, while 
    ## ignoring all Newline values
    ## 
    ## **Note:** 
    ## - This is to be used inside a *for loop*.
    ## 
    ## **Usage:**
    ## ```nim
    ## for i in cleanedBlockValues(y, y.a.len):
    ##     x.a[cnt] = i
    ##     inc cnt
    ## ```

    when not defined(NOERRORLINES):
        if v.dirty:
            for i in 0..L-1:
                if v.a[i].kind != Newline:
                    yield v.a[i]
        else:
            for i in 0..L-1:
                yield v.a[i]
    else:
        for i in 0..L-1:
            yield v.a[i]

template cleanedBlockValues*(v: Value): untyped =
    ## yield a Value object per iteration, while 
    ## ignoring all Newline values
    ##
    ## **Note:** 
    ## - Detects `v.a`'s length automatically
    ## - This is to be used inside a *for loop*.
    ##
    ## **Usage:**
    ## ```nim
    ## for i in cleanedBlockValues(y):
    ##      x.a[cnt] = i
    ##      inc cnt
    ## ```

    let l = v.a.len
    cleanedBlockValues(v, l)

macro ensureCleaned*(name: untyped): untyped =
    let cleanName =  ident("clean" & ($name).capitalizeAscii())
    let cleanedBlock = ident("cleanedBlockTmp" & ($name).capitalizeAscii())
    when not defined(NOERRORLINES):
        result = quote do:
            var `cleanedBlock`: ValueArray
            let `cleanName` {.cursor.} = (
                if `name`.dirty:
                    `cleanedBlock` = cleanedBlockImpl(`name`.a)
                    `cleanedBlock`
                else:
                    `name`.a
            )
    else:
        result = quote do:
            let `cleanName` {.cursor.} = `name`.a
