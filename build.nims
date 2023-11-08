#!/usr/bin/env nim
######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: build.nims
######################################################
# initial conversion to NimScript thanks to:
# - Patrick (skydive241@gmx.de)

# TODO(build.nims) General cleanup needed
#  labels: installer, enhancement, cleanup

#=======================================
# Libraries
#=======================================

import os, parseopt, sequtils
import strformat, strutils, tables
import macros, sugar

import src/helpers/terminal#

#=======================================
# Initialize globals
#=======================================

mode = ScriptMode.Silent
NoColors = hostOS == "windows"

#=======================================
# Flag system
#=======================================

var flags*: seq[string] = newSeqOfCap[string](64)
    ## flags represent the flags that will be passed to the compiler.
    ##
    ## Initialize a sequence of initial 64 slots,
    ## what help us to append elements without lose performance.

## `filter`_, `stripStr`_, `--`_ and `---`_ are inspired by the
## original ones from Nim's STD lib, by 2015 Andreas Rumpf.

proc filter(content: string, condition: (char) -> bool): string =
    result = newStringOfCap content.len
    for c in content:
        if c.condition:
            result.add c

proc stripStr(content: string): string =
    result = content.filter: (x: char) => 
        x notin {' ', '\c', '\n'}
    
    if result[0] == '"' and result[^1] == '"':
        result = result[1..^2]

template `--`*(key: untyped) {.dirty.} =
    ## Overrides the original ``--`` to append values into ``flags``,
    ## instead of pass direclty to the compiler.
    ## Since this isn't the config.nims file.
    flags.add("--" & stripStr(astToStr(key)))

template `--`*(key, val: untyped) {.dirty.} =
    ## Overrides the original ``--`` to append values into ``flags``,
    ## instead of pass direclty to the compiler.
    ## Since this isn't the config.nims file.
    flags.add("--" & stripStr(astToStr(key)) & ":" & stripStr(astToStr(val)))

template `---`*(key: untyped, val: string): untyped =
    ## A simple modification of `--` for string values.
    flags.add("--" & stripStr(astToStr(key)) & ":" & val)
    
include ".config/arch.nims"
include ".config/buildmode.nims"
include ".config/devtools.nims"
include ".config/who.nims"

#=======================================
# Constants
#=======================================

let
    # terminal color aliases
    RED*        = fg(redColor)
    GREEN*      = bold(greenColor)
    BLUE*       = fg(blueColor)
    MAGENTA*    = fg(magentaColor)
    CYAN*       = fg(cyanColor)
    GRAY*       = fg(grayColor)
    CLEAR*      = resetColor()
    BOLD*       = bold()

    # paths
    ROOT_DIR        = r"{getHomeDir()}.arturo".fmt
    TARGET_DIR      = r"{ROOT_DIR}/bin".fmt
    TARGET_LIB      = r"{ROOT_DIR}/lib".fmt
    TARGET_STORES   = r"{ROOT_DIR}/stores".fmt
    MAIN            = r"src/arturo.nim"

    # configuration options
    OPTIONS: Table[string, proc()] = {
        "docgen": proc () {.closure.} = 
            --define:DOCGEN
        ,
        "dontcompress": proc () {.closure.} = 
            discard
        ,
        "dontinstall": proc () {.closure.} = 
            discard 
        ,
        "log": proc () {.closure.} = 
            discard
        ,
        "noerrorlines": proc () {.closure.} = 
            --define:NOERRORLINES
        ,
        "optimized": proc () {.closure.} = 
             --define:OPTIMIZED
        ,
        "vcc": proc () {.closure.} = 
            discard
        ,
    }.toTable

#=======================================
# Variables
#=======================================

var
    BINARY              = "bin/arturo"
    TARGET_FILE         = toExe(r"{TARGET_DIR}/arturo".fmt)
    COMPILER            = "c"
    COMPRESS            = true
    INSTALL             = true
    PRINT_LOG           = false
    RUN_UNIT_TESTS      = false
    FOR_WEB             = false
    IS_DEV              = false 
    MODE                = ""       

    FLAGS*              = ""
    CONFIG              ="@full"

    ARGS: seq[string]   = @[] 

