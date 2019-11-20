#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: main.nim
  *****************************************************************]#

when defined(profiler) or defined(memProfiler): 
    import nimprof

import os, parseopt, strutils 
import compiler, console, panic, version

#[######################################################
    Constants
  ======================================================]#

const
    HELP_TXT        = readFile("src/rsrc/help.txt").replace("\\e","\e")
    SUPERFLUOUS     = "superfluous arguments given"


#[######################################################
    Helper functions
  ======================================================]#

template showHelp() =
    showVersion()
    echo HELP_TXT

#[######################################################
    Where all the magic begins...
  ======================================================]#

when isMainModule:
    var scriptPath = ""
    var includePath = ""

    var p = initOptParser(commandLineParams())

    p.next()
    while p.kind!=cmdEnd:
        case p.key
            of "h","help": 
                p.next()
                if p.kind!=cmdEnd or includePath!="" or scriptPath!="":
                    cmdlineError("arturo: " & SUPERFLUOUS)
                else:
                    showHelp()
                    quit(0)
            of "v","version": 
                p.next()
                if p.kind!=cmdEnd or includePath!="" or scriptPath!="":
                    cmdlineError("arturo: " & SUPERFLUOUS)
                else:
                    showVersion()
                    quit(0)
            of "i","include":   
                includePath = p.val
            else:
                scriptPath = p.key
                break

        p.next()

    if scriptPath=="":
        console.startRepl(includePath)
    else:
        compiler.runScript(scriptPath,p.remainingArgs,includePath);

#[****************************************
   This is the end,
   my only friend, the end...
  ****************************************]#