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

when not defined(WEB):
    import parseopt, segFaults
else:
    import jsffi

when defined(PORTABLE):
    import os, sequtils

when defined(PROFILE):
    import nimprof

when not defined(WEB):
    import vm/[bytecode, version]

import vm/[env, vm]

when not defined(WEB):

    #=======================================
    # Types
    #=======================================

    type
        CmdAction = enum
            execFile
            evalCode
            readBcode
            writeBcode
            writePInfo
            showHelp
            showVersion

    #=======================================
    # Constants
    #=======================================

    const helpTxt = """

    Usage:
    arturo [options] <path>

    Options:
    -c --compile              Compile script and write bytecode
    -x --execute              Execute script from bytecode

    -e --evaluate             Evaluate given code
    -r --repl                 Show repl / interactive console

    -u --update               Update to latest version

    -m --module           
            list                List all available modules
            remote              List all available remote modules
            info <name>         Get info about given module
            install <name>      Install remote module by name
            uninstall <name>    Uninstall module by name
            update              Update all local modules

    -d --debug                Show debugging information
    --no-color                Mute all colors from output

    -h --help                 Show this help screen
    -v --version              Show current version
    """
    
#=======================================
# Main entry
#=======================================

when isMainModule and not defined(WEB):

    var token = initOptParser()

    var action: CmdAction = evalCode
    var runConsole  = static readFile("src/scripts/console.art")
    var runUpdate   = static readFile("src/scripts/update.art")
    var runModule   = static readFile("src/scripts/module.art")
    var code: string = ""
    var arguments: seq[string] = @[]
    var muted: bool = false
    var debug: bool = false

    when not defined(PORTABLE):

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
                        of "pInfo":
                            action = writePInfo
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
                        of "d","debug":
                            debug = true
                        of "no-color":
                            muted = true
                        of "h","help":
                            action = showHelp
                        of "v","version":
                            action = showVersion
                        else:
                            #echo "error: unrecognized option (" & token.key & ")"
                            discard
                of cmdEnd: break

        arguments = token.remainingArgs()

        setColors(muted = muted)

        case action:
            of execFile, evalCode:
                if code=="":
                    code = runConsole

                when defined(BENCHMARK):
                    benchmark "doParse / doEval":
                        discard run(code, arguments, action==execFile, debug=debug)
                else:
                    discard run(code, arguments, action==execFile, debug=debug)
                    
            of writeBcode:
                let filename = code
                discard writeBytecode(run(code, arguments, isFile=true, doExecute=false), filename & ".bcode")

            of readBcode:
                let filename = code
                runBytecode(readBytecode(code), filename, arguments)

            of writePInfo:
                writePortableInfo(code)

            of showHelp:
                echo helpTxt
            of showVersion:
                echo ArturoVersionTxt
    else:
        arguments = commandLineParams()
        code = static readFile(getEnv("PORTABLE_INPUT"))
        let portable = static readFile(getEnv("PORTABLE_DATA"))

        if scriptData.d.hasKey("embed"):
            Syms["_embedded"] = newDictionary()
            let paths = scriptData.d["embed"].a[0].a
            let permitted = scriptData.d["embed"].a[1].a.map((x)=>x.s)
            for path in paths:
                for subpath in walkDirRec(path.s):
                    var (dir, name, ext) = splitFile(subpath)
                    echo "ext is: " & ext
                    if ext in permitted:
                        Syms["_embedded"].d[subpath] = newString(readFile(subpath))
                        dump(path)

        dump(Syms["_embedded"])

        discard run(code, arguments, isFile=false)
else:
    proc main*(txt: cstring, params: JsObject = jsUndefined): JsObject {.exportc:"A$", varargs.}=
        var str = $(txt)
        return run(str, params)