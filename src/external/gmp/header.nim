#
# Nim GMP wrapper 
# (c) Copyright 2014 Will Szumski
#
# See the file "COPYING", included in this
# distribution, for details about the copyright.
#

#FIXME: other OSes need include path?
{.passl: "-lgmp".}

type 
  INNER_C_UNION_5532179898798000430* {.importc: "no_name", header: "<gmp.h>".} = object  {.
      union.}
    mp_lc* {.importc: "_mp_lc".}: pointer
  
  # should check limb sizes / import them directly?
  mp_limb_t* {.importc: "mp_limb_t", nodecl.} = uint
  mp_limb_signed_t* {.importc: "mp_limb_signed_t", nodecl.} = int
  mp_bitcnt_t* {.importc: "mp_bitcnt_t", nodecl.} = culong
  mm_mpz_struct* {.byref, importc: "__mpz_struct", header: "<gmp.h>".} = object 
    mp_alloc* {.importc: "_mp_alloc".}: cint
    mp_size* {.importc: "_mp_size".}: cint
    mp_d* {.importc: "_mp_d".}: ptr mp_limb_t

  MP_INT* = mm_mpz_struct
  #mpz_t* = array[1, mm_mpz_struct]
  mpz_t* = mm_mpz_struct
  mp_ptr* = ptr mp_limb_t
  mp_srcptr* = ptr mp_limb_t
  mp_size_t* {.importc: "mp_size_t", nodecl.} = clong
  mp_exp_t* {.importc: "mp_exp_t", nodecl.} = clong
  mm_mpq_struct* {.byref, importc: "__mpq_struct", header: "<gmp.h>".} = object 
    mp_num* {.importc: "_mp_num".}: mm_mpz_struct
    mp_den* {.importc: "_mp_den".}: mm_mpz_struct

  MP_RAT* = mm_mpq_struct
  #mpq_t* = array[1, mm_mpq_struct]
  mpq_t* = mm_mpq_struct
  mm_mpf_struct* {.byref, importc: "__mpf_struct", header: "<gmp.h>".} = object 
    mp_prec* {.importc: "_mp_prec".}: cint
    mp_size* {.importc: "_mp_size".}: cint
    mp_exp* {.importc: "_mp_exp".}: mp_exp_t
    mp_d* {.importc: "_mp_d".}: ptr mp_limb_t

  #mpf_t* = array[1, mm_mpf_struct]
  mpf_t* = mm_mpf_struct
  gmp_randalg_t* = distinct cint
  mm_gmp_randstate_struct* {.importc: "__gmp_randstate_struct", header: "<gmp.h>".} = object 
    mp_seed* {.importc: "_mp_seed".}: mpz_t
    mp_alg* {.importc: "_mp_alg".}: gmp_randalg_t
    mp_algdata* {.importc: "_mp_algdata".}: INNER_C_UNION_5532179898798000430

  #gmp_randstate_t* = array[1, mm_gmp_randstate_struct]
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

proc mpq_numref*(a2: mpq_ptr): mpz_ptr {.importc: "mpq_numref",
    header: "<gmp.h>".}
proc mpq_numref*(a2: var mpq_t): mpz_ptr {.importc: "mpq_numref",
    header: "<gmp.h>".}
proc mpq_denref*(a2: mpq_ptr): mpz_ptr {.importc: "mpq_denref",
    header: "<gmp.h>".}
proc mpq_denref*(a2: var mpq_t): mpz_ptr {.importc: "mpq_denref",
    header: "<gmp.h>".}
proc mp_set_memory_functions*(a2: proc (a2: csize): pointer; a3: proc (
    a2: pointer; a3: csize; a4: csize): pointer; 
                              a4: proc (a2: pointer; a3: csize)) {.
    importc: "mp_set_memory_functions", header: "<gmp.h>".}
proc mp_get_memory_functions*(a2: proc (a2: csize): pointer; a3: proc (
    a2: pointer; a3: csize; a4: csize): pointer; 
                              a4: proc (a2: pointer; a3: csize)) {.
    importc: "mp_get_memory_functions", header: "<gmp.h>".}
var mp_bits_per_limb* {.importc: "mp_bits_per_limb", header: "<gmp.h>".}: cint
var gmp_errno* {.importc: "gmp_errno", header: "<gmp.h>".}: cint
var gmp_version* {.importc: "gmp_version", header: "<gmp.h>".}: cstring
proc gmp_randinit*(a2: gmp_randstate_t; a3: gmp_randalg_t) {.varargs, 
    importc: "gmp_randinit", header: "<gmp.h>".}
proc gmp_randinit_default*(a2: gmp_randstate_t) {.
    importc: "gmp_randinit_default", header: "<gmp.h>".}
proc gmp_randinit_lc_2exp*(a2: gmp_randstate_t; a3: mpz_srcptr; a4: culong; 
                           a5: mp_bitcnt_t) {.importc: "gmp_randinit_lc_2exp", 
    header: "<gmp.h>".}
proc gmp_randinit_lc_2exp*(a2: gmp_randstate_t; a3: mpz_t; a4: culong; 
                           a5: mp_bitcnt_t) {.importc: "gmp_randinit_lc_2exp", 
    header: "<gmp.h>".}
proc gmp_randinit_lc_2exp_size*(a2: gmp_randstate_t; a3: mp_bitcnt_t): cint {.
    importc: "gmp_randinit_lc_2exp_size", header: "<gmp.h>".}
proc gmp_randinit_mt*(a2: gmp_randstate_t) {.importc: "gmp_randinit_mt", 
    header: "<gmp.h>".}
proc gmp_randinit_set*(a2: gmp_randstate_t; a3: ptr mm_gmp_randstate_struct) {.
    importc: "gmp_randinit_set", header: "<gmp.h>".}
proc gmp_randseed*(a2: gmp_randstate_t; a3: mpz_srcptr) {.
    importc: "gmp_randseed", header: "<gmp.h>".}
proc gmp_randseed*(a2: gmp_randstate_t; a3: mpz_t) {.importc: "gmp_randseed", 
    header: "<gmp.h>".}
proc gmp_randseed_ui*(a2: gmp_randstate_t; a3: culong) {.
    importc: "gmp_randseed_ui", header: "<gmp.h>".}
proc gmp_randclear*(a2: gmp_randstate_t) {.importc: "gmp_randclear", 
    header: "<gmp.h>".}
proc gmp_urandomb_ui*(a2: gmp_randstate_t; a3: culong): culong {.
    importc: "gmp_urandomb_ui", header: "<gmp.h>".}
proc gmp_urandomm_ui*(a2: gmp_randstate_t; a3: culong): culong {.
    importc: "gmp_urandomm_ui", header: "<gmp.h>".}
proc gmp_asprintf*(a2: cstringArray; a3: cstring): cint {.varargs, 
    importc: "gmp_asprintf", header: "<gmp.h>".}
proc gmp_fprintf*(a2: File; a3: cstring): cint {.varargs, 
    importc: "gmp_fprintf", header: "<gmp.h>".}
proc gmp_printf*(a2: cstring): cint {.varargs, importc: "gmp_printf", 
                                      header: "<gmp.h>".}
proc gmp_snprintf*(a2: cstring; a3: csize; a4: cstring): cint {.varargs, 
    importc: "gmp_snprintf", header: "<gmp.h>".}
proc gmp_sprintf*(a2: cstring; a3: cstring): cint {.varargs, 
    importc: "gmp_sprintf", header: "<gmp.h>".}
proc gmp_fscanf*(a2: File; a3: cstring): cint {.varargs, 
    importc: "gmp_fscanf", header: "<gmp.h>".}
proc gmp_scanf*(a2: cstring): cint {.varargs, importc: "gmp_scanf", 
                                     header: "<gmp.h>".}
proc gmp_sscanf*(a2: cstring; a3: cstring): cint {.varargs, 
    importc: "gmp_sscanf", header: "<gmp.h>".}
proc m_mpz_realloc*(a2: mpz_ptr; a3: mp_size_t): pointer {.
    importc: "_mpz_realloc", header: "<gmp.h>".}
proc m_mpz_realloc*(a2: var mpz_t; a3: mp_size_t): pointer {.
    importc: "_mpz_realloc", header: "<gmp.h>".}
proc mpz_add*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_add", 
    header: "<gmp.h>".}
proc mpz_add*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_add", 
    header: "<gmp.h>".}
proc mpz_add_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.
    importc: "mpz_add_ui", header: "<gmp.h>".}
proc mpz_add_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc: "mpz_add_ui", 
    header: "<gmp.h>".}
proc mpz_addmul*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "mpz_addmul", header: "<gmp.h>".}
proc mpz_addmul*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_addmul", 
    header: "<gmp.h>".}
proc mpz_addmul_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.
    importc: "mpz_addmul_ui", header: "<gmp.h>".}
proc mpz_addmul_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.
    importc: "mpz_addmul_ui", header: "<gmp.h>".}
proc mpz_and*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_and", 
    header: "<gmp.h>".}
proc mpz_and*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_and", 
    header: "<gmp.h>".}
proc mpz_array_init*(a2: mpz_ptr; a3: mp_size_t; a4: mp_size_t) {.
    importc: "mpz_array_init", header: "<gmp.h>".}
proc mpz_array_init*(a2: var mpz_t; a3: mp_size_t; a4: mp_size_t) {.
    importc: "mpz_array_init", header: "<gmp.h>".}
proc mpz_bin_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.
    importc: "mpz_bin_ui", header: "<gmp.h>".}
proc mpz_bin_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc: "mpz_bin_ui", 
    header: "<gmp.h>".}
proc mpz_bin_uiui*(a2: mpz_ptr; a3: culong; a4: culong) {.
    importc: "mpz_bin_uiui", header: "<gmp.h>".}
proc mpz_bin_uiui*(a2: var mpz_t; a3: culong; a4: culong) {.
    importc: "mpz_bin_uiui", header: "<gmp.h>".}
proc mpz_cdiv_q*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "mpz_cdiv_q", header: "<gmp.h>".}
proc mpz_cdiv_q*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_cdiv_q", 
    header: "<gmp.h>".}
proc mpz_cdiv_q_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.
    importc: "mpz_cdiv_q_2exp", header: "<gmp.h>".}
proc mpz_cdiv_q_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.
    importc: "mpz_cdiv_q_2exp", header: "<gmp.h>".}
proc mpz_cdiv_q_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.
    importc: "mpz_cdiv_q_ui", header: "<gmp.h>".}
proc mpz_cdiv_q_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.
    importc: "mpz_cdiv_q_ui", header: "<gmp.h>".}
proc mpz_cdiv_qr*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: mpz_srcptr) {.
    importc: "mpz_cdiv_qr", header: "<gmp.h>".}
proc mpz_cdiv_qr*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: mpz_t) {.
    importc: "mpz_cdiv_qr", header: "<gmp.h>".}
proc mpz_cdiv_qr_ui*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: culong): culong {.
    importc: "mpz_cdiv_qr_ui", header: "<gmp.h>".}
proc mpz_cdiv_qr_ui*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: culong): culong {.
    importc: "mpz_cdiv_qr_ui", header: "<gmp.h>".}
proc mpz_cdiv_r*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "mpz_cdiv_r", header: "<gmp.h>".}
proc mpz_cdiv_r*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_cdiv_r", 
    header: "<gmp.h>".}
proc mpz_cdiv_r_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.
    importc: "mpz_cdiv_r_2exp", header: "<gmp.h>".}
proc mpz_cdiv_r_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.
    importc: "mpz_cdiv_r_2exp", header: "<gmp.h>".}
proc mpz_cdiv_r_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.
    importc: "mpz_cdiv_r_ui", header: "<gmp.h>".}
proc mpz_cdiv_r_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.
    importc: "mpz_cdiv_r_ui", header: "<gmp.h>".}
proc mpz_cdiv_ui*(a2: mpz_srcptr; a3: culong): culong {.importc: "mpz_cdiv_ui", 
    header: "<gmp.h>".}
proc mpz_cdiv_ui*(a2: mpz_t; a3: culong): culong {.importc: "mpz_cdiv_ui", 
    header: "<gmp.h>".}
proc mpz_clear*(a2: mpz_ptr) {.importc: "mpz_clear", header: "<gmp.h>".}
proc mpz_clear*(a2: var mpz_t) {.importc: "mpz_clear", header: "<gmp.h>".}
proc mpz_clears*(a2: mpz_ptr) {.varargs, importc: "mpz_clears", 
                                header: "<gmp.h>".}
proc mpz_clears*(a2: var mpz_t) {.varargs, importc: "mpz_clears", 
                                  header: "<gmp.h>".}
proc mpz_clrbit*(a2: mpz_ptr; a3: mp_bitcnt_t) {.importc: "mpz_clrbit", 
    header: "<gmp.h>".}
proc mpz_clrbit*(a2: var mpz_t; a3: mp_bitcnt_t) {.importc: "mpz_clrbit", 
    header: "<gmp.h>".}
proc mpz_cmp*(a2: mpz_srcptr; a3: mpz_srcptr): cint {.importc: "mpz_cmp", 
    header: "<gmp.h>".}
proc mpz_cmp*(a2: mpz_t; a3: mpz_t): cint {.importc: "mpz_cmp", 
    header: "<gmp.h>".}
proc mpz_cmp_d*(a2: mpz_srcptr; a3: cdouble): cint {.importc: "mpz_cmp_d", 
    header: "<gmp.h>".}
proc mpz_cmp_d*(a2: mpz_t; a3: cdouble): cint {.importc: "mpz_cmp_d", 
    header: "<gmp.h>".}
proc mpz_cmp_si*(a2: mpz_srcptr; a3: clong): cint {.importc: "_mpz_cmp_si", 
    header: "<gmp.h>".}
proc mpz_cmp_si*(a2: mpz_t; a3: clong): cint {.importc: "_mpz_cmp_si", 
    header: "<gmp.h>".}
