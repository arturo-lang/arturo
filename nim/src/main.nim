#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: main.nim
  *****************************************************************]#

import os
import parseopt
import strutils 

when defined(profile): import nimprof

import ast/id
import compiler
import console
import panic

type
    AppAction = enum
        runAction, consoleAction, helpAction, versionAction, noAction

const 
    ART_VERSION     = "0.3.9"
    ART_BUILD       = readFile("../source/resources/build.txt").strip
    ART_BUILD_DATE  = readFile("../source/resources/build_date.txt").strip

#[========================================
   Helper functions
  ========================================]#

template showHelp() = 
    const helpTxt = readFile("src/rsrc/help.txt").replace("\\e","\e")
    showVersion()
    echo helpTxt

template showVersion() = 
    const vers = "\x1B[32m\x1B[1mArturo " & ART_VERSION & "\x1B[0m (" & ART_BUILD_DATE & " build " & ART_BUILD & ") [" & hostCPU & "-" & hostOS & "]"
    echo vers
    echo "(c) 2019 Yanis Zafirópulos\n"

#[========================================
   Where all the magic begins...
  ========================================]#

when isMainModule:
    var scriptPath = ""
    var includePath = ""
    var warnings = false

    var action = noAction

    var p = initOptParser(commandLineParams(),  shortNoVal = {'w'},
                                                longNoVal = @["warnings"])

    p.next()
    case p.key
        of ":r","run"       : action = runAction
        of ":c","console"   : action = consoleAction
        of ":h","help"      : action = helpAction
        of ":v","version"   : action = versionAction
        else                : 
            if p.key!="": cmdlineError("unrecognized command '" & p.key & "'")
            else: cmdlineError("no command specified") 

    p.next()
    case action
        of runAction:   
            while true:
                case p.kind
                    of cmdEnd: break
                    of cmdShortOption, cmdLongOption:
                        case p.key
                            of "i","include":   includePath = p.val
                            of "w","warnings":  warnings = true
                            else:               cmdlineError("run: unrecognized parameter '" & p.key & "'")
                    of cmdArgument: scriptPath = p.key
                p.next()

            if scriptPath!="": compiler.runScript(scriptPath,includePath,warnings)
            else: cmdlineError("run: no script specified")

        of consoleAction:   
            if p.kind!=cmdEnd: cmdlineError("console: superfluous arguments given") 
            else: console.startRepl()
        of helpAction:      
            if p.kind!=cmdEnd: cmdlineError("help: superfluous arguments given") 
            else: showHelp(); quit()
        of versionAction:   
            if p.kind!=cmdEnd: cmdlineError("version: superfluous arguments given")
            else: showVersion(); quit()
        else: 
            cmdlineError("no command specified")   

#[****************************************
   This is the end,
   my only friend, the end...
  ****************************************]#