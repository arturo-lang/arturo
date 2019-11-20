#
# Nim GMP wrapper 
# (c) Copyright 2014 Will Szumski
#
# See the file "COPYING", included in this
# distribution, for details about the copyright.
#

{.deadCodeElim: on.}

when defined(windows):
  const libgmp* = "libgmp.dll"
elif defined(macosx):
  const libgmp* = "libgmp.dylib"
else:
  const libgmp* = "libgmp.so"
  
type 
  mm_gmp_randstate_algdata* {.pure, union.} = object
    mp_lc*: pointer

  mp_limb_t* = uint
  mp_limb_signed_t* = int
  mp_bitcnt_t* = culong
  mm_mpz_struct* {.byref, pure.} = object 
    mp_alloc*: cint
    mp_size*: cint
    mp_d*: ptr mp_limb_t

  MP_INT* = mm_mpz_struct
  mpz_t* = mm_mpz_struct
  mp_ptr* = ptr mp_limb_t
  mp_srcptr* = ptr mp_limb_t
  mp_size_t* = clong
  mp_exp_t* = clong
  mm_mpq_struct* {.byref, pure.} = object 
    mp_num*: mm_mpz_struct
    mp_den*: mm_mpz_struct

  MP_RAT* = mm_mpq_struct
  mpq_t* = mm_mpq_struct
  mm_mpf_struct* {.byref, pure.} = object 
    mp_prec*: cint
    mp_size*: cint
    mp_exp*: mp_exp_t
    mp_d*: ptr mp_limb_t

  mpf_t* = mm_mpf_struct
  gmp_randalg_t* = distinct cint
  mm_gmp_randstate_struct* {.pure.} = object 
    mp_seed*: mpz_t
    mp_alg*: gmp_randalg_t
    mp_algdata*: mm_gmp_randstate_algdata

  gmp_randstate_t* = mm_gmp_randstate_struct
  mpz_srcptr* = ptr mm_mpz_struct
  mpz_ptr* = ptr mm_mpz_struct
  mpf_srcptr* = ptr mm_mpf_struct
  mpf_ptr* = ptr mm_mpf_struct
  mpq_srcptr* = ptr mm_mpq_struct
  mpq_ptr* = ptr mm_mpq_struct
  
include extratypes

const 
  GMP_RAND_ALG_DEFAULT: gmp_randalg_t = 0.gmp_randalg_t
  GMP_RAND_ALG_LC: gmp_randalg_t = GMP_RAND_ALG_DEFAULT

proc mpq_numref*(a2: mpq_ptr): mpz_ptr = a2.mp_num.addr
proc mpq_numref*(a2: var mpq_t): mpz_ptr = mpq_numref(a2.addr)
proc mpq_denref*(a2: mpq_ptr): mpz_ptr = a2.mp_den.addr
proc mpq_denref*(a2: var mpq_t): mpz_ptr = mpq_denref(a2.addr)
proc mp_set_memory_functions*(a2: proc (a2: csize): pointer; a3: proc (
    a2: pointer; a3: csize; a4: csize): pointer; 
                              a4: proc (a2: pointer; a3: csize)) {.
    importc: "__gmp_set_memory_functions", dynlib: libgmp, cdecl.}
proc mp_get_memory_functions*(a2: proc (a2: csize): pointer; a3: proc (
    a2: pointer; a3: csize; a4: csize): pointer; 
                              a4: proc (a2: pointer; a3: csize)) {.
    importc: "__gmp_get_memory_functions", dynlib: libgmp, cdecl.}
var mp_bits_per_limb* {.importc: "mp_bits_per_limb", header: "<gmp.h>".}: cint
var gmp_errno* {.importc: "gmp_errno", header: "<gmp.h>".}: cint
var gmp_version* {.importc: "gmp_version", header: "<gmp.h>".}: cstring
proc gmp_randinit*(a2: gmp_randstate_t; a3: gmp_randalg_t) {.varargs, 
    importc: "__gmp_randinit", dynlib: libgmp, cdecl.}
proc gmp_randinit_default*(a2: gmp_randstate_t) {.
    importc: "__gmp_randinit_default", dynlib: libgmp, cdecl.}
proc gmp_randinit_lc_2exp*(a2: gmp_randstate_t; a3: mpz_srcptr; a4: culong; 
                           a5: mp_bitcnt_t) {.importc: "__gmp_randinit_lc_2exp", 
    dynlib: libgmp, cdecl.}
proc gmp_randinit_lc_2exp*(a2: gmp_randstate_t; a3: mpz_t; a4: culong; 
                           a5: mp_bitcnt_t) {.importc: "__gmp_randinit_lc_2exp", 
    dynlib: libgmp, cdecl.}
proc gmp_randinit_lc_2exp_size*(a2: gmp_randstate_t; a3: mp_bitcnt_t): cint {.
    importc: "__gmp_randinit_lc_2exp_size", dynlib: libgmp, cdecl.}
proc gmp_randinit_mt*(a2: gmp_randstate_t) {.importc: "__gmp_randinit_mt", 
    dynlib: libgmp, cdecl.}
proc gmp_randinit_set*(a2: gmp_randstate_t; a3: ptr mm_gmp_randstate_struct) {.
    importc: "__gmp_randinit_set", dynlib: libgmp, cdecl.}
proc gmp_randseed*(a2: gmp_randstate_t; a3: mpz_srcptr) {.
    importc: "__gmp_randseed", dynlib: libgmp, cdecl.}
proc gmp_randseed*(a2: gmp_randstate_t; a3: mpz_t) {.importc: "__gmp_randseed", 
    dynlib: libgmp, cdecl.}
proc gmp_randseed_ui*(a2: gmp_randstate_t; a3: culong) {.
    importc: "__gmp_randseed_ui", dynlib: libgmp, cdecl.}
proc gmp_randclear*(a2: gmp_randstate_t) {.importc: "__gmp_randclear", 
    dynlib: libgmp, cdecl.}
proc gmp_urandomb_ui*(a2: gmp_randstate_t; a3: culong): culong {.
    importc: "__gmp_urandomb_ui", dynlib: libgmp, cdecl.}
proc gmp_urandomm_ui*(a2: gmp_randstate_t; a3: culong): culong {.
    importc: "__gmp_urandomm_ui", dynlib: libgmp, cdecl.}
proc gmp_asprintf*(a2: cstringArray; a3: cstring): cint {.varargs, 
    importc: "__gmp_asprintf", dynlib: libgmp, cdecl.}
proc gmp_fprintf*(a2: File; a3: cstring): cint {.varargs, 
    importc: "__gmp_fprintf", dynlib: libgmp, cdecl.}
proc gmp_printf*(a2: cstring): cint {.varargs, importc: "__gmp_printf", 
                                      dynlib: libgmp, cdecl.}
proc gmp_snprintf*(a2: cstring; a3: csize; a4: cstring): cint {.varargs, 
    importc: "__gmp_snprintf", dynlib: libgmp, cdecl.}
proc gmp_sprintf*(a2: cstring; a3: cstring): cint {.varargs, 
    importc: "__gmp_sprintf", dynlib: libgmp, cdecl.}
proc gmp_fscanf*(a2: File; a3: cstring): cint {.varargs, 
    importc: "__gmp_fscanf", dynlib: libgmp, cdecl.}
proc gmp_scanf*(a2: cstring): cint {.varargs, importc: "__gmp_scanf", 
                                     dynlib: libgmp, cdecl.}
proc gmp_sscanf*(a2: cstring; a3: cstring): cint {.varargs, 
    importc: "__gmp_sscanf", dynlib: libgmp, cdecl.}
proc mpz_realloc*(a2: mpz_ptr; a3: mp_size_t): pointer {.
    importc: "__gmpz_realloc", dynlib: libgmp, cdecl.}
proc mpz_realloc*(a2: var mpz_t; a3: mp_size_t): pointer {.
    importc: "__gmpz_realloc", dynlib: libgmp, cdecl.}
proc mpz_add*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "__gmpz_add", dynlib: libgmp, cdecl.}
proc mpz_add*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "__gmpz_add", 
    dynlib: libgmp, cdecl.}
proc mpz_add_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.
    importc: "__gmpz_add_ui", dynlib: libgmp, cdecl.}
proc mpz_add_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.
    importc: "__gmpz_add_ui", dynlib: libgmp, cdecl.}
proc mpz_addmul*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "__gmpz_addmul", dynlib: libgmp, cdecl.}
proc mpz_addmul*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.
    importc: "__gmpz_addmul", dynlib: libgmp, cdecl.}
proc mpz_addmul_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.
    importc: "__gmpz_addmul_ui", dynlib: libgmp, cdecl.}
proc mpz_addmul_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.
    importc: "__gmpz_addmul_ui", dynlib: libgmp, cdecl.}
proc mpz_and*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "__gmpz_and", dynlib: libgmp, cdecl.}
proc mpz_and*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "__gmpz_and", 
    dynlib: libgmp, cdecl.}
proc mpz_array_init*(a2: mpz_ptr; a3: mp_size_t; a4: mp_size_t) {.
    importc: "__gmpz_array_init", dynlib: libgmp, cdecl.}
proc mpz_array_init*(a2: var mpz_t; a3: mp_size_t; a4: mp_size_t) {.
    importc: "__gmpz_array_init", dynlib: libgmp, cdecl.}
proc mpz_bin_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.
    importc: "__gmpz_bin_ui", dynlib: libgmp, cdecl.}
proc mpz_bin_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.
    importc: "__gmpz_bin_ui", dynlib: libgmp, cdecl.}
proc mpz_bin_uiui*(a2: mpz_ptr; a3: culong; a4: culong) {.
    importc: "__gmpz_bin_uiui", dynlib: libgmp, cdecl.}
proc mpz_bin_uiui*(a2: var mpz_t; a3: culong; a4: culong) {.
    importc: "__gmpz_bin_uiui", dynlib: libgmp, cdecl.}
proc mpz_cdiv_q*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "__gmpz_cdiv_q", dynlib: libgmp, cdecl.}
proc mpz_cdiv_q*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.
    importc: "__gmpz_cdiv_q", dynlib: libgmp, cdecl.}
proc mpz_cdiv_q_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.
    importc: "__gmpz_cdiv_q_2exp", dynlib: libgmp, cdecl.}
proc mpz_cdiv_q_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.
    importc: "__gmpz_cdiv_q_2exp", dynlib: libgmp, cdecl.}
proc mpz_cdiv_q_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.
    importc: "__gmpz_cdiv_q_ui", dynlib: libgmp, cdecl.}
proc mpz_cdiv_q_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.
    importc: "__gmpz_cdiv_q_ui", dynlib: libgmp, cdecl.}
proc mpz_cdiv_qr*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: mpz_srcptr) {.
    importc: "__gmpz_cdiv_qr", dynlib: libgmp, cdecl.}
proc mpz_cdiv_qr*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: mpz_t) {.
    importc: "__gmpz_cdiv_qr", dynlib: libgmp, cdecl.}
proc mpz_cdiv_qr_ui*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: culong): culong {.
    importc: "__gmpz_cdiv_qr_ui", dynlib: libgmp, cdecl.}
proc mpz_cdiv_qr_ui*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: culong): culong {.
    importc: "__gmpz_cdiv_qr_ui", dynlib: libgmp, cdecl.}
proc mpz_cdiv_r*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "__gmpz_cdiv_r", dynlib: libgmp, cdecl.}
proc mpz_cdiv_r*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.
    importc: "__gmpz_cdiv_r", dynlib: libgmp, cdecl.}
proc mpz_cdiv_r_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.
    importc: "__gmpz_cdiv_r_2exp", dynlib: libgmp, cdecl.}
proc mpz_cdiv_r_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.
    importc: "__gmpz_cdiv_r_2exp", dynlib: libgmp, cdecl.}
proc mpz_cdiv_r_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.
    importc: "__gmpz_cdiv_r_ui", dynlib: libgmp, cdecl.}
proc mpz_cdiv_r_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.
    importc: "__gmpz_cdiv_r_ui", dynlib: libgmp, cdecl.}
proc mpz_cdiv_ui*(a2: mpz_srcptr; a3: culong): culong {.
    importc: "__gmpz_cdiv_ui", dynlib: libgmp, cdecl.}
proc mpz_cdiv_ui*(a2: mpz_t; a3: culong): culong {.importc: "__gmpz_cdiv_ui", 
    dynlib: libgmp, cdecl.}
proc mpz_clear*(a2: mpz_ptr) {.importc: "__gmpz_clear", dynlib: libgmp, cdecl.}
proc mpz_clear*(a2: var mpz_t) {.importc: "__gmpz_clear", dynlib: libgmp, cdecl.}
proc mpz_clears*(a2: mpz_ptr) {.varargs, importc: "__gmpz_clears", 
                                dynlib: libgmp, cdecl.}
proc mpz_clears*(a2: var mpz_t) {.varargs, importc: "__gmpz_clears", 
                                  dynlib: libgmp, cdecl.}
proc mpz_clrbit*(a2: mpz_ptr; a3: mp_bitcnt_t) {.importc: "__gmpz_clrbit", 
    dynlib: libgmp, cdecl.}
proc mpz_clrbit*(a2: var mpz_t; a3: mp_bitcnt_t) {.importc: "__gmpz_clrbit", 
    dynlib: libgmp, cdecl.}
proc mpz_cmp*(a2: mpz_srcptr; a3: mpz_srcptr): cint {.importc: "__gmpz_cmp", 
    dynlib: libgmp, cdecl.}
proc mpz_cmp*(a2: mpz_t; a3: mpz_t): cint {.importc: "__gmpz_cmp", 
    dynlib: libgmp, cdecl.}
proc mpz_cmp_d*(a2: mpz_srcptr; a3: cdouble): cint {.importc: "__gmpz_cmp_d", 
    dynlib: libgmp, cdecl.}
proc mpz_cmp_d*(a2: mpz_t; a3: cdouble): cint {.importc: "__gmpz_cmp_d", 
    dynlib: libgmp, cdecl.}
proc mpz_cmp_si*(a2: mpz_srcptr; a3: clong): cint {.importc: "__gmpz_cmp_si", 
    dynlib: libgmp, cdecl.}
proc mpz_cmp_si*(a2: mpz_t; a3: clong): cint {.importc: "__gmpz_cmp_si", 
    dynlib: libgmp, cdecl.}
proc mpz_cmp_ui*(a2: mpz_srcptr; a3: culong): cint {.importc: "__gmpz_cmp_ui", 
    dynlib: libgmp, cdecl.}
proc mpz_cmp_ui*(a2: mpz_t; a3: culong): cint {.importc: "__gmpz_cmp_ui", 
    dynlib: libgmp, cdecl.}
proc mpz_cmpabs*(a2: mpz_srcptr; a3: mpz_srcptr): cint {.
    importc: "__gmpz_cmpabs", dynlib: libgmp, cdecl.}
proc mpz_cmpabs*(a2: mpz_t; a3: mpz_t): cint {.importc: "__gmpz_cmpabs", 
    dynlib: libgmp, cdecl.}
