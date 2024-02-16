#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: vm/errors.nim
#=======================================================

## Error handling for the VM.

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import re, terminal
import sequtils, strformat, strutils, sugar, std/with

import helpers/strings
import helpers/terminal

import vm/values/custom/verror

#=======================================
# Types
#=======================================

type
    ReturnTriggered*    = ref object of Defect
    BreakTriggered*     = ref object of Defect
    ContinueTriggered*  = ref object of Defect

#=======================================
# Constants
#=======================================

const
    MaxIntSupported     = $(sizeof(int) * 8)
    ReplContext         = " <repl> "

    UseUnicodeChars     = true

    HorizLine           = when UseUnicodeChars: "\u2550" else: "="
    VertLine            = when UseUnicodeChars: "\u2503" else: "|"
    VertLineD           = when UseUnicodeChars: "\u2551" else: "|"
    ArrowRight          = when UseUnicodeChars: "\u25ba" else: ">"
    LeftBracket         = when UseUnicodeChars: "\u2561" else: "["
    RightBracket        = when UseUnicodeChars: "\u255E" else: "]"

#=======================================
# Variables
#=======================================

var
    CurrentContext* : string    = ReplContext
    CurrentPath*    : string    = ""
    CurrentLine*    : int       = 0
    ExecStack*      : seq[int]  = @[]

#=======================================
# Helpers
#=======================================

# Check environment

proc isRepl(): bool =
    return CurrentContext == ReplContext

proc getCurrentContext(e: VError): string =
    if e.kind == CmdlineErr: return ""

    if CurrentContext == ReplContext: return CurrentContext
    return " <script> "

# General formatting

proc processPseudomarkdown(s: string): string =
    result = s.replacef(re"_([^_]+)_",fmt("{bold()}$1{resetColor}"))

proc formatMessage(s: string): string =
    var ret = s.processPseudomarkdown()
               #.replacef(re":([a-z]+)",fmt("{fg(magentaColor)}:$1{resetColor}"))

    ret = indent(strip(dedent(ret)), 2)

    return ret

proc lineTrunc(s: string, padding: int): string =
    let lines = s.splitLines()
    if lines.len > 5:
        result = lines[0..4].join("\n")
        result &= "\n" & fg(grayColor) & "..." & resetColor()
        result = strip(result)
    else:
        result = s
    
    result = indent(result, padding)

proc `~~`*(s: string, inputs: seq[string]): string =
    var replacements: seq[string]
    var finalS = s
    for line in s.splitLines():
        for found in line.findAll(re"\$[\$#]"):
            if found=="$$":
                let ind = line.realFind("$$")
                replacements.add(strip(lineTrunc(strip(inputs[replacements.len]),ind)))
            else:
                replacements.add(inputs[replacements.len])
    
    finalS = finalS.replace("$$", "$#")
    return finalS % replacements    

# Error messages

proc printErrorHeader(e: VError) =
    let preHeader = 
        fg(redColor) & "{HorizLine}{HorizLine}{LeftBracket} ".fmt & 
        bold(redColor) & (e.kind.label) & 
        fg(redColor) & " {RightBracket}".fmt

    let postHeader = 
        getCurrentContext(e) & 
        "{HorizLine}{HorizLine}".fmt & 
        resetColor()

    let middleStretch = terminalWidth() - preHeader.realLen() - postHeader.realLen()

    echo ""
    echo preHeader & repeat(HorizLine, middleStretch) & postHeader

proc printErrorKindDescription(e: VError) =
    if e.kind.description != "":
        echo ""
        echo indent(e.kind.description, 2) & resetColor

proc printErrorMessage(e: VError) =
    echo ""
    echo strip(indent(dedent(formatMessage(e.msg)), 2), chars={'\n'})

