#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: library/Crypto.nim
#=======================================================

## The main Crypto module 
## (part of the standard library)

# TODO(Crypto) more potential built-in function candidates?
#  labels: library, enhancement, open discussion

# TODO(Crypto) is module's name a misnomer?
#  labels: library, enhancement, open discussion

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import md5, std/sha1

import base64, uri
when not defined(freebsd) and not defined(WEB):
    import encodings

import helpers/strings
import helpers/url

import vm/lib

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    builtin "crc",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the CRC32 polynomial of given string",
        args        = {
            "value" : {String,Literal}
        },
        attrs       = NoAttrs,
        returns     = {String,Nothing},
        example     = """
            print crc "The quick brown fox jumps over the lazy dog"
            ; 414FA339
        """:
            #=======================================================
            if xKind==Literal:
                ensureInPlace()
                InPlaced.s = InPlaced.s.crc32()
            else:
                push(newString(x.s.crc32()))

    builtin "decode",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "encode given value (default: base-64)",
        args        = {
            "value" : {String,Literal}
        },
        attrs       = {
            "url"   : ({Logical},"decode URL based on RFC3986")
        },
        returns     = {String,Nothing},
        example     = """
            print decode "TnVtcXVhbSBmdWdpZW5zIHJlc3BleGVyaXM="
            ; Numquam fugiens respexeris
            ..........
            print decode.url "http%3A%2F%2Ffoo+bar%2F"
            ; http://foo bar/
        """:
            #=======================================================
            if (hadAttr("url")):
                if xKind==Literal:
                    ensureInPlace()
                    InPlaced.s = InPlaced.s.decodeUrl()
                else:
                    push(newString(x.s.decodeUrl()))
            else:
                if xKind==Literal:
                    ensureInPlace()
                    InPlaced.s = InPlaced.s.decode()
                else:
                    push(newString(x.s.decode()))

    # TODO(Crypto\encode) Move function to different module?
    #  Function doesn't really correspond to cryptography anymore. Or at least most of it. What should be done?
    #  labels: library, open discussion
    builtin "encode",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "decode given value (default: base-64)",
        args        = {
            "value" : {String,Literal}
        },
        attrs       = {
            "url"       : ({Logical},"encode URL based on RFC3986"),
            "spaces"    : ({Logical},"also encode spaces"),
            "slashes"   : ({Logical},"also encode slashes"),
            "from"      : ({String},"source character encoding (default: CP1252)"),
            "to"        : ({String},"target character encoding (default: UTF-8)")
        },
        returns     = {String,Nothing},
        example     = """
            print encode "Numquam fugiens respexeris"
            ; TnVtcXVhbSBmdWdpZW5zIHJlc3BleGVyaXM=
            ..........
            print encode.url "http://foo bar/"
            ; http%3A%2F%2Ffoo+bar%2F
        """:
            #=======================================================
            if (hadAttr("url")):
                let spaces = (hadAttr("spaces"))
                let slashes = (hadAttr("slashes"))
                if xKind==Literal:
                    ensureInPlace()
                    InPlaced.s = InPlaced.s.urlencode(encodeSpaces=spaces, encodeSlashes=slashes)
                else:
                    push(newString(x.s.urlencode(encodeSpaces=spaces, encodeSlashes=slashes)))

            elif checkAttr("from"):
                when not defined(freebsd) and not defined(WEB):
                    var src = aFrom.s
                    var dest = "UTF-8"
                    if checkAttr("to"):
                        dest = aTo.s

                    if xKind==Literal:
                        ensureInPlace()
                        InPlaced.s = convert(InPlaced.s, srcEncoding=src, destEncoding=dest)
                    else:
                        push(newString(convert(x.s, srcEncoding=src, destEncoding=dest)))
                else:
                    if xKind==String:
                        push(newString(x.s))

            elif checkAttr("to"):
                when not defined(freebsd) and not defined(WEB):
                    var src = "CP1252"
                    var dest = aTo.s

                    if xKind==Literal:
                        ensureInPlace()
                        InPlaced.s = convert(InPlaced.s, srcEncoding=src, destEncoding=dest)
                    else:
                        push(newString(convert(x.s, srcEncoding=src, destEncoding=dest)))
                else:
                    if xKind==String:
                        push(newString(x.s))

            else:
                if xKind==Literal:
                    ensureInPlace()
                    InPlaced.s = InPlaced.s.encode()
                else:
                    push(newString(x.s.encode()))

    when not defined(WEB):
        # TODO(Crypto\digest) could it be used for Web/JS builds too?
        #  would it be that useful to have md5/sha1 encoding capabilities through JavaScript?
        #  labels: library,enhancement,open discussion,web
        builtin "digest",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "get digest for given value (default: MD5)",
            args        = {
                "value" : {String,Literal}
            },
            attrs       = {
                "sha"   : ({Logical},"use SHA1")
            },
            returns     = {String,Nothing},
            example     = """                
            print digest "Hello world"
            ; 3e25960a79dbc69b674cd4ec67a72c62
            ..........
            print digest.sha "Hello world"
            ; 7b502c3a1f48c8609ae212cdfb639dee39673f5e
            """:
                #=======================================================
                if (hadAttr("sha")):
                    if xKind==Literal:
                        ensureInPlace()
                        SetInPlace(newString(($(secureHash(InPlaced.s))).toLowerAscii()))
                    else:
                        push(newString(($(secureHash(x.s))).toLowerAscii()))
                else:
                    if xKind==Literal:
                        ensureInPlace()
                        SetInPlace(newString(($(toMD5(InPlaced.s))).toLowerAscii()))
                    else:
                        push(newString(($(toMD5(x.s))).toLowerAscii()))

    builtin "hash",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get hash for given value",
        args        = {
            "value" : {Any}
        },
        attrs       = {
            "string": ({Logical},"get as a string")
        },
        returns     = {Integer,String},
        example     = """
            print hash "hello"      ; 613153351
            print hash [1 2 3]      ; 645676735036410
            print hash 123          ; 123

            a: [1 2 3]
            b: [1 2 3]
            print (hash a)=(hash b) ; true
        """:
            #=======================================================
            if (hadAttr("string")):
                push(newString($(hash(x))))
            else:
                push(newInteger(hash(x)))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)