proc mpz_cmp_ui*(a2: mpz_srcptr; a3: culong): cint {.importc: "_mpz_cmp_ui", 
    header: "<gmp.h>".}
proc mpz_cmp_ui*(a2: mpz_t; a3: culong): cint {.importc: "_mpz_cmp_ui", 
    header: "<gmp.h>".}
proc mpz_cmpabs*(a2: mpz_srcptr; a3: mpz_srcptr): cint {.importc: "mpz_cmpabs", 
    header: "<gmp.h>".}
proc mpz_cmpabs*(a2: mpz_t; a3: mpz_t): cint {.importc: "mpz_cmpabs", 
    header: "<gmp.h>".}
proc mpz_cmpabs_d*(a2: mpz_srcptr; a3: cdouble): cint {.importc: "mpz_cmpabs_d", 
    header: "<gmp.h>".}
proc mpz_cmpabs_d*(a2: mpz_t; a3: cdouble): cint {.importc: "mpz_cmpabs_d", 
    header: "<gmp.h>".}
proc mpz_cmpabs_ui*(a2: mpz_srcptr; a3: culong): cint {.
    importc: "mpz_cmpabs_ui", header: "<gmp.h>".}
proc mpz_cmpabs_ui*(a2: mpz_t; a3: culong): cint {.importc: "mpz_cmpabs_ui", 
    header: "<gmp.h>".}
proc mpz_com*(a2: mpz_ptr; a3: mpz_srcptr) {.importc: "mpz_com", 
    header: "<gmp.h>".}
proc mpz_com*(a2: var mpz_t; a3: mpz_t) {.importc: "mpz_com", header: "<gmp.h>".}
proc mpz_combit*(a2: mpz_ptr; a3: mp_bitcnt_t) {.importc: "mpz_combit", 
    header: "<gmp.h>".}
proc mpz_combit*(a2: var mpz_t; a3: mp_bitcnt_t) {.importc: "mpz_combit", 
    header: "<gmp.h>".}
proc mpz_congruent_p*(a2: mpz_srcptr; a3: mpz_srcptr; a4: mpz_srcptr): cint {.
    importc: "mpz_congruent_p", header: "<gmp.h>".}
proc mpz_congruent_p*(a2: mpz_t; a3: mpz_t; a4: mpz_t): cint {.
    importc: "mpz_congruent_p", header: "<gmp.h>".}
proc mpz_congruent_2exp_p*(a2: mpz_srcptr; a3: mpz_srcptr; a4: mp_bitcnt_t): cint {.
    importc: "mpz_congruent_2exp_p", header: "<gmp.h>".}
proc mpz_congruent_2exp_p*(a2: mpz_t; a3: mpz_t; a4: mp_bitcnt_t): cint {.
    importc: "mpz_congruent_2exp_p", header: "<gmp.h>".}
proc mpz_congruent_ui_p*(a2: mpz_srcptr; a3: culong; a4: culong): cint {.
    importc: "mpz_congruent_ui_p", header: "<gmp.h>".}
proc mpz_congruent_ui_p*(a2: mpz_t; a3: culong; a4: culong): cint {.
    importc: "mpz_congruent_ui_p", header: "<gmp.h>".}
proc mpz_divexact*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "mpz_divexact", header: "<gmp.h>".}
proc mpz_divexact*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.
    importc: "mpz_divexact", header: "<gmp.h>".}
proc mpz_divexact_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.
    importc: "mpz_divexact_ui", header: "<gmp.h>".}
proc mpz_divexact_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.
    importc: "mpz_divexact_ui", header: "<gmp.h>".}
proc mpz_divisible_p*(a2: mpz_srcptr; a3: mpz_srcptr): cint {.
    importc: "mpz_divisible_p", header: "<gmp.h>".}
proc mpz_divisible_p*(a2: mpz_t; a3: mpz_t): cint {.importc: "mpz_divisible_p", 
    header: "<gmp.h>".}
proc mpz_divisible_ui_p*(a2: mpz_srcptr; a3: culong): cint {.
    importc: "mpz_divisible_ui_p", header: "<gmp.h>".}
proc mpz_divisible_ui_p*(a2: mpz_t; a3: culong): cint {.
    importc: "mpz_divisible_ui_p", header: "<gmp.h>".}
proc mpz_divisible_2exp_p*(a2: mpz_srcptr; a3: mp_bitcnt_t): cint {.
    importc: "mpz_divisible_2exp_p", header: "<gmp.h>".}
proc mpz_divisible_2exp_p*(a2: mpz_t; a3: mp_bitcnt_t): cint {.
    importc: "mpz_divisible_2exp_p", header: "<gmp.h>".}
proc mpz_dump*(a2: mpz_srcptr) {.importc: "mpz_dump", header: "<gmp.h>".}
proc mpz_dump*(a2: mpz_t) {.importc: "mpz_dump", header: "<gmp.h>".}
proc mpz_export*(a2: pointer; a3: ptr csize; a4: cint; a5: csize; a6: cint; 
                 a7: csize; a8: mpz_srcptr): pointer {.importc: "mpz_export", 
    header: "<gmp.h>".}
proc mpz_export*(a2: pointer; a3: ptr csize; a4: cint; a5: csize; a6: cint; 
                 a7: csize; a8: mpz_t): pointer {.importc: "mpz_export", 
    header: "<gmp.h>".}
proc mpz_fac_ui*(a2: mpz_ptr; a3: culong) {.importc: "mpz_fac_ui", 
    header: "<gmp.h>".}
proc mpz_fac_ui*(a2: var mpz_t; a3: culong) {.importc: "mpz_fac_ui", 
    header: "<gmp.h>".}
proc mpz_2fac_ui*(a2: mpz_ptr; a3: culong) {.importc: "mpz_2fac_ui", 
    header: "<gmp.h>".}
proc mpz_2fac_ui*(a2: var mpz_t; a3: culong) {.importc: "mpz_2fac_ui", 
    header: "<gmp.h>".}
proc mpz_mfac_uiui*(a2: mpz_ptr; a3: culong; a4: culong) {.
    importc: "mpz_mfac_uiui", header: "<gmp.h>".}
proc mpz_mfac_uiui*(a2: var mpz_t; a3: culong; a4: culong) {.
    importc: "mpz_mfac_uiui", header: "<gmp.h>".}
proc mpz_primorial_ui*(a2: mpz_ptr; a3: culong) {.importc: "mpz_primorial_ui", 
    header: "<gmp.h>".}
proc mpz_primorial_ui*(a2: var mpz_t; a3: culong) {.importc: "mpz_primorial_ui", 
    header: "<gmp.h>".}
proc mpz_fdiv_q*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "mpz_fdiv_q", header: "<gmp.h>".}
proc mpz_fdiv_q*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_fdiv_q", 
    header: "<gmp.h>".}
proc mpz_fdiv_q_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.
    importc: "mpz_fdiv_q_2exp", header: "<gmp.h>".}
proc mpz_fdiv_q_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.
    importc: "mpz_fdiv_q_2exp", header: "<gmp.h>".}
proc mpz_fdiv_q_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.
    importc: "mpz_fdiv_q_ui", header: "<gmp.h>".}
proc mpz_fdiv_q_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.
    importc: "mpz_fdiv_q_ui", header: "<gmp.h>".}
proc mpz_fdiv_qr*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: mpz_srcptr) {.
    importc: "mpz_fdiv_qr", header: "<gmp.h>".}
proc mpz_fdiv_qr*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: mpz_t) {.
    importc: "mpz_fdiv_qr", header: "<gmp.h>".}
proc mpz_fdiv_qr_ui*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: culong): culong {.
    importc: "mpz_fdiv_qr_ui", header: "<gmp.h>".}
proc mpz_fdiv_qr_ui*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: culong): culong {.
    importc: "mpz_fdiv_qr_ui", header: "<gmp.h>".}
proc mpz_fdiv_r*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "mpz_fdiv_r", header: "<gmp.h>".}
proc mpz_fdiv_r*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_fdiv_r", 
    header: "<gmp.h>".}
proc mpz_fdiv_r_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.
    importc: "mpz_fdiv_r_2exp", header: "<gmp.h>".}
proc mpz_fdiv_r_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.
    importc: "mpz_fdiv_r_2exp", header: "<gmp.h>".}
proc mpz_fdiv_r_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.
    importc: "mpz_fdiv_r_ui", header: "<gmp.h>".}
proc mpz_fdiv_r_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.
    importc: "mpz_fdiv_r_ui", header: "<gmp.h>".}
proc mpz_fdiv_ui*(a2: mpz_srcptr; a3: culong): culong {.importc: "mpz_fdiv_ui", 
    header: "<gmp.h>".}
proc mpz_fdiv_ui*(a2: mpz_t; a3: culong): culong {.importc: "mpz_fdiv_ui", 
    header: "<gmp.h>".}
proc mpz_fib_ui*(a2: mpz_ptr; a3: culong) {.importc: "mpz_fib_ui", 
    header: "<gmp.h>".}
proc mpz_fib_ui*(a2: var mpz_t; a3: culong) {.importc: "mpz_fib_ui", 
    header: "<gmp.h>".}
proc mpz_fib2_ui*(a2: mpz_ptr; a3: mpz_ptr; a4: culong) {.
    importc: "mpz_fib2_ui", header: "<gmp.h>".}
proc mpz_fib2_ui*(a2: var mpz_t; a3: var mpz_t; a4: culong) {.
    importc: "mpz_fib2_ui", header: "<gmp.h>".}
proc mpz_fits_sint_p*(a2: mpz_srcptr): cint {.importc: "mpz_fits_sint_p", 
    header: "<gmp.h>".}
proc mpz_fits_sint_p*(a2: mpz_t): cint {.importc: "mpz_fits_sint_p", 
    header: "<gmp.h>".}
proc mpz_fits_slong_p*(a2: mpz_srcptr): cint {.importc: "mpz_fits_slong_p", 
    header: "<gmp.h>".}
proc mpz_fits_slong_p*(a2: mpz_t): cint {.importc: "mpz_fits_slong_p", 
    header: "<gmp.h>".}
proc mpz_fits_sshort_p*(a2: mpz_srcptr): cint {.importc: "mpz_fits_sshort_p", 
    header: "<gmp.h>".}
proc mpz_fits_sshort_p*(a2: mpz_t): cint {.importc: "mpz_fits_sshort_p", 
    header: "<gmp.h>".}
proc mpz_gcd*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_gcd", 
    header: "<gmp.h>".}
proc mpz_gcd*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_gcd", 
    header: "<gmp.h>".}
proc mpz_gcd_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.
    importc: "mpz_gcd_ui", header: "<gmp.h>".}
proc mpz_gcd_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.
    importc: "mpz_gcd_ui", header: "<gmp.h>".}
proc mpz_gcdext*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_ptr; a5: mpz_srcptr; 
                 a6: mpz_srcptr) {.importc: "mpz_gcdext", header: "<gmp.h>".}
proc mpz_gcdext*(a2: var mpz_t; a3: var mpz_t; a4: var mpz_t; a5: mpz_t; 
                 a6: mpz_t) {.importc: "mpz_gcdext", header: "<gmp.h>".}
proc mpz_get_d*(a2: mpz_srcptr): cdouble {.importc: "mpz_get_d", 
    header: "<gmp.h>".}
proc mpz_get_d*(a2: mpz_t): cdouble {.importc: "mpz_get_d", header: "<gmp.h>".}
proc mpz_get_d_2exp*(a2: ptr clong; a3: mpz_srcptr): cdouble {.
    importc: "mpz_get_d_2exp", header: "<gmp.h>".}
proc mpz_get_d_2exp*(a2: ptr clong; a3: mpz_t): cdouble {.
    importc: "mpz_get_d_2exp", header: "<gmp.h>".}
proc mpz_get_si*(a2: mpz_srcptr): clong {.importc: "mpz_get_si", 
    header: "<gmp.h>".}
proc mpz_get_si*(a2: mpz_t): clong {.importc: "mpz_get_si", header: "<gmp.h>".}
proc mpz_get_str*(a2: cstring; a3: cint; a4: mpz_srcptr): cstring {.
    importc: "mpz_get_str", header: "<gmp.h>".}
proc mpz_get_str*(a2: cstring; a3: cint; a4: mpz_t): cstring {.
    importc: "mpz_get_str", header: "<gmp.h>".}
proc mpz_hamdist*(a2: mpz_srcptr; a3: mpz_srcptr): mp_bitcnt_t {.
    importc: "mpz_hamdist", header: "<gmp.h>".}
proc mpz_hamdist*(a2: mpz_t; a3: mpz_t): mp_bitcnt_t {.importc: "mpz_hamdist", 
    header: "<gmp.h>".}
proc mpz_import*(a2: mpz_ptr; a3: csize; a4: cint; a5: csize; a6: cint; 
                 a7: csize; a8: pointer) {.importc: "mpz_import", 
    header: "<gmp.h>".}
proc mpz_import*(a2: var mpz_t; a3: csize; a4: cint; a5: csize; a6: cint; 
                 a7: csize; a8: pointer) {.importc: "mpz_import", 
    header: "<gmp.h>".}
proc mpz_init*(a2: mpz_ptr) {.importc: "mpz_init", header: "<gmp.h>".}
proc mpz_init*(a2: var mpz_t) {.importc: "mpz_init", header: "<gmp.h>".}
proc mpz_init2*(a2: mpz_ptr; a3: mp_bitcnt_t) {.importc: "mpz_init2", 
    header: "<gmp.h>".}
proc mpz_init2*(a2: var mpz_t; a3: mp_bitcnt_t) {.importc: "mpz_init2", 
    header: "<gmp.h>".}
