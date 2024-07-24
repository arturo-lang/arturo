
{. push used .}

proc amd64Config() =
    discard

proc arm64Config() =
    --cpu:arm64 
    if hostOS != "macosx":
        --gcc.path:"/usr/bin" 
        --gcc.exe:"aarch64-linux-gnu-gcc" 
        --gcc.linkerexe:"aarch64-linux-gnu-gcc"
    else:
        --passC:"-I/opt/homebrew/include"
    
proc x86Config() =
    --cpu:i386 
    --define:bit32
    if defined(gcc): 
        --passC:"'-m32'" 
        --passL:"'-m32'"
        
proc arm32Config() = 
    --cpu:arm 
    --define:bit32
    
{. pop .}