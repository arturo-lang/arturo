#!/usr/bin/env nim
######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: build.nims
######################################################
# initial conversion to NimScript thanks to:
# - Patrick (skydive241@gmx.de)

#=======================================
# Libraries
#=======================================

import os, parseopt,sequtils
import strformat, strutils, tables

import src/helpers/terminal

#=======================================
# Initialize globals
#=======================================

mode = ScriptMode.Silent
NoColors = hostOS == "windows"

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
    ROOT_DIR    = r"{getHomeDir()}.arturo".fmt
    TARGET_DIR  = r"{ROOT_DIR}/bin".fmt
    TARGET_FILE = toExe(r"{TARGET_DIR}/arturo".fmt)
    TARGET_LIB  = r"{ROOT_DIR}/lib".fmt
    MAIN        = r"src/arturo.nim"

    # configuration options
    OPTIONS = {
        "arm"               : "--cpu:arm",
        "arm64"             : "--cpu:arm64 --gcc.path:/usr/bin --gcc.exe:aarch64-linux-gnu-gcc --gcc.linkerexe:aarch64-linux-gnu-gcc",
        "debug"             : "-d:DEBUG --debugger:on --debuginfo --linedir:on",
        "dev"               : "--embedsrc:on -d:DEV --listCmd --verbosity:1 --hints:on",
        "dontcompress"      : "",
        "dontinstall"       : "",
        "full"              : "",
        "log"               : "",
        "mini"              : "",
        "noasciidecode"     : "-d:NOASCIIDECODE",
        "noclipboard"       : "-d:NOCLIPBOARD",
        "nodev"             : "",
        "nodialogs"         : "-d:NODIALOGS",
        "noexamples"        : "-d:NOEXAMPLES",
        "nogmp"             : "-d:NOGMP",
        "noparsers"         : "-d:NOPARSERS",
        "nosqlite"          : "-d:NOSQLITE",
        "nounzip"           : "-d:NOUNZIP",
        "nowebview"         : "-d:NOWEBVIEW",
        "profile"           : "-d:PROFILE --profiler:on --stackTrace:on",
        "release"           : "--passC:'-flto'",
        "safe"              : "-d:SAFE",
        "vcc"               : "",
        "verbose"           : "-d:VERBOSE",
        "web"               : "--verbosity:3 -d:WEB"
    }.toTable

#=======================================
# Variables
#=======================================

var
    BINARY              = "bin/arturo"
    COMPILER            = "c"
    COMPRESS            = true
    INSTALL             = true
    PRINT_LOG           = false
    RUN_UNIT_TESTS      = false
    FOR_WEB             = false
    IS_DEV              = false 
    MODE                = ""       

    FLAGS*              = "--skipUserCfg:on --colors:off -d:release -d:danger " &
                          "--panics:off --mm:orc --checks:off --overflowChecks:on " &
                          "-d:ssl --cincludes:extras --nimcache:.cache " & 
                          "--path:src --opt:speed --passC:-O3"
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
    echo r"                      (c)2022 Yanis Zafirópulos                      "
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
    section "Building..."

    echo "{GRAY}   version: ".fmt & staticRead("version/version") & " b/" & staticRead("version/build")
    echo "   config: {CONFIG}{CLEAR}".fmt

    if IS_DEV or PRINT_LOG:
        echo "{GRAY}   flags: {FLAGS}{CLEAR}".fmt

#=======================================
# Helpers
#=======================================

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
    js = js.multiReplace(
        ("Stack_1660944389", "STA"),
        ("finalizer", "FIN"),
        ("counter", "COU"),
        ("tpKindValue", "TKDV"),
        ("tpKind", "TKD"),
        ("iKindValue", "IKDV"),
        ("iKind", "IKD"),
        ("fnKindValue", "FKDV"),
        ("fnKind", "FKD"),
        ("dbKindValue", "DKDV"),
        ("dbKind", "DKD"),
        ("offsetBase", "OFFB"),
        ("offset", "OFF")
    )

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
    for k in [
        "noasciidecode", 
        "noclipboard",
        "nodialogs",
        "noexamples", 
        "nogmp", 
        "noparsers", 
        "nosqlite", 
        "nounzip", 
        "nowebview"
    ]:
        FLAGS = "{FLAGS} {OPTIONS[k]}".fmt

    # plus, shrinking + the MINI flag
    FLAGS = FLAGS.replace("--opt:speed ","") & " --opt:size -d:MINI"

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
        # TODO(build.nims) Check compression
        #  right now, especially on Linux, `upx` seems to be destroying the final binary
        # labels: bug, enhancement, installer
        
        #     let upx = "upx"

        #     let (_, code) = gorgeEx r"{upx} -q {toExe(BINARY)}".fmt
        #     if code!=0:
        #         echo "{RED}   upx: 3rd-party tool not available{CLEAR}".fmt

