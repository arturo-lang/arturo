
{. push used .}

# the CPU we're building for: hostCPU isn't reliable
# for that (e.g. on Windows arm64, it says amd64)
var targetCPU = hostCPU

proc amd64Config() =
    targetCPU = "amd64"

proc arm64Config() =
    --cpu:arm64 
    targetCPU = "arm64"
    
{. pop .}