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

import ../stack, ../value

#=======================================
# Methods
#=======================================

template Encode*():untyped =
    require(opEncode)

    if x.kind==Literal:
        syms[x.s].s = syms[x.s].s.encode()
    else:
        stack.push(newString(x.s.encode()))

template Decode*():untyped =
    require(opDecode)

    if x.kind==Literal:
        syms[x.s].s = syms[x.s].s.decode()
    else:
        stack.push(newString(x.s.decode()))

template GetHash*():untyped =
    require(opGetHash)

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
