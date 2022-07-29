######################################################
# nim-gmp
# MPFR BigNum library wrapper
# for Nim
#
# (c) 2022 Yanis Zafirópulos
# 
# @license: see LICENSE file
# @file: extras/mpfr.nim
######################################################

#=======================================
# Libraries
#=======================================

import extras/gmp

#=======================================
# Compilation & Linking
#=======================================

{.push header: "<mpfr.h>", cdecl.}

#=======================================
# Types
#=======================================

type 
    mpfr_prec_t = clong
    mpfr_sign_t = cint
    mpfr_exp_t = clong
    mpfr_rnd_t = cint

    mm_mpfr_struct* {.byref, importc: "__mpfr_struct"} = object
        mpfr_prec* {.importc: "_mpfr_prec".}: mpfr_prec_t
        mpfr_sign* {.importc: "_mpfr_sign".}: mpfr_sign_t
        mpfr_exp* {.importc: "_mpfr_exp".}: mpfr_exp_t
        mpfr_d* {.importc: "_mpfr_d".}: ptr mp_limb_t

type
    mpfr* = mm_mpfr_struct

#=======================================
# Constants
#=======================================

const
    MPFR_RNDN*  = 0
    MPFR_RNDZ*  = 1
    MPFR_RNDU*  = 2
    MPFR_RNDD*  = 3
    MPFR_RNDA*  = 4
    MPFR_RNDF*  = 5
    MPFR_RNDNA* = -1

#=======================================
# Function prototypes
#=======================================

func mpfr_clear*(a: var mpfr) {.importc.}
func mpfr_init*(a: var mpfr) {.importc.}
func mpfr_set_d*(a: var mpfr, b: cdouble, c: mpfr_rnd_t) {.importc.}
func mpfr_set_si*(a: var mpfr, b: clong, c: mpfr_rnd_t) {.importc.}
func mpfr_set_ui*(a: var mpfr, b: culong, c: mpfr_rnd_t) {.importc.}
func mpfr_set_z*(a: var mpfr, b: mpz_t, c: mpfr_rnd_t) {.importc.}
func mpfr_set_str*(a: var mpfr, b: cstring, c: cint, d: mpfr_rnd_t):cint {.importc.}

func mpfr_get_d*(a: mpfr, b: mpfr_rnd_t): cdouble {.importc.}
func mpfr_cmp*(a: mpfr, b: mpfr): cint {.importc.}
func mpfr_cmp_d*(a: mpfr, b: cdouble): cint {.importc.}
func mpfr_cmp_si*(a: mpfr, b: clong): cint {.importc.}
func mpfr_cmp_ui*(a: mpfr, b: culong): cint {.importc.}

func mpfr_get_str*(a: cstring; b: var mp_exp_t; c: cint; d: csize_t; e: mpfr, f: mpfr_rnd_t): cstring {.importc.}

func mpfr_fits_uint_p*(a: mpfr, b: mpfr_rnd_t): cint {.importc.}

func mpfr_add*(a: var mpfr, b: mpfr, c: mpfr, d: mpfr_rnd_t) {.importc.}
func mpfr_add_z*(a: var mpfr, b: mpfr, c: mpz_t, d: mpfr_rnd_t) {.importc.}
func mpfr_add_d*(a: var mpfr, b: mpfr, c: cdouble, d: mpfr_rnd_t) {.importc.}
func mpfr_sub*(a: var mpfr, b: mpfr, c: mpfr, d: mpfr_rnd_t) {.importc.}
func mpfr_sub_z*(a: var mpfr, b: mpfr, c: mpz_t, d: mpfr_rnd_t) {.importc.}
func mpfr_sub_d*(a: var mpfr, b: mpfr, c: cdouble, d: mpfr_rnd_t) {.importc.}
func mpfr_mul*(a: var mpfr, b: mpfr, c: mpfr, d: mpfr_rnd_t) {.importc.}
func mpfr_mul_z*(a: var mpfr, b: mpfr, c: mpz_t, d: mpfr_rnd_t) {.importc.}
func mpfr_mul_d*(a: var mpfr, b: mpfr, c: cdouble, d: mpfr_rnd_t) {.importc.}
func mpfr_div*(a: var mpfr, b: mpfr, c: mpfr, d: mpfr_rnd_t) {.importc.}
func mpfr_div_z*(a: var mpfr, b: mpfr, c: mpz_t, d: mpfr_rnd_t) {.importc.}
func mpfr_div_d*(a: var mpfr, b: mpfr, c: cdouble, d: mpfr_rnd_t) {.importc.}
func mpfr_pow*(a: var mpfr, b: mpfr, c: mpfr, d: mpfr_rnd_t) {.importc.}
func mpfr_pow_z*(a: var mpfr, b: mpfr, c: mpz_t, d: mpfr_rnd_t) {.importc.}

{.pop.}

#=======================================
# Methods
#=======================================

func finalizeFloat*(z: ref mpfr) =
    mpfr_clear(z[])