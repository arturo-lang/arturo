
{. push used .}

proc releaseConfig() =
    --define:OPTIMIZED
    
    if hostOS=="windows": 
        --define:strip 
    else: 
        --define:strip
        --passC:"'-flto'"
        --passL:"'-flto'"

proc userConfig() =
    releaseConfig()

proc devConfig() =
    --define:DEV 
    --embedsrc:on 
    --listCmd

{. pop .}