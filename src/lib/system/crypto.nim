#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/crypto.nim
  * @description: cryptography
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc Crypto_decodeBase64*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = STR(S(0).decode())

proc Crypto_decodeBase64I*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    S(0) = S(0).decode()
    result = v[0]

proc Crypto_encodeBase64*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = STR(S(0).encode())

proc Crypto_encodeBase64I*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    S(0) = S(0).encode()
    result = v[0]

proc Crypto_md5*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = STR(S(0).getMD5())

proc Crypto_md5I*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    S(0) = S(0).getMD5()
    result = v[0]

proc Crypto_sha1*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = STR($(S(0).secureHash()))

proc Crypto_sha1I*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    S(0) = $(S(0).secureHash())
    result = v[0]

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

# when defined(unittest):

#     suite "Library: system/dictionary":

#         test "shuffle":
#             check(not eq( callFunction("shuffle",@[ARR(@[INT(1),INT(2),INT(3),INT(4),INT(5),INT(6),INT(7),INT(8),INT(9)])]), ARR(@[INT(1),INT(2),INT(3),INT(4),INT(5),INT(6),INT(7),INT(8),INT(9)]) ))

#         test "swap":
#             check(eq( callFunction("swap",@[ARR(@[INT(1),INT(2),INT(3)]),INT(0),INT(2)]), ARR(@[INT(3),INT(2),INT(1)]) ))
