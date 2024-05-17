#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: vm/bundler.nim
#=======================================================

## Bundled executable manager

#=======================================
# Libraries
#=======================================

import algorithm, tables
import vm/[values/value]

import options, os
import osproc, sequtils, strutils

import std/private/ospaths2

when defined(DEV):
    import std/private/osdirs

import helpers/io
import helpers/jsonobject

import vm/values/[types, custom/vsymbol]
import vm/[globals, vm, parse, packager]

#=======================================
# Types
#=======================================

type
    BundleConfig = ref object
        name        :   string
        curpath     :   string

        main        :   string
        files       :   Table[string,string]
        aliases     :   Table[string,string]
        symbols     :   seq[string]
        modules     :   seq[string]
        noMini      :   bool

#=======================================
# Constants
#=======================================

const 
    BundleSuffix = "_bundle.json"

    TmpFolder       = 
        when defined(DEV): "../_tmpart"
        else:              "_tmpart"
    
    PackageCache    = "aliases/cache/"

    ImportCall      = "import"
    RelativeCall    = "relative"
    ReadCall        = "read"

    Implicit        = @[
        "any?", "array", "ensure", "is?",
        "get", "set", "let",  
        "sys", "script", "terminal"              
    
    ]

    MiniKillers     = @[
        "close", "open", "query",                       # Database
        "mail",                                         # Net
        "alert", "clip", "dialog", "unclip", "webview"  # Ui
    ]

#=======================================
# Variables
#=======================================

var
    pathStack: seq[string]

when defined(WEB):
    var stdout: string = ""

#=======================================
# Forward declarations
#=======================================

proc analyzeFile(conf: BundleConfig, filename: string)

#=======================================
# Helpers
#=======================================

when defined(WEB):
    proc write(buffer: var string, str: string) =
        buffer &= str
    
    proc flushFile(buffer: var string) =
        echo buffer

template section(msg: string, blk: untyped): untyped =
    stdout.write "- " & msg & "..."
    stdout.flushFile()

    blk

    stdout.write " OK\n"
    stdout.flushFile()

proc copyDirRecursively(source: string, dest: string) =
    createDir(dest)
    for kind, path in walkDir(source):
        var noSource = splitPath(path).tail
        if noSource != ".git":
            if kind == pcDir:
                copyDirRecursively(path, dest / noSource)
            else:
                copyFile(path, dest / noSource, {cfSymlinkAsIs})

proc commandExists(cmd: string) =
    let (_, exitCode) = execCmdEx("[ -x \"$(command -v " & cmd & ")\" ]")
    if exitCode != 0:
        echo "\t`" & cmd & "` command required; cannot proceed!"
        quit(1)

proc startVM() =
    var str = ""
    discard run(str, @[], isFile=false)

proc isPackageFile(p: string): bool =
    return p.contains(PackageCache)

proc cleanedPath(conf: BundleConfig, p: string): string =
    if not p.isPackageFile():
        return relativePath(p, conf.curpath)

    return ":" & p.split(PackageCache)[^1]

proc relativePathTo(p: string): string =
    joinPath(pathStack[^1], p)

proc isRelativeCall(v: Value): bool =
    (v.kind == Symbol and v.m == dotslash) or 
    (v.kind == Word and v.s == RelativeCall)

proc isStdlibSymbol(v: Value): bool =
    v.kind == Function or 
    ((not v.info.isNil) and (v.info.module != ""))

proc configFile(conf: BundleConfig): string =
    conf.name & BundleSuffix

proc analyzeBlock(conf: BundleConfig, filename: string, bl: ValueArray) =
    let prefix = if filename == "": "" else: filename & "/"
    var i = 0
    while i < bl.len:
        
        let item = bl[i]

        case item.kind:
            of Word:
                if (let symv = Syms.getOrDefault(item.s, nil); not symv.isNil):
                    if symv.isStdlibSymbol():
                        conf.symbols.add(item.s)

                if MiniKillers.contains(item.s):
                    conf.noMini = true

                if i+1 < bl.len:
                    let nextItem = bl[i+1]
                    var afterNextItem = VNULL
                    if i+2 < bl.len:
                        afterNextItem = bl[i+2]

                    if item.s == ImportCall:
                        if nextItem.kind in {Literal, String}:
                            if (let res = getEntryForPackage(nextItem.s, (true, NoPackageVersion), "main", false); res.isSome):
                                let src = res.get()

                                let clean = conf.cleanedPath(src)
                                conf.files[clean] = readFile(src)

                                if src.isPackageFile():
                                    conf.aliases[nextItem.s] = clean

                                conf.analyzeFile(src)
                            
                        elif afterNextItem.kind != Null and nextItem.isRelativeCall():
                            let fname = relativePathTo(afterNextItem.s)
                            if (let res = getEntryForPackage(fname, (true, NoPackageVersion), "main", false); res.isSome):
                                let src = res.get()

                                conf.files[conf.cleanedPath(src)] = readFile(src)
                                conf.analyzeFile(src)

                    elif item.s == ReadCall:
                        if afterNextItem.kind != Null and nextItem.isRelativeCall():
                            let fname = relativePathTo(afterNextItem.s)
                            conf.files[conf.cleanedPath(fname)] = readFile(fname)
        
            of Symbol:
                if (let aliased = Aliases.getOrDefault(item.m, NoAliasBinding); aliased != NoAliasBinding):
                    if (let symv = Syms.getOrDefault(aliased.name.s, nil); not symv.isNil):
                        if symv.isStdlibSymbol():
                            conf.symbols.add(aliased.name.s)

            of Inline, Block:
                conf.analyzeBlock(filename, item.a)

            else:
                discard

        i += 1

