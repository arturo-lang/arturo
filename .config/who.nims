
{. push used .}

proc releaseConfig() =
    --define:OPTIMIZED

    # temporary: for measuring PGO on the CI
    for pgoFlag in getEnv("PGO_FLAGS").split(' '):
        if pgoFlag != "":
            flags.add("--passC:" & pgoFlag)
            flags.add("--passL:" & pgoFlag)
    
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