proc verifyDirectories*() =
    echo "{GRAY}   setting up directories...".fmt
    # create target dirs recursively, if they don't exist
    mkdir TARGET_DIR
    mkdir TARGET_LIB

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

    # use VCC for non-MINI Windows builds
    if (hostOS=="windows" and not FLAGS.contains("NOWEBVIEW") and IS_DEV):
        let (_,_) = gorgeEx "src\\extras\\webview\\deps\\build.bat"

    if hostOS=="windows":
        FLAGS = """{FLAGS} --passL:"""".fmt & staticExec("pkg-config --libs-only-L libcrypto") & """ -llibcrypto.a """".fmt
        echo FLAGS
    # let's go for it
    if IS_DEV or PRINT_LOG:
        # if we're in dev mode we don't really care about the success/failure of the process -
        # I guess we'll see it in front of us
        echo "{GRAY}".fmt
        try:
            exec "nim {COMPILER} {FLAGS} -o:{toExe(BINARY)} {MAIN}".fmt
        except:
            echo r"{RED}  CRASHED!!!{CLEAR}".fmt
            res = QuitFailure
    else:
        # but when it's running e.g. as a CI build,
        # we most definitely want it a) to be silent, b) to capture the exit code
        (outp, res) = gorgeEx "nim {COMPILER} {FLAGS} -o:{toExe(BINARY)} {MAIN}".fmt

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
        FLAGS = FLAGS & " " & OPTIONS["dev"]

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
    FLAGS="{FLAGS} --forceBuild:on --opt:size -d:NOEXAMPLES -d:NOERRORLINES -d:PORTABLE".fmt
    echo r"{GRAY}FLAGS: {FLAGS}".fmt
    echo r""

    echo "{GRAY}".fmt

    if (let cd = compile(footer=false); cd != 0):
        quit(cd)
        
    # clean up
    rmFile(r"{package}.data.json".fmt)

    echo "{CLEAR}".fmt

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

# check environment
let userName = if hostOS == "windows": getEnv("USERNAME") else: staticExec("whoami")
IS_DEV = userName == "drkameleon"

# parse command line
var p = initOptParser("") 
while true:
    p.next()

    case p.kind:
        of cmdArgument:
            if p.key in ["install", "package", "test", "benchmark", "help"]:
                if MODE == "":
                    MODE = p.key
                else:
                    showLogo()
                    showHelp(error=true, errorMsg="Multiple operations specified!")
            else:
                if p.key notin ["e", "./build.nims", "build.nims", "build"]:
                    if OPTIONS.hasKey(p.key):
                        FLAGS = "{FLAGS} {OPTIONS[p.key]}".fmt
                        case p.key:
                            of "debug":
                                COMPRESS = false
                            of "dev":
                                IS_DEV = true
                            of "dontcompress":
                                COMPRESS = false
                            of "dontinstall":
                                INSTALL = false
                            of "log":
                                PRINT_LOG = true
                            of "mini":
                                miniBuild()
                                CONFIG = "@mini"
                            of "nodev":
                                IS_DEV = false
                            of "web":
                                miniBuild()
                                FOR_WEB = true
                                COMPILER = "js"
                                BINARY = r"{BINARY}.js".fmt
                                CONFIG = "@web"
                            else:
                                discard
                    else:
                        ARGS.add(p.key)
        of cmdShortOption, cmdLongOption:   
            if p.key != "hints":
                showLogo()
                showHelp(error=true, errorMsg="Erroneous argument supplied!")
        of cmdEnd: 
            break

# show our log anyway
showLogo()

# process accordingly
try:
    case MODE:
        of "install"    :   buildArturo()
        of "package"    :   buildPackage()
        of "test"       :   performTests()
        of "benchmark"  :   performBenchmarks()
        of "help"       :   showHelp()
        of ""           :   showHelp(error=true, errorMsg=r"No operation specified.")
        else            :   showHelp(error=true, errorMsg=r"Not a valid operation: {MODE}".fmt)
except:
    quit(QuitFailure)

#=======================================
# This is the end,
# my only friend, the end...
#=======================================