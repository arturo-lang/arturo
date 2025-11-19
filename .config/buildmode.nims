
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
    --define:useOpenssl3
    if hostOS == "macosx": 
        when defined(arm64):
            --passC:"-I/opt/homebrew/include"
        else:
            --passC:"-I/usr/local/include"
    --define:ssl

proc docgenBuildConfig() =
    fullBuildConfig()
    --define:DOCGEN

proc bundleConfig() =
    --define:BUNDLE
    #--define:NOERRORLINES

{. pop .}