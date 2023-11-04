
import std/os
import std/strformat
import std/strutils

var
    flags*: seq[string] = newSeqOfCap[string](64)
        ## flags represent the flags that will be passed to the compiler.
        ##
        ## Initialize a sequence of initial 64 slots,
        ## what help us to append elements without lose performance.

proc strip(s: string): string {. redefine .} =
    ## (c) Copyright 2015 Andreas Rumpf
    ## This is the copy of the private strip function
    ## from https://github.com/nim-lang/Nim/blob/version-2-0/lib/system/nimscript.nim
    var i = 0
    while s[i] in {' ', '\c', '\n'}: inc i
    result = s.substr(i)
    if result[0] == '"' and result[^1] == '"':
        result = result[1..^2]

template `--`*(key: untyped) {.dirty.} =
    ## Overrides the original ``--`` to append values into ``flags``,
    ## instead of pass direclty to the compiler.
    ## Since this isn't the config.nims file.
    flags.add("--" & strip(astToStr(key)))

template `--`*(key, val: untyped) {.dirty.} =
    ## Overrides the original ``--`` to append values into ``flags``,
    ## instead of pass direclty to the compiler.
    ## Since this isn't the config.nims file.
    flags.add("--" & strip(astToStr(key)) & ":" & strip(astToStr(val)))

template `---`*(key: untyped, val: string): untyped =
    ## A simple modification of `--` for string values.
    flags.add("--" & strip(astToStr(key)) & ":" & val)

proc defineMimalloc() =
    let
        path = projectDir().joinPath("src"/"extras"/"mimalloc")
        sourcePath = path.joinPath("src" / "static.c")
        includePath = path.joinPath("include")

    --define:useMalloc
    ---define:"mimallocStatic={sourcePath}".fmt
    ---define:"mimallocIncludePath={includePath}".fmt

    patchFile("stdlib", "malloc", projectDir()/"src"/"extras"/"mimalloc")

    if get("cc") in ["clang", "gcc", "icc", "icl"]:
        --passC:"-fno-builtin-malloc"

proc buildConfig*() =
    --path:src
    --cincludes:extras
    ---nimcache:projectDir()
                .joinPath(".cache")
                .normalizedPath()
    --skipUserCfg:on
    --skipParentCfg:on
    --colors:off
    --parallelBuild:0

    --define:strip
    --threads:off
    --mm:orc
    defineMimalloc()

    --verbosity:1
    --hints:on
    --define:danger
    --panics:off
    --checks:off

    if "windows" == hostOS:
        --passL:"-pthread"
        ---gcc.path:staticExec("pkg-config --libs-only-L gmp")
            .strip()
            .replace("-L","")
            .replace("/lib","/bin")
            .normalizedPath()[0..^2]

    if get("cc") in ["clang", "gcc", "icc", "icl"]:
        --passC:"-ftls-model=initial-exec"


## OS Related
## ----------

proc staticallyLinkStd() =
    ## Statically link the STD lib for C and C++
    let linking = "\"-static-libstdc++ -static-libgcc " &
                  "-Wl,-Bstatic -lstdc++ " &
                  "-Wl,-Bdynamic\""
    ---passL:linking

proc windowsConfig*(full: bool) =
    ## Configuration for build Windows binaries
    ## The default linker must be g++.

    --gcc.linkerexe:"g++"
    --dynlibOverride:pcre64
    staticallyLinkStd()

    # SSL is only available for @full builds
    if full:
        --define:noOpenSSLHacks
        --define:"sslVersion:("
        --dynlibOverride:"ssl-"
        --dynlibOverride:"crypto-"

proc unixConfig*(macosx: bool, full: bool) =
    ## Configuration for the Unix enviroment
    --passL:"-lm"

    if macosx:
        --dynlibOverride:pcre
    # SSL is only available for @full builds
    if full:
        --dynlibOverride:ssl
        --dynlibOverride:crypto


## CPU/Arch Related
## ----------------

proc arm32Config*() =
    ## Configuration for the 32-bit ARM
    --cpu:arm
    --define:bit32

proc arm64Config*() =
    ## Configuration for the 64-bit ARM
    --cpu:arm64
    --gcc.path:"/usr/bin"
    --gcc.exe:aarch64-linux-gnu-gcc
    --gcc.linkerexe:aarch64-linux-gnu-gcc

proc x86Config*() =
    ## Configuration for the 32-bit x86 family
    --cpu:i386
    --define:bit32

    # -m32 is a GCC flag for compiling it in 32-bits mode.
    if get("cc") == "gcc":
        --passC:"-m32"
        --passL:"-m32"

proc x64Config*() =
    ## Configuration for the 64-bit x86 family
    ## Aka.: AMD64
    --cpu:amd64


## Builds Related
## --------------

proc undefineDependencies() =
    ## Undefine  all dependencies
    ## Should be used on MINI and WEB config.
    --define:NOASCIIDECODE
    --define:NOCLIPBOARD
    --define:NODIALOGS
    --define:NOERRORLINES
    --define:NOGMP
    --define:NOPARSERS
    --define:NOSQLITE
    --define:NOWEBVIEW

proc miniBuildConfig*(bsd: bool) =
    ## Config for @mini build
    ## ``bsd`` is true for 'freebsd', 'openbsd' and 'netbsd'.

    --define:MINI
    undefineDependencies()

    # Verbosity is at the highest value due to common issues
    # related to BSD builds.
    if bsd:
        --verbosity:3

proc safeBuildConfig*() =
    ## Config for @safe build
    ## That runs on the Playground
    --define:SAFE
    undefineDependencies()

proc webBuildConfig*() =
    ## Config for @web build
    --define:WEB
    --verbosity: 3 # Verbosity is at the highest value due to common issues
                   # related to @web builds.
    undefineDependencies()

proc fullBuildConfig*() =
    ## Config for @full build
    --define:ssl


## Profile Related
## ---------------

proc disableHints() =
    --hint:"ProcessingStmt:off"
    --hint:"XCannotRaiseY:off"

proc disableWarnings() =
    --warning:"GcUnsafe:off"
    --warning:"CastSizes:off"
    --warning:"ProveInit:off"
    --warning:"ProveField:off"
    --warning:"Uninit:off"
    --warning:"BareExcept:off"

proc optimizeforSpeed(unix: bool) =
    --define:OPTIMIZED
    --opt:speed
    --define:danger
    --panics:off
    --checks:off
    --define:strip

    if unix:
        --passC:"-flto"
        --passL:"-flto"

proc debugConfig() =
    --define:DEBUG
    --debugger:on
    --debuginfo
    --linedir:on

proc profilerConfig(profiler: string) =
    ## TODO: Discuss what should be used and when.
    if profiler == "none":
        --profiler:off
        return

    --define:PROFILE
    --stackTrace:on

    case profiler
    of "mem":
        --profiler:off
        --define:memProfiler
    of "native":
        --debugger:native
    else:
        discard

proc userConfig*(unix: bool) =
    --hints:off
    --warnings:off
    optimizeforSpeed(unix)

proc devConfig*() =
    --hints:on
    --warnings:on
    --verbosity:3

    disableHints()
    disableWarnings()
    --embedsrc:on
    --define:DEV
    --listCmd
    debugConfig()

proc ciConfig*(unix: bool) =
    optimizeforSpeed(unix)

# proc benchConfig*(unix: bool) =
#     optimizeforSpeed(unix)