#=======================================
# Forward declarations
#=======================================

proc getShellRc*(): string

#=======================================
# Output
#=======================================

proc showLogo*() =
    echo r"====================================================================={GREEN}".fmt
    echo r"                               _                                     "
    echo r"                              | |                                    "
    echo r"                     __ _ _ __| |_ _   _ _ __ ___                    "
    echo r"                    / _` | '__| __| | | | '__/ _ \                   "
    echo r"                   | (_| | |  | |_| |_| | | | (_) |                  "
    echo r"                    \__,_|_|   \__|\__,_|_|  \___/                   "
    echo r"{CLEAR}{BOLD}                                                        ".fmt
    echo r"                     Arturo Programming Language{CLEAR}              ".fmt
    echo r"                      (c)2023 Yanis Zafirópulos                      "
    echo r"                                                                     "

proc showHeader*(title: string) = 
    echo r"====================================================================="
    echo r" ► {title.toUpperAscii()}                                            ".fmt
    echo r"====================================================================="

proc section*(title: string) =
    echo r"{CLEAR}".fmt
    echo r"--------------------------------------------"
    echo r" {MAGENTA}●{CLEAR} {title}".fmt
    echo r"--------------------------------------------"

proc showFooter*() =
    echo r"{CLEAR}".fmt
    echo r"====================================================================="
    echo r" {MAGENTA}●{CLEAR}{GREEN} Awesome!{CLEAR}".fmt
    echo r"====================================================================="
    echo r"   Arturo has been successfully built & installed!"
    if hostOS != "windows":
        echo r""
        echo r"   To be able to run it,"
        echo r"   first make sure its in your $PATH:"
        echo r""
        echo r"          export PATH=$HOME/.arturo/bin:$PATH"
        echo r""
        echo r"   and add it to your {getShellRc()},".fmt
        echo r"   so that it's set automatically every time."
    echo r""
    echo r"   Rock on! :)"
    echo r"====================================================================="
    echo r"{CLEAR}".fmt

proc showEnvironment*() =
    section "Checking environment..."

    echo "{GRAY}   os: {hostOS}".fmt
    echo "   compiler: Nim v{NimVersion}{CLEAR}".fmt

proc showBuildInfo*() =
    let params = flags.join(" ")
    section "Building..."
    echo "{GRAY}   version: ".fmt & staticRead("version/version") & " b/" & staticRead("version/build")
    echo "   config: {CONFIG}{CLEAR}".fmt

    if IS_DEV or PRINT_LOG:
        echo "{GRAY}   flags: {params} {FLAGS}{CLEAR}".fmt

#=======================================
# Helpers
#=======================================
# TODO(build.nims) JavaScript compression not working correctly
#  labels: web,bug
proc recompressJS*(jsFile: string) =
    let outputFile = jsFile #.replace(".min.js", ".final.min.js")
    var js = readFile(jsFile)

    # replace Field0, Field1, etc with F0, F1, etc
    js = js.replaceWord("Field0", "F0")
           .replaceWord("Field1", "F1")
           .replaceWord("Field2", "F2")
           .replaceWord("Field3", "F3")

    # replace redundant error messages
    js = js.multiReplace(
        ("field '", ""),
        ("' is not accessible for type '", ""),
        ("' using ", ""),
        ("'kind = ", ""),
        ("'iKind = ", ""),
        ("'tpKind = ", ""),
        ("'fnKind = ", "")
    )

    # replace other more-verbose identifiers
    # js = js.multiReplace(
    #     ("Stack_1660944389", "STA"),
    #     #("finalizer", "FIN"),
    #     # ("counter", "COU"),
    #     # ("tpKindValue", "TKDV"),
    #     # ("tpKind", "TKD"),
    #     # ("iKindValue", "IKDV"),
    #     # ("iKind", "IKD"),
    #     # ("fnKindValue", "FKDV"),
    #     # ("fnKind", "FKD"),
    #     # ("dbKindValue", "DKDV"),
    #     # ("dbKind", "DKD"),
    #     # ("offsetBase", "OFFB"),
    #     # ("offset", "OFF")
    # )

    writeFile(outputFile, js)

