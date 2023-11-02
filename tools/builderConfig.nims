
import std/os
import std/strformat
import std/strutils

var 
    flags*: seq[string] = newSeqOfCap[string](64)
        ## flags represent the flags that will be passed to the compiler.
        ## 
        ## Initialize a sequence of initial 64 slots,
        ## what help us to append elements without lose performance.

proc strip(s: string): string =
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
        path = projectDir().joinPath("extras"/"mimalloc")
        sourcePath = path.joinPath("src" / "static.c")
        includePath = path.joinPath("include")

    --define:useMalloc
    ---define:"mimallocStatic={sourcePath}".fmt
    ---define:"mimallocIncludePath={includePath}".fmt
    
    patchFile("stdlib", "malloc", "src" / "extras" / "mimalloc")

    # tags: default, (gcc | clang | icc | icl)
    if get("cc") in ["clang", "gcc", "icc", "icl"]:
        --passC:"-fno-builtin-malloc"

proc buildConfig*() =
    --path:src              # tags: default
    --cincludes:extras      # tags: default
    --nimcache:".cache"     # tags: default
    --skipUserCfg:on        # tags: default
    --colors:off            # tags: default

    --define:strip
    --threads:off           # tags: default
    --mm:orc                # tags: default
    defineMimalloc()

    # tags: default, windows-host
    if "windows" == hostOS:
        --passL:"-pthread"
        ---gcc.path:staticExec("pkg-config --libs-only-L gmp")
            .strip()
            .replace("-L","")
            .replace("/lib","/bin")
            .normalizedPath()

    # tags: default, (gcc | clang | icc | icl)
    if get("cc") in ["clang", "gcc", "icc", "icl"]:
        --passC:"-ftls-model=initial-exec"


## OS Related
## ----------

proc staticallyLinkStd() =
    ## Statically link the STD lib for C and C++
    --passL:"-static-libstdc++"
    --passL:"-static-libgcc"
    --passL:"-Wl, -Bstatic -lstdc++"
    --passL:"-Wl, -Bdynamic"

proc windowsConfig*(full: bool) =
    ## Configuration for build Windows binaries
    ## The default linker must be g++.

    --gcc.linkerexe:g++
    --dynlibOverride:pcre64             # tags: default, windows
    staticallyLinkStd()

    # SSL is only available for @full builds
    if full:
        --define:noOpenSSLHacks         # tags: default, windows, ssl
        --define:"sslVersion:("         # tags: default, windows, ssl
        --dynlibOverride:"ssl-"         # tags: default, windows, ssl
        --dynlibOverride:"crypto-"      # tags: default, windows, ssl

proc unixConfig*(macosx: bool, full: bool) =
    ## Configuration for the Unix enviroment
    --passL:"-lm"                   # tags: default, unix

    if macosx:
        --dynlibOverride:pcre       # tags: default, macosx
    # SSL is only available for @full builds
    if full:
        --dynlibOverride:ssl        # tags: default, unix, ssl
        --dynlibOverride:crypto     # tags: default, unix, ssl


## CPU/Arch Related
## ----------------

proc arm32Config*() =
    ## Configuration for the 32-bit ARM
    --cpu:arm           # tags: arm32
    --define:bit32      # tags: arm32

proc arm64Config*() =
    ## Configuration for the 64-bit ARM
    --cpu:arm64                                 # tags: arm64
    --gcc.path:"/usr/bin"                       # tags: arm64
    --gcc.exe:aarch64-linux-gnu-gcc             # tags: arm64
    --gcc.linkerexe:aarch64-linux-gnu-gcc       # tags: arm64

proc x86Config*() =
    ## Configuration for the 32-bit x86 family
    --cpu:i386              # tags: x86
    --define:bit32          # tags: x86

    # -m32 is a GCC flag for compiling it in 32-bits mode.
    if get("cc") == "gcc":
        --passC:"-m32"      # tags: x86, gcc
        --passL:"-m32"      # tags: x86, gcc

proc x64Config*() =
    ## Configuration for the 64-bit x86 family
    ## Aka.: AMD64
    --cpu:amd64


## Builds Related
## --------------

proc undefineDependencies() =
    ## Undefine  all dependencies
    ## Should be used on MINI and WEB config.
    --define:NOASCIIDECODE      # tags: noasciidecode
    --define:NOCLIPBOARD        # tags: noclipboard
    --define:NODIALOGS          # tags: nodialogs
    --define:NOERRORLINES       # tags: noerrorlines
    --define:NOGMP              # tags: nogmp
    --define:NOPARSERS          # tags: noparsers
    --define:NOSQLITE           # tags: nosqlite
    --define:NOWEBVIEW          # tags: nowebview

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
    --hint:ProcessingStmt:off       # tags: default
    --hint:XCannotRaiseY:off        # tags: default

proc disableWarnings() =
    --warning:GcUnsafe:off          # tags: default
    --warning:CastSizes:off         # tags: default
    --warning:ProveInit:off         # tags: default
    --warning:ProveField:off        # tags: default
    --warning:Uninit:off            # tags: default
    --warning:BareExcept:off        # tags: default

proc optimizeforSpeed(unix: bool) =
    --define:OPTIMIZED      # tags: optimized
    --opt:speed             # tags: default
    --define:danger         # tags: default
    --panics:off            # tags: default
    --checks:off            # tags: default
    --define:strip          # tags: release

    if unix:
        --passC:"-flto"     # tags: release, unix
        --passL:"-flto"     # tags: release, unix

proc debugConfig() =
    --define:DEBUG      # tags: debug
    --debugger:on       # tags: debug
    --debuginfo         # tags: debug
    --linedir:on        # tags: debug

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
    --embedsrc:on           # tags: dev
    --define:DEV            # tags: dev
    --listCmd               # tags: dev
    debugConfig()

proc ciConfig*(unix: bool) =
    optimizeforSpeed(unix)

# proc benchConfig*(unix: bool) =
#     optimizeforSpeed(unix)