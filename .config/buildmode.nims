
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
        # Headers
        --passC:"-I/opt/homebrew/include"      # ARM64 Homebrew
        --passC:"-I/usr/local/include"         # Intel Homebrew
        --passC:"-I/opt/local/include"         # MacPorts
        
        # Library paths
        --passL:"-L/opt/homebrew/lib"          # ARM64 Homebrew
        --passL:"-L/usr/local/lib"             # Intel Homebrew
        --passL:"-L/opt/local/lib"             # MacPorts
        
        # Runtime search paths
        --passL:"-Wl,-rpath,/opt/homebrew/opt/mpfr/lib"
        --passL:"-Wl,-rpath,/opt/homebrew/opt/gmp/lib"
        --passL:"-Wl,-rpath,/usr/local/opt/mpfr/lib"
        --passL:"-Wl,-rpath,/usr/local/opt/gmp/lib"
        --passL:"-Wl,-rpath,/opt/local/lib"
        
        --passL:"-Wl,-headerpad_max_install_names"
    --define:ssl
    --define:DOCGEN

proc docgenBuildConfig() =
    fullBuildConfig()
    --define:DOCGEN

proc bundleConfig() =
    --define:BUNDLE
    #--define:NOERRORLINES

{. pop .}