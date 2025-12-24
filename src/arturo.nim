#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2025 Yanis Zafirópulos
#
# @file: arturo.nim
#=======================================================

## This is the main entry point where 
## the whole magic begins.
## 
## The purpose of this module is to parse the 
## command-line arguments and pass the control 
## to the VM.

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import segFaults
else:
    import jsffi

when defined(PROFILE):
    import nimprof

when defined(BUNDLE):
    import os

when not defined(WEB):
    import helpers/terminal

when not defined(WEB) and not defined(BUNDLE):
    import parseopt, re
    import vm/[bytecode, env, errors, version]

import vm/vm

when not defined(WEB):
    import vm/[parse, values/value, values/printable]
    when not defined(MINI):
        import vm/[packager]

when defined(BUNDLE):
    import vm/bundle/resources
else:
    when not defined(WEB):
        import vm/bundle/generator

when not defined(WEB) and not defined(BUNDLE):

    #=======================================
    # Types
    #=======================================

    type
        CmdAction = enum
            execFile
            evalCode
            readBcode
            writeBcode
            generateBundle
            packagerMode
            showHelp
            showVersion

            noAction

    #=======================================
    # Constants
    #=======================================

    const helpTxtHeader = """

Arturo 
Programming Language + Bytecode VM compiler

"""

    const helpTxt = """
Usage:
    arturo [options] <path>

Arguments:
    <path>
        Path to the source code file to execute -
        usually with an .art extension

Commands:
""" & (when not defined(MINI): """
    -p, --package               
            list                            List all available packages
            remote                          List all available remote packages
            install <package> [version]     Install given remote package
            uninstall <package> [version]   Uninstall given local package
            update                          Update all local packages

""" else: "") & """
    -e, --evaluate                          Evaluate given code string

    -r, --repl                              Show repl / interactive console
    
    -h, --help                              Show this help screen
    -v, --version                           Show current version

Options:
    --no-color                              Mute all colors from output

Experimental:
    -c, --compile                           Compile script and write bytecode
    -x, --execute                           Execute script from bytecode

    -b, --bundle                            Bundle file as an executable
        --as <name>                         Rename executable to...
"""
    #=======================================
    # Templates
    #=======================================

    template guard(condition: bool, action: untyped): untyped =
        if (condition):
            action
            echo ""
            printHelp(withHeader=false)
            quit(1)

    #=======================================
    # Helpers
    #=======================================

    proc printHelp(withHeader=true) =
        var txt = helpTxt

        if withHeader:
            txt = helpTxtHeader & txt

        echo txt.replacef(re"(\-\-?[\w\-]+)", fg(magentaColor) & "$1" & resetColor())
                .replacef(re"    <path>", fg(magentaColor) & "    <path>" & resetColor())
                .replacef(re"(\w+:)", bold(cyanColor) & "$1" & resetColor())
                .replacef(re"Arturo", bold(greenColor) & "Arturo" & resetColor())
                .replacef(re"(\n            [\w]+(?:\s[\w<>]+)?)",bold(whiteColor) & "$1" & resetColor())

    proc packagerMode(command: string, args: seq[string]) =
        when not defined(MINI):
            VerbosePackager = true
            CmdlinePackager = true
            case command:
                of "list":
                    guard(args.len != 0): Error_ExtraneousParameter(command, args[0])
                    run(proc()=
                        packageListLocal()
                    )
                of "remote":
                    guard(args.len != 0): Error_ExtraneousParameter(command, args[0])
                    run(proc()=
                        packageListRemote()
                    )
                of "install":
                    guard(args.len == 0): Error_NotEnoughParameters(command)
                    guard(args.len > 2): Error_ExtraneousParameter(command, args[2])
                    run(proc()=
                        packageInstall(args[0], (if args.len==2: args[1] else: ""))
                    )
                of "uninstall":
                    guard(args.len == 0): Error_NotEnoughParameters(command)
                    guard(args.len > 2): Error_ExtraneousParameter(command, args[2])
                    run(proc()=
                        packageUninstall(args[0], (if args.len==2: args[1] else: ""))
                    )
                of "update":
                    guard(args.len != 0): Error_ExtraneousParameter(command, args[1])
                    run(proc()=
                        packageUpdateAll()
                    )
                of "":
                    guard(true): Error_NoPackageCommand()
                else:
                    guard(true): Error_UnrecognizedPackageCommand(command)

#=======================================
# Main entry
#=======================================

when isMainModule and not defined(WEB):

    var code: string
    var arguments: seq[string]

    when not defined(BUNDLE):
        var token = initOptParser()

        var action: CmdAction = noAction
        var runConsole  = static readFile("src/scripts/console.art")
        var runUpdate   = static readFile("src/scripts/update.art")
        var muted: bool = not isColorFriendlyTerminal()
        var bundleName: string = ""

        var unrecognizedOption = ""

        while true:
            token.next()
            case token.kind:
                of cmdArgument: 
                    if code=="":
                        code = token.key
                        break
                of cmdShortOption, cmdLongOption:
                    case token.key:
                        # commands
                        of "r","repl":
                            action = evalCode
                            code = runConsole
                        of "e","evaluate":
                            action = evalCode
                        of "u","update":
                            action = evalCode
                            code = runUpdate
                        of "p", "package":
                            when not defined(MINI):
                                action = packagerMode
                            else:
                                unrecognizedOption = token.key
                            #break
                        of "h","help":
                            action = showHelp
                        of "v","version":
                            action = showVersion
                        
                        # options
                        of "no-color":
                            muted = true

                        # experimental
                        of "c","compile":
                            action = writeBcode
                        of "x","execute":
                            action = readBcode
                        of "b","bundle":
                            action = generateBundle
                        of "as":
                            bundleName = token.val
                        
                        else:
                            unrecognizedOption = token.key
                of cmdEnd: break

        arguments = token.remainingArgs()

        setColors(muted = muted)

        if action == noAction:
            if code == "":
                action = evalCode
                code = runConsole
            else:
                action = execFile

        if unrecognizedOption!="" and ((action==evalCode and code=="") or (action notin {execFile, evalCode})):
            guard(true): Error_UnrecognizedOption(unrecognizedOption)

        case action:
            of execFile, evalCode:

                when defined(BENCHMARK):
                    benchmark "doParse / doEval":
                        discard run(code, arguments, action==execFile)
                else:
                    discard run(code, arguments, action==execFile)
                    
            of writeBcode:
                var target = code & ".bcode"

                let evaled = newBytecode(run(code, arguments, isFile=true, doExecute=false))
                let dataS = codify(newBlock(evaled.trans.constants), unwrapped=true, safeStrings=true)
                let codeS = evaled.trans.instructions

                discard writeBytecode(dataS, codeS, target, compressed=true)

            of readBcode:
                let filename = code
                let bcode = readBytecode(code)
                let parsed = doParse(bcode[0], isFile=false).a[0]
                runBytecode(Translation(constants: parsed.a, instructions: bcode[1]), filename, arguments)
            
            of generateBundle:
                generateBundle(code, bundleName)

            of packagerMode:
                packagerMode(code, arguments)

            of showHelp:
                printHelp()
            of showVersion:
                echo ArturoVersionTxt
            of noAction:
                discard
    else:
        arguments = commandLineParams()
        var bundleMain = static BundleMain
        discard run(bundleMain, arguments, isFile=false)#, withData=portable)
else:
    proc main*(txt: cstring, params: JsObject = jsUndefined): JsObject {.exportc:"A$", varargs.}=
        var str = $(txt)
        return run(str, params)