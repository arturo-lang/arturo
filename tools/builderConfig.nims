
template `---`(key: untyped, val: string): untyped =
    ## A simple modification of `--` for string values.
    switch(strip(astToStr(key)), val)
    
    
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
    
proc unixConfig*(macosx: bool) =
    ## Configuration for the Unix enviroment
    --dynlibOverride:ssl        # tags: default, unix, ssl
    --dynlibOverride:crypto     # tags: default, unix, ssl
    
    if macosx:
        --dynlibOverride:pcre       # tags: default, macosx
    
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
    
proc x86Config*(gcc: bool) =
    ## Configuration for the 32-bit x86 family
    --cpu:i386              # tags: x86
    --define:bit32          # tags: x86
    
    # -m32 is a GCC flag for compiling it in 32-bits mode. 
    if gcc:
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