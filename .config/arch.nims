
{. push used .}

proc amd64Config() =
    discard

proc arm64Config() =
    --cpu:arm64 
    --gcc.path:"/usr/bin" 
    --gcc.exe:"aarch64-linux-gnu-gcc" 
    --gcc.linkerexe:"aarch64-linux-gnu-gcc"
    
proc x86Config() =
    --verbosity:3
    --cpu:i386 
    --define:bit32
    if defined(gcc): 
        --passC:"'-m32'" 
        --passL:"'-m32'"
        
proc arm32Config() = 
    --verbosity:3
    --cpu:arm 
    --define:bit32
    
{. pop .}