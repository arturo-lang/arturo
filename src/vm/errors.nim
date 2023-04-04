#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: vm/errors.nim
#=======================================================

## Error handling for the VM.

# TODO(VM/errors) General cleanup needed
#  Do we need all these different errors? Could it be done in a more organized function by, at least, using some template? Are there other errors - mostly coming from built-in functions - that are not reported, which we could add?
#  labels: vm, error handling, enhancement, cleanup

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import re
    
import sequtils, strformat, strutils, sugar

import helpers/strings
import helpers/terminal

#=======================================
# Types
#=======================================

type
    ReturnTriggered* = ref object of Defect
    BreakTriggered* = ref object of Defect
    ContinueTriggered* = ref object of Defect
    VMError* = ref object of CatchableError

    VMErrorKind* = enum
        RuntimeError   = "Runtime"
        AssertionError = "Assertion"
        SyntaxError    = "Syntax"
        ProgramError   = "Program"
        CompilerError  = "Compiler"

        UndefinedError = "Undefined"

#=======================================
# Constants
#=======================================

const
    Alternative     = "perhaps you meant"

#=======================================
# Variables
#=======================================

var
    CurrentFile* = "<repl>"
    CurrentPath* = ""
    CurrentLine* = 0
    ExecStack*: seq[int] = @[]

#=======================================
# Forward declarations
#=======================================

proc showVMErrors*(e: ref Exception)

#=======================================
# Main
#=======================================

proc getLineError(): string =
    if CurrentFile != "<repl>":
        if CurrentLine==0: CurrentLine = 1
        if ExecStack.len > 1:
            ExecStack.add(CurrentLine)
        result &= (bold(grayColor)).replace(";","%&") & "File: " & resetColor & (fg(grayColor)).replace(";","%&") & CurrentFile & ";" & (bold(grayColor)).replace(";","%&") & "Line: " & resetColor & (fg(grayColor)).replace(";","%&") & $(CurrentLine) & resetColor & ";;"

proc panic*(context: VMErrorKind, error: string, throw=true) =
    ## throw error, using given context and error message
    var errorMsg = error
    if context != CompilerError:
        when not defined(NOERRORLINES):
            errorMsg = getLineError() & errorMsg
        else:
            discard 
    let err = VMError(name: cstring($(context)), msg:move errorMsg)
    if throw:
        raise err
    else:
        showVMErrors(err)

#=======================================
# Helpers
#=======================================

proc showVMErrors*(e: ref Exception) =
    ## show error message
    var header: string
    var errorKind: VMErrorKind = UndefinedError
    try:
        header = $(e.name)

        try:
            # try checking if it's a valid error context
            errorKind = parseEnum[VMErrorKind](header)
        except ValueError:
            # if not, show it as an uncaught runtime exception
            e.msg = getLineError() & "uncaught system exception:;" & e.msg
            header = $(RuntimeError)

            
        # if $(header) notin [RuntimeError, AssertionError, SyntaxError, ProgramError, CompilerError]:
        #     e.msg = getLineError() & "uncaught system exception:;" & e.msg
        #     header = RuntimeError
    except CatchableError:
        header = "HEADER"

    let marker = ">>"
    let separator = "|"
    let indent = repeat(" ", header.len + marker.len + 2)

    when not defined(WEB):
        var message: string
        
        if errorKind==ProgramError:
            let liner = e.msg.split("<:>")[0].split(";;")[0]
            let msg = e.msg.split("<:>")[1]
            message = liner & ";;" & msg.replacef(re"_([^_]+)_",fmt("{bold()}$1{resetColor}"))
        else:
            message = e.msg.replacef(re"_([^_]+)_",fmt("{bold()}$1{resetColor}"))
    else:
        var message = "MESSAGE"

    let errMsgParts = message.split(";").map((x)=>(strutils.strip(x)).replace("~%"," ").replace("%&",";").replace("T@B","\t"))
    let alignedError = align("error", header.len)
    
    var errMsg = errMsgParts[0] & fmt("\n{bold(redColor)}{repeat(' ',marker.len)} {alignedError} {separator}{resetColor} ")

    if errMsgParts.len > 1:
        errMsg &= errMsgParts[1..^1].join(fmt("\n{indent}{bold(redColor)}{separator}{resetColor} "))
    echo fmt("{bold(redColor)}{marker} {header} {separator}{resetColor} {errMsg}")