proc mpz_cmpabs_d*(a2: mpz_srcptr; a3: cdouble): cint {.
    importc: "__gmpz_cmpabs_d", dynlib: libgmp, cdecl.}
proc mpz_cmpabs_d*(a2: mpz_t; a3: cdouble): cint {.importc: "__gmpz_cmpabs_d", 
    dynlib: libgmp, cdecl.}
proc mpz_cmpabs_ui*(a2: mpz_srcptr; a3: culong): cint {.
    importc: "__gmpz_cmpabs_ui", dynlib: libgmp, cdecl.}
proc mpz_cmpabs_ui*(a2: mpz_t; a3: culong): cint {.importc: "__gmpz_cmpabs_ui", 
    dynlib: libgmp, cdecl.}
proc mpz_com*(a2: mpz_ptr; a3: mpz_srcptr) {.importc: "__gmpz_com", 
    dynlib: libgmp, cdecl.}
proc mpz_com*(a2: var mpz_t; a3: mpz_t) {.importc: "__gmpz_com", dynlib: libgmp, 
    cdecl.}
proc mpz_combit*(a2: mpz_ptr; a3: mp_bitcnt_t) {.importc: "__gmpz_combit", 
    dynlib: libgmp, cdecl.}
proc mpz_combit*(a2: var mpz_t; a3: mp_bitcnt_t) {.importc: "__gmpz_combit", 
    dynlib: libgmp, cdecl.}
proc mpz_congruent_p*(a2: mpz_srcptr; a3: mpz_srcptr; a4: mpz_srcptr): cint {.
    importc: "__gmpz_congruent_p", dynlib: libgmp, cdecl.}
proc mpz_congruent_p*(a2: mpz_t; a3: mpz_t; a4: mpz_t): cint {.
    importc: "__gmpz_congruent_p", dynlib: libgmp, cdecl.}
proc mpz_congruent_2exp_p*(a2: mpz_srcptr; a3: mpz_srcptr; a4: mp_bitcnt_t): cint {.
    importc: "__gmpz_congruent_2exp_p", dynlib: libgmp, cdecl.}
proc mpz_congruent_2exp_p*(a2: mpz_t; a3: mpz_t; a4: mp_bitcnt_t): cint {.
    importc: "__gmpz_congruent_2exp_p", dynlib: libgmp, cdecl.}
proc mpz_congruent_ui_p*(a2: mpz_srcptr; a3: culong; a4: culong): cint {.
    importc: "__gmpz_congruent_ui_p", dynlib: libgmp, cdecl.}
proc mpz_congruent_ui_p*(a2: mpz_t; a3: culong; a4: culong): cint {.
    importc: "__gmpz_congruent_ui_p", dynlib: libgmp, cdecl.}
proc mpz_divexact*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "__gmpz_divexact", dynlib: libgmp, cdecl.}
proc mpz_divexact*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.
    importc: "__gmpz_divexact", dynlib: libgmp, cdecl.}
proc mpz_divexact_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.
    importc: "__gmpz_divexact_ui", dynlib: libgmp, cdecl.}
proc mpz_divexact_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.
    importc: "__gmpz_divexact_ui", dynlib: libgmp, cdecl.}
proc mpz_divisible_p*(a2: mpz_srcptr; a3: mpz_srcptr): cint {.
    importc: "__gmpz_divisible_p", dynlib: libgmp, cdecl.}
proc mpz_divisible_p*(a2: mpz_t; a3: mpz_t): cint {.
    importc: "__gmpz_divisible_p", dynlib: libgmp, cdecl.}
proc mpz_divisible_ui_p*(a2: mpz_srcptr; a3: culong): cint {.
    importc: "__gmpz_divisible_ui_p", dynlib: libgmp, cdecl.}
proc mpz_divisible_ui_p*(a2: mpz_t; a3: culong): cint {.
    importc: "__gmpz_divisible_ui_p", dynlib: libgmp, cdecl.}
proc mpz_divisible_2exp_p*(a2: mpz_srcptr; a3: mp_bitcnt_t): cint {.
    importc: "__gmpz_divisible_2exp_p", dynlib: libgmp, cdecl.}
proc mpz_divisible_2exp_p*(a2: mpz_t; a3: mp_bitcnt_t): cint {.
    importc: "__gmpz_divisible_2exp_p", dynlib: libgmp, cdecl.}
proc mpz_dump*(a2: mpz_srcptr) {.importc: "__gmpz_dump", dynlib: libgmp, cdecl.}
proc mpz_dump*(a2: mpz_t) {.importc: "__gmpz_dump", dynlib: libgmp, cdecl.}
proc mpz_export*(a2: pointer; a3: ptr csize; a4: cint; a5: csize; a6: cint; 
                 a7: csize; a8: mpz_srcptr): pointer {.importc: "__gmpz_export", 
    dynlib: libgmp, cdecl.}
proc mpz_export*(a2: pointer; a3: ptr csize; a4: cint; a5: csize; a6: cint; 
                 a7: csize; a8: mpz_t): pointer {.importc: "__gmpz_export", 
    dynlib: libgmp, cdecl.}
proc mpz_fac_ui*(a2: mpz_ptr; a3: culong) {.importc: "__gmpz_fac_ui", 
    dynlib: libgmp, cdecl.}
proc mpz_fac_ui*(a2: var mpz_t; a3: culong) {.importc: "__gmpz_fac_ui", 
    dynlib: libgmp, cdecl.}
proc mpz_2fac_ui*(a2: mpz_ptr; a3: culong) {.importc: "__gmpz_2fac_ui", 
    dynlib: libgmp, cdecl.}
proc mpz_2fac_ui*(a2: var mpz_t; a3: culong) {.importc: "__gmpz_2fac_ui", 
    dynlib: libgmp, cdecl.}
proc mpz_mfac_uiui*(a2: mpz_ptr; a3: culong; a4: culong) {.
    importc: "__gmpz_mfac_uiui", dynlib: libgmp, cdecl.}
proc mpz_mfac_uiui*(a2: var mpz_t; a3: culong; a4: culong) {.
    importc: "__gmpz_mfac_uiui", dynlib: libgmp, cdecl.}
proc mpz_primorial_ui*(a2: mpz_ptr; a3: culong) {.
    importc: "__gmpz_primorial_ui", dynlib: libgmp, cdecl.}
proc mpz_primorial_ui*(a2: var mpz_t; a3: culong) {.
    importc: "__gmpz_primorial_ui", dynlib: libgmp, cdecl.}
proc mpz_fdiv_q*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "__gmpz_fdiv_q", dynlib: libgmp, cdecl.}
proc mpz_fdiv_q*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.
    importc: "__gmpz_fdiv_q", dynlib: libgmp, cdecl.}
proc mpz_fdiv_q_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.
    importc: "__gmpz_fdiv_q_2exp", dynlib: libgmp, cdecl.}
proc mpz_fdiv_q_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.
    importc: "__gmpz_fdiv_q_2exp", dynlib: libgmp, cdecl.}
proc mpz_fdiv_q_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.
    importc: "__gmpz_fdiv_q_ui", dynlib: libgmp, cdecl.}
proc mpz_fdiv_q_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.
    importc: "__gmpz_fdiv_q_ui", dynlib: libgmp, cdecl.}
proc mpz_fdiv_qr*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: mpz_srcptr) {.
    importc: "__gmpz_fdiv_qr", dynlib: libgmp, cdecl.}
proc mpz_fdiv_qr*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: mpz_t) {.
    importc: "__gmpz_fdiv_qr", dynlib: libgmp, cdecl.}
proc mpz_fdiv_qr_ui*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: culong): culong {.
    importc: "__gmpz_fdiv_qr_ui", dynlib: libgmp, cdecl.}
proc mpz_fdiv_qr_ui*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: culong): culong {.
    importc: "__gmpz_fdiv_qr_ui", dynlib: libgmp, cdecl.}
proc mpz_fdiv_r*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "__gmpz_fdiv_r", dynlib: libgmp, cdecl.}
proc mpz_fdiv_r*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.
    importc: "__gmpz_fdiv_r", dynlib: libgmp, cdecl.}
proc mpz_fdiv_r_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.
    importc: "__gmpz_fdiv_r_2exp", dynlib: libgmp, cdecl.}
proc mpz_fdiv_r_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.
    importc: "__gmpz_fdiv_r_2exp", dynlib: libgmp, cdecl.}
proc mpz_fdiv_r_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.
    importc: "__gmpz_fdiv_r_ui", dynlib: libgmp, cdecl.}
proc mpz_fdiv_r_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.
    importc: "__gmpz_fdiv_r_ui", dynlib: libgmp, cdecl.}
proc mpz_fdiv_ui*(a2: mpz_srcptr; a3: culong): culong {.
    importc: "__gmpz_fdiv_ui", dynlib: libgmp, cdecl.}
proc mpz_fdiv_ui*(a2: mpz_t; a3: culong): culong {.importc: "__gmpz_fdiv_ui", 
    dynlib: libgmp, cdecl.}
proc mpz_fib_ui*(a2: mpz_ptr; a3: culong) {.importc: "__gmpz_fib_ui", 
    dynlib: libgmp, cdecl.}
proc mpz_fib_ui*(a2: var mpz_t; a3: culong) {.importc: "__gmpz_fib_ui", 
    dynlib: libgmp, cdecl.}
proc mpz_fib2_ui*(a2: mpz_ptr; a3: mpz_ptr; a4: culong) {.
    importc: "__gmpz_fib2_ui", dynlib: libgmp, cdecl.}
proc mpz_fib2_ui*(a2: var mpz_t; a3: var mpz_t; a4: culong) {.
    importc: "__gmpz_fib2_ui", dynlib: libgmp, cdecl.}
proc mpz_fits_sint_p*(a2: mpz_srcptr): cint {.importc: "__gmpz_fits_sint_p", 
    dynlib: libgmp, cdecl.}
proc mpz_fits_sint_p*(a2: mpz_t): cint {.importc: "__gmpz_fits_sint_p", 
    dynlib: libgmp, cdecl.}
proc mpz_fits_slong_p*(a2: mpz_srcptr): cint {.importc: "__gmpz_fits_slong_p", 
    dynlib: libgmp, cdecl.}
proc mpz_fits_slong_p*(a2: mpz_t): cint {.importc: "__gmpz_fits_slong_p", 
    dynlib: libgmp, cdecl.}
proc mpz_fits_sshort_p*(a2: mpz_srcptr): cint {.importc: "__gmpz_fits_sshort_p", 
    dynlib: libgmp, cdecl.}
proc mpz_fits_sshort_p*(a2: mpz_t): cint {.importc: "__gmpz_fits_sshort_p", 
    dynlib: libgmp, cdecl.}
proc mpz_gcd*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "__gmpz_gcd", dynlib: libgmp, cdecl.}
proc mpz_gcd*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "__gmpz_gcd", 
    dynlib: libgmp, cdecl.}
proc mpz_gcd_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.
    importc: "__gmpz_gcd_ui", dynlib: libgmp, cdecl.}
proc mpz_gcd_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.
    importc: "__gmpz_gcd_ui", dynlib: libgmp, cdecl.}
proc mpz_gcdext*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_ptr; a5: mpz_srcptr; 
                 a6: mpz_srcptr) {.importc: "__gmpz_gcdext", dynlib: libgmp, 
                                   cdecl.}
proc mpz_gcdext*(a2: var mpz_t; a3: var mpz_t; a4: var mpz_t; a5: mpz_t; 
                 a6: mpz_t) {.importc: "__gmpz_gcdext", dynlib: libgmp, cdecl.}
proc mpz_get_d*(a2: mpz_srcptr): cdouble {.importc: "__gmpz_get_d", 
    dynlib: libgmp, cdecl.}
proc mpz_get_d*(a2: mpz_t): cdouble {.importc: "__gmpz_get_d", dynlib: libgmp, 
                                      cdecl.}
proc mpz_get_d_2exp*(a2: ptr clong; a3: mpz_srcptr): cdouble {.
    importc: "__gmpz_get_d_2exp", dynlib: libgmp, cdecl.}
proc mpz_get_d_2exp*(a2: ptr clong; a3: mpz_t): cdouble {.
    importc: "__gmpz_get_d_2exp", dynlib: libgmp, cdecl.}
proc mpz_get_si*(a2: mpz_srcptr): clong {.importc: "__gmpz_get_si", 
    dynlib: libgmp, cdecl.}
proc mpz_get_si*(a2: mpz_t): clong {.importc: "__gmpz_get_si", dynlib: libgmp, 
                                     cdecl.}
proc mpz_get_str*(a2: cstring; a3: cint; a4: mpz_srcptr): cstring {.
    importc: "__gmpz_get_str", dynlib: libgmp, cdecl.}
proc mpz_get_str*(a2: cstring; a3: cint; a4: mpz_t): cstring {.
    importc: "__gmpz_get_str", dynlib: libgmp, cdecl.}
proc mpz_hamdist*(a2: mpz_srcptr; a3: mpz_srcptr): mp_bitcnt_t {.
    importc: "__gmpz_hamdist", dynlib: libgmp, cdecl.}
proc mpz_hamdist*(a2: mpz_t; a3: mpz_t): mp_bitcnt_t {.
    importc: "__gmpz_hamdist", dynlib: libgmp, cdecl.}
proc mpz_import*(a2: mpz_ptr; a3: csize; a4: cint; a5: csize; a6: cint; 
                 a7: csize; a8: pointer) {.importc: "__gmpz_import", 
    dynlib: libgmp, cdecl.}
proc mpz_import*(a2: var mpz_t; a3: csize; a4: cint; a5: csize; a6: cint; 
                 a7: csize; a8: pointer) {.importc: "__gmpz_import", 
    dynlib: libgmp, cdecl.}
proc mpz_init*(a2: mpz_ptr) {.importc: "__gmpz_init", dynlib: libgmp, cdecl.}
proc mpz_init*(a2: var mpz_t) {.importc: "__gmpz_init", dynlib: libgmp, cdecl.}
proc mpz_init2*(a2: mpz_ptr; a3: mp_bitcnt_t) {.importc: "__gmpz_init2", 
    dynlib: libgmp, cdecl.}
proc mpz_init2*(a2: var mpz_t; a3: mp_bitcnt_t) {.importc: "__gmpz_init2", 
    dynlib: libgmp, cdecl.}
proc mpz_inits*(a2: mpz_ptr) {.varargs, importc: "__gmpz_inits", dynlib: libgmp, 
                               cdecl.}
proc mpz_inits*(a2: var mpz_t) {.varargs, importc: "__gmpz_inits", 
                                 dynlib: libgmp, cdecl.}
proc mpz_init_set*(a2: mpz_ptr; a3: mpz_srcptr) {.importc: "__gmpz_init_set", 
    dynlib: libgmp, cdecl.}
proc mpz_init_set*(a2: var mpz_t; a3: mpz_t) {.importc: "__gmpz_init_set", 
    dynlib: libgmp, cdecl.}