proc mpz_inits*(a2: mpz_ptr) {.varargs, importc: "mpz_inits", header: "<gmp.h>".}
proc mpz_inits*(a2: var mpz_t) {.varargs, importc: "mpz_inits", 
                                 header: "<gmp.h>".}
proc mpz_init_set*(a2: mpz_ptr; a3: mpz_srcptr) {.importc: "mpz_init_set", 
    header: "<gmp.h>".}
proc mpz_init_set*(a2: var mpz_t; a3: mpz_t) {.importc: "mpz_init_set", 
    header: "<gmp.h>".}
proc mpz_init_set_d*(a2: mpz_ptr; a3: cdouble) {.importc: "mpz_init_set_d", 
    header: "<gmp.h>".}
proc mpz_init_set_d*(a2: var mpz_t; a3: cdouble) {.importc: "mpz_init_set_d", 
    header: "<gmp.h>".}
proc mpz_init_set_si*(a2: mpz_ptr; a3: clong) {.importc: "mpz_init_set_si", 
    header: "<gmp.h>".}
proc mpz_init_set_si*(a2: var mpz_t; a3: clong) {.importc: "mpz_init_set_si", 
    header: "<gmp.h>".}
proc mpz_init_set_str*(a2: mpz_ptr; a3: cstring; a4: cint): cint {.
    importc: "mpz_init_set_str", header: "<gmp.h>".}
proc mpz_init_set_str*(a2: var mpz_t; a3: cstring; a4: cint): cint {.
    importc: "mpz_init_set_str", header: "<gmp.h>".}
proc mpz_init_set_ui*(a2: mpz_ptr; a3: culong) {.importc: "mpz_init_set_ui", 
    header: "<gmp.h>".}
proc mpz_init_set_ui*(a2: var mpz_t; a3: culong) {.importc: "mpz_init_set_ui", 
    header: "<gmp.h>".}
proc mpz_inp_raw*(a2: mpz_ptr; a3: File): csize {.importc: "mpz_inp_raw", 
    header: "<gmp.h>".}
proc mpz_inp_raw*(a2: var mpz_t; a3: File): csize {.importc: "mpz_inp_raw", 
    header: "<gmp.h>".}
proc mpz_inp_str*(a2: mpz_ptr; a3: File; a4: cint): csize {.
    importc: "mpz_inp_str", header: "<gmp.h>".}
proc mpz_inp_str*(a2: var mpz_t; a3: File; a4: cint): csize {.
    importc: "mpz_inp_str", header: "<gmp.h>".}
proc mpz_invert*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr): cint {.
    importc: "mpz_invert", header: "<gmp.h>".}
proc mpz_invert*(a2: var mpz_t; a3: mpz_t; a4: mpz_t): cint {.
    importc: "mpz_invert", header: "<gmp.h>".}
proc mpz_ior*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_ior", 
    header: "<gmp.h>".}
proc mpz_ior*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_ior", 
    header: "<gmp.h>".}
proc mpz_jacobi*(a2: mpz_srcptr; a3: mpz_srcptr): cint {.importc: "mpz_jacobi", 
    header: "<gmp.h>".}
proc mpz_jacobi*(a2: mpz_t; a3: mpz_t): cint {.importc: "mpz_jacobi", 
    header: "<gmp.h>".}
proc mpz_kronecker_si*(a2: mpz_srcptr; a3: clong): cint {.
    importc: "mpz_kronecker_si", header: "<gmp.h>".}
proc mpz_kronecker_si*(a2: mpz_t; a3: clong): cint {.
    importc: "mpz_kronecker_si", header: "<gmp.h>".}
proc mpz_kronecker_ui*(a2: mpz_srcptr; a3: culong): cint {.
    importc: "mpz_kronecker_ui", header: "<gmp.h>".}
proc mpz_kronecker_ui*(a2: mpz_t; a3: culong): cint {.
    importc: "mpz_kronecker_ui", header: "<gmp.h>".}
proc mpz_si_kronecker*(a2: clong; a3: mpz_srcptr): cint {.
    importc: "mpz_si_kronecker", header: "<gmp.h>".}
proc mpz_si_kronecker*(a2: clong; a3: mpz_t): cint {.
    importc: "mpz_si_kronecker", header: "<gmp.h>".}
proc mpz_ui_kronecker*(a2: culong; a3: mpz_srcptr): cint {.
    importc: "mpz_ui_kronecker", header: "<gmp.h>".}
proc mpz_ui_kronecker*(a2: culong; a3: mpz_t): cint {.
    importc: "mpz_ui_kronecker", header: "<gmp.h>".}
proc mpz_lcm*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_lcm", 
    header: "<gmp.h>".}
proc mpz_lcm*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_lcm", 
    header: "<gmp.h>".}
proc mpz_lcm_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.
    importc: "mpz_lcm_ui", header: "<gmp.h>".}
proc mpz_lcm_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc: "mpz_lcm_ui", 
    header: "<gmp.h>".}
proc mpz_lucnum_ui*(a2: mpz_ptr; a3: culong) {.importc: "mpz_lucnum_ui", 
    header: "<gmp.h>".}
proc mpz_lucnum_ui*(a2: var mpz_t; a3: culong) {.importc: "mpz_lucnum_ui", 
    header: "<gmp.h>".}
proc mpz_lucnum2_ui*(a2: mpz_ptr; a3: mpz_ptr; a4: culong) {.
    importc: "mpz_lucnum2_ui", header: "<gmp.h>".}
proc mpz_lucnum2_ui*(a2: var mpz_t; a3: var mpz_t; a4: culong) {.
    importc: "mpz_lucnum2_ui", header: "<gmp.h>".}
proc mpz_millerrabin*(a2: mpz_srcptr; a3: cint): cint {.
    importc: "mpz_millerrabin", header: "<gmp.h>".}
proc mpz_millerrabin*(a2: mpz_t; a3: cint): cint {.importc: "mpz_millerrabin", 
    header: "<gmp.h>".}
proc mpz_mod*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_mod", 
    header: "<gmp.h>".}
proc mpz_mod*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_mod", 
    header: "<gmp.h>".}
proc mpz_mul*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_mul", 
    header: "<gmp.h>".}
proc mpz_mul*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_mul", 
    header: "<gmp.h>".}
proc mpz_mul_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.
    importc: "mpz_mul_2exp", header: "<gmp.h>".}
proc mpz_mul_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.
    importc: "mpz_mul_2exp", header: "<gmp.h>".}
proc mpz_mul_si*(a2: mpz_ptr; a3: mpz_srcptr; a4: clong) {.
    importc: "mpz_mul_si", header: "<gmp.h>".}
proc mpz_mul_si*(a2: var mpz_t; a3: mpz_t; a4: clong) {.importc: "mpz_mul_si", 
    header: "<gmp.h>".}
proc mpz_mul_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.
    importc: "mpz_mul_ui", header: "<gmp.h>".}
proc mpz_mul_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc: "mpz_mul_ui", 
    header: "<gmp.h>".}
proc mpz_nextprime*(a2: mpz_ptr; a3: mpz_srcptr) {.importc: "mpz_nextprime", 
    header: "<gmp.h>".}
proc mpz_nextprime*(a2: var mpz_t; a3: mpz_t) {.importc: "mpz_nextprime", 
    header: "<gmp.h>".}
proc mpz_out_raw*(a2: File; a3: mpz_srcptr): csize {.importc: "mpz_out_raw", 
    header: "<gmp.h>".}
proc mpz_out_raw*(a2: File; a3: mpz_t): csize {.importc: "mpz_out_raw", 
    header: "<gmp.h>".}
proc mpz_out_str*(a2: File; a3: cint; a4: mpz_srcptr): csize {.
    importc: "mpz_out_str", header: "<gmp.h>".}
proc mpz_out_str*(a2: File; a3: cint; a4: mpz_t): csize {.
    importc: "mpz_out_str", header: "<gmp.h>".}
proc mpz_perfect_power_p*(a2: mpz_srcptr): cint {.
    importc: "mpz_perfect_power_p", header: "<gmp.h>".}
proc mpz_perfect_power_p*(a2: mpz_t): cint {.importc: "mpz_perfect_power_p", 
    header: "<gmp.h>".}
proc mpz_pow_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.
    importc: "mpz_pow_ui", header: "<gmp.h>".}
proc mpz_pow_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc: "mpz_pow_ui", 
    header: "<gmp.h>".}
proc mpz_powm*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr; a5: mpz_srcptr) {.
    importc: "mpz_powm", header: "<gmp.h>".}
proc mpz_powm*(a2: var mpz_t; a3: mpz_t; a4: mpz_t; a5: mpz_t) {.
    importc: "mpz_powm", header: "<gmp.h>".}
proc mpz_powm_sec*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr; a5: mpz_srcptr) {.
    importc: "mpz_powm_sec", header: "<gmp.h>".}
proc mpz_powm_sec*(a2: var mpz_t; a3: mpz_t; a4: mpz_t; a5: mpz_t) {.
    importc: "mpz_powm_sec", header: "<gmp.h>".}
proc mpz_powm_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong; a5: mpz_srcptr) {.
    importc: "mpz_powm_ui", header: "<gmp.h>".}
proc mpz_powm_ui*(a2: var mpz_t; a3: mpz_t; a4: culong; a5: mpz_t) {.
    importc: "mpz_powm_ui", header: "<gmp.h>".}
proc mpz_probab_prime_p*(a2: mpz_srcptr; a3: cint): cint {.
    importc: "mpz_probab_prime_p", header: "<gmp.h>".}
proc mpz_probab_prime_p*(a2: mpz_t; a3: cint): cint {.
    importc: "mpz_probab_prime_p", header: "<gmp.h>".}
proc mpz_random*(a2: mpz_ptr; a3: mp_size_t) {.importc: "mpz_random", 
    header: "<gmp.h>".}
proc mpz_random*(a2: var mpz_t; a3: mp_size_t) {.importc: "mpz_random", 
    header: "<gmp.h>".}
proc mpz_random2*(a2: mpz_ptr; a3: mp_size_t) {.importc: "mpz_random2", 
    header: "<gmp.h>".}
proc mpz_random2*(a2: var mpz_t; a3: mp_size_t) {.importc: "mpz_random2", 
    header: "<gmp.h>".}
proc mpz_realloc2*(a2: mpz_ptr; a3: mp_bitcnt_t) {.importc: "mpz_realloc2", 
    header: "<gmp.h>".}
proc mpz_realloc2*(a2: var mpz_t; a3: mp_bitcnt_t) {.importc: "mpz_realloc2", 
    header: "<gmp.h>".}
proc mpz_remove*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr): mp_bitcnt_t {.
    importc: "mpz_remove", header: "<gmp.h>".}
proc mpz_remove*(a2: var mpz_t; a3: mpz_t; a4: mpz_t): mp_bitcnt_t {.
    importc: "mpz_remove", header: "<gmp.h>".}
proc mpz_root*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): cint {.
    importc: "mpz_root", header: "<gmp.h>".}
proc mpz_root*(a2: var mpz_t; a3: mpz_t; a4: culong): cint {.
    importc: "mpz_root", header: "<gmp.h>".}
proc mpz_rootrem*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: culong) {.
    importc: "mpz_rootrem", header: "<gmp.h>".}
proc mpz_rootrem*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: culong) {.
    importc: "mpz_rootrem", header: "<gmp.h>".}
proc mpz_rrandomb*(a2: mpz_ptr; a3: gmp_randstate_t; a4: mp_bitcnt_t) {.
    importc: "mpz_rrandomb", header: "<gmp.h>".}
proc mpz_rrandomb*(a2: var mpz_t; a3: gmp_randstate_t; a4: mp_bitcnt_t) {.
    importc: "mpz_rrandomb", header: "<gmp.h>".}
proc mpz_scan0*(a2: mpz_srcptr; a3: mp_bitcnt_t): mp_bitcnt_t {.
    importc: "mpz_scan0", header: "<gmp.h>".}
proc mpz_scan0*(a2: mpz_t; a3: mp_bitcnt_t): mp_bitcnt_t {.importc: "mpz_scan0", 
    header: "<gmp.h>".}
proc mpz_scan1*(a2: mpz_srcptr; a3: mp_bitcnt_t): mp_bitcnt_t {.
    importc: "mpz_scan1", header: "<gmp.h>".}
proc mpz_scan1*(a2: mpz_t; a3: mp_bitcnt_t): mp_bitcnt_t {.importc: "mpz_scan1", 
    header: "<gmp.h>".}
proc mpz_set*(a2: mpz_ptr; a3: mpz_srcptr) {.importc: "mpz_set", 
    header: "<gmp.h>".}
proc mpz_set*(a2: var mpz_t; a3: mpz_t) {.importc: "mpz_set", header: "<gmp.h>".}
proc mpz_set_d*(a2: mpz_ptr; a3: cdouble) {.importc: "mpz_set_d", 
    header: "<gmp.h>".}
proc mpz_set_d*(a2: var mpz_t; a3: cdouble) {.importc: "mpz_set_d", 
    header: "<gmp.h>".}
proc mpz_set_f*(a2: mpz_ptr; a3: mpf_srcptr) {.importc: "mpz_set_f", 
    header: "<gmp.h>".}
proc mpz_set_f*(a2: var mpz_t; a3: mpf_t) {.importc: "mpz_set_f", 
    header: "<gmp.h>".}
proc mpz_set_si*(a2: mpz_ptr; a3: clong) {.importc: "mpz_set_si", 
    header: "<gmp.h>".}
proc mpz_set_si*(a2: var mpz_t; a3: clong) {.importc: "mpz_set_si", 
    header: "<gmp.h>".}
proc mpz_set_str*(a2: mpz_ptr; a3: cstring; a4: cint): cint {.
    importc: "mpz_set_str", header: "<gmp.h>".}
proc mpz_set_str*(a2: var mpz_t; a3: cstring; a4: cint): cint {.
    importc: "mpz_set_str", header: "<gmp.h>".}