proc printCodePreview(e: VError) =
    when not defined(NOERRORLINES):
        if (not isRepl()) and (e.kind != CmdlineErr) and (e.kind != ProgramErr) :
            echo ""
            let codeLines = readFile(CurrentPath).splitLines()
            const linesBeforeAfter = 2
            let lineFrom = max(0, CurrentLine - (linesBeforeAfter+1))
            let lineTo = min(len(codeLines)-1, CurrentLine + (linesBeforeAfter-1))
            echo "  " & fg(grayColor) & "{VertLine} ".fmt & bold(grayColor) & "File: " & fg(grayColor) & CurrentPath
            echo "  " & fg(grayColor) & "{VertLine} ".fmt & bold(grayColor) & "Line: " & fg(grayColor) & $(CurrentLine)
            echo "  " & fg(grayColor) & "{VertLine} ".fmt & resetColor
            for lineNo in lineFrom..lineTo:
                var line = codeLines[lineNo]
                var pointerArrow = "{VertLineD} ".fmt
                var lineNum = $(lineNo+1)
                var lineNumPre = ""
                var lineNumPost = ""
                if lineNo == CurrentLine-1: 
                    pointerArrow = "{VertLineD}".fmt & fg(redColor) & "{ArrowRight}".fmt & fg(grayColor)
                    line = bold(grayColor) & line & fg(grayColor)
                    lineNumPre = bold(grayColor)
                    lineNumPost = fg(grayColor)
                echo "  " & fg(grayColor) & "{VertLine} ".fmt & lineNumPre & align(lineNum,4) & lineNumPost & " {pointerArrow} ".fmt & line & resetColor

proc printHint(e: VError) =
    if e.hint != "":
        let wrappingWidth = min(100, int(0.8 * float(terminalWidth() - 2 - 6)))
        let hinter = "  " & "\e[4;97m" & "Hint" & resetColor() & ": "
        echo ""
        if e.hint.contains("\n"):
            echo (hinter & "$$") ~~ @[e.hint.processPseudomarkdown()]
        else:
            echo hinter & wrapped(strip(dedent(e.hint)).splitLines().join(" "), wrappingWidth, delim="\n        ")

#=======================================
# Methods
#=======================================

proc showError*(e: VError) =
    with e:
        printErrorHeader()
        printErrorKindDescription()
        printErrorMessage()
        printCodePreview()
        printHint()
    
    if (not isRepl()) or e.hint=="":
        echo ""

proc panic(error: VError) =
    if error.kind == CmdlineErr:
        showError(error)
        quit(1)
    else:
        raise error

#=======================================
# Constructors
#=======================================

#------------------------
# Command-line Errors
#------------------------

proc Error_ScriptNotExists*(name: string) =
    panic:
        toError CmdlineErr, """
            Given script doesn't exist:
                _$#_
        """ ~~ @[name]

proc Error_UnrecognizedOption*(name: string) =
    panic:
        toError CmdlineErr, """
            Unrecognized command-line option:
                _$#_
        """ ~~ @[name]

proc Error_UnrecognizedPackageCommand*(name: string) =
    panic:
        toError CmdlineErr, """
            Unrecognized _package_ command:
                _$#_
        """ ~~ @[name]

proc Error_NoPackageCommand*() =
    panic:
        toError CmdlineErr, """
            No _package_ command command given -
            have a look at the options below
        """

proc Error_ExtraneousParameter*(subcmd: string, name: string) =
    panic: 
        toError CmdlineErr, """
            Extraneous parameter for _$#_:
                $#
        """ ~~ @[subcmd, name]

proc Error_NotEnoughParameters*(name: string) =
    panic:
        toError CmdlineErr, """
            Not enough parameters for _$#_ -
            consult the help screen below
        """ ~~ @[name]

#------------------------
# Package Errors
#------------------------

proc Error_PackageNotFound*(pkg: string) =
    panic:
        toError PackageErr, """
            Package not found:
                _$#_
        """ ~~ @[pkg]

proc Error_PackageRepoNotCorrect*(repo: string) =
    panic:
        toError PackageErr, """
            Package repository url not correct:
                $#
        """ ~~ @[repo]

proc Error_PackageRepoNotFound*(repo: string) =
    panic:
        toError PackageErr, """
            Package repository not found:
                $#
        """ ~~ @[repo]

proc Error_CorruptRemoteSpec*(pkg: string) =
    panic:
        toError PackageErr, """
            Corrupt spec file for remote package:
                _$#_
        """ ~~ @[pkg]

proc Error_PackageNotValid*(pkg: string) =
    panic:
        toError PackageErr, """
            Invalid package:
                _$#_
        """ ~~ @[pkg]