proc mpz_init_set_d*(a2: mpz_ptr; a3: cdouble) {.importc: "__gmpz_init_set_d", 
    dynlib: libgmp, cdecl.}
proc mpz_init_set_d*(a2: var mpz_t; a3: cdouble) {.importc: "__gmpz_init_set_d", 
    dynlib: libgmp, cdecl.}
proc mpz_init_set_si*(a2: mpz_ptr; a3: clong) {.importc: "__gmpz_init_set_si", 
    dynlib: libgmp, cdecl.}
proc mpz_init_set_si*(a2: var mpz_t; a3: clong) {.importc: "__gmpz_init_set_si", 
    dynlib: libgmp, cdecl.}
proc mpz_init_set_str*(a2: mpz_ptr; a3: cstring; a4: cint): cint {.
    importc: "__gmpz_init_set_str", dynlib: libgmp, cdecl.}
proc mpz_init_set_str*(a2: var mpz_t; a3: cstring; a4: cint): cint {.
    importc: "__gmpz_init_set_str", dynlib: libgmp, cdecl.}
proc mpz_init_set_ui*(a2: mpz_ptr; a3: culong) {.importc: "__gmpz_init_set_ui", 
    dynlib: libgmp, cdecl.}
proc mpz_init_set_ui*(a2: var mpz_t; a3: culong) {.
    importc: "__gmpz_init_set_ui", dynlib: libgmp, cdecl.}
proc mpz_inp_raw*(a2: mpz_ptr; a3: File): csize {.importc: "__gmpz_inp_raw", 
    dynlib: libgmp, cdecl.}
proc mpz_inp_raw*(a2: var mpz_t; a3: File): csize {.
    importc: "__gmpz_inp_raw", dynlib: libgmp, cdecl.}
proc mpz_inp_str*(a2: mpz_ptr; a3: File; a4: cint): csize {.
    importc: "__gmpz_inp_str", dynlib: libgmp, cdecl.}
proc mpz_inp_str*(a2: var mpz_t; a3: File; a4: cint): csize {.
    importc: "__gmpz_inp_str", dynlib: libgmp, cdecl.}
proc mpz_invert*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr): cint {.
    importc: "__gmpz_invert", dynlib: libgmp, cdecl.}
proc mpz_invert*(a2: var mpz_t; a3: mpz_t; a4: mpz_t): cint {.
    importc: "__gmpz_invert", dynlib: libgmp, cdecl.}
proc mpz_ior*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "__gmpz_ior", dynlib: libgmp, cdecl.}
proc mpz_ior*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "__gmpz_ior", 
    dynlib: libgmp, cdecl.}
proc mpz_jacobi*(a2: mpz_srcptr; a3: mpz_srcptr): cint {.
    importc: "__gmpz_jacobi", dynlib: libgmp, cdecl.}
proc mpz_jacobi*(a2: mpz_t; a3: mpz_t): cint {.importc: "__gmpz_jacobi", 
    dynlib: libgmp, cdecl.}
proc mpz_kronecker_si*(a2: mpz_srcptr; a3: clong): cint {.
    importc: "__gmpz_kronecker_si", dynlib: libgmp, cdecl.}
proc mpz_kronecker_si*(a2: mpz_t; a3: clong): cint {.
    importc: "__gmpz_kronecker_si", dynlib: libgmp, cdecl.}
proc mpz_kronecker_ui*(a2: mpz_srcptr; a3: culong): cint {.
    importc: "__gmpz_kronecker_ui", dynlib: libgmp, cdecl.}
proc mpz_kronecker_ui*(a2: mpz_t; a3: culong): cint {.
    importc: "__gmpz_kronecker_ui", dynlib: libgmp, cdecl.}
proc mpz_si_kronecker*(a2: clong; a3: mpz_srcptr): cint {.
    importc: "__gmpz_si_kronecker", dynlib: libgmp, cdecl.}
proc mpz_si_kronecker*(a2: clong; a3: mpz_t): cint {.
    importc: "__gmpz_si_kronecker", dynlib: libgmp, cdecl.}
proc mpz_ui_kronecker*(a2: culong; a3: mpz_srcptr): cint {.
    importc: "__gmpz_ui_kronecker", dynlib: libgmp, cdecl.}
proc mpz_ui_kronecker*(a2: culong; a3: mpz_t): cint {.
    importc: "__gmpz_ui_kronecker", dynlib: libgmp, cdecl.}
proc mpz_lcm*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "__gmpz_lcm", dynlib: libgmp, cdecl.}
proc mpz_lcm*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "__gmpz_lcm", 
    dynlib: libgmp, cdecl.}
proc mpz_lcm_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.
    importc: "__gmpz_lcm_ui", dynlib: libgmp, cdecl.}
proc mpz_lcm_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.
    importc: "__gmpz_lcm_ui", dynlib: libgmp, cdecl.}
proc mpz_lucnum_ui*(a2: mpz_ptr; a3: culong) {.importc: "__gmpz_lucnum_ui", 
    dynlib: libgmp, cdecl.}
proc mpz_lucnum_ui*(a2: var mpz_t; a3: culong) {.importc: "__gmpz_lucnum_ui", 
    dynlib: libgmp, cdecl.}
proc mpz_lucnum2_ui*(a2: mpz_ptr; a3: mpz_ptr; a4: culong) {.
    importc: "__gmpz_lucnum2_ui", dynlib: libgmp, cdecl.}
proc mpz_lucnum2_ui*(a2: var mpz_t; a3: var mpz_t; a4: culong) {.
    importc: "__gmpz_lucnum2_ui", dynlib: libgmp, cdecl.}
proc mpz_millerrabin*(a2: mpz_srcptr; a3: cint): cint {.
    importc: "__gmpz_millerrabin", dynlib: libgmp, cdecl.}
proc mpz_millerrabin*(a2: mpz_t; a3: cint): cint {.
    importc: "__gmpz_millerrabin", dynlib: libgmp, cdecl.}
proc mpz_mod*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "__gmpz_mod", dynlib: libgmp, cdecl.}
proc mpz_mod*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "__gmpz_mod", 
    dynlib: libgmp, cdecl.}
proc mpz_mul*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "__gmpz_mul", dynlib: libgmp, cdecl.}
proc mpz_mul*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "__gmpz_mul", 
    dynlib: libgmp, cdecl.}
proc mpz_mul_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.
    importc: "__gmpz_mul_2exp", dynlib: libgmp, cdecl.}
proc mpz_mul_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.
    importc: "__gmpz_mul_2exp", dynlib: libgmp, cdecl.}
proc mpz_mul_si*(a2: mpz_ptr; a3: mpz_srcptr; a4: clong) {.
    importc: "__gmpz_mul_si", dynlib: libgmp, cdecl.}
proc mpz_mul_si*(a2: var mpz_t; a3: mpz_t; a4: clong) {.
    importc: "__gmpz_mul_si", dynlib: libgmp, cdecl.}
proc mpz_mul_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.
    importc: "__gmpz_mul_ui", dynlib: libgmp, cdecl.}
proc mpz_mul_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.
    importc: "__gmpz_mul_ui", dynlib: libgmp, cdecl.}
proc mpz_nextprime*(a2: mpz_ptr; a3: mpz_srcptr) {.importc: "__gmpz_nextprime", 
    dynlib: libgmp, cdecl.}
proc mpz_nextprime*(a2: var mpz_t; a3: mpz_t) {.importc: "__gmpz_nextprime", 
    dynlib: libgmp, cdecl.}
proc mpz_out_raw*(a2: File; a3: mpz_srcptr): csize {.
    importc: "__gmpz_out_raw", dynlib: libgmp, cdecl.}
proc mpz_out_raw*(a2: File; a3: mpz_t): csize {.importc: "__gmpz_out_raw", 
    dynlib: libgmp, cdecl.}
proc mpz_out_str*(a2: File; a3: cint; a4: mpz_srcptr): csize {.
    importc: "__gmpz_out_str", dynlib: libgmp, cdecl.}
proc mpz_out_str*(a2: File; a3: cint; a4: mpz_t): csize {.
    importc: "__gmpz_out_str", dynlib: libgmp, cdecl.}
proc mpz_perfect_power_p*(a2: mpz_srcptr): cint {.
    importc: "__gmpz_perfect_power_p", dynlib: libgmp, cdecl.}
proc mpz_perfect_power_p*(a2: mpz_t): cint {.importc: "__gmpz_perfect_power_p", 
    dynlib: libgmp, cdecl.}
proc mpz_pow_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.
    importc: "__gmpz_pow_ui", dynlib: libgmp, cdecl.}
proc mpz_pow_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.
    importc: "__gmpz_pow_ui", dynlib: libgmp, cdecl.}
proc mpz_powm*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr; a5: mpz_srcptr) {.
    importc: "__gmpz_powm", dynlib: libgmp, cdecl.}
proc mpz_powm*(a2: var mpz_t; a3: mpz_t; a4: mpz_t; a5: mpz_t) {.
    importc: "__gmpz_powm", dynlib: libgmp, cdecl.}
proc mpz_powm_sec*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr; a5: mpz_srcptr) {.
    importc: "__gmpz_powm_sec", dynlib: libgmp, cdecl.}
proc mpz_powm_sec*(a2: var mpz_t; a3: mpz_t; a4: mpz_t; a5: mpz_t) {.
    importc: "__gmpz_powm_sec", dynlib: libgmp, cdecl.}
proc mpz_powm_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong; a5: mpz_srcptr) {.
    importc: "__gmpz_powm_ui", dynlib: libgmp, cdecl.}
proc mpz_powm_ui*(a2: var mpz_t; a3: mpz_t; a4: culong; a5: mpz_t) {.
    importc: "__gmpz_powm_ui", dynlib: libgmp, cdecl.}
proc mpz_probab_prime_p*(a2: mpz_srcptr; a3: cint): cint {.
    importc: "__gmpz_probab_prime_p", dynlib: libgmp, cdecl.}
proc mpz_probab_prime_p*(a2: mpz_t; a3: cint): cint {.
    importc: "__gmpz_probab_prime_p", dynlib: libgmp, cdecl.}
proc mpz_random*(a2: mpz_ptr; a3: mp_size_t) {.importc: "__gmpz_random", 
    dynlib: libgmp, cdecl.}
proc mpz_random*(a2: var mpz_t; a3: mp_size_t) {.importc: "__gmpz_random", 
    dynlib: libgmp, cdecl.}
proc mpz_random2*(a2: mpz_ptr; a3: mp_size_t) {.importc: "__gmpz_random2", 
    dynlib: libgmp, cdecl.}
proc mpz_random2*(a2: var mpz_t; a3: mp_size_t) {.importc: "__gmpz_random2", 
    dynlib: libgmp, cdecl.}
proc mpz_realloc2*(a2: mpz_ptr; a3: mp_bitcnt_t) {.importc: "__gmpz_realloc2", 
    dynlib: libgmp, cdecl.}
proc mpz_realloc2*(a2: var mpz_t; a3: mp_bitcnt_t) {.importc: "__gmpz_realloc2", 
    dynlib: libgmp, cdecl.}
proc mpz_remove*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr): mp_bitcnt_t {.
    importc: "__gmpz_remove", dynlib: libgmp, cdecl.}
proc mpz_remove*(a2: var mpz_t; a3: mpz_t; a4: mpz_t): mp_bitcnt_t {.
    importc: "__gmpz_remove", dynlib: libgmp, cdecl.}
proc mpz_root*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): cint {.
    importc: "__gmpz_root", dynlib: libgmp, cdecl.}
proc mpz_root*(a2: var mpz_t; a3: mpz_t; a4: culong): cint {.
    importc: "__gmpz_root", dynlib: libgmp, cdecl.}
proc mpz_rootrem*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: culong) {.
    importc: "__gmpz_rootrem", dynlib: libgmp, cdecl.}
proc mpz_rootrem*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: culong) {.
    importc: "__gmpz_rootrem", dynlib: libgmp, cdecl.}
proc mpz_rrandomb*(a2: mpz_ptr; a3: gmp_randstate_t; a4: mp_bitcnt_t) {.
    importc: "__gmpz_rrandomb", dynlib: libgmp, cdecl.}
proc mpz_rrandomb*(a2: var mpz_t; a3: gmp_randstate_t; a4: mp_bitcnt_t) {.
    importc: "__gmpz_rrandomb", dynlib: libgmp, cdecl.}
proc mpz_scan0*(a2: mpz_srcptr; a3: mp_bitcnt_t): mp_bitcnt_t {.
    importc: "__gmpz_scan0", dynlib: libgmp, cdecl.}
proc mpz_scan0*(a2: mpz_t; a3: mp_bitcnt_t): mp_bitcnt_t {.
    importc: "__gmpz_scan0", dynlib: libgmp, cdecl.}
proc mpz_scan1*(a2: mpz_srcptr; a3: mp_bitcnt_t): mp_bitcnt_t {.
    importc: "__gmpz_scan1", dynlib: libgmp, cdecl.}
proc mpz_scan1*(a2: mpz_t; a3: mp_bitcnt_t): mp_bitcnt_t {.
    importc: "__gmpz_scan1", dynlib: libgmp, cdecl.}
proc mpz_set*(a2: mpz_ptr; a3: mpz_srcptr) {.importc: "__gmpz_set", 
    dynlib: libgmp, cdecl.}
proc mpz_set*(a2: var mpz_t; a3: mpz_t) {.importc: "__gmpz_set", dynlib: libgmp, 
    cdecl.}
proc mpz_set_d*(a2: mpz_ptr; a3: cdouble) {.importc: "__gmpz_set_d", 
    dynlib: libgmp, cdecl.}
proc mpz_set_d*(a2: var mpz_t; a3: cdouble) {.importc: "__gmpz_set_d", 
    dynlib: libgmp, cdecl.}
proc mpz_set_f*(a2: mpz_ptr; a3: mpf_srcptr) {.importc: "__gmpz_set_f", 
    dynlib: libgmp, cdecl.}
proc mpz_set_f*(a2: var mpz_t; a3: mpf_t) {.importc: "__gmpz_set_f", 
    dynlib: libgmp, cdecl.}
proc mpz_set_si*(a2: mpz_ptr; a3: clong) {.importc: "__gmpz_set_si", 
    dynlib: libgmp, cdecl.}
proc mpz_set_si*(a2: var mpz_t; a3: clong) {.importc: "__gmpz_set_si", 
    dynlib: libgmp, cdecl.}
proc mpz_set_str*(a2: mpz_ptr; a3: cstring; a4: cint): cint {.
    importc: "__gmpz_set_str", dynlib: libgmp, cdecl.}
proc mpz_set_str*(a2: var mpz_t; a3: cstring; a4: cint): cint {.
    importc: "__gmpz_set_str", dynlib: libgmp, cdecl.}
proc mpz_set_ui*(a2: mpz_ptr; a3: culong) {.importc: "__gmpz_set_ui", 
    dynlib: libgmp, cdecl.}
proc mpz_set_ui*(a2: var mpz_t; a3: culong) {.importc: "__gmpz_set_ui", 
    dynlib: libgmp, cdecl.}
