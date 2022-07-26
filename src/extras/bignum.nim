#
# Nim GMP wrapper 
# (c) Copyright 2014 Will Szumski
#
# See the file "COPYING", included in this
# distribution, for details about the copyright.
#

import os

{.passL: "-lgmp".}

{.push header: "<gmp.h>", cdecl.}

#=======================================
# Types
#=======================================

type 
    INNER_C_UNION_5532179898798000430* {.union, importc: "no_name".} = object  
        mp_lc* {.importc: "_mp_lc".}: pointer
  
    mp_limb_t* {.importc: "mp_limb_t", nodecl.} = uint
    mp_limb_signed_t* {.importc: "mp_limb_signed_t", nodecl.} = int
    mp_bitcnt_t* {.importc: "mp_bitcnt_t", nodecl.} = culong
    mm_mpz_struct* {.byref, importc: "__mpz_struct".} = object 
        mp_alloc* {.importc: "_mp_alloc".}: cint
        mp_size* {.importc: "_mp_size".}: cint
        mp_d* {.importc: "_mp_d".}: ptr mp_limb_t

    MP_INT* = mm_mpz_struct
    mpz_t* = mm_mpz_struct
    mp_ptr* = ptr mp_limb_t
    mp_srcptr* = ptr mp_limb_t
    mp_size_t* {.importc: "mp_size_t", nodecl.} = clong
    mp_exp_t* {.importc: "mp_exp_t", nodecl.} = clong
    mm_mpq_struct* {.byref, importc: "__mpq_struct".} = object 
        mp_num* {.importc: "_mp_num".}: mm_mpz_struct
        mp_den* {.importc: "_mp_den".}: mm_mpz_struct

    MP_RAT* = mm_mpq_struct
    mpq_t* = mm_mpq_struct
    mm_mpf_struct* {.byref, importc: "__mpf_struct".} = object 
        mp_prec* {.importc: "_mp_prec".}: cint
        mp_size* {.importc: "_mp_size".}: cint
        mp_exp* {.importc: "_mp_exp".}: mp_exp_t
        mp_d* {.importc: "_mp_d".}: ptr mp_limb_t

    MP_FLT* = mm_mpf_struct
    mpf_t* = mm_mpf_struct
    gmp_randalg_t* = distinct cint
    mm_gmp_randstate_struct* {.importc: "__gmp_randstate_struct".} = object 
        mp_seed* {.importc: "_mp_seed".}: mpz_t
        mp_alg* {.importc: "_mp_alg".}: gmp_randalg_t
        mp_algdata* {.importc: "_mp_algdata".}: INNER_C_UNION_5532179898798000430

    gmp_randstate_t* = mm_gmp_randstate_struct
    mpz_srcptr* = ptr mm_mpz_struct
    mpz_ptr* = ptr mm_mpz_struct
    mpf_srcptr* = ptr mm_mpf_struct
    mpf_ptr* = ptr mm_mpf_struct
    mpq_srcptr* = ptr mm_mpq_struct
    mpq_ptr* = ptr mm_mpq_struct

type
    mpz* = mm_mpz_struct
    mpf* = mm_mpf_struct
    mpq* = mm_mpq_struct

#=======================================
# Constants
#=======================================
  
const 
    GMP_ERROR_NONE* = 0
    GMP_ERROR_UNSUPPORTED_ARGUMENT* = 1
    GMP_ERROR_DIVISION_BY_ZERO* = 2
    GMP_ERROR_SQRT_OF_NEGATIVE* = 4
    GMP_ERROR_INVALID_ARGUMENT* = 8

#=======================================
# Function prototypes
#=======================================

var mp_bits_per_limb* {.importc: "mp_bits_per_limb".}: cint
var gmp_errno* {.importc: "gmp_errno".}: cint
var gmp_version* {.importc: "gmp_version".}: cstring

