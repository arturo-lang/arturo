######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
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

    when defined(VERBOSE):
        echo "- Importing: Crypto"

    builtin "crc",
        alias       = unaliased, 
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
            ##########################################################
            if x.kind==Literal:
                InPlace.s = InPlaced.s.crc32()
            else:
                push(newString(x.s.crc32()))

    builtin "decode",
        alias       = unaliased, 
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
            ;;;;
            print decode.url "http%3A%2F%2Ffoo+bar%2F"
            ; http://foo bar/
        """:
            ##########################################################
            if (popAttr("url")!=VNULL):
                if x.kind==Literal:
                    InPlace.s = InPlaced.s.decodeUrl()
                else:
                    push(newString(x.s.decodeUrl()))
            else:
                if x.kind==Literal:
                    InPlace.s = InPlaced.s.decode()
                else:
                    push(newString(x.s.decode()))

    # TODO(Crypto\encode) Move function to different module?
    #  Function doesn't really correspond to cryptography anymore. Or at least most of it. What should be done?
    #  labels: library, open discussion
    builtin "encode",
        alias       = unaliased, 
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
            ;;;;
            print encode.url "http://foo bar/"
            ; http%3A%2F%2Ffoo+bar%2F
        """:
            ##########################################################
            if (popAttr("url")!=VNULL):
                let spaces = (popAttr("spaces") != VNULL)
                let slashes = (popAttr("slashes") != VNULL)
                if x.kind==Literal:
                    InPlace.s = InPlaced.s.urlencode(encodeSpaces=spaces, encodeSlashes=slashes)
                else:
                    push(newString(x.s.urlencode(encodeSpaces=spaces, encodeSlashes=slashes)))

            elif (let aFrom = popAttr("from"); aFrom != VNULL):
                when not defined(freebsd) and not defined(WEB):
                    var src = aFrom.s
                    var dest = "UTF-8"
                    if (let aTo = popAttr("to"); aTo != VNULL):
                        dest = aTo.s

                    if x.kind==Literal:
                        InPlace.s = convert(InPlaced.s, srcEncoding=src, destEncoding=dest)
                    else:
                        push(newString(convert(x.s, srcEncoding=src, destEncoding=dest)))
                else:
                    if x.kind==String:
                        push(newString(x.s))

            elif (let aTo = popAttr("to"); aTo != VNULL):
                when not defined(freebsd) and not defined(WEB):
                    var src = "CP1252"
                    var dest = aTo.s

                    if x.kind==Literal:
                        InPlace.s = convert(InPlaced.s, srcEncoding=src, destEncoding=dest)
                    else:
                        push(newString(convert(x.s, srcEncoding=src, destEncoding=dest)))
                else:
                    if x.kind==String:
                        push(newString(x.s))

            else:
                if x.kind==Literal:
                    InPlace.s = InPlaced.s.encode()
                else:
                    push(newString(x.s.encode()))

    when not defined(WEB):
        # TODO(Crypto\digest) could it be used for Web/JS builds too?
        #  would it be that useful to have md5/sha1 encoding capabilities through JavaScript?
        #  labels: library,enhancement,open discussion,web
        builtin "digest",
            alias       = unaliased, 
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
            ;;;;
            print digest.sha "Hello world"
            ; 7b502c3a1f48c8609ae212cdfb639dee39673f5e
            """:
                ##########################################################
                if (popAttr("sha") != VNULL):
                    if x.kind==Literal:
                        SetInPlace(newString(($(secureHash(InPlace.s))).toLowerAscii()))
                    else:
                        push(newString(($(secureHash(x.s))).toLowerAscii()))
                else:
                    if x.kind==Literal:
                        SetInPlace(newString(($(toMD5(InPlace.s))).toLowerAscii()))
                    else:
                        push(newString(($(toMD5(x.s))).toLowerAscii()))

    builtin "hash",
        alias       = unaliased, 
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
            ##########################################################
            if (popAttr("string") != VNULL):
                push(newString($(hash(x))))
            else:
                push(newInteger(hash(x)))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)