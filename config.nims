#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: config.nims
#=======================================================

#=======================================
# Libraries
#=======================================

import os, strutils

#=======================================
# Helpers
#=======================================

proc configMimalloc() =
    let
        mimallocPath = projectDir() / "extras" / "mimalloc"
        mimallocStatic = "mimallocStatic=\"" & (mimallocPath / "src" / "static.c") & '"'
        mimallocIncludePath = "mimallocIncludePath=\"" & (mimallocPath / "include") & '"'

    --define:useMalloc 
    switch "define", mimallocStatic
    switch "define", mimallocIncludePath

    if get("cc") in @["gcc", "clang", "icc", "icl"]:
        --passC:"-ftls-model=initial-exec -fno-builtin-malloc"

    "stdlib".patchFile("malloc"):
        "src"/"extras"/"mimalloc"
 

proc configPCRE() =
    if defined(windows):
        --dynlibOverride:pcre64
    else:
        --dynlibOverride:pcre

proc configWebkit() =
    if not (defined(linux) or defined(freebsd)):
        return

    const webkitVersions = ["4.1", "4.0"]

    proc getWebkitVersion(): string =
        let testPkg = gorgeEx("which pkg-config")
        if testPkg.exitCode != 0:
            # pkg-config not found
            # probably because we are not on Ubuntu
            if defined(freebsd):
                return "41"
            else:
                return "4.1"

        for version in webkitVersions:
            let ret = gorgeEx("pkg-config --exists webkit2gtk-" & version)
            if ret.exitCode == 0:
                if version == "4.0" or version == "40":
                    --define:"LEGACYUNIX"
                return version

        if defined(freebsd):
            return "41"
        else:
            return "4.1"  # fallback if none found

    switch "define", "webkitVersion=" & getWebkitVersion()

proc configSSL() =
    if not defined(ssl):
        return

    if defined(windows):
        --define:"noOpenSSLHacks"
        --define:"sslVersion:("
        --dynlibOverride:"ssl-"
        --dynlibOverride:"crypto-"
    else:
        --dynlibOverride:ssl
        --dynlibOverride:crypto

proc configMath() =
    if not defined(windows):
        --passL:"-lm"

proc configPlatform() =
    if hostOS == "macosx":
        # Headers
        --passC:"-I/opt/homebrew/include"      # ARM64 Homebrew
        --passC:"-I/usr/local/include"         # Intel Homebrew
        --passC:"-I/opt/local/include"         # MacPorts

        # Library paths
        --passL:"-L/opt/homebrew/lib"          # ARM64 Homebrew
        --passL:"-L/usr/local/lib"             # Intel Homebrew
        --passL:"-L/opt/local/lib"             # MacPorts

        # Runtime search paths
        --passL:"-Wl,-rpath,/opt/homebrew/opt/mpfr/lib"
        --passL:"-Wl,-rpath,/opt/homebrew/opt/gmp/lib"
        --passL:"-Wl,-rpath,/usr/local/opt/mpfr/lib"
        --passL:"-Wl,-rpath,/usr/local/opt/gmp/lib"
        --passL:"-Wl,-rpath,/opt/local/lib"

        --passL:"-Wl,-headerpad_max_install_names"

    elif defined(windows):
        --passL:"-static-libstdc++ -static-libgcc -Wl,-Bstatic -lstdc++ -Wl,-Bdynamic"
        --gcc.linkerexe:"g++"

proc configThreads() =
    --threads:off
    if not defined(windows):
        --passL:"-pthread"

#=======================================
# Main 
#=======================================

proc main() =
    #--------------------------
    # paths
    #--------------------------
    --path:src
    --cincludes:extras
    --nimcache:".cache" 

    #--------------------------
    # compiler flags
    #--------------------------
    --skipUserCfg:on 
    --define:danger
    --panics:off 
    --mm:orc 
    --checks:off
    --opt:speed 
    
    #--------------------------
    # logging
    #--------------------------
    --hints:on
    --verbosity:1
    hint "ProcessingStmt":off
    hint "XCannotRaiseY":off
    hint "ConvFromXtoItselfNotNeeded":off
    warning "GcUnsafe":off
    warning "CastSizes":off
    warning "ProveInit":off
    warning "ProveField":off
    warning "Uninit":off
    warning "BareExcept":off
    --colors:off 

    #--------------------------
    # extra configuration
    #--------------------------
    configMimalloc()
    configMath()
    configWebkit()
    configPCRE()
    configSSL()
    configPlatform()
    configThreads()

main()