######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/values/clean.nim
######################################################

import macros, sequtils, strutils, sugar

import vm/values/types

#=======================================
# Methods
#=======================================

# TODO(VM/values/clean) `cleanBlock` is too slow
#  when built without NOERRORLINES - which is our normal setup - this specific piece of code could be slowing down the whole language by up to 20%
#  labels: vm, values, performance, enhancement, benchmark, critical

func cleanBlock*(va: var ValueArray) {.inline,enforceNoRaises.} =
    when not defined(NOERRORLINES):
        va.keepIf((vv) => vv.kind != Newline)
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