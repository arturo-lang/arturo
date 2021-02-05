######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: library/Crypto.nim
######################################################

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import base64, md5, std/sha1

import vm/[common, globals, stack, value]

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Crypto"

    builtin "decode",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "base-64 encode given value",
        args        = {
            "value" : {String,Literal}
        },
        attrs       = NoAttrs,
        returns     = {String,Nothing},
        example     = """
            print decode "TnVtcXVhbSBmdWdpZW5zIHJlc3BleGVyaXM="
            ; Numquam fugiens respexeris
        """:
            ##########################################################
            if x.kind==Literal:
                Syms[x.s].s = Syms[x.s].s.decode()
            else:
                stack.push(newString(x.s.decode()))

    builtin "encode",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "base-64 decode given value",
        args        = {
            "value" : {String,Literal}
        },
        attrs       = NoAttrs,
        returns     = {String,Nothing},
        example     = """
            print encode "Numquam fugiens respexeris"
            ; TnVtcXVhbSBmdWdpZW5zIHJlc3BleGVyaXM=
        """:
            ##########################################################
            if x.kind==Literal:
                Syms[x.s].s = Syms[x.s].s.encode()
            else:
                stack.push(newString(x.s.encode()))

    builtin "digest",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get digest for given value (default: MD5)",
        args        = {
            "value" : {String,Literal}
        },
        attrs       = {
            "sha"   : ({Boolean},"use SHA1")
        },
        returns     = {String,Nothing},
        example     = """
            print digest "Hello world"
            ; 3e25960a79dbc69b674cd4ec67a72c62
            
            print digest.sha "Hello world"
            ; 7b502c3a1f48c8609ae212cdfb639dee39673f5e
        """:
            ##########################################################
            if (popAttr("sha") != VNULL):
                if x.kind==Literal:
                    Syms[x.s] = newString(($(secureHash(Syms[x.s].s))).toLowerAscii())
                else:
                    stack.push(newString(($(secureHash(x.s))).toLowerAscii()))
            else:
                if x.kind==Literal:
                    Syms[x.s] = newString(($(toMD5(Syms[x.s].s))).toLowerAscii())
                else:
                    stack.push(newString(($(toMD5(x.s))).toLowerAscii()))

    builtin "hash",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get hash for given value",
        args        = {
            "value" : {Any}
        },
        attrs       = {
            "string": ({Boolean},"get as a string")
        },
        returns     = {Integer,String},
        # TODO(Crypto\hash) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            if (popAttr("string") != VNULL):
                stack.push(newString($(hash(x))))
            else:
                stack.push(newInteger(hash(x)))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)