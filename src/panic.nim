#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: panic.nim
  *****************************************************************]#

import strutils

const 
    CMDLINE_ERROR   = "✘ \x1B[4;1;35mCmdLine Error\x1B[0;37m | "
    CMDLINE_HELP    = "                | try `arturo --help` for more information."

    RUNTIME_ERROR   = "✘ \x1B[4;1;35mRuntime Error\x1B[0;37m @ "
    RUNTIME_PAD     = "                | "

    PARSE_ERROR     = "✘ \x1B[4;1;35mParse Error\x1B[0;37m | "
    PARSE_PAD       = "              | "

    CONSOLE_ERROR   = "✘ \x1B[4;1;35mConsole Error\x1B[0;37m | "
    CONSOLE_HELP    = "                | try `?help` for more information."

var
    QuitOnError*: bool

#[######################################################
    Methods
  ======================================================]#

proc runtimeError*(msg:string, filename:string="", line:int=0) {.exportc.} =
    echo RUNTIME_ERROR & "file: " & $filename & " - line: " & $line
    echo RUNTIME_PAD & $msg.split("\n").join("\n" & RUNTIME_PAD)
    echo ""
    if QuitOnError: quit()

proc parseError*(msg:cstring, filename:cstring, line:cint) {.exportc.} =
    echo PARSE_ERROR & "file: " & $filename & " - line: " & $line
    echo PARSE_PAD & $msg
    echo ""
    if QuitOnError: quit()

proc cmdlineError*(msg:string, showHelp:bool=true) = 
    echo CMDLINE_ERROR & msg
    if showHelp: echo CMDLINE_HELP
    echo ""
    quit()

proc consoleError*(msg:string, showHelp:bool=true) = 
    echo CONSOLE_ERROR & msg
    if showHelp: echo CONSOLE_HELP
    echo ""

#[######################################################
    Templates
  ======================================================]#

template NotComparableError*(l: int, r: int) =
    raise newException(Exception,"cannot compare arguments\n" &
                 "lValue: " & valueKindToPrintable(l) & "\n" &
                 "rValue: " & valueKindToPrintable(r))

template InvalidOperationError*(op: string, l: int, r: int) =
    raise newException(Exception,"invalid arguments for operator '" & op & "'\n" &
                 "lValue: " & valueKindToPrintable(l) & "\n" &
                 "rValue: " & valueKindToPrintable(r))

template SymbolNotFoundError*(s: string) =
    raise newException(Exception,"symbol not found: '" & s & "'")

template FunctionNotFoundError*(s: string) =
    raise newException(Exception,"function not found: '" & s & "'")

template IncorrectArgumentNumberError*(f: string) =
    raise newException(Exception,"incorrect number of arguments for function '" & f & "'")

template IncorrectArgumentValuesError*(no: int, f: string, e: int, g: int) =
    raise newException(Exception,"incorrect argument [" & $no & "] for function '" & f & "'\n" &
                 "expected: " & valueKindsToPrintable(e) & "\n" &
                 "got: " & valueKindToPrintable(g))

template IncorrectInPlaceArgumentsError*(no: int, f: string, g: int) =
    raise newException(Exception,"incorrect argument [" & $no & "] for in-place function '" & f & "'\n" &
                 "expected: identifier\n" &
                 "got: " & valueKindToPrintable(g))

template ProgramPanic*(msg: string) =
    raise newException(Exception,"program panic\n" &
                 "msg: " & msg)