func mpq_numref*(a2: mpq_ptr): mpz_ptr {.importc: "mpq_numref".}
func mpq_numref*(a2: var mpq_t): mpz_ptr {.importc: "mpq_numref".}
func mpq_denref*(a2: mpq_ptr): mpz_ptr {.importc: "mpq_denref".}
func mpq_denref*(a2: var mpq_t): mpz_ptr {.importc: "mpq_denref".}
func mp_set_memory_functions*(a2: proc (a2: csize_t): pointer; a3: proc (a2: pointer; a3: csize_t; a4: csize_t): pointer; a4: proc (a2: pointer; a3: csize_t)) {.importc: "mp_set_memory_functions".}
func mp_get_memory_functions*(a2: proc (a2: csize_t): pointer; a3: proc (a2: pointer; a3: csize_t; a4: csize_t): pointer; a4: proc (a2: pointer; a3: csize_t)) {.importc: "mp_get_memory_functions".}
func gmp_randinit*(a2: gmp_randstate_t; a3: gmp_randalg_t) {.varargs,importc: "gmp_randinit".}
func gmp_randinit_default*(a2: gmp_randstate_t) {.importc: "gmp_randinit_default".}
func gmp_randinit_lc_2exp*(a2: gmp_randstate_t; a3: mpz_srcptr; a4: culong; a5: mp_bitcnt_t) {.importc: "gmp_randinit_lc_2exp".}
func gmp_randinit_lc_2exp*(a2: gmp_randstate_t; a3: mpz_t; a4: culong; a5: mp_bitcnt_t) {.importc: "gmp_randinit_lc_2exp".}
func gmp_randinit_lc_2exp_size*(a2: gmp_randstate_t; a3: mp_bitcnt_t): cint {.importc: "gmp_randinit_lc_2exp_size".}
func gmp_randinit_mt*(a2: gmp_randstate_t) {.importc: "gmp_randinit_mt".}
func gmp_randinit_set*(a2: gmp_randstate_t; a3: ptr mm_gmp_randstate_struct) {.importc: "gmp_randinit_set".}
func gmp_randseed*(a2: gmp_randstate_t; a3: mpz_srcptr) {.importc: "gmp_randseed".}
func gmp_randseed*(a2: gmp_randstate_t; a3: mpz_t) {.importc: "gmp_randseed".}
func gmp_randseed_ui*(a2: gmp_randstate_t; a3: culong) {.importc: "gmp_randseed_ui".}
func gmp_randclear*(a2: gmp_randstate_t) {.importc: "gmp_randclear".}
func gmp_urandomb_ui*(a2: gmp_randstate_t; a3: culong): culong {.importc: "gmp_urandomb_ui".}
func gmp_urandomm_ui*(a2: gmp_randstate_t; a3: culong): culong {.importc: "gmp_urandomm_ui".}
func gmp_asprintf*(a2: cstringArray; a3: cstring): cint {.varargs,importc: "gmp_asprintf".}
func gmp_fprintf*(a2: File; a3: cstring): cint {.varargs,importc: "gmp_fprintf".}
func gmp_printf*(a2: cstring): cint {.varargs,importc: "gmp_printf".}
func gmp_snprintf*(a2: cstring; a3: csize_t; a4: cstring): cint {.varargs,importc: "gmp_snprintf".}
func gmp_sprintf*(a2: cstring; a3: cstring): cint {.varargs,importc: "gmp_sprintf".}
func gmp_fscanf*(a2: File; a3: cstring): cint {.varargs,importc: "gmp_fscanf".}
func gmp_scanf*(a2: cstring): cint {.varargs,importc: "gmp_scanf".}
func gmp_sscanf*(a2: cstring; a3: cstring): cint {.varargs,importc: "gmp_sscanf".}
func m_mpz_realloc*(a2: mpz_ptr; a3: mp_size_t): pointer {.importc: "_mpz_realloc".}
func m_mpz_realloc*(a2: var mpz_t; a3: mp_size_t): pointer {.importc: "_mpz_realloc".}
func mpz_add*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_add".}
func mpz_add*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_add".}
func mpz_add_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.importc: "mpz_add_ui".}
func mpz_add_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc: "mpz_add_ui".}
func mpz_addmul*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_addmul".}
func mpz_addmul*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_addmul".}
func mpz_addmul_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.importc: "mpz_addmul_ui".}
func mpz_addmul_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc: "mpz_addmul_ui".}
func mpz_and*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_and".}
func mpz_and*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_and".}
func mpz_array_init*(a2: mpz_ptr; a3: mp_size_t; a4: mp_size_t) {.importc: "mpz_array_init".}
func mpz_array_init*(a2: var mpz_t; a3: mp_size_t; a4: mp_size_t) {.importc: "mpz_array_init".}
func mpz_bin_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.importc: "mpz_bin_ui".}
func mpz_bin_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc: "mpz_bin_ui".}
func mpz_bin_uiui*(a2: mpz_ptr; a3: culong; a4: culong) {.importc: "mpz_bin_uiui".}
func mpz_bin_uiui*(a2: var mpz_t; a3: culong; a4: culong) {.importc: "mpz_bin_uiui".}
func mpz_cdiv_q*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_cdiv_q".}
func mpz_cdiv_q*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_cdiv_q".}
func mpz_cdiv_q_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.importc: "mpz_cdiv_q_2exp".}
func mpz_cdiv_q_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.importc: "mpz_cdiv_q_2exp".}
func mpz_cdiv_q_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.importc: "mpz_cdiv_q_ui".}
func mpz_cdiv_q_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.importc: "mpz_cdiv_q_ui".}
func mpz_cdiv_qr*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: mpz_srcptr) {.importc: "mpz_cdiv_qr".}
func mpz_cdiv_qr*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: mpz_t) {.importc: "mpz_cdiv_qr".}
func mpz_cdiv_qr_ui*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: culong): culong {.importc: "mpz_cdiv_qr_ui".}
func mpz_cdiv_qr_ui*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: culong): culong {.importc: "mpz_cdiv_qr_ui".}
func mpz_cdiv_r*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_cdiv_r".}
func mpz_cdiv_r*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_cdiv_r".}
func mpz_cdiv_r_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.importc: "mpz_cdiv_r_2exp".}
func mpz_cdiv_r_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.importc: "mpz_cdiv_r_2exp".}
func mpz_cdiv_r_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.importc: "mpz_cdiv_r_ui".}
func mpz_cdiv_r_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.importc: "mpz_cdiv_r_ui".}
func mpz_cdiv_ui*(a2: mpz_srcptr; a3: culong): culong {.importc: "mpz_cdiv_ui".}
func mpz_cdiv_ui*(a2: mpz_t; a3: culong): culong {.importc: "mpz_cdiv_ui".}
func mpz_clear*(a2: mpz_ptr) {.importc: "mpz_clear".}
func mpz_clear*(a2: var mpz_t) {.importc: "mpz_clear".}
func mpz_clears*(a2: mpz_ptr) {.varargs,importc: "mpz_clears".}
func mpz_clears*(a2: var mpz_t) {.varargs,importc: "mpz_clears".}
func mpz_clrbit*(a2: mpz_ptr; a3: mp_bitcnt_t) {.importc: "mpz_clrbit".}
func mpz_clrbit*(a2: var mpz_t; a3: mp_bitcnt_t) {.importc: "mpz_clrbit".}
func mpz_cmp*(a2: mpz_srcptr; a3: mpz_srcptr): cint {.importc: "mpz_cmp".}
func mpz_cmp*(a2: mpz_t; a3: mpz_t): cint {.importc: "mpz_cmp".}
func mpz_cmp_d*(a2: mpz_srcptr; a3: cdouble): cint {.importc: "mpz_cmp_d".}
func mpz_cmp_d*(a2: mpz_t; a3: cdouble): cint {.importc: "mpz_cmp_d".}
func mpz_cmp_si*(a2: mpz_srcptr; a3: clong): cint {.importc: "_mpz_cmp_si".}
func mpz_cmp_si*(a2: mpz_t; a3: clong): cint {.importc: "_mpz_cmp_si".}
func mpz_cmp_ui*(a2: mpz_srcptr; a3: culong): cint {.importc: "_mpz_cmp_ui".}
func mpz_cmp_ui*(a2: mpz_t; a3: culong): cint {.importc: "_mpz_cmp_ui".}
func mpz_cmpabs*(a2: mpz_srcptr; a3: mpz_srcptr): cint {.importc: "mpz_cmpabs".}
func mpz_cmpabs*(a2: mpz_t; a3: mpz_t): cint {.importc: "mpz_cmpabs".}
func mpz_cmpabs_d*(a2: mpz_srcptr; a3: cdouble): cint {.importc: "mpz_cmpabs_d".}
func mpz_cmpabs_d*(a2: mpz_t; a3: cdouble): cint {.importc: "mpz_cmpabs_d".}
func mpz_cmpabs_ui*(a2: mpz_srcptr; a3: culong): cint {.importc: "mpz_cmpabs_ui".}
func mpz_cmpabs_ui*(a2: mpz_t; a3: culong): cint {.importc: "mpz_cmpabs_ui".}
func mpz_com*(a2: mpz_ptr; a3: mpz_srcptr) {.importc: "mpz_com".}
func mpz_com*(a2: var mpz_t; a3: mpz_t) {.importc: "mpz_com".}
func mpz_combit*(a2: mpz_ptr; a3: mp_bitcnt_t) {.importc: "mpz_combit".}
func mpz_combit*(a2: var mpz_t; a3: mp_bitcnt_t) {.importc: "mpz_combit".}
func mpz_congruent_p*(a2: mpz_srcptr; a3: mpz_srcptr; a4: mpz_srcptr): cint {.importc: "mpz_congruent_p".}
func mpz_congruent_p*(a2: mpz_t; a3: mpz_t; a4: mpz_t): cint {.importc: "mpz_congruent_p".}
func mpz_congruent_2exp_p*(a2: mpz_srcptr; a3: mpz_srcptr; a4: mp_bitcnt_t): cint {.importc: "mpz_congruent_2exp_p".}
func mpz_congruent_2exp_p*(a2: mpz_t; a3: mpz_t; a4: mp_bitcnt_t): cint {.importc: "mpz_congruent_2exp_p".}
func mpz_congruent_ui_p*(a2: mpz_srcptr; a3: culong; a4: culong): cint {.importc: "mpz_congruent_ui_p".}
func mpz_congruent_ui_p*(a2: mpz_t; a3: culong; a4: culong): cint {.importc: "mpz_congruent_ui_p".}
func mpz_divexact*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_divexact".}
func mpz_divexact*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_divexact".}
func mpz_divexact_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.importc: "mpz_divexact_ui".}
func mpz_divexact_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc: "mpz_divexact_ui".}
func mpz_divisible_p*(a2: mpz_srcptr; a3: mpz_srcptr): cint {.importc: "mpz_divisible_p".}
func mpz_divisible_p*(a2: mpz_t; a3: mpz_t): cint {.importc: "mpz_divisible_p".}
func mpz_divisible_ui_p*(a2: mpz_srcptr; a3: culong): cint {.importc: "mpz_divisible_ui_p".}
func mpz_divisible_ui_p*(a2: mpz_t; a3: culong): cint {.importc: "mpz_divisible_ui_p".}
func mpz_divisible_2exp_p*(a2: mpz_srcptr; a3: mp_bitcnt_t): cint {.importc: "mpz_divisible_2exp_p".}
func mpz_divisible_2exp_p*(a2: mpz_t; a3: mp_bitcnt_t): cint {.importc: "mpz_divisible_2exp_p".}
func mpz_dump*(a2: mpz_srcptr) {.importc: "mpz_dump".}
func mpz_dump*(a2: mpz_t) {.importc: "mpz_dump".}
func mpz_export*(a2: pointer; a3: ptr csize_t; a4: cint; a5: csize_t; a6: cint; a7: csize_t; a8: mpz_srcptr): pointer {.importc: "mpz_export".}
func mpz_export*(a2: pointer; a3: ptr csize_t; a4: cint; a5: csize_t; a6: cint; a7: csize_t; a8: mpz_t): pointer {.importc: "mpz_export".}
func mpz_fac_ui*(a2: mpz_ptr; a3: culong) {.importc: "mpz_fac_ui".}
func mpz_fac_ui*(a2: var mpz_t; a3: culong) {.importc: "mpz_fac_ui".}
func mpz_2fac_ui*(a2: mpz_ptr; a3: culong) {.importc: "mpz_2fac_ui".}
func mpz_2fac_ui*(a2: var mpz_t; a3: culong) {.importc: "mpz_2fac_ui".}
func mpz_mfac_uiui*(a2: mpz_ptr; a3: culong; a4: culong) {.importc: "mpz_mfac_uiui".}
func mpz_mfac_uiui*(a2: var mpz_t; a3: culong; a4: culong) {.importc: "mpz_mfac_uiui".}
func mpz_primorial_ui*(a2: mpz_ptr; a3: culong) {.importc: "mpz_primorial_ui".}
func mpz_primorial_ui*(a2: var mpz_t; a3: culong) {.importc: "mpz_primorial_ui".}
func mpz_fdiv_q*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_fdiv_q".}
func mpz_fdiv_q*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_fdiv_q".}
func mpz_fdiv_q_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.importc: "mpz_fdiv_q_2exp".}
func mpz_fdiv_q_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.importc: "mpz_fdiv_q_2exp".}
func mpz_fdiv_q_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.importc: "mpz_fdiv_q_ui".}
func mpz_fdiv_q_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.importc: "mpz_fdiv_q_ui".}
func mpz_fdiv_qr*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: mpz_srcptr) {.importc: "mpz_fdiv_qr".}
func mpz_fdiv_qr*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: mpz_t) {.importc: "mpz_fdiv_qr".}
func mpz_fdiv_qr_ui*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: culong): culong {.importc: "mpz_fdiv_qr_ui".}
func mpz_fdiv_qr_ui*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: culong): culong {.importc: "mpz_fdiv_qr_ui".}
func mpz_fdiv_r*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_fdiv_r".}
func mpz_fdiv_r*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_fdiv_r".}
func mpz_fdiv_r_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.importc: "mpz_fdiv_r_2exp".}
func mpz_fdiv_r_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.importc: "mpz_fdiv_r_2exp".}
func mpz_fdiv_r_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.importc: "mpz_fdiv_r_ui".}
func mpz_fdiv_r_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.importc: "mpz_fdiv_r_ui".}
func mpz_fdiv_ui*(a2: mpz_srcptr; a3: culong): culong {.importc: "mpz_fdiv_ui".}
func mpz_fdiv_ui*(a2: mpz_t; a3: culong): culong {.importc: "mpz_fdiv_ui".}
func mpz_fib_ui*(a2: mpz_ptr; a3: culong) {.importc: "mpz_fib_ui".}
func mpz_fib_ui*(a2: var mpz_t; a3: culong) {.importc: "mpz_fib_ui".}
func mpz_fib2_ui*(a2: mpz_ptr; a3: mpz_ptr; a4: culong) {.importc: "mpz_fib2_ui".}
func mpz_fib2_ui*(a2: var mpz_t; a3: var mpz_t; a4: culong) {.importc: "mpz_fib2_ui".}
func mpz_fits_sint_p*(a2: mpz_srcptr): cint {.importc: "mpz_fits_sint_p".}
func mpz_fits_sint_p*(a2: mpz_t): cint {.importc: "mpz_fits_sint_p".}
func mpz_fits_slong_p*(a2: mpz_srcptr): cint {.importc: "mpz_fits_slong_p".}
func mpz_fits_slong_p*(a2: mpz_t): cint {.importc: "mpz_fits_slong_p".}
func mpz_fits_sshort_p*(a2: mpz_srcptr): cint {.importc: "mpz_fits_sshort_p".}
func mpz_fits_sshort_p*(a2: mpz_t): cint {.importc: "mpz_fits_sshort_p".}
func mpz_gcd*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_gcd".}
func mpz_gcd*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_gcd".}
func mpz_gcd_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.importc: "mpz_gcd_ui".}
func mpz_gcd_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.importc: "mpz_gcd_ui".}
func mpz_gcdext*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_ptr; a5: mpz_srcptr; a6: mpz_srcptr) {.importc: "mpz_gcdext".}
func mpz_gcdext*(a2: var mpz_t; a3: var mpz_t; a4: var mpz_t; a5: mpz_t; a6: mpz_t) {.importc: "mpz_gcdext".}
func mpz_get_d*(a2: mpz_srcptr): cdouble {.importc: "mpz_get_d".}
func mpz_get_d*(a2: mpz_t): cdouble {.importc: "mpz_get_d".}
func mpz_get_d_2exp*(a2: ptr clong; a3: mpz_srcptr): cdouble {.importc: "mpz_get_d_2exp".}
func mpz_get_d_2exp*(a2: ptr clong; a3: mpz_t): cdouble {.importc: "mpz_get_d_2exp".}
func mpz_get_si*(a2: mpz_srcptr): clong {.importc: "mpz_get_si".}
func mpz_get_si*(a2: mpz_t): clong {.importc: "mpz_get_si".}
func mpz_get_str*(a2: cstring; a3: cint; a4: mpz_srcptr): cstring {.importc: "mpz_get_str".}
func mpz_get_str*(a2: cstring; a3: cint; a4: mpz_t): cstring {.importc: "mpz_get_str".}
func mpz_hamdist*(a2: mpz_srcptr; a3: mpz_srcptr): mp_bitcnt_t {.importc: "mpz_hamdist".}
func mpz_hamdist*(a2: mpz_t; a3: mpz_t): mp_bitcnt_t {.importc: "mpz_hamdist".}
func mpz_import*(a2: mpz_ptr; a3: csize_t; a4: cint; a5: csize_t; a6: cint; a7: csize_t; a8: pointer) {.importc: "mpz_import".}
func mpz_import*(a2: var mpz_t; a3: csize_t; a4: cint; a5: csize_t; a6: cint; a7: csize_t; a8: pointer) {.importc: "mpz_import".}
func mpz_init*(a2: mpz_ptr) {.importc: "mpz_init".}
func mpz_init*(a2: var mpz_t) {.importc: "mpz_init".}
func mpz_init2*(a2: mpz_ptr; a3: mp_bitcnt_t) {.importc: "mpz_init2".}
func mpz_init2*(a2: var mpz_t; a3: mp_bitcnt_t) {.importc: "mpz_init2".}
func mpz_inits*(a2: mpz_ptr) {.varargs,importc: "mpz_inits".}
func mpz_inits*(a2: var mpz_t) {.varargs,importc: "mpz_inits".}
func mpz_init_set*(a2: mpz_ptr; a3: mpz_srcptr) {.importc: "mpz_init_set".}
func mpz_init_set*(a2: var mpz_t; a3: mpz_t) {.importc: "mpz_init_set".}
func mpz_init_set_d*(a2: mpz_ptr; a3: cdouble) {.importc: "mpz_init_set_d".}
func mpz_init_set_d*(a2: var mpz_t; a3: cdouble) {.importc: "mpz_init_set_d".}
func mpz_init_set_si*(a2: mpz_ptr; a3: clong) {.importc: "mpz_init_set_si".}
func mpz_init_set_si*(a2: var mpz_t; a3: clong) {.importc: "mpz_init_set_si".}
func mpz_init_set_str*(a2: mpz_ptr; a3: cstring; a4: cint): cint {.importc: "mpz_init_set_str".}
func mpz_init_set_str*(a2: var mpz_t; a3: cstring; a4: cint): cint {.importc: "mpz_init_set_str".}
func mpz_init_set_ui*(a2: mpz_ptr; a3: culong) {.importc: "mpz_init_set_ui".}
func mpz_init_set_ui*(a2: var mpz_t; a3: culong) {.importc: "mpz_init_set_ui".}
func mpz_inp_raw*(a2: mpz_ptr; a3: File): csize_t {.importc: "mpz_inp_raw".}
func mpz_inp_raw*(a2: var mpz_t; a3: File): csize_t {.importc: "mpz_inp_raw".}
func mpz_inp_str*(a2: mpz_ptr; a3: File; a4: cint): csize_t {.importc: "mpz_inp_str".}
func mpz_inp_str*(a2: var mpz_t; a3: File; a4: cint): csize_t {.importc: "mpz_inp_str".}
func mpz_invert*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr): cint {.importc: "mpz_invert".}
func mpz_invert*(a2: var mpz_t; a3: mpz_t; a4: mpz_t): cint {.importc: "mpz_invert".}
func mpz_ior*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_ior".}
func mpz_ior*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_ior".}
func mpz_jacobi*(a2: mpz_srcptr; a3: mpz_srcptr): cint {.importc: "mpz_jacobi".}
func mpz_jacobi*(a2: mpz_t; a3: mpz_t): cint {.importc: "mpz_jacobi".}
func mpz_kronecker_si*(a2: mpz_srcptr; a3: clong): cint {.importc: "mpz_kronecker_si".}
func mpz_kronecker_si*(a2: mpz_t; a3: clong): cint {.importc: "mpz_kronecker_si".}
func mpz_kronecker_ui*(a2: mpz_srcptr; a3: culong): cint {.importc: "mpz_kronecker_ui".}
func mpz_kronecker_ui*(a2: mpz_t; a3: culong): cint {.importc: "mpz_kronecker_ui".}
func mpz_si_kronecker*(a2: clong; a3: mpz_srcptr): cint {.importc: "mpz_si_kronecker".}
func mpz_si_kronecker*(a2: clong; a3: mpz_t): cint {.importc: "mpz_si_kronecker".}
func mpz_ui_kronecker*(a2: culong; a3: mpz_srcptr): cint {.importc: "mpz_ui_kronecker".}
func mpz_ui_kronecker*(a2: culong; a3: mpz_t): cint {.importc: "mpz_ui_kronecker".}
func mpz_lcm*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_lcm".}
func mpz_lcm*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_lcm".}
func mpz_lcm_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.importc: "mpz_lcm_ui".}
func mpz_lcm_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc: "mpz_lcm_ui".}
func mpz_lucnum_ui*(a2: mpz_ptr; a3: culong) {.importc: "mpz_lucnum_ui".}
func mpz_lucnum_ui*(a2: var mpz_t; a3: culong) {.importc: "mpz_lucnum_ui".}
func mpz_lucnum2_ui*(a2: mpz_ptr; a3: mpz_ptr; a4: culong) {.importc: "mpz_lucnum2_ui".}
func mpz_lucnum2_ui*(a2: var mpz_t; a3: var mpz_t; a4: culong) {.importc: "mpz_lucnum2_ui".}
func mpz_millerrabin*(a2: mpz_srcptr; a3: cint): cint {.importc: "mpz_millerrabin".}
func mpz_millerrabin*(a2: mpz_t; a3: cint): cint {.importc: "mpz_millerrabin".}
func mpz_mod*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_mod".}
func mpz_mod*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_mod".}
func mpz_mul*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_mul".}
func mpz_mul*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_mul".}
func mpz_mul_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.importc: "mpz_mul_2exp".}
func mpz_mul_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.importc: "mpz_mul_2exp".}
func mpz_mul_si*(a2: mpz_ptr; a3: mpz_srcptr; a4: clong) {.importc: "mpz_mul_si".}
func mpz_mul_si*(a2: var mpz_t; a3: mpz_t; a4: clong) {.importc: "mpz_mul_si".}
func mpz_mul_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.importc: "mpz_mul_ui".}
func mpz_mul_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc: "mpz_mul_ui".}
func mpz_nextprime*(a2: mpz_ptr; a3: mpz_srcptr) {.importc: "mpz_nextprime".}
func mpz_nextprime*(a2: var mpz_t; a3: mpz_t) {.importc: "mpz_nextprime".}
func mpz_out_raw*(a2: File; a3: mpz_srcptr): csize_t {.importc: "mpz_out_raw".}
func mpz_out_raw*(a2: File; a3: mpz_t): csize_t {.importc: "mpz_out_raw".}
func mpz_out_str*(a2: File; a3: cint; a4: mpz_srcptr): csize_t {.importc: "mpz_out_str".}
func mpz_out_str*(a2: File; a3: cint; a4: mpz_t): csize_t {.importc: "mpz_out_str".}
func mpz_perfect_power_p*(a2: mpz_srcptr): cint {.importc: "mpz_perfect_power_p".}
func mpz_perfect_power_p*(a2: mpz_t): cint {.importc: "mpz_perfect_power_p".}
func mpz_pow_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.importc: "mpz_pow_ui".}
func mpz_pow_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc: "mpz_pow_ui".}
func mpz_powm*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr; a5: mpz_srcptr) {.importc: "mpz_powm".}
func mpz_powm*(a2: var mpz_t; a3: mpz_t; a4: mpz_t; a5: mpz_t) {.importc: "mpz_powm".}
func mpz_powm_sec*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr; a5: mpz_srcptr) {.importc: "mpz_powm_sec".}
func mpz_powm_sec*(a2: var mpz_t; a3: mpz_t; a4: mpz_t; a5: mpz_t) {.importc: "mpz_powm_sec".}
func mpz_powm_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong; a5: mpz_srcptr) {.importc: "mpz_powm_ui".}
func mpz_powm_ui*(a2: var mpz_t; a3: mpz_t; a4: culong; a5: mpz_t) {.importc: "mpz_powm_ui".}
func mpz_probab_prime_p*(a2: mpz_srcptr; a3: cint): cint {.importc: "mpz_probab_prime_p".}
func mpz_probab_prime_p*(a2: mpz_t; a3: cint): cint {.importc: "mpz_probab_prime_p".}
func mpz_random*(a2: mpz_ptr; a3: mp_size_t) {.importc: "mpz_random".}
func mpz_random*(a2: var mpz_t; a3: mp_size_t) {.importc: "mpz_random".}
func mpz_random2*(a2: mpz_ptr; a3: mp_size_t) {.importc: "mpz_random2".}
func mpz_random2*(a2: var mpz_t; a3: mp_size_t) {.importc: "mpz_random2".}
func mpz_realloc2*(a2: mpz_ptr; a3: mp_bitcnt_t) {.importc: "mpz_realloc2".}
func mpz_realloc2*(a2: var mpz_t; a3: mp_bitcnt_t) {.importc: "mpz_realloc2".}
func mpz_remove*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr): mp_bitcnt_t {.importc: "mpz_remove".}
func mpz_remove*(a2: var mpz_t; a3: mpz_t; a4: mpz_t): mp_bitcnt_t {.importc: "mpz_remove".}
func mpz_root*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): cint {.importc: "mpz_root".}
func mpz_root*(a2: var mpz_t; a3: mpz_t; a4: culong): cint {.importc: "mpz_root".}
func mpz_rootrem*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: culong) {.importc: "mpz_rootrem".}
func mpz_rootrem*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: culong) {.importc: "mpz_rootrem".}
func mpz_rrandomb*(a2: mpz_ptr; a3: gmp_randstate_t; a4: mp_bitcnt_t) {.importc: "mpz_rrandomb".}
func mpz_rrandomb*(a2: var mpz_t; a3: gmp_randstate_t; a4: mp_bitcnt_t) {.importc: "mpz_rrandomb".}
func mpz_scan0*(a2: mpz_srcptr; a3: mp_bitcnt_t): mp_bitcnt_t {.importc: "mpz_scan0".}
func mpz_scan0*(a2: mpz_t; a3: mp_bitcnt_t): mp_bitcnt_t {.importc: "mpz_scan0".}
func mpz_scan1*(a2: mpz_srcptr; a3: mp_bitcnt_t): mp_bitcnt_t {.importc: "mpz_scan1".}
func mpz_scan1*(a2: mpz_t; a3: mp_bitcnt_t): mp_bitcnt_t {.importc: "mpz_scan1".}
func mpz_set*(a2: mpz_ptr; a3: mpz_srcptr) {.importc: "mpz_set".}
func mpz_set*(a2: var mpz_t; a3: mpz_t) {.importc: "mpz_set".}
func mpz_set_d*(a2: mpz_ptr; a3: cdouble) {.importc: "mpz_set_d".}
func mpz_set_d*(a2: var mpz_t; a3: cdouble) {.importc: "mpz_set_d".}
func mpz_set_f*(a2: mpz_ptr; a3: mpf_srcptr) {.importc: "mpz_set_f".}
func mpz_set_f*(a2: var mpz_t; a3: mpf_t) {.importc: "mpz_set_f".}
func mpz_set_si*(a2: mpz_ptr; a3: clong) {.importc: "mpz_set_si".}
func mpz_set_si*(a2: var mpz_t; a3: clong) {.importc: "mpz_set_si".}
func mpz_set_str*(a2: mpz_ptr; a3: cstring; a4: cint): cint {.importc: "mpz_set_str".}
func mpz_set_str*(a2: var mpz_t; a3: cstring; a4: cint): cint {.importc: "mpz_set_str".}
func mpz_set_ui*(a2: mpz_ptr; a3: culong) {.importc: "mpz_set_ui".}
func mpz_set_ui*(a2: var mpz_t; a3: culong) {.importc: "mpz_set_ui".}
func mpz_setbit*(a2: mpz_ptr; a3: mp_bitcnt_t) {.importc: "mpz_setbit".}
func mpz_setbit*(a2: var mpz_t; a3: mp_bitcnt_t) {.importc: "mpz_setbit".}
func mpz_sizeinbase*(a2: mpz_srcptr; a3: cint): csize_t {.importc: "mpz_sizeinbase".}
func mpz_sizeinbase*(a2: mpz_t; a3: cint): csize_t {.importc: "mpz_sizeinbase".}
func mpz_sqrt*(a2: mpz_ptr; a3: mpz_srcptr) {.importc: "mpz_sqrt".}
func mpz_sqrt*(a2: var mpz_t; a3: mpz_t) {.importc: "mpz_sqrt".}
func mpz_sqrtrem*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr) {.importc: "mpz_sqrtrem".}
func mpz_sqrtrem*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t) {.importc: "mpz_sqrtrem".}
func mpz_sub*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_sub".}
func mpz_sub*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_sub".}
func mpz_sub_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.importc: "mpz_sub_ui".}
func mpz_sub_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc: "mpz_sub_ui".}
func mpz_ui_sub*(a2: mpz_ptr; a3: culong; a4: mpz_srcptr) {.importc: "mpz_ui_sub".}
func mpz_ui_sub*(a2: var mpz_t; a3: culong; a4: mpz_t) {.importc: "mpz_ui_sub".}
func mpz_submul*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_submul".}
func mpz_submul*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_submul".}
func mpz_submul_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong) {.importc: "mpz_submul_ui".}
func mpz_submul_ui*(a2: var mpz_t; a3: mpz_t; a4: culong) {.importc: "mpz_submul_ui".}
func mpz_swap*(a2: mpz_ptr; a3: mpz_ptr) {.importc: "mpz_swap".}
func mpz_swap*(a2: var mpz_t; a3: var mpz_t) {.importc: "mpz_swap".}
func mpz_tdiv_ui*(a2: mpz_srcptr; a3: culong): culong {.importc: "mpz_tdiv_ui".}
func mpz_tdiv_ui*(a2: mpz_t; a3: culong): culong {.importc: "mpz_tdiv_ui".}
func mpz_tdiv_q*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_tdiv_q".}
func mpz_tdiv_q*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_tdiv_q".}
func mpz_tdiv_q_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.importc: "mpz_tdiv_q_2exp".}
func mpz_tdiv_q_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.importc: "mpz_tdiv_q_2exp".}
func mpz_tdiv_q_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.importc: "mpz_tdiv_q_ui".}
func mpz_tdiv_q_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.importc: "mpz_tdiv_q_ui".}
func mpz_tdiv_qr*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: mpz_srcptr) {.importc: "mpz_tdiv_qr".}
func mpz_tdiv_qr*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: mpz_t) {.importc: "mpz_tdiv_qr".}
func mpz_tdiv_qr_ui*(a2: mpz_ptr; a3: mpz_ptr; a4: mpz_srcptr; a5: culong): culong {.importc: "mpz_tdiv_qr_ui".}
func mpz_tdiv_qr_ui*(a2: var mpz_t; a3: var mpz_t; a4: mpz_t; a5: culong): culong {.importc: "mpz_tdiv_qr_ui".}
func mpz_tdiv_r*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_tdiv_r".}
func mpz_tdiv_r*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_tdiv_r".}
func mpz_tdiv_r_2exp*(a2: mpz_ptr; a3: mpz_srcptr; a4: mp_bitcnt_t) {.importc: "mpz_tdiv_r_2exp".}
func mpz_tdiv_r_2exp*(a2: var mpz_t; a3: mpz_t; a4: mp_bitcnt_t) {.importc: "mpz_tdiv_r_2exp".}
func mpz_tdiv_r_ui*(a2: mpz_ptr; a3: mpz_srcptr; a4: culong): culong {.importc: "mpz_tdiv_r_ui".}
func mpz_tdiv_r_ui*(a2: var mpz_t; a3: mpz_t; a4: culong): culong {.importc: "mpz_tdiv_r_ui".}
func mpz_tstbit*(a2: mpz_srcptr; a3: mp_bitcnt_t): cint {.importc: "mpz_tstbit".}
func mpz_tstbit*(a2: mpz_t; a3: mp_bitcnt_t): cint {.importc: "mpz_tstbit".}
func mpz_ui_pow_ui*(a2: mpz_ptr; a3: culong; a4: culong) {.importc: "mpz_ui_pow_ui".}
func mpz_ui_pow_ui*(a2: var mpz_t; a3: culong; a4: culong) {.importc: "mpz_ui_pow_ui".}
func mpz_urandomb*(a2: mpz_ptr; a3: gmp_randstate_t; a4: mp_bitcnt_t) {.importc: "mpz_urandomb".}
func mpz_urandomb*(a2: var mpz_t; a3: gmp_randstate_t; a4: mp_bitcnt_t) {.importc: "mpz_urandomb".}
func mpz_urandomm*(a2: mpz_ptr; a3: gmp_randstate_t; a4: mpz_srcptr) {.importc: "mpz_urandomm".}
func mpz_urandomm*(a2: var mpz_t; a3: gmp_randstate_t; a4: mpz_t) {.importc: "mpz_urandomm".}
func mpz_xor*(a2: mpz_ptr; a3: mpz_srcptr; a4: mpz_srcptr) {.importc: "mpz_xor".}
func mpz_xor*(a2: var mpz_t; a3: mpz_t; a4: mpz_t) {.importc: "mpz_xor".}
func mpz_limbs_read*(a2: mpz_srcptr): mp_srcptr {.importc: "mpz_limbs_read".}
func mpz_limbs_read*(a2: mpz_t): mp_srcptr {.importc: "mpz_limbs_read".}
func mpz_limbs_write*(a2: mpz_ptr; a3: mp_size_t): mp_ptr {.importc: "mpz_limbs_write".}
func mpz_limbs_write*(a2: var mpz_t; a3: mp_size_t): mp_ptr {.importc: "mpz_limbs_write".}
func mpz_limbs_modify*(a2: mpz_ptr; a3: mp_size_t): mp_ptr {.importc: "mpz_limbs_modify".}
func mpz_limbs_modify*(a2: var mpz_t; a3: mp_size_t): mp_ptr {.importc: "mpz_limbs_modify".}
func mpz_limbs_finish*(a2: mpz_ptr; a3: mp_size_t) {.importc: "mpz_limbs_finish".}
func mpz_limbs_finish*(a2: var mpz_t; a3: mp_size_t) {.importc: "mpz_limbs_finish".}
func mpz_roinit_n*(a2: mpz_ptr; a3: mp_srcptr; a4: mp_size_t): mpz_srcptr {.importc: "mpz_roinit_n".}
func mpz_roinit_n*(a2: var mpz_t; a3: var mp_limb_t; a4: mp_size_t): mpz_srcptr {.importc: "mpz_roinit_n".}
func mpq_add*(a2: mpq_ptr; a3: mpq_srcptr; a4: mpq_srcptr) {.importc: "mpq_add".}
func mpq_add*(a2: var mpq_t; a3: mpq_t; a4: mpq_t) {.importc: "mpq_add".}
func mpq_canonicalize*(a2: mpq_ptr) {.importc: "mpq_canonicalize".}
func mpq_canonicalize*(a2: var mpq_t) {.importc: "mpq_canonicalize".}
func mpq_clear*(a2: mpq_ptr) {.importc: "mpq_clear".}
func mpq_clear*(a2: var mpq_t) {.importc: "mpq_clear".}
func mpq_clears*(a2: mpq_ptr) {.varargs,importc: "mpq_clears".}
func mpq_clears*(a2: var mpq_t) {.varargs,importc: "mpq_clears".}
func mpq_cmp*(a2: mpq_srcptr; a3: mpq_srcptr): cint {.importc: "mpq_cmp".}
func mpq_cmp*(a2: mpq_t; a3: mpq_t): cint {.importc: "mpq_cmp".}
func m_mpq_cmp_si*(a2: mpq_srcptr; a3: clong; a4: culong): cint {.importc: "_mpq_cmp_si".}
func m_mpq_cmp_si*(a2: mpq_t; a3: clong; a4: culong): cint {.importc: "_mpq_cmp_si".}
func m_mpq_cmp_ui*(a2: mpq_srcptr; a3: culong; a4: culong): cint {.importc: "_mpq_cmp_ui".}
func m_mpq_cmp_ui*(a2: mpq_t; a3: culong; a4: culong): cint {.importc: "_mpq_cmp_ui".}
func mpq_div*(a2: mpq_ptr; a3: mpq_srcptr; a4: mpq_srcptr) {.importc: "mpq_div".}
func mpq_div*(a2: var mpq_t; a3: mpq_t; a4: mpq_t) {.importc: "mpq_div".}
func mpq_div_2exp*(a2: mpq_ptr; a3: mpq_srcptr; a4: mp_bitcnt_t) {.importc: "mpq_div_2exp".}
func mpq_div_2exp*(a2: var mpq_t; a3: mpq_t; a4: mp_bitcnt_t) {.importc: "mpq_div_2exp".}
func mpq_equal*(a2: mpq_srcptr; a3: mpq_srcptr): cint {.importc: "mpq_equal".}
func mpq_equal*(a2: mpq_t; a3: mpq_t): cint {.importc: "mpq_equal".}
func mpq_get_num*(a2: mpz_ptr; a3: mpq_srcptr) {.importc: "mpq_get_num".}
func mpq_get_num*(a2: var mpz_t; a3: mpq_t) {.importc: "mpq_get_num".}
func mpq_get_den*(a2: mpz_ptr; a3: mpq_srcptr) {.importc: "mpq_get_den".}
func mpq_get_den*(a2: var mpz_t; a3: mpq_t) {.importc: "mpq_get_den".}
func mpq_get_d*(a2: mpq_srcptr): cdouble {.importc: "mpq_get_d".}
func mpq_get_d*(a2: mpq_t): cdouble {.importc: "mpq_get_d".}
func mpq_get_str*(a2: cstring; a3: cint; a4: mpq_srcptr): cstring {.importc: "mpq_get_str".}
func mpq_get_str*(a2: cstring; a3: cint; a4: mpq_t): cstring {.importc: "mpq_get_str".}
func mpq_init*(a2: mpq_ptr) {.importc: "mpq_init".}
func mpq_init*(a2: var mpq_t) {.importc: "mpq_init".}
func mpq_inits*(a2: mpq_ptr) {.varargs,importc: "mpq_inits".}
func mpq_inits*(a2: var mpq_t) {.varargs,importc: "mpq_inits".}
func mpq_inp_str*(a2: mpq_ptr; a3: File; a4: cint): csize_t {.importc: "mpq_inp_str".}
func mpq_inp_str*(a2: var mpq_t; a3: File; a4: cint): csize_t {.importc: "mpq_inp_str".}
func mpq_inv*(a2: mpq_ptr; a3: mpq_srcptr) {.importc: "mpq_inv".}
func mpq_inv*(a2: var mpq_t; a3: mpq_t) {.importc: "mpq_inv".}
func mpq_mul*(a2: mpq_ptr; a3: mpq_srcptr; a4: mpq_srcptr) {.importc: "mpq_mul".}
func mpq_mul*(a2: var mpq_t; a3: mpq_t; a4: mpq_t) {.importc: "mpq_mul".}
func mpq_mul_2exp*(a2: mpq_ptr; a3: mpq_srcptr; a4: mp_bitcnt_t) {.importc: "mpq_mul_2exp".}
func mpq_mul_2exp*(a2: var mpq_t; a3: mpq_t; a4: mp_bitcnt_t) {.importc: "mpq_mul_2exp".}
func mpq_out_str*(a2: File; a3: cint; a4: mpq_srcptr): csize_t {.importc: "mpq_out_str".}
func mpq_out_str*(a2: File; a3: cint; a4: mpq_t): csize_t {.importc: "mpq_out_str".}
func mpq_set*(a2: mpq_ptr; a3: mpq_srcptr) {.importc: "mpq_set".}
func mpq_set*(a2: var mpq_t; a3: mpq_t) {.importc: "mpq_set".}
func mpq_set_d*(a2: mpq_ptr; a3: cdouble) {.importc: "mpq_set_d".}
func mpq_set_d*(a2: var mpq_t; a3: cdouble) {.importc: "mpq_set_d".}
func mpq_set_den*(a2: mpq_ptr; a3: mpz_srcptr) {.importc: "mpq_set_den".}
func mpq_set_den*(a2: var mpq_t; a3: mpz_t) {.importc: "mpq_set_den".}
func mpq_set_f*(a2: mpq_ptr; a3: mpf_srcptr) {.importc: "mpq_set_f".}
func mpq_set_f*(a2: var mpq_t; a3: mpf_t) {.importc: "mpq_set_f".}
func mpq_set_num*(a2: mpq_ptr; a3: mpz_srcptr) {.importc: "mpq_set_num".}
func mpq_set_num*(a2: var mpq_t; a3: mpz_t) {.importc: "mpq_set_num".}
func mpq_set_si*(a2: mpq_ptr; a3: clong; a4: culong) {.importc: "mpq_set_si".}
func mpq_set_si*(a2: var mpq_t; a3: clong; a4: culong) {.importc: "mpq_set_si".}
func mpq_set_str*(a2: mpq_ptr; a3: cstring; a4: cint): cint {.importc: "mpq_set_str".}
func mpq_set_str*(a2: var mpq_t; a3: cstring; a4: cint): cint {.importc: "mpq_set_str".}
func mpq_set_ui*(a2: mpq_ptr; a3: culong; a4: culong) {.importc: "mpq_set_ui".}
func mpq_set_ui*(a2: var mpq_t; a3: culong; a4: culong) {.importc: "mpq_set_ui".}
func mpq_set_z*(a2: mpq_ptr; a3: mpz_srcptr) {.importc: "mpq_set_z".}
func mpq_set_z*(a2: var mpq_t; a3: mpz_t) {.importc: "mpq_set_z".}
func mpq_sub*(a2: mpq_ptr; a3: mpq_srcptr; a4: mpq_srcptr) {.importc: "mpq_sub".}
func mpq_sub*(a2: var mpq_t; a3: mpq_t; a4: mpq_t) {.importc: "mpq_sub".}
func mpq_swap*(a2: mpq_ptr; a3: mpq_ptr) {.importc: "mpq_swap".}
func mpq_swap*(a2: var mpq_t; a3: var mpq_t) {.importc: "mpq_swap".}
func mpf_abs*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "mpf_abs".}
func mpf_abs*(a2: var mpf_t; a3: mpf_t) {.importc: "mpf_abs".}
func mpf_add*(a2: mpf_ptr; a3: mpf_srcptr; a4: mpf_srcptr) {.importc: "mpf_add".}
func mpf_add*(a2: var mpf_t; a3: mpf_t; a4: mpf_t) {.importc: "mpf_add".}
func mpf_add_ui*(a2: mpf_ptr; a3: mpf_srcptr; a4: culong) {.importc: "mpf_add_ui".}
func mpf_add_ui*(a2: var mpf_t; a3: mpf_t; a4: culong) {.importc: "mpf_add_ui".}
func mpf_ceil*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "mpf_ceil".}
func mpf_ceil*(a2: var mpf_t; a3: mpf_t) {.importc: "mpf_ceil".}
func mpf_clear*(a2: mpf_ptr) {.importc: "mpf_clear".}
func mpf_clear*(a2: var mpf_t) {.importc: "mpf_clear".}
func mpf_clears*(a2: mpf_ptr) {.varargs,importc: "mpf_clears".}
func mpf_clears*(a2: var mpf_t) {.varargs,importc: "mpf_clears".}
func mpf_cmp*(a2: mpf_srcptr; a3: mpf_srcptr): cint {.importc: "mpf_cmp".}
func mpf_cmp*(a2: mpf_t; a3: mpf_t): cint {.importc: "mpf_cmp".}
func mpf_cmp_d*(a2: mpf_srcptr; a3: cdouble): cint {.importc: "mpf_cmp_d".}
func mpf_cmp_d*(a2: mpf_t; a3: cdouble): cint {.importc: "mpf_cmp_d".}
func mpf_cmp_si*(a2: mpf_srcptr; a3: clong): cint {.importc: "mpf_cmp_si".}
func mpf_cmp_si*(a2: mpf_t; a3: clong): cint {.importc: "mpf_cmp_si".}
func mpf_cmp_ui*(a2: mpf_srcptr; a3: culong): cint {.importc: "mpf_cmp_ui".}
func mpf_cmp_ui*(a2: mpf_t; a3: culong): cint {.importc: "mpf_cmp_ui".}
func mpf_div*(a2: mpf_ptr; a3: mpf_srcptr; a4: mpf_srcptr) {.importc: "mpf_div".}
func mpf_div*(a2: var mpf_t; a3: mpf_t; a4: mpf_t) {.importc: "mpf_div".}
func mpf_div_2exp*(a2: mpf_ptr; a3: mpf_srcptr; a4: mp_bitcnt_t) {.importc: "mpf_div_2exp".}
func mpf_div_2exp*(a2: var mpf_t; a3: mpf_t; a4: mp_bitcnt_t) {.importc: "mpf_div_2exp".}
func mpf_div_ui*(a2: mpf_ptr; a3: mpf_srcptr; a4: culong) {.importc: "mpf_div_ui".}
func mpf_div_ui*(a2: var mpf_t; a3: mpf_t; a4: culong) {.importc: "mpf_div_ui".}
func mpf_dump*(a2: mpf_srcptr) {.importc: "mpf_dump".}
func mpf_dump*(a2: mpf_t) {.importc: "mpf_dump".}
func mpf_eq*(a2: mpf_srcptr; a3: mpf_srcptr; a4: mp_bitcnt_t): cint {.importc: "mpf_eq".}
func mpf_eq*(a2: mpf_t; a3: mpf_t; a4: mp_bitcnt_t): cint {.importc: "mpf_eq".}
func mpf_fits_sint_p*(a2: mpf_srcptr): cint {.importc: "mpf_fits_sint_p".}
func mpf_fits_sint_p*(a2: mpf_t): cint {.importc: "mpf_fits_sint_p".}
func mpf_fits_slong_p*(a2: mpf_srcptr): cint {.importc: "mpf_fits_slong_p".}
func mpf_fits_slong_p*(a2: mpf_t): cint {.importc: "mpf_fits_slong_p".}
func mpf_fits_sshort_p*(a2: mpf_srcptr): cint {.importc: "mpf_fits_sshort_p".}
func mpf_fits_sshort_p*(a2: mpf_t): cint {.importc: "mpf_fits_sshort_p".}
func mpf_fits_uint_p*(a2: mpf_srcptr): cint {.importc: "mpf_fits_uint_p".}
func mpf_fits_uint_p*(a2: mpf_t): cint {.importc: "mpf_fits_uint_p".}
func mpf_fits_ulong_p*(a2: mpf_srcptr): cint {.importc: "mpf_fits_ulong_p".}
func mpf_fits_ulong_p*(a2: mpf_t): cint {.importc: "mpf_fits_ulong_p".}
func mpf_fits_ushort_p*(a2: mpf_srcptr): cint {.importc: "mpf_fits_ushort_p".}
func mpf_fits_ushort_p*(a2: mpf_t): cint {.importc: "mpf_fits_ushort_p".}
func mpf_floor*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "mpf_floor".}
func mpf_floor*(a2: var mpf_t; a3: mpf_t) {.importc: "mpf_floor".}
func mpf_get_d*(a2: mpf_srcptr): cdouble {.importc: "mpf_get_d".}
func mpf_get_d*(a2: mpf_t): cdouble {.importc: "mpf_get_d".}
func mpf_get_d_2exp*(a2: ptr clong; a3: mpf_srcptr): cdouble {.importc: "mpf_get_d_2exp".}
func mpf_get_d_2exp*(a2: ptr clong; a3: mpf_t): cdouble {.importc: "mpf_get_d_2exp".}
func mpf_get_default_prec*(): mp_bitcnt_t {.importc: "mpf_get_default_prec".}
func mpf_get_prec*(a2: mpf_srcptr): mp_bitcnt_t {.importc: "mpf_get_prec".}
func mpf_get_prec*(a2: mpf_t): mp_bitcnt_t {.importc: "mpf_get_prec".}
func mpf_get_si*(a2: mpf_srcptr): clong {.importc: "mpf_get_si".}
func mpf_get_si*(a2: mpf_t): clong {.importc: "mpf_get_si".}
func mpf_get_str*(a2: cstring; a3: ptr mp_exp_t; a4: cint; a5: csize_t; a6: mpf_srcptr): cstring {.importc: "mpf_get_str".}
func mpf_get_str*(a2: cstring; a3: var mp_exp_t; a4: cint; a5: csize_t; a6: mpf_t): cstring {.importc: "mpf_get_str".}
func mpf_get_ui*(a2: mpf_srcptr): culong {.importc: "mpf_get_ui".}
func mpf_get_ui*(a2: mpf_t): culong {.importc: "mpf_get_ui".}
func mpf_init*(a2: mpf_ptr) {.importc: "mpf_init".}
func mpf_init*(a2: var mpf_t) {.importc: "mpf_init".}
func mpf_init2*(a2: mpf_ptr; a3: mp_bitcnt_t) {.importc: "mpf_init2".}
func mpf_init2*(a2: var mpf_t; a3: mp_bitcnt_t) {.importc: "mpf_init2".}
func mpf_inits*(a2: mpf_ptr) {.varargs,importc: "mpf_inits".}
func mpf_inits*(a2: var mpf_t) {.varargs,importc: "mpf_inits".}
func mpf_init_set*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "mpf_init_set".}
func mpf_init_set*(a2: var mpf_t; a3: mpf_t) {.importc: "mpf_init_set".}
func mpf_init_set_d*(a2: mpf_ptr; a3: cdouble) {.importc: "mpf_init_set_d".}
func mpf_init_set_d*(a2: var mpf_t; a3: cdouble) {.importc: "mpf_init_set_d".}
func mpf_init_set_si*(a2: mpf_ptr; a3: clong) {.importc: "mpf_init_set_si".}
func mpf_init_set_si*(a2: var mpf_t; a3: clong) {.importc: "mpf_init_set_si".}
func mpf_init_set_str*(a2: mpf_ptr; a3: cstring; a4: cint): cint {.importc: "mpf_init_set_str".}
func mpf_init_set_str*(a2: var mpf_t; a3: cstring; a4: cint): cint {.importc: "mpf_init_set_str".}
func mpf_init_set_ui*(a2: mpf_ptr; a3: culong) {.importc: "mpf_init_set_ui".}
func mpf_init_set_ui*(a2: var mpf_t; a3: culong) {.importc: "mpf_init_set_ui".}
func mpf_inp_str*(a2: mpf_ptr; a3: File; a4: cint): csize_t {.importc: "mpf_inp_str".}
func mpf_inp_str*(a2: var mpf_t; a3: File; a4: cint): csize_t {.importc: "mpf_inp_str".}
func mpf_integer_p*(a2: mpf_srcptr): cint {.importc: "mpf_integer_p".}
func mpf_integer_p*(a2: mpf_t): cint {.importc: "mpf_integer_p".}
func mpf_mul*(a2: mpf_ptr; a3: mpf_srcptr; a4: mpf_srcptr) {.importc: "mpf_mul".}
func mpf_mul*(a2: var mpf_t; a3: mpf_t; a4: mpf_t) {.importc: "mpf_mul".}
func mpf_mul_2exp*(a2: mpf_ptr; a3: mpf_srcptr; a4: mp_bitcnt_t) {.importc: "mpf_mul_2exp".}
func mpf_mul_2exp*(a2: var mpf_t; a3: mpf_t; a4: mp_bitcnt_t) {.importc: "mpf_mul_2exp".}
func mpf_mul_ui*(a2: mpf_ptr; a3: mpf_srcptr; a4: culong) {.importc: "mpf_mul_ui".}
func mpf_mul_ui*(a2: var mpf_t; a3: mpf_t; a4: culong) {.importc: "mpf_mul_ui".}
func mpf_neg*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "mpf_neg".}
func mpf_neg*(a2: var mpf_t; a3: mpf_t) {.importc: "mpf_neg".}
func mpf_out_str*(a2: File; a3: cint; a4: csize_t; a5: mpf_srcptr): csize_t {.importc: "mpf_out_str".}
func mpf_out_str*(a2: File; a3: cint; a4: csize_t; a5: mpf_t): csize_t {.importc: "mpf_out_str".}
func mpf_pow_ui*(a2: mpf_ptr; a3: mpf_srcptr; a4: culong) {.importc: "mpf_pow_ui".}
func mpf_pow_ui*(a2: var mpf_t; a3: mpf_t; a4: culong) {.importc: "mpf_pow_ui".}
func mpf_random2*(a2: mpf_ptr; a3: mp_size_t; a4: mp_exp_t) {.importc: "mpf_random2".}
func mpf_random2*(a2: var mpf_t; a3: mp_size_t; a4: mp_exp_t) {.importc: "mpf_random2".}
func mpf_reldiff*(a2: mpf_ptr; a3: mpf_srcptr; a4: mpf_srcptr) {.importc: "mpf_reldiff".}
func mpf_reldiff*(a2: var mpf_t; a3: mpf_t; a4: mpf_t) {.importc: "mpf_reldiff".}
func mpf_set*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "mpf_set".}
func mpf_set*(a2: var mpf_t; a3: mpf_t) {.importc: "mpf_set".}
func mpf_set_d*(a2: mpf_ptr; a3: cdouble) {.importc: "mpf_set_d".}
func mpf_set_d*(a2: var mpf_t; a3: cdouble) {.importc: "mpf_set_d".}
func mpf_set_default_prec*(a2: mp_bitcnt_t) {.importc: "mpf_set_default_prec".}
func mpf_set_prec*(a2: mpf_ptr; a3: mp_bitcnt_t) {.importc: "mpf_set_prec".}
func mpf_set_prec*(a2: var mpf_t; a3: mp_bitcnt_t) {.importc: "mpf_set_prec".}
func mpf_set_prec_raw*(a2: mpf_ptr; a3: mp_bitcnt_t) {.importc: "mpf_set_prec_raw".}
func mpf_set_prec_raw*(a2: var mpf_t; a3: mp_bitcnt_t) {.importc: "mpf_set_prec_raw".}
func mpf_set_q*(a2: mpf_ptr; a3: mpq_srcptr) {.importc: "mpf_set_q".}
func mpf_set_q*(a2: var mpf_t; a3: mpq_t) {.importc: "mpf_set_q".}
func mpf_set_si*(a2: mpf_ptr; a3: clong) {.importc: "mpf_set_si".}
func mpf_set_si*(a2: var mpf_t; a3: clong) {.importc: "mpf_set_si".}
func mpf_set_str*(a2: mpf_ptr; a3: cstring; a4: cint): cint {.importc: "mpf_set_str".}
func mpf_set_str*(a2: var mpf_t; a3: cstring; a4: cint): cint {.importc: "mpf_set_str".}
func mpf_set_ui*(a2: mpf_ptr; a3: culong) {.importc: "mpf_set_ui".}
func mpf_set_ui*(a2: var mpf_t; a3: culong) {.importc: "mpf_set_ui".}
func mpf_set_z*(a2: mpf_ptr; a3: mpz_srcptr) {.importc: "mpf_set_z".}
func mpf_set_z*(a2: var mpf_t; a3: mpz_t) {.importc: "mpf_set_z".}
func mpf_size*(a2: mpf_srcptr): csize_t {.importc: "mpf_size".}
func mpf_size*(a2: mpf_t): csize_t {.importc: "mpf_size".}
func mpf_sqrt*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "mpf_sqrt".}
func mpf_sqrt*(a2: var mpf_t; a3: mpf_t) {.importc: "mpf_sqrt".}
func mpf_sqrt_ui*(a2: mpf_ptr; a3: culong) {.importc: "mpf_sqrt_ui".}
func mpf_sqrt_ui*(a2: var mpf_t; a3: culong) {.importc: "mpf_sqrt_ui".}
func mpf_sub*(a2: mpf_ptr; a3: mpf_srcptr; a4: mpf_srcptr) {.importc: "mpf_sub".}
func mpf_sub*(a2: var mpf_t; a3: mpf_t; a4: mpf_t) {.importc: "mpf_sub".}
func mpf_sub_ui*(a2: mpf_ptr; a3: mpf_srcptr; a4: culong) {.importc: "mpf_sub_ui".}
func mpf_sub_ui*(a2: var mpf_t; a3: mpf_t; a4: culong) {.importc: "mpf_sub_ui".}
func mpf_swap*(a2: mpf_ptr; a3: mpf_ptr) {.importc: "mpf_swap".}
func mpf_swap*(a2: var mpf_t; a3: var mpf_t) {.importc: "mpf_swap".}
func mpf_trunc*(a2: mpf_ptr; a3: mpf_srcptr) {.importc: "mpf_trunc".}
func mpf_trunc*(a2: var mpf_t; a3: mpf_t) {.importc: "mpf_trunc".}
func mpf_ui_div*(a2: mpf_ptr; a3: culong; a4: mpf_srcptr) {.importc: "mpf_ui_div".}
func mpf_ui_div*(a2: var mpf_t; a3: culong; a4: mpf_t) {.importc: "mpf_ui_div".}
func mpf_ui_sub*(a2: mpf_ptr; a3: culong; a4: mpf_srcptr) {.importc: "mpf_ui_sub".}
func mpf_ui_sub*(a2: var mpf_t; a3: culong; a4: mpf_t) {.importc: "mpf_ui_sub".}
func mpf_urandomb*(a2: mpf_t; a3: gmp_randstate_t; a4: mp_bitcnt_t) {.importc: "mpf_urandomb".}
func mpn_add_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t): mp_limb_t {.importc: "mpn_add_n".}
func mpn_add_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t): mp_limb_t {.importc: "mpn_add_n".}
func mpn_addmul_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.importc: "mpn_addmul_1".}
func mpn_addmul_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.importc: "mpn_addmul_1".}
func mpn_divexact_by3c*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.importc: "mpn_divexact_by3c".}
func mpn_divexact_by3c*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.importc: "mpn_divexact_by3c".}
func mpn_divrem*(a2: mp_ptr; a3: mp_size_t; a4: mp_ptr; a5: mp_size_t; a6: mp_srcptr; a7: mp_size_t): mp_limb_t {.importc: "mpn_divrem".}
func mpn_divrem*(a2: var mp_limb_t; a3: mp_size_t; a4: var mp_limb_t; a5: mp_size_t; a6: var mp_limb_t; a7: mp_size_t): mp_limb_t {.importc: "mpn_divrem".}
func mpn_divrem_1*(a2: mp_ptr; a3: mp_size_t; a4: mp_srcptr; a5: mp_size_t; a6: mp_limb_t): mp_limb_t {.importc: "mpn_divrem_1".}
func mpn_divrem_1*(a2: var mp_limb_t; a3: mp_size_t; a4: var mp_limb_t; a5: mp_size_t; a6: mp_limb_t): mp_limb_t {.importc: "mpn_divrem_1".}
func mpn_divrem_2*(a2: mp_ptr; a3: mp_size_t; a4: mp_ptr; a5: mp_size_t; a6: mp_srcptr): mp_limb_t {.importc: "mpn_divrem_2".}
func mpn_divrem_2*(a2: var mp_limb_t; a3: mp_size_t; a4: var mp_limb_t; a5: mp_size_t; a6: var mp_limb_t): mp_limb_t {.importc: "mpn_divrem_2".}
func mpn_div_qr_1*(a2: mp_ptr; a3: ptr mp_limb_t; a4: mp_srcptr; a5: mp_size_t; a6: mp_limb_t): mp_limb_t {.importc: "mpn_div_qr_1".}
func mpn_div_qr_1*(a2: var mp_limb_t; a3: ptr mp_limb_t; a4: var mp_limb_t; a5: mp_size_t; a6: mp_limb_t): mp_limb_t {.importc: "mpn_div_qr_1".}
func mpn_div_qr_2*(a2: mp_ptr; a3: mp_ptr; a4: mp_srcptr; a5: mp_size_t; a6: mp_srcptr): mp_limb_t {.importc: "mpn_div_qr_2".}
func mpn_div_qr_2*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t; a6: var mp_limb_t): mp_limb_t {.importc: "mpn_div_qr_2".}
func mpn_gcd*(a2: mp_ptr; a3: mp_ptr; a4: mp_size_t; a5: mp_ptr; a6: mp_size_t): mp_size_t {.importc: "mpn_gcd".}
func mpn_gcd*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: var mp_limb_t; a6: mp_size_t): mp_size_t {.importc: "mpn_gcd".}
func mpn_gcd_1*(a2: mp_srcptr; a3: mp_size_t; a4: mp_limb_t): mp_limb_t {.importc: "mpn_gcd_1".}
func mpn_gcd_1*(a2: var mp_limb_t; a3: mp_size_t; a4: mp_limb_t): mp_limb_t {.importc: "mpn_gcd_1".}
func mpn_gcdext_1*(a2: ptr mp_limb_signed_t; a3: ptr mp_limb_signed_t; a4: mp_limb_t; a5: mp_limb_t): mp_limb_t {.importc: "mpn_gcdext_1".}
func mpn_gcdext*(a2: mp_ptr; a3: mp_ptr; a4: ptr mp_size_t; a5: mp_ptr; a6: mp_size_t; a7: mp_ptr; a8: mp_size_t): mp_size_t {.importc: "mpn_gcdext".}
func mpn_gcdext*(a2: var mp_limb_t; a3: var mp_limb_t; a4: ptr mp_size_t; a5: var mp_limb_t; a6: mp_size_t; a7: var mp_limb_t; a8: mp_size_t): mp_size_t {.importc: "mpn_gcdext".}
func mpn_get_str*(a2: ptr uint8; a3: cint; a4: mp_ptr; a5: mp_size_t): csize_t {.importc: "mpn_get_str".}
func mpn_get_str*(a2: ptr uint8; a3: cint; a4: var mp_limb_t; a5: mp_size_t): csize_t {.importc: "mpn_get_str".}
func mpn_hamdist*(a2: mp_srcptr; a3: mp_srcptr; a4: mp_size_t): mp_bitcnt_t {.importc: "mpn_hamdist".}
func mpn_hamdist*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t): mp_bitcnt_t {.importc: "mpn_hamdist".}
func mpn_lshift*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: cuint): mp_limb_t {.importc: "mpn_lshift".}
func mpn_lshift*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: cuint): mp_limb_t {.importc: "mpn_lshift".}
func mpn_mod_1*(a2: mp_srcptr; a3: mp_size_t; a4: mp_limb_t): mp_limb_t {.importc: "mpn_mod_1".}
func mpn_mod_1*(a2: var mp_limb_t; a3: mp_size_t; a4: mp_limb_t): mp_limb_t {.importc: "mpn_mod_1".}
func mpn_mul*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_srcptr; a6: mp_size_t): mp_limb_t {.importc: "mpn_mul".}
func mpn_mul*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: var mp_limb_t; a6: mp_size_t): mp_limb_t {.importc: "mpn_mul".}
func mpn_mul_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.importc: "mpn_mul_1".}
func mpn_mul_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.importc: "mpn_mul_1".}
func mpn_mul_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.importc: "mpn_mul_n".}
func mpn_mul_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t) {.importc: "mpn_mul_n".}
func mpn_sqr*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t) {.importc: "mpn_sqr".}
func mpn_sqr*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t) {.importc: "mpn_sqr".}
func mpn_neg*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t): mp_limb_t {.importc: "mpn_neg".}
func mpn_neg*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t): mp_limb_t {.importc: "mpn_neg".}
func mpn_com*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t) {.importc: "mpn_com".}
func mpn_com*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t) {.importc: "mpn_com".}
func mpn_perfect_square_p*(a2: mp_srcptr; a3: mp_size_t): cint {.importc: "mpn_perfect_square_p".}
func mpn_perfect_square_p*(a2: var mp_limb_t; a3: mp_size_t): cint {.importc: "mpn_perfect_square_p".}
func mpn_perfect_power_p*(a2: mp_srcptr; a3: mp_size_t): cint {.importc: "mpn_perfect_power_p".}
func mpn_perfect_power_p*(a2: var mp_limb_t; a3: mp_size_t): cint {.importc: "mpn_perfect_power_p".}
func mpn_popcount*(a2: mp_srcptr; a3: mp_size_t): mp_bitcnt_t {.importc: "mpn_popcount".}
func mpn_popcount*(a2: var mp_limb_t; a3: mp_size_t): mp_bitcnt_t {.importc: "mpn_popcount".}
func mpn_pow_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t; a6: mp_ptr): mp_size_t {.importc: "mpn_pow_1".}
func mpn_pow_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: mp_limb_t; a6: var mp_limb_t): mp_size_t {.importc: "mpn_pow_1".}
func mpn_preinv_mod_1*(a2: mp_srcptr; a3: mp_size_t; a4: mp_limb_t; a5: mp_limb_t): mp_limb_t {.importc: "mpn_preinv_mod_1".}
func mpn_preinv_mod_1*(a2: var mp_limb_t; a3: mp_size_t; a4: mp_limb_t; a5: mp_limb_t): mp_limb_t {.importc: "mpn_preinv_mod_1".}
func mpn_random*(a2: mp_ptr; a3: mp_size_t) {.importc: "mpn_random".}
func mpn_random*(a2: var mp_limb_t; a3: mp_size_t) {.importc: "mpn_random".}
func mpn_random2*(a2: mp_ptr; a3: mp_size_t) {.importc: "mpn_random2".}
func mpn_random2*(a2: var mp_limb_t; a3: mp_size_t) {.importc: "mpn_random2".}
func mpn_rshift*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: cuint): mp_limb_t {.importc: "mpn_rshift".}
func mpn_rshift*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: cuint): mp_limb_t {.importc: "mpn_rshift".}
func mpn_scan0*(a2: mp_srcptr; a3: mp_bitcnt_t): mp_bitcnt_t {.importc: "mpn_scan0".}
func mpn_scan0*(a2: var mp_limb_t; a3: mp_bitcnt_t): mp_bitcnt_t {.importc: "mpn_scan0".}
func mpn_scan1*(a2: mp_srcptr; a3: mp_bitcnt_t): mp_bitcnt_t {.importc: "mpn_scan1".}
func mpn_scan1*(a2: var mp_limb_t; a3: mp_bitcnt_t): mp_bitcnt_t {.importc: "mpn_scan1".}
func mpn_set_str*(a2: mp_ptr; a3: ptr uint8; a4: csize_t; a5: cint): mp_size_t {.importc: "mpn_set_str".}
func mpn_set_str*(a2: var mp_limb_t; a3: ptr uint8; a4: csize_t; a5: cint): mp_size_t {.importc: "mpn_set_str".}
func mpn_sizeinbase*(a2: mp_srcptr; a3: mp_size_t; a4: cint): csize_t {.importc: "mpn_sizeinbase".}
func mpn_sizeinbase*(a2: var mp_limb_t; a3: mp_size_t; a4: cint): csize_t {.importc: "mpn_sizeinbase".}
func mpn_sqrtrem*(a2: mp_ptr; a3: mp_ptr; a4: mp_srcptr; a5: mp_size_t): mp_size_t {.importc: "mpn_sqrtrem".}
func mpn_sqrtrem*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t): mp_size_t {.importc: "mpn_sqrtrem".}
func mpn_sub*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_srcptr; a6: mp_size_t): mp_limb_t {.importc: "mpn_sub".}
func mpn_sub*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: var mp_limb_t; a6: mp_size_t): mp_limb_t {.importc: "mpn_sub".}
func mpn_sub_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.importc: "mpn_sub_1".}
func mpn_sub_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.importc: "mpn_sub_1".}
func mpn_sub_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t): mp_limb_t {.importc: "mpn_sub_n".}
func mpn_sub_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t): mp_limb_t {.importc: "mpn_sub_n".}
func mpn_submul_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.importc: "mpn_submul_1".}
func mpn_submul_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: mp_limb_t): mp_limb_t {.importc: "mpn_submul_1".}
func mpn_tdiv_qr*(a2: mp_ptr; a3: mp_ptr; a4: mp_size_t; a5: mp_srcptr; a6: mp_size_t; a7: mp_srcptr; a8: mp_size_t) {.importc: "mpn_tdiv_qr".}
func mpn_tdiv_qr*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: var mp_limb_t; a6: mp_size_t; a7: var mp_limb_t; a8: mp_size_t) {.importc: "mpn_tdiv_qr".}
func mpn_and_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.importc: "mpn_and_n".}
func mpn_and_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t) {.importc: "mpn_and_n".}
func mpn_andn_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.importc: "mpn_andn_n".}
func mpn_andn_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t) {.importc: "mpn_andn_n".}
func mpn_nand_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.importc: "mpn_nand_n".}
func mpn_nand_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t) {.importc: "mpn_nand_n".}
func mpn_ior_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.importc: "mpn_ior_n".}
func mpn_ior_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t) {.importc: "mpn_ior_n".}
func mpn_iorn_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.importc: "mpn_iorn_n".}
func mpn_iorn_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t) {.importc: "mpn_iorn_n".}
func mpn_nior_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.importc: "mpn_nior_n".}
func mpn_nior_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t) {.importc: "mpn_nior_n".}
func mpn_xor_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.importc: "mpn_xor_n".}
func mpn_xor_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t) {.importc: "mpn_xor_n".}
func mpn_xnor_n*(a2: mp_ptr; a3: mp_srcptr; a4: mp_srcptr; a5: mp_size_t) {.importc: "mpn_xnor_n".}
func mpn_xnor_n*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t) {.importc: "mpn_xnor_n".}
func mpn_copyi*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t) {.importc: "mpn_copyi".}
func mpn_copyi*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t) {.importc: "mpn_copyi".}
func mpn_copyd*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t) {.importc: "mpn_copyd".}
func mpn_copyd*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t) {.importc: "mpn_copyd".}
func mpn_zero*(a2: mp_ptr; a3: mp_size_t) {.importc: "mpn_zero".}
func mpn_zero*(a2: var mp_limb_t; a3: mp_size_t) {.importc: "mpn_zero".}
func mpn_cnd_add_n*(a2: mp_limb_t; a3: mp_ptr; a4: mp_srcptr; a5: mp_srcptr; a6: mp_size_t): mp_limb_t {.importc: "mpn_cnd_add_n".}
func mpn_cnd_add_n*(a2: mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: var mp_limb_t; a6: mp_size_t): mp_limb_t {.importc: "mpn_cnd_add_n".}
func mpn_cnd_sub_n*(a2: mp_limb_t; a3: mp_ptr; a4: mp_srcptr; a5: mp_srcptr; a6: mp_size_t): mp_limb_t {.importc: "mpn_cnd_sub_n".}
func mpn_cnd_sub_n*(a2: mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: var mp_limb_t; a6: mp_size_t): mp_limb_t {.importc: "mpn_cnd_sub_n".}
func mpn_sec_add_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t; a6: mp_ptr): mp_limb_t {.importc: "mpn_sec_add_1".}
func mpn_sec_add_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: mp_limb_t; a6: var mp_limb_t): mp_limb_t {.importc: "mpn_sec_add_1".}
func mpn_sec_add_1_itch*(a2: mp_size_t): mp_size_t {.importc: "mpn_sec_add_1_itch".}
func mpn_sec_sub_1*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_limb_t; a6: mp_ptr): mp_limb_t {.importc: "mpn_sec_sub_1".}
func mpn_sec_sub_1*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: mp_limb_t; a6: var mp_limb_t): mp_limb_t {.importc: "mpn_sec_sub_1".}
func mpn_sec_sub_1_itch*(a2: mp_size_t): mp_size_t {.importc: "mpn_sec_sub_1_itch".}
func mpn_sec_mul*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_srcptr; a6: mp_size_t; a7: mp_ptr) {.importc: "mpn_sec_mul".}
func mpn_sec_mul*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: var mp_limb_t; a6: mp_size_t; a7: var mp_limb_t) {.importc: "mpn_sec_mul".}
func mpn_sec_mul_itch*(a2: mp_size_t; a3: mp_size_t): mp_size_t {.importc: "mpn_sec_mul_itch".}
func mpn_sec_sqr*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_ptr) {.importc: "mpn_sec_sqr".}
func mpn_sec_sqr*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: var mp_limb_t) {.importc: "mpn_sec_sqr".}
func mpn_sec_sqr_itch*(a2: mp_size_t): mp_size_t {.importc: "mpn_sec_sqr_itch".}
func mpn_sec_powm*(a2: mp_ptr; a3: mp_srcptr; a4: mp_size_t; a5: mp_srcptr; a6: mp_bitcnt_t; a7: mp_srcptr; a8: mp_size_t; a9: mp_ptr) {.importc: "mpn_sec_powm".}
func mpn_sec_powm*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: var mp_limb_t; a6: mp_bitcnt_t; a7: var mp_limb_t; a8: mp_size_t; a9: var mp_limb_t) {.importc: "mpn_sec_powm".}
func mpn_sec_powm_itch*(a2: mp_size_t; a3: mp_bitcnt_t; a4: mp_size_t): mp_size_t {.importc: "mpn_sec_powm_itch".}
func mpn_sec_tabselect*(a2: ptr mp_limb_t; a3: ptr mp_limb_t; a4: mp_size_t; a5: mp_size_t; a6: mp_size_t) {.importc: "mpn_sec_tabselect".}
func mpn_sec_div_qr*(a2: mp_ptr; a3: mp_ptr; a4: mp_size_t; a5: mp_srcptr; a6: mp_size_t; a7: mp_ptr): mp_limb_t {.importc: "mpn_sec_div_qr".}
func mpn_sec_div_qr*(a2: var mp_limb_t; a3: var mp_limb_t; a4: mp_size_t; a5: var mp_limb_t; a6: mp_size_t; a7: var mp_limb_t): mp_limb_t {.importc: "mpn_sec_div_qr".}
func mpn_sec_div_qr_itch*(a2: mp_size_t; a3: mp_size_t): mp_size_t {.importc: "mpn_sec_div_qr_itch".}
func mpn_sec_div_r*(a2: mp_ptr; a3: mp_size_t; a4: mp_srcptr; a5: mp_size_t; a6: mp_ptr) {.importc: "mpn_sec_div_r".}
func mpn_sec_div_r*(a2: var mp_limb_t; a3: mp_size_t; a4: var mp_limb_t; a5: mp_size_t; a6: var mp_limb_t) {.importc: "mpn_sec_div_r".}
func mpn_sec_div_r_itch*(a2: mp_size_t; a3: mp_size_t): mp_size_t {.importc: "mpn_sec_div_r_itch".}
func mpn_sec_invert*(a2: mp_ptr; a3: mp_ptr; a4: mp_srcptr; a5: mp_size_t; a6: mp_bitcnt_t; a7: mp_ptr): cint {.importc: "mpn_sec_invert".}
func mpn_sec_invert*(a2: var mp_limb_t; a3: var mp_limb_t; a4: var mp_limb_t; a5: mp_size_t; a6: mp_bitcnt_t; a7: var mp_limb_t): cint {.importc: "mpn_sec_invert".}
func mpn_sec_invert_itch*(a2: mp_size_t): mp_size_t {.importc: "mpn_sec_invert_itch".}
func mpz_abs*(mm_gmp_w: mpz_ptr; mm_gmp_u: mpz_srcptr) {.importc: "mpz_abs".}
func mpz_abs*(mm_gmp_w: var mpz_t; mm_gmp_u: mpz_t) {.importc: "mpz_abs".}
func mpz_fits_uint_p*(mm_gmp_z: mpz_srcptr): cint {.importc: "mpz_fits_uint_p".}
func mpz_fits_uint_p*(mm_gmp_z: mpz_t): cint {.importc: "mpz_fits_uint_p".}
func mpz_fits_ulong_p*(mm_gmp_z: mpz_srcptr): cint {.importc: "mpz_fits_ulong_p".}
func mpz_fits_ulong_p*(mm_gmp_z: mpz_t): cint {.importc: "mpz_fits_ulong_p".}
func mpz_fits_ushort_p*(mm_gmp_z: mpz_srcptr): cint {.importc: "mpz_fits_ushort_p".}
func mpz_fits_ushort_p*(mm_gmp_z: mpz_t): cint {.importc: "mpz_fits_ushort_p".}
func mpz_get_ui*(mm_gmp_z: mpz_srcptr): culong {.importc: "mpz_get_ui".}
func mpz_get_ui*(mm_gmp_z: mpz_t): culong {.importc: "mpz_get_ui".}
func mpz_getlimbn*(mm_gmp_z: mpz_srcptr; mm_gmp_n: mp_size_t): mp_limb_t {.importc: "mpz_getlimbn".}
func mpz_getlimbn*(mm_gmp_z: mpz_t; mm_gmp_n: mp_size_t): mp_limb_t {.importc: "mpz_getlimbn".}
func mpz_neg*(mm_gmp_w: mpz_ptr; mm_gmp_u: mpz_srcptr) {.importc: "mpz_neg".}
func mpz_neg*(mm_gmp_w: var mpz_t; mm_gmp_u: mpz_t) {.importc: "mpz_neg".}
func mpz_perfect_square_p*(mm_gmp_a: mpz_srcptr): cint {.importc: "mpz_perfect_square_p".}
func mpz_perfect_square_p*(mm_gmp_a: mpz_t): cint {.importc: "mpz_perfect_square_p".}
func mpz_popcount*(mm_gmp_u: mpz_srcptr): mp_bitcnt_t {.importc: "mpz_popcount".}
func mpz_popcount*(mm_gmp_u: mpz_t): mp_bitcnt_t {.importc: "mpz_popcount".}
func mpz_set_q*(mm_gmp_w: mpz_ptr; mm_gmp_u: mpq_srcptr) {.importc: "mpz_set_q".}
func mpz_set_q*(mm_gmp_w: var mpz_t; mm_gmp_u: mpq_t) {.importc: "mpz_set_q".}
func mpz_size*(mm_gmp_z: mpz_srcptr): csize_t {.importc: "mpz_size".}
func mpz_size*(mm_gmp_z: mpz_t): csize_t {.importc: "mpz_size".}
func mpq_abs*(mm_gmp_w: mpq_ptr; mm_gmp_u: mpq_srcptr) {.importc: "mpq_abs".}
func mpq_abs*(mm_gmp_w: var mpq_t; mm_gmp_u: mpq_t) {.importc: "mpq_abs".}
func mpq_neg*(mm_gmp_w: mpq_ptr; mm_gmp_u: mpq_srcptr) {.importc: "mpq_neg".}
func mpq_neg*(mm_gmp_w: var mpq_t; mm_gmp_u: mpq_t) {.importc: "mpq_neg".}
func mpn_add*(mm_gmp_wp: mp_ptr; mm_gmp_xp: mp_srcptr; mm_gmp_xsize: mp_size_t; mm_gmp_yp: mp_srcptr; mm_gmp_ysize: mp_size_t): mp_limb_t {.importc: "mpn_add".}
func mpn_add*(mm_gmp_wp: var mp_limb_t; mm_gmp_xp: var mp_limb_t; mm_gmp_xsize: mp_size_t; mm_gmp_yp: var mp_limb_t; mm_gmp_ysize: mp_size_t): mp_limb_t {.importc: "mpn_add".}
func mpn_add_1*(mm_gmp_dst: mp_ptr; mm_gmp_src: mp_srcptr; mm_gmp_size: mp_size_t; mm_gmp_n: mp_limb_t): mp_limb_t {.importc: "mpn_add_1".}
func mpn_add_1*(mm_gmp_dst: var mp_limb_t; mm_gmp_src: var mp_limb_t; mm_gmp_size: mp_size_t; mm_gmp_n: mp_limb_t): mp_limb_t {.importc: "mpn_add_1".}
func mpn_cmp*(mm_gmp_xp: mp_srcptr; mm_gmp_yp: mp_srcptr; mm_gmp_size: mp_size_t): cint {.importc: "mpn_cmp".}
func mpn_cmp*(mm_gmp_xp: var mp_limb_t; mm_gmp_yp: var mp_limb_t; mm_gmp_size: mp_size_t): cint {.importc: "mpn_cmp".}
func mpz_sgn*(a2: mpz_srcptr): cint {.importc: "mpz_sgn".}
func mpz_sgn*(a2: mpz_t): cint {.importc: "mpz_sgn".}
func mpf_sgn*(a2: mpf_srcptr): cint {.importc: "mpf_sgn".}
func mpf_sgn*(a2: mpf_t): cint {.importc: "mpf_sgn".}
func mpq_sgn*(a2: mpq_srcptr): cint {.importc: "mpq_sgn".}
func mpq_sgn*(a2: mpq_t): cint {.importc: "mpq_sgn".}
func mpz_odd_p*(a2: mpz_srcptr): cint {.importc: "mpz_odd_p".}
func mpz_odd_p*(a2: mpz_t): cint {.importc: "mpz_odd_p".}
func mpz_even_p*(a2: mpz_srcptr): cint {.importc: "mpz_even_p".}
func mpz_even_p*(a2: mpz_t): cint {.importc: "mpz_even_p".}