proc mpz_setbit*(a2: mpz_ptr; a3: mp_bitcnt_t) {.importc: "__gmpz_setbit", 
    dynlib: libgmp, cdecl.}
proc mpz_setbit*(a2: var mpz_t; a3: mp_bitcnt_t) {.importc: "__gmpz_setbit", 
    dynlib: libgmp, cdecl.}
proc mpz_sizeinbase*(a2: mpz_srcptr; a3: cint): csize {.
    importc: "__gmpz_sizeinbase", dynlib: libgmp, cdecl.}
proc mpz_sizeinbase*(a2: mpz_t; a3: cint): csize {.importc: "__gmpz_sizeinbase", 
    dynlib: libgmp, cdecl.}
proc mpz_sqrt*(a2: mpz_ptr; a3: mpz_srcptr) {.importc: "__gmpz_sqrt", 
    dynlib: libgmp, cdecl.}
proc mpz_sqrt*(a2: var mpz_t; a3: mpz_t) {.importc: "__gmpz_sqrt", 
    dynlib: libgmp, cdecl.}
proc mpz_sqrtrem*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr) {.
    importc: "__gmpz_sqrtrem", dynlib: libgmp, cdecl.}
proc mpz_sqrtrem*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t) {.
    importc: "__gmpz_sqrtrem", dynlib: libgmp, cdecl.}
proc mpz_sub*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "__gmpz_sub", dynlib: libgmp, cdecl.}
proc mpz_sub*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "__gmpz_sub", 
    dynlib: libgmp, cdecl.}
proc mpz_sub_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.
    importc: "__gmpz_sub_ui", dynlib: libgmp, cdecl.}
proc mpz_sub_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.
    importc: "__gmpz_sub_ui", dynlib: libgmp, cdecl.}
proc mpz_ui_sub*(a2: mpz_ptr; a3: culong; a4: mpz_srcptr) {.
    importc: "__gmpz_ui_sub", dynlib: libgmp, cdecl.}
proc mpz_ui_sub*(a2: var mpz_t; a3: culong; a4: mpz_t) {.
    importc: "__gmpz_ui_sub", dynlib: libgmp, cdecl.}
proc mpz_submul*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "__gmpz_submul", dynlib: libgmp, cdecl.}
proc mpz_submul*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.
    importc: "__gmpz_submul", dynlib: libgmp, cdecl.}
proc mpz_submul_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.
    importc: "__gmpz_submul_ui", dynlib: libgmp, cdecl.}
proc mpz_submul_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.
    importc: "__gmpz_submul_ui", dynlib: libgmp, cdecl.}
proc mpz_swap*(a2: mpz_ptr; a3: mpz_ptr) {.importc: "__gmpz_swap", 
    dynlib: libgmp, cdecl.}
proc mpz_swap*(a2: var mpz_t; a3: var mpz_t) {.importc: "__gmpz_swap", 
    dynlib: libgmp, cdecl.}
proc mpz_tdiv_ui*(a2: mpz_srcptr; a3: culong): culong {.
    importc: "__gmpz_tdiv_ui", dynlib: libgmp, cdecl.}
proc mpz_tdiv_ui*(a2: mpz_t; a3: culong): culong {.importc: "__gmpz_tdiv_ui", 
    dynlib: libgmp, cdecl.}
proc mpz_tdiv_q*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "__gmpz_tdiv_q", dynlib: libgmp, cdecl.}
proc mpz_tdiv_q*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.
    importc: "__gmpz_tdiv_q", dynlib: libgmp, cdecl.}
proc mpz_tdiv_q_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.
    importc: "__gmpz_tdiv_q_2exp", dynlib: libgmp, cdecl.}
proc mpz_tdiv_q_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.
    importc: "__gmpz_tdiv_q_2exp", dynlib: libgmp, cdecl.}
proc mpz_tdiv_q_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.
    importc: "__gmpz_tdiv_q_ui", dynlib: libgmp, cdecl.}
proc mpz_tdiv_q_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.
    importc: "__gmpz_tdiv_q_ui", dynlib: libgmp, cdecl.}
proc mpz_tdiv_qr*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: mpz_srcptr) {.
    importc: "__gmpz_tdiv_qr", dynlib: libgmp, cdecl.}
proc mpz_tdiv_qr*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: mpz_t) {.
    importc: "__gmpz_tdiv_qr", dynlib: libgmp, cdecl.}
proc mpz_tdiv_qr_ui*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: culong): culong {.
    importc: "__gmpz_tdiv_qr_ui", dynlib: libgmp, cdecl.}
proc mpz_tdiv_qr_ui*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: culong): culong {.
    importc: "__gmpz_tdiv_qr_ui", dynlib: libgmp, cdecl.}
proc mpz_tdiv_r*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "__gmpz_tdiv_r", dynlib: libgmp, cdecl.}
proc mpz_tdiv_r*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.
    importc: "__gmpz_tdiv_r", dynlib: libgmp, cdecl.}
proc mpz_tdiv_r_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.
    importc: "__gmpz_tdiv_r_2exp", dynlib: libgmp, cdecl.}
proc mpz_tdiv_r_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.
    importc: "__gmpz_tdiv_r_2exp", dynlib: libgmp, cdecl.}
proc mpz_tdiv_r_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.
    importc: "__gmpz_tdiv_r_ui", dynlib: libgmp, cdecl.}
proc mpz_tdiv_r_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.
    importc: "__gmpz_tdiv_r_ui", dynlib: libgmp, cdecl.}
proc mpz_tstbit*(a2: mpz_srcptr; a3: mp_bitcnt_t): cint {.
    importc: "__gmpz_tstbit", dynlib: libgmp, cdecl.}
proc mpz_tstbit*(a2: mpz_t; a3: mp_bitcnt_t): cint {.importc: "__gmpz_tstbit", 
    dynlib: libgmp, cdecl.}
proc mpz_ui_pow_ui*(a2: mpz_ptr; a3: culong; a4: culong) {.
    importc: "__gmpz_ui_pow_ui", dynlib: libgmp, cdecl.}
proc mpz_ui_pow_ui*(a2: var mpz_t; a3: culong; a4: culong) {.
    importc: "__gmpz_ui_pow_ui", dynlib: libgmp, cdecl.}
proc mpz_urandomb*(a2: mpz_ptr; a3: gmp_randstate_t; a4: mp_bitcnt_t) {.
    importc: "__gmpz_urandomb", dynlib: libgmp, cdecl.}
proc mpz_urandomb*(a2: var mpz_t; a3: gmp_randstate_t; a4: mp_bitcnt_t) {.
    importc: "__gmpz_urandomb", dynlib: libgmp, cdecl.}
proc mpz_urandomm*(a2: mpz_ptr; a3: gmp_randstate_t; a4: mpz_srcptr) {.
    importc: "__gmpz_urandomm", dynlib: libgmp, cdecl.}
proc mpz_urandomm*(a2: var mpz_t; a3: gmp_randstate_t; a4: mpz_t) {.
    importc: "__gmpz_urandomm", dynlib: libgmp, cdecl.}
proc mpz_xor*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "__gmpz_xor", dynlib: libgmp, cdecl.}
proc mpz_xor*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "__gmpz_xor", 
    dynlib: libgmp, cdecl.}
proc mpz_limbs_read*(a2: mpz_srcptr): mp_srcptr {.importc: "__gmpz_limbs_read", 
    dynlib: libgmp, cdecl.}
proc mpz_limbs_read*(a2: mpz_t): mp_srcptr {.importc: "__gmpz_limbs_read", 
    dynlib: libgmp, cdecl.}
proc mpz_limbs_write*(a2: mpz_ptr; a3: mp_size_t): mp_ptr {.
    importc: "__gmpz_limbs_write", dynlib: libgmp, cdecl.}
proc mpz_limbs_write*(a2: var mpz_t; a3: mp_size_t): mp_ptr {.
    importc: "__gmpz_limbs_write", dynlib: libgmp, cdecl.}
proc mpz_limbs_modify*(a2: mpz_ptr; a3: mp_size_t): mp_ptr {.
    importc: "__gmpz_limbs_modify", dynlib: libgmp, cdecl.}
proc mpz_limbs_modify*(a2: var mpz_t; a3: mp_size_t): mp_ptr {.
    importc: "__gmpz_limbs_modify", dynlib: libgmp, cdecl.}
proc mpz_limbs_finish*(a2: mpz_ptr; a3: mp_size_t) {.
    importc: "__gmpz_limbs_finish", dynlib: libgmp, cdecl.}
proc mpz_limbs_finish*(a2: var mpz_t; a3: mp_size_t) {.
    importc: "__gmpz_limbs_finish", dynlib: libgmp, cdecl.}
proc mpz_roinit_n*(a2: mpz_ptr; a3: mp_srcptr; a4: mp_size_t): mpz_srcptr {.
    importc: "__gmpz_roinit_n", dynlib: libgmp, cdecl.}
proc mpz_roinit_n*(a2: var mpz_t; a3: var mp_limb_t; a4: mp_size_t): mpz_srcptr {.
    importc: "__gmpz_roinit_n", dynlib: libgmp, cdecl.}
proc mpq_add*(a2: mpq_ptr; a3: mpq_srcptr; a4: mpq_srcptr) {.
    importc: "__gmpq_add", dynlib: libgmp, cdecl.}
proc mpq_add*(a2: var mpq_t; a3: mpq_t; a4: mpq_t) {.importc: "__gmpq_add", 
    dynlib: libgmp, cdecl.}
proc mpq_canonicalize*(a2: mpq_ptr) {.importc: "__gmpq_canonicalize", 
                                      dynlib: libgmp, cdecl.}
proc mpq_canonicalize*(a2: var mpq_t) {.importc: "__gmpq_canonicalize", 
                                        dynlib: libgmp, cdecl.}
proc mpq_clear*(a2: mpq_ptr) {.importc: "__gmpq_clear", dynlib: libgmp, cdecl.}
proc mpq_clear*(a2: var mpq_t) {.importc: "__gmpq_clear", dynlib: libgmp, cdecl.}
proc mpq_clears*(a2: mpq_ptr) {.varargs, importc: "__gmpq_clears", 
                                dynlib: libgmp, cdecl.}
proc mpq_clears*(a2: var mpq_t) {.varargs, importc: "__gmpq_clears", 
                                  dynlib: libgmp, cdecl.}
proc mpq_cmp*(a2: mpq_srcptr; a3: mpq_srcptr): cint {.importc: "__gmpq_cmp", 
    dynlib: libgmp, cdecl.}
proc mpq_cmp*(a2: mpq_t; a3: mpq_t): cint {.importc: "__gmpq_cmp", 
    dynlib: libgmp, cdecl.}
proc mpq_cmp_si*(a2: mpq_srcptr; a3: clong; a4: culong): cint {.
    importc: "__gmpq_cmp_si", dynlib: libgmp, cdecl.}
proc mpq_cmp_si*(a2: mpq_t; a3: clong; a4: culong): cint {.
    importc: "__gmpq_cmp_si", dynlib: libgmp, cdecl.}
proc mpq_cmp_ui*(a2: mpq_srcptr; a3: culong; a4: culong): cint {.
    importc: "__gmpq_cmp_ui", dynlib: libgmp, cdecl.}
proc mpq_cmp_ui*(a2: mpq_t; a3: culong; a4: culong): cint {.
    importc: "__gmpq_cmp_ui", dynlib: libgmp, cdecl.}
proc mpq_div*(a2: mpq_ptr; a3: mpq_srcptr; a4: mpq_srcptr) {.
    importc: "__gmpq_div", dynlib: libgmp, cdecl.}
proc mpq_div*(a2: var mpq_t; a3: mpq_t; a4: mpq_t) {.importc: "__gmpq_div", 
    dynlib: libgmp, cdecl.}
proc mpq_div_2exp*(a2: mpq_ptr; a3: mpq_srcptr; a4: mp_bitcnt_t) {.
    importc: "__gmpq_div_2exp", dynlib: libgmp, cdecl.}
proc mpq_div_2exp*(a2: var mpq_t; a3: mpq_t; a4: mp_bitcnt_t) {.
    importc: "__gmpq_div_2exp", dynlib: libgmp, cdecl.}
proc mpq_equal*(a2: mpq_srcptr; a3: mpq_srcptr): cint {.importc: "__gmpq_equal", 
    dynlib: libgmp, cdecl.}
proc mpq_equal*(a2: mpq_t; a3: mpq_t): cint {.importc: "__gmpq_equal", 
    dynlib: libgmp, cdecl.}
proc mpq_get_num*(a2: mpz_ptr; a3: mpq_srcptr) {.importc: "__gmpq_get_num", 
    dynlib: libgmp, cdecl.}
proc mpq_get_num*(a2: var mpz_t; a3: mpq_t) {.importc: "__gmpq_get_num", 
    dynlib: libgmp, cdecl.}
proc mpq_get_den*(a2: mpz_ptr; a3: mpq_srcptr) {.importc: "__gmpq_get_den", 
    dynlib: libgmp, cdecl.}
proc mpq_get_den*(a2: var mpz_t; a3: mpq_t) {.importc: "__gmpq_get_den", 
    dynlib: libgmp, cdecl.}
proc mpq_get_d*(a2: mpq_srcptr): cdouble {.importc: "__gmpq_get_d", 
    dynlib: libgmp, cdecl.}
proc mpq_get_d*(a2: mpq_t): cdouble {.importc: "__gmpq_get_d", dynlib: libgmp, 
                                      cdecl.}
proc mpq_get_str*(a2: cstring; a3: cint; a4: mpq_srcptr): cstring {.
    importc: "__gmpq_get_str", dynlib: libgmp, cdecl.}
proc mpq_get_str*(a2: cstring; a3: cint; a4: mpq_t): cstring {.
    importc: "__gmpq_get_str", dynlib: libgmp, cdecl.}
proc mpq_init*(a2: mpq_ptr) {.importc: "__gmpq_init", dynlib: libgmp, cdecl.}
proc mpq_init*(a2: var mpq_t) {.importc: "__gmpq_init", dynlib: libgmp, cdecl.}
proc mpq_inits*(a2: mpq_ptr) {.varargs, importc: "__gmpq_inits", dynlib: libgmp, 
                               cdecl.}
proc mpq_inits*(a2: var mpq_t) {.varargs, importc: "__gmpq_inits", 
                                 dynlib: libgmp, cdecl.}
proc mpq_inp_str*(a2: mpq_ptr; a3: File; a4: cint): csize {.
    importc: "__gmpq_inp_str", dynlib: libgmp, cdecl.}
proc mpq_inp_str*(a2: var mpq_t; a3: File; a4: cint): csize {.
    importc: "__gmpq_inp_str", dynlib: libgmp, cdecl.}
proc mpq_inv*(a2: mpq_ptr; a3: mpq_srcptr) {.importc: "__gmpq_inv", 
    dynlib: libgmp, cdecl.}
proc mpq_inv*(a2: var mpq_t; a3: mpq_t) {.importc: "__gmpq_inv", dynlib: libgmp, 
    cdecl.}
