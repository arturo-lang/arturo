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
# Helpers
#=======================================

# proc substitute2to1*(a: ByteArray, subA: OpCode, subB: OpCode, replacement: OpCode): ByteArray =
#     var i = 0
#     var cntr = 0
#     let aLen = a.len
#     newSeq(result, aLen)
#     while i < aLen-2+1:
#         let diffA = a[i] - (Byte)(subA)
#         if diffA >= 0 and diffA <= 29 and diffA == a[i+1] - (Byte)(subB):
#             result[cntr] = (Byte)(replacement) + diffA
#             cntr.inc()
#             i.inc(2)
#         else:
#             result[cntr] = a[i]
#             cntr.inc()
#             i.inc(1)
#     let rest = a[i..^1]
#     for j,it in rest:
#         result[cntr+j] = it
#     result.setLen(cntr + rest.len)

template currentOp(): untyped =
    (OpCode)(a[i])

proc optimize(a: ByteArray): ByteArray =
    var i = 0
    var cntr = 0
    let aLen = a.len
    newSeq(result, aLen)
    while i < aLen:
        #echo "processing: i=" & $(i) & " ("& $((OpCode)a[i]) & ")"
        # let current = (OpCode)(a[i])
        case currentOp:
            of opStore0..opStore29: 
                if a[i+1] in (Byte)(opLoad0)..(Byte)(opLoad29):
                    result[cntr] = (Byte)(opStorl0) + a[i] - (Byte)(opStore0)
                    cntr.inc()
                    i.inc(2)
                else:
                    result[cntr] = a[i]
                    cntr.inc()
                    i.inc(1)
            of opPush,opStore,opLoad,opCall,opStorl,opAttr:
                result[cntr] = a[i]
                result[cntr+1] = a[i+1]
                cntr.inc(2)
                i.inc(2)
            of opPushX,opStoreX,opLoadX,opCallX,opStorlX,opEol:
                result[cntr] = a[i]
                result[cntr+1] = a[i+1]
                result[cntr+2] = a[i+2]
                cntr.inc(3)
                i.inc(3)
            else:
                result[cntr] = a[i]
                cntr.inc()
                i.inc(1)

    result.setLen(cntr)

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

# TODO(VM/bytecode) `optimizeBytecode` should have access to full bytecode
#  that is: including the data segment
#  labels: enhancement, cleanup, vm, bytecode

proc optimizeBytecode*(bc: seq[byte]): seq[byte] =
    result = bc.optimize()