proc mpz_set_ui*(a2: mpz_ptr; a3: culong) {.importc: "mpz_set_ui", 
    header: "<gmp.h>".}
proc mpz_set_ui*(a2: var mpz_t; a3: culong) {.importc: "mpz_set_ui", 
    header: "<gmp.h>".}
proc mpz_setbit*(a2: mpz_ptr; a3: mp_bitcnt_t) {.importc: "mpz_setbit", 
    header: "<gmp.h>".}
proc mpz_setbit*(a2: var mpz_t; a3: mp_bitcnt_t) {.importc: "mpz_setbit", 
    header: "<gmp.h>".}
proc mpz_sizeinbase*(a2: mpz_srcptr; a3: cint): csize {.
    importc: "mpz_sizeinbase", header: "<gmp.h>".}
proc mpz_sizeinbase*(a2: mpz_t; a3: cint): csize {.importc: "mpz_sizeinbase", 
    header: "<gmp.h>".}
proc mpz_sqrt*(a2: mpz_ptr; a3: mpz_srcptr) {.importc: "mpz_sqrt", 
    header: "<gmp.h>".}
proc mpz_sqrt*(a2: var mpz_t; a3: mpz_t) {.importc: "mpz_sqrt", 
    header: "<gmp.h>".}
proc mpz_sqrtrem*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr) {.
    importc: "mpz_sqrtrem", header: "<gmp.h>".}
proc mpz_sqrtrem*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t) {.
    importc: "mpz_sqrtrem", header: "<gmp.h>".}
proc mpz_sub*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_sub", 
    header: "<gmp.h>".}
proc mpz_sub*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_sub", 
    header: "<gmp.h>".}
proc mpz_sub_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.
    importc: "mpz_sub_ui", header: "<gmp.h>".}
proc mpz_sub_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc: "mpz_sub_ui", 
    header: "<gmp.h>".}
proc mpz_ui_sub*(a2: mpz_ptr; a3: culong; a4: mpz_srcptr) {.
    importc: "mpz_ui_sub", header: "<gmp.h>".}
proc mpz_ui_sub*(a2: var mpz_t; a3: culong; a4: mpz_t) {.importc: "mpz_ui_sub", 
    header: "<gmp.h>".}
proc mpz_submul*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "mpz_submul", header: "<gmp.h>".}
proc mpz_submul*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_submul", 
    header: "<gmp.h>".}
proc mpz_submul_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.
    importc: "mpz_submul_ui", header: "<gmp.h>".}
proc mpz_submul_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.
    importc: "mpz_submul_ui", header: "<gmp.h>".}
proc mpz_swap*(a2: mpz_ptr; a3: mpz_ptr) {.importc: "mpz_swap", 
    header: "<gmp.h>".}
proc mpz_swap*(a2: var mpz_t; a3: var mpz_t) {.importc: "mpz_swap", 
    header: "<gmp.h>".}
proc mpz_tdiv_ui*(a2: mpz_srcptr; a3: culong): culong {.importc: "mpz_tdiv_ui", 
    header: "<gmp.h>".}
proc mpz_tdiv_ui*(a2: mpz_t; a3: culong): culong {.importc: "mpz_tdiv_ui", 
    header: "<gmp.h>".}
proc mpz_tdiv_q*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "mpz_tdiv_q", header: "<gmp.h>".}
proc mpz_tdiv_q*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_tdiv_q", 
    header: "<gmp.h>".}
proc mpz_tdiv_q_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.
    importc: "mpz_tdiv_q_2exp", header: "<gmp.h>".}
proc mpz_tdiv_q_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.
    importc: "mpz_tdiv_q_2exp", header: "<gmp.h>".}
proc mpz_tdiv_q_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.
    importc: "mpz_tdiv_q_ui", header: "<gmp.h>".}
proc mpz_tdiv_q_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.
    importc: "mpz_tdiv_q_ui", header: "<gmp.h>".}
proc mpz_tdiv_qr*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: mpz_srcptr) {.
    importc: "mpz_tdiv_qr", header: "<gmp.h>".}
proc mpz_tdiv_qr*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: mpz_t) {.
    importc: "mpz_tdiv_qr", header: "<gmp.h>".}
proc mpz_tdiv_qr_ui*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: culong): culong {.
    importc: "mpz_tdiv_qr_ui", header: "<gmp.h>".}
proc mpz_tdiv_qr_ui*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: culong): culong {.
    importc: "mpz_tdiv_qr_ui", header: "<gmp.h>".}
proc mpz_tdiv_r*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.
    importc: "mpz_tdiv_r", header: "<gmp.h>".}
proc mpz_tdiv_r*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_tdiv_r", 
    header: "<gmp.h>".}
proc mpz_tdiv_r_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.
    importc: "mpz_tdiv_r_2exp", header: "<gmp.h>".}
proc mpz_tdiv_r_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.
    importc: "mpz_tdiv_r_2exp", header: "<gmp.h>".}
proc mpz_tdiv_r_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.
    importc: "mpz_tdiv_r_ui", header: "<gmp.h>".}
proc mpz_tdiv_r_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.
    importc: "mpz_tdiv_r_ui", header: "<gmp.h>".}
proc mpz_tstbit*(a2: mpz_srcptr; a3: mp_bitcnt_t): cint {.importc: "mpz_tstbit", 
    header: "<gmp.h>".}
proc mpz_tstbit*(a2: mpz_t; a3: mp_bitcnt_t): cint {.importc: "mpz_tstbit", 
    header: "<gmp.h>".}
proc mpz_ui_pow_ui*(a2: mpz_ptr; a3: culong; a4: culong) {.
    importc: "mpz_ui_pow_ui", header: "<gmp.h>".}
proc mpz_ui_pow_ui*(a2: var mpz_t; a3: culong; a4: culong) {.
    importc: "mpz_ui_pow_ui", header: "<gmp.h>".}
proc mpz_urandomb*(a2: mpz_ptr; a3: gmp_randstate_t; a4: mp_bitcnt_t) {.
    importc: "mpz_urandomb", header: "<gmp.h>".}
proc mpz_urandomb*(a2: var mpz_t; a3: gmp_randstate_t; a4: mp_bitcnt_t) {.
    importc: "mpz_urandomb", header: "<gmp.h>".}
proc mpz_urandomm*(a2: mpz_ptr; a3: gmp_randstate_t; a4: mpz_srcptr) {.
    importc: "mpz_urandomm", header: "<gmp.h>".}
proc mpz_urandomm*(a2: var mpz_t; a3: gmp_randstate_t; a4: mpz_t) {.
    importc: "mpz_urandomm", header: "<gmp.h>".}
proc mpz_xor*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_xor", 
    header: "<gmp.h>".}
proc mpz_xor*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_xor", 
    header: "<gmp.h>".}
proc mpz_limbs_read*(a2: mpz_srcptr): mp_srcptr {.importc: "mpz_limbs_read", 
    header: "<gmp.h>".}
proc mpz_limbs_read*(a2: mpz_t): mp_srcptr {.importc: "mpz_limbs_read", 
    header: "<gmp.h>".}
proc mpz_limbs_write*(a2: mpz_ptr; a3: mp_size_t): mp_ptr {.
    importc: "mpz_limbs_write", header: "<gmp.h>".}
proc mpz_limbs_write*(a2: var mpz_t; a3: mp_size_t): mp_ptr {.
    importc: "mpz_limbs_write", header: "<gmp.h>".}
proc mpz_limbs_modify*(a2: mpz_ptr; a3: mp_size_t): mp_ptr {.
    importc: "mpz_limbs_modify", header: "<gmp.h>".}
proc mpz_limbs_modify*(a2: var mpz_t; a3: mp_size_t): mp_ptr {.
    importc: "mpz_limbs_modify", header: "<gmp.h>".}
proc mpz_limbs_finish*(a2: mpz_ptr; a3: mp_size_t) {.
    importc: "mpz_limbs_finish", header: "<gmp.h>".}
proc mpz_limbs_finish*(a2: var mpz_t; a3: mp_size_t) {.
    importc: "mpz_limbs_finish", header: "<gmp.h>".}
proc mpz_roinit_n*(a2: mpz_ptr; a3: mp_srcptr; a4: mp_size_t): mpz_srcptr {.
    importc: "mpz_roinit_n", header: "<gmp.h>".}
proc mpz_roinit_n*(a2: var mpz_t; a3: var mp_limb_t; a4: mp_size_t): mpz_srcptr {.
    importc: "mpz_roinit_n", header: "<gmp.h>".}
proc mpq_add*(a2: mpq_ptr; a3: mpq_srcptr; a4: mpq_srcptr) {.importc: "mpq_add", 
    header: "<gmp.h>".}
proc mpq_add*(a2: var mpq_t; a3: mpq_t; a4: mpq_t) {.importc: "mpq_add", 
    header: "<gmp.h>".}
proc mpq_canonicalize*(a2: mpq_ptr) {.importc: "mpq_canonicalize", 
                                      header: "<gmp.h>".}
proc mpq_canonicalize*(a2: var mpq_t) {.importc: "mpq_canonicalize", 
                                        header: "<gmp.h>".}
proc mpq_clear*(a2: mpq_ptr) {.importc: "mpq_clear", header: "<gmp.h>".}
proc mpq_clear*(a2: var mpq_t) {.importc: "mpq_clear", header: "<gmp.h>".}
proc mpq_clears*(a2: mpq_ptr) {.varargs, importc: "mpq_clears", 
                                header: "<gmp.h>".}
proc mpq_clears*(a2: var mpq_t) {.varargs, importc: "mpq_clears", 
                                  header: "<gmp.h>".}
proc mpq_cmp*(a2: mpq_srcptr; a3: mpq_srcptr): cint {.importc: "mpq_cmp", 
    header: "<gmp.h>".}
proc mpq_cmp*(a2: mpq_t; a3: mpq_t): cint {.importc: "mpq_cmp", 
    header: "<gmp.h>".}
proc m_mpq_cmp_si*(a2: mpq_srcptr; a3: clong; a4: culong): cint {.
    importc: "_mpq_cmp_si", header: "<gmp.h>".}
proc m_mpq_cmp_si*(a2: mpq_t; a3: clong; a4: culong): cint {.
    importc: "_mpq_cmp_si", header: "<gmp.h>".}
proc m_mpq_cmp_ui*(a2: mpq_srcptr; a3: culong; a4: culong): cint {.
    importc: "_mpq_cmp_ui", header: "<gmp.h>".}
proc m_mpq_cmp_ui*(a2: mpq_t; a3: culong; a4: culong): cint {.
    importc: "_mpq_cmp_ui", header: "<gmp.h>".}
proc mpq_div*(a2: mpq_ptr; a3: mpq_srcptr; a4: mpq_srcptr) {.importc: "mpq_div", 
    header: "<gmp.h>".}
proc mpq_div*(a2: var mpq_t; a3: mpq_t; a4: mpq_t) {.importc: "mpq_div", 
    header: "<gmp.h>".}
proc mpq_div_2exp*(a2: mpq_ptr; a3: mpq_srcptr; a4: mp_bitcnt_t) {.
    importc: "mpq_div_2exp", header: "<gmp.h>".}
proc mpq_div_2exp*(a2: var mpq_t; a3: mpq_t; a4: mp_bitcnt_t) {.
    importc: "mpq_div_2exp", header: "<gmp.h>".}
proc mpq_equal*(a2: mpq_srcptr; a3: mpq_srcptr): cint {.importc: "mpq_equal", 
    header: "<gmp.h>".}
proc mpq_equal*(a2: mpq_t; a3: mpq_t): cint {.importc: "mpq_equal", 
    header: "<gmp.h>".}
proc mpq_get_num*(a2: mpz_ptr; a3: mpq_srcptr) {.importc: "mpq_get_num", 
    header: "<gmp.h>".}
proc mpq_get_num*(a2: var mpz_t; a3: mpq_t) {.importc: "mpq_get_num", 
    header: "<gmp.h>".}
proc mpq_get_den*(a2: mpz_ptr; a3: mpq_srcptr) {.importc: "mpq_get_den", 
    header: "<gmp.h>".}
proc mpq_get_den*(a2: var mpz_t; a3: mpq_t) {.importc: "mpq_get_den", 
    header: "<gmp.h>".}
proc mpq_get_d*(a2: mpq_srcptr): cdouble {.importc: "mpq_get_d", 
    header: "<gmp.h>".}
proc mpq_get_d*(a2: mpq_t): cdouble {.importc: "mpq_get_d", header: "<gmp.h>".}
proc mpq_get_str*(a2: cstring; a3: cint; a4: mpq_srcptr): cstring {.
    importc: "mpq_get_str", header: "<gmp.h>".}
proc mpq_get_str*(a2: cstring; a3: cint; a4: mpq_t): cstring {.
    importc: "mpq_get_str", header: "<gmp.h>".}
proc mpq_init*(a2: mpq_ptr) {.importc: "mpq_init", header: "<gmp.h>".}
proc mpq_init*(a2: var mpq_t) {.importc: "mpq_init", header: "<gmp.h>".}
proc mpq_inits*(a2: mpq_ptr) {.varargs, importc: "mpq_inits", header: "<gmp.h>".}
proc mpq_inits*(a2: var mpq_t) {.varargs, importc: "mpq_inits", 
                                 header: "<gmp.h>".}
proc mpq_inp_str*(a2: mpq_ptr; a3: File; a4: cint): csize {.
    importc: "mpq_inp_str", header: "<gmp.h>".}
proc mpq_inp_str*(a2: var mpq_t; a3: File; a4: cint): csize {.
    importc: "mpq_inp_str", header: "<gmp.h>".}
proc mpq_inv*(a2: mpq_ptr; a3: mpq_srcptr) {.importc: "mpq_inv", 
    header: "<gmp.h>".}
