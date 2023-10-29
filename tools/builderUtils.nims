
import std/strutils
import std/strformat
import std/cmdline
import std/macros

## Helper functions for ``builder.nims``
## This file will prove the API and also 
## the functions that manages all complexity of the build system

## CLI Related
## -----------

let 
    args* = commandLineParams()
    command = paramStr(2)

proc getOptionValue*(args: seq[string], cmd: string, default: string,
                     short: string = "", into: seq[string] = @[]): string =
    ## Gets an optional argument's value
    ## example, for ```--who rick``, the returned value will be ``rick``,
    ## otherwhise, if the flag is not found, it'll return the ``default``
    ## 
    ## This procedure has side effects and ends the application if the user
    ## write something wrong.
    result = default
    
    template isFlag(arg: string): bool =
        arg.startsWith("-")
        
    template flagFound(arg: string): bool =
        arg in [fmt"-{short}", fmt"--{cmd}"]
        
    func hasMissingValue(args: seq[string], currIdx: int): bool =    
        result = false
        if currIdx >= args.high:
            return true
        if args[currIdx.succ].isFlag():
            return true
        
    let allowGenericArgument: bool = into.len == 0

    for idx, arg in args:
        if not arg.isFlag() or not arg.flagFound():
            continue
        
        if args.hasMissingValue(idx):
            quit fmt"Missing value for --{cmd}.", QuitFailure
        
        let next = args[idx.succ]
        if allowGenericArgument or next in into:
            return next
        quit fmt"{next} isn't into {into} for --{cmd}.", QuitFailure
                 

func hasFlag*(args: seq[string], cmd: string, 
              short: string = "", 
              default: bool = false): bool =
    ## Returns true if some flag was found
    result = false
    for arg in args:
        if not arg.startsWith("-"):
            continue
        if arg in [fmt"-{short}", fmt"--{cmd}"]:
            return true


macro implementationToStr(id: typed): string =
    id.getImpl.toStrLit
  
proc getDocs(impl: string): seq[string] =
    result = @[]
    for line in impl.splitLines():
        let cleanline = line.strip()
        if cleanline.startsWith("##"):
            result.add cleanline[2 .. cleanline.high]
        # Don't iterate until the end of the implementation,
        # Just until the end of the impl's documentation
        elif result.len > 0:
            return
        
template help(ident: typed) =
  for line in ident.implementationToStr.getDocs():
    echo line
        
template `==?`(a, b: string): bool = cmpIgnoreStyle(a, b) == 0
template cmd*(name: untyped; description: string; body: untyped): untyped =
    ## This is a modification of the original ``task`` by (c) Copyright 2015 Andreas Rumpf
    ## original source: https://github.com/nim-lang/Nim/blob/805b4e2dc2afddf7be27e32fe0543e4227b31f74/lib/system/nimscript.nim#L390
    ##
    ## Reason: ``task``s were not working with optional arguments, 
    ## so I removed the ``getCommand``, and replaced it by paramStr(2) 
    ## defined by ``command``
    proc `name Task`*() =
        body

    let task = command
    if task ==? "help" or args.hasFlag("help", short="h"):
        help `name Task`
        quit QuitSuccess

    if task ==? astToStr(name):
        `name Task`()
    

## Build related
## -------------
    
type BuildOptions* = tuple
    targetOS, targetCPU, buildConfig, who: string
    shouldCompress, shouldInstall, shouldLog: bool

proc buildArturo*(dist: string, build: BuildOptions) =
    echo build
    
    