{.pop.}




  
when isMainModule:
  discard
  


type Int* = ref mpz_t
  ## An Int represents a signed multi-precision integer.

func isLLP64: bool {.compileTime.} =
  # LLP64 programming model
  sizeof(clong) != sizeof(int)

{.push hints: off.}

# DECLARED_BUT_NOT_USED

when defined(windows):
  const LLP64_ULONG_MAX = 0xFFFFFFFF

  proc fitsLLP64Long(x: int): bool =
    # Returns whether `x` fits in a LLP64 signed long int.
    return x >= low(clong) and x <= high(clong)

  proc fitsLLP64ULong(x: int): bool =
    # Returns whether `x` fits in a LLP64 unsigned long int.
    return x >= 0 and x <= LLP64_ULONG_MAX

{.pop.}

func validBase(base: cint) =
  # Validates the given base.
  if base < -36 or (base > -2 and base < 2) or base > 62:
    raise newException(ValueError, "Invalid base")

func finalizeInt(z: Int) =
  # Finalizer - release the memory allocated to the mpz.
  mpz_clear(z[])

func newInt*(x: culong): Int =
  ## Allocates and returns a new Int set to `x`.
  new(result, finalizeInt)
  mpz_init_set_ui(result[], x)

func newInt*(x: int = 0): Int =
  ## Allocates and returns a new Int set to `x`.
  new(result, finalizeInt)
  when isLLP64():
    if x.fitsLLP64Long:
      mpz_init_set_si(result[], x.clong)
    elif x.fitsLLP64ULong:
      mpz_init_set_ui(result[], x.culong)
    else:
      mpz_init(result[])
      if x < 0: result[].mp_size = -1 else: result[].mp_size = 1
      if x < 0 and x > low(int):
        result[].mp_d[] = (-x).mp_limb_t
      else:
        result[].mp_d[] = x.mp_limb_t
  else:
    mpz_init_set_si(result[], x.clong)

