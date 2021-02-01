######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: vm/errors.nim
######################################################

#=======================================
# Libraries
#=======================================

import vm/value

type ReturnTriggered* = object of Defect

#=======================================
# Templates
#=======================================

template showConversionError*():untyped =
    echo "cannot convert argument of type :" & ($(y.kind)).toLowerAscii() & " to :" & ($(x.t)).toLowerAscii()

template invalidConversionError*(origin: string):untyped =
    echo "cannot convert " & origin & " to :" & ($(x.t)).toLowerAscii()

