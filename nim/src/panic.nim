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

    PARSE_ERROR   = "✘ \x1B[4;1;35mParse Error\x1B[0;37m | "
    PARSE_PAD     = "              | "

#[========================================
   C interface
  ========================================]#

proc parseError*(msg:cstring, filename:cstring, line:cint) {.exportc.} =
    echo PARSE_ERROR & "file: " & $filename & " - line: " & $line
    echo PARSE_PAD & $msg
    echo ""
    quit()

#[========================================
   Methods
  ========================================]#

proc cmdlineError*(msg:string, showHelp:bool=true) = 
    echo CMDLINE_ERROR & msg
    if showHelp: echo CMDLINE_HELP
    echo ""
    quit()


