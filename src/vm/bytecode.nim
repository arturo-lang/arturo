#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: vm/bytecode.nim
#=======================================================

## Module for manipulation Arturo's bytecode

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import streams

    import extras/miniz

import opcodes
export opcodes

#=======================================
# Constants
#=======================================

when not defined(WEB):
    const
        BcodeMagic              = uint32(0x86BC0DE0)
        BcodeMagicCompressed    = uint32(0x86BC0DE1)

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
            f.write(len(finalDataSeg))                              # first its length
            f.write(finalDataSeg)                                   # then the segment itself

            # write Code Segment
            f.write(len(finalCodeSeg))                              # first its length
            f.writeData(addr(finalCodeSeg[0]), finalCodeSeg.len)    # write code segment

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
            f.read(sz)                                      # read data segment size

            var dataSegment: string
            f.readStr(sz, dataSegment)                      # read the data segment contents

            f.read(sz)                                      # read code segment size

            var codeSegment = newSeq[byte](sz)
            discard f.readData(addr(codeSegment[0]), sz)    # read the code segment contents

            if compressed:
                dataSegment = uncompressString(dataSegment)
                codeSegment = uncompressBytes(codeSegment)

            return (dataSegment, codeSegment)               # return the result
    else:
        discard