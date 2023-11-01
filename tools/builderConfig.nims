
template `---`(key: untyped, val: string): untyped =
    ## A simple modification of `--` for string values.
    switch(strip(astToStr(key)), val)
    
    
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