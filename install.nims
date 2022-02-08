#!/usr/bin/env -S nim --hints:off
################################################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: install.nims
################################################################################
import 
    std/[ parseopt, strformat, strutils, ]
{.warning[UnusedImport]:off.}

let
    COLORS = true
    RED* = if COLORS: "\e[0;31m" else: ""
    GREEN* = if COLORS: "\e[1;32m" else: ""
    BLUE* = if COLORS: "\e[0;34m" else: ""
    MAGENTA* = if COLORS: "\e[1;35m" else: ""
    CYAN* = if COLORS: "\e[1;36m" else: ""
    GRAY* = if COLORS: "\e[0;90m" else: ""
    CLEAR* = if COLORS: "\e[0m" else: ""
    BOLD* = if COLORS: "\e[1m" else: ""

################################################################################
# HELPERS
################################################################################
proc showHeader*(title: string) =
    echo r"=======================================================================".fmt
    echo r"{GREEN}                                                            _                                        ".fmt
    echo r"                                                         | |                                     "
    echo r"                                        __ _ _ __| |_ _     _ _ __ ___     "
    echo r"                                     / _` | '__| __| | | | '__/ _ \    "
    echo r"                                    | (_| | |    | |_| |_| | | | (_) | "
    echo r"                                     \__,_|_|     \__|\__,_|_|    \___/    "
    echo r"{CLEAR}".fmt
    echo r"                                                         {BOLD}Arturo".fmt
    echo r"                                             Programming Language{CLEAR}".fmt
    echo r"                                        (c)2022 Yanis Zafirópulos"
    echo r"======================================================================="
    echo r" ► {title}".fmt
    echo r"======================================================================="

proc showFooter*() =
    echo r"{GRAY}".fmt
    echo r":======================================================================"
    echo r": Arturo has been successfully installed!"
    echo r":"
    echo r": To be able to run it,"
    echo r": first make sure its in your $PATH:"
    echo r":"
    echo r":        export PATH=$HOME/.arturo/bin:$PATH"
    echo r":"
    echo r": and add it to your ${shellRcFile},"
    echo r": so that it's set automatically every time."
    echo r":"
    echo r": Rock on! :)"
    echo r":======================================================================"
    echo r"{CLEAR}".fmt

proc section*(title: string) =
    echo ""
    echo r"-----------------------------------------------------------------------"
    echo " {MAGENTA}●{CLEAR} {title}".fmt
    echo r"-----------------------------------------------------------------------"

proc verifyOS*() : string =
    var currentOS: string

    case hostOS:
        of "windows":       result = "Windows"
        of "macosx":        result = "macOS"
        of "linux":         result = "Linux"
        of "netbsd":        result = "NetBSD"
        of "freebsd":       result = "FreeBSD"
        of "openbsd":       result = "OpenBSD"
        of "solaris":       result = "Solaris"
        of "aix":           result = "AIX"
        of "haiku":         result = "Haiku"
        of "standalone":    result = "Unknown"

    # echo r"{GRAY}Os: {currentOS}{CLEAR}".fmt
    # return currentOS

proc verifyNim*() =
#    if ! command_exists nim ; 
#     then
#                curl https://nim-lang.org/choosenim/init.sh -sSf | sh
#        fi
#    VERS=$(nim -v | grep -o "Version \d\.\d\.\d")
#    NIMV="${VERS/Version /}"
    echo r"{GRAY}Nim version: {NimVersion}{CLEAR}".fmt

################################################################################
# INITIALIZE OPTIONS
################################################################################
# paths and tools
let
    ROOT_DIR = r"./.arturo"
    TARGET_DIR = "{ROOT_DIR}/bin".fmt
    TARGET_FILE = toExe("{TARGET_DIR}/arturo".fmt)
    TARGET_LIB = "{ROOT_DIR}/lib".fmt
    MAIN = "src/arturo.nim"