#=======================================
# Methods
#=======================================

# Compiler errors

proc CompilerError_ScriptNotExists*(name: string) =
    panic CompilerError,
          "given script path doesn't exist:" & ";" &
          "_" & name & "_"

proc CompilerError_UnrecognizedOption*(name: string) =
    panic CompilerError,
          "unrecognized command-line option:" & ";" &
          "_" & name & "_",
          throw=false

# Syntax errors

proc SyntaxError_MissingClosingSquareBracket*(lineno: int, context: string) =
    CurrentLine = lineno
    panic SyntaxError,
          "missing closing square bracket: `]`" & ";;" & 
          "near: " & context

proc SyntaxError_MissingClosingParenthesis*(lineno: int, context: string) =
    CurrentLine = lineno
    panic SyntaxError,
          "missing closing square bracket: `)`" & ";;" & 
          "near: " & context

proc SyntaxError_StrayClosingSquareBracket*(lineno: int, context: string) =
    CurrentLine = lineno
    panic SyntaxError,
          "stray closing square bracket: `]`" & ";;" & 
          "near: " & context

proc SyntaxError_StrayClosingCurlyBracket*(lineno: int, context: string) =
    CurrentLine = lineno
    panic SyntaxError,
          "stray closing curly bracket: `}`" & ";;" & 
          "near: " & context

proc SyntaxError_StrayClosingParenthesis*(lineno: int, context: string) =
    CurrentLine = lineno
    panic SyntaxError,
          "stray closing parenthesis: `)`" & ";;" & 
          "near: " & context

proc SyntaxError_UnterminatedString*(strtype: string, lineno: int, context: string) =
    var strt = strtype
    if strt!="": strt &= " "
    CurrentLine = lineno
    panic SyntaxError,
          "unterminated " & strt & "string;;" & 
          "near: " & context

proc SyntaxError_NewlineInQuotedString*(lineno: int, context: string) =
    CurrentLine = lineno
    panic SyntaxError,
          "newline in quoted string;" & 
          "for multiline strings, you could use either:;" &
          "curly blocks _{..}_ or _triple \"-\"_ templates;;" &
          "near: " & context

proc SyntaxError_EmptyLiteral*(lineno: int, context: string) =
    CurrentLine = lineno
    panic SyntaxError,
          "empty literal value;;" & 
          "near: " & context

# Assertion errors

proc AssertionError_AssertionFailed*(context: string) =
    panic AssertionError,
          context
          
proc AssertionError_AssertionFailed*(context: string, message: string) =
    panic AssertionError, 
          message & ":;" & 
          "for: " & context

# Runtime errors

proc RuntimeError_IntegerParsingOverflow*(lineno: int, number: string) =
    CurrentLine = lineno
    panic RuntimeError,
          "number parsing overflow - up to " & $(sizeof(int) * 8) & "-bit integers supported" & ";" &
          "given: " & truncate(number, 20)

proc RuntimeError_IntegerOperationOverflow*(operation: string, argA, argB: string) =
    panic RuntimeError,
            "number operation overflow - up to " & $(sizeof(int) * 8) & "-bit integers supported" & ";" &
            "attempted: " & operation & ";" &
            "with: " & truncate(argA & " " & argB, 30)

proc RuntimeError_NumberOutOfPermittedRange*(operation: string, argA, argB: string) =
    panic RuntimeError,
            "number operator out of range - up to " & $(sizeof(int) * 8) & "-bit integers supported" & ";" &
            "attempted: " & operation & ";" &
            "with: " & truncate(argA & " " & argB, 30)

proc RuntimeError_IncompatibleQuantityOperation*(operation: string, argA, argB, kindA, kindB: string) =
    panic RuntimeError,
            "incompatible operation between quantities" & ";" &
            "attempted: " & operation & ";" &
            "with: " & truncate(argA & " (" & kindA & ") " & argB & " (" & kindB & ")", 60)
            