proc mpq_inv*(a2: var mpq_t; a3: mpq_t) {.importc: "mpq_inv", header: "<gmp.h>".}
proc mpq_mul*(a2: mpq_ptr; a3: mpq_srcptr; a4: mpq_srcptr) {.importc: "mpq_mul", 
    header: "<gmp.h>".}
proc mpq_mul*(a2: var mpq_t; a3: mpq_t; a4: mpq_t) {.importc: "mpq_mul", 
    header: "<gmp.h>".}
proc mpq_mul_2exp*(a2: mpq_ptr; a3: mpq_srcptr; a4: mp_bitcnt_t) {.
    importc: "mpq_mul_2exp", header: "<gmp.h>".}
proc mpq_mul_2exp*(a2: var mpq_t; a3: mpq_t; a4: mp_bitcnt_t) {.
    importc: "mpq_mul_2exp", header: "<gmp.h>".}
proc mpq_out_str*(a2: File; a3: cint; a4: mpq_srcptr): csize {.
    importc: "mpq_out_str", header: "<gmp.h>".}
proc mpq_out_str*(a2: File; a3: cint; a4: mpq_t): csize {.
    importc: "mpq_out_str", header: "<gmp.h>".}
proc mpq_set*(a2: mpq_ptr; a3: mpq_srcptr) {.importc: "mpq_set", 
    header: "<gmp.h>".}
proc mpq_set*(a2: var mpq_t; a3: mpq_t) {.importc: "mpq_set", header: "<gmp.h>".}
proc mpq_set_d*(a2: mpq_ptr; a3: cdouble) {.importc: "mpq_set_d", 
    header: "<gmp.h>".}
proc mpq_set_d*(a2: var mpq_t; a3: cdouble) {.importc: "mpq_set_d", 
    header: "<gmp.h>".}
proc mpq_set_den*(a2: mpq_ptr; a3: mpz_srcptr) {.importc: "mpq_set_den", 
    header: "<gmp.h>".}
proc mpq_set_den*(a2: var mpq_t; a3: mpz_t) {.importc: "mpq_set_den", 
    header: "<gmp.h>".}
proc mpq_set_f*(a2: mpq_ptr; a3: mpf_srcptr) {.importc: "mpq_set_f", 
    header: "<gmp.h>".}
proc mpq_set_f*(a2: var mpq_t; a3: mpf_t) {.importc: "mpq_set_f", 
    header: "<gmp.h>".}
proc mpq_set_num*(a2: mpq_ptr; a3: mpz_srcptr) {.importc: "mpq_set_num", 
    header: "<gmp.h>".}
proc mpq_set_num*(a2: var mpq_t; a3: mpz_t) {.importc: "mpq_set_num", 
    header: "<gmp.h>".}
proc mpq_set_si*(a2: mpq_ptr; a3: clong; a4: culong) {.importc: "mpq_set_si", 
    header: "<gmp.h>".}
proc mpq_set_si*(a2: var mpq_t; a3: clong; a4: culong) {.importc: "mpq_set_si", 
    header: "<gmp.h>".}
proc mpq_set_str*(a2: mpq_ptr; a3: cstring; a4: cint): cint {.
    importc: "mpq_set_str", header: "<gmp.h>".}
proc mpq_set_str*(a2: var mpq_t; a3: cstring; a4: cint): cint {.
    importc: "mpq_set_str", header: "<gmp.h>".}
proc mpq_set_ui*(a2: mpq_ptr; a3: culong; a4: culong) {.importc: "mpq_set_ui", 
    header: "<gmp.h>".}
proc mpq_set_ui*(a2: var mpq_t; a3: culong; a4: culong) {.importc: "mpq_set_ui", 
    header: "<gmp.h>".}
proc mpq_set_z*(a2: mpq_ptr; a3: mpz_srcptr) {.importc: "mpq_set_z", 
    header: "<gmp.h>".}
proc mpq_set_z*(a2: var mpq_t; a3: mpz_t) {.importc: "mpq_set_z", 
    header: "<gmp.h>".}
proc mpq_sub*(a2: mpq_ptr; a3: mpq_srcptr; a4: mpq_srcptr) {.importc: "mpq_sub", 
    header: "<gmp.h>".}
proc mpq_sub*(a2: var mpq_t; a3: mpq_t; a4: mpq_t) {.importc: "mpq_sub", 
    header: "<gmp.h>".}
proc mpq_swap*(a2: mpq_ptr; a3: mpq_ptr) {.importc: "mpq_swap", 
    header: "<gmp.h>".}
proc mpq_swap*(a2: var mpq_t; a3: var mpq_t) {.importc: "mpq_swap", 
    header: "<gmp.h>".}
proc mpf_abs*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "mpf_abs", 
    header: "<gmp.h>".}
proc mpf_abs*(a2: var mpf_t; a3: mpf_t) {.importc: "mpf_abs", header: "<gmp.h>".}
proc mpf_add*(a2: mpf_ptr; a3: mpf_srcptr; a4: mpf_srcptr) {.importc: "mpf_add", 
    header: "<gmp.h>".}
proc mpf_add*(a2: var mpf_t; a3: mpf_t; a4: mpf_t) {.importc: "mpf_add", 
    header: "<gmp.h>".}
proc mpf_add_ui*(a2: mpf_ptr; a3: mpf_srcptr; a4: culong) {.
    importc: "mpf_add_ui", header: "<gmp.h>".}
proc mpf_add_ui*(a2: var mpf_t; a3: mpf_t; a4: culong) {.importc: "mpf_add_ui", 
    header: "<gmp.h>".}
proc mpf_ceil*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "mpf_ceil", 
    header: "<gmp.h>".}
proc mpf_ceil*(a2: var mpf_t; a3: mpf_t) {.importc: "mpf_ceil", 
    header: "<gmp.h>".}
proc mpf_clear*(a2: mpf_ptr) {.importc: "mpf_clear", header: "<gmp.h>".}
proc mpf_clear*(a2: var mpf_t) {.importc: "mpf_clear", header: "<gmp.h>".}
proc mpf_clears*(a2: mpf_ptr) {.varargs, importc: "mpf_clears", 
                                header: "<gmp.h>".}
proc mpf_clears*(a2: var mpf_t) {.varargs, importc: "mpf_clears", 
                                  header: "<gmp.h>".}
proc mpf_cmp*(a2: mpf_srcptr; a3: mpf_srcptr): cint {.importc: "mpf_cmp", 
    header: "<gmp.h>".}
proc mpf_cmp*(a2: mpf_t; a3: mpf_t): cint {.importc: "mpf_cmp", 
    header: "<gmp.h>".}
proc mpf_cmp_d*(a2: mpf_srcptr; a3: cdouble): cint {.importc: "mpf_cmp_d", 
    header: "<gmp.h>".}
proc mpf_cmp_d*(a2: mpf_t; a3: cdouble): cint {.importc: "mpf_cmp_d", 
    header: "<gmp.h>".}
proc mpf_cmp_si*(a2: mpf_srcptr; a3: clong): cint {.importc: "mpf_cmp_si", 
    header: "<gmp.h>".}
proc mpf_cmp_si*(a2: mpf_t; a3: clong): cint {.importc: "mpf_cmp_si", 
    header: "<gmp.h>".}
proc mpf_cmp_ui*(a2: mpf_srcptr; a3: culong): cint {.importc: "mpf_cmp_ui", 
    header: "<gmp.h>".}
proc mpf_cmp_ui*(a2: mpf_t; a3: culong): cint {.importc: "mpf_cmp_ui", 
    header: "<gmp.h>".}
proc mpf_div*(a2: mpf_ptr; a3: mpf_srcptr; a4: mpf_srcptr) {.importc: "mpf_div", 
    header: "<gmp.h>".}
proc mpf_div*(a2: var mpf_t; a3: mpf_t; a4: mpf_t) {.importc: "mpf_div", 
    header: "<gmp.h>".}
proc mpf_div_2exp*(a2: mpf_ptr; a3: mpf_srcptr; a4: mp_bitcnt_t) {.
    importc: "mpf_div_2exp", header: "<gmp.h>".}
proc mpf_div_2exp*(a2: var mpf_t; a3: mpf_t; a4: mp_bitcnt_t) {.
    importc: "mpf_div_2exp", header: "<gmp.h>".}
proc mpf_div_ui*(a2: mpf_ptr; a3: mpf_srcptr; a4: culong) {.
    importc: "mpf_div_ui", header: "<gmp.h>".}
proc mpf_div_ui*(a2: var mpf_t; a3: mpf_t; a4: culong) {.importc: "mpf_div_ui", 
    header: "<gmp.h>".}
proc mpf_dump*(a2: mpf_srcptr) {.importc: "mpf_dump", header: "<gmp.h>".}
proc mpf_dump*(a2: mpf_t) {.importc: "mpf_dump", header: "<gmp.h>".}
proc mpf_eq*(a2: mpf_srcptr; a3: mpf_srcptr; a4: mp_bitcnt_t): cint {.
    importc: "mpf_eq", header: "<gmp.h>".}
proc mpf_eq*(a2: mpf_t; a3: mpf_t; a4: mp_bitcnt_t): cint {.importc: "mpf_eq", 
    header: "<gmp.h>".}
proc mpf_fits_sint_p*(a2: mpf_srcptr): cint {.importc: "mpf_fits_sint_p", 
    header: "<gmp.h>".}
proc mpf_fits_sint_p*(a2: mpf_t): cint {.importc: "mpf_fits_sint_p", 
    header: "<gmp.h>".}
proc mpf_fits_slong_p*(a2: mpf_srcptr): cint {.importc: "mpf_fits_slong_p", 
    header: "<gmp.h>".}
proc mpf_fits_slong_p*(a2: mpf_t): cint {.importc: "mpf_fits_slong_p", 
    header: "<gmp.h>".}
proc mpf_fits_sshort_p*(a2: mpf_srcptr): cint {.importc: "mpf_fits_sshort_p", 
    header: "<gmp.h>".}
proc mpf_fits_sshort_p*(a2: mpf_t): cint {.importc: "mpf_fits_sshort_p", 
    header: "<gmp.h>".}
proc mpf_fits_uint_p*(a2: mpf_srcptr): cint {.importc: "mpf_fits_uint_p", 
    header: "<gmp.h>".}
proc mpf_fits_uint_p*(a2: mpf_t): cint {.importc: "mpf_fits_uint_p", 
    header: "<gmp.h>".}
proc mpf_fits_ulong_p*(a2: mpf_srcptr): cint {.importc: "mpf_fits_ulong_p", 
    header: "<gmp.h>".}
proc mpf_fits_ulong_p*(a2: mpf_t): cint {.importc: "mpf_fits_ulong_p", 
    header: "<gmp.h>".}
proc mpf_fits_ushort_p*(a2: mpf_srcptr): cint {.importc: "mpf_fits_ushort_p", 
    header: "<gmp.h>".}
proc mpf_fits_ushort_p*(a2: mpf_t): cint {.importc: "mpf_fits_ushort_p", 
    header: "<gmp.h>".}
proc mpf_floor*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "mpf_floor", 
    header: "<gmp.h>".}
proc mpf_floor*(a2: var mpf_t; a3: mpf_t) {.importc: "mpf_floor", 
    header: "<gmp.h>".}
proc mpf_get_d*(a2: mpf_srcptr): cdouble {.importc: "mpf_get_d", 
    header: "<gmp.h>".}
proc mpf_get_d*(a2: mpf_t): cdouble {.importc: "mpf_get_d", header: "<gmp.h>".}
proc mpf_get_d_2exp*(a2: ptr clong; a3: mpf_srcptr): cdouble {.
    importc: "mpf_get_d_2exp", header: "<gmp.h>".}
proc mpf_get_d_2exp*(a2: ptr clong; a3: mpf_t): cdouble {.
    importc: "mpf_get_d_2exp", header: "<gmp.h>".}
proc mpf_get_default_prec*(): mp_bitcnt_t {.importc: "mpf_get_default_prec", 
    header: "<gmp.h>".}
proc mpf_get_prec*(a2: mpf_srcptr): mp_bitcnt_t {.importc: "mpf_get_prec", 
    header: "<gmp.h>".}
proc mpf_get_prec*(a2: mpf_t): mp_bitcnt_t {.importc: "mpf_get_prec", 
    header: "<gmp.h>".}
proc mpf_get_si*(a2: mpf_srcptr): clong {.importc: "mpf_get_si", 
    header: "<gmp.h>".}
proc mpf_get_si*(a2: mpf_t): clong {.importc: "mpf_get_si", header: "<gmp.h>".}
proc mpf_get_str*(a2: cstring; a3: ptr mp_exp_t; a4: cint; a5: csize; 
                  a6: mpf_srcptr): cstring {.importc: "mpf_get_str", 
    header: "<gmp.h>".}
proc mpf_get_str*(a2: cstring; a3: var mp_exp_t; a4: cint; a5: csize; a6: mpf_t): cstring {.
    importc: "mpf_get_str", header: "<gmp.h>".}
proc mpf_get_ui*(a2: mpf_srcptr): culong {.importc: "mpf_get_ui", 
    header: "<gmp.h>".}
proc mpf_get_ui*(a2: mpf_t): culong {.importc: "mpf_get_ui", header: "<gmp.h>".}
proc mpf_init*(a2: mpf_ptr) {.importc: "mpf_init", header: "<gmp.h>".}
proc mpf_init*(a2: var mpf_t) {.importc: "mpf_init", header: "<gmp.h>".}
proc mpf_init2*(a2: mpf_ptr; a3: mp_bitcnt_t) {.importc: "mpf_init2", 
    header: "<gmp.h>".}
proc mpf_init2*(a2: var mpf_t; a3: mp_bitcnt_t) {.importc: "mpf_init2", 
    header: "<gmp.h>".}