proc Error_PackageUnknownError*(pkg: string) =
    panic:
        toError PackageErr, """
            Unexpected error while installing package:
                _$#_
        """ ~~ @[pkg]

proc Error_PackageInvalidVersion*(vers: string) =
    panic:
        toError PackageErr, """
            Error parsing package version:
                _$#_
        """ ~~ @[vers]

#------------------------
# Conversion Errors
#------------------------

proc Error_CannotConvert*(arg,fromType,toType: string) =
    panic:
        toError ConversionErr, """
            Got value:
                $$

            Conversion to given type is not supported:
                :$#
        """ ~~ @[arg, toType.toLowerAscii()]

proc Error_ConversionFailed*(arg,fromType,toType: string, hint: string="") =
    panic:
        toError ConversionErr, """
            Got value:
                $$

            Failed while trying to convert to:
                :$#
        """ ~~ @[arg, toType.toLowerAscii()], hint
          
proc Error_CannotConvertDifferentDimensions*(convFrom, convTo: string) =
    panic:
        toError ConversionErr, """
            Trying to convert quantity with property:
                $#

            To:
                $#
        """ ~~ @[convFrom, convTo]

#------------------------
# Syntax Errors
#------------------------

proc Error_MissingClosingSquareBracket*(lineno: int) =
    CurrentLine = lineno
    panic:
        toError SyntaxErr, """
            Issue found when trying to parse:
                Block

            Missing:
                closing square bracket (`]`)
        """ ~~ @[]

proc Error_MissingClosingParenthesis*(lineno: int) =
    CurrentLine = lineno
    panic:
        toError SyntaxErr, """
            Issue found when trying to parse:
                Inline

            Missing:
                closing parenthesis (`)`)
        """ ~~ @[]

proc Error_StrayClosingSquareBracket*(lineno: int) =
    CurrentLine = lineno
    panic:
        toError SyntaxErr, """
            Found extraneous block symbol:
                closing square bracket (`]`)
        """ ~~ @[]

proc Error_StrayClosingCurlyBracket*(lineno: int) =
    CurrentLine = lineno
    panic: 
        toError SyntaxErr, """
            Found extraneous block symbol:
                closing curly bracket (`}`)
        """ ~~ @[]

proc Error_StrayClosingParenthesis*(lineno: int) =
    CurrentLine = lineno
    panic:
        toError SyntaxErr, """
            Found extraneous block symbol:
                closing parenthesis (`)`)
        """ ~~ @[]

proc Error_UnterminatedString*(strtype: string, lineno: int) =
    var strt = strtype
    if strt!="": strt &= " "
    var missing: string
    if strt=="":
        missing = "closing double quote (`\"`)"
    elif strt=="verbatim":
        missing = "closing color-bracket (`:}`)"
    else:
        missing = "closing curly bracket (`}`)"
    CurrentLine = lineno
    panic:
        toError SyntaxErr, """
            Issue found when trying to parse:
                String

            Missing:
                $$
        """ ~~ @[missing]

proc Error_NewlineInQuotedString*(lineno: int) =
    CurrentLine = lineno
    panic:
        toError SyntaxErr, """
            Issue found when trying to parse:
                String
            
            Quoted string contains:
                newline (`\n`)
        """ ~~ @[], "For multiline strings, you could use either: curly blocks `{..}` or triple `-` templates"

#------------------------
# Assertion Errors
#------------------------

proc Error_AssertionFailed*(context: string) =
    panic:
        toError AssertionErr, """
            Tried:
                $$
        """ ~~ @[context]
          
proc Error_AssertionFailed*(context: string, message: string) =
    panic: 
        toError AssertionErr, """
            Unable to ensure:
                $$

            Tried: 
                $$
        """ ~~ @[message, context]

#------------------------
# Arithmetic Errors
#------------------------

proc Error_IntegerParsingOverflow*(lineno: int, number: string) =
    CurrentLine = lineno
    let hint = "Up to $#-bit integers supported" ~~ @[MaxIntSupported]
    panic: 
        toError ArithmeticErr, """
            Couldn't parse Integer value

            From value: 
                $$
        """ ~~ @[number], hint

