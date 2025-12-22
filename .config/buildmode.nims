
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
        --passC:"-I/opt/homebrew/include"
        --passC:"-I/opt/local/include"
        --passL:"-L/opt/homebrew/lib"
        --passL:"-L/opt/local/lib"
        --passL:"-Wl,-rpath,/opt/homebrew/lib"
        --passL:"-Wl,-rpath,/opt/local/lib"
    --define:ssl
 
proc docgenBuildConfig() =
    fullBuildConfig()
    --define:DOCGEN

proc bundleConfig() =
    --define:BUNDLE
    #--define:NOERRORLINES

{. pop .}