proc getShellRc*(): string =
    # will only be called on non-Windows systems -
    # are there any more shells that are not taken into account?
    let (output, _) = gorgeEx("echo $SHELL")
    case output:
        of "/bin/zsh":
            result = "~/.zshrc"
        of "/bin/bash":
            result = "~/.bashrc or ~/.profile"
        of "/bin/sh":
            result = "~/.profile"
        else:
            result = "~/.profile"

proc miniBuild*() =
    # all the necessary "modes" for mini builds
    miniBuildConfig()

    # plus, shrinking + the MINI flag
    if hostOS=="freebsd" or hostOS=="openbsd" or hostOS=="netbsd":
        --verbosity:3

proc compressBinary() =
    if COMPRESS:
        section "Post-processing..."

        echo r"{GRAY}   compressing binary...{CLEAR}".fmt
        if FOR_WEB:
            let minBin = BINARY.replace(".js",".min.js")
            let (_, code) = gorgeEx r"uglifyjs {BINARY} -c -m ""toplevel,reserved=['A$']"" -c -o {minBin}".fmt
            if code!=0:
                echo "{RED}   uglifyjs: 3rd-party tool not available{CLEAR}".fmt
            else:
                recompressJS(minBin)
        else:
            discard
        # TODO(build.nims) Check & fix upx-based compression on Linux
        #  right now, especially on Linux, `upx` seems to be destroying the final binary
        #  labels: bug, enhancement, linux, installer
        
        #     let upx = "upx"

        #     let (_, code) = gorgeEx r"{upx} -q {toExe(BINARY)}".fmt
        #     if code!=0:
        #         echo "{RED}   upx: 3rd-party tool not available{CLEAR}".fmt

proc verifyDirectories*() =
    echo "{GRAY}   setting up directories...".fmt
    # create target dirs recursively, if they don't exist
    mkdir TARGET_DIR
    mkdir TARGET_LIB
    mkdir TARGET_STORES

proc updateBuild*() =
    # will only be called in DEV mode -
    # basically, increment the build number by one and perform a git commit
    writeFile("version/build", $(readFile("version/build").strip.parseInt + 1))
    let (output, _) = gorgeEx r"git commit -m 'build update' version/build".fmt
    for ln in output.split("\n"):
        echo "{GRAY}   ".fmt & ln.strip() & "{CLEAR}".fmt

proc compile*(footer=false): int =
    var outp = ""
    var res = 0
    let params = flags.join(" ")

    # use VCC for non-MINI Windows builds
    if (hostOS=="windows" and not flags.contains("NOWEBVIEW") and IS_DEV):
        let (_,_) = gorgeEx "src\\extras\\webview\\deps\\build.bat"

    # if hostOS=="windows":
    #     FLAGS = """{FLAGS} --passL:"-static """.fmt & staticExec("pkg-config --libs-only-L libcrypto").strip() & """ -lcrypto -Bdynamic" """.fmt
    #     echo FLAGS
    when defined(windows):
        FLAGS.add """ --passL:"-static-libstdc++ -static-libgcc -Wl,-Bstatic -lstdc++ -Wl,-Bdynamic"""" &
                  """ --gcc.linkerexe="g++""""
    else:
        FLAGS.add """ --passL:"-lm""""
    # let's go for it
    if IS_DEV or PRINT_LOG:
        # if we're in dev mode we don't really care about the success/failure of the process -
        # I guess we'll see it in front of us
        echo "{GRAY}".fmt
        try:
            exec "nim {COMPILER} {params} {FLAGS} -o:{toExe(BINARY)} {MAIN}".fmt
        except:
            echo r"{RED}  CRASHED!!!{CLEAR}".fmt
            res = QuitFailure
    else:
        # but when it's running e.g. as a CI build,
        # we most definitely want it a) to be silent, b) to capture the exit code
        (outp, res) = gorgeEx "nim {COMPILER} {params} {FLAGS} -o:{toExe(BINARY)} {MAIN}".fmt

    return res

