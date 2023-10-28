
import std/options
export options

## Helper functions for ``builder.nims``
## This file will prove the API and also 
## the functions that manages all complexity of the build system

template section(title: string, description: string, body: untyped): untyped =
    body



section "CLI", "Command Line Interface API related stuff":
    
    type
        OptionArg*[T] = object
            flag: string
            short: Option[string]
            value: T
            possibleValues: Option[seq[string]]

    proc newOptionArg*[T](flag: string, 
                        defaultVal: T, 
                        short: Option[string] = none(string),
                        check: Option[seq[string]] = none(seq[string])
                        ): OptionArg[T] =
                        
        type kind = typeof defaultVal
        if short.isSome:
            var short = some("-" & short.get)
            
        return OptionArg[kind](flag:  "--" & flag, 
                            short: short, 
                            value: defaultVal,
                            possibleValues: check)

    proc parseOptions*(options: seq[OptionArg]) =
        discard

    proc showHelp*(command: string, description: string, options: seq[OptionArg]) =
        discard



section "build", "Build related functions":
    
    type BuildOptions* = tuple
        targetOS: OptionArg[string]
        targetCPU: OptionArg[string] 
        binaryMode: OptionArg[string]
        isDev: OptionArg[bool]
        shouldCompress: OptionArg[bool] 
        shouldInstall: OptionArg[bool] 
        shouldLog: OptionArg[bool]

    proc buildArturo(dist: string, options: BuildOptions) =
        discard