func newInt*(s: string, base: cint = 10): Int =
  ## Allocates and returns a new Int set to `s`, interpreted in the given `base`.
  validBase(base)
  new(result, finalizeInt)
  if mpz_init_set_str(result[], s, base) == -1:
    raise newException(ValueError, "String not in correct base")

func clear*(z: Int) =
  ## Clears the allocated space used by the number.
  ##
  ## This normally happens on a finalizer call, but if you want immediate
  ## deallocation you can call it.
  GCunref(z)
  finalizeInt(z)

func clone*(z: Int): Int =
  ## Returns a clone of `z`.
  new(result, finalizeInt)
  mpz_init_set(result[], z[])

func digits*(z: Int, base: range[(2.cint) .. (62.cint)] = 10): csize_t =
  ## Returns the size of `z` measured in number of digits in the given `base`.
  ## The sign of `z` is ignored, just the absolute value is used.
  mpz_sizeinbase(z[], base)

func `$`*(z: Int, base: cint = 10): string =
  ## The stringify operator for an Int argument. Returns `z` converted to a
  ## string in the given `base`.
  validBase(base)
  result = newString(digits(z, base) + 2)
  result.setLen(mpz_get_str((cstring)result, base, z[]).len)

func set*(z, x: Int): Int =
  ## Sets `z` to `x` and returns `z`.
  result = z
  mpz_set(result[], x[])

