# initial conversion to NimScript thanks to:
# - Patrick (skydive241@gmx.de)

# TODO(build.nims) General cleanup needed
#  labels: installer, enhancement, cleanup

#=======================================
# Libraries
#=======================================

import os, parseopt, sequtils
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
    ROOT_DIR        = r"{getHomeDir()}.arturo".fmt
    TARGET_DIR      = r"{ROOT_DIR}/bin".fmt
    TARGET_LIB      = r"{ROOT_DIR}/lib".fmt
    TARGET_STORES   = r"{ROOT_DIR}/stores".fmt
    MAIN            = r"src/arturo.nim"

    # configuration options
    OPTIONS = {
        "arm"               : "--cpu:arm -d:bit32",
        "arm64"             : "--cpu:arm64 --gcc.path:/usr/bin --gcc.exe:aarch64-linux-gnu-gcc --gcc.linkerexe:aarch64-linux-gnu-gcc",
        "debug"             : "-d:DEBUG --debugger:on --debuginfo --linedir:on",
        "dev"               : "--embedsrc:on -d:DEV --listCmd",
        "docgen"            : "-d:DOCGEN",
        "dontcompress"      : "",
        "dontinstall"       : "",
        "full"              : "-d:ssl",
        "log"               : "",
        "memprofile"        : "-d:PROFILE --profiler:off --stackTrace:on --d:memProfiler",
        "mini"              : "",
        "noasciidecode"     : "-d:NOASCIIDECODE",
        "noclipboard"       : "-d:NOCLIPBOARD",
        "nodev"             : "",
        "nodialogs"         : "-d:NODIALOGS",
        "noerrorlines"      : "-d:NOERRORLINES",
        "nogmp"             : "-d:NOGMP",
        "noparsers"         : "-d:NOPARSERS",
        "nosqlite"          : "-d:NOSQLITE",
        "nowebview"         : "-d:NOWEBVIEW",
        "optimized"         : "-d:OPTIMIZED",
        "profile"           : "-d:PROFILE --profiler:on --stackTrace:on",
        "profilenative"     : "--debugger:native",
        "profiler"          : "-d:PROFILER --profiler:on --stackTrace:on",
        "release"           : (when hostOS=="windows": "-d:strip" else: "-d:strip --passC:'-flto' --passL:'-flto'"),
        "safe"              : "-d:SAFE",
        "vcc"               : "",
        "web"               : "--verbosity:3 -d:WEB",
        "x86"               : "--cpu:i386 -d:bit32 " & (when defined(gcc): "--passC:'-m32' --passL:'-m32'" else: ""),  
        "amd64"             : ""
    }.toTable

#=======================================
# Variables
#=======================================

var
    BINARY              = "bin/arturo"
    TARGET_FILE         = toExe(r"{TARGET_DIR}/arturo".fmt)
    COMPILER            = "c"
    INSTALL             = true
    PRINT_LOG           = false
    FOR_WEB             = false
    IS_DEV              = false 
    MODE                = ""       

    FLAGS*              = "--verbosity:1 --hints:on --hint:ProcessingStmt:off --hint:XCannotRaiseY:off --warning:GcUnsafe:off --warning:CastSizes:off --warning:ProveInit:off --warning:ProveField:off --warning:Uninit:off --warning:BareExcept:off --threads:off " & 
                          "--skipUserCfg:on --colors:off -d:danger " &
                          "--panics:off --mm:orc -d:useMalloc --checks:off " &
                          "--cincludes:extras --opt:speed --nimcache:.cache " & (when hostOS != "windows": "--passL:'-pthread' " else: " ") &
                          "--path:src "
    CONFIG              ="@full"

    ARGS: seq[string]   = @[] 

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

    writeFile(outputFile, js)

proc miniBuild*() =
    # all the necessary "modes" for mini builds
    for k in [
        "noasciidecode", 
        "noclipboard",
        "nodialogs",
        "nogmp", 
        "noparsers", 
        "nosqlite", 
        "nowebview"
    ]:
        FLAGS = "{FLAGS} {OPTIONS[k]}".fmt

    # plus, shrinking + the MINI flag
    FLAGS = FLAGS & " -d:MINI"
    if hostOS=="freebsd" or hostOS=="openbsd" or hostOS=="netbsd":
        FLAGS = FLAGS & " --verbosity:3 "

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

    # use VCC for non-MINI Windows builds
    if (hostOS=="windows" and not FLAGS.contains("NOWEBVIEW") and IS_DEV):
        let (_,_) = gorgeEx "src\\extras\\webview\\deps\\build.bat"

    # if hostOS=="windows":
    #     FLAGS = """{FLAGS} --passL:"-static """.fmt & staticExec("pkg-config --libs-only-L libcrypto").strip() & """ -lcrypto -Bdynamic" """.fmt
    #     echo FLAGS
    when defined(windows):
        FLAGS = """{FLAGS}  --passL:"-static-libstdc++ -static-libgcc -Wl,-Bstatic -lstdc++ -Wl,-Bdynamic" --gcc.linkerexe="g++"""".fmt
    else:
        FLAGS = """{FLAGS} --passL:"-lm"""".fmt
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

    installAll()

#=======================================
# Main
#=======================================

# parse command line
var p = initOptParser("") 
while true:
    p.next()

    case p.kind
    of cmdArgument:
        if p.key in ["install"] and MODE == "":
            MODE = p.key
        else:
            showLogo()
            showHelp(error=true, errorMsg="Multiple operations specified!")
        else:
            if p.key in ["e", "./build.nims", "build.nims", "build"]:
                discard
            elif OPTIONS.hasKey(p.key):
                FLAGS = "{FLAGS} {OPTIONS[p.key]}".fmt
                case p.key
                of "dontinstall":
                    INSTALL = false
                of "log":
                    PRINT_LOG = true
                of "mini":
                    miniBuild()
                    CONFIG = "@mini"
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
        if p.key=="as":
            BINARY = "bin/" & p.val
            TARGET_FILE = toExe(r"{TARGET_DIR}/{p.val}".fmt)
        else:
            if p.key != "hints":
                showLogo()
                showHelp(error=true, errorMsg="Erroneous argument supplied!")
    of cmdEnd: 
        break

if CONFIG == "@full":
    FLAGS = FLAGS & " " & OPTIONS["full"]

# show our log anyway
showLogo()

# process accordingly
try:
    case MODE:
        of "install"    :   buildArturo()
        of ""           :   showHelp(error=true, errorMsg=r"No operation specified.")
        else            :   showHelp(error=true, errorMsg=r"Not a valid operation: {MODE}".fmt)
except:
    quit(QuitFailure)

#=======================================
# This is the end,
# my only friend, the end...
#=======================================