#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: helpers/benchmark.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import std/monotimes, strutils, times

#=======================================
# Templates
#=======================================
    
template benchmark*(benchmarkName: string, code: untyped) =
    block:
        let t0 = getMonoTime()
        code
        let elapsed = float(ticks(getMonoTime()) - ticks(t0))
        let elapsedStr = (elapsed/1000000.0).formatFloat(format = ffDecimal, precision = 3)
        echo "[benchmark] time: ", elapsedStr, "ms"

template getBenchmark*(code: untyped): float =
    let t0 = getMonoTime()
    code
    (float(ticks(getMonoTime()) - ticks(t0)))/1000000.0