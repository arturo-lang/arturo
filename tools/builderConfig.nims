
template `---`(key: untyped, val: string): untyped =
    ## A simple modification of `--` for string values.
    switch(strip(astToStr(key)), val)
    
## Builds Related
## --------------


proc undefineDependencies() = 
    ## Undefine  all dependencies
    ## Should be used on MINI and WEB config.
    --define:NOASCIIDECODE      # tags: noasciidecode
    --define:NOCLIPBOARD        # tags: noclipboard
    --define:NODIALOGS          # tags: nodialogs
    --define:NOERRORLINES       # tags: noerrorlines
    --define:NOGMP              # tags: nogmp
    --define:NOPARSERS          # tags: noparsers
    --define:NOSQLITE           # tags: nosqlite
    --define:NOWEBVIEW          # tags: nowebview

proc miniBuildConfig*() =
    --define:MINI
    undefineDependencies()
    
proc safeBuildConfig*() =
    --define:SAFE
    undefineDependencies()
    
proc webBuildConfig*() =
    --define:WEB
    undefineDependencies()