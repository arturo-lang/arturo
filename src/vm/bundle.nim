#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: vm/bundle.nim
#=======================================================

## Bundled executable manager

import osproc
import vm/vm

const tmpFolder = "_tmpart"

var runBundler  = static readFile("src/scripts/bundler.art")

proc commandExists(cmd: string) =
    let (_, exitCode) = execCmdEx("[ -x \"$(command -v " & cmd & ")\" ]")
    if exitCode != 0:
        echo "`" & cmd & "` command required; cannot proceed!"
        quit(1)

proc checkNim() = commandExists("nim")
proc checkGit() = commandExists("git")

proc cloneArturo() =
    let (_, res) = execCmdEx("git clone https://github.com/arturo-lang/arturo.git " & tmpFolder)
    if res != 0:
        echo "something went wrong when cloning Arturo sources..."
        quit(1)

proc generateBundle*(filename: string) =
    checkNim()
    checkGit()
    cloneArturo()
    discard run(runBundler, @[], isFile=false)