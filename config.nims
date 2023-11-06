import os, strutils

# TODO(config.nims) Do we need this?
#  Hopefully, it doesn't mess things up too much; but if it's used - and when - we should know.
#  labels: installer
    
--cincludes:extras
--path:src
--hints:off

if "windows" == hostOS:
    let gccPath = staticExec("pkg-config --libs-only-L gmp")
                    .strip()
                    .replace("-L","")
                    .replace("/lib","/bin")
                    .normalizedPath()
    switch "gcc.path", gccPath    
                       
                       
let
    mimallocPath = projectDir() / "extras" / "mimalloc" 
    mimallocStatic = "mimallocStatic=\"" & (mimallocPath / "src" / "static.c") & '"'
    mimallocIncludePath = "mimallocIncludePath=\"" & (mimallocPath / "include") & '"'

switch "define", mimallocStatic
switch "define", mimallocIncludePath

case get("cc"):
    of "gcc", "clang", "icc", "icl":
        --passC:"-ftls-model=initial-exec -fno-builtin-malloc"
    else:
        discard
 
patchFile("stdlib", "malloc", "src" / "extras" / "mimalloc")

when defined(windows): 
    --dynlibOverride:"pcre64"

    when defined(ssl):
        --define:"noOpenSSLHacks"
        --define:"sslVersion:("
        --dynlibOverride:"ssl-"
        --dynlibOverride:"crypto-"
else:
    when defined(macosx):
        --dynlibOverride:pcre

    when defined(ssl):
        --dynlibOverride:ssl
        --dynlibOverride:crypto