func set*(z: Int, x: culong): Int =
  ## Sets `z` to `x` and returns `z`.
  result = z
  mpz_set_ui(result[], x)

func set*(z: Int, x: int): Int =
  ## Sets `z` to `x` and returns `z`.
  result = z
  when isLLP64():
    if x.fitsLLP64Long:
      mpz_set_si(result[], x.clong)
    elif x.fitsLLP64ULong:
      mpz_set_ui(result[], x.culong)
    else:
      if x < 0: result[].mp_size = -1 else: result[].mp_size = 1
      if x < 0 and x > low(int):
        result[].mp_d[] = (-x).mp_limb_t
      else:
        result[].mp_d[] = x.mp_limb_t
  else:
    mpz_set_si(result[], x.clong)

func set*(z: Int, s: string, base: cint = 10): Int =
  ## Sets `z` to the value of `s`, interpreted in the given `base`, and returns `z`.
  validBase(base)
  result = z
  if mpz_set_str(result[], s, base) == -1:
    raise newException(ValueError, "String not in correct base")

func swap*(x: Int, y: Int) =
  ## Swaps the values `x` and `y` efficiently.
  mpz_swap(x[], y[])

func cmp*(x, y: Int): cint =
  ## Compares `x` and `y` and returns:
  ## ::
  ##   -1 if x <  y
  ##    0 if x == y
  ##   +1 if x >  y
  result = mpz_cmp(x[], y[])
  if result < 0:
    result = -1
  elif result > 0:
    result = 1

