
{. push used .}

proc miniBuildConfig() =
    --define:MINI
    
    --define:NOASCIIDECODE
    --define:NOCLIPBOARD
    --define:NODIALOGS
    --define:NOGMP
    --define:NOPARSERS
    --define:NOSQLITE
    --define:NOWEBVIEW

proc safeBuildConfig() =
    --define:SAFE

proc webBuildConfig() =
    --verbosity:3
    --define:WEB

proc fullBuildConfig() =
    --define:ssl

{. pop .}