proc mpq_mul*(a2: mpq_ptr; a3: mpq_srcptr; a4: mpq_srcptr) {.
    importc: "__gmpq_mul", dynlib: libgmp, cdecl.}
proc mpq_mul*(a2: var mpq_t; a3: mpq_t; a4: mpq_t) {.importc: "__gmpq_mul", 
    dynlib: libgmp, cdecl.}
proc mpq_mul_2exp*(a2: mpq_ptr; a3: mpq_srcptr; a4: mp_bitcnt_t) {.
    importc: "__gmpq_mul_2exp", dynlib: libgmp, cdecl.}
proc mpq_mul_2exp*(a2: var mpq_t; a3: mpq_t; a4: mp_bitcnt_t) {.
    importc: "__gmpq_mul_2exp", dynlib: libgmp, cdecl.}
proc mpq_out_str*(a2: File; a3: cint; a4: mpq_srcptr): csize {.
    importc: "__gmpq_out_str", dynlib: libgmp, cdecl.}
proc mpq_out_str*(a2: File; a3: cint; a4: mpq_t): csize {.
    importc: "__gmpq_out_str", dynlib: libgmp, cdecl.}
proc mpq_set*(a2: mpq_ptr; a3: mpq_srcptr) {.importc: "__gmpq_set", 
    dynlib: libgmp, cdecl.}
proc mpq_set*(a2: var mpq_t; a3: mpq_t) {.importc: "__gmpq_set", dynlib: libgmp, 
    cdecl.}
proc mpq_set_d*(a2: mpq_ptr; a3: cdouble) {.importc: "__gmpq_set_d", 
    dynlib: libgmp, cdecl.}
proc mpq_set_d*(a2: var mpq_t; a3: cdouble) {.importc: "__gmpq_set_d", 
    dynlib: libgmp, cdecl.}
proc mpq_set_den*(a2: mpq_ptr; a3: mpz_srcptr) {.importc: "__gmpq_set_den", 
    dynlib: libgmp, cdecl.}
proc mpq_set_den*(a2: var mpq_t; a3: mpz_t) {.importc: "__gmpq_set_den", 
    dynlib: libgmp, cdecl.}
proc mpq_set_f*(a2: mpq_ptr; a3: mpf_srcptr) {.importc: "__gmpq_set_f", 
    dynlib: libgmp, cdecl.}
proc mpq_set_f*(a2: var mpq_t; a3: mpf_t) {.importc: "__gmpq_set_f", 
    dynlib: libgmp, cdecl.}
proc mpq_set_num*(a2: mpq_ptr; a3: mpz_srcptr) {.importc: "__gmpq_set_num", 
    dynlib: libgmp, cdecl.}
proc mpq_set_num*(a2: var mpq_t; a3: mpz_t) {.importc: "__gmpq_set_num", 
    dynlib: libgmp, cdecl.}
proc mpq_set_si*(a2: mpq_ptr; a3: clong; a4: culong) {.importc: "__gmpq_set_si", 
    dynlib: libgmp, cdecl.}
proc mpq_set_si*(a2: var mpq_t; a3: clong; a4: culong) {.
    importc: "__gmpq_set_si", dynlib: libgmp, cdecl.}
proc mpq_set_str*(a2: mpq_ptr; a3: cstring; a4: cint): cint {.
    importc: "__gmpq_set_str", dynlib: libgmp, cdecl.}
proc mpq_set_str*(a2: var mpq_t; a3: cstring; a4: cint): cint {.
    importc: "__gmpq_set_str", dynlib: libgmp, cdecl.}
proc mpq_set_ui*(a2: mpq_ptr; a3: culong; a4: culong) {.
    importc: "__gmpq_set_ui", dynlib: libgmp, cdecl.}
proc mpq_set_ui*(a2: var mpq_t; a3: culong; a4: culong) {.
    importc: "__gmpq_set_ui", dynlib: libgmp, cdecl.}
proc mpq_set_z*(a2: mpq_ptr; a3: mpz_srcptr) {.importc: "__gmpq_set_z", 
    dynlib: libgmp, cdecl.}
proc mpq_set_z*(a2: var mpq_t; a3: mpz_t) {.importc: "__gmpq_set_z", 
    dynlib: libgmp, cdecl.}
proc mpq_sub*(a2: mpq_ptr; a3: mpq_srcptr; a4: mpq_srcptr) {.
    importc: "__gmpq_sub", dynlib: libgmp, cdecl.}
proc mpq_sub*(a2: var mpq_t; a3: mpq_t; a4: mpq_t) {.importc: "__gmpq_sub", 
    dynlib: libgmp, cdecl.}
proc mpq_swap*(a2: mpq_ptr; a3: mpq_ptr) {.importc: "__gmpq_swap", 
    dynlib: libgmp, cdecl.}
proc mpq_swap*(a2: var mpq_t; a3: var mpq_t) {.importc: "__gmpq_swap", 
    dynlib: libgmp, cdecl.}
proc mpf_abs*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "__gmpf_abs", 
    dynlib: libgmp, cdecl.}
proc mpf_abs*(a2: var mpf_t; a3: mpf_t) {.importc: "__gmpf_abs", dynlib: libgmp, 
    cdecl.}
proc mpf_add*(a2: mpf_ptr; a3: mpf_srcptr; a4: mpf_srcptr) {.
    importc: "__gmpf_add", dynlib: libgmp, cdecl.}
proc mpf_add*(a2: var mpf_t; a3: mpf_t; a4: mpf_t) {.importc: "__gmpf_add", 
    dynlib: libgmp, cdecl.}
proc mpf_add_ui*(a2: mpf_ptr; a3: mpf_srcptr; a4: culong) {.
    importc: "__gmpf_add_ui", dynlib: libgmp, cdecl.}
proc mpf_add_ui*(a2: var mpf_t; a3: mpf_t; a4: culong) {.
    importc: "__gmpf_add_ui", dynlib: libgmp, cdecl.}
proc mpf_ceil*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "__gmpf_ceil", 
    dynlib: libgmp, cdecl.}
proc mpf_ceil*(a2: var mpf_t; a3: mpf_t) {.importc: "__gmpf_ceil", 
    dynlib: libgmp, cdecl.}
proc mpf_clear*(a2: mpf_ptr) {.importc: "__gmpf_clear", dynlib: libgmp, cdecl.}
proc mpf_clear*(a2: var mpf_t) {.importc: "__gmpf_clear", dynlib: libgmp, cdecl.}
proc mpf_clears*(a2: mpf_ptr) {.varargs, importc: "__gmpf_clears", 
                                dynlib: libgmp, cdecl.}
proc mpf_clears*(a2: var mpf_t) {.varargs, importc: "__gmpf_clears", 
                                  dynlib: libgmp, cdecl.}
proc mpf_cmp*(a2: mpf_srcptr; a3: mpf_srcptr): cint {.importc: "__gmpf_cmp", 
    dynlib: libgmp, cdecl.}
proc mpf_cmp*(a2: mpf_t; a3: mpf_t): cint {.importc: "__gmpf_cmp", 
    dynlib: libgmp, cdecl.}
proc mpf_cmp_d*(a2: mpf_srcptr; a3: cdouble): cint {.importc: "__gmpf_cmp_d", 
    dynlib: libgmp, cdecl.}
proc mpf_cmp_d*(a2: mpf_t; a3: cdouble): cint {.importc: "__gmpf_cmp_d", 
    dynlib: libgmp, cdecl.}
proc mpf_cmp_si*(a2: mpf_srcptr; a3: clong): cint {.importc: "__gmpf_cmp_si", 
    dynlib: libgmp, cdecl.}
proc mpf_cmp_si*(a2: mpf_t; a3: clong): cint {.importc: "__gmpf_cmp_si", 
    dynlib: libgmp, cdecl.}
proc mpf_cmp_ui*(a2: mpf_srcptr; a3: culong): cint {.importc: "__gmpf_cmp_ui", 
    dynlib: libgmp, cdecl.}
proc mpf_cmp_ui*(a2: mpf_t; a3: culong): cint {.importc: "__gmpf_cmp_ui", 
    dynlib: libgmp, cdecl.}
proc mpf_div*(a2: mpf_ptr; a3: mpf_srcptr; a4: mpf_srcptr) {.
    importc: "__gmpf_div", dynlib: libgmp, cdecl.}
proc mpf_div*(a2: var mpf_t; a3: mpf_t; a4: mpf_t) {.importc: "__gmpf_div", 
    dynlib: libgmp, cdecl.}
proc mpf_div_2exp*(a2: mpf_ptr; a3: mpf_srcptr; a4: mp_bitcnt_t) {.
    importc: "__gmpf_div_2exp", dynlib: libgmp, cdecl.}
proc mpf_div_2exp*(a2: var mpf_t; a3: mpf_t; a4: mp_bitcnt_t) {.
    importc: "__gmpf_div_2exp", dynlib: libgmp, cdecl.}
proc mpf_div_ui*(a2: mpf_ptr; a3: mpf_srcptr; a4: culong) {.
    importc: "__gmpf_div_ui", dynlib: libgmp, cdecl.}
proc mpf_div_ui*(a2: var mpf_t; a3: mpf_t; a4: culong) {.
    importc: "__gmpf_div_ui", dynlib: libgmp, cdecl.}
proc mpf_dump*(a2: mpf_srcptr) {.importc: "__gmpf_dump", dynlib: libgmp, cdecl.}
proc mpf_dump*(a2: mpf_t) {.importc: "__gmpf_dump", dynlib: libgmp, cdecl.}
proc mpf_eq*(a2: mpf_srcptr; a3: mpf_srcptr; a4: mp_bitcnt_t): cint {.
    importc: "__gmpf_eq", dynlib: libgmp, cdecl.}
proc mpf_eq*(a2: mpf_t; a3: mpf_t; a4: mp_bitcnt_t): cint {.
    importc: "__gmpf_eq", dynlib: libgmp, cdecl.}
proc mpf_fits_sint_p*(a2: mpf_srcptr): cint {.importc: "__gmpf_fits_sint_p", 
    dynlib: libgmp, cdecl.}
proc mpf_fits_sint_p*(a2: mpf_t): cint {.importc: "__gmpf_fits_sint_p", 
    dynlib: libgmp, cdecl.}
proc mpf_fits_slong_p*(a2: mpf_srcptr): cint {.importc: "__gmpf_fits_slong_p", 
    dynlib: libgmp, cdecl.}
proc mpf_fits_slong_p*(a2: mpf_t): cint {.importc: "__gmpf_fits_slong_p", 
    dynlib: libgmp, cdecl.}
proc mpf_fits_sshort_p*(a2: mpf_srcptr): cint {.importc: "__gmpf_fits_sshort_p", 
    dynlib: libgmp, cdecl.}
proc mpf_fits_sshort_p*(a2: mpf_t): cint {.importc: "__gmpf_fits_sshort_p", 
    dynlib: libgmp, cdecl.}
proc mpf_fits_uint_p*(a2: mpf_srcptr): cint {.importc: "__gmpf_fits_uint_p", 
    dynlib: libgmp, cdecl.}
proc mpf_fits_uint_p*(a2: mpf_t): cint {.importc: "__gmpf_fits_uint_p", 
    dynlib: libgmp, cdecl.}
proc mpf_fits_ulong_p*(a2: mpf_srcptr): cint {.importc: "__gmpf_fits_ulong_p", 
    dynlib: libgmp, cdecl.}
proc mpf_fits_ulong_p*(a2: mpf_t): cint {.importc: "__gmpf_fits_ulong_p", 
    dynlib: libgmp, cdecl.}
proc mpf_fits_ushort_p*(a2: mpf_srcptr): cint {.importc: "__gmpf_fits_ushort_p", 
    dynlib: libgmp, cdecl.}
proc mpf_fits_ushort_p*(a2: mpf_t): cint {.importc: "__gmpf_fits_ushort_p", 
    dynlib: libgmp, cdecl.}
proc mpf_floor*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "__gmpf_floor", 
    dynlib: libgmp, cdecl.}
proc mpf_floor*(a2: var mpf_t; a3: mpf_t) {.importc: "__gmpf_floor", 
    dynlib: libgmp, cdecl.}
proc mpf_get_d*(a2: mpf_srcptr): cdouble {.importc: "__gmpf_get_d", 
    dynlib: libgmp, cdecl.}
proc mpf_get_d*(a2: mpf_t): cdouble {.importc: "__gmpf_get_d", dynlib: libgmp, 
                                      cdecl.}
proc mpf_get_d_2exp*(a2: ptr clong; a3: mpf_srcptr): cdouble {.
    importc: "__gmpf_get_d_2exp", dynlib: libgmp, cdecl.}
proc mpf_get_d_2exp*(a2: ptr clong; a3: mpf_t): cdouble {.
    importc: "__gmpf_get_d_2exp", dynlib: libgmp, cdecl.}
proc mpf_get_default_prec*(): mp_bitcnt_t {.importc: "__gmpf_get_default_prec", 
    dynlib: libgmp, cdecl.}
proc mpf_get_prec*(a2: mpf_srcptr): mp_bitcnt_t {.importc: "__gmpf_get_prec", 
    dynlib: libgmp, cdecl.}
proc mpf_get_prec*(a2: mpf_t): mp_bitcnt_t {.importc: "__gmpf_get_prec", 
    dynlib: libgmp, cdecl.}
proc mpf_get_si*(a2: mpf_srcptr): clong {.importc: "__gmpf_get_si", 
    dynlib: libgmp, cdecl.}
proc mpf_get_si*(a2: mpf_t): clong {.importc: "__gmpf_get_si", dynlib: libgmp, 
                                     cdecl.}
proc mpf_get_str*(a2: cstring; a3: ptr mp_exp_t; a4: cint; a5: csize; 
                  a6: mpf_srcptr): cstring {.importc: "__gmpf_get_str", 
    dynlib: libgmp, cdecl.}
proc mpf_get_str*(a2: cstring; a3: var mp_exp_t; a4: cint; a5: csize; a6: mpf_t): cstring {.
    importc: "__gmpf_get_str", dynlib: libgmp, cdecl.}
proc mpf_get_ui*(a2: mpf_srcptr): culong {.importc: "__gmpf_get_ui", 
    dynlib: libgmp, cdecl.}
proc mpf_get_ui*(a2: mpf_t): culong {.importc: "__gmpf_get_ui", dynlib: libgmp, 
                                      cdecl.}
proc mpf_init*(a2: mpf_ptr) {.importc: "__gmpf_init", dynlib: libgmp, cdecl.}
proc mpf_init*(a2: var mpf_t) {.importc: "__gmpf_init", dynlib: libgmp, cdecl.}
proc mpf_init2*(a2: mpf_ptr; a3: mp_bitcnt_t) {.importc: "__gmpf_init2", 
    dynlib: libgmp, cdecl.}
proc mpf_init2*(a2: var mpf_t; a3: mp_bitcnt_t) {.importc: "__gmpf_init2", 
    dynlib: libgmp, cdecl.}