func cmp*(x: Int, y: culong): cint =
  ## Compares `x` and `y` and returns:
  ## ::
  ##   -1 if x <  y
  ##    0 if x == y
  ##   +1 if x >  y
  result = mpz_cmp_ui(x[], y)
  if result < 0:
    result = -1
  elif result > 0:
    result = 1

func cmp*(x: Int, y: int): cint =
  ## Compares `x` and `y` and returns:
  ## ::
  ##   -1 if x <  y
  ##    0 if x == y
  ##   +1 if x >  y
  when isLLP64():
    if y.fitsLLP64Long:
      result = mpz_cmp_si(x[], y.clong)
    elif y.fitsLLP64ULong:
      return x.cmp(y.culong)
    else:
      var size: cint
      if y < 0: size = -1 else: size = 1
      if x[].mp_size != size:
        if x[].mp_size != 0:
          result = x[].mp_size
        else:
          if size == -1: result = 1 else: result = -1
      else:
        var op1, op2: mp_limb_t
        if size == -1 and y > low(int):
          op1 = (-y).mp_limb_t
          op2 = x[].mp_d[]
        else:
          if y == low(int):
            op1 = y.mp_limb_t
            op2 = x[].mp_d[]
          else:
            op1 = x[].mp_d[]
            op2 = y.mp_limb_t

        if op1 == op2:
          result = 0
        elif op1 > op2:
          result = 1
        else:
          result = -1
  else:
    result = mpz_cmp_si(x[], y.clong)

  if result < 0:
    result = -1
  elif result > 0:
    result = 1

func `==`*(x: Int, y: int | culong | Int): bool =
  ## Returns whether `x` equals `y`.
  cmp(x, y) == 0

func `==`*(x: int | culong, y: Int): bool =
  ## Returns whether `x` equals `y`.
  cmp(y, x) == 0

func `<`*(x: Int, y: int | culong | Int): bool =
  ## Returns whether `x` is less than `y`.
  cmp(x, y) == -1

func `<`*(x: int | culong, y: Int): bool =
  ## Returns whether `x` is less than `y`.
  cmp(y, x) == 1

func `<=`*(x: Int, y: int | culong | Int): bool =
  ## Returns whether `x` is less than or equal `y`.
  let c = cmp(x, y)
  c == 0 or c == -1

func `<=`*(x: int | culong, y: Int): bool =
  ## Returns whether `x` is less than or equal `y`.
  let c = cmp(y, x)
  c == 0 or c == 1

func sign*(x: Int): cint =
  ## Allows faster testing for negative, zero, and positive. Returns:
  ## ::
  ##   -1 if x <  0
  ##    0 if x == 0
  ##   +1 if x >  0
  mpz_sgn(x[])

func positive*(x: Int): bool =
  ## Returns whether `x` is positive or zero.
  x.sign >= 0

func negative*(x: Int): bool =
  ## Returns whether `x` is negative.
  x.sign < 0

func isZero*(x: Int): bool =
  ## Returns whether `x` is zero.
  x.sign == 0

func abs*(z, x: Int): Int =
  ## Sets `z` to |x| (the absolute value of `x`) and returns `z`.
  result = z
  mpz_abs(result[], x[])

func abs*(x: Int): Int =
  ## Returns the absolute value of `x`.
  newInt().abs(x)

func add*(z, x, y: Int): Int =
  ## Sets `z` to the sum x+y and returns `z`.
  result = z
  mpz_add(result[], x[], y[])

func add*(z, x: Int, y: culong): Int =
  ## Sets `z` to the sum x+y and returns `z`.
  result = z
  mpz_add_ui(result[], x[], y)

func add*(z, x: Int, y: int): Int =
  ## Sets `z` to the sum x+y and returns `z`.
  when isLLP64():
    if y.fitsLLP64ULong: z.add(x, y.culong) else: z.add(x, newInt(y))
  else:
    if y >= 0: z.add(x, y.culong) else: z.add(x, newInt(y))

func `+`*(x: Int, y: int | culong | Int): Int =
  ## Returns the sum x+y.
  newInt().add(x, y)

func `+`*(x: int | culong, y: Int): Int =
  ## Returns the sum x+y.
  newInt().add(y, x)

func sub*(z, x, y: Int): Int =
  ## Sets `z` to the difference x-y and returns `z`.
  result = z
  mpz_sub(result[], x[], y[])

func sub*(z, x: Int, y: culong): Int =
  ## Sets `z` to the difference x-y and returns `z`.
  result = z
  mpz_sub_ui(result[], x[], y)

func sub*(z: Int, x: culong, y: Int): Int =
  ## Sets `z` to the difference x-y and returns `z`.
  result = z
  mpz_ui_sub(result[], x, y[])

func sub*(z, x: Int, y: int): Int =
  ## Sets `z` to the difference x-y and returns `z`.
  when isLLP64():
    if y.fitsLLP64ULong: z.sub(x, y.culong) else: z.sub(x, newInt(y))
  else:
    if y >= 0: z.sub(x, y.culong) else: z.sub(x, newInt(y))

func sub*(z: Int, x: int, y: Int): Int =
  ## Sets `z` to the difference x-y and returns `z`.
  when isLLP64():
    if x.fitsLLP64ULong: z.sub(x.culong, y) else: z.sub(newInt(x), y)
  else:
    if x >= 0: z.sub(x.culong, y) else: z.sub(newInt(x), y)

func `-`*(x: Int, y: int | culong | Int): Int =
  ## Returns the difference x-y.
  newInt().sub(x, y)

func `-`*(x: int | culong, y: Int): Int =
  ## Returns the difference x-y.
  newInt().sub(x, y)

func addMul*(z, x, y: Int): Int =
  ## Increments `z` by `x` times `y`.
  result = z
  mpz_addmul(result[], x[], y[])

func addMul*(z, x: Int, y: culong): Int =
  ## Increments `z` by `x` times `y`.
  result = z
  mpz_addmul_ui(result[], x[], y)

func addMul*(z, x: Int, y: int): Int =
  ## Increments `z` by `x` times `y`.
  when isLLP64():
    if y.fitsLLP64ULong: z.addMul(x, y.culong) else: z.addMul(x, newInt(y))
  else:
    if y >= 0: z.addMul(x, y.culong) else: z.addMul(x, newInt(y))

func addMul*(z: Int, x: int | culong, y: Int): Int =
  ## Increments `z` by `x` times `y`.
  z.addMul(y, x)

func addMul*(z: Int, x: int | culong, y: int | culong): Int =
  ## Increments `z` by `x` times `y`.
  z.addMul(newInt(x), y)

func subMul*(z, x, y: Int): Int =
  ## Decrements `z` by `x` times `y`.
  result = z
  mpz_submul(result[], x[], y[])

func subMul*(z, x: Int, y: culong): Int =
  ## Decrements `z` by `x` times `y`.
  result = z
  mpz_submul_ui(result[], x[], y)