proc installAll*() =
    if INSTALL and not FOR_WEB:
        section "Installing..."

        verifyDirectories()
        echo "   copying files..."
        cpFile(toExe(BINARY), TARGET_FILE)
        if hostOS != "windows":
            exec(r"chmod +x {TARGET_FILE}".fmt)
        else:
            cpFile("src\\extras\\webview\\deps\\dlls\\x64\\webview.dll","bin\\webview.dll")
            cpFile("src\\extras\\webview\\deps\\dlls\\x64\\WebView2Loader.dll","bin\\WebView2Loader.dll")
        echo "   deployed to: {ROOT_DIR}{CLEAR}".fmt

#=======================================
# Methods
#=======================================

proc buildArturo*() =
    showHeader "install"
    
    # if the one who's building is some guy going back the nick "drkameleon" -
    # who might that be ?! - then it's a DEV build
    if IS_DEV:
        section "Updating build..."
        updateBuild()
        devConfig()

    # show environment & build info
    showEnvironment()
    showBuildInfo()

    if (let cd = compile(footer=true); cd != 0):
        quit(cd)

    compressBinary()

    installAll()

    showFooter()

proc buildPackage*() =
    showHeader "package"

    let package = ARGS[0]

    # generate portable data
    section "Processing data..."

    writeFile("{package}.data.json".fmt, staticExec(r"arturo --package-info {package}.art".fmt))
    echo "{GRAY}   written to: {package}.data.json{CLEAR}".fmt

    # set up environment
    section "Setting up options..."

    putEnv("PORTABLE_INPUT", "{package}.art".fmt)
    putEnv("PORTABLE_DATA", "{package}.data.json".fmt)

    echo "{GRAY}   done".fmt

    # show environment & build info
    showEnvironment()
    showBuildInfo()

    echo "{GRAY}".fmt
        
    BINARY="{package}".fmt
    FLAGS="{FLAGS} --forceBuild:on --opt:size -d:NOERRORLINES -d:PORTABLE".fmt
    echo r"{GRAY}FLAGS: {FLAGS}".fmt
    echo r""

    echo "{GRAY}".fmt

    if (let cd = compile(footer=false); cd != 0):
        quit(cd)
        
    # clean up
    rmFile(r"{package}.data.json".fmt)

    echo "{CLEAR}".fmt

proc buildDocs*() =
    let params = flags.join(" ")
    showHeader "docs"

    section "Generating documentation..."
    exec(r"nim doc --project --index:on --outdir:dev-docs {params} {FLAGS} src/arturo.nim".fmt)
    exec(r"nim buildIndex -o:dev-docs/theindex.html dev-docs")

proc performTests*() =
    showHeader "test"
    try:
        exec r"{TARGET_FILE} ./tools/tester.art".fmt
    except:
        try: 
            exec r"{toExe(BINARY)} ./tools/tester.art".fmt
        except:
            quit(QuitFailure)

proc performBenchmarks*() = 
    showHeader "benchmark"
    try:
        exec r"{TARGET_FILE} ./tools/benchmarker.art".fmt
    except:
        try: 
            exec r"{toExe(BINARY)} ./tools/benchmarker.art".fmt
        except:
            quit(QuitFailure)

