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
 
# when defined(windows): 
#     switch("dynlibOverride", "crypto-")
