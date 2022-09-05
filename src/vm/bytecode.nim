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

    import extras/miniz

import os

# when not defined(NOUNZIP):
#     import extras/miniz

import helpers/bytes as bytesHelper

import opcodes
export opcodes

import vm/values/value

#=======================================
# Constants
#=======================================

const 
    #opPushAny   = opPush0..opPush13
    #opStoreAny  = opStore0..opStore13
    opLoadAny   = opLoad0..opLoad13
    #opCallAny   = opCall0..opCall13

    BcodeMagic              = (uint32)0x86BC0DE0
    BcodeMagicCompressed    = (uint32)0x86BC0DE1

#=======================================
# Helpers
#=======================================

template Op(sth: untyped): untyped = (OpCode)(sth)
template By(sth: untyped): untyped = (Byte)(sth)

template skip(steps: int): untyped =
    i.inc(steps)

template current(): untyped = a[i]
template next(): untyped    = 
    while Op(a[i+1]) in [opEol,opEolX]: 
        if Op(a[i+1])==opEol: skip(2)
        else: skip(3)
    a[i+1]

template consume(num: int = 1): untyped =
    result[p] = a[initialI]
    when num > 1:
        result[p+1] = a[initialI+1]
        when num > 2:
            result[p+2] = a[initialI+2]
    p.inc(num)
    i.inc(num)

template inject(what: untyped): untyped =
    result[p] = what
    p.inc()

template keep(): untyped =
    result[p] = current()
    p.inc()

proc optimize(trans: Translation): ByteArray =
    let (_, a) = trans
    var i = 0
    var p = 0
    let aLen = a.len
    newSeq(result, aLen)
    while i < aLen:
        let initial = current
        let initialI = i
        #echo fmt"I = {i} -> {Op(initial)}"
        case Op(initial):
            of opStore0..opStore13: 
                if Op(next) in opLoadAny and By(opLoad)-a[i+1]==By(opStore)-initial:
                    # (opStore*) + (opLoad*) -> (opStorl*)
                    inject(): By(opStorl0) + initial - By(opStore0) 
                    skip(2)
                else:
                    consume(1)
            of opPush0..opPush13, opLoad0..opLoad13:
                if Op(next) == Op(initial):
                    # (opPush/opLoad*) x N -> (opPush/opLoad*) + (opDup) x N
                    keep()
                    while Op(next) == Op(initial):
                        inject(): By(opDup)
                        skip(1)
                    skip(1)
                else:
                    consume(1)

            # of opCall0..opCall29:
            #     let idx = initial - By(opCall0)
            #     echo fmt"found opCall* -> {idx}"
            #     if d[idx].kind==Word and Syms[d[idx].s] == AddF:
            #         inject(): By(opIAdd)
            #         skip(1)
            #     else:
            #         consume(1)

            of opPush,opStore,opLoad,opCall,opStorl,opAttr:
                consume(2)
            of opPushX,opStoreX,opLoadX,opCallX,opStorlX:
                consume(3)
            of opEol:
                skip(2)
            of opEolX:
                skip(3)
            else:
                consume(1)

    result.setLen(p)

#=======================================
# Methods
#=======================================

proc writeBytecode*(dataSeg: string, codeSeg: seq[byte], target: string, compressed = false): bool =
    when not defined(WEB):
        var f = newFileStream(target, fmWrite)
        if not f.isNil:
            var finalDataSeg = dataSeg
            var finalCodeSeg = codeSeg

            if compressed: f.write(BcodeMagicCompressed)
            else: f.write(BcodeMagic)

            if compressed:
                finalDataSeg = compressString(dataSeg)
                finalCodeSeg = compressBytes(codeSeg)

            # write Data Segment
            f.write(len(finalDataSeg))      # first its length
            f.write(finalDataSeg)           # then the segment itself

            # write Code Segment
            f.write(len(finalCodeSeg))      # first its length
            # TODO(VM/bytecode) Do we have to write bytes one by one?
            #  labels: vm, bytecode, enhancement
            for b in finalCodeSeg:          # then the segment itself
                f.write(b)

            f.close()
                    
            return true
        else:
            return false
    else:
        discard

proc readBytecode*(origin: string): (string, seq[byte]) =
    when not defined(WEB):
        var f = newFileStream(origin, fmRead)
        if not f.isNil:
            var magic = f.readUint32()
            var compressed = false
            if magic == BcodeMagicCompressed:
                compressed = true

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

            if compressed:
                dataSegment = uncompressString(dataSegment)
                codeSegment = uncompressBytes(codeSegment)

            return (dataSegment, codeSegment)       # return the result
    else:
        discard

# TODO(VM/bytecode) `optimizeBytecode` should have access to full bytecode
#  that is: including the data segment
#  labels: enhancement, cleanup, vm, bytecode

proc optimizeBytecode*(t: Translation): seq[byte] =
    result = optimize(t)