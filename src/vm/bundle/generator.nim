#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: vm/bundle/generator.nim
#=======================================================

## Bundled executable generator

#=======================================
# Libraries
#=======================================

import algorithm, options, os, osproc
import sequtils, strutils, sugar, tables

import std/private/ospaths2

when defined(DEV):
    import std/private/osdirs

import helpers/io
import helpers/jsonobject

import vm/[globals, vm, exec, parse, packager]
import vm/values/[value, types]
import vm/values/custom/[vlogical, vsymbol]

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
    
    PackageCache    = "packages/cache/"

    ImportCall      = "import"
    RelativeCall    = "relative"
    ReadCall        = "read"
    DoCall          = "do"
    DictionaryCall  = "dictionary"

    MiniKillers     = @[
        "close", "open", "query",                       # Database
        "mail",                                         # Net
        "alert", "clip", "dialog", "unclip", "webview"  # Ui
    ]

#=======================================
# Variables
#=======================================

var
    pathStack           : seq[string] = @[]

    forceMini           : bool = false
    forceFull           : bool = false
    forceImplicit       : seq[string] = @[]
    forceFlags          : string = ""

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
    if findExe(cmd) == "":
        echo "\t`" & cmd & "` command required; cannot proceed!"
        quit(1)
    # let (_, exitCode) = execCmdEx("[ -x \"$(command -v " & cmd & ")\" ]")
    # if exitCode != 0:
    #     echo "\t`" & cmd & "` command required; cannot proceed!"
    #     quit(1)

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
       
                    elif item.s == DoCall:
                        if afterNextItem.kind != Null and nextItem.isRelativeCall():
                            let fname = relativePathTo(afterNextItem.s)
                            conf.files[conf.cleanedPath(fname)] = readFile(fname)

                    elif item.s == DictionaryCall:
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

            of Path:
                conf.symbols.add("get")

                if (let symv = Syms.getOrDefault(item.p[0].s, nil); not symv.isNil):
                    if symv.isStdlibSymbol():
                        conf.symbols.add(item.p[0].s)

            of PathLabel:
                conf.symbols.add("set")

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

proc addImplicit(syms: var seq[string]) =
    if syms.contains("define"):
        syms.add(@["ensure", "function", "if", "greater?", "equal?", "return", "neg", "to"])

    if syms.contains("function") or syms.contains("method"):
        syms.add(@["any?", "array", "is?", "ensure"])

    if syms.contains("add"):
        syms.add(@["inc", "mul"])

    if syms.contains("sub"):
        syms.add("dec")

#=======================================
# Methods
#=======================================

proc checkInfo(filepath: string): string =
    if not dirExists(filepath):
        return filepath

    var entryFile: string = filepath
    let possibleInfoFile = joinPath(@[filepath, "info.art"])
    if fileExists(possibleInfoFile):
        let info = execDictionary(doParse(possibleInfoFile, isFile=true))
        if (var execPath = info.getOrDefault("executable", nil); not execPath.isNil):
            entryFile = joinPath(@[filepath, execPath.s])
            let (_, _, ext) = splitFile(entryFile)
            if ext == "":
                entryFile &= ".art"

    let possibleBundleFile = joinPath(@[filepath, "bundle.info.art"])
    if fileExists(possibleBundleFile):
        let bundleInfo = execDictionary(doParse(possibleBundleFile, isFile=true))
        
        if (let forceMiniOption = bundleInfo.getOrDefault("mini", nil); not forceMiniOption.isNil):
            forceMini = forceMiniOption.b == True

        if (let forceFullOption = bundleInfo.getOrDefault("full", nil); not forceFullOption.isNil):
            forceFull = forceFullOption.b == True

        if (let forceImplicitOption = bundleInfo.getOrDefault("implicit", nil); not forceImplicitOption.isNil):
            forceImplicit = forceImplicitOption.a.map((z)=>z.s)

        if (let forceFlagsOption = bundleInfo.getOrDefault("flags", nil); not forceFlagsOption.isNil):
            forceFlags = forceFlagsOption.s

        if (let forceEntryOption = bundleInfo.getOrDefault("entry", nil); not forceEntryOption.isNil):
            entryFile = joinPath(@[filepath, forceEntryOption.s])

    if not fileExists(entryFile):
        echo "\tentry file not valid: " & entryFile
        quit(1)

    return entryFile

