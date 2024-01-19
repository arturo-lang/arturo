
{. push used .}

proc noDepencenciesConfig() =
    --define:NOASCIIDECODE
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
    hint "XDeclaredButNotUsed":on
    noDepencenciesConfig()

proc fullBuildConfig() =
    --define:GMP
    --define:ssl

{. pop .}