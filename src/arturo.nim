######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: arturo.nim
######################################################

#=======================================
# Libraries
#=======================================

import parseopt, segFaults, tables

when defined(PROFILE):
    import nimprof

import vm/[version, value, vm]

#=======================================
# Types
#=======================================

type
    CmdAction = enum
        execFile
        evalCode
        # readBcode
        # writeBcode
        showHelp
        showVersion

#=======================================
# Constants
#=======================================

#   -o --output               Compile script and write bytecode
#   -i --input                Execute script from bytecode

const helpTxt = """

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

    when not defined(PORTABLE):

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
                        # of "o","output":
                        #     action = writeBcode
                        #     code = token.val
                        # of "i","input":
                        #     action = readBcode
                        #     code = token.val
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
                        run(code, arguments, action==execFile)
                else:
                    run(code, arguments, action==execFile)
                    
            # of writeBcode:
            #     discard
            #     # bootup(run=false):
            #     #     let filename = code
            #     #     let parsed = doParse(move code, isFile = true)
            #     #     let evaled = parsed.doEval()

            #     #     discard writeBytecode(evaled, filename & ".bcode")

            # of readBcode:
            #     discard
            #     # bootup(run=true):
            #     #     let evaled = readBytecode(code)

            of showHelp:
                echo helpTxt
            of showVersion:
                echo VersionTxt
    else:
        arguments = commandLineParams().map(proc (x:string):Value = newString(x))
        code = static readFile(getEnv("PORTABLE_INPUT"))

        run(code, arguments, isFile=false)