proc RuntimeError_IncompatibleValueType*(functionName: string, tp: string, expected: string) =
    panic RuntimeError,
          "cannot perform _" & (functionName) & "_;" &
          "incompatible value type for " & tp & ";" &
          "expected " & expected

proc RuntimeError_IncompatibleBlockValue*(functionName: string, val: string, expected: string) =
    panic RuntimeError,
          "cannot perform _" & (functionName) & "_ -> [" & val & " ...];" &
          "incompatible value in block parameter" & ";" &
          "expected " & expected

proc RuntimeError_IncompatibleBlockSize*(functionName: string, got: int, expected: int) =
    panic RuntimeError,
          "cannot perform _" & (functionName) & ";" &
          "incompatible block size: " & $(got) & ";" &
          "expected: " & $(expected)

proc RuntimeError_InvalidOperation*(operation: string, argA, argB: string) =
    panic RuntimeError,
            "invalid operation _" & operation & "_;" &
            (if argB!="": "between: " else: "with: ") & argA & (if argB!="": ";" & "and: " & argB else: "")

proc RuntimeError_CannotConvertQuantity*(val, argA, kindA, argB, kindB: string) =
    panic RuntimeError,
          "cannot convert quantity: " & val & ";" &
          "from: " & argA & " (" & kindA & ") " & ";" &
          "to: " & argB & " (" & kindB & ")"

proc RuntimeError_DivisionByZero*() =
    panic RuntimeError,
            "division by zero"

proc RuntimeError_OutOfBounds*(indx: int, maxRange: int) =
    panic RuntimeError,
          "array index out of bounds: " & $(indx) & ";" & 
          "valid range: 0.." & $(maxRange)

proc RuntimeError_SymbolNotFound*(sym: string, alter: seq[string]) =
    let sep = ";" & repeat("~%",Alternative.len - 2) & "or... "
    panic RuntimeError,
          "symbol not found: " & sym & ";" & 
          "perhaps you meant... " & alter.map((x) => "_" & x & "_ ?").join(sep)

proc RuntimeError_CannotModifyConstant*(sym: string) =
    panic RuntimeError,
          "value points to a readonly constant: " & sym & ";" &
          "which cannot be modified in-place"

proc RuntimeError_FileNotFound*(path: string) =
    panic RuntimeError,
          "file not found: " & path

proc RuntimeError_AliasNotFound*(sym: string) =
    panic RuntimeError,
          "alias not found: " & sym

proc RuntimeError_KeyNotFound*(sym: string, alter: seq[string]) =
    let sep = ";" & repeat("~%",Alternative.len - 2) & "or... "
    panic RuntimeError,
          "dictionary key not found: " & sym & ";" & 
          "perhaps you meant... " & alter.map((x) => "_" & x & "_ ?").join(sep)

proc RuntimeError_CannotStoreKey*(key: string, valueKind: string, storeKind: string) =
    panic RuntimeError,
          "unsupported value type: " & valueKind & ";" &
          "for store of type: " & storeKind & ";" &
          "when storing key: " & key

proc RuntimeError_SqliteDisabled*() =
    panic RuntimeError,
          "SQLite not available in MINI builds;" &
          "if you want to have access to SQLite-related functionality,;" &
          "please, install Arturo's full version"

proc RuntimeError_NotEnoughArguments*(functionName:string, functionArity: int) =
    panic RuntimeError,
          "cannot perform _" & (functionName) & "_;" & 
          "not enough parameters: " & $(functionArity) & " required"

proc RuntimeError_WrongArgumentType*(functionName: string, actual: string, paramPos: string, accepted: string) =
    panic RuntimeError, 
          "cannot perform _" & (functionName) & "_ -> " & actual & ";" &
          "incorrect argument type for " & paramPos & " parameter;" &
          "accepts " & accepted

proc RuntimeError_WrongAttributeType*(functionName: string, attributeName: string, actual: string, accepted: string) =
    panic RuntimeError, 
          "cannot perform _" & (functionName) & "_;" &
          "incorrect attribute type for _" & (attributeName) & "_ -> " & actual & ";" &
          "accepts " & accepted

