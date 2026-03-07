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

proc configThreads() =
    if not defined(windows):
        --passL:"-pthread"

#=======================================
# Main 
#=======================================

proc main() =
    #--------------------------
    # defaults
    #--------------------------
    --cincludes:extras
    --path:src
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
    --threads:off 
    --skipUserCfg:on 
    --colors:off 
    --define:danger
    --panics:off 
    --mm:orc 
    --define:useMalloc 
    --checks:off
    --cincludes:extras 
    --opt:speed 
    --nimcache:".cache" 
    --path:src

    #--------------------------
    # extra configuration
    #--------------------------
    configMimalloc()
    configWebkit()
    configPCRE()
    configSSL()
    configThreads()

main()