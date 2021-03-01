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

import sequtils, sets
import strformat, strutils, sugar
import nre except toSeq

import helpers/colors as ColorsHelper

import vm/[stack, value]

const
    RuntimeError* = "Runtime Error"
    SyntaxError*  = "Syntax Error"

type 
    ReturnTriggered* = object of Defect
    VMError* = ref object of Defect

var
    vmPanic* = false
    vmError* = ""
    vmReturn* = false
    vmBreak* = false
    vmContinue* = false

#=======================================
# Helpers
#=======================================

template panic*(context: string, error: string): untyped =
    raise VMError(name: context, msg:error)

proc showVMErrors*(e: ref Exception) =
    var header = e.name

    if $(header) notin [RuntimeError, SyntaxError]:
        header = RuntimeError

    let marker = ">>"
    let separator = "|"
    let indent = repeat(" ", header.len + marker.len + 2)

    var message = e.msg.replace(nre.re"_([^_]+)_",fmt("{bold()}$1{resetColor}"))

    let errMsg = message.split(";").map((x)=>strutils.strip(x)).join(fmt("\n{indent}{bold(redColor)}{separator}{resetColor} "))
    echo fmt("{bold(redColor)}{marker} {header} {separator}{resetColor} {errMsg}")
    # emptyStack()

# proc showVMErrors*() =
#     if vmPanic:
#         let errMsg = vmError.split(";").map((x)=>strutils.strip(x)).join(fmt("\n         {bold(redColor)}|{resetColor} "))
#         echo fmt("{bold(redColor)}>> Error |{resetColor} {errMsg}")
#         emptyStack()
#         vmPanic = false

#=======================================
# Templates
#=======================================

template showConversionError*():untyped =
    echo "cannot convert argument of type :" & ($(y.kind)).toLowerAscii() & " to :" & ($(x.t)).toLowerAscii()

template invalidConversionError*(origin: string): untyped =
    echo "cannot convert " & origin & " to :" & ($(x.t)).toLowerAscii()

template SyntaxError_MissingClosingBracket*(context: string): untyped =
    panic SyntaxError,
          "missing closing bracket" & ";" & 
          "near: " & context

template RuntimeError_OutOfBounds*(indx: int, maxRange: int):untyped =
    panic RuntimeError,
          "array index out of bounds: " & $(indx) & ";" & 
          "valid range: 0.." & $(maxRange)

template RuntimeError_SymbolNotFound*(sym: string, alter: string):untyped =
    panic RuntimeError,
          "symbol not found: " & sym & ";" & 
          "perhaps you meant _" & alter & "_ ?"

template RuntimeError_KeyNotFound*(sym: string, alter: string):untyped =
    panic RuntimeError,
          "dictionary key not found: " & sym & ";" & 
          "perhaps you meant _" & alter & "_ ?"

template RuntimeError_NotEnoughArguments*(functionName:string, functionArity: int): untyped =
    panic RuntimeError,
          "cannot perform _" & (static functionName) & "_;" & 
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

    panic RuntimeError,
          "cannot perform _" & (static functionName) & "_ -> " & actualStr & ";" &
          "incorrect argument type for " & ordinalPos & " parameter;" &
          "accepts " & acceptedStr