proc showHelp*(error=false, errorMsg="") =
    if error:
        showHeader("Error")
        echo r"{RED}".fmt
        echo r" " & errorMsg
        echo r" Please choose one of the ones below:"
        echo r"{CLEAR}".fmt
    else:
        showHeader("Help")

    echo r" install              : Build arturo and install executable"
    echo r"      mini            : Build MINI version (optional)"
    echo r"      web             : Build Web/JS version (optional)"
    echo r""
    echo r" package <script>     : Package arturo app and build executable"
    echo r""
    echo r" test                 : Run test suite"
    echo r" benchmark            : Run benchmark suite"
    echo r""
    echo r" help                 : Show this help screen"
    echo r""
    echo r"---------------------------------------------------------------------"
    echo r" ✼ Example:"
    echo r"---------------------------------------------------------------------"
    echo r""
    echo r" ./build.nims install         -> to build & install the full version "
    echo r" ./build.nims install mini    -> to build & install the mini version "
    echo r" ./build.nims package script  -> to package your <script>.art app    "
    echo r""

    if error:
        quit(QuitFailure)

#=======================================
# Main
#=======================================

let 
    args = commandLineParams()
    command = if "build.nims" in paramStr(1):
            paramStr(2)
        else:
            paramStr(1)

proc panic(msg: string) =
    showLogo()
    showHelp(error=true, errorMsg=msg)
    
template `==?`(a, b: string): bool = cmpIgnoreStyle(a, b) == 0
proc `>>?`(element: string, container: openarray[string]): bool = 
    result = false
    for el in container:
        if element ==? el:
            return true

proc getOptionValue*(args: seq[string], cmd: string, default: string,
                     short: string = "", into: seq[string] = @[]): string =
    ## Gets an optional argument's value
    ## example, for ``--who rick``, the returned value will be ``rick``,
    ## otherwhise, if the flag is not found, it'll return the ``default``
    ## 
    ## This procedure has side effects and ends the application if the user
    ## write something wrong.
    result = default

    template isFlag(arg: string): bool =
        arg.startsWith("-")

    template flagFound(arg: string): bool =
        arg in [fmt"-{short}", fmt"--{cmd}"]

    func hasMissingValue(args: seq[string], currIdx: int): bool =    
        result = false
        if currIdx >= args.high:
            return true
        if args[currIdx.succ].isFlag():
            return true

    let allowGenericArgument: bool = into.len == 0

    for idx, arg in args:
        if not arg.isFlag() or not arg.flagFound():
            continue

        if args.hasMissingValue(idx):
            quit fmt"Missing value for --{cmd}.", QuitFailure

        let next = args[idx.succ]
        if not allowGenericArgument or next >>? into:
            return next
        quit fmt"{next} isn't into {into} for --{cmd}.", QuitFailure


func hasFlag*(args: seq[string], cmd: string, 
              short: string = "", 
              default: bool = false): bool =
    ## Returns true if some flag was found
    result = default
    for arg in args:
        if not arg.startsWith("-"):
            continue
        if arg >>? [fmt"-{short}", fmt"--{cmd}"]:
            return true

proc hasCommand*(args: seq[string], cmd: string, 
              default: bool = false): bool =
    ## Returns true if some flag was found
    result = default
    for arg in args:
        if arg.startsWith("-"):
            continue
        if arg.cmpIgnoreStyle(cmd) == 0:
            return true

macro implementationToStr(id: typed): string =
    id.getImpl.toStrLit

iterator getDocs(impl: string): string =
    ## Return the documentation of any implementation
    ## 
    ## This iterates until the end of the documentation block.
    var found = false
    for line in impl.splitLines():
        let cleanline = line.strip()
        if cleanline.startsWith("##"):
            yield cleanline[3 .. cleanline.high]
            found = true
        # Don't iterate until the end of the implementation,
        # Just until the end of the impl's documentation
        elif found:
            break

template help(ident: typed, status: int) =
    ## Prints the documentation from a identifier.
    ## 
    ## Params
    ## ------
    ## ident: typed
    ##      the identifier, can be any declared implementation.
    ##
    ## Usage
    ## -----
    ## ..code-block:: nim
    ##      help getOptionValue
    for line in ident.implementationToStr.getDocs():
        echo line
    quit status

