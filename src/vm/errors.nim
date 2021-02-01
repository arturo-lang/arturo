######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: vm/errors.nim
######################################################

#=======================================
# Libraries
#=======================================

import sequtils, strformat, strutils, sugar

import helpers/colors as ColorsHelper

import vm/[stack, value]

type ReturnTriggered* = object of Defect

var
    vmPanic* = false
    vmError* = ""
    vmReturn* = false
    vmBreak* = false
    vmContinue* = false

#=======================================
# Templates
#=======================================

template showConversionError*():untyped =
    echo "cannot convert argument of type :" & ($(y.kind)).toLowerAscii() & " to :" & ($(x.t)).toLowerAscii()

template invalidConversionError*(origin: string):untyped =
    echo "cannot convert " & origin & " to :" & ($(x.t)).toLowerAscii()

template panic*(error: string): untyped =
    vmPanic = true
    vmError = error
    return

proc showVMErrors*() =
    if vmPanic:
        let errMsg = vmError.split(";").map((x)=>strutils.strip(x)).join(fmt("\n         {bold(redColor)}|{resetColor} "))
        echo fmt("{bold(redColor)}>> Error |{resetColor} {errMsg}")
        emptyStack()
        vmPanic = false