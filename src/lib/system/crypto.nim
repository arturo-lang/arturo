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
    let v0 = VALID(0,SV)

    result = STR(S(v0).decode())

proc Crypto_decodeBase64I*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    S(v0) = S(v0).decode()
    result = v0

proc Crypto_encodeBase64*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    result = STR(S(v0).encode())

proc Crypto_encodeBase64I*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    S(v0) = S(v0).encode()
    result = v0

proc Crypto_md5*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    result = STR(S(v0).getMD5())

proc Crypto_md5I*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    S(v0) = S(v0).getMD5()
    result = v0

proc Crypto_sha1*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    result = STR(($(S(v0).secureHash())).toLower())

proc Crypto_sha1I*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    S(v0) = ($(S(v0).secureHash())).toLower()
    result = v0

proc Crypto_uuid*[F,X,V](f: F, xl: X): V {.inline.} =
    result = STR($(genOid()))

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
