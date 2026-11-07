
{. push used .}

proc releaseConfig() =
    --define:OPTIMIZED
    --define:strip
    --passC:"-flto"
    --passL:"-flto"

proc userConfig() =
    releaseConfig()

proc devConfig() =
    --define:DEV 
    --embedsrc:on 
    --listCmd

{. pop .}