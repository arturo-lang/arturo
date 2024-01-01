#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
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

when defined(PORTABLE):
    import os

when not defined(WEB):
    when not defined(MINI):
        import helpers/packager
    import helpers/terminal

when not defined(WEB) and not defined(PORTABLE):
    import parseopt, re
    import vm/[bytecode, env, errors, package, version]

import vm/vm

when not defined(WEB):
    import vm/[parse, values/value, values/printable]

when not defined(WEB) and not defined(PORTABLE):

    #=======================================
    # Types
    #=======================================

    type
        CmdAction = enum
            execFile
            evalCode
            readBcode
            writeBcode
            showPInfo
            packagerMode
            showHelp
            showVersion

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
    -e, --evaluate <code>                   Evaluate given code

    -c, --compile <script>                  Compile script and write bytecode
    -x, --execute <bytecode>                Execute script from bytecode

    -r, --repl                              Show repl / interactive console
    
    -h, --help                              Show this help screen
    -v, --version                           Show current version

Options:
    --no-color                              Mute all colors from output
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
                    guard(args.len != 0): CompilerError_ExtraneousParameter(command, args[0])
                    run(proc()=
                        packageListLocal()
                    )
                of "remote":
                    guard(args.len != 0): CompilerError_ExtraneousParameter(command, args[0])
                    run(proc()=
                        packageListRemote()
                    )
                of "install":
                    guard(args.len == 0): CompilerError_NotEnoughParameters(command)
                    guard(args.len > 2): CompilerError_ExtraneousParameter(command, args[2])
                    run(proc()=
                        packageInstall(args[0], (if args.len==2: args[1] else: ""))
                    )
                of "uninstall":
                    guard(args.len == 0): CompilerError_NotEnoughParameters(command)
                    guard(args.len > 2): CompilerError_ExtraneousParameter(command, args[2])
                    run(proc()=
                        packageUninstall(args[0], (if args.len==2: args[1] else: ""))
                    )
                of "update":
                    guard(args.len != 0): CompilerError_ExtraneousParameter(command, args[1])
                    run(proc()=
                        packageUpdateAll()
                    )
                of "":
                    guard(true): CompilerError_NoPackageCommand()
                else:
                    guard(true): CompilerError_UnrecognizedPackageCommand(command)

#=======================================
# Main entry
#=======================================

when isMainModule and not defined(WEB):

    var code: string
    var arguments: seq[string]

    when not defined(PORTABLE):
        var token = initOptParser()

        var action: CmdAction = evalCode
        var runConsole  = static readFile("src/scripts/console.art")
        #var runUpdate   = static readFile("src/scripts/update.art")
        #var runModule   = static readFile("src/scripts/module.art")
        var muted: bool = not isColorFriendlyTerminal()

        var unrecognizedOption = ""

        while true:
            token.next()
            case token.kind:
                of cmdArgument: 
                    if code=="":
                        if action==evalCode:
                            action = execFile
                        
                        code = token.key
                        break
                of cmdShortOption, cmdLongOption:
                    case token.key:
                        of "r","repl":
                            action = evalCode
                            code = runConsole
                        of "e","evaluate":
                            action = evalCode
                            code = token.val
                        of "c","compile":
                            action = writeBcode
                            code = token.val
                        of "package-info":
                            action = showPInfo
                            code = token.val
                        of "x","execute":
                            action = readBcode
                            code = token.val
                        # of "u","update":
                        #     action = evalCode
                        #     code = runUpdate
                        of "p", "package":
                            when not defined(MINI):
                                action = packagerMode
                                code = token.val
                            else:
                                unrecognizedOption = token.key
                            #break
                        of "no-color":
                            muted = true
                        of "h","help":
                            action = showHelp
                        of "v","version":
                            action = showVersion
                        else:
                            unrecognizedOption = token.key
                of cmdEnd: break

        arguments = token.remainingArgs()

        setColors(muted = muted)

        if unrecognizedOption!="" and ((action==evalCode and code=="") or (action notin {execFile, evalCode})):
            guard(true): CompilerError_UnrecognizedOption(unrecognizedOption)

        case action:
            of execFile, evalCode:
                if code=="":
                    code = runConsole

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

            of packagerMode:
                packagerMode(code, arguments)

            of showPInfo:
                showPackageInfo(code)

            of showHelp:
                printHelp()
            of showVersion:
                echo ArturoVersionTxt
    else:
        arguments = commandLineParams()
        code = static readFile(getEnv("PORTABLE_INPUT"))
        let portable = static readFile(getEnv("PORTABLE_DATA"))

        discard run(code, arguments, isFile=false, withData=portable)
else:
    proc main*(txt: cstring, params: JsObject = jsUndefined): JsObject {.exportc:"A$", varargs.}=
        var str = $(txt)
        return run(str, params)