proc lookForNim() = commandExists("nim")
proc lookForGit() = commandExists("git")

proc cloneArturo() =
    removeDir(TmpFolder)
    when defined(DEV):
        copyDirRecursively(getCurrentDir(), TmpFolder)
    else:
        let (_, res) = execCmdEx("git clone https://github.com/arturo-lang/arturo.git " & TmpFolder)
        if res != 0:
            echo "\tsomething went wrong when cloning Arturo sources..."
            quit(1)

proc analyzeSources(filename: string, target: string): BundleConfig =
    let (dir, name, _) = splitFile(filename)

    result = BundleConfig()
    result.name = 
        if target == "": name
        else: target
    result.curpath = dir
    result.main = readFile(filename)
    result.files = initTable[string,string]()
    result.aliases = initTable[string,string]()

    pushpopPath dir:
        result.analyzeBlock("", doParse(filename, isFile=true).a)

    result.symbols.addImplicit()
    result.symbols &= forceImplicit

    result.symbols = sorted(deduplicate(result.symbols))
    result.modules = sorted(deduplicate(result.symbols.map(
        proc (z: string): string =
            Syms[z].info.module
    )))

proc saveConfiguration(conf: BundleConfig) =
    let output = {
        "name"      : newString(conf.name),
        "main"      : newString(conf.main),
        "files"     : newStringDictionary(conf.files),
        "aliases"   : newStringDictionary(conf.aliases),
        "symbols"   : newStringBlock(conf.symbols),
        "modules"   : newStringBlock(conf.modules)
    }.toOrderedTable

    writeToFile(joinPath(@[TmpFolder, conf.configFile()]), jsonFromValueDict(output))

when defined(DEV):
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
        echo "\tFound " & $(conf.aliases.len) & " aliases:"
        for k,v in conf.aliases.pairs():
            echo "\t\t- " & k & " -> " & v
        
proc buildExecutable(conf: BundleConfig) =
    let currentFolder = getCurrentDir()
    setCurrentDir(TmpFolder)

    var mode = 
        if conf.nomini: ""
        else: "--mode mini"

    if forceMini:
        mode = "--mode mini"

    if forceFull:
        mode = ""

    let (outp, err) = execCmdEx("nim build.nims build " & conf.configFile() & " --bundle " & mode & " " & forceFlags & " --log --as " & conf.name)

    if err != 0:
        echo "\tSomething went wrong went building the project..."
        echo outp
        quit(1)

    setCurrentDir(currentFolder)

    let finalName =
        when defined(windows):
            conf.name & ".exe"
        else:
            conf.name

    copyFile(TmpFolder / "bin" / finalName, currentFolder / finalName)

proc cleanUp() =
    removeDir(TmpFolder)

#=======================================
# Main entry point
#=======================================

proc generateBundle*(filepath: string, target: string) =
    section "Firing up the VM":
        startVM()

    var entryFile: string
    section "Checking information":
        entryFile = checkInfo(filepath)

    section "Looking for Nim":
        lookForNim()

    section "Looking for Git":
        lookForGit()
    
    section "Cloning Arturo":
        cloneArturo()
    
    var conf: BundleConfig
    section "Analyzing source code":
        conf = analyzeSources(entryFile, target)

    section "Saving configuration":
        conf.saveConfiguration()
        
    when defined(DEV):
        conf.debug()
    
    section "Building executable":
        conf.buildExecutable()
    
    section "Cleaning up":
        cleanUp()
