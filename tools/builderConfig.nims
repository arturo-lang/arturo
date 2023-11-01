
template `---`(key: untyped, val: string): untyped =
    ## A simple modification of `--` for string values.
    switch(strip(astToStr(key)), val)
    
    
## OS Related
## ----------


proc staticallyLinkStd() =
    --passL:"-static-libstdc++"
    --passL:"-static-libgcc"
    --passL:"-Wl, -Bstatic -lstdc++"
    --passL:"-Wl, -Bdynamic"

proc windowsConfig*(full: bool) =
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
    --dynlibOverride:ssl        # tags: default, unix, ssl
    --dynlibOverride:crypto     # tags: default, unix, ssl
    
    if macosx:
        --dynlibOverride:pcre       # tags: default, macosx
    
## CPU/Arch Related
## ----------------

proc arm32Config*() =
    --cpu:arm           # tags: arm32
    --define:bit32      # tags: arm32
    
proc arm64Config*() =
    --cpu:arm64                                 # tags: arm64
    --gcc.path:"/usr/bin"                       # tags: arm64
    --gcc.exe:aarch64-linux-gnu-gcc             # tags: arm64
    --gcc.linkerexe:aarch64-linux-gnu-gcc       # tags: arm64
    
proc x86Config*(gcc: bool) =
    --cpu:i386              # tags: x86
    --define:bit32          # tags: x86
    if gcc:
        --passC:"-m32"      # tags: x86, gcc
        --passL:"-m32"      # tags: x86, gcc

proc x64Config*() =
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

proc miniBuildConfig*() =
    --define:MINI
    undefineDependencies()
    
proc safeBuildConfig*() =
    --define:SAFE
    undefineDependencies()
    
proc webBuildConfig*() =
    --define:WEB
    --verbosity: 3
    undefineDependencies()
    
proc fullBuildConfig*() =
    --define:ssl