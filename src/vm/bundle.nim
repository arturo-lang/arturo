#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: vm/bundle.nim
#=======================================================

## Bundled executable manager

#=======================================
# Libraries
#=======================================

import tables
import vm/[values/value]

when not defined(BUNDLE):
    import algorithm, options, os
    import osproc, sequtils, strutils

    when defined(DEV):
        import std/private/osdirs

    import helpers/io
    import helpers/jsonobject
    import helpers/path

    import vm/values/[types, custom/vsymbol]
    import vm/[globals, vm, parse, packager]

#=======================================
# Types
#=======================================

type
    BundleConfig = ref object
        name:           string
        main:           string
        imports:        Table[string,string]
        packages:       Table[string,string]
        symbols:        seq[string]
        modules:        seq[string]
        noMini:         bool

#=======================================
# Constants
#=======================================

const 
    BundleSuffix = "_bundle.json"

when not defined(BUNDLE):
    const 
        TmpFolder       = 
            when defined(DEV): "../_tmpart"
            else:              "_tmpart"
        
        PackageCache    = "packages/cache/"

        ImportCall      = "import"
        RelativeCall    = "relative"
        ReadCall        = "read"

        MiniKillers     = @[
            "close", "open", "query",                       # Database
            "mail",                                         # Net
            "alert", "clip", "dialog", "unclip", "webview"  # Ui
        ]

#=======================================
# Variables
#=======================================

when defined(BUNDLE):
    var
        Bundle*: ValueDict

else:
    var
        pathStack: seq[string]

when defined(WEB):
    var stdout: string = ""

#=======================================
# Forward declarations
#=======================================

when not defined(BUNDLE):
    proc analyzeFile(conf: BundleConfig, filename: string)

#=======================================
# Helpers
#=======================================

when not defined(BUNDLE):

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

    proc cleanedPath(p: string): string =
        if not p.isPackageFile():
            return p

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

                                    let clean = cleanedPath(src)
                                    conf.imports[clean] = readFile(src)

                                    if src.isPackageFile():
                                        conf.packages[nextItem.s] = clean

                                    conf.analyzeFile(src)
                                
                            elif afterNextItem.kind != Null and nextItem.isRelativeCall():
                                let fname = relativePathTo(afterNextItem.s)
                                if (let res = getEntryForPackage(fname, (true, NoPackageVersion), "main", false); res.isSome):
                                    let src = res.get()

                                    conf.imports[cleanedPath(src)] = readFile(src)
                                    conf.analyzeFile(src)

                        elif item.s == ReadCall:
                            if afterNextItem.kind != Null and nextItem.isRelativeCall():
                                let fname = relativePathTo(afterNextItem.s)
                                conf.imports[cleanedPath(fname)] = readFile(fname)
            
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

when defined(BUNDLE):
    
    proc getBundledResource*(identifier: string): Value =
        Bundled[identifier]

else:

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
        result = BundleConfig()

        result.name = 
        result.main = readFile(filename)
        result.imports = initTable[string,string]()
        result.packages = initTable[string,string]()

        let (dir, _, _) = splitFile(filename)
        pushpopPath dir:
            result.analyzeBlock("", doParse(filename, isFile=true).a)

        result.symbols = sorted(deduplicate(result.symbols))
        result.modules = sorted(deduplicate(result.symbols.map(
            proc (z: string): string =
                Syms[z].info.module
        )))

    proc saveConfiguration(conf: BundleConfig) =
        let output = {
            "name"      : newString(conf.name),
            "main"      : newString(conf.main),
            "imports"   : newStringDictionary(conf.imports),
            "packages"  : newStringDictionary(conf.packages),
            "symbols"   : newStringBlock(conf.symbols),
            "modules"   : newStringBlock(conf.modules)
        }.toOrderedTable

        writeToFile(conf.configFile(), jsonFromValueDict(output))

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
        echo "\tFound " & $(conf.imports.len) & " imports:"
        for k,v in conf.imports.pairs():
            echo "\t\t- " & k

        echo ""
        echo "\tOf them, " & $(conf.packages.len) & " being packages:"
        for k,v in conf.packages.pairs():
            echo "\t\t- " & k & " -> " & v
            

    proc buildExecutable(conf: BundleConfig, filename: string) =
        let currentFolder = getCurrentDir()
        setCurrentDir(TmpFolder)

        let mode = 
            if conf.nomini: ""
            else: "--mode mini"

        let (_, res) = execCmdEx("./build.nims build " & conf.configFile() & " --bundle " & mode & " --as " & conf.name)
        if res != 0:
            echo "\tSomething went wrong went building the project..."
            quit(1)

        copyFile(TmpFolder / "bin" / conf.name, currentFolder / conf.name)

        setCurrentDir(currentFolder)

    proc cleanUp() =
        removeDir(TmpFolder)

    #---------------------------------------
    # Main entry point
    #---------------------------------------

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
        
        # section "Building executable":
        #     conf.buildExecutable(filename)
        
        section "Cleaning up":
            cleanUp()
    