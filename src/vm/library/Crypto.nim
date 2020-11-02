######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Crypto.nim
######################################################

#=======================================
# Libraries
#=======================================

import vm/stack, vm/value

#=======================================
# Methods
#=======================================

template Decode*():untyped =
    # EXAMPLE:
    # print decode "TnVtcXVhbSBmdWdpZW5zIHJlc3BleGVyaXM="
    # ; Numquam fugiens respexeris

    require(opDecode)

    if x.kind==Literal:
        syms[x.s].s = syms[x.s].s.decode()
    else:
        stack.push(newString(x.s.decode()))

template Encode*():untyped =
    # EXAMPLE:
    # print encode "Numquam fugiens respexeris"
    # ; TnVtcXVhbSBmdWdpZW5zIHJlc3BleGVyaXM=

    require(opEncode)

    if x.kind==Literal:
        syms[x.s].s = syms[x.s].s.encode()
    else:
        stack.push(newString(x.s.encode()))

template Digest*():untyped =
    # EXAMPLE:
    # print digest "Hello world"
    # ; 3e25960a79dbc69b674cd4ec67a72c62
    #
    # print digest.sha "Hello world"
    # ; 7b502c3a1f48c8609ae212cdfb639dee39673f5e

    require(opDigest)

    if (popAttr("sha") != VNULL):
        if x.kind==Literal:
            syms[x.s] = newString(($(secureHash(syms[x.s].s))).toLowerAscii())
        else:
            stack.push(newString(($(secureHash(x.s))).toLowerAscii()))
    else:
        if x.kind==Literal:
            syms[x.s] = newString(($(toMD5(syms[x.s].s))).toLowerAscii())
        else:
            stack.push(newString(($(toMD5(x.s))).toLowerAscii()))