proc mpf_inits*(a2: mpf_ptr) {.varargs, importc: "mpf_inits", header: "<gmp.h>".}
proc mpf_inits*(a2: var mpf_t) {.varargs, importc: "mpf_inits", 
                                 header: "<gmp.h>".}
proc mpf_init_set*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "mpf_init_set", 
    header: "<gmp.h>".}
proc mpf_init_set*(a2: var mpf_t; a3: mpf_t) {.importc: "mpf_init_set", 
    header: "<gmp.h>".}
proc mpf_init_set_d*(a2: mpf_ptr; a3: cdouble) {.importc: "mpf_init_set_d", 
    header: "<gmp.h>".}
proc mpf_init_set_d*(a2: var mpf_t; a3: cdouble) {.importc: "mpf_init_set_d", 
    header: "<gmp.h>".}
proc mpf_init_set_si*(a2: mpf_ptr; a3: clong) {.importc: "mpf_init_set_si", 
    header: "<gmp.h>".}
proc mpf_init_set_si*(a2: var mpf_t; a3: clong) {.importc: "mpf_init_set_si", 
    header: "<gmp.h>".}
proc mpf_init_set_str*(a2: mpf_ptr; a3: cstring; a4: cint): cint {.
    importc: "mpf_init_set_str", header: "<gmp.h>".}
proc mpf_init_set_str*(a2: var mpf_t; a3: cstring; a4: cint): cint {.
    importc: "mpf_init_set_str", header: "<gmp.h>".}
proc mpf_init_set_ui*(a2: mpf_ptr; a3: culong) {.importc: "mpf_init_set_ui", 
    header: "<gmp.h>".}
proc mpf_init_set_ui*(a2: var mpf_t; a3: culong) {.importc: "mpf_init_set_ui", 
    header: "<gmp.h>".}
proc mpf_inp_str*(a2: mpf_ptr; a3: File; a4: cint): csize {.
    importc: "mpf_inp_str", header: "<gmp.h>".}
proc mpf_inp_str*(a2: var mpf_t; a3: File; a4: cint): csize {.
    importc: "mpf_inp_str", header: "<gmp.h>".}
proc mpf_integer_p*(a2: mpf_srcptr): cint {.importc: "mpf_integer_p", 
    header: "<gmp.h>".}
proc mpf_integer_p*(a2: mpf_t): cint {.importc: "mpf_integer_p", 
                                       header: "<gmp.h>".}
proc mpf_mul*(a2: mpf_ptr; a3: mpf_srcptr; a4: mpf_srcptr) {.importc: "mpf_mul", 
    header: "<gmp.h>".}
proc mpf_mul*(a2: var mpf_t; a3: mpf_t; a4: mpf_t) {.importc: "mpf_mul", 
    header: "<gmp.h>".}
proc mpf_mul_2exp*(a2: mpf_ptr; a3: mpf_srcptr; a4: mp_bitcnt_t) {.
    importc: "mpf_mul_2exp", header: "<gmp.h>".}
proc mpf_mul_2exp*(a2: var mpf_t; a3: mpf_t; a4: mp_bitcnt_t) {.
    importc: "mpf_mul_2exp", header: "<gmp.h>".}
proc mpf_mul_ui*(a2: mpf_ptr; a3: mpf_srcptr; a4: culong) {.
    importc: "mpf_mul_ui", header: "<gmp.h>".}
proc mpf_mul_ui*(a2: var mpf_t; a3: mpf_t; a4: culong) {.importc: "mpf_mul_ui", 
    header: "<gmp.h>".}
proc mpf_neg*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "mpf_neg", 
    header: "<gmp.h>".}
proc mpf_neg*(a2: var mpf_t; a3: mpf_t) {.importc: "mpf_neg", header: "<gmp.h>".}
proc mpf_out_str*(a2: File; a3: cint; a4: csize; a5: mpf_srcptr): csize {.
    importc: "mpf_out_str", header: "<gmp.h>".}
proc mpf_out_str*(a2: File; a3: cint; a4: csize; a5: mpf_t): csize {.
    importc: "mpf_out_str", header: "<gmp.h>".}
proc mpf_pow_ui*(a2: mpf_ptr; a3: mpf_srcptr; a4: culong) {.
    importc: "mpf_pow_ui", header: "<gmp.h>".}
proc mpf_pow_ui*(a2: var mpf_t; a3: mpf_t; a4: culong) {.importc: "mpf_pow_ui", 
    header: "<gmp.h>".}
proc mpf_random2*(a2: mpf_ptr; a3: mp_size_t; a4: mp_exp_t) {.
    importc: "mpf_random2", header: "<gmp.h>".}
proc mpf_random2*(a2: var mpf_t; a3: mp_size_t; a4: mp_exp_t) {.
    importc: "mpf_random2", header: "<gmp.h>".}
proc mpf_reldiff*(a2: mpf_ptr; a3: mpf_srcptr; a4: mpf_srcptr) {.
    importc: "mpf_reldiff", header: "<gmp.h>".}
proc mpf_reldiff*(a2: var mpf_t; a3: mpf_t; a4: mpf_t) {.importc: "mpf_reldiff", 
    header: "<gmp.h>".}
proc mpf_set*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "mpf_set", 
    header: "<gmp.h>".}
proc mpf_set*(a2: var mpf_t; a3: mpf_t) {.importc: "mpf_set", header: "<gmp.h>".}
proc mpf_set_d*(a2: mpf_ptr; a3: cdouble) {.importc: "mpf_set_d", 
    header: "<gmp.h>".}
proc mpf_set_d*(a2: var mpf_t; a3: cdouble) {.importc: "mpf_set_d", 
    header: "<gmp.h>".}
proc mpf_set_default_prec*(a2: mp_bitcnt_t) {.importc: "mpf_set_default_prec", 
    header: "<gmp.h>".}
proc mpf_set_prec*(a2: mpf_ptr; a3: mp_bitcnt_t) {.importc: "mpf_set_prec", 
    header: "<gmp.h>".}
proc mpf_set_prec*(a2: var mpf_t; a3: mp_bitcnt_t) {.importc: "mpf_set_prec", 
    header: "<gmp.h>".}
proc mpf_set_prec_raw*(a2: mpf_ptr; a3: mp_bitcnt_t) {.
    importc: "mpf_set_prec_raw", header: "<gmp.h>".}
proc mpf_set_prec_raw*(a2: var mpf_t; a3: mp_bitcnt_t) {.
    importc: "mpf_set_prec_raw", header: "<gmp.h>".}
proc mpf_set_q*(a2: mpf_ptr; a3: mpq_srcptr) {.importc: "mpf_set_q", 
    header: "<gmp.h>".}
proc mpf_set_q*(a2: var mpf_t; a3: mpq_t) {.importc: "mpf_set_q", 
    header: "<gmp.h>".}
proc mpf_set_si*(a2: mpf_ptr; a3: clong) {.importc: "mpf_set_si", 
    header: "<gmp.h>".}
proc mpf_set_si*(a2: var mpf_t; a3: clong) {.importc: "mpf_set_si", 
    header: "<gmp.h>".}
proc mpf_set_str*(a2: mpf_ptr; a3: cstring; a4: cint): cint {.
    importc: "mpf_set_str", header: "<gmp.h>".}
proc mpf_set_str*(a2: var mpf_t; a3: cstring; a4: cint): cint {.
    importc: "mpf_set_str", header: "<gmp.h>".}
proc mpf_set_ui*(a2: mpf_ptr; a3: culong) {.importc: "mpf_set_ui", 
    header: "<gmp.h>".}
proc mpf_set_ui*(a2: var mpf_t; a3: culong) {.importc: "mpf_set_ui", 
    header: "<gmp.h>".}
proc mpf_set_z*(a2: mpf_ptr; a3: mpz_srcptr) {.importc: "mpf_set_z", 
    header: "<gmp.h>".}
proc mpf_set_z*(a2: var mpf_t; a3: mpz_t) {.importc: "mpf_set_z", 
    header: "<gmp.h>".}
proc mpf_size*(a2: mpf_srcptr): csize {.importc: "mpf_size", header: "<gmp.h>".}
proc mpf_size*(a2: mpf_t): csize {.importc: "mpf_size", header: "<gmp.h>".}
proc mpf_sqrt*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "mpf_sqrt", 
    header: "<gmp.h>".}
proc mpf_sqrt*(a2: var mpf_t; a3: mpf_t) {.importc: "mpf_sqrt", 
    header: "<gmp.h>".}
proc mpf_sqrt_ui*(a2: mpf_ptr; a3: culong) {.importc: "mpf_sqrt_ui", 
    header: "<gmp.h>".}
proc mpf_sqrt_ui*(a2: var mpf_t; a3: culong) {.importc: "mpf_sqrt_ui", 
    header: "<gmp.h>".}
proc mpf_sub*(a2: mpf_ptr; a3: mpf_srcptr; a4: mpf_srcptr) {.importc: "mpf_sub", 
    header: "<gmp.h>".}
proc mpf_sub*(a2: var mpf_t; a3: mpf_t; a4: mpf_t) {.importc: "mpf_sub", 
    header: "<gmp.h>".}
proc mpf_sub_ui*(a2: mpf_ptr; a3: mpf_srcptr; a4: culong) {.
    importc: "mpf_sub_ui", header: "<gmp.h>".}
proc mpf_sub_ui*(a2: var mpf_t; a3: mpf_t; a4: culong) {.importc: "mpf_sub_ui", 
    header: "<gmp.h>".}
proc mpf_swap*(a2: mpf_ptr; a3: mpf_ptr) {.importc: "mpf_swap", 
    header: "<gmp.h>".}
proc mpf_swap*(a2: var mpf_t; a3: var mpf_t) {.importc: "mpf_swap", 
    header: "<gmp.h>".}
proc mpf_trunc*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "mpf_trunc", 
    header: "<gmp.h>".}
proc mpf_trunc*(a2: var mpf_t; a3: mpf_t) {.importc: "mpf_trunc", 
    header: "<gmp.h>".}
proc mpf_ui_div*(a2: mpf_ptr; a3: culong; a4: mpf_srcptr) {.
    importc: "mpf_ui_div", header: "<gmp.h>".}
proc mpf_ui_div*(a2: var mpf_t; a3: culong; a4: mpf_t) {.importc: "mpf_ui_div", 
    header: "<gmp.h>".}
proc mpf_ui_sub*(a2: mpf_ptr; a3: culong; a4: mpf_srcptr) {.
    importc: "mpf_ui_sub", header: "<gmp.h>".}
proc mpf_ui_sub*(a2: var mpf_t; a3: culong; a4: mpf_t) {.importc: "mpf_ui_sub", 
    header: "<gmp.h>".}
proc mpf_urandomb*(a2: mpf_t; a3: gmp_randstate_t; a4: mp_bitcnt_t) {.
    importc: "mpf_urandomb", header: "<gmp.h>".}
proc mpn_add_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t): mp_limb_t {.
    importc: "mpn_add_n", header: "<gmp.h>".}
proc mpn_add_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                a5: mp_size_t): mp_limb_t {.importc: "mpn_add_n", 
    header: "<gmp.h>".}
proc mpn_addmul_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.
    importc: "mpn_addmul_1", header: "<gmp.h>".}
proc mpn_addmul_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                   a5: mp_limb_t): mp_limb_t {.importc: "mpn_addmul_1", 
    header: "<gmp.h>".}
proc mpn_divexact_by3c*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.
    importc: "mpn_divexact_by3c", header: "<gmp.h>".}
proc mpn_divexact_by3c*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                        a5: mp_limb_t): mp_limb_t {.
    importc: "mpn_divexact_by3c", header: "<gmp.h>".}
proc mpn_divrem*(a2: mp_ptr; a3: mp_size_t; a4: mp_ptr; a5: mp_size_t; 
                 a6: mp_srcptr; a7: mp_size_t): mp_limb_t {.
    importc: "mpn_divrem", header: "<gmp.h>".}
proc mpn_divrem*(a2: var mp_limb_t; a3: mp_size_t; a4: var mp_limb_t; 
                 a5: mp_size_t; a6: var mp_limb_t; a7: mp_size_t): mp_limb_t {.
    importc: "mpn_divrem", header: "<gmp.h>".}
proc mpn_divrem_1*(a2: mp_ptr; a3: mp_size_t; a4: mp_srcptr; a5: mp_size_t; 
                   a6: mp_limb_t): mp_limb_t {.importc: "mpn_divrem_1", 
    header: "<gmp.h>".}
proc mpn_divrem_1*(a2: var mp_limb_t; a3: mp_size_t; a4: var mp_limb_t; 
                   a5: mp_size_t; a6: mp_limb_t): mp_limb_t {.
    importc: "mpn_divrem_1", header: "<gmp.h>".}
proc mpn_divrem_2*(a2: mp_ptr; a3: mp_size_t; a4: mp_ptr; a5: mp_size_t; 
                   a6: mp_srcptr): mp_limb_t {.importc: "mpn_divrem_2", 
    header: "<gmp.h>".}
proc mpn_divrem_2*(a2: var mp_limb_t; a3: mp_size_t; a4: var mp_limb_t; 
                   a5: mp_size_t; a6: var mp_limb_t): mp_limb_t {.
    importc: "mpn_divrem_2", header: "<gmp.h>".}
proc mpn_div_qr_1*(a2: mp_ptr; a3: ptr mp_limb_t; a4: mp_srcptr; a5: mp_size_t; 
                   a6: mp_limb_t): mp_limb_t {.importc: "mpn_div_qr_1", 
    header: "<gmp.h>".}
proc mpn_div_qr_1*(a2: var mp_limb_t; a3: ptr mp_limb_t; a4: var mp_limb_t; 
                   a5: mp_size_t; a6: mp_limb_t): mp_limb_t {.
    importc: "mpn_div_qr_1", header: "<gmp.h>".}