proc mpf_inits*(a2: mpf_ptr) {.varargs, importc: "__gmpf_inits", dynlib: libgmp, 
                               cdecl.}
proc mpf_inits*(a2: var mpf_t) {.varargs, importc: "__gmpf_inits", 
                                 dynlib: libgmp, cdecl.}
proc mpf_init_set*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "__gmpf_init_set", 
    dynlib: libgmp, cdecl.}
proc mpf_init_set*(a2: var mpf_t; a3: mpf_t) {.importc: "__gmpf_init_set", 
    dynlib: libgmp, cdecl.}
proc mpf_init_set_d*(a2: mpf_ptr; a3: cdouble) {.importc: "__gmpf_init_set_d", 
    dynlib: libgmp, cdecl.}
proc mpf_init_set_d*(a2: var mpf_t; a3: cdouble) {.importc: "__gmpf_init_set_d", 
    dynlib: libgmp, cdecl.}
proc mpf_init_set_si*(a2: mpf_ptr; a3: clong) {.importc: "__gmpf_init_set_si", 
    dynlib: libgmp, cdecl.}
proc mpf_init_set_si*(a2: var mpf_t; a3: clong) {.importc: "__gmpf_init_set_si", 
    dynlib: libgmp, cdecl.}
proc mpf_init_set_str*(a2: mpf_ptr; a3: cstring; a4: cint): cint {.
    importc: "__gmpf_init_set_str", dynlib: libgmp, cdecl.}
proc mpf_init_set_str*(a2: var mpf_t; a3: cstring; a4: cint): cint {.
    importc: "__gmpf_init_set_str", dynlib: libgmp, cdecl.}
proc mpf_init_set_ui*(a2: mpf_ptr; a3: culong) {.importc: "__gmpf_init_set_ui", 
    dynlib: libgmp, cdecl.}
proc mpf_init_set_ui*(a2: var mpf_t; a3: culong) {.
    importc: "__gmpf_init_set_ui", dynlib: libgmp, cdecl.}
proc mpf_inp_str*(a2: mpf_ptr; a3: File; a4: cint): csize {.
    importc: "__gmpf_inp_str", dynlib: libgmp, cdecl.}
proc mpf_inp_str*(a2: var mpf_t; a3: File; a4: cint): csize {.
    importc: "__gmpf_inp_str", dynlib: libgmp, cdecl.}
proc mpf_integer_p*(a2: mpf_srcptr): cint {.importc: "__gmpf_integer_p", 
    dynlib: libgmp, cdecl.}
proc mpf_integer_p*(a2: mpf_t): cint {.importc: "__gmpf_integer_p", 
                                       dynlib: libgmp, cdecl.}
proc mpf_mul*(a2: mpf_ptr; a3: mpf_srcptr; a4: mpf_srcptr) {.
    importc: "__gmpf_mul", dynlib: libgmp, cdecl.}
proc mpf_mul*(a2: var mpf_t; a3: mpf_t; a4: mpf_t) {.importc: "__gmpf_mul", 
    dynlib: libgmp, cdecl.}
proc mpf_mul_2exp*(a2: mpf_ptr; a3: mpf_srcptr; a4: mp_bitcnt_t) {.
    importc: "__gmpf_mul_2exp", dynlib: libgmp, cdecl.}
proc mpf_mul_2exp*(a2: var mpf_t; a3: mpf_t; a4: mp_bitcnt_t) {.
    importc: "__gmpf_mul_2exp", dynlib: libgmp, cdecl.}
proc mpf_mul_ui*(a2: mpf_ptr; a3: mpf_srcptr; a4: culong) {.
    importc: "__gmpf_mul_ui", dynlib: libgmp, cdecl.}
proc mpf_mul_ui*(a2: var mpf_t; a3: mpf_t; a4: culong) {.
    importc: "__gmpf_mul_ui", dynlib: libgmp, cdecl.}
proc mpf_neg*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "__gmpf_neg", 
    dynlib: libgmp, cdecl.}
proc mpf_neg*(a2: var mpf_t; a3: mpf_t) {.importc: "__gmpf_neg", dynlib: libgmp, 
    cdecl.}
proc mpf_out_str*(a2: File; a3: cint; a4: csize; a5: mpf_srcptr): csize {.
    importc: "__gmpf_out_str", dynlib: libgmp, cdecl.}
proc mpf_out_str*(a2: File; a3: cint; a4: csize; a5: mpf_t): csize {.
    importc: "__gmpf_out_str", dynlib: libgmp, cdecl.}
proc mpf_pow_ui*(a2: mpf_ptr; a3: mpf_srcptr; a4: culong) {.
    importc: "__gmpf_pow_ui", dynlib: libgmp, cdecl.}
proc mpf_pow_ui*(a2: var mpf_t; a3: mpf_t; a4: culong) {.
    importc: "__gmpf_pow_ui", dynlib: libgmp, cdecl.}
proc mpf_random2*(a2: mpf_ptr; a3: mp_size_t; a4: mp_exp_t) {.
    importc: "__gmpf_random2", dynlib: libgmp, cdecl.}
proc mpf_random2*(a2: var mpf_t; a3: mp_size_t; a4: mp_exp_t) {.
    importc: "__gmpf_random2", dynlib: libgmp, cdecl.}
proc mpf_reldiff*(a2: mpf_ptr; a3: mpf_srcptr; a4: mpf_srcptr) {.
    importc: "__gmpf_reldiff", dynlib: libgmp, cdecl.}
proc mpf_reldiff*(a2: var mpf_t; a3: mpf_t; a4: mpf_t) {.
    importc: "__gmpf_reldiff", dynlib: libgmp, cdecl.}
proc mpf_set*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "__gmpf_set", 
    dynlib: libgmp, cdecl.}
proc mpf_set*(a2: var mpf_t; a3: mpf_t) {.importc: "__gmpf_set", dynlib: libgmp, 
    cdecl.}
proc mpf_set_d*(a2: mpf_ptr; a3: cdouble) {.importc: "__gmpf_set_d", 
    dynlib: libgmp, cdecl.}
proc mpf_set_d*(a2: var mpf_t; a3: cdouble) {.importc: "__gmpf_set_d", 
    dynlib: libgmp, cdecl.}
proc mpf_set_default_prec*(a2: mp_bitcnt_t) {.
    importc: "__gmpf_set_default_prec", dynlib: libgmp, cdecl.}
proc mpf_set_prec*(a2: mpf_ptr; a3: mp_bitcnt_t) {.importc: "__gmpf_set_prec", 
    dynlib: libgmp, cdecl.}
proc mpf_set_prec*(a2: var mpf_t; a3: mp_bitcnt_t) {.importc: "__gmpf_set_prec", 
    dynlib: libgmp, cdecl.}
proc mpf_set_prec_raw*(a2: mpf_ptr; a3: mp_bitcnt_t) {.
    importc: "__gmpf_set_prec_raw", dynlib: libgmp, cdecl.}
proc mpf_set_prec_raw*(a2: var mpf_t; a3: mp_bitcnt_t) {.
    importc: "__gmpf_set_prec_raw", dynlib: libgmp, cdecl.}
proc mpf_set_q*(a2: mpf_ptr; a3: mpq_srcptr) {.importc: "__gmpf_set_q", 
    dynlib: libgmp, cdecl.}
proc mpf_set_q*(a2: var mpf_t; a3: mpq_t) {.importc: "__gmpf_set_q", 
    dynlib: libgmp, cdecl.}
proc mpf_set_si*(a2: mpf_ptr; a3: clong) {.importc: "__gmpf_set_si", 
    dynlib: libgmp, cdecl.}
proc mpf_set_si*(a2: var mpf_t; a3: clong) {.importc: "__gmpf_set_si", 
    dynlib: libgmp, cdecl.}
proc mpf_set_str*(a2: mpf_ptr; a3: cstring; a4: cint): cint {.
    importc: "__gmpf_set_str", dynlib: libgmp, cdecl.}
proc mpf_set_str*(a2: var mpf_t; a3: cstring; a4: cint): cint {.
    importc: "__gmpf_set_str", dynlib: libgmp, cdecl.}
proc mpf_set_ui*(a2: mpf_ptr; a3: culong) {.importc: "__gmpf_set_ui", 
    dynlib: libgmp, cdecl.}
proc mpf_set_ui*(a2: var mpf_t; a3: culong) {.importc: "__gmpf_set_ui", 
    dynlib: libgmp, cdecl.}
proc mpf_set_z*(a2: mpf_ptr; a3: mpz_srcptr) {.importc: "__gmpf_set_z", 
    dynlib: libgmp, cdecl.}
proc mpf_set_z*(a2: var mpf_t; a3: mpz_t) {.importc: "__gmpf_set_z", 
    dynlib: libgmp, cdecl.}
proc mpf_size*(a2: mpf_srcptr): csize {.importc: "__gmpf_size", dynlib: libgmp, 
                                        cdecl.}
proc mpf_size*(a2: mpf_t): csize {.importc: "__gmpf_size", dynlib: libgmp, cdecl.}
proc mpf_sqrt*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "__gmpf_sqrt", 
    dynlib: libgmp, cdecl.}
proc mpf_sqrt*(a2: var mpf_t; a3: mpf_t) {.importc: "__gmpf_sqrt", 
    dynlib: libgmp, cdecl.}
proc mpf_sqrt_ui*(a2: mpf_ptr; a3: culong) {.importc: "__gmpf_sqrt_ui", 
    dynlib: libgmp, cdecl.}
proc mpf_sqrt_ui*(a2: var mpf_t; a3: culong) {.importc: "__gmpf_sqrt_ui", 
    dynlib: libgmp, cdecl.}
proc mpf_sub*(a2: mpf_ptr; a3: mpf_srcptr; a4: mpf_srcptr) {.
    importc: "__gmpf_sub", dynlib: libgmp, cdecl.}
proc mpf_sub*(a2: var mpf_t; a3: mpf_t; a4: mpf_t) {.importc: "__gmpf_sub", 
    dynlib: libgmp, cdecl.}
proc mpf_sub_ui*(a2: mpf_ptr; a3: mpf_srcptr; a4: culong) {.
    importc: "__gmpf_sub_ui", dynlib: libgmp, cdecl.}
proc mpf_sub_ui*(a2: var mpf_t; a3: mpf_t; a4: culong) {.
    importc: "__gmpf_sub_ui", dynlib: libgmp, cdecl.}
proc mpf_swap*(a2: mpf_ptr; a3: mpf_ptr) {.importc: "__gmpf_swap", 
    dynlib: libgmp, cdecl.}
proc mpf_swap*(a2: var mpf_t; a3: var mpf_t) {.importc: "__gmpf_swap", 
    dynlib: libgmp, cdecl.}
proc mpf_trunc*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "__gmpf_trunc", 
    dynlib: libgmp, cdecl.}
proc mpf_trunc*(a2: var mpf_t; a3: mpf_t) {.importc: "__gmpf_trunc", 
    dynlib: libgmp, cdecl.}
proc mpf_ui_div*(a2: mpf_ptr; a3: culong; a4: mpf_srcptr) {.
    importc: "__gmpf_ui_div", dynlib: libgmp, cdecl.}
proc mpf_ui_div*(a2: var mpf_t; a3: culong; a4: mpf_t) {.
    importc: "__gmpf_ui_div", dynlib: libgmp, cdecl.}
proc mpf_ui_sub*(a2: mpf_ptr; a3: culong; a4: mpf_srcptr) {.
    importc: "__gmpf_ui_sub", dynlib: libgmp, cdecl.}
proc mpf_ui_sub*(a2: var mpf_t; a3: culong; a4: mpf_t) {.
    importc: "__gmpf_ui_sub", dynlib: libgmp, cdecl.}
proc mpf_urandomb*(a2: mpf_t; a3: gmp_randstate_t; a4: mp_bitcnt_t) {.
    importc: "__gmpf_urandomb", dynlib: libgmp, cdecl.}
proc mpn_add_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t): mp_limb_t {.
    importc: "__gmpn_add_n", dynlib: libgmp, cdecl.}
proc mpn_add_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                a5: mp_size_t): mp_limb_t {.importc: "__gmpn_add_n", 
    dynlib: libgmp, cdecl.}
proc mpn_addmul_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.
    importc: "__gmpn_addmul_1", dynlib: libgmp, cdecl.}
proc mpn_addmul_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                   a5: mp_limb_t): mp_limb_t {.importc: "__gmpn_addmul_1", 
    dynlib: libgmp, cdecl.}
proc mpn_divexact_by3c*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.
    importc: "__gmpn_divexact_by3c", dynlib: libgmp, cdecl.}
proc mpn_divexact_by3c*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                        a5: mp_limb_t): mp_limb_t {.
    importc: "__gmpn_divexact_by3c", dynlib: libgmp, cdecl.}
proc mpn_divrem*(a2: mp_ptr; a3: mp_size_t; a4: mp_ptr; a5: mp_size_t; 
                 a6: mp_srcptr; a7: mp_size_t): mp_limb_t {.
    importc: "__gmpn_divrem", dynlib: libgmp, cdecl.}
proc mpn_divrem*(a2: var mp_limb_t; a3: mp_size_t; a4: var mp_limb_t; 
                 a5: mp_size_t; a6: var mp_limb_t; a7: mp_size_t): mp_limb_t {.
    importc: "__gmpn_divrem", dynlib: libgmp, cdecl.}
proc mpn_divrem_1*(a2: mp_ptr; a3: mp_size_t; a4: mp_srcptr; a5: mp_size_t; 
                   a6: mp_limb_t): mp_limb_t {.importc: "__gmpn_divrem_1", 
    dynlib: libgmp, cdecl.}
proc mpn_divrem_1*(a2: var mp_limb_t; a3: mp_size_t; a4: var mp_limb_t; 
                   a5: mp_size_t; a6: mp_limb_t): mp_limb_t {.
    importc: "__gmpn_divrem_1", dynlib: libgmp, cdecl.}
proc mpn_divrem_2*(a2: mp_ptr; a3: mp_size_t; a4: mp_ptr; a5: mp_size_t; 
                   a6: mp_srcptr): mp_limb_t {.importc: "__gmpn_divrem_2", 
    dynlib: libgmp, cdecl.}
proc mpn_divrem_2*(a2: var mp_limb_t; a3: mp_size_t; a4: var mp_limb_t; 
                   a5: mp_size_t; a6: var mp_limb_t): mp_limb_t {.
    importc: "__gmpn_divrem_2", dynlib: libgmp, cdecl.}
proc mpn_div_qr_1*(a2: mp_ptr; a3: ptr mp_limb_t; a4: mp_srcptr; a5: mp_size_t; 
                   a6: mp_limb_t): mp_limb_t {.importc: "__gmpn_div_qr_1", 
    dynlib: libgmp, cdecl.}
proc mpn_div_qr_1*(a2: var mp_limb_t; a3: ptr mp_limb_t; a4: var mp_limb_t; 
                   a5: mp_size_t; a6: mp_limb_t): mp_limb_t {.
    importc: "__gmpn_div_qr_1", dynlib: libgmp, cdecl.}
