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

import std/monotimes, strutils, times

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

template getBenchmark*(code: untyped): float =
    let t0 = epochTime()
    code
    epochTime() - t0
    
template betterBenchmark*(benchmarkName: string, code: untyped) =
    block:
        let t0 = getMonoTime()
        code
        let elapsed = (float)(ticks(getMonoTime()) - ticks(t0))
        let elapsedStr = (elapsed/(float)1000000).formatFloat(format = ffDecimal, precision = 3)
        echo "[benchmark] time: ", elapsedStr, "ms"

template getBetterBenchmark*(code: untyped): float =
    let t0 = getMonoTime()
    code
    ((float)(ticks(getMonoTime()) - ticks(t0)))/(float)(1000000)