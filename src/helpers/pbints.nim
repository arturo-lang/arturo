#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: helpers/pbints.nim
#=======================================================

## EXPERIMENTAL: PocketBignum's small-or-big integers (`pbi`)
##
## A `Pbi` is either a machine int64 (`b == nil`) or a reference
## to an immutable, reference-counted bignum - and results come back
## as small ones whenever they fit, so promotion & demotion are
## entirely handled by the library.

#=======================================
# Libraries
#=======================================

import extras/gmp
import helpers/bignums
import helpers/intrinsics

#=======================================
# Types
#=======================================

{.push header: "<gmp.h>", cdecl.}       # compat/gmp.h includes pocketbignum.h

type
    PbiBig* {.importc: "pbi_big", incompleteStruct.} = object

    Pbi* {.importc: "pbi", bycopy, completeStruct.} = object
        s*: int             # int64_t on the C side (64-bit targets only, for now)
        b*: ptr PbiBig

func pbi_add(a, b: Pbi): Pbi {.importc.}
func pbi_cmp(a, b: Pbi): cint {.importc.}
func pbi_sgn(a: Pbi): cint {.importc.}
proc pbi_retain(a: Pbi) {.importc.}
proc pbi_release(a: Pbi) {.importc.}
proc pbi_from_pbz(z: mpz_srcptr): Pbi {.importc.}
proc pbi_get_pbz(r: mpz_ptr, a: Pbi) {.importc.}

{.pop.}

#=======================================
# Hooks
#=======================================

proc `=destroy`*(x: Pbi) {.inline.} =
    if not x.b.isNil:
        pbi_release(x)

proc `=wasMoved`*(x: var Pbi) {.inline.} =
    x.b = nil

proc `=copy`*(dest: var Pbi, src: Pbi) {.inline.} =
    if dest.b != src.b:
        if not src.b.isNil: pbi_retain(src)
        if not dest.b.isNil: pbi_release(dest)
        dest.b = src.b
    dest.s = src.s

proc `=dup`*(src: Pbi): Pbi {.inline.} =
    if not src.b.isNil: pbi_retain(src)
    result.s = src.s
    result.b = src.b

proc `=sink`*(dest: var Pbi, src: Pbi) {.inline.} =
    if not dest.b.isNil: pbi_release(dest)   # same block twice: refc >= 2, so it stays
    dest.s = src.s
    dest.b = src.b

#=======================================
# Methods
#=======================================

template isSmall*(x: Pbi): bool = x.b.isNil

func toPbi*(i: int): Pbi {.inline.} =
    Pbi(s: i, b: nil)

proc toPbi*(x: Int): Pbi {.inline.} =
    pbi_from_pbz(addr x[])

proc toInt*(x: Pbi): Int =
    ## copy, as a GMP-style bignum
    result = newInt()
    pbi_get_pbz(addr result[], x)

func `+`*(a, b: Pbi): Pbi {.inline.} =
    pbi_add(a, b)

func cmp*(a, b: Pbi): int {.inline.} =
    int(pbi_cmp(a, b))

func sgn*(a: Pbi): int {.inline.} =
    int(pbi_sgn(a))

proc addSlowI(x: var Pbi, y: Pbi) {.noinline.} =
    x = pbi_add(x, y)

template `+=`*(x: var Pbi, y: Pbi) =
    ## in place: small + small straight into `x.s`, like a machine add
    var r: int
    if likely(x.b.isNil and y.b.isNil and not addIntWithOverflow(x.s, y.s, r)):
        x.s = r
    else:
        addSlowI(x, y)