template pushpopPath(newPath: string, action: untyped): untyped =
    pathStack.add(newPath)
    action
    pathStack.delete((pathStack.len-1)..(pathStack.len-1))

proc analyzeFile(conf: BundleConfig, filename: string) =
    let (dir, _, _) = splitFile(filename)
    pushpopPath dir:
        conf.analyzeBlock(filename, doParse(filename, isFile=true).a)

#=======================================
# Methods
#=======================================

proc checkNim() = commandExists("nim")
proc checkGit() = commandExists("git")

proc cloneArturo() =
    when defined(DEV):
        copyDirRecursively(getCurrentDir(), TmpFolder)
    else:
        let (_, res) = execCmdEx("git clone https://github.com/arturo-lang/arturo.git " & TmpFolder)
        if res != 0:
            echo "\tsomething went wrong when cloning Arturo sources..."
            quit(1)

proc analyzeSources(filename: string): BundleConfig =
    let (dir, name, _) = splitFile(filename)

    result = BundleConfig()

    result.name = name
    result.curpath = dir
    result.main = readFile(filename)
    result.files = initTable[string,string]()
    result.aliases = initTable[string,string]()

    pushpopPath dir:
        result.analyzeBlock("", doParse(filename, isFile=true).a)

    result.symbols &= Implicit

    result.symbols = sorted(deduplicate(result.symbols))
    result.modules = sorted(deduplicate(result.symbols.map(
        proc (z: string): string =
            Syms[z].info.module
    )))

proc saveConfiguration(conf: BundleConfig) =
    let output = {
        "name"      : newString(conf.name),
        "main"      : newString(conf.main),
        "files"   : newStringDictionary(conf.files),
        "aliases"  : newStringDictionary(conf.aliases),
        "symbols"   : newStringBlock(conf.symbols),
        "modules"   : newStringBlock(conf.modules)
    }.toOrderedTable

    writeToFile(joinPath(@[TmpFolder, conf.configFile()]), jsonFromValueDict(output))

proc debug(conf: BundleConfig) =
    echo "\tFound " & $(conf.symbols.len) & " stdlib symbols:"
    for s in conf.symbols:
        echo "\t\t- " & s

    echo ""
    echo "\tFrom " & $(conf.modules.len) & " stdlib modules:"
    for m in conf.modules:
        echo "\t\t- " & m

    echo ""
    echo "\tBuild can be mini?"
    echo "\t\t- " & $(not conf.nomini)

    echo ""
    echo "\tFound " & $(conf.files.len) & " files:"
    for k,v in conf.files.pairs():
        echo "\t\t- " & k

    echo ""
    echo "\tFound " & $(conf.aliases.len) & "aliases:"
    for k,v in conf.aliases.pairs():
        echo "\t\t- " & k & " -> " & v
        

proc buildExecutable(conf: BundleConfig, filename: string) =
    let currentFolder = getCurrentDir()
    setCurrentDir(TmpFolder)

    let mode = 
        if conf.nomini: ""
        else: "--mode mini"

    let (outp, res) = execCmdEx("./build.nims build " & conf.configFile() & " --bundle " & mode & " --as " & conf.name)
    if res != 0:
        echo "\tSomething went wrong went building the project..."
        echo outp
        quit(1)

    copyFile(TmpFolder / "bin" / conf.name, currentFolder / conf.name)

    setCurrentDir(currentFolder)

proc cleanUp() =
    removeDir(TmpFolder)

#=======================================
# Main entry point
#=======================================

proc generateBundle*(filename: string) =
    section "Firing up the VM":
        startVM()

    section "Checking Nim":
        checkNim()

    section "Checking Git":
        checkGit()
    
    section "Cloning Arturo":
        cloneArturo()
    
    var conf: BundleConfig
    section "Analyzing source code":
        conf = analyzeSources(filename)

    section "Saving configuration":
        conf.saveConfiguration()
        
    when defined(DEV):
        conf.debug()
    
    section "Building executable":
        conf.buildExecutable(filename)
    
    # section "Cleaning up":
    #     cleanUp()
