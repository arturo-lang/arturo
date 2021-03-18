######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: vm/bytecode.nim
######################################################

#=======================================
# Libraries
#=======================================

import hashes

import vm/types

#=======================================
# Types 
#=======================================

#=======================================
# Methods
#=======================================

# proc writeBytecode*(trans: Translation, target: string): bool =
#     let marshaled = $$(trans[0])
#     let bcode = trans[1]

#     var f = newFileStream(target, fmWrite)
#     if not f.isNil:
#         f.write(len(marshaled))
#         f.write(marshaled)
#         f.write(len(bcode))
#         for b in bcode:
#             f.write(b)
#         f.flush

#         return true
#     else:
#         return false

# proc readBytecode*(origin: string): Translation =
#     var f = newFileStream(origin, fmRead)
#     if not f.isNil:
#         var s: int
#         f.read(s)           # read constants size
#         var t: string
#         f.readStr(s,t)      # read the marshaled constants

#         f.read(s)           # read bytecode size

#         var bcode: ByteArray = newSeq[byte](s)
#         var indx = 0
#         while not f.atEnd():
#             bcode[indx] = f.readUint8()         # read bytes one-by-one
#             indx += 1

#         return (t.to[:ValueArray], bcode)       # return the Translation


proc hash*(x: OpCode): Hash {.inline.}=
    cast[Hash](ord(x))