proc mpn_div_qr_2*(a2: mp_ptr; a3: mp_ptr; a4: mp_srcptr; a5: mp_size_t; 
                   a6: mp_srcptr): mp_limb_t {.importc: "mpn_div_qr_2", 
    header: "<gmp.h>".}
proc mpn_div_qr_2*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                   a5: mp_size_t; a6: var mp_limb_t): mp_limb_t {.
    importc: "mpn_div_qr_2", header: "<gmp.h>".}
proc mpn_gcd*(a2: mp_ptr; a3: mp_ptr; a4: mp_size_t; a5: mp_ptr; a6: mp_size_t): mp_size_t {.
    importc: "mpn_gcd", header: "<gmp.h>".}
proc mpn_gcd*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
              a5: var mp_limb_t; a6: mp_size_t): mp_size_t {.importc: "mpn_gcd", 
    header: "<gmp.h>".}
proc mpn_gcd_1*(a2: mp_srcptr; a3: mp_size_t; a4: mp_limb_t): mp_limb_t {.
    importc: "mpn_gcd_1", header: "<gmp.h>".}
proc mpn_gcd_1*(a2: var mp_limb_t; a3: mp_size_t; a4: mp_limb_t): mp_limb_t {.
    importc: "mpn_gcd_1", header: "<gmp.h>".}
proc mpn_gcdext_1*(a2: ptr mp_limb_signed_t; a3: ptr mp_limb_signed_t; 
                   a4: mp_limb_t; a5: mp_limb_t): mp_limb_t {.
    importc: "mpn_gcdext_1", header: "<gmp.h>".}
proc mpn_gcdext*(a2: mp_ptr; a3: mp_ptr; a4: ptr mp_size_t; a5: mp_ptr; 
                 a6: mp_size_t; a7: mp_ptr; a8: mp_size_t): mp_size_t {.
    importc: "mpn_gcdext", header: "<gmp.h>".}
proc mpn_gcdext*(a2: var mp_limb_t; a3: var mp_limb_t; a4: ptr mp_size_t; 
                 a5: var mp_limb_t; a6: mp_size_t; a7: var mp_limb_t; 
                 a8: mp_size_t): mp_size_t {.importc: "mpn_gcdext", 
    header: "<gmp.h>".}
proc mpn_get_str*(a2: ptr cuchar; a3: cint; a4: mp_ptr; a5: mp_size_t): csize {.
    importc: "mpn_get_str", header: "<gmp.h>".}
proc mpn_get_str*(a2: ptr cuchar; a3: cint; a4: var mp_limb_t; a5: mp_size_t): csize {.
    importc: "mpn_get_str", header: "<gmp.h>".}
proc mpn_hamdist*(a2: mp_srcptr; a3: mp_srcptr; a4: mp_size_t): mp_bitcnt_t {.
    importc: "mpn_hamdist", header: "<gmp.h>".}
proc mpn_hamdist*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t): mp_bitcnt_t {.
    importc: "mpn_hamdist", header: "<gmp.h>".}
proc mpn_lshift*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: cuint): mp_limb_t {.
    importc: "mpn_lshift", header: "<gmp.h>".}
proc mpn_lshift*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: cuint): mp_limb_t {.
    importc: "mpn_lshift", header: "<gmp.h>".}
proc mpn_mod_1*(a2: mp_srcptr; a3: mp_size_t; a4: mp_limb_t): mp_limb_t {.
    importc: "mpn_mod_1", header: "<gmp.h>".}
proc mpn_mod_1*(a2: var mp_limb_t; a3: mp_size_t; a4: mp_limb_t): mp_limb_t {.
    importc: "mpn_mod_1", header: "<gmp.h>".}
proc mpn_mul*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_srcptr; 
              a6: mp_size_t): mp_limb_t {.importc: "mpn_mul", header: "<gmp.h>".}
proc mpn_mul*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
              a5: var mp_limb_t; a6: mp_size_t): mp_limb_t {.importc: "mpn_mul", 
    header: "<gmp.h>".}
proc mpn_mul_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.
    importc: "mpn_mul_1", header: "<gmp.h>".}
proc mpn_mul_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                a5: mp_limb_t): mp_limb_t {.importc: "mpn_mul_1", 
    header: "<gmp.h>".}
proc mpn_mul_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.
    importc: "mpn_mul_n", header: "<gmp.h>".}
proc mpn_mul_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                a5: mp_size_t) {.importc: "mpn_mul_n", header: "<gmp.h>".}
proc mpn_sqr*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t) {.importc: "mpn_sqr", 
    header: "<gmp.h>".}
proc mpn_sqr*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t) {.
    importc: "mpn_sqr", header: "<gmp.h>".}
proc mpn_neg*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t): mp_limb_t {.
    importc: "mpn_neg", header: "<gmp.h>".}
proc mpn_neg*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t): mp_limb_t {.
    importc: "mpn_neg", header: "<gmp.h>".}
proc mpn_com*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t) {.importc: "mpn_com", 
    header: "<gmp.h>".}
proc mpn_com*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t) {.
    importc: "mpn_com", header: "<gmp.h>".}
proc mpn_perfect_square_p*(a2: mp_srcptr; a3: mp_size_t): cint {.
    importc: "mpn_perfect_square_p", header: "<gmp.h>".}
proc mpn_perfect_square_p*(a2: var mp_limb_t; a3: mp_size_t): cint {.
    importc: "mpn_perfect_square_p", header: "<gmp.h>".}
proc mpn_perfect_power_p*(a2: mp_srcptr; a3: mp_size_t): cint {.
    importc: "mpn_perfect_power_p", header: "<gmp.h>".}
proc mpn_perfect_power_p*(a2: var mp_limb_t; a3: mp_size_t): cint {.
    importc: "mpn_perfect_power_p", header: "<gmp.h>".}
proc mpn_popcount*(a2: mp_srcptr; a3: mp_size_t): mp_bitcnt_t {.
    importc: "mpn_popcount", header: "<gmp.h>".}
proc mpn_popcount*(a2: var mp_limb_t; a3: mp_size_t): mp_bitcnt_t {.
    importc: "mpn_popcount", header: "<gmp.h>".}
proc mpn_pow_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t; 
                a6: mp_ptr): mp_size_t {.importc: "mpn_pow_1", header: "<gmp.h>".}
proc mpn_pow_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                a5: mp_limb_t; a6: var mp_limb_t): mp_size_t {.
    importc: "mpn_pow_1", header: "<gmp.h>".}
proc mpn_preinv_mod_1*(a2: mp_srcptr; a3: mp_size_t; a4: mp_limb_t; 
                       a5: mp_limb_t): mp_limb_t {.importc: "mpn_preinv_mod_1", 
    header: "<gmp.h>".}
proc mpn_preinv_mod_1*(a2: var mp_limb_t; a3: mp_size_t; a4: mp_limb_t; 
                       a5: mp_limb_t): mp_limb_t {.importc: "mpn_preinv_mod_1", 
    header: "<gmp.h>".}
proc mpn_random*(a2: mp_ptr; a3: mp_size_t) {.importc: "mpn_random", 
    header: "<gmp.h>".}
proc mpn_random*(a2: var mp_limb_t; a3: mp_size_t) {.importc: "mpn_random", 
    header: "<gmp.h>".}
proc mpn_random2*(a2: mp_ptr; a3: mp_size_t) {.importc: "mpn_random2", 
    header: "<gmp.h>".}
proc mpn_random2*(a2: var mp_limb_t; a3: mp_size_t) {.importc: "mpn_random2", 
    header: "<gmp.h>".}
proc mpn_rshift*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: cuint): mp_limb_t {.
    importc: "mpn_rshift", header: "<gmp.h>".}
proc mpn_rshift*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: cuint): mp_limb_t {.
    importc: "mpn_rshift", header: "<gmp.h>".}
proc mpn_scan0*(a2: mp_srcptr; a3: mp_bitcnt_t): mp_bitcnt_t {.
    importc: "mpn_scan0", header: "<gmp.h>".}
proc mpn_scan0*(a2: var mp_limb_t; a3: mp_bitcnt_t): mp_bitcnt_t {.
    importc: "mpn_scan0", header: "<gmp.h>".}
proc mpn_scan1*(a2: mp_srcptr; a3: mp_bitcnt_t): mp_bitcnt_t {.
    importc: "mpn_scan1", header: "<gmp.h>".}
proc mpn_scan1*(a2: var mp_limb_t; a3: mp_bitcnt_t): mp_bitcnt_t {.
    importc: "mpn_scan1", header: "<gmp.h>".}
proc mpn_set_str*(a2: mp_ptr; a3: ptr cuchar; a4: csize; a5: cint): mp_size_t {.
    importc: "mpn_set_str", header: "<gmp.h>".}
proc mpn_set_str*(a2: var mp_limb_t; a3: ptr cuchar; a4: csize; a5: cint): mp_size_t {.
    importc: "mpn_set_str", header: "<gmp.h>".}
proc mpn_sizeinbase*(a2: mp_srcptr; a3: mp_size_t; a4: cint): csize {.
    importc: "mpn_sizeinbase", header: "<gmp.h>".}
proc mpn_sizeinbase*(a2: var mp_limb_t; a3: mp_size_t; a4: cint): csize {.
    importc: "mpn_sizeinbase", header: "<gmp.h>".}
proc mpn_sqrtrem*(a2: mp_ptr; a3: mp_ptr; a4: mp_srcptr; a5: mp_size_t): mp_size_t {.
    importc: "mpn_sqrtrem", header: "<gmp.h>".}
proc mpn_sqrtrem*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                  a5: mp_size_t): mp_size_t {.importc: "mpn_sqrtrem", 
    header: "<gmp.h>".}
proc mpn_sub*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_srcptr; 
              a6: mp_size_t): mp_limb_t {.importc: "mpn_sub", header: "<gmp.h>".}
proc mpn_sub*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
              a5: var mp_limb_t; a6: mp_size_t): mp_limb_t {.importc: "mpn_sub", 
    header: "<gmp.h>".}
proc mpn_sub_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.
    importc: "mpn_sub_1", header: "<gmp.h>".}
proc mpn_sub_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                a5: mp_limb_t): mp_limb_t {.importc: "mpn_sub_1", 
    header: "<gmp.h>".}
proc mpn_sub_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t): mp_limb_t {.
    importc: "mpn_sub_n", header: "<gmp.h>".}
proc mpn_sub_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                a5: mp_size_t): mp_limb_t {.importc: "mpn_sub_n", 
    header: "<gmp.h>".}
proc mpn_submul_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.
    importc: "mpn_submul_1", header: "<gmp.h>".}
proc mpn_submul_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                   a5: mp_limb_t): mp_limb_t {.importc: "mpn_submul_1", 
    header: "<gmp.h>".}
proc mpn_tdiv_qr*(a2: mp_ptr; a3: mp_ptr; a4: mp_size_t; a5: mp_srcptr; 
                  a6: mp_size_t; a7: mp_srcptr; a8: mp_size_t) {.
    importc: "mpn_tdiv_qr", header: "<gmp.h>".}
proc mpn_tdiv_qr*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                  a5: var mp_limb_t; a6: mp_size_t; a7: var mp_limb_t; 
                  a8: mp_size_t) {.importc: "mpn_tdiv_qr", header: "<gmp.h>".}
proc mpn_and_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.
    importc: "mpn_and_n", header: "<gmp.h>".}
proc mpn_and_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                a5: mp_size_t) {.importc: "mpn_and_n", header: "<gmp.h>".}
proc mpn_andn_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.
    importc: "mpn_andn_n", header: "<gmp.h>".}
proc mpn_andn_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                 a5: mp_size_t) {.importc: "mpn_andn_n", header: "<gmp.h>".}
proc mpn_nand_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.
    importc: "mpn_nand_n", header: "<gmp.h>".}
proc mpn_nand_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                 a5: mp_size_t) {.importc: "mpn_nand_n", header: "<gmp.h>".}
proc mpn_ior_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.
    importc: "mpn_ior_n", header: "<gmp.h>".}
proc mpn_ior_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                a5: mp_size_t) {.importc: "mpn_ior_n", header: "<gmp.h>".}
proc mpn_iorn_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.
    importc: "mpn_iorn_n", header: "<gmp.h>".}
proc mpn_iorn_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                 a5: mp_size_t) {.importc: "mpn_iorn_n", header: "<gmp.h>".}
proc mpn_nior_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.
    importc: "mpn_nior_n", header: "<gmp.h>".}
proc mpn_nior_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                 a5: mp_size_t) {.importc: "mpn_nior_n", header: "<gmp.h>".}
proc mpn_xor_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.
    importc: "mpn_xor_n", header: "<gmp.h>".}
proc mpn_xor_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                a5: mp_size_t) {.importc: "mpn_xor_n", header: "<gmp.h>".}
proc mpn_xnor_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.
    importc: "mpn_xnor_n", header: "<gmp.h>".}
proc mpn_xnor_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                 a5: mp_size_t) {.importc: "mpn_xnor_n", header: "<gmp.h>".}
proc mpn_copyi*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t) {.
    importc: "mpn_copyi", header: "<gmp.h>".}
proc mpn_copyi*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t) {.
    importc: "mpn_copyi", header: "<gmp.h>".}
proc mpn_copyd*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t) {.
    importc: "mpn_copyd", header: "<gmp.h>".}
proc mpn_copyd*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t) {.
    importc: "mpn_copyd", header: "<gmp.h>".}
proc mpn_zero*(a2: mp_ptr; a3: mp_size_t) {.importc: "mpn_zero", 
    header: "<gmp.h>".}
proc mpn_zero*(a2: var mp_limb_t; a3: mp_size_t) {.importc: "mpn_zero", 
    header: "<gmp.h>".}
