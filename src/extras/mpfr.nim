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

{.passL: "-lmpfr".}

{.push header: "<mpfr.h>", cdecl.}

#=======================================
# Types
#=======================================

type 
    mpfr_prec_t = clong
    mpfr_sign_t = cint
    mpfr_exp_t = clong
    mm_mpfr_struct* {.byref, importc: "__mpfr_struct"} = object
        mpfr_prec* {.importc: "_mpfr_prec".}: mpfr_prec_t
        mpfr_sign* {.importc: "_mpfr_sign".}: mpfr_sign_t
        mpfr_exp* {.importc: "_mpfr_exp".}: mpfr_exp_t
        mpfr_d* {.importc: "_mpfr_d".}: ptr mp_limb_t

# type 
#     MP_ALG_DATA* {.union, importc: "no_name".} = object  
#         mp_lc* {.importc: "_mp_lc".}: pointer
  
#     mp_limb_t* {.importc, nodecl.} = uint
#     mp_limb_signed_t* {.importc, nodecl.} = int
#     mp_bitcnt_t* {.importc, nodecl.} = culong
#     mm_mpz_struct* {.byref, importc: "__mpz_struct".} = object 
#         mp_alloc* {.importc: "_mp_alloc".}: cint
#         mp_size* {.importc: "_mp_size".}: cint
#         mp_d* {.importc: "_mp_d".}: ptr mp_limb_t

#     MP_INT* = mm_mpz_struct
#     mpz_t* = mm_mpz_struct
#     mp_ptr* = ptr mp_limb_t
#     mp_srcptr* = ptr mp_limb_t
#     mp_size_t* {.importc, nodecl.} = clong
#     mp_exp_t* {.importc, nodecl.} = clong
#     mm_mpq_struct* {.byref, importc: "__mpq_struct".} = object 
#         mp_num* {.importc: "_mp_num".}: mm_mpz_struct
#         mp_den* {.importc: "_mp_den".}: mm_mpz_struct

#     MP_RAT* = mm_mpq_struct
#     mpq_t* = mm_mpq_struct
#     mm_mpf_struct* {.byref, importc: "__mpf_struct".} = object 
#         mp_prec* {.importc: "_mp_prec".}: cint
#         mp_size* {.importc: "_mp_size".}: cint
#         mp_exp* {.importc: "_mp_exp".}: mp_exp_t
#         mp_d* {.importc: "_mp_d".}: ptr mp_limb_t

#     MP_FLT* = mm_mpf_struct
#     mpf_t* = mm_mpf_struct
#     gmp_randalg_t* = distinct cint
#     mm_gmp_randstate_struct* {.importc: "__gmp_randstate_struct".} = object 
#         mp_seed* {.importc: "_mp_seed".}: mpz_t
#         mp_alg* {.importc: "_mp_alg".}: gmp_randalg_t
#         mp_algdata* {.importc: "_mp_algdata".}: MP_ALG_DATA

#     gmp_randstate_t* = mm_gmp_randstate_struct
#     mpz_srcptr* = ptr mm_mpz_struct
#     mpz_ptr* = ptr mm_mpz_struct
#     mpf_srcptr* = ptr mm_mpf_struct
#     mpf_ptr* = ptr mm_mpf_struct
#     mpq_srcptr* = ptr mm_mpq_struct
#     mpq_ptr* = ptr mm_mpq_struct

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
  
# const 
#     GMP_ERROR_NONE* = 0
#     GMP_ERROR_UNSUPPORTED_ARGUMENT* = 1
#     GMP_ERROR_DIVISION_BY_ZERO* = 2
#     GMP_ERROR_SQRT_OF_NEGATIVE* = 4
#     GMP_ERROR_INVALID_ARGUMENT* = 8

#=======================================
# Variable prototypes
#=======================================

# var mp_bits_per_limb* {.importc.}: cint
# var gmp_errno* {.importc.}: cint
# var gmp_version* {.importc.}: cstring

#=======================================
# Function prototypes
#=======================================

func mpfr_clear*(a: var mpfr) {.importc.}
func mpfr_init*(a: var mpfr) {.importc.}
func mpfr_set_d*(a: var mpfr, b: cdouble, c: cint) {.importc.}
func mpfr_set_si*(a: var mpfr, b: clong, c: cint) {.importc.}
func mpfr_set_ui*(a: var mpfr, b: culong, c: cint) {.importc.}
func mpfr_set_z*(a: var mpfr, b: mpz_t, c: cint) {.importc.}
func mpfr_set_str*(a: var mpfr, b: cstring, c: cint):cint {.importc.}

func mpfr_get_d*(a: mpfr): cdouble {.importc.}
func mpfr_cmp*(a: mpfr, b: mpfr): cint {.importc.}
func mpfr_cmp_d*(a: mpfr, b: cdouble): cint {.importc.}
func mpfr_cmp_si*(a: mpfr, b: clong): cint {.importc.}
func mpfr_cmp_ui*(a: mpfr, b: culong): cint {.importc.}

func mpfr_get_str*(a: cstring; b: var mp_exp_t; c: cint; d: csize_t; e: mpfr, f: cint): cstring {.importc.}

func mpfr_div*(a: var mpfr, b: mpfr, c: mpfr) {.importc.}

# func gmp_asprintf*(a2: cstringArray; a3: cstring): cint {.varargs, importc.}
# func gmp_fprintf*(a2: File; a3: cstring): cint {.varargs, importc.}
# func gmp_fscanf*(a2: File; a3: cstring): cint {.varargs, importc.}
# func gmp_printf*(a2: cstring): cint {.varargs, importc.}
# func gmp_randclear*(a2: gmp_randstate_t) {.importc.}
# func gmp_randinit*(a2: gmp_randstate_t; a3: gmp_randalg_t) {.varargs, importc.}
# func gmp_randinit_default*(a2: gmp_randstate_t) {.importc.}
# func gmp_randinit_lc_2exp*(a2: gmp_randstate_t; a3: mpz_srcptr; a4: culong; a5: mp_bitcnt_t) {.importc.}
# func gmp_randinit_lc_2exp*(a2: gmp_randstate_t; a3: mpz_t; a4: culong; a5: mp_bitcnt_t) {.importc.}
# func gmp_randinit_lc_2exp_size*(a2: gmp_randstate_t; a3: mp_bitcnt_t): cint {.importc.}
# func gmp_randinit_mt*(a2: gmp_randstate_t) {.importc.}
# func gmp_randinit_set*(a2: gmp_randstate_t; a3: ptr mm_gmp_randstate_struct) {.importc.}
# func gmp_randseed*(a2: gmp_randstate_t; a3: mpz_srcptr) {.importc.}
# func gmp_randseed*(a2: gmp_randstate_t; a3: mpz_t) {.importc.}
# func gmp_randseed_ui*(a2: gmp_randstate_t; a3: culong) {.importc.}
# func gmp_scanf*(a2: cstring): cint {.varargs, importc.}
# func gmp_snprintf*(a2: cstring; a3: csize_t; a4: cstring): cint {.varargs, importc.}
# func gmp_sprintf*(a2: cstring; a3: cstring): cint {.varargs, importc.}
# func gmp_sscanf*(a2: cstring; a3: cstring): cint {.varargs, importc.}
# func gmp_urandomb_ui*(a2: gmp_randstate_t; a3: culong): culong {.importc.}
# func gmp_urandomm_ui*(a2: gmp_randstate_t; a3: culong): culong {.importc.}

# func m_mpq_cmp_si*(a2: mpq_srcptr; a3: clong; a4: culong): cint {.importc: "_mpq_cmp_si".}
# func m_mpq_cmp_si*(a2: mpq_t; a3: clong; a4: culong): cint {.importc: "_mpq_cmp_si".}
# func m_mpq_cmp_ui*(a2: mpq_srcptr; a3: culong; a4: culong): cint {.importc: "_mpq_cmp_ui".}
# func m_mpq_cmp_ui*(a2: mpq_t; a3: culong; a4: culong): cint {.importc: "_mpq_cmp_ui".}
# func m_mpz_realloc*(a2: mpz_ptr; a3: mp_size_t): pointer {.importc: "_mpz_realloc".}
# func m_mpz_realloc*(a2: var mpz_t; a3: mp_size_t): pointer {.importc: "_mpz_realloc".}
# func mp_get_memory_functions*(a2: proc (a2: csize_t): pointer; a3: proc (a2: pointer; a3: csize_t; a4: csize_t): pointer; a4: proc (a2: pointer; a3: csize_t)) {.importc.}
# func mp_set_memory_functions*(a2: proc (a2: csize_t): pointer; a3: proc (a2: pointer; a3: csize_t; a4: csize_t): pointer; a4: proc (a2: pointer; a3: csize_t)) {.importc.}

