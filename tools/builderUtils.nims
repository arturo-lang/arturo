
import std/sequtils
import std/strutils
import std/strformat
import std/cmdline
import std/macros
import std/os

import "./builderConfig.nims"

## Helper functions for ``builder.nims``
## This file will prove the API and also 
## the functions that manages all complexity of the build system

## CLI Related
## -----------

let 
    args* = commandLineParams()
    command = paramStr(2)
 
echo command                  

proc getOptionValue*(args: seq[string], cmd: string, default: string,
                     short: string = "", into: seq[string] = @[]): string =
    ## Gets an optional argument's value
    ## example, for ``--who rick``, the returned value will be ``rick``,
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
          
iterator getDocs(impl: string): string =
    ## Return the documentation of any implementation
    ## 
    ## This iterates until the end of the documentation block.
    var found = false
    for line in impl.splitLines():
        let cleanline = line.strip()
        if cleanline.startsWith("##"):
            yield cleanline[3 .. cleanline.high]
            found = true
        # Don't iterate until the end of the implementation,
        # Just until the end of the impl's documentation
        elif found:
            break
        
template help(ident: typed) =
    ## Prints the documentation from a identifier.
    ## 
    ## Params
    ## ------
    ## ident: typed
    ##      the identifier, can be any declared implementation.
    ##
    ## Usage
    ## -----
    ## ..code-block:: nim
    ##      help getOptionValue
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
    
    if command ==? astToStr(name):
        if args.hasFlag("help", short="h"):
            help `name Task`
            quit QuitSuccess
        else:
            `name Task`()
    

## Build related
## -------------
    
type BuildOptions* = tuple
    targetOS, targetCPU, buildConfig, who: string
    shouldCompress, shouldInstall, shouldLog: bool

proc compile(
        source: string, dest: string, flags: seq[string], log: bool,
        backend: string = "c"
    ) =
    let 
        params = flags.join(" ")
        cmd = fmt"nim {backend} {params} --out:{dest} {source.normalizedPath}"
    if log:
        echo cmd, "\n\n"
        exec cmd
    else:
        (msg, code) = gorgeEx cmd
        if code != QuitSuccess:
            quit msg, QuitFailure
            
            
proc copyWebView(root: string, to: string, is32Bits: bool) =
    let 
        bitsMode = if is32Bits: "x86" else: "x64"
        binPath = root/to
        webviewPath = root/"src"/"extras"/"webview"/"deps"/bitsMode
        
    for dll in ["webview.dll", "WebView2Loader.dll"]:
        cpFile webviewPath/dll, binPath/dll
            
proc installBinary(binary: string, is32Bits: bool) =
    
    let 
        rootDir      = projectDir()
        targetDir    = getHomeDir().joinPath(".arturo")
        
        win = hostOS != "windows"
        unix = not win
    
    proc createDirs(dir: string) =
        mkdir dir
        for path in ["bin", "lib", "store"]:
            mkdir dir/path
    
    proc enableExecutablePermissions(binary: string) =
        let bin = targetDir.joinPath(binary.toExe)
        exec fmt"chmod +x {bin}"
        
    # Creates the directories into "~/.arturo/"
    targetDir.createDirs()
    
    # Copies webview dll to /bin
    if win:
        rootDir.copyWebView(to="bin", is32Bits=is32Bits)

    # Copies from /bin/ to ~/.arturo/bin/
    cpDir rootDir/"bin", targetDir/"bin"
    
    # For unix systems, the binary needs executable permissions
    if unix:
        binary.enableExecutablePermissions()
        

proc buildWebViewOnWindows(full: bool, dev: bool) =
    echo "\nBuilding webview...\n"
    const batPath = projectDir()
                    .joinPath("src"/"extras"/"webview"/"deps"/"build.bat")
                    .normalizedPath()
    let 
        vcc = "vcc" == get("cc")
        win = "windows" == hostOS

    if [win, dev, full, vcc].allIt(it):
        exec batPath

proc buildArturo*(dist: string, build: BuildOptions) =
    let
        unix: bool = not build.targetOS.contains("win")
        bsd: bool = build.targetOS.contains("bsd")
        macosx: bool = build.targetOS.contains("mac")
        full: bool = build.buildConfig == "full"
        web: bool = build.buildConfig == "web"
        
        dev: bool = build.who in ["dev", "ci"]
        
        is32Bits: bool = not build.targetCPU.contains("64")

    buildConfig()
    
    case build.who
    of "user":
        userConfig(unix)
    of "dev":
        devConfig()
    of "ci":
        ciConfig(unix)
    else:
        discard
    
    if unix:
        unixConfig(macosx, full)
    else:
        windowsConfig(full)
        
    case build.targetCPU
    of "amd64", "x64", "x86-64":
        x64Config()
    of "x86", "x86-32":
        x86Config()
    of "arm", "arm32":
        arm32Config()
    of "arm64":
        arm64Config()
    else:
        discard
    
    case build.buildConfig
    of "mini":
        miniBuildConfig(bsd)
    of "web":
        webBuildConfig()
    of "safe":
        safeBuildConfig()
    of "full":
        fullBuildConfig()
    else:
        discard
    
    if web:
        "src/arturo.nim".compile(
            dest=dist/"arturo.js",
            flags=flags, 
            log=build.shouldLog
            backend="js"
        )
    else:
        let binPath = dist/"arturo".toExe()
        buildWebViewOnWindows(full, dev)
        "src/arturo.nim".compile(
            dest=binPath,
            flags=flags, 
            log=build.shouldLog
        )
        
        if build.shouldInstall:
            binPath.installBinary(is32Bits)