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

type
    AppAction = enum
        runAction, consoleAction, helpAction, versionAction, noAction

const
    HELP_TXT = readFile("src/rsrc/help.txt").replace("\\e","\e")

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
                    cmdlineError("console: not supported on 'mini' releases")
            else:
                if fileExists(p.key): 
                    compiler.runScript(p.key,p.remainingArgs,includePath,warnings); done = true
                else: cmdlineError("unrecognized command '" & p.key & "'")

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
                                else:               cmdlineError("run: unrecognized parameter '" & p.key & "'")
                        of cmdArgument: scriptPath = p.key; break
                    

                if scriptPath!="": compiler.runScript(scriptPath,p.remainingArgs,includePath,warnings)
                else: cmdlineError("run: no script specified")

            of consoleAction: 
                p.next()  
                when not defined(mini):
                    if p.kind!=cmdEnd: cmdlineError("console: superfluous arguments given") 
                    else: console.startRepl()
                else:
                    cmdlineError("console: not supported on 'mini' releases")
            of helpAction:   
                p.next()   
                if p.kind!=cmdEnd: cmdlineError("help: superfluous arguments given") 
                else: showHelp(); quit()
            of versionAction:   
                p.next()
                if p.kind!=cmdEnd: cmdlineError("version: superfluous arguments given")
                else: showVersion(); quit()
            else: 
                cmdlineError("no command specified")   

#[****************************************
   This is the end,
   my only friend, the end...
  ****************************************]#