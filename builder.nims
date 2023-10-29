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


task build, "Builds Arturo":
    
    ## This is an example of how we should write the tasks when it's finished
        
    var
        
        targetModes = some @["full", "mini", "web"]
        targetCPUs  = some @["amd64", "arm", "arm64", "i386", "x86"]
        targetOSes  = some @["freebsd", "linux", "openbsd", "macosx", "netbsd", "windows"]
        
        os:       OptionArg[string] = newOptionArg("os",       hostOS,              check=targetOSes)
        mode:     OptionArg[string] = newOptionArg("mode",     "full",  "m".some(), check=targetModes)
        arch:     OptionArg[string] = newOptionArg("arch",     hostCPU, "a".some(), check=targetCPUs)
        devMode:  OptionArg[bool]   = newOptionArg("dev",      false)
        compress: OptionArg[bool]   = newOptionArg("compress", false,   "c".some())
        install:  OptionArg[bool]   = newOptionArg("install",  false,   "i".some())
        log:      OptionArg[bool]   = newOptionArg("log",      false)
        help:     OptionArg[bool]   = newOptionArg("help",     false,   "h".some())
        
    if help.value:
        showHelp(
            command      = "build",
            description = "Provides a cross-compilation for the Arturo's binary",
            options     = @[os, mode, arch, devMode, compress, install, log, help]
        )
        
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
        
        quit QuitSuccess
        
    parseOptions(@[os, mode, arch, devMode, compress, install, log])
    "bin/".buildArturo( 
        BuildOptions(targetOS: os, 
              targetCPU: arch, 
              binaryMode: mode,
              isDev: devMode, 
              shouldCompress: compress, 
              shouldInstall: install, 
              shouldLog: log
        )
    )
        
        
    
task package, "":
    discard


task docs, "Generates documentation":
    discard


task test, "Tests the source code":
    discard


task benchmark, "Benchmarks the source code":
    discard


task help, "Prints the help":
    discard