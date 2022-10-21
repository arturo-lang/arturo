#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: arturo.nim
#=======================================================

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import segFaults
else:
    import jsffi

when defined(PORTABLE):
    import os

when defined(PROFILE):
    import nimprof

when not defined(WEB) and not defined(PORTABLE):
    import parseopt, re
    import helpers/terminal
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

Options:
    -c, --compile              Compile script and write bytecode
    -x, --execute              Execute script from bytecode

    -e, --evaluate             Evaluate given code
    -r, --repl                 Show repl / interactive console

    -u, --update               Update to latest version

    -m, --module           
            list               List all available modules
            remote             List all available remote modules
            info <name>        Get info about given module
            install <name>     Install remote module by name
            uninstall <name>   Uninstall module by name
            update             Update all local modules

    --no-color                 Mute all colors from output

    -h, --help                 Show this help screen
    -v, --version              Show current version
"""

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
    
#=======================================
# Main entry
#=======================================

when isMainModule and not defined(WEB):

    var code: string = ""
    var arguments: seq[string] = @[]

    when not defined(PORTABLE):
        var token = initOptParser()

        var action: CmdAction = evalCode
        var runConsole  = static readFile("src/scripts/console.art")
        var runUpdate   = static readFile("src/scripts/update.art")
        var runModule   = static readFile("src/scripts/module.art")
        var muted: bool = false
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
                        of "u","update":
                            action = evalCode
                            code = runUpdate
                        of "m", "module":
                            action = evalCode
                            code = runModule
                            break
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

        if unrecognizedOption!="" and ((action==evalCode and code=="") or (action notin [execFile, evalCode])):
            CompilerError_UnrecognizedOption(unrecognizedOption)
            echo ""
            printHelp(withHeader=false)
            quit(1)

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