proc mpn_cnd_add_n*(a2: mp_limb_t; a3: mp_ptr; a4: mp_srcptr; a5: mp_srcptr; 
                    a6: mp_size_t): mp_limb_t {.importc: "mpn_cnd_add_n", 
    header: "<gmp.h>".}
proc mpn_cnd_add_n*(a2: mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                    a5: var mp_limb_t; a6: mp_size_t): mp_limb_t {.
    importc: "mpn_cnd_add_n", header: "<gmp.h>".}
proc mpn_cnd_sub_n*(a2: mp_limb_t; a3: mp_ptr; a4: mp_srcptr; a5: mp_srcptr; 
                    a6: mp_size_t): mp_limb_t {.importc: "mpn_cnd_sub_n", 
    header: "<gmp.h>".}
proc mpn_cnd_sub_n*(a2: mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                    a5: var mp_limb_t; a6: mp_size_t): mp_limb_t {.
    importc: "mpn_cnd_sub_n", header: "<gmp.h>".}
proc mpn_sec_add_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t; 
                    a6: mp_ptr): mp_limb_t {.importc: "mpn_sec_add_1", 
    header: "<gmp.h>".}
proc mpn_sec_add_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                    a5: mp_limb_t; a6: var mp_limb_t): mp_limb_t {.
    importc: "mpn_sec_add_1", header: "<gmp.h>".}
proc mpn_sec_add_1_itch*(a2: mp_size_t): mp_size_t {.
    importc: "mpn_sec_add_1_itch", header: "<gmp.h>".}
proc mpn_sec_sub_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t; 
                    a6: mp_ptr): mp_limb_t {.importc: "mpn_sec_sub_1", 
    header: "<gmp.h>".}
proc mpn_sec_sub_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                    a5: mp_limb_t; a6: var mp_limb_t): mp_limb_t {.
    importc: "mpn_sec_sub_1", header: "<gmp.h>".}
proc mpn_sec_sub_1_itch*(a2: mp_size_t): mp_size_t {.
    importc: "mpn_sec_sub_1_itch", header: "<gmp.h>".}
proc mpn_sec_mul*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_srcptr; 
                  a6: mp_size_t; a7: mp_ptr) {.importc: "mpn_sec_mul", 
    header: "<gmp.h>".}
proc mpn_sec_mul*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                  a5: var mp_limb_t; a6: mp_size_t; a7: var mp_limb_t) {.
    importc: "mpn_sec_mul", header: "<gmp.h>".}
proc mpn_sec_mul_itch*(a2: mp_size_t; a3: mp_size_t): mp_size_t {.
    importc: "mpn_sec_mul_itch", header: "<gmp.h>".}
proc mpn_sec_sqr*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_ptr) {.
    importc: "mpn_sec_sqr", header: "<gmp.h>".}
proc mpn_sec_sqr*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                  a5: var mp_limb_t) {.importc: "mpn_sec_sqr", header: "<gmp.h>".}
proc mpn_sec_sqr_itch*(a2: mp_size_t): mp_size_t {.importc: "mpn_sec_sqr_itch", 
    header: "<gmp.h>".}
proc mpn_sec_powm*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_srcptr; 
                   a6: mp_bitcnt_t; a7: mp_srcptr; a8: mp_size_t; a9: mp_ptr) {.
    importc: "mpn_sec_powm", header: "<gmp.h>".}
proc mpn_sec_powm*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                   a5: var mp_limb_t; a6: mp_bitcnt_t; a7: var mp_limb_t; 
                   a8: mp_size_t; a9: var mp_limb_t) {.importc: "mpn_sec_powm", 
    header: "<gmp.h>".}
proc mpn_sec_powm_itch*(a2: mp_size_t; a3: mp_bitcnt_t; a4: mp_size_t): mp_size_t {.
    importc: "mpn_sec_powm_itch", header: "<gmp.h>".}
proc mpn_sec_tabselect*(a2: ptr mp_limb_t; a3: ptr mp_limb_t; a4: mp_size_t; 
                        a5: mp_size_t; a6: mp_size_t) {.
    importc: "mpn_sec_tabselect", header: "<gmp.h>".}
proc mpn_sec_div_qr*(a2: mp_ptr; a3: mp_ptr; a4: mp_size_t; a5: mp_srcptr; 
                     a6: mp_size_t; a7: mp_ptr): mp_limb_t {.
    importc: "mpn_sec_div_qr", header: "<gmp.h>".}
proc mpn_sec_div_qr*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; 
                     a5: var mp_limb_t; a6: mp_size_t; a7: var mp_limb_t): mp_limb_t {.
    importc: "mpn_sec_div_qr", header: "<gmp.h>".}
proc mpn_sec_div_qr_itch*(a2: mp_size_t; a3: mp_size_t): mp_size_t {.
    importc: "mpn_sec_div_qr_itch", header: "<gmp.h>".}
proc mpn_sec_div_r*(a2: mp_ptr; a3: mp_size_t; a4: mp_srcptr; a5: mp_size_t; 
                    a6: mp_ptr) {.importc: "mpn_sec_div_r", header: "<gmp.h>".}
proc mpn_sec_div_r*(a2: var mp_limb_t; a3: mp_size_t; a4: var mp_limb_t; 
                    a5: mp_size_t; a6: var mp_limb_t) {.
    importc: "mpn_sec_div_r", header: "<gmp.h>".}
proc mpn_sec_div_r_itch*(a2: mp_size_t; a3: mp_size_t): mp_size_t {.
    importc: "mpn_sec_div_r_itch", header: "<gmp.h>".}
proc mpn_sec_invert*(a2: mp_ptr; a3: mp_ptr; a4: mp_srcptr; a5: mp_size_t; 
                     a6: mp_bitcnt_t; a7: mp_ptr): cint {.
    importc: "mpn_sec_invert", header: "<gmp.h>".}
proc mpn_sec_invert*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; 
                     a5: mp_size_t; a6: mp_bitcnt_t; a7: var mp_limb_t): cint {.
    importc: "mpn_sec_invert", header: "<gmp.h>".}
proc mpn_sec_invert_itch*(a2: mp_size_t): mp_size_t {.
    importc: "mpn_sec_invert_itch", header: "<gmp.h>".}
proc mpz_abs*(mm_gmp_w: mpz_ptr; mm_gmp_u: mpz_srcptr) {.importc: "mpz_abs", 
    header: "<gmp.h>".}
proc mpz_abs*(mm_gmp_w: var mpz_t; mm_gmp_u: mpz_t) {.importc: "mpz_abs", 
    header: "<gmp.h>".}
proc mpz_fits_uint_p*(mm_gmp_z: mpz_srcptr): cint {.importc: "mpz_fits_uint_p", 
    header: "<gmp.h>".}
proc mpz_fits_uint_p*(mm_gmp_z: mpz_t): cint {.importc: "mpz_fits_uint_p", 
    header: "<gmp.h>".}
proc mpz_fits_ulong_p*(mm_gmp_z: mpz_srcptr): cint {.
    importc: "mpz_fits_ulong_p", header: "<gmp.h>".}
proc mpz_fits_ulong_p*(mm_gmp_z: mpz_t): cint {.importc: "mpz_fits_ulong_p", 
    header: "<gmp.h>".}
proc mpz_fits_ushort_p*(mm_gmp_z: mpz_srcptr): cint {.
    importc: "mpz_fits_ushort_p", header: "<gmp.h>".}
proc mpz_fits_ushort_p*(mm_gmp_z: mpz_t): cint {.importc: "mpz_fits_ushort_p", 
    header: "<gmp.h>".}
proc mpz_get_ui*(mm_gmp_z: mpz_srcptr): culong {.importc: "mpz_get_ui", 
    header: "<gmp.h>".}
proc mpz_get_ui*(mm_gmp_z: mpz_t): culong {.importc: "mpz_get_ui", 
    header: "<gmp.h>".}
proc mpz_getlimbn*(mm_gmp_z: mpz_srcptr; mm_gmp_n: mp_size_t): mp_limb_t {.
    importc: "mpz_getlimbn", header: "<gmp.h>".}
proc mpz_getlimbn*(mm_gmp_z: mpz_t; mm_gmp_n: mp_size_t): mp_limb_t {.
    importc: "mpz_getlimbn", header: "<gmp.h>".}
proc mpz_neg*(mm_gmp_w: mpz_ptr; mm_gmp_u: mpz_srcptr) {.importc: "mpz_neg", 
    header: "<gmp.h>".}
proc mpz_neg*(mm_gmp_w: var mpz_t; mm_gmp_u: mpz_t) {.importc: "mpz_neg", 
    header: "<gmp.h>".}
proc mpz_perfect_square_p*(mm_gmp_a: mpz_srcptr): cint {.
    importc: "mpz_perfect_square_p", header: "<gmp.h>".}
proc mpz_perfect_square_p*(mm_gmp_a: mpz_t): cint {.
    importc: "mpz_perfect_square_p", header: "<gmp.h>".}
proc mpz_popcount*(mm_gmp_u: mpz_srcptr): mp_bitcnt_t {.importc: "mpz_popcount", 
    header: "<gmp.h>".}
proc mpz_popcount*(mm_gmp_u: mpz_t): mp_bitcnt_t {.importc: "mpz_popcount", 
    header: "<gmp.h>".}
proc mpz_set_q*(mm_gmp_w: mpz_ptr; mm_gmp_u: mpq_srcptr) {.importc: "mpz_set_q", 
    header: "<gmp.h>".}
proc mpz_set_q*(mm_gmp_w: var mpz_t; mm_gmp_u: mpq_t) {.importc: "mpz_set_q", 
    header: "<gmp.h>".}
proc mpz_size*(mm_gmp_z: mpz_srcptr): csize {.importc: "mpz_size", 
    header: "<gmp.h>".}
proc mpz_size*(mm_gmp_z: mpz_t): csize {.importc: "mpz_size", header: "<gmp.h>".}
proc mpq_abs*(mm_gmp_w: mpq_ptr; mm_gmp_u: mpq_srcptr) {.importc: "mpq_abs", 
    header: "<gmp.h>".}
proc mpq_abs*(mm_gmp_w: var mpq_t; mm_gmp_u: mpq_t) {.importc: "mpq_abs", 
    header: "<gmp.h>".}
proc mpq_neg*(mm_gmp_w: mpq_ptr; mm_gmp_u: mpq_srcptr) {.importc: "mpq_neg", 
    header: "<gmp.h>".}
proc mpq_neg*(mm_gmp_w: var mpq_t; mm_gmp_u: mpq_t) {.importc: "mpq_neg", 
    header: "<gmp.h>".}
proc mpn_add*(mm_gmp_wp: mp_ptr; mm_gmp_xp: mp_srcptr; mm_gmp_xsize: mp_size_t; 
              mm_gmp_yp: mp_srcptr; mm_gmp_ysize: mp_size_t): mp_limb_t {.
    importc: "mpn_add", header: "<gmp.h>".}
proc mpn_add*(mm_gmp_wp: var mp_limb_t; mm_gmp_xp: var mp_limb_t; 
              mm_gmp_xsize: mp_size_t; mm_gmp_yp: var mp_limb_t; 
              mm_gmp_ysize: mp_size_t): mp_limb_t {.importc: "mpn_add", 
    header: "<gmp.h>".}
proc mpn_add_1*(mm_gmp_dst: mp_ptr; mm_gmp_src: mp_srcptr; 
                mm_gmp_size: mp_size_t; mm_gmp_n: mp_limb_t): mp_limb_t {.
    importc: "mpn_add_1", header: "<gmp.h>".}
proc mpn_add_1*(mm_gmp_dst: var mp_limb_t; mm_gmp_src: var mp_limb_t; 
                mm_gmp_size: mp_size_t; mm_gmp_n: mp_limb_t): mp_limb_t {.
    importc: "mpn_add_1", header: "<gmp.h>".}
proc mpn_cmp*(mm_gmp_xp: mp_srcptr; mm_gmp_yp: mp_srcptr; mm_gmp_size: mp_size_t): cint {.
    importc: "mpn_cmp", header: "<gmp.h>".}
proc mpn_cmp*(mm_gmp_xp: var mp_limb_t; mm_gmp_yp: var mp_limb_t; 
              mm_gmp_size: mp_size_t): cint {.importc: "mpn_cmp", 
    header: "<gmp.h>".}
proc mpz_sgn*(a2: mpz_srcptr): cint {.importc: "mpz_sgn", header: "<gmp.h>".}
proc mpz_sgn*(a2: mpz_t): cint {.importc: "mpz_sgn", header: "<gmp.h>".}
proc mpf_sgn*(a2: mpf_srcptr): cint {.importc: "mpf_sgn", header: "<gmp.h>".}
proc mpf_sgn*(a2: mpf_t): cint {.importc: "mpf_sgn", header: "<gmp.h>".}
proc mpq_sgn*(a2: mpq_srcptr): cint {.importc: "mpq_sgn", header: "<gmp.h>".}
proc mpq_sgn*(a2: mpq_t): cint {.importc: "mpq_sgn", header: "<gmp.h>".}
proc mpz_odd_p*(a2: mpz_srcptr): cint {.importc: "mpz_odd_p",
    header: "<gmp.h>".}
proc mpz_odd_p*(a2: mpz_t): cint {.importc: "mpz_odd_p", header: "<gmp.h>".}
proc mpz_even_p*(a2: mpz_srcptr): cint {.importc: "mpz_even_p",
    header: "<gmp.h>".}
proc mpz_even_p*(a2: mpz_t): cint {.importc: "mpz_even_p", header: "<gmp.h>".}
const 
  GMP_ERROR_NONE* = 0
  GMP_ERROR_UNSUPPORTED_ARGUMENT* = 1
  GMP_ERROR_DIVISION_BY_ZERO* = 2
  GMP_ERROR_SQRT_OF_NEGATIVE* = 4
  GMP_ERROR_INVALID_ARGUMENT* = 8
  
when isMainModule:
  discard
  
