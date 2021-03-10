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
import helpers/strings as StringsHelper

import vm/[bytecode, stack, value]

const
    RuntimeError*   = "Runtime"
    AssertionError* = "Assertion"
    SyntaxError*    = "Syntax"
    ProgramError*   = "Program"
    CompilerError*  = "Compiler"

    Alternative*  = "perhaps you meant"

type 
    ReturnTriggered* = ref object of Defect
    BreakTriggered* = ref object of Defect
    ContinueTriggered* = ref object of Defect
    VMError* = ref object of Defect

var
    vmPanic* = false
    vmError* = ""
    vmReturn* = false
    vmBreak* = false
    vmContinue* = false
    # opstack
    OpStack*    : array[5,OpCode]
    ConstStack* : ValueArray

#=======================================
# Helpers
#=======================================

proc getOpStack*(): string =
    if DoDebug:
        try:
            var ret = ";;"
            ret &= (fg(grayColor)).replace(";","%&") & "\b------------------------------;" & resetColor
            ret &= (fg(grayColor)).replace(";","%&") & "bytecode stack trace:;" & resetColor
            ret &= (fg(grayColor)).replace(";","%&") & "\b------------------------------;" & resetColor
            for i in countdown(4,0):
                let op = (OpCode)(OpStack[i])
                if op!=opNop :
                    ret &= (fg(grayColor)).replace(";","%&") & "\b>T@B" & ($(op)).replace("op","").toUpperAscii()
                    case op:
                        of opConstI0..opConstI10:
                            let indx = (int)(op)-(int)opConstI0
                            if indx>=0 and indx<ConstStack.len:
                                ret &= " (" & $(ConstStack[indx]) & ")"
                        of opPush0..opPush30:
                            let indx = (int)(op)-(int)opPush0
                            if indx>=0 and indx<ConstStack.len:
                                ret &= " (" & $(ConstStack[indx]) & ")"
                        of opStore0..opStore30:
                            let indx = (int)(op)-(int)opStore0
                            if indx>=0 and indx<ConstStack.len:
                                ret &= " (" & $(ConstStack[indx]) & ")"
                        of opLoad0..opLoad30:
                            let indx = (int)(op)-(int)opLoad0
                            if indx>=0 and indx<ConstStack.len:
                                ret &= " (" & $(ConstStack[indx]) & ")"
                        of opCall0..opCall30: 
                            let indx = (int)(op)-(int)opCall0
                            if indx>=0 and indx<ConstStack.len:
                                ret &= " (" & $(ConstStack[indx]) & ")"
                        else:
                            discard
                    
                    ret &= resetColor
                        
                if i!=0:
                    ret &= ";"

            ret
        except:
            ""
    else:
        ""

proc getWrongArgumentTypeErrorMsg*(functionName: string, argumentPos: int, expectedValues: seq[ValueKind]): string =
    let actualStr = toSeq(0..argumentPos).map(proc(x:int):string = ":" & ($(Stack[SP-1-x].kind)).toLowerAscii()).join(" ")
    let acceptedStr = expectedValues.map(proc(x:ValueKind):string = ":" & ($(x)).toLowerAscii()).join(" ")

    var ordinalPos: string = ""
    if argumentPos==0:
        ordinalPos = "first"
    elif argumentPos==1:
        ordinalPos = "second"
    elif argumentPos==2:
        ordinalPos = "third"

    return "cannot perform _" & functionName & "_ -> " & actualStr & ";" &
           "incorrect argument type for " & ordinalPos & " parameter;" &
           "accepts " & acceptedStr

proc panic*(context: string, error: string) =
    var errorMsg = error
    if $(context) notin [AssertionError, SyntaxError, CompilerError]:
        errorMsg &= getOpStack()
    raise VMError(name: context, msg:move errorMsg)