func subMul*(z, x: Int, y: int): Int =
  ## Decrements `z` by `x` times `y`.
  when isLLP64():
    if y.fitsLLP64ULong: z.subMul(x, y.culong) else: z.subMul(x, newInt(y))
  else:
    if y >= 0: z.subMul(x, y.culong) else: z.subMul(x, newInt(y))

func subMul*(z: Int, x: int | culong, y: Int): Int =
  ## Decrements `z` by `x` times `y`.
  z.subMul(y, x)

func subMul*(z: Int, x: int | culong, y: int | culong): Int =
  ## Increments `z` by `x` times `y`.
  z.subMul(newInt(x), y)

func inc*(z: Int, x: int | culong | Int) =
  ## Increments `z` by `x`.
  discard z.add(z, x)

func dec*(z: Int, x: int | culong | Int) =
  ## Decrements `z` by `x`.
  discard z.sub(z, x)

func `+=`*(z: Int, x: int | culong | Int) =
  ## Increments `z` by `x`.
  z.inc(x)

func `-=`*(z: Int, x: int | culong | Int) =
  ## Decrements `z` by `x`.
  z.dec(x)

func mul*(z, x, y: Int): Int =
  ## Sets `z` to the product x*y and returns `z`.
  result = z
  mpz_mul(result[], x[], y[])

func mul*(z, x: Int, y: culong): Int =
  ## Sets `z` to the product x*y and returns `z`.
  result = z
  mpz_mul_ui(result[], x[], y)

func mul*(z, x: Int, y: int): Int =
  ## Sets `z` to the product x*y and returns `z`.
  result = z
  when isLLP64():
    if y.fitsLLP64Long:
      mpz_mul_si(result[], x[], y.clong)
    elif y.fitsLLP64ULong:
      mpz_mul_ui(result[], x[], y.culong)
    else:
      mpz_mul(result[], x[], newInt(y)[])
  else:
    mpz_mul_si(result[], x[], y.clong)

func `*`*(x: Int, y: int | culong | Int): Int =
  ## Returns the product x*y.
  newInt().mul(x, y)

func `*`*(x: int | culong, y: Int): Int =
  ## Returns the product x*y.
  newInt().mul(y, x)

func `*=`*(z: Int, x: int | culong | Int) =
  discard z.mul(z, x)

# template countupImpl(incr: stmt) {.immediate, dirty.} =
#   when a is int or a is culong:
#     var res = newInt(a)
#   else:
#     var res = a.clone

#   while res <= b:
#     yield res
#     incr

# iterator countup*(a: Int, b: int | culong | Int, step: int | culong | Int): Int {.inline.} =
#   ## Counts from `a` up to `b` with the given `step` count.
#   countupImpl: inc(res, step)

# iterator countup*(a: int | culong, b: Int, step: Int): Int {.inline.} =
#   ## Counts from `a` up to `b` with the given `step` count.
#   countupImpl: inc(res, step)

# iterator countup*(a: int | culong, b: int | culong, step: Int): Int {.inline.} =
#   ## Counts from `a` up to `b` with the given `step` count.
#   countupImpl: inc(res, step)

# iterator countup*(a: int | culong, b: Int, step: int | culong): Int {.inline.} =
#   ## Counts from `a` up to `b` with the given `step` count.
#   countupImpl: inc(res, step)

# iterator `..`*(a: Int, b: int | culong | Int): Int {.inline.} =
#   ## An alias for `countup`.
#   let step = 1
#   countupImpl: inc(res, step)

# iterator `..`*(a: int | culong, b: Int): Int {.inline.} =
#   ## An alias for `countup`.
#   let step = 1
#   countupImpl: inc(res, step)

func `and`*(z, x, y: Int): Int =
  ## Sets `z` = `x` bitwise-and `y` and returns `z`.
  result = z
  mpz_and(z[], x[], y[])

func `and`*(x, y: Int): Int =
  ## Returns `x` bitwise-and `y`.
  newInt().`and`(x, y)

func `and`*(x: Int, y: int | culong): Int =
  ## Returns `x` bitwise-and `y`.
  x and newInt(y)

func `and`*(x: int | culong, y: Int): Int =
  ## Returns `x` bitwise-and `y`.
  newInt(x) and y

func `or`*(z, x, y: Int): Int =
  ## Sets `z` = `x` bitwise inclusive-or `y` and returns `z`.
  result = z
  mpz_ior(z[], x[], y[])

func `or`*(x, y: Int): Int =
  ## Returns `x` bitwise inclusive-or `y`.
  newInt().`or`(x, y)

func `or`*(x: Int, y: int | culong): Int =
  ## Returns `x` bitwise inclusive-or `y`.
  x or newInt(y)

func `or`*(x: int | culong, y: Int): Int =
  ## Returns `x` bitwise inclusive-or `y`.
  newInt(x) or y

func `xor`*(z, x, y: Int): Int =
  ## Sets `z` = `x` bitwise exclusive-or `y` and returns `z`.
  result = z
  mpz_xor(z[], x[], y[])

func `xor`*(x, y: Int): Int =
  ## Returns `x` bitwise exclusive-or `y`.
  newInt().`xor`(x, y)

func `xor`*(x: Int, y: int | culong): Int =
  ## Returns `x` bitwise exclusive-or `y`.
  x xor newInt(y)

func `xor`*(x: int | culong, y: Int): Int =
  ## Returns `x` bitwise exclusive-or `y`.
  newInt(x) xor y

func `not`*(z, x: Int): Int =
  ## Sets `z` to the one's complement of `x` and returns `z`.
  result = z
  mpz_com(z[], x[])

func `not`*(x: Int): Int =
  ## Returns the one's complement of `x`.
  newInt().`not` x

func odd*(z: Int): bool =
  ## Returns whether `z` is odd.
  mpz_odd_p(z[]) != 0

func even*(z: Int): bool =
  ## Returns whether `z` is even.
  mpz_even_p(z[]) != 0

func `div`*(z, x, y: Int): Int =
  ## Sets `z` to the quotient x/y for `y` != 0 and returns `z`.
  ## `div` implements truncated division towards zero.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  mpz_tdiv_q(result[], x[], y[])

func `div`*(z, x: Int, y: culong): Int =
  ## Sets `z` to the quotient x/y for `y` != 0 and returns `z`.
  ## `div` implements truncated division towards zero.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  discard mpz_tdiv_q_ui(result[], x[], y)

func `div`*(z, x: Int, y: int): Int =
  ## Sets `z` to the quotient x/y for `y` != 0 and returns `z`.
  ## `div` implements truncated division towards zero.
  when isLLP64():
    if y.fitsLLP64ULong: z.`div`(x, y.culong) else: z.`div`(x, newInt(y))
  else:
    if y >= 0: z.`div`(x, y.culong) else: z.`div`(x, newInt(y))

func `div`*(x: Int, y: int | culong | Int): Int =
  ## Returns the quotient x/y for `y` != 0.
  ## `div` implements truncated division towards zero.
  newInt().`div`(x, y)

func `div`*(x: int | culong, y: Int): Int =
  ## Returns the quotient x/y for `y` != 0.
  ## `div` implements truncated division towards zero.
  newInt().`div`(newInt(x), y)

func `mod`*(z, x, y: Int): Int =
  ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
  ## `mod` implements truncated division towards zero.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  mpz_tdiv_r(result[], x[], y[])

func `mod`*(z, x: Int, y: culong): Int =
  ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
  ## `mod` implements truncated division towards zero.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  discard mpz_tdiv_r_ui(result[], x[], y)

func `mod`*(z, x: Int, y: int): Int =
  ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
  ## `mod` implements truncated division towards zero.
  when isLLP64():
    if y.fitsLLP64ULong: z.`mod`(x, y.culong) else: z.`mod`(x, newInt(y))
  else:
    if y >= 0: z.`mod`(x, y.culong) else: z.`mod`(x, newInt(y))

func `mod`*(x: Int, y: int | culong | Int): Int =
  ## Returns the remainder x/y for `y` != 0.
  ## `mod` implements truncated division towards zero.
  newInt().`mod`(x, y)

func `mod`*(x: int | culong, y: Int): Int =
  ## Returns the remainder x/y for `y` != 0.
  ## `mod` implements truncated division towards zero.
  newInt().`mod`(newInt(x), y)

func modInverse*(z, g, n: Int): bool =
  ## Computes the inverse of `g` modulo `n` and put the result in `z`. If the
  ## inverse exists, the return value is `true` and `z` will satisfy
  ## 0 < `z` < abs(`n`). If an inverse doesn't exist the return value is `false`
  ## and `z` is undefined. The behaviour of this proc is undefined when `n` is
  ## zero.
  mpz_invert(z[], g[], n[]) != 0

func modInverse*(g: Int, n: Int): Int =
  ## Computes the inverse of `g` modulo `n`. If an inverse doesn't exist the
  ## return value is undefined. The behaviour of this proc is undefined when `n`
  ## is zero.
  result = newInt()
  discard modInverse(result, g, n)

func modInverse*(g: Int, n: int | culong): Int =
  ## Computes the inverse of `g` modulo `n`. If an inverse doesn't exist the
  ## return value is undefined. The behaviour of this proc is undefined when `n`
  ## is zero.
  modInverse(g, newInt(n))

func modInverse*(g: int | culong, n: Int): Int =
  ## Computes the inverse of `g` modulo `n`. If an inverse doesn't exist the
  ## return value is undefined. The behaviour of this proc is undefined when `n`
  ## is zero.
  modInverse(newInt(g), n)

func divMod*(q, r, x, y: Int): tuple[q, r: Int] =
  ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
  ## `y` != 0 and returns the tuple (`q`, `r`).
  ## `divMod` implements truncated division towards zero.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = (q: q, r: r)
  mpz_tdiv_qr(q[], r[], x[], y[])

func divMod*(q, r, x: Int, y: culong): tuple[q, r: Int] =
  ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
  ## `y` != 0 and returns the tuple (`q`, `r`).
  ## `divMod` implements truncated division towards zero.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = (q: q, r: r)
  discard mpz_tdiv_qr_ui(q[], r[], x[], y)

func divMod*(q, r, x: Int, y: int): tuple[q, r: Int] =
  ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
  ## `y` != 0 and returns the tuple (`q`, `r`).
  ## `divMod` implements truncated division towards zero.
  when isLLP64():
    if y.fitsLLP64ULong: divMod(q, r, x, y.culong) else: divMod(q, r, x, newInt(y))
  else:
    if y >= 0: divMod(q, r, x, y.culong) else: divMod(q, r, x, newInt(y))

func divMod*(x: Int, y: int | culong | Int): tuple[q, r: Int] =
  ## Returns a tuple consisting of the quotient and remainder resulting from x/y
  ## for `y` != 0.
  ## `divMod` implements truncated division towards zero.
  divMod(newInt(), newInt(), x, y)

func divMod*(x: int | culong, y: Int): tuple[q, r: Int] =
  ## Returns a tuple consisting of the quotient and remainder resulting from x/y
  ## for `y` != 0.
  ## `divMod` implements truncated division towards zero.
  divMod(newInt(), newInt(), newInt(x), y)

func fdiv*(z, x, y: Int): Int =
  ## Sets `z` to the quotient x/y for `y` != 0 and returns `z`.
  ## `fdiv` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  mpz_fdiv_q(result[], x[], y[])

func fdiv*(z, x: Int, y: culong): Int =
  ## Sets `z` to the quotient x/y for `y` != 0 and returns `z`.
  ## `fdiv` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  discard mpz_fdiv_q_ui(result[], x[], y)

func fdiv*(z, x: Int, y: int): Int =
  ## Sets `z` to the quotient x/y for `y` != 0 and returns `z`.
  ## `fdiv` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  when isLLP64():
    if y.fitsLLP64ULong: z.fdiv(x, y.culong) else: z.fdiv(x, newInt(y))
  else:
    if y >= 0: z.fdiv(x, y.culong) else: z.fdiv(x, newInt(y))

func fdiv*(x: Int, y: int | culong | Int): Int =
  ## Returns the quotient x/y for `y` != 0.
  ## `fdiv` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  newInt().fdiv(x, y)

func fdiv*(x: int | culong, y: Int): Int =
  ## Returns the quotient x/y for `y` != 0.
  ## `fdiv` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  newInt().fdiv(newInt(x), y)

func `//`*(x: Int, y: int | culong | Int): Int =
  ## Returns the quotient x/y for `y` != 0.
  ## `//` implements truncated division towards negative infinity.
  fdiv(x, y)

func `//`*(x: int | culong, y: Int): Int =
  ## Returns the quotient x/y for `y` != 0.
  ## `//` implements truncated division towards negative infinity.
  fdiv(x, y)

func fmod*(z, x, y: Int): Int =
  ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
  ## `fmod` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  mpz_fdiv_r(result[], x[], y[])

func fmod*(z, x: Int, y: culong): Int =
  ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
  ## `fmod` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  discard mpz_fdiv_r_ui(result[], x[], y)

func fmod*(z, x: Int, y: int): Int =
  ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
  ## `fmod` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  when isLLP64():
    if y.fitsLLP64ULong: z.fmod(x, y.culong) else: z.fmod(x, newInt(y))
  else:
    if y >= 0: z.fmod(x, y.culong) else: z.fmod(x, newInt(y))

func fmod*(x: Int, y: int | culong | Int): Int =
  ## Returns the remainder x/y for `y` != 0.
  ## `fmod` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  newInt().fmod(x, y)

func fmod*(x: int | culong, y: Int): Int =
  ## Returns the remainder x/y for `y` != 0.
  ## `fmod` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  newInt().fmod(newInt(x), y)

func `\\`*(x: Int, y: int | culong | Int): Int =
  ## Returns the remainder x/y for `y` != 0.
  ## `\\` implements truncated division towards negative infinity.
  fmod(x, y)

func `\\`*(x: int | culong, y: Int): Int =
  ## Returns the remainder x/y for `y` != 0.
  ## `\\` implements truncated division towards negative infinity.
  fmod(x, y)

func fdivMod*(q, r, x, y: Int): tuple[q, r: Int] =
  ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
  ## `y` != 0 and returns the tuple (`q`, `r`).
  ## `fdivMod` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = (q: q, r: r)
  mpz_fdiv_qr(q[], r[], x[], y[])

func fdivMod*(q, r, x: Int, y: culong): tuple[q, r: Int] =
  ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
  ## `y` != 0 and returns the tuple (`q`, `r`).
  ## `fdivMod` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = (q: q, r: r)
  discard mpz_fdiv_qr_ui(q[], r[], x[], y)

func fdivMod*(q, r, x: Int, y: int): tuple[q, r: Int] =
  ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
  ## `y` != 0 and returns the tuple (`q`, `r`).
  ## `fdivMod` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  when isLLP64():
    if y.fitsLLP64ULong: fdivMod(q, r, x, y.culong) else: fdivMod(q, r, x, newInt(y))
  else:
    if y >= 0: fdivMod(q, r, x, y.culong) else: fdivMod(q, r, x, newInt(y))

func fdivMod*(x: Int, y: int | culong | Int): tuple[q, r: Int] =
  ## Returns a tuple consisting of the quotient and remainder resulting from x/y
  ## for `y` != 0.
  ## `fdivMod` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  fdivMod(newInt(), newInt(), x, y)

func fdivMod*(x: int | culong, y: Int): tuple[q, r: Int] =
  ## Returns a tuple consisting of the quotient and remainder resulting from x/y
  ## for `y` != 0.
  ## `fdivMod` implements truncated division towards negative infinity.
  ## The f stands for “floor”.
  fdivMod(newInt(), newInt(), newInt(x), y)

func cdiv*(z, x, y: Int): Int =
  ## Sets `z` to the quotient x/y for `y` != 0 and returns `z`.
  ## `cdiv` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  mpz_cdiv_q(result[], x[], y[])

func cdiv*(z, x: Int, y: culong): Int =
  ## Sets `z` to the quotient x/y for `y` != 0 and returns `z`.
  ## `cdiv` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  discard mpz_cdiv_q_ui(result[], x[], y)

func cdiv*(z, x: Int, y: int): Int =
  ## Sets `z` to the quotient x/y for `y` != 0 and returns `z`.
  ## `cdiv` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  when isLLP64():
    if y.fitsLLP64ULong: z.cdiv(x, y.culong) else: z.cdiv(x, newInt(y))
  else:
    if y >= 0: z.cdiv(x, y.culong) else: z.cdiv(x, newInt(y))

