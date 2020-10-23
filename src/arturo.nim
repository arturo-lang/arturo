######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: arturo.nim
######################################################

#=======================================
# Libraries
#=======================================

import os, parseopt, segFaults, strutils

when defined(PROFILE):
    import nimprof

import translator/eval, translator/parse
import vm/env, vm/exec, vm/value

when defined(BENCHMARK):
    import strutils
    import utils

#=======================================
# Constants
#=======================================

const 
    Version = static readFile("version/version").strip()
    Build = static readFile("version/build").strip()

#=======================================
# Types
#=======================================

type
    CmdAction = enum
        execFile
        evalCode
        showHelp
        showVersion

#=======================================
# Globals
#=======================================

let versionTxt = "arturo v/" & Version

let helpTxt = """

Usage:
  arturo [options] <path>

Options:
  -e --evaluate             Evaluate given code
  -c --console              Show repl / interactive console

  -u --update               Update to latest version

  -m --module           
        list                List all available modules
        remote              List all available remote modules
        info <name>         Get info about given module
        install <name>      Install remote module by name
        uninstall <name>    Uninstall module by name
        update              Update all local modules

  -h --help                 Show this help screen
  -v --version              Show current version
"""
    
#=======================================
# Main entry
#=======================================

when isMainModule:

    var token = initOptParser()

    var action: CmdAction = evalCode
    var runConsole  = static readFile("src/system/console.art")
    var runUpdate   = static readFile("src/system/update.art")
    var runModule   = static readFile("src/system/module.art")
    var code: string = ""
    var arguments: ValueArray = @[]

    while true:
        token.next()
        case token.kind:
            of cmdArgument: 
                if code=="":
                    action = execFile
                    code = token.key
                else:
                    arguments.add(newString(token.key))
            of cmdShortOption, cmdLongOption:
                case token.key:
                    of "c","console":
                        action = evalCode
                        code = runConsole
                    of "e","evaluate":
                        action = evalCode
                        code = token.val
                    of "u","update":
                        action = evalCode
                        code = runUpdate
                    of "m", "module":
                        action = evalCode
                        code = runModule
                    of "h","help":
                        action = showHelp
                    of "v","version":
                        action = showVersion
                    else:
                        echo "error: unrecognized option (" & token.key & ")"
            of cmdEnd: break

    case action:
        of execFile, evalCode:
            if code=="":
                code = runConsole

            when defined(BENCHMARK):
                benchmark "doParse / doEval":
                    let parsed = doParse(move code, isFile = action==execFile)
                    let evaled = parsed.doEval()
            else:
                initEnv(
                    arguments = arguments, 
                    version = Version,
                    build = Build
                )
                if action==execFile:
                    env.addPath(code)
                else:
                    env.addPath(getCurrentDir())

                var presets = getEnvDictionary()

                let parsed = doParse(move code, isFile = action==execFile)
                let evaled = parsed.doEval()
                initVM()
                discard doExec(evaled, withSyms=addr presets)

                showVMErrors()
        of showHelp:
            echo helpTxt
        of showVersion:
            echo versionTxt
