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

when defined(PROFILE):
    import nimprof

import os, parseopt, segFaults

import translator/eval, translator/parse
import vm/bytecode, vm/env, vm/exec, vm/value
import version

when defined(BENCHMARK):
    import utils

#=======================================
# Types
#=======================================

type
    CmdAction = enum
        execFile
        evalCode
        readBcode
        writeBcode
        showHelp
        showVersion

#=======================================
# Globals
#=======================================

let helpTxt = """

Usage:
  arturo [options] <path>

Options:
  -e --evaluate             Evaluate given code
  -c --console              Show repl / interactive console

  -o --output               Compile script and write bytecode
  -i --input                Execute script from bytecode

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

    #=======================================
    # Helpers
    #=======================================

    template bootup*(run: bool, perform: untyped):untyped =
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

        perform

        if run:
            initVM()
            discard doExec(evaled, withSyms=addr presets)
            showVMErrors()

    var token = initOptParser()

    var action: CmdAction = evalCode
    var runConsole  = static readFile("src/system/console.art")
    var runUpdate   = static readFile("src/system/update.art")
    var runModule   = static readFile("src/system/module.art")
    var code: string = ""
    var arguments: ValueArray = @[]

    when not defined(STANDALONE):

        while true:
            token.next()
            case token.kind:
                of cmdArgument: 
                    if code=="":
                        if action==evalCode:
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
                        of "o","output":
                            action = writeBcode
                            code = token.val
                        of "i","input":
                            action = readBcode
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
                    bootup(run=true):
                        when defined(PYTHONIC):
                            code = readFile(code)
                            let parsed = doParse(move code, isFile = false)
                        else:
                            let parsed = doParse(move code, isFile = action==execFile)
                            
                        let evaled = parsed.doEval()
                    
            of writeBcode:
                bootup(run=false):
                    let filename = code
                    let parsed = doParse(move code, isFile = true)
                    let evaled = parsed.doEval()

                    discard writeBytecode(evaled, filename & ".bcode")

            of readBcode:
                bootup(run=true):
                    let evaled = readBytecode(code)

            of showHelp:
                echo helpTxt
            of showVersion:
                echo VersionTxt
    else:
        arguments = commandLineParams()

        bootup(run=true):
            let parsed = doParse(move code, isFile = false)
            let evaled = parsed.doEval()