# func mpf_abs*(a2: mpf_ptr; a3: mpf_srcptr) {.importc.}
# func mpf_abs*(a2: var mpf_t; a3: mpf_t) {.importc.}
# func mpf_add*(a2: mpf_ptr; a3: mpf_srcptr; a4: mpf_srcptr) {.importc.}
# func mpf_add*(a2: var mpf_t; a3: mpf_t; a4: mpf_t) {.importc.}
# func mpf_add_ui*(a2: mpf_ptr; a3: mpf_srcptr; a4: culong) {.importc.}
# func mpf_add_ui*(a2: var mpf_t; a3: mpf_t; a4: culong) {.importc.}
# func mpf_ceil*(a2: mpf_ptr; a3: mpf_srcptr) {.importc.}
# func mpf_ceil*(a2: var mpf_t; a3: mpf_t) {.importc.}
# func mpf_clear*(a2: mpf_ptr) {.importc.}
# func mpf_clear*(a2: var mpf_t) {.importc.}
# func mpf_clears*(a2: mpf_ptr) {.varargs, importc.}
# func mpf_clears*(a2: var mpf_t) {.varargs, importc.}
# func mpf_cmp*(a2: mpf_srcptr; a3: mpf_srcptr): cint {.importc.}
# func mpf_cmp*(a2: mpf_t; a3: mpf_t): cint {.importc.}
# func mpf_cmp_d*(a2: mpf_srcptr; a3: cdouble): cint {.importc.}
# func mpf_cmp_d*(a2: mpf_t; a3: cdouble): cint {.importc.}
# func mpf_cmp_si*(a2: mpf_srcptr; a3: clong): cint {.importc.}
# func mpf_cmp_si*(a2: mpf_t; a3: clong): cint {.importc.}
# func mpf_cmp_ui*(a2: mpf_srcptr; a3: culong): cint {.importc.}
# func mpf_cmp_ui*(a2: mpf_t; a3: culong): cint {.importc.}
# func mpf_div*(a2: mpf_ptr; a3: mpf_srcptr; a4: mpf_srcptr) {.importc.}
# func mpf_div*(a2: var mpf_t; a3: mpf_t; a4: mpf_t) {.importc.}
# func mpf_div_2exp*(a2: mpf_ptr; a3: mpf_srcptr; a4: mp_bitcnt_t) {.importc.}
# func mpf_div_2exp*(a2: var mpf_t; a3: mpf_t; a4: mp_bitcnt_t) {.importc.}
# func mpf_div_ui*(a2: mpf_ptr; a3: mpf_srcptr; a4: culong) {.importc.}
# func mpf_div_ui*(a2: var mpf_t; a3: mpf_t; a4: culong) {.importc.}
# func mpf_dump*(a2: mpf_srcptr) {.importc.}
# func mpf_dump*(a2: mpf_t) {.importc.}
# func mpf_eq*(a2: mpf_srcptr; a3: mpf_srcptr; a4: mp_bitcnt_t): cint {.importc.}
# func mpf_eq*(a2: mpf_t; a3: mpf_t; a4: mp_bitcnt_t): cint {.importc.}
# func mpf_fits_sint_p*(a2: mpf_srcptr): cint {.importc.}
# func mpf_fits_sint_p*(a2: mpf_t): cint {.importc.}
# func mpf_fits_slong_p*(a2: mpf_srcptr): cint {.importc.}
# func mpf_fits_slong_p*(a2: mpf_t): cint {.importc.}
# func mpf_fits_sshort_p*(a2: mpf_srcptr): cint {.importc.}
# func mpf_fits_sshort_p*(a2: mpf_t): cint {.importc.}
# func mpf_fits_uint_p*(a2: mpf_srcptr): cint {.importc.}
# func mpf_fits_uint_p*(a2: mpf_t): cint {.importc.}
# func mpf_fits_ulong_p*(a2: mpf_srcptr): cint {.importc.}
# func mpf_fits_ulong_p*(a2: mpf_t): cint {.importc.}
# func mpf_fits_ushort_p*(a2: mpf_srcptr): cint {.importc.}
# func mpf_fits_ushort_p*(a2: mpf_t): cint {.importc.}
# func mpf_floor*(a2: mpf_ptr; a3: mpf_srcptr) {.importc.}
# func mpf_floor*(a2: var mpf_t; a3: mpf_t) {.importc.}
# func mpf_get_d*(a2: mpf_srcptr): cdouble {.importc.}
# func mpf_get_d*(a2: mpf_t): cdouble {.importc.}
# func mpf_get_d_2exp*(a2: ptr clong; a3: mpf_srcptr): cdouble {.importc.}
# func mpf_get_d_2exp*(a2: ptr clong; a3: mpf_t): cdouble {.importc.}
# func mpf_get_default_prec*(): mp_bitcnt_t {.importc.}
# func mpf_get_prec*(a2: mpf_srcptr): mp_bitcnt_t {.importc.}
# func mpf_get_prec*(a2: mpf_t): mp_bitcnt_t {.importc.}
# func mpf_get_si*(a2: mpf_srcptr): clong {.importc.}
# func mpf_get_si*(a2: mpf_t): clong {.importc.}
# func mpf_get_str*(a2: cstring; a3: ptr mp_exp_t; a4: cint; a5: csize_t; a6: mpf_srcptr): cstring {.importc.}
# func mpf_get_str*(a2: cstring; a3: var mp_exp_t; a4: cint; a5: csize_t; a6: mpf_t): cstring {.importc.}
# func mpf_get_ui*(a2: mpf_srcptr): culong {.importc.}
# func mpf_get_ui*(a2: mpf_t): culong {.importc.}
# func mpf_init*(a2: mpf_ptr) {.importc.}
# func mpf_init*(a2: var mpf_t) {.importc.}
# func mpf_init2*(a2: mpf_ptr; a3: mp_bitcnt_t) {.importc.}
# func mpf_init2*(a2: var mpf_t; a3: mp_bitcnt_t) {.importc.}
# func mpf_init_set*(a2: mpf_ptr; a3: mpf_srcptr) {.importc.}
# func mpf_init_set*(a2: var mpf_t; a3: mpf_t) {.importc.}
# func mpf_init_set_d*(a2: mpf_ptr; a3: cdouble) {.importc.}
# func mpf_init_set_d*(a2: var mpf_t; a3: cdouble) {.importc.}
# func mpf_init_set_si*(a2: mpf_ptr; a3: clong) {.importc.}
# func mpf_init_set_si*(a2: var mpf_t; a3: clong) {.importc.}
# func mpf_init_set_str*(a2: mpf_ptr; a3: cstring; a4: cint): cint {.importc.}
# func mpf_init_set_str*(a2: var mpf_t; a3: cstring; a4: cint): cint {.importc.}
# func mpf_init_set_ui*(a2: mpf_ptr; a3: culong) {.importc.}
# func mpf_init_set_ui*(a2: var mpf_t; a3: culong) {.importc.}
# func mpf_inits*(a2: mpf_ptr) {.varargs, importc.}
# func mpf_inits*(a2: var mpf_t) {.varargs, importc.}
# func mpf_inp_str*(a2: mpf_ptr; a3: File; a4: cint): csize_t {.importc.}
# func mpf_inp_str*(a2: var mpf_t; a3: File; a4: cint): csize_t {.importc.}
# func mpf_integer_p*(a2: mpf_srcptr): cint {.importc.}
# func mpf_integer_p*(a2: mpf_t): cint {.importc.}
# func mpf_mul*(a2: mpf_ptr; a3: mpf_srcptr; a4: mpf_srcptr) {.importc.}
# func mpf_mul*(a2: var mpf_t; a3: mpf_t; a4: mpf_t) {.importc.}
# func mpf_mul_2exp*(a2: mpf_ptr; a3: mpf_srcptr; a4: mp_bitcnt_t) {.importc.}
# func mpf_mul_2exp*(a2: var mpf_t; a3: mpf_t; a4: mp_bitcnt_t) {.importc.}
# func mpf_mul_ui*(a2: mpf_ptr; a3: mpf_srcptr; a4: culong) {.importc.}
# func mpf_mul_ui*(a2: var mpf_t; a3: mpf_t; a4: culong) {.importc.}
# func mpf_neg*(a2: mpf_ptr; a3: mpf_srcptr) {.importc.}
# func mpf_neg*(a2: var mpf_t; a3: mpf_t) {.importc.}
# func mpf_out_str*(a2: File; a3: cint; a4: csize_t; a5: mpf_srcptr): csize_t {.importc.}
# func mpf_out_str*(a2: File; a3: cint; a4: csize_t; a5: mpf_t): csize_t {.importc.}
# func mpf_pow_ui*(a2: mpf_ptr; a3: mpf_srcptr; a4: culong) {.importc.}
# func mpf_pow_ui*(a2: var mpf_t; a3: mpf_t; a4: culong) {.importc.}
# func mpf_random2*(a2: mpf_ptr; a3: mp_size_t; a4: mp_exp_t) {.importc.}
# func mpf_random2*(a2: var mpf_t; a3: mp_size_t; a4: mp_exp_t) {.importc.}
# func mpf_reldiff*(a2: mpf_ptr; a3: mpf_srcptr; a4: mpf_srcptr) {.importc.}
# func mpf_reldiff*(a2: var mpf_t; a3: mpf_t; a4: mpf_t) {.importc.}
# func mpf_set*(a2: mpf_ptr; a3: mpf_srcptr) {.importc.}
# func mpf_set*(a2: var mpf_t; a3: mpf_t) {.importc.}
# func mpf_set_d*(a2: mpf_ptr; a3: cdouble) {.importc.}
# func mpf_set_d*(a2: var mpf_t; a3: cdouble) {.importc.}
# func mpf_set_default_prec*(a2: mp_bitcnt_t) {.importc.}
# func mpf_set_prec*(a2: mpf_ptr; a3: mp_bitcnt_t) {.importc.}
# func mpf_set_prec*(a2: var mpf_t; a3: mp_bitcnt_t) {.importc.}
# func mpf_set_prec_raw*(a2: mpf_ptr; a3: mp_bitcnt_t) {.importc.}
# func mpf_set_prec_raw*(a2: var mpf_t; a3: mp_bitcnt_t) {.importc.}
# func mpf_set_q*(a2: mpf_ptr; a3: mpq_srcptr) {.importc.}
# func mpf_set_q*(a2: var mpf_t; a3: mpq_t) {.importc.}
# func mpf_set_si*(a2: mpf_ptr; a3: clong) {.importc.}
# func mpf_set_si*(a2: var mpf_t; a3: clong) {.importc.}
# func mpf_set_str*(a2: mpf_ptr; a3: cstring; a4: cint): cint {.importc.}
# func mpf_set_str*(a2: var mpf_t; a3: cstring; a4: cint): cint {.importc.}
# func mpf_set_ui*(a2: mpf_ptr; a3: culong) {.importc.}
# func mpf_set_ui*(a2: var mpf_t; a3: culong) {.importc.}
# func mpf_set_z*(a2: mpf_ptr; a3: mpz_srcptr) {.importc.}
# func mpf_set_z*(a2: var mpf_t; a3: mpz_t) {.importc.}
# func mpf_sgn*(a2: mpf_srcptr): cint {.importc.}
# func mpf_sgn*(a2: mpf_t): cint {.importc.}
# func mpf_size*(a2: mpf_srcptr): csize_t {.importc.}
# func mpf_size*(a2: mpf_t): csize_t {.importc.}
# func mpf_sqrt*(a2: mpf_ptr; a3: mpf_srcptr) {.importc.}
# func mpf_sqrt*(a2: var mpf_t; a3: mpf_t) {.importc.}
# func mpf_sqrt_ui*(a2: mpf_ptr; a3: culong) {.importc.}
# func mpf_sqrt_ui*(a2: var mpf_t; a3: culong) {.importc.}
# func mpf_sub*(a2: mpf_ptr; a3: mpf_srcptr; a4: mpf_srcptr) {.importc.}
# func mpf_sub*(a2: var mpf_t; a3: mpf_t; a4: mpf_t) {.importc.}
# func mpf_sub_ui*(a2: mpf_ptr; a3: mpf_srcptr; a4: culong) {.importc.}
# func mpf_sub_ui*(a2: var mpf_t; a3: mpf_t; a4: culong) {.importc.}
# func mpf_swap*(a2: mpf_ptr; a3: mpf_ptr) {.importc.}
# func mpf_swap*(a2: var mpf_t; a3: var mpf_t) {.importc.}
# func mpf_trunc*(a2: mpf_ptr; a3: mpf_srcptr) {.importc.}
# func mpf_trunc*(a2: var mpf_t; a3: mpf_t) {.importc.}
# func mpf_ui_div*(a2: mpf_ptr; a3: culong; a4: mpf_srcptr) {.importc.}
# func mpf_ui_div*(a2: var mpf_t; a3: culong; a4: mpf_t) {.importc.}
# func mpf_ui_sub*(a2: mpf_ptr; a3: culong; a4: mpf_srcptr) {.importc.}
# func mpf_ui_sub*(a2: var mpf_t; a3: culong; a4: mpf_t) {.importc.}
# func mpf_urandomb*(a2: mpf_t; a3: gmp_randstate_t; a4: mp_bitcnt_t) {.importc.}