proc RuntimeError_CannotConvert*(arg,fromType,toType: string) =
    panic RuntimeError,
          "cannot convert argument: " & truncate(arg,20) & ";" &
          "from :" & (fromType).toLowerAscii() & ";" &
          "to   :" & (toType).toLowerAscii()

proc RuntimeError_ConversionFailed*(arg,fromType,toType: string) =
    panic RuntimeError,
          "conversion failed: " & truncate(arg,20) & ";" &
          "from :" & (fromType).toLowerAscii() & ";" &
          "to   :" & (toType).toLowerAscii()

proc RuntimeError_LibraryNotLoaded*(path: string) =
    panic RuntimeError,
          "dynamic library could not be loaded:" & ";" &
          path

proc RuntimeError_LibrarySymbolNotFound*(path: string, sym: string) =
    panic RuntimeError,
          "symbol not found: " & sym & ";" & 
          "in library: " & path

proc RuntimeError_ErrorLoadingLibrarySymbol*(path: string, sym: string) =
    panic RuntimeError,
          "error loading symbol: " & sym & ";" & 
          "from library: " & path

proc RuntimeError_OperationNotPermitted*(operation: string) =
    panic RuntimeError,
          "unsafe operation: " & operation & ";" &
          "not permitted in online playground"
          
proc RuntimeError_StackUnderflow*() =
    panic RuntimeError,
            "stack underflow"

proc RuntimeError_ConfigNotFound*(gkey: string, akey: string) =
    panic RuntimeError,
          "configuration not found for: " & gkey & ";" &
          "you can either supply it globally via `config`;" &
          "or using the option: ." & akey

proc RuntimeError_RangeWithZeroStep*() =
    panic RuntimeError,
          "attribute step can't be 0"


# Program errors

proc ProgramError_panic*(message: string, code: int) =
    panic ProgramError,
          $(code) & "<:>" & message

# TODO Re-establish stack trace debug reports
#  labels: vm, error handling

# var
#     OpStack*    : array[5,OpCode]
#     ConstStack* : ValueArray
# proc getOpStack*(): string =
#     try:
#         var ret = ";;"
#         ret &= (fg(grayColor)).replace(";","%&") & "\b------------------------------;" & resetColor
#         ret &= (fg(grayColor)).replace(";","%&") & "bytecode stack trace:;" & resetColor
#         ret &= (fg(grayColor)).replace(";","%&") & "\b------------------------------;" & resetColor
#         for i in countdown(4,0):
#             let op = (OpCode)(OpStack[i])
#             if op!=opNop :
#                 ret &= (fg(grayColor)).replace(";","%&") & "\b>T@B" & ($(op)).replace("op","").toUpperAscii()
#                 case op:
#                     of opConstI0..opConstI10:
#                         let indx = (int)(op)-(int)opConstI0
#                         if indx>=0 and indx<ConstStack.len:
#                             ret &= " (" & $(ConstStack[indx]) & ")"
#                     of opPush0..opPush30:
#                         let indx = (int)(op)-(int)opPush0
#                         if indx>=0 and indx<ConstStack.len:
#                             ret &= " (" & $(ConstStack[indx]) & ")"
#                     of opStore0..opStore30:
#                         let indx = (int)(op)-(int)opStore0
#                         if indx>=0 and indx<ConstStack.len:
#                             ret &= " (" & $(ConstStack[indx]) & ")"
#                     of opLoad0..opLoad30:
#                         let indx = (int)(op)-(int)opLoad0
#                         if indx>=0 and indx<ConstStack.len:
#                             ret &= " (" & $(ConstStack[indx]) & ")"
#                     of opCall0..opCall30: 
#                         let indx = (int)(op)-(int)opCall0
#                         if indx>=0 and indx<ConstStack.len:
#                             ret &= " (" & $(ConstStack[indx]) & ")"
#                     else:
#                         discard
                
#                 ret &= resetColor
                    
#             if i!=0:
#                 ret &= ";"

#         ret
#     except CatchableError:
#         ""
