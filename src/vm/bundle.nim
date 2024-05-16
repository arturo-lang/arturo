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
    import options, os, osproc
    import sequtils, strutils

    when defined(DEV):
        import std/private/osdirs

    import helpers/path

    import vm/values/[types, custom/vsymbol]
    import vm/[globals, vm, parse, packager]

#=======================================
# Types
#=======================================

type
    BundleConfig = ref object
        imports:        OrderedTable[string,string]
        packages:       OrderedTable[string,string]
        symbols:        seq[string]
        miniPossible:   bool

#=======================================
# Constants
#=======================================

when not defined(BUNDLE):
    const tmpFolder = 
        when defined(DEV): "../_tmpart"
        else:              "_tmpart"

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
    proc analyzeFile(conf: BundleConfig, filename: string, isFirst: bool = false)

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
            echo "`" & cmd & "` command required; cannot proceed!"
            quit(1)

    proc startVM() =
        var str = ""
        discard run(str, @[], isFile=false)

    proc analyzeBlock(conf: BundleConfig, filename: string, bl: ValueArray) =
        let prefix = if filename == "": "" else: filename & "/"
        let (dir, name, ext) = splitFile(filename)
        var i = 0
        while i < bl.len:
            
            let item = bl[i]

            if item.kind == Word:
                if (let symv = Syms.getOrDefault(item.s, nil); not symv.isNil):
                    if symv.kind == Function or ((not symv.info.isNil) and (symv.info.module != "")):
                        conf.symbols.add(item.s)

                if i+1 < bl.len:
                    let nextItem = bl[i+1]
                    var afterNextItem = VNULL
                    if i+2 < bl.len:
                        afterNextItem = bl[i+2]

                    if item.s == "import":
                        #echo "importing @ " & pathStack[^1]
                        if nextItem.kind in {Literal, String}:
                            if (let res = getEntryForPackage(nextItem.s, (true, NoPackageVersion), "main", false); res.isSome):
                                let src = res.get()
                                #echo "Found package import: " & src
                                let content = readFile(src)
                                if src.contains("packages/cache"):
                                    conf.packages[nextItem.s] = ":" & src.split("packages/cache/")[^1]
                                    conf.imports[":" & src.split("packages/cache/")[^1]] = content
                                else:
                                    conf.imports[src] = content
                                conf.analyzeFile(src)
                            
                        elif afterNextItem.kind != Null and ((nextItem.kind == Symbol and nextItem.m == dotslash) or (nextItem.kind == Word and nextItem.s == "relative")):
                            let fname = joinPath(pathStack[^1], afterNextItem.s)
                            #echo "looking for: " & fname
                            if (let res = getEntryForPackage(fname, (true, NoPackageVersion), "main", false); res.isSome):
                                let src = res.get()
                                #echo "Found file import: " & fname
                                let content = readFile(src)
                                if src.contains("packages/cache"):
                                    conf.imports[":" & src.split("packages/cache/")[^1]] = content
                                else:
                                    conf.imports[src] = content
                                #result[fname] = content
                                conf.analyzeFile(src)
                    elif item.s == "read":
                        if afterNextItem.kind != Null and ((nextItem.kind == Symbol and nextItem.m == dotslash) or (nextItem.kind == Word and nextItem.s == "relative")):
                            let fname = joinPath(pathStack[^1], afterNextItem.s)

                            let content = readFile(fname)
                            if fname.contains("packages/cache"):
                                conf.imports[":" & fname.split("packages/cache/")[^1]] = content
                            else:
                                conf.imports[fname] = content
            elif item.kind in {Inline, Block}:
                conf.analyzeBlock(filename, item.a)

            i += 1

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
            copyDirRecursively(getCurrentDir(), tmpFolder)
        else:
            let (_, res) = execCmdEx("git clone https://github.com/arturo-lang/arturo.git " & tmpFolder)
            if res != 0:
                echo "something went wrong when cloning Arturo sources..."
                quit(1)

    proc analyzeFile(conf: BundleConfig, filename: string, isFirst: bool = false) =
        let (dir, name, ext) = splitFile(filename)
        pathStack.add(dir)
        let parsed = doParse(filename, isFile=true)
        conf.analyzeBlock((if isFirst: "" else: filename), parsed.a)
        pathStack.delete((pathStack.len-1)..(pathStack.len-1))
    
    proc buildExecutable(conf: BundleConfig, filename: string) =
        let currentFolder = getCurrentDir()
        setCurrentDir(tmpFolder)

        let fileDetails = parsePathComponents(filename)
        let binName = fileDetails["filename"].s

        let (_, res) = execCmdEx("./build.nims build " & binName & " --bundle --mode mini --as " & binName)
        if res != 0:
            echo "Something went wrong went building the project..."
            quit(1)

        copyFile(tmpFolder / "bin" / binName, currentFolder / binName)

        setCurrentDir(currentFolder)

    proc cleanUp() =
        removeDir(tmpFolder)

    proc generateBundle*(filename: string) =
        section "Firing up the VM":
            startVM()

        section "Checking Nim":
            checkNim()

        section "Checking Git":
            checkGit()
        
        section "Cloning Arturo":
            cloneArturo()
        
        var conf = BundleConfig()
        section "Analyzing source code":
            conf.analyzeFile(filename, isFirst=true)
        

        
        
        conf.symbols = deduplicate(bundleConfig.symbols)

        for k,v in conf.imports.pairs():
            echo "----------------------------------"
            echo "|" & k & "|"
            echo "----------------------------------"

        echo "PACKAGES!"

        for k,v in conf.packages.pairs():
            echo "----------------------------------"
            echo " " & k & " -> " & v
            echo "----------------------------------"


        echo "$$ SYMBOLS"
        var modules: seq[string]
        for f in conf.symbols:
            echo "-> " & f

            let symv = Syms[f]
            if not symv.info.isNil:
                modules.add(symv.info.module)

        modules = deduplicate(modules)

        echo ">> MODULES"
        for m in modules:
            echo "-> " & m
            #echo v
            #echo "\n"
        # for k in keys(Syms):
        #     echo $(k)
        
        # section "Building executable":
        #     conf.buildExecutable(filename)
        
        # section "Cleaning up":
        #     cleanUp()
    