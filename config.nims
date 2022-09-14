import os, strutils

# TODO(config.nims) Do we need this?
#  Hopefully, it doesn't mess things up too much; but if it's used - and when - we should know.
#  labels: installer
    
switch("cincludes","extras")
switch("path","src")
switch("hints","off")

if hostOS=="windows":
    switch("gcc.path", normalizedPath(
        staticExec("pkg-config --libs-only-L gmp").strip()
                                                  .replace("-L","")
                                                  .replace("/lib","/bin")
        )
    )

let
    mimallocPath = projectDir() / "extras" / "mimalloc" 
    # Quote the paths so we support paths with spaces
    # TODO: Is there a better way of doing this?
    mimallocStatic = "mimallocStatic=\"" & (mimallocPath / "src" / "static.c") & '"'
    mimallocIncludePath = "mimallocIncludePath=\"" & (mimallocPath / "include") & '"'

# So we can compile mimalloc from the patched files
switch("define", mimallocStatic)
switch("define", mimallocIncludePath)
 
patchFile("stdlib", "malloc", "src" / "extras" / "mimalloc")
# when defined(windows): 
#     switch("dynlibOverride", "crypto-")