# func mpn_add*(mm_gmp_wp: mp_ptr; mm_gmp_xp: mp_srcptr; mm_gmp_xsize: mp_size_t; mm_gmp_yp: mp_srcptr; mm_gmp_ysize: mp_size_t): mp_limb_t {.importc.}
# func mpn_add*(mm_gmp_wp: var mp_limb_t; mm_gmp_xp: var mp_limb_t; mm_gmp_xsize: mp_size_t; mm_gmp_yp: var mp_limb_t; mm_gmp_ysize: mp_size_t): mp_limb_t {.importc.}
# func mpn_add_1*(mm_gmp_dst: mp_ptr; mm_gmp_src: mp_srcptr; mm_gmp_size: mp_size_t; mm_gmp_n: mp_limb_t): mp_limb_t {.importc.}
# func mpn_add_1*(mm_gmp_dst: var mp_limb_t; mm_gmp_src: var mp_limb_t; mm_gmp_size: mp_size_t; mm_gmp_n: mp_limb_t): mp_limb_t {.importc.}
# func mpn_add_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t): mp_limb_t {.importc.}
# func mpn_add_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t): mp_limb_t {.importc.}
# func mpn_addmul_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.importc.}
# func mpn_addmul_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.importc.}
# func mpn_and_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.importc.}
# func mpn_and_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t) {.importc.}
# func mpn_andn_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.importc.}
# func mpn_andn_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t) {.importc.}
# func mpn_cmp*(mm_gmp_xp: mp_srcptr; mm_gmp_yp: mp_srcptr; mm_gmp_size: mp_size_t): cint {.importc.}
# func mpn_cmp*(mm_gmp_xp: var mp_limb_t; mm_gmp_yp: var mp_limb_t; mm_gmp_size: mp_size_t): cint {.importc.}
# func mpn_cnd_add_n*(a2: mp_limb_t; a3: mp_ptr; a4: mp_srcptr; a5: mp_srcptr; a6: mp_size_t): mp_limb_t {.importc.}
# func mpn_cnd_add_n*(a2: mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: var mp_limb_t; a6: mp_size_t): mp_limb_t {.importc.}
# func mpn_cnd_sub_n*(a2: mp_limb_t; a3: mp_ptr; a4: mp_srcptr; a5: mp_srcptr; a6: mp_size_t): mp_limb_t {.importc.}
# func mpn_cnd_sub_n*(a2: mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: var mp_limb_t; a6: mp_size_t): mp_limb_t {.importc.}
# func mpn_com*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t) {.importc.}
# func mpn_com*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t) {.importc.}
# func mpn_copyd*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t) {.importc.}
# func mpn_copyd*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t) {.importc.}
# func mpn_copyi*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t) {.importc.}
# func mpn_copyi*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t) {.importc.}
# func mpn_div_qr_1*(a2: mp_ptr; a3: ptr mp_limb_t; a4: mp_srcptr; a5: mp_size_t; a6: mp_limb_t): mp_limb_t {.importc.}
# func mpn_div_qr_1*(a2: var mp_limb_t; a3: ptr mp_limb_t; a4: var mp_limb_t; a5: mp_size_t; a6: mp_limb_t): mp_limb_t {.importc.}
# func mpn_div_qr_2*(a2: mp_ptr; a3: mp_ptr; a4: mp_srcptr; a5: mp_size_t; a6: mp_srcptr): mp_limb_t {.importc.}
# func mpn_div_qr_2*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t; a6: var mp_limb_t): mp_limb_t {.importc.}
# func mpn_divexact_by3c*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.importc.}
# func mpn_divexact_by3c*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.importc.}
# func mpn_divrem*(a2: mp_ptr; a3: mp_size_t; a4: mp_ptr; a5: mp_size_t; a6: mp_srcptr; a7: mp_size_t): mp_limb_t {.importc.}
# func mpn_divrem*(a2: var mp_limb_t; a3: mp_size_t; a4: var mp_limb_t; a5: mp_size_t; a6: var mp_limb_t; a7: mp_size_t): mp_limb_t {.importc.}
# func mpn_divrem_1*(a2: mp_ptr; a3: mp_size_t; a4: mp_srcptr; a5: mp_size_t; a6: mp_limb_t): mp_limb_t {.importc.}
# func mpn_divrem_1*(a2: var mp_limb_t; a3: mp_size_t; a4: var mp_limb_t; a5: mp_size_t; a6: mp_limb_t): mp_limb_t {.importc.}
# func mpn_divrem_2*(a2: mp_ptr; a3: mp_size_t; a4: mp_ptr; a5: mp_size_t; a6: mp_srcptr): mp_limb_t {.importc.}
# func mpn_divrem_2*(a2: var mp_limb_t; a3: mp_size_t; a4: var mp_limb_t; a5: mp_size_t; a6: var mp_limb_t): mp_limb_t {.importc.}
# func mpn_gcd*(a2: mp_ptr; a3: mp_ptr; a4: mp_size_t; a5: mp_ptr; a6: mp_size_t): mp_size_t {.importc.}
# func mpn_gcd*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: var mp_limb_t; a6: mp_size_t): mp_size_t {.importc.}
# func mpn_gcd_1*(a2: mp_srcptr; a3: mp_size_t; a4: mp_limb_t): mp_limb_t {.importc.}
# func mpn_gcd_1*(a2: var mp_limb_t; a3: mp_size_t; a4: mp_limb_t): mp_limb_t {.importc.}
# func mpn_gcdext*(a2: mp_ptr; a3: mp_ptr; a4: ptr mp_size_t; a5: mp_ptr; a6: mp_size_t; a7: mp_ptr; a8: mp_size_t): mp_size_t {.importc.}
# func mpn_gcdext*(a2: var mp_limb_t; a3: var mp_limb_t; a4: ptr mp_size_t; a5: var mp_limb_t; a6: mp_size_t; a7: var mp_limb_t; a8: mp_size_t): mp_size_t {.importc.}
# func mpn_gcdext_1*(a2: ptr mp_limb_signed_t; a3: ptr mp_limb_signed_t; a4: mp_limb_t; a5: mp_limb_t): mp_limb_t {.importc.}
# func mpn_get_str*(a2: ptr uint8; a3: cint; a4: mp_ptr; a5: mp_size_t): csize_t {.importc.}
# func mpn_get_str*(a2: ptr uint8; a3: cint; a4: var mp_limb_t; a5: mp_size_t): csize_t {.importc.}
# func mpn_hamdist*(a2: mp_srcptr; a3: mp_srcptr; a4: mp_size_t): mp_bitcnt_t {.importc.}
# func mpn_hamdist*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t): mp_bitcnt_t {.importc.}
# func mpn_ior_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.importc.}
# func mpn_ior_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t) {.importc.}
# func mpn_iorn_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.importc.}
# func mpn_iorn_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t) {.importc.}
# func mpn_lshift*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: cuint): mp_limb_t {.importc.}
# func mpn_lshift*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: cuint): mp_limb_t {.importc.}
# func mpn_mod_1*(a2: mp_srcptr; a3: mp_size_t; a4: mp_limb_t): mp_limb_t {.importc.}
# func mpn_mod_1*(a2: var mp_limb_t; a3: mp_size_t; a4: mp_limb_t): mp_limb_t {.importc.}
# func mpn_mul*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_srcptr; a6: mp_size_t): mp_limb_t {.importc.}
# func mpn_mul*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: var mp_limb_t; a6: mp_size_t): mp_limb_t {.importc.}
# func mpn_mul_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.importc.}
# func mpn_mul_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.importc.}
# func mpn_mul_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.importc.}
# func mpn_mul_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t) {.importc.}
# func mpn_nand_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.importc.}
# func mpn_nand_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t) {.importc.}
# func mpn_neg*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t): mp_limb_t {.importc.}
# func mpn_neg*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t): mp_limb_t {.importc.}
# func mpn_nior_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.importc.}
# func mpn_nior_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t) {.importc.}
# func mpn_perfect_power_p*(a2: mp_srcptr; a3: mp_size_t): cint {.importc.}
# func mpn_perfect_power_p*(a2: var mp_limb_t; a3: mp_size_t): cint {.importc.}
# func mpn_perfect_square_p*(a2: mp_srcptr; a3: mp_size_t): cint {.importc.}
# func mpn_perfect_square_p*(a2: var mp_limb_t; a3: mp_size_t): cint {.importc.}
# func mpn_popcount*(a2: mp_srcptr; a3: mp_size_t): mp_bitcnt_t {.importc.}
# func mpn_popcount*(a2: var mp_limb_t; a3: mp_size_t): mp_bitcnt_t {.importc.}
# func mpn_pow_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t; a6: mp_ptr): mp_size_t {.importc.}
# func mpn_pow_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: mp_limb_t; a6: var mp_limb_t): mp_size_t {.importc.}
# func mpn_preinv_mod_1*(a2: mp_srcptr; a3: mp_size_t; a4: mp_limb_t; a5: mp_limb_t): mp_limb_t {.importc.}
# func mpn_preinv_mod_1*(a2: var mp_limb_t; a3: mp_size_t; a4: mp_limb_t; a5: mp_limb_t): mp_limb_t {.importc.}
# func mpn_random*(a2: mp_ptr; a3: mp_size_t) {.importc.}
# func mpn_random*(a2: var mp_limb_t; a3: mp_size_t) {.importc.}
# func mpn_random2*(a2: mp_ptr; a3: mp_size_t) {.importc.}
# func mpn_random2*(a2: var mp_limb_t; a3: mp_size_t) {.importc.}
# func mpn_rshift*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: cuint): mp_limb_t {.importc.}
# func mpn_rshift*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: cuint): mp_limb_t {.importc.}
# func mpn_scan0*(a2: mp_srcptr; a3: mp_bitcnt_t): mp_bitcnt_t {.importc.}
# func mpn_scan0*(a2: var mp_limb_t; a3: mp_bitcnt_t): mp_bitcnt_t {.importc.}
# func mpn_scan1*(a2: mp_srcptr; a3: mp_bitcnt_t): mp_bitcnt_t {.importc.}
# func mpn_scan1*(a2: var mp_limb_t; a3: mp_bitcnt_t): mp_bitcnt_t {.importc.}
# func mpn_sec_add_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t; a6: mp_ptr): mp_limb_t {.importc.}
# func mpn_sec_add_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: mp_limb_t; a6: var mp_limb_t): mp_limb_t {.importc.}
# func mpn_sec_add_1_itch*(a2: mp_size_t): mp_size_t {.importc.}
# func mpn_sec_div_qr*(a2: mp_ptr; a3: mp_ptr; a4: mp_size_t; a5: mp_srcptr; a6: mp_size_t; a7: mp_ptr): mp_limb_t {.importc.}
# func mpn_sec_div_qr*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: var mp_limb_t; a6: mp_size_t; a7: var mp_limb_t): mp_limb_t {.importc.}
# func mpn_sec_div_qr_itch*(a2: mp_size_t; a3: mp_size_t): mp_size_t {.importc.}
# func mpn_sec_div_r*(a2: mp_ptr; a3: mp_size_t; a4: mp_srcptr; a5: mp_size_t; a6: mp_ptr) {.importc.}
# func mpn_sec_div_r*(a2: var mp_limb_t; a3: mp_size_t; a4: var mp_limb_t; a5: mp_size_t; a6: var mp_limb_t) {.importc.}
# func mpn_sec_div_r_itch*(a2: mp_size_t; a3: mp_size_t): mp_size_t {.importc.}
# func mpn_sec_invert*(a2: mp_ptr; a3: mp_ptr; a4: mp_srcptr; a5: mp_size_t; a6: mp_bitcnt_t; a7: mp_ptr): cint {.importc.}
# func mpn_sec_invert*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t; a6: mp_bitcnt_t; a7: var mp_limb_t): cint {.importc.}
# func mpn_sec_invert_itch*(a2: mp_size_t): mp_size_t {.importc.}
# func mpn_sec_mul*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_srcptr; a6: mp_size_t; a7: mp_ptr) {.importc.}
# func mpn_sec_mul*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: var mp_limb_t; a6: mp_size_t; a7: var mp_limb_t) {.importc.}
# func mpn_sec_mul_itch*(a2: mp_size_t; a3: mp_size_t): mp_size_t {.importc.}
# func mpn_sec_powm*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_srcptr; a6: mp_bitcnt_t; a7: mp_srcptr; a8: mp_size_t; a9: mp_ptr) {.importc.}
# func mpn_sec_powm*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: var mp_limb_t; a6: mp_bitcnt_t; a7: var mp_limb_t; a8: mp_size_t; a9: var mp_limb_t) {.importc.}
# func mpn_sec_powm_itch*(a2: mp_size_t; a3: mp_bitcnt_t; a4: mp_size_t): mp_size_t {.importc.}
# func mpn_sec_sqr*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_ptr) {.importc.}
# func mpn_sec_sqr*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: var mp_limb_t) {.importc.}
# func mpn_sec_sqr_itch*(a2: mp_size_t): mp_size_t {.importc.}
# func mpn_sec_sub_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t; a6: mp_ptr): mp_limb_t {.importc.}
# func mpn_sec_sub_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: mp_limb_t; a6: var mp_limb_t): mp_limb_t {.importc.}
# func mpn_sec_sub_1_itch*(a2: mp_size_t): mp_size_t {.importc.}
# func mpn_sec_tabselect*(a2: ptr mp_limb_t; a3: ptr mp_limb_t; a4: mp_size_t; a5: mp_size_t; a6: mp_size_t) {.importc.}
# func mpn_set_str*(a2: mp_ptr; a3: ptr uint8; a4: csize_t; a5: cint): mp_size_t {.importc.}
# func mpn_set_str*(a2: var mp_limb_t; a3: ptr uint8; a4: csize_t; a5: cint): mp_size_t {.importc.}
# func mpn_sizeinbase*(a2: mp_srcptr; a3: mp_size_t; a4: cint): csize_t {.importc.}
# func mpn_sizeinbase*(a2: var mp_limb_t; a3: mp_size_t; a4: cint): csize_t {.importc.}
# func mpn_sqr*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t) {.importc.}
# func mpn_sqr*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t) {.importc.}
# func mpn_sqrtrem*(a2: mp_ptr; a3: mp_ptr; a4: mp_srcptr; a5: mp_size_t): mp_size_t {.importc.}
# func mpn_sqrtrem*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t): mp_size_t {.importc.}
# func mpn_sub*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_srcptr; a6: mp_size_t): mp_limb_t {.importc.}
# func mpn_sub*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: var mp_limb_t; a6: mp_size_t): mp_limb_t {.importc.}
# func mpn_sub_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.importc.}
# func mpn_sub_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.importc.}
# func mpn_sub_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t): mp_limb_t {.importc.}
# func mpn_sub_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t): mp_limb_t {.importc.}
# func mpn_submul_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.importc.}
# func mpn_submul_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.importc.}
# func mpn_tdiv_qr*(a2: mp_ptr; a3: mp_ptr; a4: mp_size_t; a5: mp_srcptr; a6: mp_size_t; a7: mp_srcptr; a8: mp_size_t) {.importc.}
# func mpn_tdiv_qr*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: var mp_limb_t; a6: mp_size_t; a7: var mp_limb_t; a8: mp_size_t) {.importc.}
# func mpn_xnor_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.importc.}
# func mpn_xnor_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t) {.importc.}
# func mpn_xor_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.importc.}
# func mpn_xor_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t) {.importc.}
# func mpn_zero*(a2: mp_ptr; a3: mp_size_t) {.importc.}
# func mpn_zero*(a2: var mp_limb_t; a3: mp_size_t) {.importc.}