proc showVMErrors*(e: ref Exception) =
    var header = e.name

    if $(header) notin [RuntimeError, AssertionError, SyntaxError, ProgramError, CompilerError]:
        header = RuntimeError

    let marker = ">>"
    let separator = "|"
    let indent = repeat(" ", header.len + marker.len + 2)

    var message = e.msg.replacef(re"_([^_]+)_",fmt("{bold()}$1{resetColor}"))

    let errMsgParts = message.split(";").map((x)=>(strutils.strip(x)).replace("~%"," ").replace("%&",";").replace("T@B","\t"))
    let alignedError = align("error", header.len)
    var errMsg = errMsgParts[0] & fmt("\n{bold(redColor)}{repeat(' ',marker.len)} {alignedError} {separator}{resetColor} ")
    if errMsgParts.len > 1:
        errMsg &= errMsgParts[1..^1].join(fmt("\n{indent}{bold(redColor)}{separator}{resetColor} "))
    echo fmt("{bold(redColor)}{marker} {header} {separator}{resetColor} {errMsg}")
    # emptyStack()

#=======================================
# Methods
#=======================================

## Compiler errors

proc CompilerError_ScriptNotExists*(name: string) =
    panic CompilerError,
          "given script path doesn't exist:" & ";" &
          "_" & name & "_"

## Syntax errors

proc SyntaxError_MissingClosingBracket*(lineno: int, context: string) =
    panic SyntaxError,
          "missing closing bracket" & ";;" & 
          "line: " & $(lineno) & ";" &
          "near: " & context

proc SyntaxError_UnterminatedString*(strtype: string, lineno: int, context: string) =
    var strt = strtype
    if strt!="": strt &= " "
    panic SyntaxError,
          "unterminated " & strt & "string;;" & 
          "line: " & $(lineno) & ";" &
          "near: " & context

proc SyntaxError_NewlineInQuotedString*(lineno: int, context: string) =
    panic SyntaxError,
          "newline in quoted string;" & 
          "for multiline strings, you could use either:;" &
          "curly blocks _{..}_ or _triple \"-\"_ templates;;" &
          "line: " & $(lineno) & ";" &
          "near: " & context

proc SyntaxError_EmptyLiteral*(lineno: int, context: string) =
    panic SyntaxError,
          "empty literal value;;" & 
          "line: " & $(lineno) & ";" &
          "near: " & context

## Assertion errors

proc AssertionError_AssertionFailed*(context: string) =
    panic AssertionError,
          context

## Runtime errors

proc RuntimeError_OutOfBounds*(indx: int, maxRange: int) =
    panic RuntimeError,
          "array index out of bounds: " & $(indx) & ";" & 
          "valid range: 0.." & $(maxRange)

proc RuntimeError_SymbolNotFound*(sym: string, alter: seq[string]) =
    let sep = ";" & repeat("~%",Alternative.len - 2) & "or... "
    panic RuntimeError,
          "symbol not found: " & sym & ";" & 
          "perhaps you meant... " & alter.map((x) => "_" & x & "_ ?").join(sep)

proc RuntimeError_KeyNotFound*(sym: string, alter: seq[string]) =
    let sep = ";" & repeat("~%",Alternative.len - 2) & "or... "
    panic RuntimeError,
          "dictionary key not found: " & sym & ";" & 
          "perhaps you meant... " & alter.map((x) => "_" & x & "_ ?").join(sep)

proc RuntimeError_NotEnoughArguments*(functionName:string, functionArity: int) =
    panic RuntimeError,
          "cannot perform _" & (functionName) & "_;" & 
          "not enough parameters: " & $(functionArity) & " required"

template RuntimeError_WrongArgumentType*(functionName:string, argumentPos: int, expected: untyped): untyped =
    let expectedValues = toSeq((expected[argumentPos][1]).items)
    
    panic RuntimeError, 
          getWrongArgumentTypeErrorMsg(functionName, argumentPos, expectedValues)

proc RuntimeError_CannotConvert*(x, y: Value) =
    panic RuntimeError,
          "cannot convert argument: " & truncate(codify(y),20) & ";" &
          "from :" & ($(y.kind)).toLowerAscii() & ";" &
          "to   :" & ($(x.t)).toLowerAscii()

proc RuntimeError_ConversionFailed*(x, y: Value) =
    panic RuntimeError,
          "conversion failed: " & truncate(codify(y),20) & ";" &
          "from :" & ($(y.kind)).toLowerAscii() & ";" &
          "to   :" & ($(x.t)).toLowerAscii()

