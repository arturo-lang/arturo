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

import re, sequtils, sets
import strformat, strutils, sugar
#import nre except toSeq

import helpers/colors as ColorsHelper

import vm/[stack, value]

const
    RuntimeError* = "Runtime"
    SyntaxError*  = "Syntax"

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

    var message = e.msg.replacef(re"_([^_]+)_",fmt("{bold()}$1{resetColor}"))

    let errMsgParts = message.split(";").map((x)=>(strutils.strip(x)).replace("~%"," "))
    let alignedError = alignLeft("Error", header.len)
    var errMsg = errMsgParts[0] & fmt("\n{bold(redColor)}{repeat(' ',marker.len)} {alignedError} {separator}{resetColor} ")
    if errMsgParts.len > 1:
        errMsg &= errMsgParts[1..^1].join(fmt("\n{indent}{bold(redColor)}{separator}{resetColor} "))
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

## Syntax errors

template SyntaxError_MissingClosingBracket*(lineno: int, context: string): untyped =
    panic SyntaxError,
          "missing closing bracket" & ";;" & 
          "line: " & $(lineno) & ";" &
          "near: " & context

template SyntaxError_UnterminatedString*(strtype: string, lineno: int, context: string): untyped =
    var strt = strtype
    if strt!="": strt &= " "
    panic SyntaxError,
          "unterminated " & strt & "string;;" & 
          "line: " & $(lineno) & ";" &
          "near: " & context

template SyntaxError_NewlineInQuotedString*(lineno: int, context: string): untyped =
    panic SyntaxError,
          "newline in quoted string;" & 
          "for multiline strings, you could use either:;" &
          "curly blocks _{..}_ or _triple \"-\"_ templates;;" &
          "line: " & $(lineno) & ";" &
          "near: " & context

template SyntaxError_EmptyLiteral*(lineno: int, context: string): untyped =
    panic SyntaxError,
          "empty literal value;;" & 
          "line: " & $(lineno) & ";" &
          "near: " & context

## Runtime errors

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

## Misc errors

template showConversionError*():untyped =
    echo "cannot convert argument of type :" & ($(y.kind)).toLowerAscii() & " to :" & ($(x.t)).toLowerAscii()

template invalidConversionError*(origin: string): untyped =
    echo "cannot convert " & origin & " to :" & ($(x.t)).toLowerAscii()
