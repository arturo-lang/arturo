######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/bytecode.nim
######################################################

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import streams

import helpers/bytes as bytesHelper

import opcodes
export opcodes

#=======================================
# Methods
#=======================================

# TODO(Bytecode) Re-visit bytecode reading & writing
#  Right now, we're using Nim's "marshalling". This looks a bit unnecessary.
#  labels: enhancement, cleanup, vm

proc writeBytecode*(dataSeg: string, codeSeg: seq[byte], target: string): bool =
    when not defined(WEB):
        var f = newFileStream(target, fmWrite)
        if not f.isNil:
            f.write(len(dataSeg))
            f.write(dataSeg)
            f.write(len(codeSeg))
            for b in codeSeg:
                f.write(b)
            f.flush

            return true
        else:
            return false
    else:
        discard

proc readBytecode*(origin: string): (string, seq[byte]) =
    when not defined(WEB):
        var f = newFileStream(origin, fmRead)
        if not f.isNil:
            var sz: int
            f.read(sz)                      # read data segment size

            var dataSegment: string
            f.readStr(sz, dataSegment)      # read the data segment contents

            f.read(sz)                      # read code segment size

            var codeSegment = newSeq[byte](sz)
            var indx = 0
            while not f.atEnd():
                codeSegment[indx] = f.readUint8()   # read bytes one-by-one
                indx += 1

            return (dataSegment, codeSegment)       # return the result
    else:
        discard

proc optimizeBytecode*(bc: seq[byte]): seq[byte] =
    result = bc.substitute2to1r((opStore0, opLoad0), opStorl0)