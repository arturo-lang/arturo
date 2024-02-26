
{. push used .}

proc noDepencenciesConfig() =
    --define:NOCLIPBOARD
    --define:NODIALOGS
    --define:NOPARSERS
    --define:NOSQLITE
    --define:NOWEBVIEW

proc miniBuildConfig() =
    --define:MINI
    noDepencenciesConfig()

proc safeBuildConfig() =
    --define:SAFE
    noDepencenciesConfig()

proc webBuildConfig() =
    --define:WEB
    noDepencenciesConfig()

proc fullBuildConfig() =
    --define:GMP
    when defined(arm64):
        if hostOS == "macosx": 
            --define:useOpenssl3
    --define:ssl

{. pop .}