proc mpn_div_qr_2*(a2: mp_ptr; a3: mp_ptr; a4: mp_srcptr; a5: mp_size_t; 
                   a6: mp_srcptr): mp_limb_t {.importc: "__gmpn_div_qr_2", 
    dynlib: libgmp, cdecl.}
proc mpn_div_qr_2*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                   a5: mp_size_t; a6: var mp_limb_t): mp_limb_t {.
    importc: "__gmpn_div_qr_2", dynlib: libgmp, cdecl.}
proc mpn_gcd*(a2: mp_ptr; a3: mp_ptr; a4: mp_size_t; a5: mp_ptr; a6: mp_size_t): mp_size_t {.
    importc: "__gmpn_gcd", dynlib: libgmp, cdecl.}
proc mpn_gcd*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
              a5: var mp_limb_t; a6: mp_size_t): mp_size_t {.
    importc: "__gmpn_gcd", dynlib: libgmp, cdecl.}
proc mpn_gcd_1*(a2: mp_srcptr; a3: mp_size_t; a4: mp_limb_t): mp_limb_t {.
    importc: "__gmpn_gcd_1", dynlib: libgmp, cdecl.}
proc mpn_gcd_1*(a2: var mp_limb_t; a3: mp_size_t; a4: mp_limb_t): mp_limb_t {.
    importc: "__gmpn_gcd_1", dynlib: libgmp, cdecl.}
proc mpn_gcdext_1*(a2: ptr mp_limb_signed_t; a3: ptr mp_limb_signed_t; 
                   a4: mp_limb_t; a5: mp_limb_t): mp_limb_t {.
    importc: "__gmpn_gcdext_1", dynlib: libgmp, cdecl.}
proc mpn_gcdext*(a2: mp_ptr; a3: mp_ptr; a4: ptr mp_size_t; a5: mp_ptr; 
                 a6: mp_size_t; a7: mp_ptr; a8: mp_size_t): mp_size_t {.
    importc: "__gmpn_gcdext", dynlib: libgmp, cdecl.}
proc mpn_gcdext*(a2: var mp_limb_t; a3: var mp_limb_t; a4: ptr mp_size_t; 
                 a5: var mp_limb_t; a6: mp_size_t; a7: var mp_limb_t; 
                 a8: mp_size_t): mp_size_t {.importc: "__gmpn_gcdext", 
    dynlib: libgmp, cdecl.}
proc mpn_get_str*(a2: ptr cuchar; a3: cint; a4: mp_ptr; a5: mp_size_t): csize {.
    importc: "__gmpn_get_str", dynlib: libgmp, cdecl.}
proc mpn_get_str*(a2: ptr cuchar; a3: cint; a4: var mp_limb_t; a5: mp_size_t): csize {.
    importc: "__gmpn_get_str", dynlib: libgmp, cdecl.}
proc mpn_hamdist*(a2: mp_srcptr; a3: mp_srcptr; a4: mp_size_t): mp_bitcnt_t {.
    importc: "__gmpn_hamdist", dynlib: libgmp, cdecl.}
proc mpn_hamdist*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t): mp_bitcnt_t {.
    importc: "__gmpn_hamdist", dynlib: libgmp, cdecl.}
proc mpn_lshift*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: cuint): mp_limb_t {.
    importc: "__gmpn_lshift", dynlib: libgmp, cdecl.}
proc mpn_lshift*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: cuint): mp_limb_t {.
    importc: "__gmpn_lshift", dynlib: libgmp, cdecl.}
proc mpn_mod_1*(a2: mp_srcptr; a3: mp_size_t; a4: mp_limb_t): mp_limb_t {.
    importc: "__gmpn_mod_1", dynlib: libgmp, cdecl.}
proc mpn_mod_1*(a2: var mp_limb_t; a3: mp_size_t; a4: mp_limb_t): mp_limb_t {.
    importc: "__gmpn_mod_1", dynlib: libgmp, cdecl.}
proc mpn_mul*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_srcptr; 
              a6: mp_size_t): mp_limb_t {.importc: "__gmpn_mul", dynlib: libgmp, 
    cdecl.}
proc mpn_mul*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
              a5: var mp_limb_t; a6: mp_size_t): mp_limb_t {.
    importc: "__gmpn_mul", dynlib: libgmp, cdecl.}
proc mpn_mul_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.
    importc: "__gmpn_mul_1", dynlib: libgmp, cdecl.}
proc mpn_mul_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                a5: mp_limb_t): mp_limb_t {.importc: "__gmpn_mul_1", 
    dynlib: libgmp, cdecl.}
proc mpn_mul_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.
    importc: "__gmpn_mul_n", dynlib: libgmp, cdecl.}
proc mpn_mul_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                a5: mp_size_t) {.importc: "__gmpn_mul_n", dynlib: libgmp, cdecl.}
proc mpn_sqr*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t) {.importc: "__gmpn_sqr", 
    dynlib: libgmp, cdecl.}
proc mpn_sqr*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t) {.
    importc: "__gmpn_sqr", dynlib: libgmp, cdecl.}
proc mpn_neg*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t): mp_limb_t {.
    importc: "__gmpn_neg", dynlib: libgmp, cdecl.}
proc mpn_neg*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t): mp_limb_t {.
    importc: "__gmpn_neg", dynlib: libgmp, cdecl.}
proc mpn_com*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t) {.importc: "__gmpn_com", 
    dynlib: libgmp, cdecl.}
proc mpn_com*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t) {.
    importc: "__gmpn_com", dynlib: libgmp, cdecl.}
proc mpn_perfect_square_p*(a2: mp_srcptr; a3: mp_size_t): cint {.
    importc: "__gmpn_perfect_square_p", dynlib: libgmp, cdecl.}
proc mpn_perfect_square_p*(a2: var mp_limb_t; a3: mp_size_t): cint {.
    importc: "__gmpn_perfect_square_p", dynlib: libgmp, cdecl.}
proc mpn_perfect_power_p*(a2: mp_srcptr; a3: mp_size_t): cint {.
    importc: "__gmpn_perfect_power_p", dynlib: libgmp, cdecl.}
proc mpn_perfect_power_p*(a2: var mp_limb_t; a3: mp_size_t): cint {.
    importc: "__gmpn_perfect_power_p", dynlib: libgmp, cdecl.}
proc mpn_popcount*(a2: mp_srcptr; a3: mp_size_t): mp_bitcnt_t {.
    importc: "__gmpn_popcount", dynlib: libgmp, cdecl.}
proc mpn_popcount*(a2: var mp_limb_t; a3: mp_size_t): mp_bitcnt_t {.
    importc: "__gmpn_popcount", dynlib: libgmp, cdecl.}
proc mpn_pow_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t; 
                a6: mp_ptr): mp_size_t {.importc: "__gmpn_pow_1", 
    dynlib: libgmp, cdecl.}
proc mpn_pow_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                a5: mp_limb_t; a6: var mp_limb_t): mp_size_t {.
    importc: "__gmpn_pow_1", dynlib: libgmp, cdecl.}
proc mpn_preinv_mod_1*(a2: mp_srcptr; a3: mp_size_t; a4: mp_limb_t; 
                       a5: mp_limb_t): mp_limb_t {.
    importc: "__gmpn_preinv_mod_1", dynlib: libgmp, cdecl.}
proc mpn_preinv_mod_1*(a2: var mp_limb_t; a3: mp_size_t; a4: mp_limb_t; 
                       a5: mp_limb_t): mp_limb_t {.
    importc: "__gmpn_preinv_mod_1", dynlib: libgmp, cdecl.}
proc mpn_random*(a2: mp_ptr; a3: mp_size_t) {.importc: "__gmpn_random", 
    dynlib: libgmp, cdecl.}
proc mpn_random*(a2: var mp_limb_t; a3: mp_size_t) {.importc: "__gmpn_random", 
    dynlib: libgmp, cdecl.}
proc mpn_random2*(a2: mp_ptr; a3: mp_size_t) {.importc: "__gmpn_random2", 
    dynlib: libgmp, cdecl.}
proc mpn_random2*(a2: var mp_limb_t; a3: mp_size_t) {.importc: "__gmpn_random2", 
    dynlib: libgmp, cdecl.}
proc mpn_rshift*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: cuint): mp_limb_t {.
    importc: "__gmpn_rshift", dynlib: libgmp, cdecl.}
proc mpn_rshift*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: cuint): mp_limb_t {.
    importc: "__gmpn_rshift", dynlib: libgmp, cdecl.}
proc mpn_scan0*(a2: mp_srcptr; a3: mp_bitcnt_t): mp_bitcnt_t {.
    importc: "__gmpn_scan0", dynlib: libgmp, cdecl.}
proc mpn_scan0*(a2: var mp_limb_t; a3: mp_bitcnt_t): mp_bitcnt_t {.
    importc: "__gmpn_scan0", dynlib: libgmp, cdecl.}
proc mpn_scan1*(a2: mp_srcptr; a3: mp_bitcnt_t): mp_bitcnt_t {.
    importc: "__gmpn_scan1", dynlib: libgmp, cdecl.}
proc mpn_scan1*(a2: var mp_limb_t; a3: mp_bitcnt_t): mp_bitcnt_t {.
    importc: "__gmpn_scan1", dynlib: libgmp, cdecl.}
proc mpn_set_str*(a2: mp_ptr; a3: ptr cuchar; a4: csize; a5: cint): mp_size_t {.
    importc: "__gmpn_set_str", dynlib: libgmp, cdecl.}
proc mpn_set_str*(a2: var mp_limb_t; a3: ptr cuchar; a4: csize; a5: cint): mp_size_t {.
    importc: "__gmpn_set_str", dynlib: libgmp, cdecl.}
proc mpn_sizeinbase*(a2: mp_srcptr; a3: mp_size_t; a4: cint): csize {.
    importc: "__gmpn_sizeinbase", dynlib: libgmp, cdecl.}
proc mpn_sizeinbase*(a2: var mp_limb_t; a3: mp_size_t; a4: cint): csize {.
    importc: "__gmpn_sizeinbase", dynlib: libgmp, cdecl.}
proc mpn_sqrtrem*(a2: mp_ptr; a3: mp_ptr; a4: mp_srcptr; a5: mp_size_t): mp_size_t {.
    importc: "__gmpn_sqrtrem", dynlib: libgmp, cdecl.}
proc mpn_sqrtrem*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                  a5: mp_size_t): mp_size_t {.importc: "__gmpn_sqrtrem", 
    dynlib: libgmp, cdecl.}
proc mpn_sub*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_srcptr; 
              a6: mp_size_t): mp_limb_t {.importc: "__gmpn_sub", dynlib: libgmp, 
    cdecl.}
proc mpn_sub*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
              a5: var mp_limb_t; a6: mp_size_t): mp_limb_t {.
    importc: "__gmpn_sub", dynlib: libgmp, cdecl.}
proc mpn_sub_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.
    importc: "__gmpn_sub_1", dynlib: libgmp, cdecl.}
proc mpn_sub_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                a5: mp_limb_t): mp_limb_t {.importc: "__gmpn_sub_1", 
    dynlib: libgmp, cdecl.}
proc mpn_sub_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t): mp_limb_t {.
    importc: "__gmpn_sub_n", dynlib: libgmp, cdecl.}
proc mpn_sub_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                a5: mp_size_t): mp_limb_t {.importc: "__gmpn_sub_n", 
    dynlib: libgmp, cdecl.}
proc mpn_submul_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.
    importc: "__gmpn_submul_1", dynlib: libgmp, cdecl.}
proc mpn_submul_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                   a5: mp_limb_t): mp_limb_t {.importc: "__gmpn_submul_1", 
    dynlib: libgmp, cdecl.}
proc mpn_tdiv_qr*(a2: mp_ptr; a3: mp_ptr; a4: mp_size_t; a5: mp_srcptr; 
                  a6: mp_size_t; a7: mp_srcptr; a8: mp_size_t) {.
    importc: "__gmpn_tdiv_qr", dynlib: libgmp, cdecl.}
proc mpn_tdiv_qr*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                  a5: var mp_limb_t; a6: mp_size_t; a7: var mp_limb_t; 
                  a8: mp_size_t) {.importc: "__gmpn_tdiv_qr", dynlib: libgmp, 
                                   cdecl.}
proc mpn_and_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.
    importc: "__gmpn_and_n", dynlib: libgmp, cdecl.}
proc mpn_and_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                a5: mp_size_t) {.importc: "__gmpn_and_n", dynlib: libgmp, cdecl.}
proc mpn_andn_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.
    importc: "__gmpn_andn_n", dynlib: libgmp, cdecl.}
proc mpn_andn_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                 a5: mp_size_t) {.importc: "__gmpn_andn_n", dynlib: libgmp, 
                                  cdecl.}
proc mpn_nand_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.
    importc: "__gmpn_nand_n", dynlib: libgmp, cdecl.}
proc mpn_nand_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                 a5: mp_size_t) {.importc: "__gmpn_nand_n", dynlib: libgmp, 
                                  cdecl.}
proc mpn_ior_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.
    importc: "__gmpn_ior_n", dynlib: libgmp, cdecl.}
proc mpn_ior_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                a5: mp_size_t) {.importc: "__gmpn_ior_n", dynlib: libgmp, cdecl.}
proc mpn_iorn_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.
    importc: "__gmpn_iorn_n", dynlib: libgmp, cdecl.}
proc mpn_iorn_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                 a5: mp_size_t) {.importc: "__gmpn_iorn_n", dynlib: libgmp, 
                                  cdecl.}
proc mpn_nior_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.
    importc: "__gmpn_nior_n", dynlib: libgmp, cdecl.}
proc mpn_nior_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                 a5: mp_size_t) {.importc: "__gmpn_nior_n", dynlib: libgmp, 
                                  cdecl.}
proc mpn_xor_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.
    importc: "__gmpn_xor_n", dynlib: libgmp, cdecl.}
proc mpn_xor_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                a5: mp_size_t) {.importc: "__gmpn_xor_n", dynlib: libgmp, cdecl.}
proc mpn_xnor_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.
    importc: "__gmpn_xnor_n", dynlib: libgmp, cdecl.}
proc mpn_xnor_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                 a5: mp_size_t) {.importc: "__gmpn_xnor_n", dynlib: libgmp, 
                                  cdecl.}
proc mpn_copyi*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t) {.
    importc: "__gmpn_copyi", dynlib: libgmp, cdecl.}
proc mpn_copyi*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t) {.
    importc: "__gmpn_copyi", dynlib: libgmp, cdecl.}
proc mpn_copyd*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t) {.
    importc: "__gmpn_copyd", dynlib: libgmp, cdecl.}
proc mpn_copyd*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t) {.
    importc: "__gmpn_copyd", dynlib: libgmp, cdecl.}
proc mpn_zero*(a2: mp_ptr; a3: mp_size_t) {.importc: "__gmpn_zero", 
    dynlib: libgmp, cdecl.}
proc mpn_zero*(a2: var mp_limb_t; a3: mp_size_t) {.importc: "__gmpn_zero", 
    dynlib: libgmp, cdecl.}
