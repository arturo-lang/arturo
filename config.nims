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
    ## build:
    ##     Provides a cross-compilation for the Arturo's binary.
    ## 
    ##     --arch: string = $hostCPU
    ##          [amd64, arm, arm64, i386, x86]
    ##     --build -b: string = full
    ##          [full, mini, web]
    ##     --os: string = $hostOS
    ##          [freebsd, linux, openbsd, macosx, netbsd, windows]
    ##     --who: string = user
    ##          [bench, ci, dev, user]
    ##     --compress -c
    ##     --install -i
    ##     --log -l
    ##     --help

    const
        availableOSes  = @["freebsd", "linux", "openbsd", "macosx", "netbsd", "windows"]
        availableCPUs  = @["amd64", "arm", "arm64", "i386", "x86"]
        availableModes = @["full", "mini", "web"]
        availableUsers = @["bench", "ci", "dev", "user"]
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
        
        
    
cmd package, "Packages an Arturo app":
    ## package: 
    ##     Packages an Arturo app and build an executable
    ## 
    ##     --help
    discard


cmd docs, "Generates documentation":
    ## docs:
    ##     Generates the documentation
    ## 
    ##     --which: string = both
    ##          [both, internal, user]
    ##     --help
    discard


cmd tests, "Tests the source code":
    ## tests:
    ##     Tests code from tests/ folder
    ## 
    ##     --tolerance: int = 0
    ##     --help
    discard


cmd bench, "Benchmarks the source code":
    ## bench:
    ##     Benchmarks the source code
    ## 
    ##     --help
    discard


cmd help, "Prints the help":
    discard