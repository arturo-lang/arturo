######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: helpers/benchmark.nim
######################################################

#=======================================
# Libraries
#=======================================

import strutils, times

#=======================================
# Templates
#=======================================

template benchmark*(benchmarkName: string, code: untyped) =
    block:
        let t0 = epochTime()
        code
        let elapsed = epochTime() - t0
        let elapsedStr = elapsed.formatFloat(format = ffDecimal, precision = 3)
        echo "[benchmark] time: ", elapsedStr, "s"