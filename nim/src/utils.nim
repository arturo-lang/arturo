#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: utils.nim
  *****************************************************************]#

import times, os, strutils

#[######################################################
    Methods
  ======================================================]#

template benchmark*(benchmarkName: string, code: untyped) =
    block:
        let t0 = epochTime()
        code
        let elapsed = epochTime() - t0
        let elapsedStr = elapsed.formatFloat(format = ffDecimal, precision = 3)
        echo "CPU Time [", benchmarkName, "] ", elapsedStr, "s"


