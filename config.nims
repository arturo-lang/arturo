import os, strutils

proc defaultConfig() =
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
    if hostOS != "windows": 
        --passL:"-pthread"
    --path:src


proc configGMPOnWindows() {.used.} =
    if "windows" == hostOS:
        let gccPath = staticExec("pkg-config --libs-only-L gmp")
                        .strip()
                        .replace("-L","")
                        .replace("/lib","/bin")
                        .normalizedPath()
        switch "gcc.path", gccPath


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
 

proc configWinPCRE() =
    --dynlibOverride:pcre64

proc configUnixPCRE() =
    --dynlibOverride:pcre

proc configWebkit() =
    const webkitVersions = ["4.1", "4.0"]

    proc getWebkitVersion(): string =
        let testPkg = gorgeEx("which pkg-config")
        if testPkg.exitCode != 0:
            # pkg-config not found
            # probably because we are not on Ubuntu
            if defined(freebsd):
                return "40"
            return "4.0"

        for version in webkitVersions:
            let ret = gorgeEx("pkg-config --exists webkit2gtk-" & version)
            if ret.exitCode == 0:
                return version

        if defined(freebsd):
            return "40"
        return "4.0"  # fallback if none found

    switch "define", "webkitVersion=" & getWebkitVersion()

proc configWinSSL() =
    --define:"noOpenSSLHacks"
    --define:"sslVersion:("
    --dynlibOverride:"ssl-"
    --dynlibOverride:"crypto-"

proc configUnixSSL() =
    --dynlibOverride:ssl
    --dynlibOverride:crypto

proc main() =
    defaultConfig()
    # see: https://github.com/arturo-lang/arturo/pull/1643
    # configGMPOnWindows()    
    configMimalloc()

    if defined(linux) or defined(freebsd):
        configWebkit()

    if defined(windows):
        configWinPCRE()
    else:
        configUnixPCRE()

    if defined(ssl):
        if defined(windows):
            configWinSSL()
        elif not defined(freebsd):
            configUnixSSL()

main()
