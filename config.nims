import os, strutils

# TODO(config.nims) Do we need this?
#  Hopefully, it doesn't mess things up too much; but if it's used - and when - we should know.
#  labels: installer
    
switch("cincludes","extras")
switch("path","src")
switch("hints","off")

if hostOS=="windows":
    switch("gcc.path", normalizedPath(
        staticExec("/usr/bin/pkg-config --libs-only-L gmp").strip()
                                                  .replace("-L","")
                                                  .replace("/lib","/bin")
        )
    )

let
    mimallocPath = projectDir() / "extras" / "mimalloc" 
    mimallocStatic = "mimallocStatic=\"" & (mimallocPath / "src" / "static.c") & '"'
    mimallocIncludePath = "mimallocIncludePath=\"" & (mimallocPath / "include") & '"'

switch("define", mimallocStatic)
switch("define", mimallocIncludePath)

case get("cc"):
    of "gcc", "clang", "icc", "icl":
        switch("passC", "-ftls-model=initial-exec -fno-builtin-malloc")
    else:
        discard
 
patchFile("stdlib", "malloc", "src" / "extras" / "mimalloc")

when defined(ssl):
  when defined(windows): 
    switch("define", "noOpenSSLHacks")
    switch("define", "sslVersion:(")
    switch("dynlibOverride", "ssl-")
    switch("dynlibOverride", "crypto-")
  else:
    switch("dynlibOverride", "ssl")
    switch("dynlibOverride", "crypto")