proc mpn_cnd_add_n*(a2: mp_limb_t; a3: mp_ptr; a4: mp_srcptr; a5: mp_srcptr; 
                    a6: mp_size_t): mp_limb_t {.importc: "__gmpn_cnd_add_n", 
    dynlib: libgmp, cdecl.}
proc mpn_cnd_add_n*(a2: mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                    a5: var mp_limb_t; a6: mp_size_t): mp_limb_t {.
    importc: "__gmpn_cnd_add_n", dynlib: libgmp, cdecl.}
proc mpn_cnd_sub_n*(a2: mp_limb_t; a3: mp_ptr; a4: mp_srcptr; a5: mp_srcptr; 
                    a6: mp_size_t): mp_limb_t {.importc: "__gmpn_cnd_sub_n", 
    dynlib: libgmp, cdecl.}
proc mpn_cnd_sub_n*(a2: mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                    a5: var mp_limb_t; a6: mp_size_t): mp_limb_t {.
    importc: "__gmpn_cnd_sub_n", dynlib: libgmp, cdecl.}
proc mpn_sec_add_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t; 
                    a6: mp_ptr): mp_limb_t {.importc: "__gmpn_sec_add_1", 
    dynlib: libgmp, cdecl.}
proc mpn_sec_add_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                    a5: mp_limb_t; a6: var mp_limb_t): mp_limb_t {.
    importc: "__gmpn_sec_add_1", dynlib: libgmp, cdecl.}
proc mpn_sec_add_1_itch*(a2: mp_size_t): mp_size_t {.
    importc: "__gmpn_sec_add_1_itch", dynlib: libgmp, cdecl.}
proc mpn_sec_sub_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t; 
                    a6: mp_ptr): mp_limb_t {.importc: "__gmpn_sec_sub_1", 
    dynlib: libgmp, cdecl.}
proc mpn_sec_sub_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                    a5: mp_limb_t; a6: var mp_limb_t): mp_limb_t {.
    importc: "__gmpn_sec_sub_1", dynlib: libgmp, cdecl.}
proc mpn_sec_sub_1_itch*(a2: mp_size_t): mp_size_t {.
    importc: "__gmpn_sec_sub_1_itch", dynlib: libgmp, cdecl.}
proc mpn_sec_mul*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_srcptr; 
                  a6: mp_size_t; a7: mp_ptr) {.importc: "__gmpn_sec_mul", 
    dynlib: libgmp, cdecl.}
proc mpn_sec_mul*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                  a5: var mp_limb_t; a6: mp_size_t; a7: var mp_limb_t) {.
    importc: "__gmpn_sec_mul", dynlib: libgmp, cdecl.}
proc mpn_sec_mul_itch*(a2: mp_size_t; a3: mp_size_t): mp_size_t {.
    importc: "__gmpn_sec_mul_itch", dynlib: libgmp, cdecl.}
proc mpn_sec_sqr*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_ptr) {.
    importc: "__gmpn_sec_sqr", dynlib: libgmp, cdecl.}
proc mpn_sec_sqr*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                  a5: var mp_limb_t) {.importc: "__gmpn_sec_sqr", 
                                       dynlib: libgmp, cdecl.}
proc mpn_sec_sqr_itch*(a2: mp_size_t): mp_size_t {.
    importc: "__gmpn_sec_sqr_itch", dynlib: libgmp, cdecl.}
proc mpn_sec_powm*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_srcptr; 
                   a6: mp_bitcnt_t; a7: mp_srcptr; a8: mp_size_t; a9: mp_ptr) {.
    importc: "__gmpn_sec_powm", dynlib: libgmp, cdecl.}
proc mpn_sec_powm*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                   a5: var mp_limb_t; a6: mp_bitcnt_t; a7: var mp_limb_t; 
                   a8: mp_size_t; a9: var mp_limb_t) {.
    importc: "__gmpn_sec_powm", dynlib: libgmp, cdecl.}
proc mpn_sec_powm_itch*(a2: mp_size_t; a3: mp_bitcnt_t; a4: mp_size_t): mp_size_t {.
    importc: "__gmpn_sec_powm_itch", dynlib: libgmp, cdecl.}
proc mpn_sec_tabselect*(a2: ptr mp_limb_t; a3: ptr mp_limb_t; a4: mp_size_t; 
                        a5: mp_size_t; a6: mp_size_t) {.
    importc: "__gmpn_sec_tabselect", dynlib: libgmp, cdecl.}
proc mpn_sec_div_qr*(a2: mp_ptr; a3: mp_ptr; a4: mp_size_t; a5: mp_srcptr; 
                     a6: mp_size_t; a7: mp_ptr): mp_limb_t {.
    importc: "__gmpn_sec_div_qr", dynlib: libgmp, cdecl.}
proc mpn_sec_div_qr*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                     a5: var mp_limb_t; a6: mp_size_t; a7: var mp_limb_t): mp_limb_t {.
    importc: "__gmpn_sec_div_qr", dynlib: libgmp, cdecl.}
proc mpn_sec_div_qr_itch*(a2: mp_size_t; a3: mp_size_t): mp_size_t {.
    importc: "__gmpn_sec_div_qr_itch", dynlib: libgmp, cdecl.}
proc mpn_sec_div_r*(a2: mp_ptr; a3: mp_size_t; a4: mp_srcptr; a5: mp_size_t; 
                    a6: mp_ptr) {.importc: "__gmpn_sec_div_r", dynlib: libgmp, 
                                  cdecl.}
proc mpn_sec_div_r*(a2: var mp_limb_t; a3: mp_size_t; a4: var mp_limb_t; 
                    a5: mp_size_t; a6: var mp_limb_t) {.
    importc: "__gmpn_sec_div_r", dynlib: libgmp, cdecl.}
proc mpn_sec_div_r_itch*(a2: mp_size_t; a3: mp_size_t): mp_size_t {.
    importc: "__gmpn_sec_div_r_itch", dynlib: libgmp, cdecl.}
proc mpn_sec_invert*(a2: mp_ptr; a3: mp_ptr; a4: mp_srcptr; a5: mp_size_t; 
                     a6: mp_bitcnt_t; a7: mp_ptr): cint {.
    importc: "__gmpn_sec_invert", dynlib: libgmp, cdecl.}
proc mpn_sec_invert*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                     a5: mp_size_t; a6: mp_bitcnt_t; a7: var mp_limb_t): cint {.
    importc: "__gmpn_sec_invert", dynlib: libgmp, cdecl.}
proc mpn_sec_invert_itch*(a2: mp_size_t): mp_size_t {.
    importc: "__gmpn_sec_invert_itch", dynlib: libgmp, cdecl.}
proc mpz_abs*(mm_gmp_w: mpz_ptr; mm_gmp_u: mpz_srcptr) {.importc: "__gmpz_abs", 
    dynlib: libgmp, cdecl.}
proc mpz_abs*(mm_gmp_w: var mpz_t; mm_gmp_u: mpz_t) {.importc: "__gmpz_abs", 
    dynlib: libgmp, cdecl.}
proc mpz_fits_uint_p*(mm_gmp_z: mpz_srcptr): cint {.
    importc: "__gmpz_fits_uint_p", dynlib: libgmp, cdecl.}
proc mpz_fits_uint_p*(mm_gmp_z: mpz_t): cint {.importc: "__gmpz_fits_uint_p", 
    dynlib: libgmp, cdecl.}
proc mpz_fits_ulong_p*(mm_gmp_z: mpz_srcptr): cint {.
    importc: "__gmpz_fits_ulong_p", dynlib: libgmp, cdecl.}
proc mpz_fits_ulong_p*(mm_gmp_z: mpz_t): cint {.importc: "__gmpz_fits_ulong_p", 
    dynlib: libgmp, cdecl.}
proc mpz_fits_ushort_p*(mm_gmp_z: mpz_srcptr): cint {.
    importc: "__gmpz_fits_ushort_p", dynlib: libgmp, cdecl.}
proc mpz_fits_ushort_p*(mm_gmp_z: mpz_t): cint {.
    importc: "__gmpz_fits_ushort_p", dynlib: libgmp, cdecl.}
proc mpz_get_ui*(mm_gmp_z: mpz_srcptr): culong {.importc: "__gmpz_get_ui", 
    dynlib: libgmp, cdecl.}
proc mpz_get_ui*(mm_gmp_z: mpz_t): culong {.importc: "__gmpz_get_ui", 
    dynlib: libgmp, cdecl.}
proc mpz_getlimbn*(mm_gmp_z: mpz_srcptr; mm_gmp_n: mp_size_t): mp_limb_t {.
    importc: "__gmpz_getlimbn", dynlib: libgmp, cdecl.}
proc mpz_getlimbn*(mm_gmp_z: mpz_t; mm_gmp_n: mp_size_t): mp_limb_t {.
    importc: "__gmpz_getlimbn", dynlib: libgmp, cdecl.}
proc mpz_neg*(mm_gmp_w: mpz_ptr; mm_gmp_u: mpz_srcptr) {.importc: "__gmpz_neg", 
    dynlib: libgmp, cdecl.}
proc mpz_neg*(mm_gmp_w: var mpz_t; mm_gmp_u: mpz_t) {.importc: "__gmpz_neg", 
    dynlib: libgmp, cdecl.}
proc mpz_perfect_square_p*(mm_gmp_a: mpz_srcptr): cint {.
    importc: "__gmpz_perfect_square_p", dynlib: libgmp, cdecl.}
proc mpz_perfect_square_p*(mm_gmp_a: mpz_t): cint {.
    importc: "__gmpz_perfect_square_p", dynlib: libgmp, cdecl.}
proc mpz_popcount*(mm_gmp_u: mpz_srcptr): mp_bitcnt_t {.
    importc: "__gmpz_popcount", dynlib: libgmp, cdecl.}
proc mpz_popcount*(mm_gmp_u: mpz_t): mp_bitcnt_t {.importc: "__gmpz_popcount", 
    dynlib: libgmp, cdecl.}
proc mpz_set_q*(mm_gmp_w: mpz_ptr; mm_gmp_u: mpq_srcptr) {.
    importc: "__gmpz_set_q", dynlib: libgmp, cdecl.}
proc mpz_set_q*(mm_gmp_w: var mpz_t; mm_gmp_u: mpq_t) {.importc: "__gmpz_set_q", 
    dynlib: libgmp, cdecl.}
proc mpz_size*(mm_gmp_z: mpz_srcptr): csize {.importc: "__gmpz_size", 
    dynlib: libgmp, cdecl.}
proc mpz_size*(mm_gmp_z: mpz_t): csize {.importc: "__gmpz_size", dynlib: libgmp, 
    cdecl.}
proc mpq_abs*(mm_gmp_w: mpq_ptr; mm_gmp_u: mpq_srcptr) {.importc: "__gmpq_abs", 
    dynlib: libgmp, cdecl.}
proc mpq_abs*(mm_gmp_w: var mpq_t; mm_gmp_u: mpq_t) {.importc: "__gmpq_abs", 
    dynlib: libgmp, cdecl.}
proc mpq_neg*(mm_gmp_w: mpq_ptr; mm_gmp_u: mpq_srcptr) {.importc: "__gmpq_neg", 
    dynlib: libgmp, cdecl.}
proc mpq_neg*(mm_gmp_w: var mpq_t; mm_gmp_u: mpq_t) {.importc: "__gmpq_neg", 
    dynlib: libgmp, cdecl.}
proc mpn_add*(mm_gmp_wp: mp_ptr; mm_gmp_xp: mp_srcptr; mm_gmp_xsize: mp_size_t; 
              mm_gmp_yp: mp_srcptr; mm_gmp_ysize: mp_size_t): mp_limb_t {.
    importc: "__gmpn_add", dynlib: libgmp, cdecl.}
proc mpn_add*(mm_gmp_wp: var mp_limb_t; mm_gmp_xp: var mp_limb_t; 
              mm_gmp_xsize: mp_size_t; mm_gmp_yp: var mp_limb_t; 
              mm_gmp_ysize: mp_size_t): mp_limb_t {.importc: "__gmpn_add", 
    dynlib: libgmp, cdecl.}
proc mpn_add_1*(mm_gmp_dst: mp_ptr; mm_gmp_src: mp_srcptr; 
                mm_gmp_size: mp_size_t; mm_gmp_n: mp_limb_t): mp_limb_t {.
    importc: "__gmpn_add_1", dynlib: libgmp, cdecl.}
proc mpn_add_1*(mm_gmp_dst: var mp_limb_t; mm_gmp_src: var mp_limb_t; 
                mm_gmp_size: mp_size_t; mm_gmp_n: mp_limb_t): mp_limb_t {.
    importc: "__gmpn_add_1", dynlib: libgmp, cdecl.}
proc mpn_cmp*(mm_gmp_xp: mp_srcptr; mm_gmp_yp: mp_srcptr; mm_gmp_size: mp_size_t): cint {.
    importc: "__gmpn_cmp", dynlib: libgmp, cdecl.}
proc mpn_cmp*(mm_gmp_xp: var mp_limb_t; mm_gmp_yp: var mp_limb_t; 
              mm_gmp_size: mp_size_t): cint {.importc: "__gmpn_cmp", 
    dynlib: libgmp, cdecl.}
proc mpz_sgn*(a2: mpz_t): cint =
  if a2.mp_size < 0: -1 else: (a2.mp_size > 0).cint
proc mpz_sgn*(a2: mpz_srcptr): cint = mpz_sgn(a2[])
proc mpf_sgn*(a2: mpf_t): cint =
  if a2.mp_size < 0: -1 else: (a2.mp_size > 0).cint
proc mpf_sgn*(a2: mpf_srcptr): cint = mpf_sgn(a2[])
proc mpq_sgn*(a2: mpq_t): cint =
  if a2.mp_num.mp_size < 0: -1 else: (a2.mp_num.mp_size > 0).cint
proc mpq_sgn*(a2: mpq_srcptr): cint = mpq_sgn(a2[])
proc mpz_odd_p*(a2: mpz_t): cint =
  (a2.mp_size != 0).cint and (cast[ptr culong](a2.mp_d)[]).cint
proc mpz_odd_p*(a2: mpz_srcptr): cint = mpz_odd_p(a2[])
proc mpz_even_p*(a2: mpz_t | mpz_srcptr): cint = (not mpz_odd_p(a2).bool).cint
const 
  GMP_ERROR_NONE* = 0
  GMP_ERROR_UNSUPPORTED_ARGUMENT* = 1
  GMP_ERROR_DIVISION_BY_ZERO* = 2
  GMP_ERROR_SQRT_OF_NEGATIVE* = 4
  GMP_ERROR_INVALID_ARGUMENT* = 8

when isMainModule: 
  var a = mpz_t()
  var b = mpz_t()
  var c = mpz_t()

  mpz_init(a)
  mpz_init(b)
  mpz_init(c)
  mpz_set_si(b,12)
  mpz_set_si(c,13)

  mpz_add(a,b,c)
  assert ($mpz_get_str(nil,10,a) == "25")