template cmd*(name: untyped; description: string; body: untyped): untyped =
    ## This is a modification of the original ``task`` by (c) Copyright 2015 Andreas Rumpf
    ## original source: https://github.com/nim-lang/Nim/blob/805b4e2dc2afddf7be27e32fe0543e4227b31f74/lib/system/nimscript.nim#L390
    ##
    ## Reason: ``task``s were not working with optional arguments, 
    ## so I removed the ``getCommand``, and replaced it by paramStr(2) 
    ## defined by ``command``
    proc `name Task`*() =
        body

    if command ==? astToStr(name):
        if args.hasFlag("help", short="h"):
            help `name Task`, QuitSuccess
        else:
            `name Task`()

# check environment
let userName = if hostOS == "windows": getEnv("USERNAME") else: staticExec("whoami")
IS_DEV = userName == "drkameleon"

showLogo()
        
template match(sample: string, body: untyped) =
    ## Usage
    ## -----
    ## ..code::
    ##      match input:
    ##        >> "amd-64", "amd", "x64", "x86-64":
    ##          --cpu:amd64
    ##        >> "arm", "arm-32":
    ##          --cpu:arm32
    ##          --define:bit32
    block matchBlock:
        
        template `>>`(elements: openarray[string], ibody: untyped) =
            if sample >>? elements:
                ibody
                break matchBlock
        
        body


cmd install, "Build arturo and install executable":
    ## build:
    ##     Provides a cross-compilation for the Arturo's binary.
    ## 
    ##     --arch: string = $hostCPU
    ##          [amd64, arm, arm64, i386, x86]
    ##     --build -b: string = full
    ##          [full, mini, web]
    ##     --os: string = $hostOS
    ##          [freebsd, linux, openbsd, mac, macos, macosx, netbsd, win, windows]
    ##     --who: string = user
    ##          [bench, ci, dev, user]
    ##     --compress -c
    ##     --install -i
    ##     --log -l
    ##     --help

    const availableCPUs = @[
        "amd-64", "x64", "x86-64", 
        "arm-64", 
        "i386", "x86", "x86-32",
        "arm", "arm-32",
    ]
    
    match args.getOptionValue("arch", default=hostCPU, short="a", into=availableCPUs):
        >> availableCPUs[0..2]: amd64Config()
        >> [availableCPUs[3]] : arm64Config()
        >> availableCPUs[4..6]: arm64Config()
        >> availableCPUs[7..8]: arm32Config()

    if args.hasCommand("debug"):
        COMPRESS = false
        debugConfig()

    if args.hasCommand("dev"):
        IS_DEV = true
        devConfig()

    if args.hasCommand("dontcompress"):
        COMPRESS = false

    if args.hasCommand("dontinstall"):
        INSTALL = false

    if args.hasCommand("log"):
        PRINT_LOG = true

    if args.hasCommand("mini"):
        miniBuild()
        CONFIG = "@mini"

    if args.hasCommand("nodev"):
        IS_DEV = false
        userConfig()

    if args.hasCommand("web"):
        miniBuild()
        FOR_WEB = true
        COMPILER = "js"
        BINARY = r"{BINARY}.js".fmt
        CONFIG = "@web"


    if args.hasCommand("docgen"):
        --define:DOCGEN

    if args.hasCommand("full"):
        fullBuildConfig()

    if args.hasCommand("memprofile"):
        memProfileConfig()

    if args.hasCommand("mini"):
        miniBuildConfig() 

    if args.hasCommand("profile"):
        profileConfig()

    if args.hasCommand("profilenative"):
        nativeProfileConfig()

    if args.hasCommand("profiler"):
        profilerConfig()

    if args.hasCommand("release"):
        releaseConfig()

    if args.hasCommand("safe"):
        safeBuildConfig()

    if args.hasCommand("web"):
        webBuildConfig()

    if CONFIG == "@full":
        fullBuildConfig()

    buildArturo()

cmd package, "Package arturo app and build executable":
    buildPackage()

cmd docs, "Build the documentation":
    buildDocs()

cmd test, "Run test suite":
    performTests()

cmd benchmark, "Run benchmark suite":
    performBenchmarks()