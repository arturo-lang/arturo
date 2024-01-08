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


proc configGMPOnWindows() =
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

proc configMacosPCRE() =
    --dynlibOverride:pcre

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
    configGMPOnWindows()
    configMimalloc()

    if defined(windows):
        configWinPCRE()

    if defined(macosx):
        configMacosPCRE()

    if defined(windows) and defined(ssl):
        configWinSSL()

    if not defined(windows) and defined(ssl):
        configUnixSSL()

main()