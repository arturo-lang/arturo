#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: panic.nim
  *****************************************************************]#

const 
    CMDLINE_ERROR   = "✘ \x1B[4;1;35mCmdLine Error\x1B[0;37m | "
    CMDLINE_HELP    = "                | try `arturo help` for more information."

    PARSE_ERROR     = "✘ \x1B[4;1;35mParse Error\x1B[0;37m | "
    PARSE_PAD       = "              | "

    CONSOLE_ERROR   = "✘ \x1B[4;1;35mConsole Error\x1B[0;37m | "
    CONSOLE_HELP    = "                | try `?help` for more information."

#[######################################################
    Methods
  ======================================================]#

proc parseError*(msg:cstring, filename:cstring, line:cint) {.exportc.} =
    echo PARSE_ERROR & "file: " & $filename & " - line: " & $line
    echo PARSE_PAD & $msg
    echo ""
    quit()

proc cmdlineError*(msg:string, showHelp:bool=true) = 
    echo CMDLINE_ERROR & msg
    if showHelp: echo CMDLINE_HELP
    echo ""
    quit()

proc consoleError*(msg:string, showHelp:bool=true) = 
    echo CONSOLE_ERROR & msg
    if showHelp: echo CONSOLE_HELP
    echo ""
