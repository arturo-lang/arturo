#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: vm/bundle.nim
#=======================================================

## Bundled executable manager

import os
import osproc
import vm/vm

when defined(DEV):
    import std/private/osdirs

const tmpFolder = 
    when defined(DEV):
        "../_tmpart"
    else:
        "_tmpart"

var runBundler  = static readFile("src/scripts/bundler.art")

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

proc cleanUp() =
    removeDir(tmpFolder)

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

proc generateBundle*(filename: string) =
    echo "- Checking Nim..."
    checkNim()
    echo "- Checking Git..."
    checkGit()
    echo "- Cloning sources..."
    cloneArturo()
    echo "- Cleaning up..."
    cleanUp()
    discard run(runBundler, @[], isFile=false)