# func mpq_abs*(mm_gmp_w: mpq_ptr; mm_gmp_u: mpq_srcptr) {.importc.}
# func mpq_abs*(mm_gmp_w: var mpq_t; mm_gmp_u: mpq_t) {.importc.}
# func mpq_add*(a2: mpq_ptr; a3: mpq_srcptr; a4: mpq_srcptr) {.importc.}
# func mpq_add*(a2: var mpq_t; a3: mpq_t; a4: mpq_t) {.importc.}
# func mpq_canonicalize*(a2: mpq_ptr) {.importc.}
# func mpq_canonicalize*(a2: var mpq_t) {.importc.}
# func mpq_clear*(a2: mpq_ptr) {.importc.}
# func mpq_clear*(a2: var mpq_t) {.importc.}
# func mpq_clears*(a2: mpq_ptr) {.varargs, importc.}
# func mpq_clears*(a2: var mpq_t) {.varargs, importc.}
# func mpq_cmp*(a2: mpq_srcptr; a3: mpq_srcptr): cint {.importc.}
# func mpq_cmp*(a2: mpq_t; a3: mpq_t): cint {.importc.}
# func mpq_denref*(a2: mpq_ptr): mpz_ptr {.importc.}
# func mpq_denref*(a2: var mpq_t): mpz_ptr {.importc.}
# func mpq_div*(a2: mpq_ptr; a3: mpq_srcptr; a4: mpq_srcptr) {.importc.}
# func mpq_div*(a2: var mpq_t; a3: mpq_t; a4: mpq_t) {.importc.}
# func mpq_div_2exp*(a2: mpq_ptr; a3: mpq_srcptr; a4: mp_bitcnt_t) {.importc.}
# func mpq_div_2exp*(a2: var mpq_t; a3: mpq_t; a4: mp_bitcnt_t) {.importc.}
# func mpq_equal*(a2: mpq_srcptr; a3: mpq_srcptr): cint {.importc.}
# func mpq_equal*(a2: mpq_t; a3: mpq_t): cint {.importc.}
# func mpq_get_d*(a2: mpq_srcptr): cdouble {.importc.}
# func mpq_get_d*(a2: mpq_t): cdouble {.importc.}
# func mpq_get_den*(a2: mpz_ptr; a3: mpq_srcptr) {.importc.}
# func mpq_get_den*(a2: var mpz_t; a3: mpq_t) {.importc.}
# func mpq_get_num*(a2: mpz_ptr; a3: mpq_srcptr) {.importc.}
# func mpq_get_num*(a2: var mpz_t; a3: mpq_t) {.importc.}
# func mpq_get_str*(a2: cstring; a3: cint; a4: mpq_srcptr): cstring {.importc.}
# func mpq_get_str*(a2: cstring; a3: cint; a4: mpq_t): cstring {.importc.}
# func mpq_init*(a2: mpq_ptr) {.importc.}
# func mpq_init*(a2: var mpq_t) {.importc.}
# func mpq_inits*(a2: mpq_ptr) {.varargs, importc.}
# func mpq_inits*(a2: var mpq_t) {.varargs, importc.}
# func mpq_inp_str*(a2: mpq_ptr; a3: File; a4: cint): csize_t {.importc.}
# func mpq_inp_str*(a2: var mpq_t; a3: File; a4: cint): csize_t {.importc.}
# func mpq_inv*(a2: mpq_ptr; a3: mpq_srcptr) {.importc.}
# func mpq_inv*(a2: var mpq_t; a3: mpq_t) {.importc.}
# func mpq_mul*(a2: mpq_ptr; a3: mpq_srcptr; a4: mpq_srcptr) {.importc.}
# func mpq_mul*(a2: var mpq_t; a3: mpq_t; a4: mpq_t) {.importc.}
# func mpq_mul_2exp*(a2: mpq_ptr; a3: mpq_srcptr; a4: mp_bitcnt_t) {.importc.}
# func mpq_mul_2exp*(a2: var mpq_t; a3: mpq_t; a4: mp_bitcnt_t) {.importc.}
# func mpq_neg*(mm_gmp_w: mpq_ptr; mm_gmp_u: mpq_srcptr) {.importc.}
# func mpq_neg*(mm_gmp_w: var mpq_t; mm_gmp_u: mpq_t) {.importc.}
# func mpq_numref*(a2: mpq_ptr): mpz_ptr {.importc.}
# func mpq_numref*(a2: var mpq_t): mpz_ptr {.importc.}
# func mpq_out_str*(a2: File; a3: cint; a4: mpq_srcptr): csize_t {.importc.}
# func mpq_out_str*(a2: File; a3: cint; a4: mpq_t): csize_t {.importc.}
# func mpq_set*(a2: mpq_ptr; a3: mpq_srcptr) {.importc.}
# func mpq_set*(a2: var mpq_t; a3: mpq_t) {.importc.}
# func mpq_set_d*(a2: mpq_ptr; a3: cdouble) {.importc.}
# func mpq_set_d*(a2: var mpq_t; a3: cdouble) {.importc.}
# func mpq_set_den*(a2: mpq_ptr; a3: mpz_srcptr) {.importc.}
# func mpq_set_den*(a2: var mpq_t; a3: mpz_t) {.importc.}
# func mpq_set_f*(a2: mpq_ptr; a3: mpf_srcptr) {.importc.}
# func mpq_set_f*(a2: var mpq_t; a3: mpf_t) {.importc.}
# func mpq_set_num*(a2: mpq_ptr; a3: mpz_srcptr) {.importc.}
# func mpq_set_num*(a2: var mpq_t; a3: mpz_t) {.importc.}
# func mpq_set_si*(a2: mpq_ptr; a3: clong; a4: culong) {.importc.}
# func mpq_set_si*(a2: var mpq_t; a3: clong; a4: culong) {.importc.}
# func mpq_set_str*(a2: mpq_ptr; a3: cstring; a4: cint): cint {.importc.}
# func mpq_set_str*(a2: var mpq_t; a3: cstring; a4: cint): cint {.importc.}
# func mpq_set_ui*(a2: mpq_ptr; a3: culong; a4: culong) {.importc.}
# func mpq_set_ui*(a2: var mpq_t; a3: culong; a4: culong) {.importc.}
# func mpq_set_z*(a2: mpq_ptr; a3: mpz_srcptr) {.importc.}
# func mpq_set_z*(a2: var mpq_t; a3: mpz_t) {.importc.}
# func mpq_sgn*(a2: mpq_srcptr): cint {.importc.}
# func mpq_sgn*(a2: mpq_t): cint {.importc.}
# func mpq_sub*(a2: mpq_ptr; a3: mpq_srcptr; a4: mpq_srcptr) {.importc.}
# func mpq_sub*(a2: var mpq_t; a3: mpq_t; a4: mpq_t) {.importc.}
# func mpq_swap*(a2: mpq_ptr; a3: mpq_ptr) {.importc.}
# func mpq_swap*(a2: var mpq_t; a3: var mpq_t) {.importc.}