# variables
var
    BINARY = "bin/arturo"
    COMPILER = "c"
    MINI_BUILD = false
    COMPRESS = true
    PRINT_LOG = false
    RUN_UNIT_TESTS = false
    FOR_WEB = false
    IS_DEV_BUILD = false             

    FLAGS* = "--skipParentCfg:on --colors:off -d:release -d:danger --panics:off --mm:orc --checks:off --overflowChecks:on -d:ssl --passC:-O3 --cincludes:extras --nimcache:.cache --embedsrc:on --path:src"
    CONFIG=""

################################################################################
# FUNCTIONS
################################################################################
proc verifyDirectories() =
    # create target dirs recursively, if not exists
    mkdir TARGET_DIR
    mkdir TARGET_LIB

proc installAll() =
    cpFile(r"{toExe(BINARY)}".fmt, r"{TARGET_FILE}".fmt)
    echo "{GRAY}Deploy files to: {ROOT_DIR}{CLEAR}".fmt
    
proc buildArturo() =
    echo(r"{GRAY}Build version: ".fmt, staticExec(r"cat version/version"), r" ", staticExec(r"cat version/build".fmt))
    echo r"config: {CONFIG}".fmt
    echo r"FLAGS: {FLAGS}".fmt
    echo r""

    if not PRINT_LOG and not IS_DEV_BUILD:
        exec "nim {COMPILER} {FLAGS} -o:{toExe(BINARY)} {MAIN}".fmt
    else:
        exec "nim {COMPILER} {FLAGS} -o:{toExe(BINARY)} {MAIN}".fmt
    echo "{CLEAR}".fmt

proc compressBinary() =
    echo r"{GRAY}Compressing binary:{CLEAR}".fmt
    if FOR_WEB:
        try:
            exec r"uglifyjs {BINARY} -c -m ""toplevel,reserved=['A$']"" -c -o {BINARY}/.js/.min.js".fmt
        except:
            echo "uglifyjs not available"
    else:
        try:
            exec r"upx.exe -q {toExe(BINARY)}".fmt
        except:
            echo "upx not available"

proc miniBuild() =
    MINI_BUILD = true 
    FLAGS.add("{FLAGS} -d:NOASCIIDECODE -d:NOEXAMPLES -d:NOGMP -d:NOPARSERS -d:NOSQLITE -d:NOUNZIP -d:NOWEBVIEW -d:MINI".fmt)

proc buildPackage(package: string) =
    # generate portable data
    writeFile("{package}.data.json".fmt, staticExec(r"arturo --package-info {package}.art".fmt))

    # set environment variables
    putEnv("PORTABLE_INPUT", "{package}.art".fmt)
    putEnv("PORTABLE_DATA", "{package}.data.json".fmt)
        
    BINARY="{package}".fmt
    FLAGS="{FLAGS} --forceBuild:on --opt:size -d:NOEXAMPLES -d:NOERRORLINES -d:PORTABLE".fmt
    echo r"{GRAY}FLAGS: {FLAGS}".fmt
    echo r""

    exec(r"nim c {FLAGS} -o:{toExe(BINARY)} {MAIN}".fmt)
        
    # clean up
    rmFile(r"{package}.data.json".fmt)
    #animate_progress 
    echo "{CLEAR}".fmt

################################################################################
# Check command switches
################################################################################
let userName = if verifyOS() == "Windows": getEnv("USERNAME") else: staticExec("whoami")
IS_DEV_BUILD = if userName == "drkameleon": true else: false

let yes = @["", "on", "1", "x", "yes", "true"]
var 
    p = initOptParser("") 
    package: string