func cdiv*(x: Int, y: int | culong | Int): Int =
  ## Returns the quotient x/y for `y` != 0.
  ## `cdiv` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  newInt().cdiv(x, y)

func cdiv*(x: int | culong, y: Int): Int =
  ## Returns the quotient x/y for `y` != 0.
  ## `cdiv` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  newInt().cdiv(newInt(x), y)

func cmod*(z, x, y: Int): Int =
  ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
  ## `cmod` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  mpz_cdiv_r(result[], x[], y[])

func cmod*(z, x: Int, y: culong): Int =
  ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
  ## `cmod` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = z
  discard mpz_cdiv_r_ui(result[], x[], y)

func cmod*(z, x: Int, y: int): Int =
  ## Sets `z` to the remainder x/y for `y` != 0 and returns `z`.
  ## `cmod` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  when isLLP64():
    if y.fitsLLP64ULong: z.cmod(x, y.culong) else: z.cmod(x, newInt(y))
  else:
    if y >= 0: z.cmod(x, y.culong) else: z.cmod(x, newInt(y))

func cmod*(x: Int, y: int | culong | Int): Int =
  ## Returns the remainder x/y for `y` != 0.
  ## `cmod` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  newInt().cmod(x, y)

func cmod*(x: int | culong, y: Int): Int =
  ## Returns the remainder x/y for `y` != 0.
  ## `cmod` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  newInt().cmod(newInt(x), y)

func cdivMod*(q, r, x, y: Int): tuple[q, r: Int] =
  ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
  ## `y` != 0 and returns the tuple (`q`, `r`).
  ## `cdivMod` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = (q: q, r: r)
  mpz_cdiv_qr(q[], r[], x[], y[])

func cdivMod*(q, r, x: Int, y: culong): tuple[q, r: Int] =
  ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
  ## `y` != 0 and returns the tuple (`q`, `r`).
  ## `cdivMod` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  if y == 0: raise newException(DivByZeroDefect, "Division by zero")
  result = (q: q, r: r)
  discard mpz_cdiv_qr_ui(q[], r[], x[], y)

func cdivMod*(q, r, x: Int, y: int): tuple[q, r: Int] =
  ## Sets `q` to the quotient and `r` to the remainder resulting from x/y for
  ## `y` != 0 and returns the tuple (`q`, `r`).
  ## `cdivMod` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  when isLLP64():
    if y.fitsLLP64ULong: cdivMod(q, r, x, y.culong) else: cdivMod(q, r, x, newInt(y))
  else:
    if y >= 0: cdivMod(q, r, x, y.culong) else: cdivMod(q, r, x, newInt(y))

func cdivMod*(x: Int, y: int | culong | Int): tuple[q, r: Int] =
  ## Returns a tuple consisting of the quotient and remainder resulting from x/y
  ## for `y` != 0.
  ## `cdivMod` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  cdivMod(newInt(), newInt(), x, y)

func cdivMod*(x: int | culong, y: Int): tuple[q, r: Int] =
  ## Returns a tuple consisting of the quotient and remainder resulting from x/y
  ## for `y` != 0.
  ## `cdivMod` implements truncated division towards positive infinity.
  ## The c stands for “ceil”.
  cdivMod(newInt(), newInt(), newInt(x), y)

func fac*(z, x: Int): Int =
  ## Sets `z` to the factorial of `x` and returns `z`.
  if x < 2:
    if x.negative:
      raise newException(RangeDefect, "Negative factorial")
    else:
      return z.set(1)

  result = z.set(2)
  var
    x0 = newInt(2)
    x1 = newInt(10)
    i = x // x0 - 1

  while i.sign == 1:
    x0 += x1
    x1 += 8
    result *= x0
    i.dec(1)

  if x.odd: result *= x

func fac*(z: Int, x: culong): Int =
  ## Sets `z` to the factorial of `x` and returns `z`.
  result = z
  mpz_fac_ui(result[], x)

func fac*(z: Int, x: int): Int =
  ## Sets `z` to the factorial of `x` and returns `z`.
  if x < 2:
    if x < 0:
      raise newException(RangeDefect, "Negative factorial")
    else:
      return z.set(1)

  result = z

  when isLLP64():
    if x.fitsLLP64ULong: discard z.fac(x.culong) else: discard z.fac(newInt(x))
  else:
    discard z.fac(x.culong)

func fac*(x: int | culong | Int): Int =
  ## Returns the factorial of `x`.
  newInt().fac(x)

# proc mulRange*(z: Int, a: int | culong | Int, b: int | culong | Int): Int =
#   ## Sets `z` to the product of all values in the range [a, b] inclusively and
#   ## returns `z`.
#   ## If a > b (empty range), the result is 1.
#   when (a is int or a is culong) and (b is int or b is culong):
#     var a = cast[b.type](a)
#     var zero = cast[b.type](0)
#   elif b is culong:
#     var zero = cast[b.type](0)
#   else:
#     var zero = 0

#   if a > b: return z.set(1)                 # empty range
#   if a <= 0 and b >= zero: return z.set(0)  # range includes 0

#   result = z

#   # Can use fac proc if a = 1 or a = 2
#   if a == 1 or a == 2:
#     discard z.fac(b)
#   else:
#     # Slow
#     discard z.set(a)
#     for i in a + 1 .. b:
#       z *= i

# proc mulRange*(a: int | culong | Int, b: int | culong | Int): Int =
#   ## Returns the product of all values in the range [a, b] inclusively.
#   ## If a > b (empty range), the result is 1.
#   newInt().mulRange(a, b)

func binom*(z, n: Int, k: culong): Int =
  ## Sets `z` to the binomial coefficient of (`n`, `k`) and returns `z`.
  result = z
  mpz_bin_ui(z[], n[], k)

func binom*(z: Int, n, k: culong): Int =
  ## Sets `z` to the binomial coefficient of (`n`, `k`) and returns `z`.
  result = z
  mpz_bin_uiui(z[], n, k)

# proc binom*(n, k: Int): Int =
#   ## Returns the binomial coefficient of (`n`, `k`).
#   if k.sign <= 0: return newInt(1)
#   var a = newInt().mulRange(n - k + 1, n)
#   var b = newInt().mulRange(1, k)
#   return newInt().`div`(a, b)

# proc binom*(n: culong | Int, k: culong): Int =
#   ## Returns the binomial coefficient of (`n`, `k`).
#   newInt().binom(n, k)

# proc binom*(n: int | culong, k: Int): Int =
#   ## Returns the binomial coefficient of (`n`, `k`).
#   binom(newInt(n), k)

# proc binom*(n: Int, k: int): Int =
#   ## Returns the binomial coefficient of (`n`, `k`).
#   if k <= 0: return newInt(1)
#   when isLLP64():
#     if k.fitsLLP64Ulong:
#       result = binom(n, k.culong)
#     else:
#       result = binom(n, newInt(k))
#   else:
#     result = binom(n, k.culong)

func bit*(x: Int, i: culong): cint =
  ## Returns the value of the `i`'th bit of `x`.
  mpz_tstbit(x[], i)

func setBit*(z: Int, i: culong): Int =
  ## Sets the i`'th bit of `z` and returns the resulting Int.
  result = z
  mpz_setbit(z[], i)

func clearBit*(z: Int, i: culong): Int =
  ## Clears the i`'th bit of `z` and returns the resulting Int.
  result = z
  mpz_clrbit(z[], i)

func complementBit*(z: Int, i: culong): Int =
  ## Complements the i`'th bit of `z` and returns the resulting Int.
  result = z
  mpz_combit(z[], i)

func bitLen*(x: Int): csize_t =
  ## Returns the length of the absolute value of `x` in bits.
  digits(x, 2)

func pow*(z, x: Int, y: culong): Int =
  ## Sets `z` to `x` raised to `y` and returns `z`. The case 0^0 yields 1.
  result = z
  mpz_pow_ui(z[], x[], y)

func pow*(z: Int, x, y: culong): Int =
  ## Sets `z` to `x` raised to `y` and returns `z`. The case 0^0 yields 1.
  result = z
  mpz_ui_pow_ui(z[], x, y)

func pow*(x: culong | Int, y: culong): Int =
  ## Returns `x` raised to `y`. The case 0^0 yields 1.
  newInt().pow(x, y)

func pow*(x: int, y: culong): Int =
  ## Returns `x` raised to `y`. The case 0^0 yields 1.
  when isLLP64():
    if x.fitsLLP64ULong: pow(x.culong, y) else: pow(newInt(x), y)
  else:
    if x >= 0: pow(x.culong, y) else: pow(newInt(x), y)

func `^`*(x: int | culong | Int, y: culong): Int =
  ## Returns `x` raised to `y`. The case 0^0 yields 1.
  pow(x, y)

func exp*(z, x: Int, y: culong, m: Int): Int =
  ## Sets `z` to (`x` raised to `y`) modulo `m` and returns `z`.
  ## If `m` == 0, z = x^y.
  if m.sign == 0: return z.pow(x, y)
  result = z
  mpz_powm_ui(z[], x[], y, m[])

func exp*(z, x, y, m: Int): Int =
  ## Sets `z` to (`x` raised to `y`) modulo `m` and returns `z`.
  ## If `m` == 0, z = x^y.
  result = z
  mpz_powm(z[], x[], y[], m[])

func exp*(x: Int, y: Int, m: Int): Int =
  ## Returns (`x` raised to `y`) modulo `m`.
  ## If `m` == 0, z = x^y.
  newInt().exp(x, y, m)

func exp*(x: Int, y: culong, m: Int): Int =
  ## Returns (`x` raised to `y`) modulo `m`.
  ## If `m` == 0, z = x^y.
  newInt().exp(x, y, m)

func exp*(x: Int, y: culong, m: int | culong): Int =
  ## Returns (`x` raised to `y`) modulo `m`.
  ## If `m` == 0, z = x^y.
  exp(x, y, newInt(m))

func exp*(x: int | culong, y: culong, m: Int): Int =
  ## Returns (`x` raised to `y`) modulo `m`.
  ## If `m` == 0, z = x^y.
  exp(newInt(x), y, m)

func sqrt*(z, x: Int): Int =
    result = z
    mpz_sqrt(z[], x[])

func sqrt*(x: Int): Int =
  ## Returns the greatest common divisor of `x` and `y`.
  newInt().sqrt(x)

func gcd*(z, x, y: Int): Int =
  ## Sets `z` to the greatest common divisor of `x` and `y` and returns `z`.
  result = z
  mpz_gcd(z[], x[], y[])

func gcd*(z, x: Int, y: culong): Int =
  ## Sets `z` to the greatest common divisor of `x` and `y` and returns `z`.
  result = z
  discard mpz_gcd_ui(z[], x[], y)

func gcd*(z, x: Int, y: int): Int =
  ## Sets `z` to the greatest common divisor of `x` and `y` and returns `z`.
  when isLLP64():
    if y.fitsLLP64ULong: z.gcd(x, y.culong) else: z.gcd(x, newInt(y))
  else:
    if y >= 0: z.gcd(x, y.culong) else: z.gcd(x, newInt(y))

func gcd*(x: Int, y: int | culong | Int): Int =
  ## Returns the greatest common divisor of `x` and `y`.
  newInt().gcd(x, y)

func gcd*(x: int | culong, y: Int): Int =
  ## Returns the greatest common divisor of `x` and `y`.
  newInt().gcd(newInt(x), y)

func lcm*(z, x, y: Int): Int =
  ## Sets `z` to the least common multiple of `x` and `y` and returns `z`.
  result = z
  mpz_lcm(z[], x[], y[])

func lcm*(z, x: Int, y: culong): Int =
  ## Sets `z` to the least common multiple of `x` and `y` and returns `z`.
  result = z
  mpz_lcm_ui(z[], x[], y)

func lcm*(z, x: Int, y: int): Int =
  ## Sets `z` to the least common multiple of `x` and `y` and returns `z`.
  when isLLP64():
    if y.fitsLLP64ULong: z.lcm(x, y.culong) else: z.lcm(x, newInt(y))
  else:
    if y >= 0: z.lcm(x, y.culong) else: z.lcm(x, newInt(y))

func lcm*(x: Int, y: int | culong | Int): Int =
  ## Returns the least common multiple of `x` and `y`.
  newInt().lcm(x, y)

func lcm*(x: int | culong, y: Int): Int =
  ## Returns the least common multiple of `x` and `y`.
  newInt().lcm(newInt(x), y)

func `shl`*(z, x: Int, y: culong): Int =
  ## Sets `z` the `shift left` operation of `x` and `y` and returns `z`.
  result = z
  mpz_mul_2exp(z[], x[], y)

func `shl`*(x: Int, y: culong): Int =
  ## Computes the `shift left` operation of `x` and `y`.
  newInt().`shl`(x, y)

func `shr`*(z, x: Int, y: culong): Int =
  ## Sets `z` to the `shift right` operation of `x` and `y`.
  result = z
  mpz_fdiv_q_2exp(z[], x[], y)

func `shr`*(x: Int, y: culong): Int =
  ## Computes the `shift right` operation of `x` and `y`.
  newInt().`shr`(x, y)

func fitsCULong*(x: Int): bool =
  ## Returns whether `x` fits in a culong.
  mpz_fits_ulong_p(x[]) != 0

func fitsCLong*(x: Int): bool =
  ## Returns whether `x` fits in a clong.
  mpz_fits_slong_p(x[]) != 0

func fitsInt*(x: Int): bool =
  ## Returns whether `x` fits in an int.
  when isLLP64():
    if x[].mp_size < -1 or x[].mp_size > 1: return false
    if x[].mp_size == 0: return true
    if x[].mp_size > 0: return (x[].mp_d[]).uint <= high(int).uint
    return x.cmp(low(int)) >= 0
  else:
    x.fitsClong

func toCULong*(x: Int): culong =
  ## Returns the value of `x` as a culong.
  ## If `x` is too big to fit a culong then just the least significant bits that
  ## do fit are returned. The sign of `x` is ignored, only the absolute value is
  ## used. To find out if the value will fit, use the proc `fitsCULong`.
  mpz_get_ui(x[])

func toCLong*(x: Int): clong =
  ## If `x` fits into a clong returns the value of `x`. Otherwise returns the
  ## least significant part of `x`, with the same sign as `x`.
  ## If `x` is too big to fit in a clong, the returned result is probably not
  ## very useful. To find out if the value will fit, use the proc `fitsCLong`.
  mpz_get_si(x[])

func toInt*(x: Int): int =
  ## If `x` fits into an int returns the value of `x`. Otherwise returns the
  ## least significant part of `x`, with the same sign as `x`.
  ## If `x` is too big to fit in an int, the returned result is probably not
  ## very useful. To find out if the value will fit, use the proc `fitsInt`.
  when isLLP64():
    if x[].mp_size > 0: return (x[].mp_d[]).int
    if x[].mp_size < 0: return -1 - ((x[].mp_d[]).uint - 1).int
    return 0
  else:
    x.toCLong

func neg*(z, x: Int): Int =
  ## Sets `z` to -`x` and returns `z`.
  result = z
  mpz_neg(z[], x[])

func `-`*(x: Int): Int =
  ## Unary `-` operator for an Int. Negates `x`.
  newInt().neg(x)

func probablyPrime*(x: Int, n: cint): cint =
  ## Determines whether `x` is prime. Return 2 if `x` is definitely prime, return
  ## 1 if `x` is probably prime (without being certain), or return 0 if `x` is
  ## definitely composite.
  ## This proc does some trial divisions, then some Miller-Rabin probabilistic
  ## primality tests. The argument `n` controls how many such tests are done; a
  ## higher value will reduce the chances of a composite being returned as
  ## "probably prime". 25 is a reasonable number; a composite number will then
  ## be identified as a prime with a probability of less than 2^(-50).
  mpz_probab_prime_p(x[], n)

func nextPrime*(z, x: Int): Int =
  ## Sets `z` to the next prime greater than `x`.
  ## This proc uses a probabilistic algorithm to identify primes. For practical
  ## purposes it's adequate, the chance of a composite passing will be extremely
  ## small.
  result = z
  mpz_nextprime(z[], x[])

func nextPrime*(x: Int): Int =
  ## Returns the next prime greater than `x`.
  ## This proc uses a probabilistic algorithm to identify primes. For practical
  ## purposes it's adequate, the chance of a composite passing will be extremely
  ## small.
  newInt().nextPrime(x)
