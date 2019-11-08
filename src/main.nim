#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: main.nim
  *****************************************************************]#

when defined(profile) or defined(memProfiler): 
    import nimprof

when not defined(mini): 
    import console

import os, parseopt, strutils 
import compiler, panic, version

#[######################################################
    Type
  ======================================================]#

type
    AppAction = enum
        runAction, consoleAction, 
        helpAction, versionAction, noAction

#[######################################################
    Constants
  ======================================================]#

const
    HELP_TXT        = readFile("src/rsrc/help.txt").replace("\\e","\e")

    MINI_RELEASE    = "not supported on 'mini' releases"
    NO_COMMAND      = "no command specified"
    NO_SCRIPT       = "no script specified"
    SUPERFLUOUS     = "superfluous arguments given"
    UNREC_COMMAND   = "unrecognized command"
    UNREC_PARAM     = "unrecognized parameter"

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
    var warnings = false

    var action = noAction
    var done = false

    var p = initOptParser(commandLineParams(),  shortNoVal = {'w'},
                                                longNoVal = @["warnings"])

    p.next()
    case p.key
        of ":r","run"       : action = runAction
        of ":c","console"   : action = consoleAction
        of ":h","help"      : action = helpAction
        of ":v","version"   : action = versionAction
        else:
            if p.key=="": 
                when not defined(mini):
                    startRepl(); done = true 
                else:
                    cmdlineError("console: " & MINI_RELEASE)
            else:
                if fileExists(p.key): 
                    compiler.runScript(p.key,p.remainingArgs,includePath,warnings); done = true
                else: cmdlineError(UNREC_COMMAND & " '" & p.key & "'")

    if not done:                
        case action
            of runAction:   
                while true:
                    p.next()

                    case p.kind
                        of cmdEnd: break
                        of cmdShortOption, cmdLongOption:
                            case p.key
                                of "i","include":   includePath = p.val
                                of "w","warnings":  warnings = true
                                else:               cmdlineError("run: " & UNREC_PARAM & " '" & p.key & "'")
                        of cmdArgument: scriptPath = p.key; break
                    

                if scriptPath!="": compiler.runScript(scriptPath,p.remainingArgs,includePath,warnings)
                else: cmdlineError("run: " & NO_SCRIPT)

            of consoleAction: 
                p.next()  
                when not defined(mini):
                    if p.kind!=cmdEnd: cmdlineError("console: " & SUPERFLUOUS) 
                    else: console.startRepl()
                else:
                    cmdlineError("console: " & MINI_RELEASE)
            of helpAction:   
                p.next()   
                if p.kind!=cmdEnd: cmdlineError("help: " & SUPERFLUOUS) 
                else: showHelp(); quit()
            of versionAction:   
                p.next()
                if p.kind!=cmdEnd: cmdlineError("version: " & SUPERFLUOUS)
                else: showVersion(); quit()
            else: 
                cmdlineError(NO_COMMAND)   

#[****************************************
   This is the end,
   my only friend, the end...
  ****************************************]#