while true:
    p.next()
    case p.kind
    of cmdEnd: break
    of cmdShortOption, cmdLongOption:            
        if p.key in ["log"]:
            PRINT_LOG = true
        if p.key in ["noupx"]:
            COMPRESS = false
        if p.key in ["dev"]:
            IS_DEV_BUILD = true
        if p.key in ["test"]:
            RUN_UNIT_TESTS = true
        if p.key in ["release"]:
            FLAGS = r"{FLAGS} --passC:'-flto'".fmt
        if p.key in ["mini"]:            
            miniBuild()
        if p.key in ["safe"]:
            FLAGS = r"{FLAGS} -d:SAFE".fmt
        if p.key in ["web"]:
            miniBuild()
            FOR_WEB = true
            COMPILER = "js"
            BINARY = r"{BINARY}.js".fmt
            FLAGS = r"{FLAGS} --verbosity:3".fmt
            FLAGS = r"{FLAGS} -d:WEB ".fmt

        if p.key in ["noasciidecode"]: FLAGS = r"{FLAGS} -d:NOASCIIDECODE".fmt
        if p.key in ["noexamples"]: FLAGS = r"{FLAGS} -d:NOEXAMPLES".fmt
        if p.key in ["nogmp"]: FLAGS = r"{FLAGS} -d:NOGMP".fmt
        if p.key in ["noparsers"]: FLAGS = r"{FLAGS} -d:NOPARSERS".fmt
        if p.key in ["nosqlite"]: FLAGS = r"{FLAGS} -d:NOSQLITE".fmt
        if p.key in ["nounzip"]: FLAGS = r"{FLAGS} -d:NOUNZIP".fmt
        if p.key in ["nowebview"]: FLAGS = r"{FLAGS} -d:NOWEBVIEW".fmt
        
        if p.key in ["arm"]: FLAGS = r"{FLAGS} --cpu:arm".fmt
        if p.key in ["arm64"]:
            FLAGS = r"{FLAGS} --cpu:arm64 --gcc.path:/usr/bin".fmt
            FLAGS = r"{FLAGS} --gcc.exe:aarch64-linux-gnu-gcc --gcc.linkerexe:aarch64-linux-gnu-gcc".fmt
        if p.key in ["verbose"]:
            CONFIG = r"verbose {CONFIG}".fmt
            FLAGS = r"{FLAGS} -d:VERBOSE".fmt
        if p.key in ["benchmark"]:
            CONFIG = r"benchmark {CONFIG}".fmt
            FLAGS = r"{FLAGS} -d:BENCHMARK".fmt
        if p.key in ["debug"]:
            COMPRESS = false
            CONFIG = r"debug {CONFIG}".fmt
            FLAGS = r"{FLAGS} -d:DEBUG --debugger:on --debuginfo --linedir:on".fmt
        if p.key in ["profile"]:
            CONFIG = r"profile {CONFIG}".fmt
            FLAGS = r"{FLAGS} -d:PROFILE --profiler:on --stackTrace:on".fmt
    of cmdArgument: package = p.key #discard

if MINI_BUILD:
    CONFIG = r"@mini {CONFIG}".fmt
    FLAGS = r"{FLAGS} --opt:size".fmt
else: 
    CONFIG = r"@full {CONFIG}".fmt
    FLAGS = "{FLAGS} --opt:speed".fmt 

if IS_DEV_BUILD:
    writeFile("version/build", $(readFile("version/build").strip.parseInt + 1))
    exec r"git commit -m 'build update' version/build".fmt
    FLAGS = r"{FLAGS} -d:DEV --listCmd --verbosity:0 --hints:on".fmt

################################################################################
# MAIN
################################################################################
task test, "Run test suite":
    exec r"{TARGET_FILE} ./tools/tester.art".fmt

task verify, "Show nim version":
    section "Checking environment..."
    let currentOS = verifyOS()
    if currentOS == "Windows":
        FLAGS.add(" -d:NOGMP")
    verifyNim()
    
task install, "Copy executable to {TARGET_DIR}".fmt:
    section "Installing..."
    verifyDirectories()
    installAll()

task build, "Build arturo and install executable":
    showHeader "Installer"
    verifyTask()

    try:
        section "Building..."
        buildArturo()

        if COMPRESS: 
            section "Post-processing..."
            compressBinary()

        installTask()
        
        if RUN_UNIT_TESTS:
            testTask()

        section "Done!"
        showFooter()

    except:
        echo "The installer failed :("

    quit(QuitSuccess)

################################################################################
# TODO(package) unify with main install script
#    labels: installer,cleanup
################################################################################
task package, "Package arturo app and build executable":
    showHeader "Packager"
    verifyTask()

    try:
        section "Packaging..."
        buildPackage(package)

        if COMPRESS: 
            section "Post-processing..."
            compressBinary()

        section "Done!"

    except:
        echo "The packager failed :("

    quit(QuitSuccess)

