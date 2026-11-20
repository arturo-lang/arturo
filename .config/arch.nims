
{. push used .}

# the CPU we're building for: hostCPU isn't reliable
# for that (e.g. on Windows arm64, it says amd64)
var targetCPU = hostCPU

proc amd64Config() =
    targetCPU = "amd64"

proc arm64Config() =
    --cpu:arm64 
    targetCPU = "arm64"
    
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