# func mpz_2fac_ui*(a2: mpz_ptr; a3: culong) {.importc.}
# func mpz_2fac_ui*(a2: var mpz_t; a3: culong) {.importc.}
# func mpz_abs*(mm_gmp_w: mpz_ptr; mm_gmp_u: mpz_srcptr) {.importc.}
# func mpz_abs*(mm_gmp_w: var mpz_t; mm_gmp_u: mpz_t) {.importc.}
# func mpz_add*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc.}
# func mpz_add*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc.}
# func mpz_add_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.importc.}
# func mpz_add_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc.}
# func mpz_addmul*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc.}
# func mpz_addmul*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc.}
# func mpz_addmul_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.importc.}
# func mpz_addmul_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc.}
# func mpz_and*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc.}
# func mpz_and*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc.}
# func mpz_array_init*(a2: mpz_ptr; a3: mp_size_t; a4: mp_size_t) {.importc.}
# func mpz_array_init*(a2: var mpz_t; a3: mp_size_t; a4: mp_size_t) {.importc.}
# func mpz_bin_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.importc.}
# func mpz_bin_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc.}
# func mpz_bin_uiui*(a2: mpz_ptr; a3: culong; a4: culong) {.importc.}
# func mpz_bin_uiui*(a2: var mpz_t; a3: culong; a4: culong) {.importc.}
# func mpz_cdiv_q*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc.}
# func mpz_cdiv_q*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc.}
# func mpz_cdiv_q_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.importc.}
# func mpz_cdiv_q_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.importc.}
# func mpz_cdiv_q_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.importc.}
# func mpz_cdiv_q_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.importc.}
# func mpz_cdiv_qr*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: mpz_srcptr) {.importc.}
# func mpz_cdiv_qr*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: mpz_t) {.importc.}
# func mpz_cdiv_qr_ui*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: culong): culong {.importc.}
# func mpz_cdiv_qr_ui*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: culong): culong {.importc.}
# func mpz_cdiv_r*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc.}
# func mpz_cdiv_r*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc.}
# func mpz_cdiv_r_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.importc.}
# func mpz_cdiv_r_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.importc.}
# func mpz_cdiv_r_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.importc.}
# func mpz_cdiv_r_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.importc.}
# func mpz_cdiv_ui*(a2: mpz_srcptr; a3: culong): culong {.importc.}
# func mpz_cdiv_ui*(a2: mpz_t; a3: culong): culong {.importc.}
# func mpz_clear*(a2: mpz_ptr) {.importc.}
# func mpz_clear*(a2: var mpz_t) {.importc.}
# func mpz_clears*(a2: mpz_ptr) {.varargs, importc.}
# func mpz_clears*(a2: var mpz_t) {.varargs, importc.}
# func mpz_clrbit*(a2: mpz_ptr; a3: mp_bitcnt_t) {.importc.}
# func mpz_clrbit*(a2: var mpz_t; a3: mp_bitcnt_t) {.importc.}
# func mpz_cmp*(a2: mpz_srcptr; a3: mpz_srcptr): cint {.importc.}
# func mpz_cmp*(a2: mpz_t; a3: mpz_t): cint {.importc.}
# func mpz_cmp_d*(a2: mpz_srcptr; a3: cdouble): cint {.importc.}
# func mpz_cmp_d*(a2: mpz_t; a3: cdouble): cint {.importc.}
# func mpz_cmp_si*(a2: mpz_srcptr; a3: clong): cint {.importc: "_mpz_cmp_si".}
# func mpz_cmp_si*(a2: mpz_t; a3: clong): cint {.importc: "_mpz_cmp_si".}
# func mpz_cmp_ui*(a2: mpz_srcptr; a3: culong): cint {.importc: "_mpz_cmp_ui".}
# func mpz_cmp_ui*(a2: mpz_t; a3: culong): cint {.importc: "_mpz_cmp_ui".}
# func mpz_cmpabs*(a2: mpz_srcptr; a3: mpz_srcptr): cint {.importc.}
# func mpz_cmpabs*(a2: mpz_t; a3: mpz_t): cint {.importc.}
# func mpz_cmpabs_d*(a2: mpz_srcptr; a3: cdouble): cint {.importc.}
# func mpz_cmpabs_d*(a2: mpz_t; a3: cdouble): cint {.importc.}
# func mpz_cmpabs_ui*(a2: mpz_srcptr; a3: culong): cint {.importc.}
# func mpz_cmpabs_ui*(a2: mpz_t; a3: culong): cint {.importc.}
# func mpz_com*(a2: mpz_ptr; a3: mpz_srcptr) {.importc.}
# func mpz_com*(a2: var mpz_t; a3: mpz_t) {.importc.}
# func mpz_combit*(a2: mpz_ptr; a3: mp_bitcnt_t) {.importc.}
# func mpz_combit*(a2: var mpz_t; a3: mp_bitcnt_t) {.importc.}
# func mpz_congruent_2exp_p*(a2: mpz_srcptr; a3: mpz_srcptr; a4: mp_bitcnt_t): cint {.importc.}
# func mpz_congruent_2exp_p*(a2: mpz_t; a3: mpz_t; a4: mp_bitcnt_t): cint {.importc.}
# func mpz_congruent_p*(a2: mpz_srcptr; a3: mpz_srcptr; a4: mpz_srcptr): cint {.importc.}
# func mpz_congruent_p*(a2: mpz_t; a3: mpz_t; a4: mpz_t): cint {.importc.}
# func mpz_congruent_ui_p*(a2: mpz_srcptr; a3: culong; a4: culong): cint {.importc.}
# func mpz_congruent_ui_p*(a2: mpz_t; a3: culong; a4: culong): cint {.importc.}
# func mpz_divexact*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc.}
# func mpz_divexact*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc.}
# func mpz_divexact_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.importc.}
# func mpz_divexact_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc.}
# func mpz_divisible_2exp_p*(a2: mpz_srcptr; a3: mp_bitcnt_t): cint {.importc.}
# func mpz_divisible_2exp_p*(a2: mpz_t; a3: mp_bitcnt_t): cint {.importc.}
# func mpz_divisible_p*(a2: mpz_srcptr; a3: mpz_srcptr): cint {.importc.}
# func mpz_divisible_p*(a2: mpz_t; a3: mpz_t): cint {.importc.}
# func mpz_divisible_ui_p*(a2: mpz_srcptr; a3: culong): cint {.importc.}
# func mpz_divisible_ui_p*(a2: mpz_t; a3: culong): cint {.importc.}
# func mpz_dump*(a2: mpz_srcptr) {.importc.}
# func mpz_dump*(a2: mpz_t) {.importc.}
# func mpz_even_p*(a2: mpz_srcptr): cint {.importc.}
# func mpz_even_p*(a2: mpz_t): cint {.importc.}
# func mpz_export*(a2: pointer; a3: ptr csize_t; a4: cint; a5: csize_t; a6: cint; a7: csize_t; a8: mpz_srcptr): pointer {.importc.}
# func mpz_export*(a2: pointer; a3: ptr csize_t; a4: cint; a5: csize_t; a6: cint; a7: csize_t; a8: mpz_t): pointer {.importc.}
# func mpz_fac_ui*(a2: mpz_ptr; a3: culong) {.importc.}
# func mpz_fac_ui*(a2: var mpz_t; a3: culong) {.importc.}
# func mpz_fdiv_q*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc.}
# func mpz_fdiv_q*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc.}
# func mpz_fdiv_q_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.importc.}
# func mpz_fdiv_q_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.importc.}
# func mpz_fdiv_q_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.importc.}
# func mpz_fdiv_q_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.importc.}
# func mpz_fdiv_qr*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: mpz_srcptr) {.importc.}
# func mpz_fdiv_qr*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: mpz_t) {.importc.}
# func mpz_fdiv_qr_ui*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: culong): culong {.importc.}
# func mpz_fdiv_qr_ui*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: culong): culong {.importc.}
# func mpz_fdiv_r*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc.}
# func mpz_fdiv_r*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc.}
# func mpz_fdiv_r_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.importc.}
# func mpz_fdiv_r_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.importc.}
# func mpz_fdiv_r_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.importc.}
# func mpz_fdiv_r_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.importc.}
# func mpz_fdiv_ui*(a2: mpz_srcptr; a3: culong): culong {.importc.}
# func mpz_fdiv_ui*(a2: mpz_t; a3: culong): culong {.importc.}
# func mpz_fib2_ui*(a2: mpz_ptr; a3: mpz_ptr; a4: culong) {.importc.}
# func mpz_fib2_ui*(a2: var mpz_t; a3: var mpz_t; a4: culong) {.importc.}
# func mpz_fib_ui*(a2: mpz_ptr; a3: culong) {.importc.}
# func mpz_fib_ui*(a2: var mpz_t; a3: culong) {.importc.}
# func mpz_fits_sint_p*(a2: mpz_srcptr): cint {.importc.}
# func mpz_fits_sint_p*(a2: mpz_t): cint {.importc.}
# func mpz_fits_slong_p*(a2: mpz_srcptr): cint {.importc.}
# func mpz_fits_slong_p*(a2: mpz_t): cint {.importc.}
# func mpz_fits_sshort_p*(a2: mpz_srcptr): cint {.importc.}
# func mpz_fits_sshort_p*(a2: mpz_t): cint {.importc.}
# func mpz_fits_uint_p*(mm_gmp_z: mpz_srcptr): cint {.importc.}
# func mpz_fits_uint_p*(mm_gmp_z: mpz_t): cint {.importc.}
# func mpz_fits_ulong_p*(mm_gmp_z: mpz_srcptr): cint {.importc.}
# func mpz_fits_ulong_p*(mm_gmp_z: mpz_t): cint {.importc.}
# func mpz_fits_ushort_p*(mm_gmp_z: mpz_srcptr): cint {.importc.}
# func mpz_fits_ushort_p*(mm_gmp_z: mpz_t): cint {.importc.}
# func mpz_gcd*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc.}
# func mpz_gcd*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc.}
# func mpz_gcd_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.importc.}
# func mpz_gcd_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.importc.}
# func mpz_gcdext*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_ptr; a5: mpz_srcptr; a6: mpz_srcptr) {.importc.}
# func mpz_gcdext*(a2: var mpz_t; a3: var mpz_t; a4: var mpz_t; a5: mpz_t; a6: mpz_t) {.importc.}
# func mpz_get_d*(a2: mpz_srcptr): cdouble {.importc.}
# func mpz_get_d*(a2: mpz_t): cdouble {.importc.}
# func mpz_get_d_2exp*(a2: ptr clong; a3: mpz_srcptr): cdouble {.importc.}
# func mpz_get_d_2exp*(a2: ptr clong; a3: mpz_t): cdouble {.importc.}
# func mpz_get_si*(a2: mpz_srcptr): clong {.importc.}
# func mpz_get_si*(a2: mpz_t): clong {.importc.}
# func mpz_get_str*(a2: cstring; a3: cint; a4: mpz_srcptr): cstring {.importc.}
# func mpz_get_str*(a2: cstring; a3: cint; a4: mpz_t): cstring {.importc.}
# func mpz_get_ui*(mm_gmp_z: mpz_srcptr): culong {.importc.}
# func mpz_get_ui*(mm_gmp_z: mpz_t): culong {.importc.}
# func mpz_getlimbn*(mm_gmp_z: mpz_srcptr; mm_gmp_n: mp_size_t): mp_limb_t {.importc.}
# func mpz_getlimbn*(mm_gmp_z: mpz_t; mm_gmp_n: mp_size_t): mp_limb_t {.importc.}
# func mpz_hamdist*(a2: mpz_srcptr; a3: mpz_srcptr): mp_bitcnt_t {.importc.}
# func mpz_hamdist*(a2: mpz_t; a3: mpz_t): mp_bitcnt_t {.importc.}
# func mpz_import*(a2: mpz_ptr; a3: csize_t; a4: cint; a5: csize_t; a6: cint; a7: csize_t; a8: pointer) {.importc.}
# func mpz_import*(a2: var mpz_t; a3: csize_t; a4: cint; a5: csize_t; a6: cint; a7: csize_t; a8: pointer) {.importc.}
# func mpz_init*(a2: mpz_ptr) {.importc.}
# func mpz_init*(a2: var mpz_t) {.importc.}
# func mpz_init2*(a2: mpz_ptr; a3: mp_bitcnt_t) {.importc.}
# func mpz_init2*(a2: var mpz_t; a3: mp_bitcnt_t) {.importc.}
# func mpz_init_set*(a2: mpz_ptr; a3: mpz_srcptr) {.importc.}
# func mpz_init_set*(a2: var mpz_t; a3: mpz_t) {.importc.}
# func mpz_init_set_d*(a2: mpz_ptr; a3: cdouble) {.importc.}
# func mpz_init_set_d*(a2: var mpz_t; a3: cdouble) {.importc.}
# func mpz_init_set_si*(a2: mpz_ptr; a3: clong) {.importc.}
# func mpz_init_set_si*(a2: var mpz_t; a3: clong) {.importc.}
# func mpz_init_set_str*(a2: mpz_ptr; a3: cstring; a4: cint): cint {.importc.}
# func mpz_init_set_str*(a2: var mpz_t; a3: cstring; a4: cint): cint {.importc.}
# func mpz_init_set_ui*(a2: mpz_ptr; a3: culong) {.importc.}
# func mpz_init_set_ui*(a2: var mpz_t; a3: culong) {.importc.}
# func mpz_inits*(a2: mpz_ptr) {.varargs, importc.}
# func mpz_inits*(a2: var mpz_t) {.varargs, importc.}
# func mpz_inp_raw*(a2: mpz_ptr; a3: File): csize_t {.importc.}
# func mpz_inp_raw*(a2: var mpz_t; a3: File): csize_t {.importc.}
# func mpz_inp_str*(a2: mpz_ptr; a3: File; a4: cint): csize_t {.importc.}
# func mpz_inp_str*(a2: var mpz_t; a3: File; a4: cint): csize_t {.importc.}
# func mpz_invert*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr): cint {.importc.}
# func mpz_invert*(a2: var mpz_t; a3: mpz_t; a4: mpz_t): cint {.importc.}
# func mpz_ior*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc.}
# func mpz_ior*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc.}
# func mpz_jacobi*(a2: mpz_srcptr; a3: mpz_srcptr): cint {.importc.}
# func mpz_jacobi*(a2: mpz_t; a3: mpz_t): cint {.importc.}
# func mpz_kronecker_si*(a2: mpz_srcptr; a3: clong): cint {.importc.}
# func mpz_kronecker_si*(a2: mpz_t; a3: clong): cint {.importc.}
# func mpz_kronecker_ui*(a2: mpz_srcptr; a3: culong): cint {.importc.}
# func mpz_kronecker_ui*(a2: mpz_t; a3: culong): cint {.importc.}
# func mpz_lcm*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc.}
# func mpz_lcm*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc.}
# func mpz_lcm_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.importc.}
# func mpz_lcm_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc.}
# func mpz_limbs_finish*(a2: mpz_ptr; a3: mp_size_t) {.importc.}
# func mpz_limbs_finish*(a2: var mpz_t; a3: mp_size_t) {.importc.}
# func mpz_limbs_modify*(a2: mpz_ptr; a3: mp_size_t): mp_ptr {.importc.}
# func mpz_limbs_modify*(a2: var mpz_t; a3: mp_size_t): mp_ptr {.importc.}
# func mpz_limbs_read*(a2: mpz_srcptr): mp_srcptr {.importc.}
# func mpz_limbs_read*(a2: mpz_t): mp_srcptr {.importc.}
# func mpz_limbs_write*(a2: mpz_ptr; a3: mp_size_t): mp_ptr {.importc.}
# func mpz_limbs_write*(a2: var mpz_t; a3: mp_size_t): mp_ptr {.importc.}
# func mpz_lucnum2_ui*(a2: mpz_ptr; a3: mpz_ptr; a4: culong) {.importc.}
# func mpz_lucnum2_ui*(a2: var mpz_t; a3: var mpz_t; a4: culong) {.importc.}
# func mpz_lucnum_ui*(a2: mpz_ptr; a3: culong) {.importc.}
# func mpz_lucnum_ui*(a2: var mpz_t; a3: culong) {.importc.}
# func mpz_mfac_uiui*(a2: mpz_ptr; a3: culong; a4: culong) {.importc.}
# func mpz_mfac_uiui*(a2: var mpz_t; a3: culong; a4: culong) {.importc.}
# func mpz_millerrabin*(a2: mpz_srcptr; a3: cint): cint {.importc.}
# func mpz_millerrabin*(a2: mpz_t; a3: cint): cint {.importc.}
# func mpz_mod*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc.}
# func mpz_mod*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc.}
# func mpz_mul*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc.}
# func mpz_mul*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc.}
# func mpz_mul_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.importc.}
# func mpz_mul_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.importc.}
# func mpz_mul_si*(a2: mpz_ptr; a3: mpz_srcptr; a4: clong) {.importc.}
# func mpz_mul_si*(a2: var mpz_t; a3: mpz_t; a4: clong) {.importc.}
# func mpz_mul_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.importc.}
# func mpz_mul_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc.}
# func mpz_neg*(mm_gmp_w: mpz_ptr; mm_gmp_u: mpz_srcptr) {.importc.}
# func mpz_neg*(mm_gmp_w: var mpz_t; mm_gmp_u: mpz_t) {.importc.}
# func mpz_nextprime*(a2: mpz_ptr; a3: mpz_srcptr) {.importc.}
# func mpz_nextprime*(a2: var mpz_t; a3: mpz_t) {.importc.}
# func mpz_odd_p*(a2: mpz_srcptr): cint {.importc.}
# func mpz_odd_p*(a2: mpz_t): cint {.importc.}
# func mpz_out_raw*(a2: File; a3: mpz_srcptr): csize_t {.importc.}
# func mpz_out_raw*(a2: File; a3: mpz_t): csize_t {.importc.}
# func mpz_out_str*(a2: File; a3: cint; a4: mpz_srcptr): csize_t {.importc.}
# func mpz_out_str*(a2: File; a3: cint; a4: mpz_t): csize_t {.importc.}
# func mpz_perfect_power_p*(a2: mpz_srcptr): cint {.importc.}
# func mpz_perfect_power_p*(a2: mpz_t): cint {.importc.}
# func mpz_perfect_square_p*(mm_gmp_a: mpz_srcptr): cint {.importc.}
# func mpz_perfect_square_p*(mm_gmp_a: mpz_t): cint {.importc.}
# func mpz_popcount*(mm_gmp_u: mpz_srcptr): mp_bitcnt_t {.importc.}
# func mpz_popcount*(mm_gmp_u: mpz_t): mp_bitcnt_t {.importc.}
# func mpz_pow_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.importc.}
# func mpz_pow_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc.}
# func mpz_powm*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr; a5: mpz_srcptr) {.importc.}
# func mpz_powm*(a2: var mpz_t; a3: mpz_t; a4: mpz_t; a5: mpz_t) {.importc.}
# func mpz_powm_sec*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr; a5: mpz_srcptr) {.importc.}
# func mpz_powm_sec*(a2: var mpz_t; a3: mpz_t; a4: mpz_t; a5: mpz_t) {.importc.}
# func mpz_powm_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong; a5: mpz_srcptr) {.importc.}
# func mpz_powm_ui*(a2: var mpz_t; a3: mpz_t; a4: culong; a5: mpz_t) {.importc.}
# func mpz_primorial_ui*(a2: mpz_ptr; a3: culong) {.importc.}
# func mpz_primorial_ui*(a2: var mpz_t; a3: culong) {.importc.}
# func mpz_probab_prime_p*(a2: mpz_srcptr; a3: cint): cint {.importc.}
# func mpz_probab_prime_p*(a2: mpz_t; a3: cint): cint {.importc.}
# func mpz_random*(a2: mpz_ptr; a3: mp_size_t) {.importc.}
# func mpz_random*(a2: var mpz_t; a3: mp_size_t) {.importc.}
# func mpz_random2*(a2: mpz_ptr; a3: mp_size_t) {.importc.}
# func mpz_random2*(a2: var mpz_t; a3: mp_size_t) {.importc.}
# func mpz_realloc2*(a2: mpz_ptr; a3: mp_bitcnt_t) {.importc.}
# func mpz_realloc2*(a2: var mpz_t; a3: mp_bitcnt_t) {.importc.}
# func mpz_remove*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr): mp_bitcnt_t {.importc.}
# func mpz_remove*(a2: var mpz_t; a3: mpz_t; a4: mpz_t): mp_bitcnt_t {.importc.}
# func mpz_roinit_n*(a2: mpz_ptr; a3: mp_srcptr; a4: mp_size_t): mpz_srcptr {.importc.}
# func mpz_roinit_n*(a2: var mpz_t; a3: var mp_limb_t; a4: mp_size_t): mpz_srcptr {.importc.}
# func mpz_root*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): cint {.importc.}
# func mpz_root*(a2: var mpz_t; a3: mpz_t; a4: culong): cint {.importc.}
# func mpz_rootrem*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: culong) {.importc.}
# func mpz_rootrem*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: culong) {.importc.}
# func mpz_rrandomb*(a2: mpz_ptr; a3: gmp_randstate_t; a4: mp_bitcnt_t) {.importc.}
# func mpz_rrandomb*(a2: var mpz_t; a3: gmp_randstate_t; a4: mp_bitcnt_t) {.importc.}
# func mpz_scan0*(a2: mpz_srcptr; a3: mp_bitcnt_t): mp_bitcnt_t {.importc.}
# func mpz_scan0*(a2: mpz_t; a3: mp_bitcnt_t): mp_bitcnt_t {.importc.}
# func mpz_scan1*(a2: mpz_srcptr; a3: mp_bitcnt_t): mp_bitcnt_t {.importc.}
# func mpz_scan1*(a2: mpz_t; a3: mp_bitcnt_t): mp_bitcnt_t {.importc.}
# func mpz_set*(a2: mpz_ptr; a3: mpz_srcptr) {.importc.}
# func mpz_set*(a2: var mpz_t; a3: mpz_t) {.importc.}
# func mpz_set_d*(a2: mpz_ptr; a3: cdouble) {.importc.}
# func mpz_set_d*(a2: var mpz_t; a3: cdouble) {.importc.}
# func mpz_set_f*(a2: mpz_ptr; a3: mpf_srcptr) {.importc.}
# func mpz_set_f*(a2: var mpz_t; a3: mpf_t) {.importc.}
# func mpz_set_q*(mm_gmp_w: mpz_ptr; mm_gmp_u: mpq_srcptr) {.importc.}
# func mpz_set_q*(mm_gmp_w: var mpz_t; mm_gmp_u: mpq_t) {.importc.}
# func mpz_set_si*(a2: mpz_ptr; a3: clong) {.importc.}
# func mpz_set_si*(a2: var mpz_t; a3: clong) {.importc.}
# func mpz_set_str*(a2: mpz_ptr; a3: cstring; a4: cint): cint {.importc.}
# func mpz_set_str*(a2: var mpz_t; a3: cstring; a4: cint): cint {.importc.}
# func mpz_set_ui*(a2: mpz_ptr; a3: culong) {.importc.}
# func mpz_set_ui*(a2: var mpz_t; a3: culong) {.importc.}
# func mpz_setbit*(a2: mpz_ptr; a3: mp_bitcnt_t) {.importc.}
# func mpz_setbit*(a2: var mpz_t; a3: mp_bitcnt_t) {.importc.}
# func mpz_sgn*(a2: mpz_srcptr): cint {.importc.}
# func mpz_sgn*(a2: mpz_t): cint {.importc.}
# func mpz_si_kronecker*(a2: clong; a3: mpz_srcptr): cint {.importc.}
# func mpz_si_kronecker*(a2: clong; a3: mpz_t): cint {.importc.}
# func mpz_size*(mm_gmp_z: mpz_srcptr): csize_t {.importc.}
# func mpz_size*(mm_gmp_z: mpz_t): csize_t {.importc.}
# func mpz_sizeinbase*(a2: mpz_srcptr; a3: cint): csize_t {.importc.}
# func mpz_sizeinbase*(a2: mpz_t; a3: cint): csize_t {.importc.}
# func mpz_sqrt*(a2: mpz_ptr; a3: mpz_srcptr) {.importc.}
# func mpz_sqrt*(a2: var mpz_t; a3: mpz_t) {.importc.}
# func mpz_sqrtrem*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr) {.importc.}
# func mpz_sqrtrem*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t) {.importc.}
# func mpz_sub*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc.}
# func mpz_sub*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc.}
# func mpz_sub_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.importc.}
# func mpz_sub_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc.}
# func mpz_submul*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc.}
# func mpz_submul*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc.}
# func mpz_submul_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.importc.}
# func mpz_submul_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc.}
# func mpz_swap*(a2: mpz_ptr; a3: mpz_ptr) {.importc.}
# func mpz_swap*(a2: var mpz_t; a3: var mpz_t) {.importc.}
# func mpz_tdiv_q*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc.}
# func mpz_tdiv_q*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc.}
# func mpz_tdiv_q_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.importc.}
# func mpz_tdiv_q_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.importc.}
# func mpz_tdiv_q_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.importc.}
# func mpz_tdiv_q_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.importc.}
# func mpz_tdiv_qr*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: mpz_srcptr) {.importc.}
# func mpz_tdiv_qr*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: mpz_t) {.importc.}
# func mpz_tdiv_qr_ui*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: culong): culong {.importc.}
# func mpz_tdiv_qr_ui*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: culong): culong {.importc.}
# func mpz_tdiv_r*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc.}
# func mpz_tdiv_r*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc.}
# func mpz_tdiv_r_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.importc.}
# func mpz_tdiv_r_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.importc.}
# func mpz_tdiv_r_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.importc.}
# func mpz_tdiv_r_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.importc.}
# func mpz_tdiv_ui*(a2: mpz_srcptr; a3: culong): culong {.importc.}
# func mpz_tdiv_ui*(a2: mpz_t; a3: culong): culong {.importc.}
# func mpz_tstbit*(a2: mpz_srcptr; a3: mp_bitcnt_t): cint {.importc.}
# func mpz_tstbit*(a2: mpz_t; a3: mp_bitcnt_t): cint {.importc.}
# func mpz_ui_kronecker*(a2: culong; a3: mpz_srcptr): cint {.importc.}
# func mpz_ui_kronecker*(a2: culong; a3: mpz_t): cint {.importc.}
# func mpz_ui_pow_ui*(a2: mpz_ptr; a3: culong; a4: culong) {.importc.}
# func mpz_ui_pow_ui*(a2: var mpz_t; a3: culong; a4: culong) {.importc.}
# func mpz_ui_sub*(a2: mpz_ptr; a3: culong; a4: mpz_srcptr) {.importc.}
# func mpz_ui_sub*(a2: var mpz_t; a3: culong; a4: mpz_t) {.importc.}
# func mpz_urandomb*(a2: mpz_ptr; a3: gmp_randstate_t; a4: mp_bitcnt_t) {.importc.}
# func mpz_urandomb*(a2: var mpz_t; a3: gmp_randstate_t; a4: mp_bitcnt_t) {.importc.}
# func mpz_urandomm*(a2: mpz_ptr; a3: gmp_randstate_t; a4: mpz_srcptr) {.importc.}
# func mpz_urandomm*(a2: var mpz_t; a3: gmp_randstate_t; a4: mpz_t) {.importc.}
# func mpz_xor*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc.}
# func mpz_xor*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc.}

{.pop.}

#=======================================
# Methods
#=======================================

func finalizeRFloat*(z: ref mpfr) =
    mpfr_clear(z[])