proc Error_IntegerOperationOverflow*(operation: string, argA, argB: string) =
    let hint = "Up to $#-bit integers supported" ~~ @[MaxIntSupported]
    panic: 
        toError ArithmeticErr, """
            Number operation overflow
            
            Attempted operation: 
                _$#_
            
            Between: 
                $$

            And:
                $$
        """ ~~ @[operation, argA, argB], hint

proc Error_IntegerSingleOperationOverflow*(operation: string, arg: string) =
    let hint = "Up to $#-bit integers supported" ~~ @[MaxIntSupported]
    panic: 
        toError ArithmeticErr, """
            Number operation overflow
            
            Attempted operation: 
                _$#_
            
            With: 
                $$
        """ ~~ @[operation, arg], hint

proc Error_NumberOutOfSupportedRange*(operation: string, arg: string) =
    let hint = "Up to $#-bit integers supported" ~~ @[MaxIntSupported]
    panic: 
        toError ArithmeticErr, """
            Number operator out of valid range

            Attempted operation: 
                _$#_
            
            With: 
                $$
        """ ~~ @[operation, arg], hint

proc Error_DivisionByZero*(arg: string) =
    panic:
        toError ArithmeticErr, """
            Division by zero

            With value:
                $$
        """ ~~ @[arg]
#------------------------
# Index Errors
#------------------------

proc Error_InvalidIndex*(indx: int, value: string, hint: string = "") =
    panic:
        toError IndexErr, """
            Invalid index: 
                $$

            For value:
                $$
        """ ~~ @[$indx, value], hint

proc Error_InvalidKey*(key: string, value: string, hint: string = "") =
    panic:
        toError IndexErr, """
            Invalid key: 
                $$

            For value:
                $$
        """ ~~ @[key, value], hint

proc Error_OutOfBounds*(indx: int, value: string, maxRange: int, what: string = "Block") =
    var items = 
        if what=="String": "characters" 
        else: "items"

    let hint = """Given $# contains $# $#; so, a valid index should fall within 0..$#""" ~~ @[what, $(maxRange+1), items, $(maxRange)]
    panic:
        toError IndexErr, """
            Index out of bounds: 
                $$

            For value:
                $$
        """ ~~ @[$indx, value], hint

proc Error_KeyNotFound*(sym: string, collection: string, alter: seq[string]) =
    let sep = "\n" & "\b\b\b\b\b\bor... "
    let hint = "Perhaps you meant... $$" ~~ @[alter.map((x) => "_" & x & "_ ?").join(sep)]
    panic:
        toError IndexErr, """
            Key not found: 
                $#

            For value:
                $$
        """ ~~ @[sym, collection], hint

proc Error_UnsupportedKeyType*(keyType: string, value: string, expectedTypes: seq[string]) =
    let expected = expectedTypes.join(", ")
    let plural = 
        if expectedTypes.len > 1: "s"
        else: ""
    panic:
        toError IndexErr, """
            Unsupported key: 
                $$

            For value:
                $$

            Expected type$#:
                $$
        """ ~~ @[keyType, value, plural, expected]
#------------------------
# System Errors
#------------------------

proc Error_FileNotFound*(path: string) =
    panic:
        toError SystemErr, """
            File not found: 
                $#
        """ ~~ @[path], errCode=ENOENT

#------------------------
# VM Errors
#------------------------

proc Error_StackUnderflow*() =
    panic:
        toError VMErr, """
            Stack underflow
        """

proc Error_ConfigNotFound*(gkey: string, akey: string) =
    panic:
        toError VMErr, """
            Configuration not found for: $#
            you can either supply it globally via `config`
            or using the option: .$#
        """ ~~ @[gkey, akey]

proc Error_OperationNotPermitted*(operation: string) =
    panic:
        toError VMErr, """
            Unsafe operation: $#
            not permitted in online playground
        """ ~~ @[operation]

#------------------------
# UI Errors
#------------------------

proc Error_CompatibleBrowserNotFound*() =
    panic:
        toError UIErr, """
            Could not find any Chrome-compatible browser installed
        """
          
proc Error_CompatibleBrowserCouldNotOpenWindow*() =
    panic:
        toError UIErr, """
            Could not open a Chrome-compatible browser window
        """

#------------------------
# Name Errors
#------------------------

