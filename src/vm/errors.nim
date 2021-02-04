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

import sequtils, sets, strformat, strutils, sugar

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
# Helpers
#=======================================

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

#=======================================
# Templates
#=======================================

template showConversionError*():untyped =
    echo "cannot convert argument of type :" & ($(y.kind)).toLowerAscii() & " to :" & ($(x.t)).toLowerAscii()

template invalidConversionError*(origin: string):untyped =
    echo "cannot convert " & origin & " to :" & ($(x.t)).toLowerAscii()

template RuntimeError_NotEnoughArguments*(functionName:string, functionArity: int): untyped =
    panic "cannot perform '" & (static functionName) & "';" & 
          "not enough parameters: " & $(static functionArity) & " required"

template RuntimeError_WrongArgumentType*(functionName:string, argumentPos: int, expected: untyped): untyped =
    let actualStr = toSeq(0..argumentPos).map(proc(x:int):string = ":" & ($(Stack[SP-1-x].kind)).toLowerAscii()).join(" ")
    let acceptedStr = toSeq((expected[argumentPos][1]).items).map(proc(x:ValueKind):string = ":" & ($(x)).toLowerAscii()).join(" ")
    
    when argumentPos==0:
        let ordinalPos = "first"
    when argumentPos==1:
        let ordinalPos = "second"
    when argumentPos==2:
        let ordinalPos = "third"

    panic "cannot perform '" & (static functionName) & "' -> " & actualStr & ";" &
          "incorrect argument type for " & ordinalPos & " parameter;" &
          "accepts " & acceptedStr

