#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: compiler.nim
  *****************************************************************]#

import os

import panic

#[========================================
   C interface
  ========================================]#

proc yyparse(): cint {.importc.}
proc yy_scan_buffer(buff:cstring, s:csize) {.importc.}

var yyfilename {.importc.}: cstring
var yyin {.importc.}: File
var yylineno {.importc.}: cint

#[========================================
   Methods
  ========================================]#

proc runScript*(scriptPath:string, includePath:string, warnings:bool) = 
    if not fileExists(scriptPath): 
        cmdlineError("path not found: '" & scriptPath & "'")

    yylineno = 0
    yyfilename = scriptPath

    let success = open(yyin, scriptPath)
    if not (success): 
        cmdlineError("something went wrong when opening file")

    discard yyparse()