proc Error_SymbolNotFound*(sym: string, alter: seq[string]) =
    let sep = "\n" & "\b\b\b\b\b\bor... "
    let hint = "Perhaps you meant... $$" ~~ @[alter.map((x) => "_" & x & "_ ?").join(sep)]
    panic:
        toError NameErr, """
            Identifier not found: 
                _$#_
        """ ~~ @[sym], hint

proc Error_AliasNotFound*(sym: string) =
    panic: 
        toError NameErr, """
            Alias not found: 
                _$#_
        """ ~~ @[sym]

#------------------------
# Value Errors
#------------------------

proc Error_CannotModifyConstant*(sym: string) =
    panic:
        toError ValueErr, """
            Readonly constants cannot be modified in-place

            Received: 
                $#
            
        """ ~~ @[sym]

proc Error_PathLiteralMofifyingString*() =
    panic:
        toError ValueErr, """ 
            In-place modification of strings
            through PathLiteral values is not supported
        """

proc Error_IncompatibleBlockSize*(functionName: string, got: int, expected: string) =
    panic: 
        toError ValueErr, """
            Cannot perform:
                _$#_

            Incompatible block size: 
                $#

            Expected: 
                $#
        """ ~~ @[functionName, $got, expected]

proc Error_NotEnoughArguments*(functionName:string, functionArity: int) =
    panic:
        toError ValueErr, """
            Not enough parameters

            Cannot perform:
                _$#_
            
            Required: 
                $#
        """ ~~ @[functionName, $functionArity]

proc Error_RangeWithZeroStep*() =
    panic:
        toError ValueErr, """
            Problem when creating Range

            Attribute step can't be 0!
        """

proc Error_IncorrectNumberOfArgumentsForInitializer*(typeName: string, got: int, expected: seq[string]) =
    panic:
        toError ValueErr, """
            Cannot initialize object of type: 
                _:$#_
            
            Wrong number of parameters: 
                $#
            
            Expected: 
                $# $#
        """ ~~ @[typeName, $got, $(expected.len), expected.join(", ")]

proc Error_MissingArgumentForInitializer*(typeName: string, missing: string) =
    panic:
        toError ValueErr, """
            Cannot initialize object of type:
                _:$#_
            
            Missing field: 
                $#
        """ ~~ @[typeName, missing]

proc Error_IncompatibleQuantityOperation*(operation: string, argA, argB, kindA, kindB: string) =
    panic: 
        toError ValueErr, """
            Incompatible operation between quantities

            Attempted: 
                $#
            
            With: 
                $#
        """ ~~ @[operation, truncate(argA & " (" & kindA & ") " & argB & " (" & kindB & ")", 60)]

#------------------------
# Type Errors
#------------------------

proc Error_IncompatibleValueType*(functionName: string, tp: string, expected: string) =
    panic: 
        toError TypeErr, """
            Cannot perform _$#_
            Incompatible value type for $#
            Expected $#
        """ ~~ @[functionName, tp, expected]

proc Error_IncompatibleBlockValue*(functionName: string, val: string, expected: string) =
    panic: 
        toError TypeErr, """
            Cannot perform _$#_ -> $#
            Incompatible value inside block parameter
            Expected $#
        """ ~~ @[functionName, val, expected]

proc Error_IncompatibleBlockValueAttribute*(functionName: string, attributeName: string, val: string, expected: string) =
    panic: 
        toError TypeErr, """
            Cannot perform _$#_
            Incompatible value inside block for _$#_ -> $#
            Accepts $#
        """ ~~ @[functionName, attributeName, val, expected]

proc Error_UsingUndefinedType*(typeName: string) =
    panic: 
        toError TypeErr, """
            Undefined or unknown type:
                _:$#_
        """ ~~ @[typeName], "Before using it, you should make sure it has been properly initialized using `define`"

proc Error_UnsupportedParentType*(typeName: string) =
    panic:
        toError TypeErr, """
            Subtyping built-in type _:$#_
            is not supported
        """ ~~ @[typeName]

proc Error_WrongArgumentType*(functionName: string, actual: string, val: string, paramPos: string, accepted: string) =
    panic:
        toError TypeErr, """
            Cannot call function:
                _$#_ $$

            Wrong argument (at position $#): 
                $$

            Expected: 
                $#
        """ ~~ @[functionName, actual, paramPos, val, accepted]

