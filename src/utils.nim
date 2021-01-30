######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: utils.nim
######################################################

#=======================================
# Libraries
#=======================================

import strutils, times

#=======================================
# Constants
#=======================================

const
    # colors
    fgCyan*      = "\e[0;36m"
    fgGray*      = "\e[0;90m"
    fgGreen*     = "\e[1;32m"
    fgRed*       = "\e[1;31m"
    fgMagenta*   = "\e[1;35m"
    fgWhite*     = "\e[0m" 
    
    fgBold*      = "\e[1m"

#=======================================
# Helpers
#=======================================

proc showDebugHeader*(title: string) =
    echo "======================================================="
    echo "== " & title
    echo "======================================================="

template benchmark*(benchmarkName: string, code: untyped) =
    block:
        let t0 = epochTime()
        code
        let elapsed = epochTime() - t0
        let elapsedStr = elapsed.formatFloat(format = ffDecimal, precision = 3)
        echo "[benchmark] time: ", elapsedStr, "s"
