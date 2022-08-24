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

import strformat

import helpers/bytes as bytesHelper

import opcodes
export opcodes

#=======================================
# Constants
#=======================================

const 
    #opPushAny   = opPush0..opPush29
    #opStoreAny  = opStore0..opStore29
    opLoadAny   = opLoad0..opLoad29
    #opCallAny   = opCall0..opCall29

#=======================================
# Helpers
#=======================================

template Op(sth: untyped): untyped = (OpCode)(sth)
template By(sth: untyped): untyped = (Byte)(sth)

template current(): untyped = a[i]
template next(): untyped    = a[i+1]

template consume(num: int = 1): untyped =
    result[p] = a[i]
    when num > 1:
        result[p+1] = a[i+1]
        when num > 2:
            result[p+2] = a[i+2]
    p.inc(num)
    i.inc(num)

template inject(what: untyped): untyped =
    result[p] = what
    p.inc()

template keep(): untyped =
    result[p] = current()
    p.inc()

template skip(steps: int): untyped =
    i.inc(steps)

proc optimize(a: ByteArray): ByteArray =
    var i = 0
    var p = 0
    let aLen = a.len
    newSeq(result, aLen)
    while i < aLen:
        #echo fmt"I = {i} -> {Op(current)}"
        case Op(current):
            of opStore0..opStore29: 
                if Op(next) in opLoadAny:
                    # (opStore*) + (opLoad*) -> (opStorl*)
                    inject(): By(opStorl0) + current - By(opStore0) 
                    skip(2)
                else:
                    consume(1)
            of opPush0..opPush29, opLoad0..opLoad29:
                if Op(next) == Op(current):
                    # (opPush/opLoad*) x N -> (opPush/opLoad*) + (opDup) x N
                    let initial = Op(current)
                    keep()
                    skip(1)
                    while Op(current) == initial:
                        inject(): By(opDup)
                        skip(1)
                else:
                    consume(1)

            of opPush,opStore,opLoad,opCall,opStorl,opAttr:
                consume(2)
            of opPushX,opStoreX,opLoadX,opCallX,opStorlX:
                consume(3)
            of opEol:
                skip(3)
            else:
                consume(1)

    result.setLen(p)

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