proc Error_WrongAttributeType*(functionName: string, attributeName: string, val: string, accepted: string) =
    panic:
        toError TypeErr, """
            Cannot call function:
                _$#_ $$

            Wrong attribute value: 
                $$

            Expected: 
                $#
        """ ~~ @[functionName, attributeName, val, accepted]

proc Error_CannotStoreKey*(key: string, valueKind: string, storeKind: string) =
    panic:
        toError TypeErr, """
            Unsupported value type: $#
            For store of type: $#
            When storing key: $#
        """ ~~ @[valueKind, storeKind, key]

proc Error_InvalidOperation*(operation: string, argA, argB: string) =
    if argB != "":
        panic:
            toError TypeErr, """
                Invalid operation _$#_
                Between: $#
                    and: $#
            """ ~~ @[operation, argA, argB]
    else:
        panic:
            toError TypeErr, """
                Invalid operation _$#_
                With: $#
            """ ~~ @[operation, argA, argB]

#------------------------
# Library Errors
#------------------------

proc Error_SqliteDisabled*() =
    panic:
        toError LibraryErr, """
            SQLite not available in MINI builds
            if you want to have access to SQLite-related functionality,
            please, install Arturo's full version
        """

proc Error_LibraryNotLoaded*(path: string) =
    panic:
        toError LibraryErr, """
            Dynamic library could not be loaded:
                $#
        """ ~~ @[path]

proc Error_LibrarySymbolNotFound*(path: string, sym: string) =
    panic:
        toError LibraryErr, """
            Symbol not found: 
                $#
            
            In library: 
                $#
        """ ~~ @[sym, path]

proc Error_ErrorLoadingLibrarySymbol*(path: string, sym: string) =
    panic:
        toError LibraryErr, """
            Error loading symbol: 
                $#
            
            From library: 
                $#
        """ ~~ @[sym, path]

# Program errors

proc ProgramError_panic*(message: string, code: int) =
    panic:
        toError ProgramErr, message, errCode=code

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


# proc showVMErrors*(e: ref Exception) =
#     ## show error message
#     var header: string
#     var errorKind: VErrorKind = RuntimeErr
#     try:
#         header = $(e.name)

#         # try:
#         #     # try checking if it's a valid error context
#         #     errorKind = parseEnum[VMErrorKind](header)
#         # except ValueError:
#         #     # if not, show it as an uncaught runtime exception
#         #     e.msg = getLineError() & "uncaught system exception:;" & e.msg
#         #     header = $(RuntimeError)

            
#         # if $(header) notin [RuntimeErr, AssertionErr, SyntaxErr, ProgramError, CompilerErr]:
#         #     e.msg = getLineError() & "uncaught system exception:;" & e.msg
#         #     header = RuntimeErr
#     except CatchableError:
#         header = "HEADER"

#     let marker = ">>"
#     let separator = "|"
#     let indent = repeat(" ", header.len + marker.len + 2)

#     when not defined(WEB):
#         var message: string
        
#         if errorKind==ProgramErr:
#             let liner = e.msg.split("<:>")[0].split("\n\n")[0]
#             let msg = e.msg.split("<:>")[1]
#             message = liner & "\n\n" & msg.replacef(re"_([^_]+)_",fmt("{bold()}$1{resetColor}"))
#         else:
#             message = e.msg.replacef(re"_([^_]+)_",fmt("{bold()}$1{resetColor}"))
#     else:
#         var message = "MESSAGE"

#     let errMsgParts = message.strip().splitLines().map((x)=>(strutils.strip(x)).replace("~%"," ").replace("%&",";").replace("T@B","\t"))
#     let alignedError = align("error", header.len)
    
#     var errMsg = errMsgParts[0] & fmt("\n{bold(redColor)}{repeat(' ',marker.len)} {alignedError} {separator}{resetColor} ")

#     if errMsgParts.len > 1:
#         errMsg &= errMsgParts[1..^1].join(fmt("\n{indent}{bold(redColor)}{separator}{resetColor} "))
#     echo fmt("{bold(redColor)}{marker} {header} {separator}{resetColor} {errMsg}")
