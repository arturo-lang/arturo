#!/usr/bin/env nim

## This file is a prototype of what should be our new API for the CLI builder
## The purpose is to have a better, readable and extensible script for the 
## future implementations.
## 
## Since Artuto may grow or even change dependencies, support or update them,
## make this code easier to change is our best choice.
##
## 
## This file depends on ``tools/builderUtils.nims`` that makes the dirty job.

import "./tools/builderUtils.nims"

cmd build, "Builds Arturo":
    
    ## This is an example of how we should write the tasks when it's finished
    
    ## Example:
    ## 
    ## $ ./builder.nims build --help
    ## 
    ## builder.nims build [OPTIONS]
    ##     Provides a cross-compilation for the Arturo's binary.
    ## 
    ##     --os   <string>
    ##          ["freebsd", "linux", "openbsd", "macosx", "netbsd", "windows"]
    ##     --mode <string> 
    ##          ["full", "mini", "web"]
    ##     --arch <string> 
    ##          ["amd64", "arm", "arm64", "i386", "x86"]
    ##     --dev
    ##     --compress
    ##     --install
    ##     --log
    ##     --help
    const
        availableOSes  = @["freebsd", "linux", "openbsd", "macosx", "netbsd", "windows"]
        availableCPUs  = @["amd64", "arm", "arm64", "i386", "x86"]
        availableModes = @["full", "mini", "web"]
        availableUsers = @["user", "dev", "ci", "bench"]
    var build: BuildOptions = (
        targetOS:    args.getOptionValue("os", default=hostOS, into=availableOSes),
        targetCPU:   args.getOptionValue("arch", default=hostCPU, into=availableCPUs),
        buildConfig: args.getOptionValue("build", short="b", default="full", into=availableModes),
        who:         args.getOptionValue("who", default="user", into=availableUsers),
        
        shouldCompress: args.hasFlag("compress", short="c", default=false),
        shouldInstall:  args.hasFlag("install", short="i", default=false),
        shouldLog:      args.hasFlag("log", short="l", default=false)
    )
    
    "bin/".buildArturo(build)
        
        
    
cmd package, "":
    discard


cmd docs, "Generates documentation":
    discard


cmd tests, "Tests the source code":
    discard


cmd bench, "Benchmarks the source code":
    discard


cmd help, "Prints the help":
    discard