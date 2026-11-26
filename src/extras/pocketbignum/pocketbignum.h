/*
 * PocketBignum - a small, fast, portable arbitrary-precision library in C.
 * Single header, stb-style. Integers (mpz), later rationals (mpq) and floats.
 *
 * Usage:
 *     #define PBN_IMPLEMENTATION      // in exactly ONE .c file
 *     #include "pocketbignum.h"
 *
 * Options (define before including):
 *     PBN_STATIC          make every function static (single-TU use)
 *     PBN_LIMB_BITS       32 or 64 (default: 64 on 64-bit targets)
 *     PBN_PORTABLE        disable compiler intrinsics/__int128 (pure C99)
 *     PBN_ABORT(msg)      fatal error hook (default: print + abort())
 *
 * For a GMP-compatible API (mpz_* names), include "compat/gmp.h" instead.
 *
 * MIT License
 * Copyright (c) 2026 Yanis Zafirópulos
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 */

#ifndef POCKETBIGNUM_H
#define POCKETBIGNUM_H

#include <stddef.h>
#include <stdint.h>
#include <limits.h>

#define PBN_VERSION "0.1.0"

#ifndef PBN_LIMB_BITS
#  if UINTPTR_MAX > 0xFFFFFFFFu || defined(__SIZEOF_INT128__)
#    define PBN_LIMB_BITS 64
#  else
#    define PBN_LIMB_BITS 32
#  endif
#endif

#if PBN_LIMB_BITS == 64
typedef uint64_t pbn_limb;
#elif PBN_LIMB_BITS == 32
typedef uint32_t pbn_limb;
#else
#  error "PBN_LIMB_BITS must be 32 or 64"
#endif

typedef long          pbn_size;    /* mp_size_t   */
typedef unsigned long pbn_bitcnt;  /* mp_bitcnt_t */

/* Layout identical to GMP's __mpz_struct */
typedef struct {
    int       _mp_alloc;   /* limbs allocated (0 = none, _mp_d points to a dummy) */
    int       _mp_size;    /* |size| = limbs used, sign = sign of the number      */
    pbn_limb *_mp_d;       /* limbs, least significant first                       */
} pbz_struct;

typedef pbz_struct        pbz_t[1];
typedef pbz_struct       *pbz_ptr;
typedef const pbz_struct *pbz_srcptr;

#ifdef PBN_STATIC
#  define PBN_API static
#  define PBN_DEF static
#else
#  define PBN_API extern
#  define PBN_DEF
#endif

#ifdef __cplusplus
extern "C" {
#endif

/* ---- memory ---- */
PBN_API void pbn_set_memory_functions(void *(*alloc_fn)(size_t),
                                      void *(*realloc_fn)(void *, size_t, size_t),
                                      void  (*free_fn)(void *, size_t));
PBN_API void pbn_get_memory_functions(void *(**alloc_fn)(size_t),
                                      void *(**realloc_fn)(void *, size_t, size_t),
                                      void  (**free_fn)(void *, size_t));

/* ---- init / assign ---- */
PBN_API void   pbz_init(pbz_ptr x);
PBN_API void   pbz_init2(pbz_ptr x, pbn_bitcnt bits);
PBN_API void   pbz_inits(pbz_ptr x, ...);
PBN_API void   pbz_clear(pbz_ptr x);
PBN_API void   pbz_clears(pbz_ptr x, ...);
PBN_API void   pbz_realloc2(pbz_ptr x, pbn_bitcnt bits);
PBN_API void   pbz_set(pbz_ptr r, pbz_srcptr a);
PBN_API void   pbz_set_ui(pbz_ptr r, unsigned long u);
PBN_API void   pbz_set_si(pbz_ptr r, long s);
PBN_API void   pbz_set_d(pbz_ptr r, double d);
PBN_API int    pbz_set_str(pbz_ptr r, const char *str, int base);
PBN_API void   pbz_swap(pbz_ptr a, pbz_ptr b);
PBN_API void   pbz_init_set(pbz_ptr r, pbz_srcptr a);
PBN_API void   pbz_init_set_ui(pbz_ptr r, unsigned long u);
PBN_API void   pbz_init_set_si(pbz_ptr r, long s);
PBN_API void   pbz_init_set_d(pbz_ptr r, double d);
PBN_API int    pbz_init_set_str(pbz_ptr r, const char *str, int base);

/* ---- conversion ---- */
PBN_API unsigned long pbz_get_ui(pbz_srcptr x);
PBN_API long   pbz_get_si(pbz_srcptr x);
PBN_API double pbz_get_d(pbz_srcptr x);
PBN_API char  *pbz_get_str(char *str, int base, pbz_srcptr x);
PBN_API size_t pbz_sizeinbase(pbz_srcptr x, int base);
PBN_API int    pbz_fits_ulong_p(pbz_srcptr x);
PBN_API int    pbz_fits_slong_p(pbz_srcptr x);
PBN_API int    pbz_fits_uint_p(pbz_srcptr x);
PBN_API int    pbz_fits_sint_p(pbz_srcptr x);
PBN_API int    pbz_fits_ushort_p(pbz_srcptr x);
PBN_API int    pbz_fits_sshort_p(pbz_srcptr x);

/* ---- arithmetic ---- */
PBN_API void pbz_add(pbz_ptr r, pbz_srcptr a, pbz_srcptr b);
PBN_API void pbz_add_ui(pbz_ptr r, pbz_srcptr a, unsigned long b);
PBN_API void pbz_sub(pbz_ptr r, pbz_srcptr a, pbz_srcptr b);
PBN_API void pbz_sub_ui(pbz_ptr r, pbz_srcptr a, unsigned long b);
PBN_API void pbz_ui_sub(pbz_ptr r, unsigned long a, pbz_srcptr b);
PBN_API void pbz_mul(pbz_ptr r, pbz_srcptr a, pbz_srcptr b);
PBN_API void pbz_mul_ui(pbz_ptr r, pbz_srcptr a, unsigned long b);
PBN_API void pbz_mul_si(pbz_ptr r, pbz_srcptr a, long b);
PBN_API void pbz_addmul(pbz_ptr r, pbz_srcptr a, pbz_srcptr b);
PBN_API void pbz_addmul_ui(pbz_ptr r, pbz_srcptr a, unsigned long b);
PBN_API void pbz_submul(pbz_ptr r, pbz_srcptr a, pbz_srcptr b);
PBN_API void pbz_submul_ui(pbz_ptr r, pbz_srcptr a, unsigned long b);
PBN_API void pbz_mul_2exp(pbz_ptr r, pbz_srcptr a, pbn_bitcnt k);
PBN_API void pbz_neg(pbz_ptr r, pbz_srcptr a);
PBN_API void pbz_abs(pbz_ptr r, pbz_srcptr a);

/* ---- division: t = truncate, f = floor, c = ceil ---- */
PBN_API void pbz_tdiv_q(pbz_ptr q, pbz_srcptr n, pbz_srcptr d);
PBN_API void pbz_tdiv_r(pbz_ptr r, pbz_srcptr n, pbz_srcptr d);
PBN_API void pbz_tdiv_qr(pbz_ptr q, pbz_ptr r, pbz_srcptr n, pbz_srcptr d);
PBN_API void pbz_fdiv_q(pbz_ptr q, pbz_srcptr n, pbz_srcptr d);
PBN_API void pbz_fdiv_r(pbz_ptr r, pbz_srcptr n, pbz_srcptr d);
PBN_API void pbz_fdiv_qr(pbz_ptr q, pbz_ptr r, pbz_srcptr n, pbz_srcptr d);
PBN_API void pbz_cdiv_q(pbz_ptr q, pbz_srcptr n, pbz_srcptr d);
PBN_API void pbz_cdiv_r(pbz_ptr r, pbz_srcptr n, pbz_srcptr d);
PBN_API void pbz_cdiv_qr(pbz_ptr q, pbz_ptr r, pbz_srcptr n, pbz_srcptr d);
PBN_API unsigned long pbz_tdiv_q_ui(pbz_ptr q, pbz_srcptr n, unsigned long d);
PBN_API unsigned long pbz_tdiv_r_ui(pbz_ptr r, pbz_srcptr n, unsigned long d);
PBN_API unsigned long pbz_tdiv_qr_ui(pbz_ptr q, pbz_ptr r, pbz_srcptr n, unsigned long d);
PBN_API unsigned long pbz_tdiv_ui(pbz_srcptr n, unsigned long d);
PBN_API unsigned long pbz_fdiv_q_ui(pbz_ptr q, pbz_srcptr n, unsigned long d);
PBN_API unsigned long pbz_fdiv_r_ui(pbz_ptr r, pbz_srcptr n, unsigned long d);
PBN_API unsigned long pbz_fdiv_qr_ui(pbz_ptr q, pbz_ptr r, pbz_srcptr n, unsigned long d);
PBN_API unsigned long pbz_fdiv_ui(pbz_srcptr n, unsigned long d);
PBN_API unsigned long pbz_cdiv_q_ui(pbz_ptr q, pbz_srcptr n, unsigned long d);
PBN_API unsigned long pbz_cdiv_r_ui(pbz_ptr r, pbz_srcptr n, unsigned long d);
PBN_API unsigned long pbz_cdiv_qr_ui(pbz_ptr q, pbz_ptr r, pbz_srcptr n, unsigned long d);
PBN_API unsigned long pbz_cdiv_ui(pbz_srcptr n, unsigned long d);
PBN_API void pbz_tdiv_q_2exp(pbz_ptr q, pbz_srcptr n, pbn_bitcnt k);
PBN_API void pbz_tdiv_r_2exp(pbz_ptr r, pbz_srcptr n, pbn_bitcnt k);
PBN_API void pbz_fdiv_q_2exp(pbz_ptr q, pbz_srcptr n, pbn_bitcnt k);
PBN_API void pbz_fdiv_r_2exp(pbz_ptr r, pbz_srcptr n, pbn_bitcnt k);
PBN_API void pbz_cdiv_q_2exp(pbz_ptr q, pbz_srcptr n, pbn_bitcnt k);
PBN_API void pbz_cdiv_r_2exp(pbz_ptr r, pbz_srcptr n, pbn_bitcnt k);
PBN_API void pbz_mod(pbz_ptr r, pbz_srcptr n, pbz_srcptr d);
PBN_API void pbz_divexact(pbz_ptr q, pbz_srcptr n, pbz_srcptr d);
PBN_API void pbz_divexact_ui(pbz_ptr q, pbz_srcptr n, unsigned long d);
PBN_API int  pbz_divisible_p(pbz_srcptr n, pbz_srcptr d);
PBN_API int  pbz_divisible_ui_p(pbz_srcptr n, unsigned long d);

/* ---- powers & roots ---- */
PBN_API void pbz_pow_ui(pbz_ptr r, pbz_srcptr b, unsigned long e);
PBN_API void pbz_ui_pow_ui(pbz_ptr r, unsigned long b, unsigned long e);
PBN_API void pbz_powm(pbz_ptr r, pbz_srcptr b, pbz_srcptr e, pbz_srcptr m);
PBN_API void pbz_powm_ui(pbz_ptr r, pbz_srcptr b, unsigned long e, pbz_srcptr m);
PBN_API void pbz_sqrt(pbz_ptr r, pbz_srcptr x);
PBN_API void pbz_sqrtrem(pbz_ptr s, pbz_ptr r, pbz_srcptr x);
PBN_API int  pbz_perfect_square_p(pbz_srcptr x);

/* ---- number theory ---- */
PBN_API int  pbz_probab_prime_p(pbz_srcptr n, int reps);
PBN_API void pbz_nextprime(pbz_ptr r, pbz_srcptr n);
PBN_API void pbz_gcd(pbz_ptr g, pbz_srcptr a, pbz_srcptr b);
PBN_API unsigned long pbz_gcd_ui(pbz_ptr g, pbz_srcptr a, unsigned long b);
PBN_API void pbz_lcm(pbz_ptr r, pbz_srcptr a, pbz_srcptr b);
PBN_API void pbz_lcm_ui(pbz_ptr r, pbz_srcptr a, unsigned long b);
PBN_API int  pbz_invert(pbz_ptr r, pbz_srcptr a, pbz_srcptr m);
PBN_API void pbz_fac_ui(pbz_ptr r, unsigned long n);

/* ---- comparison ---- */
PBN_API int pbz_cmp(pbz_srcptr a, pbz_srcptr b);
PBN_API int pbz_cmp_ui(pbz_srcptr a, unsigned long b);
PBN_API int pbz_cmp_si(pbz_srcptr a, long b);
PBN_API int pbz_cmp_d(pbz_srcptr a, double b);
PBN_API int pbz_cmpabs(pbz_srcptr a, pbz_srcptr b);
PBN_API int pbz_cmpabs_ui(pbz_srcptr a, unsigned long b);
PBN_API int pbz_cmpabs_d(pbz_srcptr a, double b);

/* ---- logic & bits (two's complement semantics) ---- */
PBN_API void pbz_and(pbz_ptr r, pbz_srcptr a, pbz_srcptr b);
PBN_API void pbz_ior(pbz_ptr r, pbz_srcptr a, pbz_srcptr b);
PBN_API void pbz_xor(pbz_ptr r, pbz_srcptr a, pbz_srcptr b);
PBN_API void pbz_com(pbz_ptr r, pbz_srcptr a);
PBN_API pbn_bitcnt pbz_popcount(pbz_srcptr a);
PBN_API int  pbz_tstbit(pbz_srcptr a, pbn_bitcnt k);
PBN_API void pbz_setbit(pbz_ptr a, pbn_bitcnt k);
PBN_API void pbz_clrbit(pbz_ptr a, pbn_bitcnt k);
PBN_API void pbz_combit(pbz_ptr a, pbn_bitcnt k);

/* ---- raw limb access ---- */
PBN_API size_t          pbz_size(pbz_srcptr x);
PBN_API pbn_limb        pbz_getlimbn(pbz_srcptr x, pbn_size n);
PBN_API const pbn_limb *pbz_limbs_read(pbz_srcptr x);
PBN_API pbn_limb       *pbz_limbs_write(pbz_ptr x, pbn_size n);
PBN_API pbn_limb       *pbz_limbs_modify(pbz_ptr x, pbn_size n);
PBN_API void            pbz_limbs_finish(pbz_ptr x, pbn_size n);
PBN_API pbz_srcptr      pbz_roinit_n(pbz_ptr x, const pbn_limb *p, pbn_size n);

PBN_API const char *const pbn_version;

/* ========================================================================= */
/* pbq: rationals (layout identical to GMP's __mpq_struct)                   */
/* ========================================================================= */

typedef struct {
    pbz_struct _mp_num;
    pbz_struct _mp_den;
} pbq_struct;

typedef pbq_struct        pbq_t[1];
typedef pbq_struct       *pbq_ptr;
typedef const pbq_struct *pbq_srcptr;

PBN_API void   pbq_init(pbq_ptr q);
PBN_API void   pbq_inits(pbq_ptr q, ...);
PBN_API void   pbq_clear(pbq_ptr q);
PBN_API void   pbq_clears(pbq_ptr q, ...);
PBN_API void   pbq_set(pbq_ptr r, pbq_srcptr a);
PBN_API void   pbq_set_z(pbq_ptr r, pbz_srcptr a);
PBN_API void   pbq_set_si(pbq_ptr r, long num, unsigned long den);
PBN_API void   pbq_set_ui(pbq_ptr r, unsigned long num, unsigned long den);
PBN_API void   pbq_set_num(pbq_ptr r, pbz_srcptr num);
PBN_API void   pbq_set_den(pbq_ptr r, pbz_srcptr den);
PBN_API void   pbq_set_d(pbq_ptr r, double d);
PBN_API int    pbq_set_str(pbq_ptr r, const char *str, int base);
PBN_API void   pbq_swap(pbq_ptr a, pbq_ptr b);
PBN_API void   pbq_get_num(pbz_ptr r, pbq_srcptr q);
PBN_API void   pbq_get_den(pbz_ptr r, pbq_srcptr q);
PBN_API double pbq_get_d(pbq_srcptr q);
PBN_API char  *pbq_get_str(char *str, int base, pbq_srcptr q);
PBN_API void   pbq_canonicalize(pbq_ptr q);
PBN_API void   pbq_add(pbq_ptr r, pbq_srcptr a, pbq_srcptr b);
PBN_API void   pbq_sub(pbq_ptr r, pbq_srcptr a, pbq_srcptr b);
PBN_API void   pbq_mul(pbq_ptr r, pbq_srcptr a, pbq_srcptr b);
PBN_API void   pbq_div(pbq_ptr r, pbq_srcptr a, pbq_srcptr b);
PBN_API void   pbq_neg(pbq_ptr r, pbq_srcptr a);
PBN_API void   pbq_abs(pbq_ptr r, pbq_srcptr a);
PBN_API void   pbq_inv(pbq_ptr r, pbq_srcptr a);
PBN_API void   pbq_mul_2exp(pbq_ptr r, pbq_srcptr a, pbn_bitcnt k);
PBN_API void   pbq_div_2exp(pbq_ptr r, pbq_srcptr a, pbn_bitcnt k);
PBN_API int    pbq_cmp(pbq_srcptr a, pbq_srcptr b);
PBN_API int    pbq_cmp_z(pbq_srcptr a, pbz_srcptr b);
PBN_API int    pbq_cmp_si(pbq_srcptr a, long num, unsigned long den);
PBN_API int    pbq_cmp_ui(pbq_srcptr a, unsigned long num, unsigned long den);
PBN_API int    pbq_equal(pbq_srcptr a, pbq_srcptr b);

/* ========================================================================= */
/* pbf: binary floating point, correctly rounded (layout = MPFR's struct)    */
/* ========================================================================= */

typedef long pbf_prec_t;
typedef int  pbf_sign_t;
typedef long pbf_exp_t;
typedef enum {
    PBF_RNDN = 0,   /* nearest, ties to even */
    PBF_RNDZ = 1,   /* toward zero           */
    PBF_RNDU = 2,   /* toward +inf           */
    PBF_RNDD = 3,   /* toward -inf           */
    PBF_RNDA = 4,   /* away from zero        */
    PBF_RNDF = 5,   /* faithful (treated as RNDN) */
    PBF_RNDNA = -1  /* treated as RNDN       */
} pbf_rnd_t;

typedef struct {
    pbf_prec_t _mpfr_prec;
    pbf_sign_t _mpfr_sign;
    pbf_exp_t  _mpfr_exp;
    pbn_limb  *_mpfr_d;
} pbf_struct;

typedef pbf_struct        pbf_t[1];
typedef pbf_struct       *pbf_ptr;
typedef const pbf_struct *pbf_srcptr;

#define PBF_PREC_MIN 1L
#define PBF_PREC_MAX ((pbf_prec_t)(LONG_MAX >> 2))

PBN_API const char *pbf_get_version(void);
PBN_API void       pbf_set_default_prec(pbf_prec_t p);
PBN_API pbf_prec_t pbf_get_default_prec(void);
PBN_API pbf_exp_t  pbf_get_emin(void);
PBN_API pbf_exp_t  pbf_get_emax(void);
PBN_API void       pbf_init(pbf_ptr x);
PBN_API void       pbf_init2(pbf_ptr x, pbf_prec_t p);
PBN_API void       pbf_inits(pbf_ptr x, ...);
PBN_API void       pbf_clear(pbf_ptr x);
PBN_API void       pbf_clears(pbf_ptr x, ...);
PBN_API void       pbf_set_prec(pbf_ptr x, pbf_prec_t p);
PBN_API pbf_prec_t pbf_get_prec(pbf_srcptr x);
PBN_API void       pbf_free_cache(void);
PBN_API void       pbf_free_str(char *s);

PBN_API void   pbf_set_nan(pbf_ptr x);
PBN_API void   pbf_set_inf(pbf_ptr x, int sign);
PBN_API void   pbf_set_zero(pbf_ptr x, int sign);
PBN_API int    pbf_set(pbf_ptr r, pbf_srcptr a, pbf_rnd_t rnd);
PBN_API int    pbf_set_d(pbf_ptr r, double d, pbf_rnd_t rnd);
PBN_API int    pbf_set_si(pbf_ptr r, long v, pbf_rnd_t rnd);
PBN_API int    pbf_set_ui(pbf_ptr r, unsigned long v, pbf_rnd_t rnd);
PBN_API int    pbf_set_z(pbf_ptr r, pbz_srcptr z, pbf_rnd_t rnd);
PBN_API int    pbf_set_str(pbf_ptr r, const char *s, int base, pbf_rnd_t rnd);
PBN_API void   pbf_swap(pbf_ptr a, pbf_ptr b);

PBN_API double pbf_get_d(pbf_srcptr x, pbf_rnd_t rnd);
PBN_API char  *pbf_get_str(char *str, pbf_exp_t *expptr, int base, size_t n, pbf_srcptr x, pbf_rnd_t rnd);
PBN_API size_t pbf_get_str_ndigits(int base, pbf_prec_t p);
PBN_API int    pbf_fits_uint_p(pbf_srcptr x, pbf_rnd_t rnd);

PBN_API int    pbf_nan_p(pbf_srcptr x);
PBN_API int    pbf_inf_p(pbf_srcptr x);
PBN_API int    pbf_zero_p(pbf_srcptr x);
PBN_API int    pbf_number_p(pbf_srcptr x);
PBN_API int    pbf_regular_p(pbf_srcptr x);
PBN_API int    pbf_sgn(pbf_srcptr x);
PBN_API int    pbf_signbit(pbf_srcptr x);

PBN_API int    pbf_cmp(pbf_srcptr a, pbf_srcptr b);
PBN_API int    pbf_cmp_d(pbf_srcptr a, double d);
PBN_API int    pbf_cmp_si(pbf_srcptr a, long v);
PBN_API int    pbf_cmp_ui(pbf_srcptr a, unsigned long v);

PBN_API int pbf_neg(pbf_ptr r, pbf_srcptr a, pbf_rnd_t rnd);
PBN_API int pbf_abs(pbf_ptr r, pbf_srcptr a, pbf_rnd_t rnd);
PBN_API int pbf_add(pbf_ptr r, pbf_srcptr a, pbf_srcptr b, pbf_rnd_t rnd);
PBN_API int pbf_add_z(pbf_ptr r, pbf_srcptr a, pbz_srcptr b, pbf_rnd_t rnd);
PBN_API int pbf_add_d(pbf_ptr r, pbf_srcptr a, double b, pbf_rnd_t rnd);
PBN_API int pbf_sub(pbf_ptr r, pbf_srcptr a, pbf_srcptr b, pbf_rnd_t rnd);
PBN_API int pbf_sub_z(pbf_ptr r, pbf_srcptr a, pbz_srcptr b, pbf_rnd_t rnd);
PBN_API int pbf_sub_d(pbf_ptr r, pbf_srcptr a, double b, pbf_rnd_t rnd);
PBN_API int pbf_mul(pbf_ptr r, pbf_srcptr a, pbf_srcptr b, pbf_rnd_t rnd);
PBN_API int pbf_mul_z(pbf_ptr r, pbf_srcptr a, pbz_srcptr b, pbf_rnd_t rnd);
PBN_API int pbf_mul_d(pbf_ptr r, pbf_srcptr a, double b, pbf_rnd_t rnd);
PBN_API int pbf_div(pbf_ptr r, pbf_srcptr a, pbf_srcptr b, pbf_rnd_t rnd);
PBN_API int pbf_div_z(pbf_ptr r, pbf_srcptr a, pbz_srcptr b, pbf_rnd_t rnd);
PBN_API int pbf_div_d(pbf_ptr r, pbf_srcptr a, double b, pbf_rnd_t rnd);
PBN_API int pbf_pow(pbf_ptr r, pbf_srcptr x, pbf_srcptr y, pbf_rnd_t rnd);
PBN_API int pbf_pow_z(pbf_ptr r, pbf_srcptr x, pbz_srcptr z, pbf_rnd_t rnd);

#ifdef __cplusplus
}
#endif

/* inline helpers (macros in GMP) */
static inline int pbz_sgn(pbz_srcptr x) { return x->_mp_size < 0 ? -1 : x->_mp_size > 0; }
static inline int pbz_odd_p(pbz_srcptr x) { return x->_mp_size != 0 && (x->_mp_d[0] & 1); }
static inline int pbz_even_p(pbz_srcptr x) { return !pbz_odd_p(x); }
static inline int pbq_sgn(pbq_srcptr q) { return pbz_sgn(&q->_mp_num); }
#define pbq_numref(q) (&(q)->_mp_num)
#define pbq_denref(q) (&(q)->_mp_den)

#endif /* POCKETBIGNUM_H */

/* ========================================================================= */
/*                              IMPLEMENTATION                               */
/* ========================================================================= */

#if defined(PBN_IMPLEMENTATION) && !defined(PBN_IMPLEMENTATION_DONE)
#define PBN_IMPLEMENTATION_DONE

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdarg.h>
#include <math.h>
#include <float.h>

#if defined(_MSC_VER) && !defined(PBN_PORTABLE)
#  include <intrin.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

/* ------------------------------------------------------------------------- */
/* configuration & platform layer                                            */
/* ------------------------------------------------------------------------- */

#define PBN_B          PBN_LIMB_BITS
#define PBN_LIMB_MAX   ((pbn_limb)~(pbn_limb)0)
#define PBN_HIGHBIT    ((pbn_limb)1 << (PBN_B - 1))
#define PBN_ABS(x)     ((x) >= 0 ? (x) : -(x))
#define PBN_MIN(a, b)  ((a) < (b) ? (a) : (b))
#define PBN_MAX(a, b)  ((a) > (b) ? (a) : (b))
#define PBN_NORM(p, n) do { while ((n) > 0 && (p)[(n) - 1] == 0) (n)--; } while (0)

#define SIZ(x)   ((x)->_mp_size)
#define ALLOC(x) ((x)->_mp_alloc)
#define PTR(x)   ((x)->_mp_d)

/* thresholds that differ by CPU (tools/tune.sh); the rest are further down, all of them
   overridable with -D */
#if defined(__aarch64__) || defined(_M_ARM64)
#  ifndef PBN_MUL_FFT_THRESHOLD
#    define PBN_MUL_FFT_THRESHOLD 3000
#  endif
#  ifndef PBN_SQR_FFT_THRESHOLD
#    define PBN_SQR_FFT_THRESHOLD 3000
#  endif
#  ifndef PBN_GCD_LEHMER2_THRESHOLD
#    define PBN_GCD_LEHMER2_THRESHOLD 300
#  endif
#  ifndef PBN_GCD_HGCD_THRESHOLD
#    define PBN_GCD_HGCD_THRESHOLD 200
#  endif
#elif defined(__x86_64__) || defined(_M_X64)
#  ifndef PBN_MUL_FFT_THRESHOLD
#    define PBN_MUL_FFT_THRESHOLD 5500     /* (from 3500 on, the FFT is faster at some sizes, slower at others) */
#  endif
#  ifndef PBN_SQR_FFT_THRESHOLD
#    define PBN_SQR_FFT_THRESHOLD 5500
#  endif
#  ifndef PBN_GCD_HGCD_THRESHOLD
#    define PBN_GCD_HGCD_THRESHOLD 400
#  endif
#  ifndef PBN_GET_STR_DC_THRESHOLD
#    define PBN_GET_STR_DC_THRESHOLD 16
#  endif
#  ifndef PBN_SET_STR_DC_THRESHOLD
#    define PBN_SET_STR_DC_THRESHOLD 192
#  endif
#endif

#ifndef PBN_MUL_KARA_THRESHOLD
#  define PBN_MUL_KARA_THRESHOLD 28
#endif
#ifndef PBN_SQR_KARA_THRESHOLD
#  define PBN_SQR_KARA_THRESHOLD 40
#endif
#ifndef PBN_MUL_TOOM3_THRESHOLD
#  define PBN_MUL_TOOM3_THRESHOLD 100
#endif
#ifndef PBN_MUL_TOOM4_THRESHOLD
#  define PBN_MUL_TOOM4_THRESHOLD 250
#endif
#ifndef PBN_SQR_TOOM4_THRESHOLD
#  define PBN_SQR_TOOM4_THRESHOLD 400
#endif
#ifndef PBN_SQR_TOOM3_THRESHOLD
#  define PBN_SQR_TOOM3_THRESHOLD 160
#endif
#define PBN_KARA_ITCH(n) (4 * (n) + 4 * 64)

#if defined(__GNUC__) || defined(__clang__)
#  define PBN_NOINLINE __attribute__((noinline))
#  define PBN_INLINE static inline __attribute__((always_inline))
#  define PBN_LIKELY(x)   __builtin_expect(!!(x), 1)
#  define PBN_UNLIKELY(x) __builtin_expect(!!(x), 0)
#elif defined(_MSC_VER)
#  define PBN_NOINLINE __declspec(noinline)
#  define PBN_INLINE static __forceinline
#  define PBN_LIKELY(x)   (x)
#  define PBN_UNLIKELY(x) (x)
#else
#  define PBN_NOINLINE
#  define PBN_INLINE static inline
#  define PBN_LIKELY(x)   (x)
#  define PBN_UNLIKELY(x) (x)
#endif

#if PBN_B == 32
   typedef uint64_t pbn_dlimb;
#  define PBN_HAVE_DLIMB 1
#elif defined(__SIZEOF_INT128__) && !defined(PBN_PORTABLE)
   typedef unsigned __int128 pbn_dlimb;
#  define PBN_HAVE_DLIMB 1
#endif

#if !defined(PBN_PORTABLE) && defined(_MSC_VER) && PBN_B == 64 && (defined(_M_X64) || defined(_M_ARM64))
#  define PBN_MSVC64 1
#endif

/* (hi, lo) = a * b */
PBN_INLINE pbn_limb pbn_umul(pbn_limb a, pbn_limb b, pbn_limb *hi) {
#if defined(PBN_HAVE_DLIMB)
    pbn_dlimb p = (pbn_dlimb)a * b;
    *hi = (pbn_limb)(p >> PBN_B);
    return (pbn_limb)p;
#elif defined(PBN_MSVC64) && defined(_M_X64)
    return _umul128(a, b, hi);
#elif defined(PBN_MSVC64) && defined(_M_ARM64)
    *hi = __umulh(a, b);
    return a * b;
#else
    /* portable 64x64 -> 128 */
    uint64_t a0 = a & 0xFFFFFFFFu, a1 = a >> 32, b0 = b & 0xFFFFFFFFu, b1 = b >> 32;
    uint64_t p00 = a0 * b0, p01 = a0 * b1, p10 = a1 * b0, p11 = a1 * b1;
    uint64_t mid = (p00 >> 32) + (p01 & 0xFFFFFFFFu) + (p10 & 0xFFFFFFFFu);
    *hi = p11 + (p01 >> 32) + (p10 >> 32) + (mid >> 32);
    return (mid << 32) | (p00 & 0xFFFFFFFFu);
#endif
}

/* count leading zeros, x != 0 */
PBN_INLINE int pbn_clz(pbn_limb x) {
#if !defined(PBN_PORTABLE) && (defined(__GNUC__) || defined(__clang__))
#  if PBN_B == 64
    return __builtin_clzll((unsigned long long)x);
#  else
    return __builtin_clz((unsigned int)x);
#  endif
#elif defined(PBN_MSVC64)
    unsigned long i; _BitScanReverse64(&i, x); return 63 - (int)i;
#elif !defined(PBN_PORTABLE) && defined(_MSC_VER) && PBN_B == 32
    unsigned long i; _BitScanReverse(&i, x); return 31 - (int)i;
#else
    int n = 0;
#  if PBN_B == 64
    if (!(x >> 32)) { n += 32; x <<= 32; }
#  endif
    if (!(x >> (PBN_B - 16))) { n += 16; x <<= 16; }
    if (!(x >> (PBN_B - 8)))  { n += 8;  x <<= 8;  }
    if (!(x >> (PBN_B - 4)))  { n += 4;  x <<= 4;  }
    if (!(x >> (PBN_B - 2)))  { n += 2;  x <<= 2;  }
    if (!(x >> (PBN_B - 1)))  { n += 1; }
    return n;
#endif
}

/* count trailing zeros, x != 0 */
PBN_INLINE int pbn_ctz(pbn_limb x) {
#if !defined(PBN_PORTABLE) && (defined(__GNUC__) || defined(__clang__))
#  if PBN_B == 64
    return __builtin_ctzll((unsigned long long)x);
#  else
    return __builtin_ctz((unsigned int)x);
#  endif
#elif defined(PBN_MSVC64)
    unsigned long i; _BitScanForward64(&i, x); return (int)i;
#elif !defined(PBN_PORTABLE) && defined(_MSC_VER) && PBN_B == 32
    unsigned long i; _BitScanForward(&i, x); return (int)i;
#else
    return PBN_B - 1 - pbn_clz(x & (~x + 1));
#endif
}

PBN_INLINE int pbn_popcount_limb(pbn_limb x) {
#if !defined(PBN_PORTABLE) && (defined(__GNUC__) || defined(__clang__))
#  if PBN_B == 64
    return __builtin_popcountll((unsigned long long)x);
#  else
    return __builtin_popcount((unsigned int)x);
#  endif
#else
    int c = 0;
    while (x) { x &= x - 1; c++; }
    return c;
#endif
}

/* add/subtract with carry: compiler builtins (clang, gcc >= 14) or MSVC intrinsics where
   available, else a double-limb or plain C formulation */
#if !defined(PBN_PORTABLE) && defined(__has_builtin)
#  if PBN_B == 64 && __has_builtin(__builtin_addcll) && __has_builtin(__builtin_subcll)
#    define PBN_ADDC_BUILTIN 1
#  elif PBN_B == 32 && __has_builtin(__builtin_addc) && __has_builtin(__builtin_subc)
#    define PBN_ADDC_BUILTIN 1
#  endif
#endif

/* a + b + cin (cin: 0/1); carry out (0/1) to *cout */
PBN_INLINE pbn_limb pbn_addc(pbn_limb a, pbn_limb b, pbn_limb cin, pbn_limb *cout) {
#if defined(PBN_ADDC_BUILTIN) && PBN_B == 64
    unsigned long long c;
    pbn_limb s = __builtin_addcll(a, b, cin, &c);
    *cout = (pbn_limb)c;
    return s;
#elif defined(PBN_ADDC_BUILTIN)
    unsigned int c;
    pbn_limb s = __builtin_addc(a, b, cin, &c);
    *cout = (pbn_limb)c;
    return s;
#elif defined(PBN_MSVC64) && defined(_M_X64)
    unsigned __int64 s;
    *cout = _addcarry_u64((unsigned char)cin, a, b, &s);
    return s;
#elif defined(PBN_HAVE_DLIMB)
    pbn_dlimb t = (pbn_dlimb)a + b + cin;
    *cout = (pbn_limb)(t >> PBN_B);
    return (pbn_limb)t;
#else
    pbn_limb s = a + b, c = s < a;
    s += cin;
    c += s < cin;
    *cout = c;
    return s;
#endif
}

/* a - b - bin (bin: 0/1); borrow out (0/1) to *bout */
PBN_INLINE pbn_limb pbn_subb(pbn_limb a, pbn_limb b, pbn_limb bin, pbn_limb *bout) {
#if defined(PBN_ADDC_BUILTIN) && PBN_B == 64
    unsigned long long c;
    pbn_limb d = __builtin_subcll(a, b, bin, &c);
    *bout = (pbn_limb)c;
    return d;
#elif defined(PBN_ADDC_BUILTIN)
    unsigned int c;
    pbn_limb d = __builtin_subc(a, b, bin, &c);
    *bout = (pbn_limb)c;
    return d;
#elif defined(PBN_MSVC64) && defined(_M_X64)
    unsigned __int64 d;
    *bout = _subborrow_u64((unsigned char)bin, a, b, &d);
    return d;
#elif defined(PBN_HAVE_DLIMB)
    pbn_dlimb t = (pbn_dlimb)a - b - bin;
    *bout = (pbn_limb)(t >> PBN_B) & 1;
    return (pbn_limb)t;
#else
    pbn_limb d = a - b, c = a < b;
    c += d < bin;
    *bout = c;
    return d - bin;
#endif
}

/* ------------------------------------------------------------------------- */
/* errors & memory                                                           */
/* ------------------------------------------------------------------------- */

static void pbn_abort_default(const char *msg) {
    fprintf(stderr, "pocketbignum: %s\n", msg);
    abort();
}
#ifndef PBN_ABORT
#  define PBN_ABORT(msg) pbn_abort_default(msg)
#endif

static void *pbn_def_alloc(size_t n) {
    void *p = malloc(n);
    if (!p) PBN_ABORT("out of memory");
    return p;
}
static void *pbn_def_realloc(void *p, size_t old, size_t n) {
    (void)old;
    p = realloc(p, n);
    if (!p) PBN_ABORT("out of memory");
    return p;
}
static void pbn_def_free(void *p, size_t n) { (void)n; free(p); }

static void *(*pbn_alloc_fn)(size_t)                 = pbn_def_alloc;
static void *(*pbn_realloc_fn)(void *, size_t, size_t) = pbn_def_realloc;
static void  (*pbn_free_fn)(void *, size_t)          = pbn_def_free;

PBN_DEF void pbn_set_memory_functions(void *(*a)(size_t), void *(*r)(void *, size_t, size_t),
                                      void (*f)(void *, size_t)) {
    pbn_alloc_fn   = a ? a : pbn_def_alloc;
    pbn_realloc_fn = r ? r : pbn_def_realloc;
    pbn_free_fn    = f ? f : pbn_def_free;
}

PBN_DEF void pbn_get_memory_functions(void *(**a)(size_t), void *(**r)(void *, size_t, size_t),
                                      void (**f)(void *, size_t)) {
    if (a) *a = pbn_alloc_fn;
    if (r) *r = pbn_realloc_fn;
    if (f) *f = pbn_free_fn;
}

PBN_DEF const char *const pbn_version = PBN_VERSION;

#define PBN_TMP_ALLOC(n)    ((pbn_limb *)pbn_alloc_fn((size_t)(n) * sizeof(pbn_limb)))
#define PBN_TMP_FREE(p, n)  pbn_free_fn((p), (size_t)(n) * sizeof(pbn_limb))

/* small temporaries live on the stack, big ones on the heap */
#define PBN_STACK_LIMBS 192
#define PBN_TMP_DECL(name)       pbn_limb name##_stack[PBN_STACK_LIMBS]
#define PBN_TMP_GET(name, n)     ((n) <= PBN_STACK_LIMBS ? name##_stack : PBN_TMP_ALLOC(n))
#define PBN_TMP_PUT(name, p, n)  do { if ((p) != name##_stack) PBN_TMP_FREE((p), (n)); } while (0)

static void pbn_divzero(void) { PBN_ABORT("division by zero"); }

/* ------------------------------------------------------------------------- */
/* pbn_n: raw limb-array kernels                                             */
/* ------------------------------------------------------------------------- */

static void pbn_n_copy(pbn_limb *rp, const pbn_limb *ap, pbn_size n) {
    if (rp != ap && n > 0) memmove(rp, ap, (size_t)n * sizeof(pbn_limb));
}
static void pbn_n_zero(pbn_limb *rp, pbn_size n) {
    if (n > 0) memset(rp, 0, (size_t)n * sizeof(pbn_limb));
}

static int pbn_n_cmp(const pbn_limb *ap, const pbn_limb *bp, pbn_size n) {
    while (--n >= 0)
        if (ap[n] != bp[n]) return ap[n] > bp[n] ? 1 : -1;
    return 0;
}

/* compare numbers of possibly different lengths (leading zeros allowed) */
static int pbn_n_cmp2(const pbn_limb *ap, pbn_size an, const pbn_limb *bp, pbn_size bn) {
    PBN_NORM(ap, an);
    PBN_NORM(bp, bn);
    if (an != bn) return an > bn ? 1 : -1;
    return pbn_n_cmp(ap, bp, an);
}

static pbn_limb pbn_n_add_n(pbn_limb *rp, const pbn_limb *ap, const pbn_limb *bp, pbn_size n) {
    pbn_size i = 0;
    pbn_limb cy = 0;
    for (; i + 4 <= n; i += 4) {
        rp[i]     = pbn_addc(ap[i],     bp[i],     cy, &cy);
        rp[i + 1] = pbn_addc(ap[i + 1], bp[i + 1], cy, &cy);
        rp[i + 2] = pbn_addc(ap[i + 2], bp[i + 2], cy, &cy);
        rp[i + 3] = pbn_addc(ap[i + 3], bp[i + 3], cy, &cy);
    }
    for (; i < n; i++) rp[i] = pbn_addc(ap[i], bp[i], cy, &cy);
    return cy;
}

static pbn_limb pbn_n_sub_n(pbn_limb *rp, const pbn_limb *ap, const pbn_limb *bp, pbn_size n) {
    pbn_size i = 0;
    pbn_limb bw = 0;
    for (; i + 4 <= n; i += 4) {
        rp[i]     = pbn_subb(ap[i],     bp[i],     bw, &bw);
        rp[i + 1] = pbn_subb(ap[i + 1], bp[i + 1], bw, &bw);
        rp[i + 2] = pbn_subb(ap[i + 2], bp[i + 2], bw, &bw);
        rp[i + 3] = pbn_subb(ap[i + 3], bp[i + 3], bw, &bw);
    }
    for (; i < n; i++) rp[i] = pbn_subb(ap[i], bp[i], bw, &bw);
    return bw;
}

static pbn_limb pbn_n_add_1(pbn_limb *rp, const pbn_limb *ap, pbn_size n, pbn_limb b) {
    pbn_size i;
    for (i = 0; i < n; i++) {
        pbn_limb s = ap[i] + b;
        b = s < b;
        rp[i] = s;
        if (!b) {
            if (rp != ap) for (i++; i < n; i++) rp[i] = ap[i];
            return 0;
        }
    }
    return b;
}

static pbn_limb pbn_n_sub_1(pbn_limb *rp, const pbn_limb *ap, pbn_size n, pbn_limb b) {
    pbn_size i;
    for (i = 0; i < n; i++) {
        pbn_limb a = ap[i];
        rp[i] = a - b;
        b = a < b;
        if (!b) {
            if (rp != ap) for (i++; i < n; i++) rp[i] = ap[i];
            return 0;
        }
    }
    return b;
}

/* an >= bn >= 0 */
static pbn_limb pbn_n_add(pbn_limb *rp, const pbn_limb *ap, pbn_size an, const pbn_limb *bp, pbn_size bn) {
    pbn_limb cy = pbn_n_add_n(rp, ap, bp, bn);
    return pbn_n_add_1(rp + bn, ap + bn, an - bn, cy);
}
static pbn_limb pbn_n_sub(pbn_limb *rp, const pbn_limb *ap, pbn_size an, const pbn_limb *bp, pbn_size bn) {
    pbn_limb bw = pbn_n_sub_n(rp, ap, bp, bn);
    return pbn_n_sub_1(rp + bn, ap + bn, an - bn, bw);
}

/* rp = -ap mod B^n; returns 1 if ap != 0 */
static pbn_limb pbn_n_neg(pbn_limb *rp, const pbn_limb *ap, pbn_size n) {
    pbn_size i = 0;
    while (i < n && ap[i] == 0) rp[i++] = 0;
    if (i == n) return 0;
    rp[i] = ~ap[i] + 1;
    for (i++; i < n; i++) rp[i] = ~ap[i];
    return 1;
}

#if defined(PBN_HAVE_DLIMB)

static pbn_limb pbn_n_mul_1_c(pbn_limb *rp, const pbn_limb *ap, pbn_size n, pbn_limb b) {
    pbn_dlimb t = 0;
    pbn_size i = 0;
    for (; i + 2 <= n; i += 2) {
        t = (pbn_dlimb)ap[i] * b + (pbn_limb)(t >> PBN_B);         rp[i] = (pbn_limb)t;
        t = (pbn_dlimb)ap[i + 1] * b + (pbn_limb)(t >> PBN_B);     rp[i + 1] = (pbn_limb)t;
    }
    for (; i < n; i++) { t = (pbn_dlimb)ap[i] * b + (pbn_limb)(t >> PBN_B); rp[i] = (pbn_limb)t; }
    return (pbn_limb)(t >> PBN_B);
}

static pbn_limb pbn_n_addmul_1_c(pbn_limb *rp, const pbn_limb *ap, pbn_size n, pbn_limb b) {
    pbn_dlimb t = 0;
    pbn_size i = 0;
    for (; i + 2 <= n; i += 2) {
        t = (pbn_dlimb)ap[i] * b + rp[i] + (pbn_limb)(t >> PBN_B);             rp[i] = (pbn_limb)t;
        t = (pbn_dlimb)ap[i + 1] * b + rp[i + 1] + (pbn_limb)(t >> PBN_B);     rp[i + 1] = (pbn_limb)t;
    }
    for (; i < n; i++) { t = (pbn_dlimb)ap[i] * b + rp[i] + (pbn_limb)(t >> PBN_B); rp[i] = (pbn_limb)t; }
    return (pbn_limb)(t >> PBN_B);
}

static pbn_limb pbn_n_submul_1_c(pbn_limb *rp, const pbn_limb *ap, pbn_size n, pbn_limb b) {
    pbn_limb cy = 0, lo, r;
    pbn_dlimb p;
    pbn_size i = 0;
    for (; i + 2 <= n; i += 2) {
        p = (pbn_dlimb)ap[i] * b + cy;
        lo = (pbn_limb)p; r = rp[i];
        rp[i] = r - lo;
        cy = (pbn_limb)(p >> PBN_B) + (r < lo);
        p = (pbn_dlimb)ap[i + 1] * b + cy;
        lo = (pbn_limb)p; r = rp[i + 1];
        rp[i + 1] = r - lo;
        cy = (pbn_limb)(p >> PBN_B) + (r < lo);
    }
    for (; i < n; i++) {
        p = (pbn_dlimb)ap[i] * b + cy;
        lo = (pbn_limb)p; r = rp[i];
        rp[i] = r - lo;
        cy = (pbn_limb)(p >> PBN_B) + (r < lo);
    }
    return cy;
}

/* rp[0..n] = rp[0..n) + a * (b0 + b1 B); returns the limb above (two rows of the
   schoolbook product per pass: half the loads & stores of two addmul_1 passes) */
#define PBN_HAVE_ADDMUL_2 1
static pbn_limb pbn_n_addmul_2(pbn_limb *rp, const pbn_limb *ap, pbn_size n, pbn_limb b0, pbn_limb b1) {
    pbn_dlimb t;
    pbn_limb h0, h1 = 0, prev = ap[0], x;
    pbn_size k;
    t = (pbn_dlimb)prev * b0 + rp[0];
    rp[0] = (pbn_limb)t;
    h0 = (pbn_limb)(t >> PBN_B);
    for (k = 1; k < n; k++) {
        pbn_limb a = ap[k];
        t = (pbn_dlimb)a * b0 + rp[k] + h0;              /* row b0, position k */
        x = (pbn_limb)t;
        h0 = (pbn_limb)(t >> PBN_B);
        t = (pbn_dlimb)prev * b1 + x + h1;               /* row b1, position k */
        rp[k] = (pbn_limb)t;
        h1 = (pbn_limb)(t >> PBN_B);
        prev = a;
    }
    t = (pbn_dlimb)prev * b1 + h0 + h1;
    rp[n] = (pbn_limb)t;
    return (pbn_limb)(t >> PBN_B);
}

#else

static pbn_limb pbn_n_mul_1_c(pbn_limb *rp, const pbn_limb *ap, pbn_size n, pbn_limb b) {
    pbn_limb cy = 0, hi, lo;
    pbn_size i;
    for (i = 0; i < n; i++) {
        lo = pbn_umul(ap[i], b, &hi);
        lo += cy;
        cy = hi + (lo < cy);
        rp[i] = lo;
    }
    return cy;
}

static pbn_limb pbn_n_addmul_1_c(pbn_limb *rp, const pbn_limb *ap, pbn_size n, pbn_limb b) {
    pbn_limb cy = 0, hi, lo, r;
    pbn_size i;
    for (i = 0; i < n; i++) {
        lo = pbn_umul(ap[i], b, &hi);
        lo += cy;
        hi += lo < cy;
        r = rp[i];
        lo += r;
        hi += lo < r;
        rp[i] = lo;
        cy = hi;
    }
    return cy;
}

static pbn_limb pbn_n_submul_1_c(pbn_limb *rp, const pbn_limb *ap, pbn_size n, pbn_limb b) {
    pbn_limb cy = 0, hi, lo, r;
    pbn_size i;
    for (i = 0; i < n; i++) {
        lo = pbn_umul(ap[i], b, &hi);
        lo += cy;
        hi += lo < cy;
        r = rp[i];
        rp[i] = r - lo;
        cy = hi + (r < lo);
    }
    return cy;
}

#endif

/* ---- assembly kernels for mul_1 / addmul_1 / submul_1 (on by default; -DPBN_NO_ASM or
        PBN_PORTABLE for plain C). x86-64: mulx with two carry chains (adcx / adox), used when
        the CPU has BMI2 & ADX (checked once); arm64: two limbs per step ---- */

#if !defined(PBN_PORTABLE) && !defined(PBN_NO_ASM) && (defined(__GNUC__) || defined(__clang__)) && PBN_B == 64 \
    && defined(PBN_HAVE_DLIMB) && defined(__x86_64__)
#  define PBN_ASM_X86 1
#  include <cpuid.h>

static int pbn_cpu_adx(void) {
    static int have = -1;
    if (have < 0) {
        unsigned a = 0, b = 0, c = 0, d = 0;
        int v = 0;
        if (__get_cpuid_max(0, NULL) >= 7) {
            __cpuid_count(7, 0, a, b, c, d);
            v = ((b >> 8) & 1) && ((b >> 19) & 1);      /* BMI2 (mulx), ADX (adcx, adox) */
        }
        have = v;
    }
    return have;
}

/* n a positive multiple of 4; cy: carry in (the limb to add at position 0) */
static pbn_limb pbn_mul_1_adx(pbn_limb *rp, const pbn_limb *ap, pbn_size n, pbn_limb b, pbn_limb cy) {
    pbn_limb l0, l1, l2, l3, h0, h1, h2;
    long long i = -(long long)n;   /* 64-bit index register, also on LLP64 (Windows) */
    __asm__ __volatile__(
        "xor %k[l0], %k[l0]\n"                        /* CF = OF = 0 */
        "1:\n\t"
        "mulx (%[ae],%[i],8), %[l0], %[h0]\n\t"
        "mulx 8(%[ae],%[i],8), %[l1], %[h1]\n\t"
        "adcx %[cy], %[l0]\n\t"
        "mulx 16(%[ae],%[i],8), %[l2], %[h2]\n\t"
        "adcx %[h0], %[l1]\n\t"
        "mulx 24(%[ae],%[i],8), %[l3], %[cy]\n\t"
        "adcx %[h1], %[l2]\n\t"
        "adcx %[h2], %[l3]\n\t"
        "mov %[l0], (%[re],%[i],8)\n\t"
        "mov %[l1], 8(%[re],%[i],8)\n\t"
        "mov %[l2], 16(%[re],%[i],8)\n\t"
        "mov %[l3], 24(%[re],%[i],8)\n\t"
        "lea 4(%[i]), %[i]\n\t"
        "jrcxz 2f\n\t"
        "jmp 1b\n"
        "2:\n\t"
        "mov $0, %k[l0]\n\t"
        "adcx %[l0], %[cy]\n\t"
        : [cy] "+r"(cy), [l0] "=&r"(l0), [l1] "=&r"(l1), [l2] "=&r"(l2), [l3] "=&r"(l3),
          [h0] "=&r"(h0), [h1] "=&r"(h1), [h2] "=&r"(h2), [i] "+c"(i)
        : [ae] "r"(ap + n), [re] "r"(rp + n), "d"(b)
        : "cc", "memory");
    return cy;
}

static pbn_limb pbn_addmul_1_adx(pbn_limb *rp, const pbn_limb *ap, pbn_size n, pbn_limb b, pbn_limb cy) {
    pbn_limb l0, l1, l2, l3, h0, h1, h2;
    long long i = -(long long)n;   /* 64-bit index register, also on LLP64 (Windows) */
    __asm__ __volatile__(
        "xor %k[l0], %k[l0]\n"                        /* CF = OF = 0 */
        "1:\n\t"
        "mulx (%[ae],%[i],8), %[l0], %[h0]\n\t"
        "mulx 8(%[ae],%[i],8), %[l1], %[h1]\n\t"
        "adcx %[cy], %[l0]\n\t"                       /* the products' chain: CF */
        "mulx 16(%[ae],%[i],8), %[l2], %[h2]\n\t"
        "adcx %[h0], %[l1]\n\t"
        "mulx 24(%[ae],%[i],8), %[l3], %[cy]\n\t"
        "adcx %[h1], %[l2]\n\t"
        "adcx %[h2], %[l3]\n\t"
        "adox (%[re],%[i],8), %[l0]\n\t"              /* adding to r: OF */
        "adox 8(%[re],%[i],8), %[l1]\n\t"
        "adox 16(%[re],%[i],8), %[l2]\n\t"
        "adox 24(%[re],%[i],8), %[l3]\n\t"
        "mov %[l0], (%[re],%[i],8)\n\t"
        "mov %[l1], 8(%[re],%[i],8)\n\t"
        "mov %[l2], 16(%[re],%[i],8)\n\t"
        "mov %[l3], 24(%[re],%[i],8)\n\t"
        "lea 4(%[i]), %[i]\n\t"
        "jrcxz 2f\n\t"
        "jmp 1b\n"
        "2:\n\t"
        "mov $0, %k[l0]\n\t"
        "adcx %[l0], %[cy]\n\t"
        "adox %[l0], %[cy]\n\t"
        : [cy] "+r"(cy), [l0] "=&r"(l0), [l1] "=&r"(l1), [l2] "=&r"(l2), [l3] "=&r"(l3),
          [h0] "=&r"(h0), [h1] "=&r"(h1), [h2] "=&r"(h2), [i] "+c"(i)
        : [ae] "r"(ap + n), [re] "r"(rp + n), "d"(b)
        : "cc", "memory");
    return cy;
}

static pbn_limb pbn_submul_1_adx(pbn_limb *rp, const pbn_limb *ap, pbn_size n, pbn_limb b, pbn_limb cy) {
    pbn_limb l0, l1, l2, l3, h0, h1, h2;
    long long i = -(long long)n;   /* 64-bit index register, also on LLP64 (Windows) */
    __asm__ __volatile__(
        "xor %k[l0], %k[l0]\n\t"                      /* CF = OF = 0 */
        "stc\n"                                       /* CF = 1: r - x = r + ~x + 1 */
        "1:\n\t"
        "mulx (%[ae],%[i],8), %[l0], %[h0]\n\t"
        "mulx 8(%[ae],%[i],8), %[l1], %[h1]\n\t"
        "adox %[cy], %[l0]\n\t"                       /* the products' chain: OF */
        "mulx 16(%[ae],%[i],8), %[l2], %[h2]\n\t"
        "adox %[h0], %[l1]\n\t"
        "mulx 24(%[ae],%[i],8), %[l3], %[cy]\n\t"
        "adox %[h1], %[l2]\n\t"
        "adox %[h2], %[l3]\n\t"
        "not %[l0]\n\t"
        "not %[l1]\n\t"
        "not %[l2]\n\t"
        "not %[l3]\n\t"
        "adcx (%[re],%[i],8), %[l0]\n\t"              /* r + ~x + CF: CF */
        "adcx 8(%[re],%[i],8), %[l1]\n\t"
        "adcx 16(%[re],%[i],8), %[l2]\n\t"
        "adcx 24(%[re],%[i],8), %[l3]\n\t"
        "mov %[l0], (%[re],%[i],8)\n\t"
        "mov %[l1], 8(%[re],%[i],8)\n\t"
        "mov %[l2], 16(%[re],%[i],8)\n\t"
        "mov %[l3], 24(%[re],%[i],8)\n\t"
        "lea 4(%[i]), %[i]\n\t"
        "jrcxz 2f\n\t"
        "jmp 1b\n"
        "2:\n\t"
        "mov $0, %k[l0]\n\t"
        "adox %[l0], %[cy]\n\t"                       /* + the last OF */
        "cmc\n\t"
        "adc %[l0], %[cy]\n\t"                        /* + the borrow (1 - CF) */
        : [cy] "+r"(cy), [l0] "=&r"(l0), [l1] "=&r"(l1), [l2] "=&r"(l2), [l3] "=&r"(l3),
          [h0] "=&r"(h0), [h1] "=&r"(h1), [h2] "=&r"(h2), [i] "+c"(i)
        : [ae] "r"(ap + n), [re] "r"(rp + n), "d"(b)
        : "cc", "memory");
    return cy;
}

#elif !defined(PBN_PORTABLE) && !defined(PBN_NO_ASM) && (defined(__GNUC__) || defined(__clang__)) && PBN_B == 64 \
    && defined(PBN_HAVE_DLIMB) && defined(__aarch64__)
#  define PBN_ASM_ARM64 1

/* k >= 1 pairs of limbs; cy in, returns cy out */
static pbn_limb pbn_mul_1_arm(pbn_limb *rp, const pbn_limb *ap, pbn_size k, pbn_limb b, pbn_limb cy) {
    pbn_limb a0, a1, l0, l1, h0, h1;
    __asm__ __volatile__(
        "1:\n\t"
        "ldp %[a0], %[a1], [%[ap]], #16\n\t"
        "mul %[l0], %[a0], %[b]\n\t"
        "umulh %[h0], %[a0], %[b]\n\t"
        "mul %[l1], %[a1], %[b]\n\t"
        "umulh %[h1], %[a1], %[b]\n\t"
        "adds %[l0], %[l0], %[cy]\n\t"
        "adcs %[l1], %[l1], %[h0]\n\t"
        "adc %[cy], %[h1], xzr\n\t"
        "stp %[l0], %[l1], [%[rp]], #16\n\t"
        "subs %[k], %[k], #1\n\t"
        "b.ne 1b\n\t"
        : [a0] "=&r"(a0), [a1] "=&r"(a1), [l0] "=&r"(l0), [l1] "=&r"(l1), [h0] "=&r"(h0), [h1] "=&r"(h1),
          [cy] "+r"(cy), [ap] "+r"(ap), [rp] "+r"(rp), [k] "+r"(k)
        : [b] "r"(b)
        : "cc", "memory");
    return cy;
}

static pbn_limb pbn_addmul_1_arm(pbn_limb *rp, const pbn_limb *ap, pbn_size k, pbn_limb b, pbn_limb cy) {
    pbn_limb a0, a1, l0, l1, h0, h1, r0, r1;
    __asm__ __volatile__(
        "1:\n\t"
        "ldp %[a0], %[a1], [%[ap]], #16\n\t"
        "ldp %[r0], %[r1], [%[rp]]\n\t"
        "mul %[l0], %[a0], %[b]\n\t"
        "umulh %[h0], %[a0], %[b]\n\t"
        "mul %[l1], %[a1], %[b]\n\t"
        "umulh %[h1], %[a1], %[b]\n\t"
        "adds %[l0], %[l0], %[cy]\n\t"
        "adcs %[l1], %[l1], %[h0]\n\t"
        "adc %[h1], %[h1], xzr\n\t"
        "adds %[r0], %[r0], %[l0]\n\t"
        "adcs %[r1], %[r1], %[l1]\n\t"
        "adc %[cy], %[h1], xzr\n\t"
        "stp %[r0], %[r1], [%[rp]], #16\n\t"
        "subs %[k], %[k], #1\n\t"
        "b.ne 1b\n\t"
        : [a0] "=&r"(a0), [a1] "=&r"(a1), [l0] "=&r"(l0), [l1] "=&r"(l1), [h0] "=&r"(h0), [h1] "=&r"(h1),
          [r0] "=&r"(r0), [r1] "=&r"(r1), [cy] "+r"(cy), [ap] "+r"(ap), [rp] "+r"(rp), [k] "+r"(k)
        : [b] "r"(b)
        : "cc", "memory");
    return cy;
}

static pbn_limb pbn_submul_1_arm(pbn_limb *rp, const pbn_limb *ap, pbn_size k, pbn_limb b, pbn_limb cy) {
    pbn_limb a0, a1, l0, l1, h0, h1, r0, r1;
    __asm__ __volatile__(
        "1:\n\t"
        "ldp %[a0], %[a1], [%[ap]], #16\n\t"
        "ldp %[r0], %[r1], [%[rp]]\n\t"
        "mul %[l0], %[a0], %[b]\n\t"
        "umulh %[h0], %[a0], %[b]\n\t"
        "mul %[l1], %[a1], %[b]\n\t"
        "umulh %[h1], %[a1], %[b]\n\t"
        "adds %[l0], %[l0], %[cy]\n\t"
        "adcs %[l1], %[l1], %[h0]\n\t"
        "adc %[h1], %[h1], xzr\n\t"
        "subs %[r0], %[r0], %[l0]\n\t"
        "sbcs %[r1], %[r1], %[l1]\n\t"
        "cinc %[cy], %[h1], cc\n\t"                   /* + the borrow */
        "stp %[r0], %[r1], [%[rp]], #16\n\t"
        "subs %[k], %[k], #1\n\t"
        "b.ne 1b\n\t"
        : [a0] "=&r"(a0), [a1] "=&r"(a1), [l0] "=&r"(l0), [l1] "=&r"(l1), [h0] "=&r"(h0), [h1] "=&r"(h1),
          [r0] "=&r"(r0), [r1] "=&r"(r1), [cy] "+r"(cy), [ap] "+r"(ap), [rp] "+r"(rp), [k] "+r"(k)
        : [b] "r"(b)
        : "cc", "memory");
    return cy;
}
#endif

static pbn_limb pbn_n_mul_1(pbn_limb *rp, const pbn_limb *ap, pbn_size n, pbn_limb b) {
#if defined(PBN_ASM_X86)
    if (n >= 8 && pbn_cpu_adx()) {
        pbn_size r = n & 3;
        pbn_limb cy = r ? pbn_n_mul_1_c(rp, ap, r, b) : 0;
        return pbn_mul_1_adx(rp + r, ap + r, n - r, b, cy);
    }
#elif defined(PBN_ASM_ARM64)
    if (n >= 2) {
        pbn_limb cy = 0;
        if (n & 1) { pbn_dlimb t = (pbn_dlimb)ap[0] * b; rp[0] = (pbn_limb)t; cy = (pbn_limb)(t >> PBN_B); rp++; ap++; }
        return pbn_mul_1_arm(rp, ap, n / 2, b, cy);
    }
#endif
    return pbn_n_mul_1_c(rp, ap, n, b);
}

static pbn_limb pbn_n_addmul_1(pbn_limb *rp, const pbn_limb *ap, pbn_size n, pbn_limb b) {
#if defined(PBN_ASM_X86)
    if (n >= 8 && pbn_cpu_adx()) {
        pbn_size r = n & 3;
        pbn_limb cy = r ? pbn_n_addmul_1_c(rp, ap, r, b) : 0;
        return pbn_addmul_1_adx(rp + r, ap + r, n - r, b, cy);
    }
#elif defined(PBN_ASM_ARM64)
    if (n >= 2) {
        pbn_limb cy = 0;
        if (n & 1) { pbn_dlimb t = (pbn_dlimb)ap[0] * b + rp[0]; rp[0] = (pbn_limb)t; cy = (pbn_limb)(t >> PBN_B); rp++; ap++; }
        return pbn_addmul_1_arm(rp, ap, n / 2, b, cy);
    }
#endif
    return pbn_n_addmul_1_c(rp, ap, n, b);
}

static pbn_limb pbn_n_submul_1(pbn_limb *rp, const pbn_limb *ap, pbn_size n, pbn_limb b) {
#if defined(PBN_ASM_X86)
    if (n >= 8 && pbn_cpu_adx()) {
        pbn_size r = n & 3;
        pbn_limb cy = r ? pbn_n_submul_1_c(rp, ap, r, b) : 0;
        return pbn_submul_1_adx(rp + r, ap + r, n - r, b, cy);
    }
#elif defined(PBN_ASM_ARM64)
    if (n >= 2) {
        pbn_limb cy = 0;
        if (n & 1) {
            pbn_dlimb p = (pbn_dlimb)ap[0] * b;
            pbn_limb lo = (pbn_limb)p, r = rp[0];
            rp[0] = r - lo;
            cy = (pbn_limb)(p >> PBN_B) + (r < lo);
            rp++; ap++;
        }
        return pbn_submul_1_arm(rp, ap, n / 2, b, cy);
    }
#endif
    return pbn_n_submul_1_c(rp, ap, n, b);
}

/* 1 <= cnt < B; processes high to low (safe for rp >= ap) */
static pbn_limb pbn_n_lshift(pbn_limb *rp, const pbn_limb *ap, pbn_size n, unsigned cnt) {
    unsigned tnc = PBN_B - cnt;
    pbn_limb hi = ap[n - 1], out = hi >> tnc;
    pbn_size i;
    for (i = n - 1; i > 0; i--) {
        pbn_limb lo = ap[i - 1];
        rp[i] = (hi << cnt) | (lo >> tnc);
        hi = lo;
    }
    rp[0] = hi << cnt;
    return out;
}

/* 1 <= cnt < B; processes low to high (safe for rp <= ap) */
static pbn_limb pbn_n_rshift(pbn_limb *rp, const pbn_limb *ap, pbn_size n, unsigned cnt) {
    unsigned tnc = PBN_B - cnt;
    pbn_limb lo = ap[0], out = lo << tnc;
    pbn_size i;
    for (i = 0; i < n - 1; i++) {
        pbn_limb hi = ap[i + 1];
        rp[i] = (lo >> cnt) | (hi << tnc);
        lo = hi;
    }
    rp[n - 1] = lo >> cnt;
    return out;
}

/* ---- single-limb division (Möller–Granlund, "Improved division by invariant integers") ---- */

/* plain 2-by-1 division, d normalized, n1 < d (used only to compute inverses) */
static pbn_limb pbn_udiv_qrnnd(pbn_limb *r, pbn_limb n1, pbn_limb n0, pbn_limb d) {
#if defined(PBN_HAVE_DLIMB)
    pbn_dlimb n = ((pbn_dlimb)n1 << PBN_B) | n0;
    *r = (pbn_limb)(n % d);
    return (pbn_limb)(n / d);
#else
    const unsigned H = PBN_B / 2;
    const pbn_limb LOW = ((pbn_limb)1 << H) - 1;
    pbn_limb d1 = d >> H, d0 = d & LOW, q1, q0, r1, r0, m;
    q1 = n1 / d1; r1 = n1 - q1 * d1;
    m = q1 * d0;
    r1 = (r1 << H) | (n0 >> H);
    if (r1 < m) { q1--; r1 += d; if (r1 >= d && r1 < m) { q1--; r1 += d; } }
    r1 -= m;
    q0 = r1 / d1; r0 = r1 - q0 * d1;
    m = q0 * d0;
    r0 = (r0 << H) | (n0 & LOW);
    if (r0 < m) { q0--; r0 += d; if (r0 >= d && r0 < m) { q0--; r0 += d; } }
    r0 -= m;
    *r = r0;
    return (q1 << H) | q0;
#endif
}

/* v = floor((B^2 - 1) / d) - B, d normalized */
#if PBN_B == 64
/* floor((2^19 - 3*2^8) / d9) for d9 = 256..511: the first step of the reciprocal below */
static const uint16_t pbn_invert_tab[256] = {
    2045, 2037, 2029, 2021, 2013, 2005, 1998, 1990, 1983, 1975, 1968, 1960, 1953, 1946, 1938, 1931,
    1924, 1917, 1910, 1903, 1896, 1889, 1883, 1876, 1869, 1863, 1856, 1849, 1843, 1836, 1830, 1824,
    1817, 1811, 1805, 1799, 1792, 1786, 1780, 1774, 1768, 1762, 1756, 1750, 1745, 1739, 1733, 1727,
    1722, 1716, 1710, 1705, 1699, 1694, 1688, 1683, 1677, 1672, 1667, 1661, 1656, 1651, 1646, 1641,
    1636, 1630, 1625, 1620, 1615, 1610, 1605, 1600, 1596, 1591, 1586, 1581, 1576, 1572, 1567, 1562,
    1558, 1553, 1548, 1544, 1539, 1535, 1530, 1526, 1521, 1517, 1513, 1508, 1504, 1500, 1495, 1491,
    1487, 1483, 1478, 1474, 1470, 1466, 1462, 1458, 1454, 1450, 1446, 1442, 1438, 1434, 1430, 1426,
    1422, 1418, 1414, 1411, 1407, 1403, 1399, 1396, 1392, 1388, 1384, 1381, 1377, 1374, 1370, 1366,
    1363, 1359, 1356, 1352, 1349, 1345, 1342, 1338, 1335, 1332, 1328, 1325, 1322, 1318, 1315, 1312,
    1308, 1305, 1302, 1299, 1295, 1292, 1289, 1286, 1283, 1280, 1276, 1273, 1270, 1267, 1264, 1261,
    1258, 1255, 1252, 1249, 1246, 1243, 1240, 1237, 1234, 1231, 1228, 1226, 1223, 1220, 1217, 1214,
    1211, 1209, 1206, 1203, 1200, 1197, 1195, 1192, 1189, 1187, 1184, 1181, 1179, 1176, 1173, 1171,
    1168, 1165, 1163, 1160, 1158, 1155, 1153, 1150, 1148, 1145, 1143, 1140, 1138, 1135, 1133, 1130,
    1128, 1125, 1123, 1121, 1118, 1116, 1113, 1111, 1109, 1106, 1104, 1102, 1099, 1097, 1095, 1092,
    1090, 1088, 1086, 1083, 1081, 1079, 1077, 1074, 1072, 1070, 1068, 1066, 1064, 1061, 1059, 1057,
    1055, 1053, 1051, 1049, 1047, 1044, 1042, 1040, 1038, 1036, 1034, 1032, 1030, 1028, 1026, 1024
};
#endif

static pbn_limb pbn_invert_limb(pbn_limb d) {
#if PBN_B == 64
    /* Moller & Granlund, Algorithm 2 ("reciprocal_word"): a table lookup & multiplications
       only, since a 128/64 division is slow on many CPUs (or goes through a runtime routine) */
    pbn_limb d0 = d & 1, d9 = d >> 55, d40 = (d >> 24) + 1, d63 = (d >> 1) + d0;
    pbn_limb v0 = pbn_invert_tab[d9 - 256];
    pbn_limb v1 = (v0 << 11) - ((v0 * v0 * d40) >> 40) - 1;
    pbn_limb v2 = (v1 << 13) + ((v1 * (((pbn_limb)1 << 60) - v1 * d40)) >> 47);
    pbn_limb e = ((v2 >> 1) & ((pbn_limb)0 - d0)) - v2 * d63;
    pbn_limb v3, hi, lo;
    pbn_umul(v2, e, &hi);
    v3 = (v2 << 31) + (hi >> 1);
    lo = pbn_umul(v3, d, &hi);
    lo += d;
    hi += lo < d;
    return v3 - hi - d;
#else
    pbn_limb r;
    return pbn_udiv_qrnnd(&r, ~d, PBN_LIMB_MAX, d);
#endif
}

/* (nh, nl) / d with precomputed inverse; nh < d, d normalized */
PBN_INLINE pbn_limb pbn_div_preinv(pbn_limb *rem, pbn_limb nh, pbn_limb nl, pbn_limb d, pbn_limb di) {
    pbn_limb qh, ql, r;
    ql = pbn_umul(nh, di, &qh);
    ql += nl;
    qh += nh + 1 + (ql < nl);
    r = nl - qh * d;
    if (r > ql) { qh--; r += d; }
    if (PBN_UNLIKELY(r >= d)) { qh++; r -= d; }
    *rem = r;
    return qh;
}

/* qp[0..n) = np / d, returns remainder; qp may be NULL or alias np */
static pbn_limb pbn_n_divrem_1(pbn_limb *qp, const pbn_limb *np, pbn_size n, pbn_limb d) {
    int s = pbn_clz(d);
    pbn_limb dn = d << s, di = pbn_invert_limb(dn), r = 0, q;
    pbn_size i;
    if (n == 0) return 0;
    if (s == 0) {
        for (i = n - 1; i >= 0; i--) {
            q = pbn_div_preinv(&r, r, np[i], dn, di);
            if (qp) qp[i] = q;
        }
        return r;
    }
    r = np[n - 1] >> (PBN_B - s);
    for (i = n - 1; i >= 0; i--) {
        pbn_limb n0 = (np[i] << s) | (i > 0 ? np[i - 1] >> (PBN_B - s) : 0);
        q = pbn_div_preinv(&r, r, n0, dn, di);
        if (qp) qp[i] = q;
    }
    return r >> s;
}

/* 3/2 reciprocal floor((B^3 - 1) / (d1 B + d0)) - B, d1 normalized (Moller & Granlund,
   "Improved division by invariant integers", Algorithm 6) */
static pbn_limb pbn_invert_3by2(pbn_limb d1, pbn_limb d0) {
    pbn_limb v = pbn_invert_limb(d1), p = d1 * v, t1, t0;
    p += d0;
    if (p < d0) {
        v--;
        if (p >= d1) { v--; p -= d1; }
        p -= d1;
    }
    t0 = pbn_umul(v, d0, &t1);
    p += t1;
    if (p < t1) {
        v--;
        if (p > d1 || (p == d1 && t0 >= d0)) v--;
    }
    return v;
}

/* (n2 n1 n0) / (d1 d0) for (n2 n1) < (d1 d0), d1 normalized, v = pbn_invert_3by2(d1, d0):
   the quotient, and the remainder in *r1:*r0 (Algorithm 5) */
PBN_INLINE pbn_limb pbn_div_3by2(pbn_limb *r1p, pbn_limb *r0p, pbn_limb n2, pbn_limb n1, pbn_limb n0,
                                 pbn_limb d1, pbn_limb d0, pbn_limb v) {
    pbn_limb q1, q0, r1, r0, t1, t0, bw;
    q0 = pbn_umul(v, n2, &q1);
    q0 += n1;
    q1 += n2 + (q0 < n1);
    r1 = n1 - q1 * d1;
    t0 = pbn_umul(d0, q1, &t1);
    /* (r1, r0) = (r1, n0) - (t1, t0) - (d1, d0) */
    bw = n0 < t0;
    r0 = n0 - t0;
    r1 = r1 - t1 - bw;
    bw = r0 < d0;
    r0 -= d0;
    r1 = r1 - d1 - bw;
    q1++;
    if (r1 >= q0) {
        q1--;
        r0 += d0;
        r1 += d1 + (r0 < d0);
    }
    if (PBN_UNLIKELY(r1 > d1 || (r1 == d1 && r0 >= d0))) {
        q1++;
        bw = r0 < d0;
        r0 -= d0;
        r1 -= d1 + bw;
    }
    *r1p = r1;
    *r0p = r0;
    return q1;
}

/* ---- schoolbook division (Knuth D, quotient limbs by 3/2 division). qp: nn-dn+1 limbs,
        rp: dn limbs ---- */
static void pbn_n_tdiv_qr_basecase(pbn_limb *qp, pbn_limb *rp, const pbn_limb *np, pbn_size nn,
                          const pbn_limb *dp, pbn_size dn) {
    int s;
    pbn_limb *u, *dd, d1, d0, di;
    pbn_size j;
    PBN_TMP_DECL(ub);

    if (dn == 1) {
        rp[0] = pbn_n_divrem_1(qp, np, nn, dp[0]);
        return;
    }

    s = pbn_clz(dp[dn - 1]);
    u = PBN_TMP_GET(ub, nn + 1 + dn);
    dd = u + nn + 1;
    if (s) {
        pbn_n_lshift(dd, dp, dn, (unsigned)s);
        u[nn] = pbn_n_lshift(u, np, nn, (unsigned)s);
    } else {
        pbn_n_copy(dd, dp, dn);
        pbn_n_copy(u, np, nn);
        u[nn] = 0;
    }

    d1 = dd[dn - 1];
    d0 = dd[dn - 2];
    di = pbn_invert_3by2(d1, d0);

    for (j = nn - dn; j >= 0; j--) {
        pbn_limb n2 = u[j + dn], n1 = u[j + dn - 1], n0 = u[j + dn - 2];
        pbn_limb q, r1, r0, cy, cy1;

        if (PBN_UNLIKELY(n2 == d1 && n1 == d0)) {
            /* (n2 n1) = (d1 d0): the 3/2 division doesn't apply, q is B-1 (or one less) */
            q = PBN_LIMB_MAX;
            cy = pbn_n_submul_1(u + j, dd, dn, q);
            if (n2 < cy) {
                q--;
                pbn_n_add_n(u + j, u + j, dd, dn);
            }
        } else {
            /* q and the top two limbs of the remainder from the top limbs, then the rest */
            q = pbn_div_3by2(&r1, &r0, n2, n1, n0, d1, d0, di);
            cy = pbn_n_submul_1(u + j, dd, dn - 2, q);
            cy1 = r0 < cy;
            r0 -= cy;
            cy = r1 < cy1;
            r1 -= cy1;
            u[j + dn - 2] = r0;
            if (PBN_UNLIKELY(cy)) {
                /* q was one too big: add the divisor back */
                r1 += d1 + pbn_n_add_n(u + j, u + j, dd, dn - 1);
                q--;
            }
            u[j + dn - 1] = r1;
        }
        u[j + dn] = 0;
        qp[j] = q;
    }

    if (s) pbn_n_rshift(rp, u, dn, (unsigned)s);
    else   pbn_n_copy(rp, u, dn);
    PBN_TMP_PUT(ub, u, nn + 1 + dn);
}

/* ---- multiplication ---- */

/* With the x86-64 kernels (BMI2 & ADX), from this many limbs on, the schoolbook rows go
   one at a time through addmul_1 (faster there than two at a time with the C addmul_2) */
#ifndef PBN_MUL_ASM_ROWS
#  define PBN_MUL_ASM_ROWS 12
#endif

PBN_INLINE int pbn_asm_rows(pbn_size n) {
#if defined(PBN_ASM_X86)
    return n >= PBN_MUL_ASM_ROWS && pbn_cpu_adx();
#else                                   /* (on arm64, the C addmul_2 is faster) */
    (void)n;
    return 0;
#endif
}

static void pbn_n_mul_basecase(pbn_limb *rp, const pbn_limb *ap, pbn_size an, const pbn_limb *bp, pbn_size bn) {
    pbn_size i = 1;
    rp[an] = pbn_n_mul_1(rp, ap, an, bp[0]);
#if defined(PBN_HAVE_ADDMUL_2)
    if (!pbn_asm_rows(an))
        for (; i + 2 <= bn; i += 2)
            rp[an + i + 1] = pbn_n_addmul_2(rp + i, ap, an, bp[i], bp[i + 1]);
#endif
    for (; i < bn; i++)
        rp[an + i] = pbn_n_addmul_1(rp + i, ap, an, bp[i]);
}

static void pbn_n_sqr_basecase(pbn_limb *rp, const pbn_limb *ap, pbn_size n) {
    pbn_size i;
    pbn_limb cy, hi, lo;
    if (n == 1) { rp[0] = pbn_umul(ap[0], ap[0], &rp[1]); return; }
    /* off-diagonal products */
    rp[0] = 0;
    rp[n] = pbn_n_mul_1(rp + 1, ap + 1, n - 1, ap[0]);
    i = 1;
#if defined(PBN_HAVE_ADDMUL_2)
    /* rows i and i+1 together: both multiply a[i+2..n), at positions 2i+2 and 2i+3;
       the remaining cross term a[i]*a[i+1] (position 2i+1) is added first */
    for (; i + 3 <= n; i += 2) {
        pbn_limb hi, lo, c, ce;
        lo = pbn_umul(ap[i], ap[i + 1], &hi);
        rp[2 * i + 1] = pbn_addc(rp[2 * i + 1], lo, 0, &c);
        ce = pbn_n_add_1(rp + 2 * i + 2, rp + 2 * i + 2, n - i - 2, hi + c);
        rp[n + i + 1] = pbn_n_addmul_2(rp + 2 * i + 2, ap + i + 2, n - i - 2, ap[i], ap[i + 1]);
        if (ce && ++rp[n + i] == 0) rp[n + i + 1]++;
    }
#endif
    for (; i < n - 1; i++)
        rp[n + i] = pbn_n_addmul_1(rp + 2 * i + 1, ap + i + 1, n - i - 1, ap[i]);
    rp[2 * n - 1] = pbn_n_lshift(rp + 1, rp + 1, 2 * n - 2, 1);
    /* add diagonal */
    cy = 0;
    for (i = 0; i < n; i++) {
        pbn_limb s;
        lo = pbn_umul(ap[i], ap[i], &hi);
        s = rp[2 * i] + lo;
        pbn_limb c = s < lo;
        s += cy;
        c += s < cy;
        rp[2 * i] = s;
        s = rp[2 * i + 1] + hi;
        cy = s < hi;
        s += c;
        cy += s < c;
        rp[2 * i + 1] = s;
    }
}

/* |a - b| into rp (an limbs), returns 1 if a < b. an >= bn */
static int pbn_absdiff(pbn_limb *rp, const pbn_limb *ap, pbn_size an, const pbn_limb *bp, pbn_size bn) {
    if (pbn_n_cmp2(ap, an, bp, bn) >= 0) {
        pbn_n_sub(rp, ap, an, bp, bn);
        return 0;
    }
    pbn_n_sub_n(rp, bp, ap, bn);
    pbn_n_zero(rp + bn, an - bn);
    return 1;
}

static void pbn_n_kara_mul(pbn_limb *rp, const pbn_limb *ap, const pbn_limb *bp, pbn_size n, pbn_limb *tp) {
    pbn_size h, l;
    pbn_limb cy, *w;
    int neg;
    if (n < PBN_MUL_KARA_THRESHOLD) { pbn_n_mul_basecase(rp, ap, n, bp, n); return; }
    h = n >> 1;
    l = n - h;
    neg = pbn_absdiff(tp, ap, l, ap + l, h) ^ pbn_absdiff(tp + l, bp, l, bp + l, h);
    pbn_n_kara_mul(rp, ap, bp, l, tp + 4 * l);                     /* z0 */
    pbn_n_kara_mul(rp + 2 * l, ap + l, bp + l, h, tp + 4 * l);     /* z2 */
    pbn_n_kara_mul(tp + 2 * l, tp, tp + l, l, tp + 4 * l);         /* |a0-a1||b0-b1| */
    w = tp;
    cy = pbn_n_add(w, rp, 2 * l, rp + 2 * l, 2 * h);
    if (neg) cy += pbn_n_add_n(w, w, tp + 2 * l, 2 * l);
    else     cy -= pbn_n_sub_n(w, w, tp + 2 * l, 2 * l);
    cy += pbn_n_add_n(rp + l, rp + l, w, 2 * l);
    if (cy && 2 * n > 3 * l) pbn_n_add_1(rp + 3 * l, rp + 3 * l, 2 * n - 3 * l, cy);
}

static void pbn_n_kara_sqr(pbn_limb *rp, const pbn_limb *ap, pbn_size n, pbn_limb *tp) {
    pbn_size h, l;
    pbn_limb cy, *w;
    if (n < PBN_SQR_KARA_THRESHOLD) { pbn_n_sqr_basecase(rp, ap, n); return; }
    h = n >> 1;
    l = n - h;
    pbn_absdiff(tp, ap, l, ap + l, h);
    pbn_n_kara_sqr(rp, ap, l, tp + 4 * l);
    pbn_n_kara_sqr(rp + 2 * l, ap + l, h, tp + 4 * l);
    pbn_n_kara_sqr(tp + 2 * l, tp, l, tp + 4 * l);
    w = tp;
    cy = pbn_n_add(w, rp, 2 * l, rp + 2 * l, 2 * h);
    cy -= pbn_n_sub_n(w, w, tp + 2 * l, 2 * l);
    cy += pbn_n_add_n(rp + l, rp + l, w, 2 * l);
    if (cy && 2 * n > 3 * l) pbn_n_add_1(rp + 3 * l, rp + 3 * l, 2 * n - 3 * l, cy);
}

/* ---- Toom-3 (evaluation at 0, 1, -1, 2, oo) ----
   a = a0 + a1 x + a2 x^2, b likewise (x = B^k); with r(t) = a(t) b(t) and the product
   c0 + c1 x + c2 x^2 + c3 x^3 + c4 x^4 (all c_i >= 0), interpolation keeps every
   intermediate non-negative:
       S = (r(1) + r(-1)) / 2         = c0 + c2 + c4    ->  c2 = S - c0 - c4
       D = (r(1) - r(-1)) / 2         = c1 + c3
       T = (r(2) - c0 - 4c2 - 16c4)/2 = c1 + 4c3        ->  c3 = (T - D) / 3,  c1 = D - c3  */

static void pbn_n_mul_n(pbn_limb *rp, const pbn_limb *ap, const pbn_limb *bp, pbn_size n, pbn_limb *tp);
static void pbn_n_sqr_n(pbn_limb *rp, const pbn_limb *ap, pbn_size n, pbn_limb *tp);

#define PBN_TOOM3_MIN 5     /* smallest size Toom-3 can split (k = ceil(n/3), n - 2k >= 1) */
#define PBN_TOOM4_MIN 13    /* smallest size Toom-4 can split (k = ceil(n/4), n - 3k >= 1) */

#define PBN_USE_TOOM4(n, thr)  ((n) >= (thr) && (n) >= PBN_TOOM4_MIN)
#define PBN_USE_TOOM3(n, thr)  ((n) >= (thr) && (n) >= PBN_TOOM3_MIN)

static pbn_size pbn_mul_itch(pbn_size n) {
    pbn_size k, a, b;
    if (n < PBN_MUL_KARA_THRESHOLD) return 0;
    if (PBN_USE_TOOM4(n, PBN_MUL_TOOM4_THRESHOLD)) {
        k = (n + 3) / 4;
        a = pbn_mul_itch(k);
        b = pbn_mul_itch(k + 1);
        return 10 * (k + 1) + 6 * (2 * k + 2) + PBN_MAX(a, b);
    }
    if (!PBN_USE_TOOM3(n, PBN_MUL_TOOM3_THRESHOLD)) return PBN_KARA_ITCH(n);
    k = (n + 2) / 3;
    a = pbn_mul_itch(k);
    b = pbn_mul_itch(k + 1);
    return 16 * (k + 1) + PBN_MAX(a, b);
}

static pbn_size pbn_sqr_itch(pbn_size n) {
    pbn_size k, a, b;
    if (n < PBN_SQR_KARA_THRESHOLD) return 0;
    if (PBN_USE_TOOM4(n, PBN_SQR_TOOM4_THRESHOLD)) {
        k = (n + 3) / 4;
        a = pbn_sqr_itch(k);
        b = pbn_sqr_itch(k + 1);
        return 5 * (k + 1) + 6 * (2 * k + 2) + PBN_MAX(a, b);
    }
    if (!PBN_USE_TOOM3(n, PBN_SQR_TOOM3_THRESHOLD)) return PBN_KARA_ITCH(n);
    k = (n + 2) / 3;
    a = pbn_sqr_itch(k);
    b = pbn_sqr_itch(k + 1);
    return 16 * (k + 1) + PBN_MAX(a, b);
}

/* rp = ap / 3 for an exact multiple of 3, by multiplying with the inverse of 3 mod B
   (Jebelean's exact division): one multiplication per limb, no division */
static void pbn_n_divexact_by3(pbn_limb *rp, const pbn_limb *ap, pbn_size n) {
    const pbn_limb inv3 = PBN_LIMB_MAX / 3 * 2 + 1;     /* 3 * inv3 == 1 (mod B) */
    pbn_limb c = 0, hi;
    pbn_size i;
    for (i = 0; i < n; i++) {
        pbn_limb a = ap[i], s = a - c, q;
        pbn_limb b = a < c;
        q = s * inv3;
        rp[i] = q;
        pbn_umul(q, 3, &hi);
        c = hi + b;
    }
}

/* rp = ap / d for an exact multiple of an odd d (same method, any odd d) */
static void pbn_n_divexact_odd(pbn_limb *rp, const pbn_limb *ap, pbn_size n, pbn_limb d) {
    pbn_limb inv = d, c = 0, hi;     /* inv = d^-1 mod B by Newton: 3 -> 6 -> ... bits */
    pbn_size i;
    int j;
    for (j = 0; j < 6; j++) inv *= 2 - d * inv;
    for (i = 0; i < n; i++) {
        pbn_limb a = ap[i], s = a - c, q;
        pbn_limb b = a < c;
        q = s * inv;
        rp[i] = q;
        pbn_umul(q, d, &hi);
        c = hi + b;
    }
}

/* rp[0..rn) += {cp, cn} * B^off (the sum must fit) */
static void pbn_add_at(pbn_limb *rp, pbn_size rn, pbn_size off, const pbn_limb *cp, pbn_size cn) {
    pbn_limb cy;
    PBN_NORM(cp, cn);
    if (cn == 0) return;
    cy = pbn_n_add_n(rp + off, rp + off, cp, cn);
    if (cy) pbn_n_add_1(rp + off + cn, rp + off + cn, rn - off - cn, cy);
}

/* v1 = a0 + a1 + a2, vm = |a0 - a1 + a2| (returns 1 if negative), v2 = a0 + 2 a1 + 4 a2;
   each k+1 limbs; a2 has r limbs */
static int pbn_toom3_eval(pbn_limb *v1, pbn_limb *vm, pbn_limb *v2, const pbn_limb *ap, pbn_size k, pbn_size r) {
    const pbn_limb *a0 = ap, *a1 = ap + k, *a2 = ap + 2 * k;
    int neg;
    /* vm = a0 + a2 */
    vm[k] = pbn_n_add(vm, a0, k, a2, r);
    /* v1 = vm + a1 */
    v1[k] = vm[k] + pbn_n_add_n(v1, vm, a1, k);
    /* vm = |vm - a1| */
    neg = pbn_absdiff(vm, vm, k + 1, a1, k);
    /* v2 = ((a2 * 2) + a1) * 2 + a0 */
    pbn_n_zero(v2, k + 1);
    pbn_n_copy(v2, a2, r);
    pbn_n_lshift(v2, v2, k + 1, 1);
    v2[k] += pbn_n_add_n(v2, v2, a1, k);
    pbn_n_lshift(v2, v2, k + 1, 1);
    v2[k] += pbn_n_add_n(v2, v2, a0, k);
    return neg;
}

/* r1 = r(1), rm = |r(-1)| (with sign neg), r2 = r(2), each w = 2k+2 limbs; c0 at rp[0..2k),
   c4 at rp[4k..4k+2r). Leaves the full product in rp[0..4k+2r). Destroys r1, rm, r2;
   t: w limbs of scratch */
static void pbn_toom3_interpolate(pbn_limb *rp, pbn_size k, pbn_size r, pbn_limb *r1, pbn_limb *rm, int neg,
                                  pbn_limb *r2, pbn_limb *t) {
    pbn_size w = 2 * k + 2, rn = 4 * k + 2 * r;
    pbn_limb bw;

    /* t = 2D, rm = 2S */
    if (!neg) {
        pbn_n_sub_n(t, r1, rm, w);
        pbn_n_add_n(rm, r1, rm, w);
    } else {
        pbn_n_add_n(t, r1, rm, w);
        pbn_n_sub_n(rm, r1, rm, w);
    }
    pbn_n_rshift(t, t, w, 1);          /* t  = D = c1 + c3 */
    pbn_n_rshift(rm, rm, w, 1);        /* rm = S = c0 + c2 + c4 */

    /* rm = c2 */
    pbn_n_sub(rm, rm, w, rp, 2 * k);
    pbn_n_sub(rm, rm, w, rp + 4 * k, 2 * r);

    /* r2 = (r(2) - c0 - 4 c2 - 16 c4) / 2 = c1 + 4 c3 */
    pbn_n_sub(r2, r2, w, rp, 2 * k);
    pbn_n_submul_1(r2, rm, w, 4);
    bw = pbn_n_submul_1(r2, rp + 4 * k, 2 * r, 16);
    if (2 * r < w) pbn_n_sub_1(r2 + 2 * r, r2 + 2 * r, w - 2 * r, bw);
    pbn_n_rshift(r2, r2, w, 1);

    /* r2 = c3 = (r2 - D) / 3 (exact), t = c1 = D - c3 */
    pbn_n_sub_n(r2, r2, t, w);
    pbn_n_divexact_by3(r2, r2, w);
    pbn_n_sub_n(t, t, r2, w);

    /* assemble: c0 | c4 already in place */
    pbn_n_zero(rp + 2 * k, 2 * k);
    pbn_add_at(rp, rn, k, t, w);
    pbn_add_at(rp, rn, 2 * k, rm, w);
    pbn_add_at(rp, rn, 3 * k, r2, w);
}

static void pbn_n_toom3_mul(pbn_limb *rp, const pbn_limb *ap, const pbn_limb *bp, pbn_size n, pbn_limb *tp) {
    pbn_size k = (n + 2) / 3, r = n - 2 * k, w = 2 * k + 2;
    pbn_limb *a1 = tp, *am = a1 + (k + 1), *a2 = am + (k + 1);
    pbn_limb *b1 = a2 + (k + 1), *bm = b1 + (k + 1), *b2 = bm + (k + 1);
    pbn_limb *r1 = b2 + (k + 1), *rm = r1 + w, *r2 = rm + w, *t = r2 + w, *ws = t + w;
    int neg;

    neg  = pbn_toom3_eval(a1, am, a2, ap, k, r);
    neg ^= pbn_toom3_eval(b1, bm, b2, bp, k, r);

    pbn_n_mul_n(r1, a1, b1, k + 1, ws);
    pbn_n_mul_n(rm, am, bm, k + 1, ws);
    pbn_n_mul_n(r2, a2, b2, k + 1, ws);
    pbn_n_mul_n(rp, ap, bp, k, ws);                              /* c0 */
    pbn_n_mul_n(rp + 4 * k, ap + 2 * k, bp + 2 * k, r, ws);      /* c4 */

    pbn_toom3_interpolate(rp, k, r, r1, rm, neg, r2, t);
}

static void pbn_n_toom3_sqr(pbn_limb *rp, const pbn_limb *ap, pbn_size n, pbn_limb *tp) {
    pbn_size k = (n + 2) / 3, r = n - 2 * k, w = 2 * k + 2;
    pbn_limb *a1 = tp, *am = a1 + (k + 1), *a2 = am + (k + 1);
    pbn_limb *r1 = a2 + (k + 1), *rm = r1 + w, *r2 = rm + w, *t = r2 + w, *ws = t + w;

    pbn_toom3_eval(a1, am, a2, ap, k, r);

    pbn_n_sqr_n(r1, a1, k + 1, ws);
    pbn_n_sqr_n(rm, am, k + 1, ws);
    pbn_n_sqr_n(r2, a2, k + 1, ws);
    pbn_n_sqr_n(rp, ap, k, ws);                                  /* c0 */
    pbn_n_sqr_n(rp + 4 * k, ap + 2 * k, r, ws);                  /* c4 */

    pbn_toom3_interpolate(rp, k, r, r1, rm, 0, r2, t);
}

/* ---- Toom-4 (evaluation at 0, 1, -1, 2, -2, 1/2, oo) ----
   a = a0 + a1 x + a2 x^2 + a3 x^3 (x = B^k, a3 of r limbs), b likewise; the product has
   coefficients c0..c6 (all >= 0). With v(t) = a(t) b(t) and vh = 64 v(1/2), interpolation
   keeps every intermediate non-negative:
       S1 = (v(1) + v(-1)) / 2 = c0 + c2 + c4 + c6,     D1 = (v(1) - v(-1)) / 2 = c1 + c3 + c5
       S2 = (v(2) + v(-2)) / 2 = c0 + 4c2 + 16c4 + 64c6, D2 = (v(2) - v(-2)) / 4 = c1 + 4c3 + 16c5
       c4 = ((S2 - c0 - 64c6) / 4 - (S1 - c0 - c6)) / 3,  c2 = S1 - c0 - c6 - c4
       H  = (vh - 64c0 - 16c2 - 4c4 - c6) / 2 = 16c1 + 4c3 + c5
       c5 = (4 D2 + H - 20 D1) / 45,  c3 = (D2 - D1) / 3 - 5c5,  c1 = D1 - c3 - c5  */

/* t = (s << sh) + a (k+1 limbs, s of sn <= k+1 limbs, a of an <= k limbs) */
static void pbn_toom4_lsh_add(pbn_limb *t, const pbn_limb *s, pbn_size sn, unsigned sh, const pbn_limb *a,
                              pbn_size an, pbn_size k) {
    pbn_n_zero(t, k + 1);
    pbn_n_copy(t, s, sn);
    if (sh) pbn_n_lshift(t, t, k + 1, sh);
    pbn_n_add(t, t, k + 1, a, an);
}

/* v1 = a(1), vm1 = |a(-1)|, v2 = a(2), vm2 = |a(-2)|, vh = 8 a(1/2); each k+1 limbs.
   Returns the signs of a(-1) (bit 0) and a(-2) (bit 1). t: 2(k+1) limbs */
static int pbn_toom4_eval(pbn_limb *v1, pbn_limb *vm1, pbn_limb *v2, pbn_limb *vm2, pbn_limb *vh,
                          const pbn_limb *ap, pbn_size k, pbn_size r, pbn_limb *t) {
    const pbn_limb *a0 = ap, *a1 = ap + k, *a2 = ap + 2 * k, *a3 = ap + 3 * k;
    pbn_limb *t0 = t, *t1 = t + (k + 1);
    int s = 0;
    /* +-1: t0 = a0 + a2, t1 = a1 + a3 */
    t0[k] = pbn_n_add_n(t0, a0, a2, k);
    t1[k] = pbn_n_add(t1, a1, k, a3, r);
    pbn_n_add_n(v1, t0, t1, k + 1);
    s |= pbn_absdiff(vm1, t0, k + 1, t1, k + 1);
    /* +-2: t0 = a0 + 4 a2, t1 = 2 a1 + 8 a3 */
    pbn_toom4_lsh_add(t0, a2, k, 2, a0, k, k);
    pbn_toom4_lsh_add(t1, a3, r, 2, a1, k, k);
    pbn_n_lshift(t1, t1, k + 1, 1);
    pbn_n_add_n(v2, t0, t1, k + 1);
    s |= pbn_absdiff(vm2, t0, k + 1, t1, k + 1) << 1;
    /* 1/2: vh = ((2 a0 + a1) 2 + a2) 2 + a3 */
    pbn_toom4_lsh_add(vh, a0, k, 1, a1, k, k);
    pbn_n_lshift(vh, vh, k + 1, 1);
    pbn_n_add(vh, vh, k + 1, a2, k);
    pbn_n_lshift(vh, vh, k + 1, 1);
    pbn_n_add(vh, vh, k + 1, a3, r);
    return s;
}

/* x -= {c, cn} * m over w limbs (the result must be >= 0) */
static void pbn_toom4_submul(pbn_limb *x, pbn_size w, const pbn_limb *c, pbn_size cn, pbn_limb m) {
    pbn_limb bw;
    PBN_NORM(c, cn);
    if (cn == 0) return;
    bw = m == 1 ? pbn_n_sub_n(x, x, c, cn) : pbn_n_submul_1(x, c, cn, m);
    if (cn < w) pbn_n_sub_1(x + cn, x + cn, w - cn, bw);
}

/* v1, vm1, v2, vm2, vh: the products at 1, -1 (sign bit 0 of neg), 2, -2 (bit 1), 1/2 (times
   64), each w = 2k+2 limbs; c0 at rp[0..2k), c6 at rp[6k..6k+2r). Leaves the product in
   rp[0..6k+2r); destroys the products. t: w limbs */
static void pbn_toom4_interpolate(pbn_limb *rp, pbn_size k, pbn_size r, pbn_limb *v1, pbn_limb *vm1,
                                  pbn_limb *v2, pbn_limb *vm2, pbn_limb *vh, int neg, pbn_limb *t) {
    pbn_size w = 2 * k + 2, rn = 6 * k + 2 * r;
    const pbn_limb *c0 = rp, *c6 = rp + 6 * k;

    /* v1 = D1, vm1 = S1 */
    if (!(neg & 1)) { pbn_n_sub_n(t, v1, vm1, w); pbn_n_add_n(vm1, v1, vm1, w); }
    else            { pbn_n_add_n(t, v1, vm1, w); pbn_n_sub_n(vm1, v1, vm1, w); }
    pbn_n_rshift(v1, t, w, 1);
    pbn_n_rshift(vm1, vm1, w, 1);
    /* v2 = D2, vm2 = S2 */
    if (!(neg & 2)) { pbn_n_sub_n(t, v2, vm2, w); pbn_n_add_n(vm2, v2, vm2, w); }
    else            { pbn_n_add_n(t, v2, vm2, w); pbn_n_sub_n(vm2, v2, vm2, w); }
    pbn_n_rshift(v2, t, w, 2);
    pbn_n_rshift(vm2, vm2, w, 1);

    /* even part: vm1 = E1 = S1 - c0 - c6, vm2 = E2 = (S2 - c0 - 64 c6) / 4 */
    pbn_toom4_submul(vm1, w, c0, 2 * k, 1);
    pbn_toom4_submul(vm1, w, c6, 2 * r, 1);
    pbn_toom4_submul(vm2, w, c0, 2 * k, 1);
    pbn_toom4_submul(vm2, w, c6, 2 * r, 64);
    pbn_n_rshift(vm2, vm2, w, 2);
    /* vm2 = c4 = (E2 - E1) / 3, vm1 = c2 = E1 - c4 */
    pbn_n_sub_n(vm2, vm2, vm1, w);
    pbn_n_divexact_by3(vm2, vm2, w);
    pbn_n_sub_n(vm1, vm1, vm2, w);

    /* vh = H = (vh - 64 c0 - 16 c2 - 4 c4 - c6) / 2 */
    pbn_toom4_submul(vh, w, c0, 2 * k, 64);
    pbn_toom4_submul(vh, w, vm1, w, 16);
    pbn_toom4_submul(vh, w, vm2, w, 4);
    pbn_toom4_submul(vh, w, c6, 2 * r, 1);
    pbn_n_rshift(vh, vh, w, 1);

    /* odd part: t = c5 = (4 D2 + H - 20 D1) / 45 */
    pbn_n_lshift(t, v2, w, 2);
    pbn_n_add_n(t, t, vh, w);
    pbn_toom4_submul(t, w, v1, w, 20);
    pbn_n_divexact_odd(t, t, w, 45);
    /* v2 = c3 = (D2 - D1) / 3 - 5 c5, v1 = c1 = D1 - c3 - c5 */
    pbn_n_sub_n(v2, v2, v1, w);
    pbn_n_divexact_by3(v2, v2, w);
    pbn_toom4_submul(v2, w, t, w, 5);
    pbn_n_sub_n(v1, v1, v2, w);
    pbn_n_sub_n(v1, v1, t, w);

    /* assemble: c0 | c6 already in place */
    pbn_n_zero(rp + 2 * k, 4 * k);
    pbn_add_at(rp, rn, k, v1, w);
    pbn_add_at(rp, rn, 2 * k, vm1, w);
    pbn_add_at(rp, rn, 3 * k, v2, w);
    pbn_add_at(rp, rn, 4 * k, vm2, w);
    pbn_add_at(rp, rn, 5 * k, t, w);
}

static void pbn_n_toom4_mul(pbn_limb *rp, const pbn_limb *ap, const pbn_limb *bp, pbn_size n, pbn_limb *tp) {
    pbn_size k = (n + 3) / 4, r = n - 3 * k, w = 2 * k + 2, e = k + 1;
    pbn_limb *a1 = tp, *am1 = a1 + e, *a2 = am1 + e, *am2 = a2 + e, *ah = am2 + e;
    pbn_limb *b1 = ah + e, *bm1 = b1 + e, *b2 = bm1 + e, *bm2 = b2 + e, *bh = bm2 + e;
    pbn_limb *v1 = bh + e, *vm1 = v1 + w, *v2 = vm1 + w, *vm2 = v2 + w, *vh = vm2 + w, *t = vh + w;
    pbn_limb *ws = t + w;
    int neg;

    /* evaluations use the product area as scratch (2(k+1) <= w limbs) */
    neg  = pbn_toom4_eval(a1, am1, a2, am2, ah, ap, k, r, v1);
    neg ^= pbn_toom4_eval(b1, bm1, b2, bm2, bh, bp, k, r, v1);

    pbn_n_mul_n(v1, a1, b1, e, ws);
    pbn_n_mul_n(vm1, am1, bm1, e, ws);
    pbn_n_mul_n(v2, a2, b2, e, ws);
    pbn_n_mul_n(vm2, am2, bm2, e, ws);
    pbn_n_mul_n(vh, ah, bh, e, ws);
    pbn_n_mul_n(rp, ap, bp, k, ws);                              /* c0 */
    pbn_n_mul_n(rp + 6 * k, ap + 3 * k, bp + 3 * k, r, ws);      /* c6 */

    pbn_toom4_interpolate(rp, k, r, v1, vm1, v2, vm2, vh, neg, t);
}

static void pbn_n_toom4_sqr(pbn_limb *rp, const pbn_limb *ap, pbn_size n, pbn_limb *tp) {
    pbn_size k = (n + 3) / 4, r = n - 3 * k, w = 2 * k + 2, e = k + 1;
    pbn_limb *a1 = tp, *am1 = a1 + e, *a2 = am1 + e, *am2 = a2 + e, *ah = am2 + e;
    pbn_limb *v1 = ah + e, *vm1 = v1 + w, *v2 = vm1 + w, *vm2 = v2 + w, *vh = vm2 + w, *t = vh + w;
    pbn_limb *ws = t + w;

    pbn_toom4_eval(a1, am1, a2, am2, ah, ap, k, r, v1);

    pbn_n_sqr_n(v1, a1, e, ws);
    pbn_n_sqr_n(vm1, am1, e, ws);
    pbn_n_sqr_n(v2, a2, e, ws);
    pbn_n_sqr_n(vm2, am2, e, ws);
    pbn_n_sqr_n(vh, ah, e, ws);
    pbn_n_sqr_n(rp, ap, k, ws);                                  /* c0 */
    pbn_n_sqr_n(rp + 6 * k, ap + 3 * k, r, ws);                  /* c6 */

    pbn_toom4_interpolate(rp, k, r, v1, vm1, v2, vm2, vh, 0, t);
}

/* rp[0..2n) = a * b (n limbs each); tp: pbn_mul_itch(n) limbs */
static void pbn_n_mul_n(pbn_limb *rp, const pbn_limb *ap, const pbn_limb *bp, pbn_size n, pbn_limb *tp) {
    if (n < PBN_MUL_KARA_THRESHOLD)
        pbn_n_mul_basecase(rp, ap, n, bp, n);
    else if (PBN_USE_TOOM4(n, PBN_MUL_TOOM4_THRESHOLD))
        pbn_n_toom4_mul(rp, ap, bp, n, tp);
    else if (PBN_USE_TOOM3(n, PBN_MUL_TOOM3_THRESHOLD))
        pbn_n_toom3_mul(rp, ap, bp, n, tp);
    else
        pbn_n_kara_mul(rp, ap, bp, n, tp);
}

/* rp[0..2n) = a^2; tp: pbn_sqr_itch(n) limbs */
static void pbn_n_sqr_n(pbn_limb *rp, const pbn_limb *ap, pbn_size n, pbn_limb *tp) {
    if (n < PBN_SQR_KARA_THRESHOLD)
        pbn_n_sqr_basecase(rp, ap, n);
    else if (PBN_USE_TOOM4(n, PBN_SQR_TOOM4_THRESHOLD))
        pbn_n_toom4_sqr(rp, ap, n, tp);
    else if (PBN_USE_TOOM3(n, PBN_SQR_TOOM3_THRESHOLD))
        pbn_n_toom3_sqr(rp, ap, n, tp);
    else
        pbn_n_kara_sqr(rp, ap, n, tp);
}

/* ---- FFT multiplication (64-bit limbs): number-theoretic transforms modulo three primes
        p = c 2^k + 1 < 2^62, one limb per coefficient; every coefficient of the product is
        below n 2^128 < p1 p2 p3 (~2^185.9), so the Chinese remainder theorem recovers it.
        3 divides every c, so the lengths can be 2^k or 3 2^k (less padding) ---- */

#if PBN_B == 64 && !defined(PBN_NO_FFT)
#  define PBN_HAVE_FFT 1
#  ifndef PBN_MUL_FFT_THRESHOLD
#    define PBN_MUL_FFT_THRESHOLD 7000     /* limbs of the smaller operand */
#  endif
#  ifndef PBN_SQR_FFT_THRESHOLD
#    define PBN_SQR_FFT_THRESHOLD 7000
#  endif

static const pbn_limb pbn_ntt_p[3] = { 4546383823830515713u, 4522739925786820609u, 4512606826625236993u };
static const pbn_limb pbn_ntt_g[3] = { 10, 37, 7 };   /* primitive roots: 2019 2^51 + 1, 4017 2^50 + 1, 501 2^53 + 1 */

/* branch-free reductions (values < 2^62: x - p is negative exactly when its top bit is set);
   data-dependent branches here would be mispredicted half the time */
PBN_INLINE pbn_limb pbn_ntt_fix(pbn_limb x, pbn_limb p) { return x + (p & ((pbn_limb)0 - (x >> 63))); }
PBN_INLINE pbn_limb pbn_ntt_add(pbn_limb a, pbn_limb b, pbn_limb p) { return pbn_ntt_fix(a + b - p, p); }
PBN_INLINE pbn_limb pbn_ntt_sub(pbn_limb a, pbn_limb b, pbn_limb p) { return pbn_ntt_fix(a - b, p); }

/* Montgomery product a b / B mod p (a < B, b < p; ni = -1/p mod B) */
PBN_INLINE pbn_limb pbn_ntt_mont(pbn_limb a, pbn_limb b, pbn_limb p, pbn_limb ni) {
    pbn_limb hi, lo = pbn_umul(a, b, &hi), h2, r;
    pbn_umul(lo * ni, p, &h2);
    r = hi + h2 + (lo != 0);       /* (ab + mp) / B: the low halves add up to 0 or B */
    return pbn_ntt_fix(r - p, p);
}

typedef struct { pbn_limb p, ni, r1, r2; } pbn_ntt_mod;   /* r1 = B mod p, r2 = B^2 mod p */

static void pbn_ntt_mod_init(pbn_ntt_mod *m, pbn_limb p) {
    pbn_limb ni = p, r;     /* p^-1 mod B by Newton, then negated */
    int i;
    for (i = 0; i < 6; i++) ni *= 2 - p * ni;
    m->p = p;
    m->ni = (pbn_limb)0 - ni;
    r = ((pbn_limb)0 - p) % p;     /* B mod p */
    m->r1 = r;
    for (i = 0; i < 64; i++) r = pbn_ntt_add(r, r, p);
    m->r2 = r;
}

/* a b mod p (plain residues) */
PBN_INLINE pbn_limb pbn_ntt_mulmod(const pbn_ntt_mod *m, pbn_limb a, pbn_limb b) {
    return pbn_ntt_mont(pbn_ntt_mont(a, b, m->p, m->ni), m->r2, m->p, m->ni);
}

static pbn_limb pbn_ntt_powmod(const pbn_ntt_mod *m, pbn_limb b, pbn_limb e) {
    pbn_limb r = 1;
    while (e) {
        if (e & 1) r = pbn_ntt_mulmod(m, r, b);
        b = pbn_ntt_mulmod(m, b, b);
        e >>= 1;
    }
    return r;
}

/* Shoup's multiplication by a known w < p: with ws = floor(w B / p), x w mod p for any x,
   as a value in [0, 2p) - one high product, the rest wraps around */
PBN_INLINE pbn_limb pbn_ntt_shoup(pbn_limb x, pbn_limb w, pbn_limb ws, pbn_limb p) {
    pbn_limb q;
    pbn_umul(x, ws, &q);
    return x * w - q * p;
}

/* floor(w B / p), w < p */
static pbn_limb pbn_ntt_shoup_const(pbn_limb w, pbn_limb p) {
    int s = pbn_clz(p);
    pbn_limb r, d = p << s;
    return pbn_div_preinv(&r, w << s, 0, d, pbn_invert_limb(d));
}

/* tw[j] = w^j (plain) and ts[j] its Shoup constant, for j < n */
static void pbn_ntt_powers(pbn_limb *tw, pbn_limb *ts, pbn_size n, pbn_limb w, const pbn_ntt_mod *m) {
    /* powers of w in Montgomery form (wB mod p), one product each; from those, the plain
       value is a reduction, and floor(wB / p) = (wB - (wB mod p)) / p an exact division:
       -(wB mod p) / p mod B, with no division at all */
    pbn_size j;
    pbn_limb p = m->p, pinv = (pbn_limb)0 - m->ni, wm = pbn_ntt_mulmod(m, w, m->r1), x = m->r1;
    for (j = 0; j < n; j++) {
        tw[j] = pbn_ntt_mont(x, 1, p, m->ni);
        ts[j] = ((pbn_limb)0 - x) * pinv;
        x = pbn_ntt_mont(x, wm, p, m->ni);
    }
}

/* tw[h + j] = w_{2h}^j (plain) and ts[h + j] its Shoup constant, for every stage
   h = 1, 2, ..., L/2 and j < h; w the L-th root of unity given */
static void pbn_ntt_twiddles(pbn_limb *tw, pbn_limb *ts, pbn_size L, pbn_limb w, const pbn_ntt_mod *m) {
    pbn_size h = L / 2, j;
    pbn_ntt_powers(tw + h, ts + h, h, w, m);
    for (h >>= 1; h >= 1; h >>= 1)
        for (j = 0; j < h; j++) {
            tw[h + j] = tw[2 * h + 2 * j];
            ts[h + j] = ts[2 * h + 2 * j];
        }
}

/* the same tables for the inverse root, from the ones of w: for the 2h-th roots,
   w^-j = -w^(h-j), and floor((p - w) B / p) = B - 1 - floor(w B / p) (w B is never a
   multiple of p) */
static void pbn_ntt_twiddles_inverse(pbn_limb *iw, pbn_limb *is, const pbn_limb *tw, const pbn_limb *ts,
                                     pbn_size L, pbn_limb p) {
    pbn_size h, j;
    for (h = 1; h < L; h <<= 1) {
        iw[h] = tw[h];
        is[h] = ts[h];
        for (j = 1; j < h; j++) {
            iw[h + j] = p - tw[2 * h - j];
            is[h + j] = ~ts[2 * h - j];
        }
    }
}

/* Above this length, the transforms go depth-first: the first (last) stage over the whole
   array, then each half on its own - so that the rest of the work stays in cache */
#ifndef PBN_NTT_BLOCK
#  define PBN_NTT_BLOCK 4096
#endif

/* The stages keep their values in [0, 2p) and never reduce them further (Harvey's
   lazy butterflies): with p < 2^62, sums & differences up to 4p still fit in a limb */

/* one decimation-in-frequency stage: butterflies h apart, over L */
PBN_INLINE void pbn_ntt_fwd_stage(pbn_limb *a, pbn_size L, pbn_size h, const pbn_limb *tw, const pbn_limb *ts, pbn_limb p) {
    pbn_limb p2 = 2 * p;
    pbn_size s, j;
    for (s = 0; s < L; s += 2 * h) {
        pbn_limb *x = a + s, *y = a + s + h;
        const pbn_limb *t = tw + h, *q = ts + h;
        for (j = 0; j < h; j++) {
            pbn_limb u = x[j], v = y[j];
            x[j] = pbn_ntt_fix(u + v - p2, p2);
            y[j] = pbn_ntt_shoup(u - v + p2, t[j], q[j], p);
        }
    }
}

/* one decimation-in-time stage */
PBN_INLINE void pbn_ntt_inv_stage(pbn_limb *a, pbn_size L, pbn_size h, const pbn_limb *tw, const pbn_limb *ts, pbn_limb p) {
    pbn_limb p2 = 2 * p;
    pbn_size s, j;
    for (s = 0; s < L; s += 2 * h) {
        pbn_limb *x = a + s, *y = a + s + h;
        const pbn_limb *t = tw + h, *q = ts + h;
        for (j = 0; j < h; j++) {
            pbn_limb u = x[j], v = pbn_ntt_shoup(y[j], t[j], q[j], p);
            x[j] = pbn_ntt_fix(u + v - p2, p2);
            y[j] = pbn_ntt_fix(u - v, p2);
        }
    }
}

/* forward transform (decimation in frequency: natural order in, bit-reversed out);
   tw[h + j] only depends on the stage, so the halves use the same table */
static void pbn_ntt_fwd(pbn_limb *a, pbn_size L, const pbn_limb *tw, const pbn_limb *ts, pbn_limb p) {
    pbn_size h;
    if (L > PBN_NTT_BLOCK) {
        pbn_ntt_fwd_stage(a, L, L / 2, tw, ts, p);
        pbn_ntt_fwd(a, L / 2, tw, ts, p);
        pbn_ntt_fwd(a + L / 2, L / 2, tw, ts, p);
        return;
    }
    for (h = L / 2; h >= 1; h >>= 1) pbn_ntt_fwd_stage(a, L, h, tw, ts, p);
}

/* inverse transform without the 1/L (decimation in time: bit-reversed in, natural out),
   tw built from the inverse root */
static void pbn_ntt_inv(pbn_limb *a, pbn_size L, const pbn_limb *tw, const pbn_limb *ts, pbn_limb p) {
    pbn_size h;
    if (L > PBN_NTT_BLOCK) {
        pbn_ntt_inv(a, L / 2, tw, ts, p);
        pbn_ntt_inv(a + L / 2, L / 2, tw, ts, p);
        pbn_ntt_inv_stage(a, L, L / 2, tw, ts, p);
        return;
    }
    for (h = 1; h < L; h <<= 1) pbn_ntt_inv_stage(a, L, h, tw, ts, p);
}

/* Length 3M: a radix-3 stage on top of three transforms of length M. With z a cube root
   of unity (1 + z + z^2 = 0), u = z (x1 - x2) gives the three sums for one product:
       x0 + x1 + x2,   x0 + z x1 + z^2 x2 = x0 - x2 + u,   x0 + z^2 x1 + z x2 = x0 - x1 - u
   the last two then times w^i, w^2i (w the 3M-th root); values in [0, 2p) in & out */
static void pbn_ntt_fwd3(pbn_limb *a, pbn_size M, const pbn_limb *t1, const pbn_limb *s1, const pbn_limb *t2,
                         const pbn_limb *s2, pbn_limb z, pbn_limb zs, pbn_limb p) {
    pbn_limb p2 = 2 * p, *b = a + M, *c = a + 2 * M;
    pbn_size i;
    for (i = 0; i < M; i++) {
        pbn_limb x0 = a[i], x1 = b[i], x2 = c[i];
        pbn_limb u = pbn_ntt_shoup(x1 - x2 + p2, z, zs, p);
        pbn_limb y1 = pbn_ntt_fix(x0 - x2, p2), y2 = pbn_ntt_fix(x0 - x1, p2);
        a[i] = pbn_ntt_fix(pbn_ntt_fix(x0 + x1 - p2, p2) + x2 - p2, p2);
        b[i] = pbn_ntt_shoup(y1 + u, t1[i], s1[i], p);
        c[i] = pbn_ntt_shoup(y2 + p2 - u, t2[i], s2[i], p);
    }
}

/* its inverse (up to the factor 3): w^-i, w^-2i first, then the same sums with z^-1 */
static void pbn_ntt_inv3(pbn_limb *a, pbn_size M, const pbn_limb *t1, const pbn_limb *s1, const pbn_limb *t2,
                         const pbn_limb *s2, pbn_limb z, pbn_limb zs, pbn_limb p) {
    pbn_limb p2 = 2 * p, *b = a + M, *c = a + 2 * M;
    pbn_size i;
    for (i = 0; i < M; i++) {
        pbn_limb x0 = a[i], x1 = pbn_ntt_shoup(b[i], t1[i], s1[i], p), x2 = pbn_ntt_shoup(c[i], t2[i], s2[i], p);
        pbn_limb u = pbn_ntt_shoup(x1 - x2 + p2, z, zs, p);
        pbn_limb y1 = pbn_ntt_fix(x0 - x2, p2), y2 = pbn_ntt_fix(x0 - x1, p2);
        a[i] = pbn_ntt_fix(pbn_ntt_fix(x0 + x1 - p2, p2) + x2 - p2, p2);
        b[i] = pbn_ntt_fix(y1 + u - p2, p2);
        c[i] = pbn_ntt_fix(y2 - u, p2);
    }
}

/* rp[0..an+bn) = a * b (sq: b is a); an, bn >= 1 */
static void pbn_n_mul_fft(pbn_limb *rp, const pbn_limb *ap, pbn_size an, const pbn_limb *bp, pbn_size bn, int sq) {
    pbn_size cn = an + bn - 1, L = 1, M, k, i;
    pbn_limb *buf, *fa, *fb, *tw, *ts, *iw, *is, *r3 = NULL, *res[3], c0 = 0, c1 = 0, c2 = 0;
    pbn_ntt_mod md[3];
    size_t total;
    int three;

    while (L < cn) L <<= 1;
    if (L < 2) L = 2;
    /* 3 2^k when that's enough: a quarter less (radix-3 tables: 8M = 2L/3 limbs) */
    three = L >= 8 && 3 * (L / 4) >= cn;
    if (three) L = 3 * (L / 4);
    M = three ? L / 3 : L;
    total = (size_t)2 * L + (size_t)4 * M + (three ? (size_t)8 * M : 0) + (size_t)3 * cn;
    buf = (pbn_limb *)pbn_alloc_fn(total * sizeof(pbn_limb));
    fa = buf;
    fb = fa + L;
    tw = fb + L;
    ts = tw + M;
    iw = ts + M;
    is = iw + M;
    res[0] = is + M;
    if (three) { r3 = res[0]; res[0] = r3 + 8 * M; }
    res[1] = res[0] + cn;
    res[2] = res[1] + cn;

    for (k = 0; k < 3; k++) {
        const pbn_ntt_mod *m = &md[k];
        pbn_limb p, w, one, scale, scales, x;
        pbn_ntt_mod_init(&md[k], pbn_ntt_p[k]);
        pbn_limb z = 0, zs = 0, zi = 0, zis = 0;
        p = m->p;
        w = pbn_ntt_powmod(m, pbn_ntt_g[k], (p - 1) / (pbn_limb)L);
        if (three) {
            /* w^i, w^2i, w^-i, w^-2i (i < M), and the cube roots z = w^M, 1/z = z^2 */
            pbn_limb wi = pbn_ntt_powmod(m, w, L - 1);
            pbn_ntt_powers(r3, r3 + M, M, w, m);
            pbn_ntt_powers(r3 + 2 * M, r3 + 3 * M, M, pbn_ntt_mulmod(m, w, w), m);
            pbn_ntt_powers(r3 + 4 * M, r3 + 5 * M, M, wi, m);
            pbn_ntt_powers(r3 + 6 * M, r3 + 7 * M, M, pbn_ntt_mulmod(m, wi, wi), m);
            z = pbn_ntt_powmod(m, w, M);
            zs = pbn_ntt_shoup_const(z, p);
            zi = pbn_ntt_mulmod(m, z, z);
            zis = pbn_ntt_shoup_const(zi, p);
            w = pbn_ntt_mulmod(m, pbn_ntt_mulmod(m, w, w), w);   /* the M-th root */
        }
        pbn_ntt_twiddles(tw, ts, M, w, m);

        /* the inputs, reduced into [0, 2p) (a Shoup product by 1) */
        one = pbn_ntt_shoup_const(1, p);
        for (i = 0; i < an; i++) fa[i] = pbn_ntt_shoup(ap[i], 1, one, p);
        for (; i < L; i++) fa[i] = 0;
        if (three) {
            pbn_ntt_fwd3(fa, M, r3, r3 + M, r3 + 2 * M, r3 + 3 * M, z, zs, p);
            for (i = 0; i < 3; i++) pbn_ntt_fwd(fa + i * M, M, tw, ts, p);
        } else {
            pbn_ntt_fwd(fa, L, tw, ts, p);
        }
        /* pointwise: Montgomery products (inputs < 2p < B / 2: results < p), each with an
           extra 1/B, taken back below */
        if (sq) {
            for (i = 0; i < L; i++) fa[i] = pbn_ntt_mont(fa[i], fa[i], p, m->ni);
        } else {
            for (i = 0; i < bn; i++) fb[i] = pbn_ntt_shoup(bp[i], 1, one, p);
            for (; i < L; i++) fb[i] = 0;
            if (three) {
                pbn_ntt_fwd3(fb, M, r3, r3 + M, r3 + 2 * M, r3 + 3 * M, z, zs, p);
                for (i = 0; i < 3; i++) pbn_ntt_fwd(fb + i * M, M, tw, ts, p);
            } else {
                pbn_ntt_fwd(fb, L, tw, ts, p);
            }
            for (i = 0; i < L; i++) fa[i] = pbn_ntt_mont(fa[i], fb[i], p, m->ni);
        }
        /* inverse: twiddles of the inverse root; then B / L (both factors at once) */
        pbn_ntt_twiddles_inverse(iw, is, tw, ts, M, p);
        if (three) {
            for (i = 0; i < 3; i++) pbn_ntt_inv(fa + i * M, M, iw, is, p);
            pbn_ntt_inv3(fa, M, r3 + 4 * M, r3 + 5 * M, r3 + 6 * M, r3 + 7 * M, zi, zis, p);
        } else {
            pbn_ntt_inv(fa, L, iw, is, p);
        }
        scale = pbn_ntt_mulmod(m, m->r1, pbn_ntt_powmod(m, (pbn_limb)L % p, p - 2));
        scales = pbn_ntt_shoup_const(scale, p);
        for (i = 0; i < cn; i++) {
            x = pbn_ntt_shoup(fa[i], scale, scales, p);
            res[k][i] = x >= p ? x - p : x;
        }
    }

    /* Garner: x = v1 + p1 v2 + p1 p2 v3, then carried into rp */
    {
        pbn_limb p1 = md[0].p, p2 = md[1].p, p3 = md[2].p, h12, l12;
        /* Montgomery-form constants: 1/p1 mod p2, p1 mod p3, 1/(p1 p2) mod p3 */
        pbn_limb i12 = pbn_ntt_mulmod(&md[1], pbn_ntt_powmod(&md[1], p1 % p2, p2 - 2), md[1].r1);
        pbn_limb p13 = pbn_ntt_mulmod(&md[2], p1 % p3, md[2].r1);
        pbn_limb i123 = pbn_ntt_mulmod(&md[2], pbn_ntt_powmod(&md[2], pbn_ntt_mulmod(&md[2], p1 % p3, p2 % p3), p3 - 2), md[2].r1);
        l12 = pbn_umul(p1, p2, &h12);
        for (i = 0; i < cn; i++) {
            pbn_limb v1 = res[0][i], v2, v3, t, x0, x1, x2, hi, lo, cy;
            /* v2 = (r2 - v1) / p1 mod p2 */
            t = v1 >= p2 ? v1 - p2 : v1;
            v2 = pbn_ntt_mont(pbn_ntt_sub(res[1][i], t, p2), i12, p2, md[1].ni);
            /* v3 = (r3 - v1 - p1 v2) / (p1 p2) mod p3 */
            t = v1;
            while (t >= p3) t -= p3;
            t = pbn_ntt_add(t, pbn_ntt_mont(v2, p13, p3, md[2].ni), p3);
            v3 = pbn_ntt_mont(pbn_ntt_sub(res[2][i], t, p3), i123, p3, md[2].ni);
            /* x = v1 + p1 v2 + (p1 p2) v3 */
            x0 = pbn_umul(p1, v2, &x1);
            x0 += v1; x1 += x0 < v1;
            lo = pbn_umul(l12, v3, &hi);
            x0 += lo; cy = x0 < lo;
            x1 += hi; x2 = x1 < hi;
            x1 += cy; x2 += x1 < cy;
            lo = pbn_umul(h12, v3, &hi);
            x1 += lo; x2 += (x1 < lo) + hi;
            /* add the carry (c0, c1, c2) and emit the low limb */
            x0 += c0; cy = x0 < c0;
            x1 += cy; cy = x1 < cy;
            x1 += c1; cy += x1 < c1;
            x2 += c2 + cy;
            rp[i] = x0;
            c0 = x1; c1 = x2; c2 = 0;
        }
        rp[cn] = c0;
    }
    pbn_free_fn(buf, total * sizeof(pbn_limb));
}
#endif

static void pbn_n_sqr(pbn_limb *rp, const pbn_limb *ap, pbn_size n) {
#if defined(PBN_HAVE_FFT)
    if (n >= PBN_SQR_FFT_THRESHOLD) { pbn_n_mul_fft(rp, ap, n, ap, n, 1); return; }
#endif
    if (n < PBN_SQR_KARA_THRESHOLD) {
        pbn_n_sqr_basecase(rp, ap, n);
    } else {
        pbn_size itch = pbn_sqr_itch(n);
        pbn_limb *tp = PBN_TMP_ALLOC(itch);
        pbn_n_sqr_n(rp, ap, n, tp);
        PBN_TMP_FREE(tp, itch);
    }
}

/* rp[0..an+bn) = a * b; an >= bn >= 1; rp must not overlap inputs */
static void pbn_n_mul(pbn_limb *rp, const pbn_limb *ap, pbn_size an, const pbn_limb *bp, pbn_size bn) {
    pbn_size itch, off, mi;
    pbn_limb *tp, *pp;

    if (bn < PBN_MUL_KARA_THRESHOLD) { pbn_n_mul_basecase(rp, ap, an, bp, bn); return; }
    if (ap == bp && an == bn) { pbn_n_sqr(rp, ap, an); return; }
#if defined(PBN_HAVE_FFT)
    if (bn >= PBN_MUL_FFT_THRESHOLD) { pbn_n_mul_fft(rp, ap, an, bp, bn, 0); return; }
#endif

    mi = pbn_mul_itch(bn);
    itch = mi + 2 * bn;
    tp = PBN_TMP_ALLOC(itch);
    pp = tp + mi;

    pbn_n_mul_n(rp, ap, bp, bn, tp);
    off = bn;
    while (an - off >= bn) {
        pbn_limb cy;
        pbn_n_mul_n(pp, ap + off, bp, bn, tp);
        cy = pbn_n_add_n(rp + off, rp + off, pp, bn);
        pbn_n_add_1(rp + off + bn, pp + bn, bn, cy);
        off += bn;
    }
    if (off < an) {
        pbn_size rem = an - off;
        pbn_limb cy;
        pbn_n_mul(pp, bp, bn, ap + off, rem);
        cy = pbn_n_add_n(rp + off, rp + off, pp, bn);
        pbn_n_add_1(rp + off + bn, pp + bn, rem, cy);
    }
    PBN_TMP_FREE(tp, itch);
}

/* ---- division: divide & conquer above a threshold (Burnikel & Ziegler; Brent &
        Zimmermann, Modern Computer Arithmetic, Algorithm 1.8), on top of Karatsuba/Toom ---- */

#ifndef PBN_DC_DIV_THRESHOLD
#  define PBN_DC_DIV_THRESHOLD 70      /* quotient & divisor limbs */
#endif

/* {ap, n+m} / {bp, n} for a normalized divisor (top bit set) and m <= n: the quotient is
   qh * B^m + {qp, m} (qh, 0 or 1, is returned), the remainder is left in ap[0..n) */
static pbn_limb pbn_dc_divrem(pbn_limb *qp, pbn_limb *ap, const pbn_limb *bp, pbn_size n, pbn_size m) {
    pbn_size k, tn;
    pbn_limb qh, qh0, *tp;
    int hi;

    if (m < PBN_DC_DIV_THRESHOLD || m < 2) {
        pbn_limb *t = PBN_TMP_ALLOC(m + 1 + n);
        pbn_n_tdiv_qr_basecase(t, t + m + 1, ap, n + m, bp, n);
        pbn_n_copy(qp, t, m);
        qh = t[m];
        pbn_n_copy(ap, t + m + 1, n);
        PBN_TMP_FREE(t, m + 1 + n);
        return qh;
    }

    k = m / 2;
    tp = PBN_TMP_ALLOC(m + 1);

    /* (Q1, R1) = (A div B^2k) / B1, with B1 = B div B^k: Q1 -> qp[k..m) (+ qh), R1 -> ap[2k..n+k) */
    qh = pbn_dc_divrem(qp + k, ap + 2 * k, bp + k, n - k, m - k);

    /* A' = R1 B^2k + A mod B^2k - Q1 B0 B^k (in ap[0..n+k)), B0 = B mod B^k */
    pbn_n_mul(tp, qp + k, m - k, bp, k);
    tp[m] = qh ? pbn_n_add_n(tp + m - k, tp + m - k, bp, k) : 0;
    tn = m + 1;
    hi = -(int)pbn_n_sub(ap + k, ap + k, n, tp, PBN_MIN(tn, n));
    if (tn > n) hi -= (int)tp[n];
    while (hi < 0) {                   /* at most twice: Q1 -= 1, A' += B^k B */
        qh -= pbn_n_sub_1(qp + k, qp + k, m - k, 1);
        hi += (int)pbn_n_add_n(ap + k, ap + k, bp, n);
    }

    /* (Q0, R0) = (A' div B^k) / B1: Q0 -> qp[0..k) (+ qh0, carried into Q1), R0 -> ap[k..n) */
    qh0 = pbn_dc_divrem(qp, ap + k, bp + k, n - k, k);
    qh += pbn_n_add_1(qp + k, qp + k, m - k, qh0);

    /* A'' = R0 B^k + A' mod B^k - Q0 B0 (in ap[0..n)) */
    pbn_n_mul(tp, qp, k, bp, k);
    tp[2 * k] = qh0 ? pbn_n_add_n(tp + k, tp + k, bp, k) : 0;
    tn = 2 * k + 1;
    hi = -(int)pbn_n_sub(ap, ap, n, tp, PBN_MIN(tn, n));
    if (tn > n) hi -= (int)tp[n];
    while (hi < 0) {                   /* at most twice: Q -= 1, A'' += B */
        qh -= pbn_n_sub_1(qp, qp, m, 1);
        hi += (int)pbn_n_add_n(ap, ap, bp, n);
    }

    PBN_TMP_FREE(tp, m + 1);
    return qh;
}

/* divide & conquer {np, nn} / {dp, dn}: qp gets nn-dn+1 limbs, rp dn limbs */
static void pbn_n_tdiv_qr_dc(pbn_limb *qp, pbn_limb *rp, const pbn_limb *np, pbn_size nn,
                             const pbn_limb *dp, pbn_size dn) {
    int s = pbn_clz(dp[dn - 1]);
    pbn_size m = nn + 1 - dn, pos, r;
    pbn_limb *u = PBN_TMP_ALLOC(nn + 1 + dn), *dd = u + nn + 1;

    if (s) {
        pbn_n_lshift(dd, dp, dn, (unsigned)s);
        u[nn] = pbn_n_lshift(u, np, nn, (unsigned)s);
    } else {
        pbn_n_copy(dd, dp, dn);
        pbn_n_copy(u, np, nn);
        u[nn] = 0;
    }

    /* the quotient (m limbs) in blocks of dn limbs from the top; each block's dividend has
       the previous remainder (< divisor) on top */
    r = m % dn;
    if (r == 0) r = dn;
    pos = m - r;
    pbn_dc_divrem(qp + pos, u + pos, dd, dn, r);
    while (pos > 0) {
        pos -= dn;
        pbn_dc_divrem(qp + pos, u + pos, dd, dn, dn);
    }

    if (s) pbn_n_rshift(rp, u, dn, (unsigned)s);
    else   pbn_n_copy(rp, u, dn);
    PBN_TMP_FREE(u, nn + 1 + dn);
}

static void pbn_n_tdiv_qr(pbn_limb *qp, pbn_limb *rp, const pbn_limb *np, pbn_size nn,
                          const pbn_limb *dp, pbn_size dn);

/* a quotient much shorter than the divisor (m = nn-dn+1 limbs, dn > 2m): it only depends
   on the top of both, so the top 2m limbs by the top m+1 of the divisor give it to within
   a couple of units; one product (m by dn limbs) and a few adds or subtractions then fix
   it, and give the remainder. (Dividing by the whole divisor would be quadratic) */
static void pbn_n_tdiv_qr_unbalanced(pbn_limb *qp, pbn_limb *rp, const pbn_limb *np, pbn_size nn,
                                     const pbn_limb *dp, pbn_size dn) {
    pbn_size m = nn - dn + 1, t = m + 1, qn = m;
    pbn_limb *tq = PBN_TMP_ALLOC(t + (nn + 1) + (nn + 1)), *pp = tq + t, *xp = pp + nn + 1;

    pbn_n_tdiv_qr(qp, tq, np + (dn - t), 2 * m, dp + (dn - t), t);

    /* pp = q dp (nn+1 limbs), xp = the dividend (nn+1 limbs) */
    PBN_NORM(qp, qn);
    if (qn) {
        pbn_n_mul(pp, dp, dn, qp, qn);
        pbn_n_zero(pp + dn + qn, nn + 1 - (dn + qn));
    } else {
        pbn_n_zero(pp, nn + 1);
    }
    pbn_n_zero(qp + qn, m - qn);
    pbn_n_copy(xp, np, nn);
    xp[nn] = 0;

    /* too big: q -= 1, pp -= d */
    while (pbn_n_cmp(pp, xp, nn + 1) > 0) {
        pbn_n_sub_1(qp, qp, m, 1);
        pbn_n_sub(pp, pp, nn + 1, dp, dn);
    }
    /* r = x - pp; too small: q += 1, r -= d */
    pbn_n_sub_n(xp, xp, pp, nn + 1);
    while (pbn_n_cmp2(xp, nn + 1, dp, dn) >= 0) {
        pbn_n_add_1(qp, qp, m, 1);
        pbn_n_sub(xp, xp, nn + 1, dp, dn);
    }
    pbn_n_copy(rp, xp, dn);
    PBN_TMP_FREE(tq, t + (nn + 1) + (nn + 1));
}

/* qp: nn-dn+1 limbs, rp: dn limbs; nothing may overlap */
static void pbn_n_tdiv_qr(pbn_limb *qp, pbn_limb *rp, const pbn_limb *np, pbn_size nn,
                          const pbn_limb *dp, pbn_size dn) {
    if (nn - dn + 1 >= PBN_DC_DIV_THRESHOLD && dn > 2 * (nn - dn + 1))
        pbn_n_tdiv_qr_unbalanced(qp, rp, np, nn, dp, dn);
    else if (dn >= PBN_DC_DIV_THRESHOLD && nn - dn + 1 >= PBN_DC_DIV_THRESHOLD)
        pbn_n_tdiv_qr_dc(qp, rp, np, nn, dp, dn);
    else
        pbn_n_tdiv_qr_basecase(qp, rp, np, nn, dp, dn);
}

/* ------------------------------------------------------------------------- */
/* pbz: signed integers                                                      */
/* ------------------------------------------------------------------------- */

static pbn_limb pbn_dummy_limb = 0;   /* target of _mp_d when nothing is allocated; never written */

/* _mp_alloc > 0: heap buffer owned by x
   _mp_alloc = 0: read-only shared limb (the value 0 or 1), never written
   _mp_alloc < 0: caller-provided stack buffer of -_mp_alloc limbs, never freed */
#define PBZ_CAP(x) (ALLOC(x) < 0 ? -ALLOC(x) : ALLOC(x))

static pbn_limb *pbz_grow_slow(pbz_ptr x, pbn_size n) {
    pbn_limb *p;
    if (n > INT_MAX) PBN_ABORT("number too large");
    if (ALLOC(x) <= 0) {
        /* not owned: allocate and keep the current value */
        pbn_size keep = PBN_MIN((pbn_size)PBN_ABS(SIZ(x)), n);
        p = (pbn_limb *)pbn_alloc_fn((size_t)n * sizeof(pbn_limb));
        if (keep) memcpy(p, PTR(x), (size_t)keep * sizeof(pbn_limb));
    } else {
        p = (pbn_limb *)pbn_realloc_fn(PTR(x), (size_t)ALLOC(x) * sizeof(pbn_limb), (size_t)n * sizeof(pbn_limb));
    }
    PTR(x) = p;
    ALLOC(x) = (int)n;
    return p;
}
#define PBZ_GROW(x, n) ((pbn_size)(n) > (pbn_size)PBZ_CAP(x) ? pbz_grow_slow((x), (n)) : PTR(x))

/* integer temporary living on the stack (spills to the heap if it grows; release with pbz_clear) */
#define PBZ_STACK(name, nl) \
    pbn_limb name##_buf[nl]; pbz_struct name##_st; pbz_ptr name = &name##_st; \
    name##_st._mp_alloc = -(int)(nl); name##_st._mp_size = 0; name##_st._mp_d = name##_buf

/* replace x's limb buffer with p (n limbs allocated) */
static void pbz_install(pbz_ptr x, pbn_limb *p, pbn_size alloc) {
    if (ALLOC(x) > 0) pbn_free_fn(PTR(x), (size_t)ALLOC(x) * sizeof(pbn_limb));
    PTR(x) = p;
    ALLOC(x) = (int)alloc;
}

/* read-only temporaries built from machine integers */
#define PBN_UL_LIMBS ((int)((sizeof(unsigned long) * CHAR_BIT + PBN_B - 1) / PBN_B))

static pbn_size pbn_from_ul(pbn_limb *buf, unsigned long u) {
    pbn_size n = 0;
    while (u) {
        buf[n++] = (pbn_limb)u;
#if ULONG_MAX > 0xFFFFFFFFUL && PBN_LIMB_BITS == 32
        u = (u >> 16) >> 16;   /* 64-bit long, 32-bit limbs: more limbs to go */
#else
        u = 0;                 /* unsigned long fits in one limb */
#endif
    }
    return n;
}

static pbn_size pbn_from_u64(pbn_limb *buf, uint64_t u) {
    pbn_size n = 0;
    while (u) {
        buf[n++] = (pbn_limb)u;
        if (64 > PBN_B) u = (u >> (PBN_B / 2)) >> (PBN_B / 2);
        else u = 0;
    }
    return n;
}

#define PBZ_TMP_UL(t, u) \
    pbn_limb t##_buf[PBN_UL_LIMBS]; pbz_struct t##_s; pbz_srcptr t = &t##_s; \
    t##_s._mp_alloc = 0; t##_s._mp_d = t##_buf; t##_s._mp_size = (int)pbn_from_ul(t##_buf, (u))

#define PBZ_TMP_SL(t, v) \
    pbn_limb t##_buf[PBN_UL_LIMBS]; pbz_struct t##_s; pbz_srcptr t = &t##_s; \
    t##_s._mp_alloc = 0; t##_s._mp_d = t##_buf; \
    t##_s._mp_size = (int)pbn_from_ul(t##_buf, (v) < 0 ? 0UL - (unsigned long)(v) : (unsigned long)(v)); \
    if ((v) < 0) t##_s._mp_size = -t##_s._mp_size

/* ---- init / assign ---- */

PBN_DEF void pbz_init(pbz_ptr x) {
    ALLOC(x) = 0;
    SIZ(x) = 0;
    PTR(x) = &pbn_dummy_limb;
}

PBN_DEF void pbz_init2(pbz_ptr x, pbn_bitcnt bits) {
    pbn_size n = (pbn_size)((bits + PBN_B - 1) / PBN_B);
    pbz_init(x);
    if (n < 1) n = 1;
    pbz_grow_slow(x, n);
}

PBN_DEF void pbz_inits(pbz_ptr x, ...) {
    va_list ap;
    va_start(ap, x);
    while (x) { pbz_init(x); x = va_arg(ap, pbz_ptr); }
    va_end(ap);
}

PBN_DEF void pbz_clear(pbz_ptr x) {
    if (ALLOC(x) > 0) pbn_free_fn(PTR(x), (size_t)ALLOC(x) * sizeof(pbn_limb));
    ALLOC(x) = 0;
    SIZ(x) = 0;
    PTR(x) = &pbn_dummy_limb;
}

PBN_DEF void pbz_clears(pbz_ptr x, ...) {
    va_list ap;
    va_start(ap, x);
    while (x) { pbz_clear(x); x = va_arg(ap, pbz_ptr); }
    va_end(ap);
}

PBN_DEF void pbz_realloc2(pbz_ptr x, pbn_bitcnt bits) {
    pbn_size n = (pbn_size)((bits + PBN_B - 1) / PBN_B);
    pbn_limb *p;
    if (n < 1) n = 1;
    if (PBN_ABS(SIZ(x)) > n) SIZ(x) = 0;
    if (ALLOC(x) <= 0) {
        p = (pbn_limb *)pbn_alloc_fn((size_t)n * sizeof(pbn_limb));
        if (SIZ(x)) memcpy(p, PTR(x), (size_t)PBN_ABS(SIZ(x)) * sizeof(pbn_limb));
    } else {
        p = (pbn_limb *)pbn_realloc_fn(PTR(x), (size_t)ALLOC(x) * sizeof(pbn_limb), (size_t)n * sizeof(pbn_limb));
    }
    PTR(x) = p;
    ALLOC(x) = (int)n;
}

PBN_DEF void pbz_set(pbz_ptr r, pbz_srcptr a) {
    pbn_size n;
    pbn_limb *rp;
    if (r == a) return;
    n = PBN_ABS(SIZ(a));
    rp = PBZ_GROW(r, n);
    pbn_n_copy(rp, PTR(a), n);
    SIZ(r) = SIZ(a);
}

PBN_DEF void pbz_set_ui(pbz_ptr r, unsigned long u) {
    pbn_limb buf[PBN_UL_LIMBS];
    pbn_size n = pbn_from_ul(buf, u);
    pbn_limb *rp = PBZ_GROW(r, n);
    pbn_n_copy(rp, buf, n);
    SIZ(r) = (int)n;
}

PBN_DEF void pbz_set_si(pbz_ptr r, long s) {
    pbz_set_ui(r, s < 0 ? 0UL - (unsigned long)s : (unsigned long)s);
    if (s < 0) SIZ(r) = -SIZ(r);
}

static void pbz_set_u64(pbz_ptr r, uint64_t u) {
    pbn_limb buf[64 / PBN_B];
    pbn_size n = pbn_from_u64(buf, u);
    pbn_limb *rp = PBZ_GROW(r, n);
    pbn_n_copy(rp, buf, n);
    SIZ(r) = (int)n;
}

PBN_DEF void pbz_set_d(pbz_ptr r, double d) {
    int neg, e;
    double m;
    uint64_t mant;
    if (d != d || d - d != 0) PBN_ABORT("invalid operation (NaN or infinity)");
    neg = d < 0;
    if (neg) d = -d;
    if (d < 1.0) { SIZ(r) = 0; return; }
    m = frexp(d, &e);                 /* d = m * 2^e, 0.5 <= m < 1 */
    mant = (uint64_t)ldexp(m, 53);    /* exact */
    if (e <= 53) {
        pbz_set_u64(r, mant >> (53 - e));
    } else {
        pbz_set_u64(r, mant);
        pbz_mul_2exp(r, r, (pbn_bitcnt)(e - 53));
    }
    if (neg) SIZ(r) = -SIZ(r);
}

PBN_DEF void pbz_swap(pbz_ptr a, pbz_ptr b) {
    pbz_struct t = *a;
    *a = *b;
    *b = t;
}

PBN_DEF void pbz_init_set(pbz_ptr r, pbz_srcptr a)        { pbz_init(r); pbz_set(r, a); }
PBN_DEF void pbz_init_set_ui(pbz_ptr r, unsigned long u)  { pbz_init(r); pbz_set_ui(r, u); }
PBN_DEF void pbz_init_set_si(pbz_ptr r, long s)           { pbz_init(r); pbz_set_si(r, s); }
PBN_DEF void pbz_init_set_d(pbz_ptr r, double d)          { pbz_init(r); pbz_set_d(r, d); }
PBN_DEF int  pbz_init_set_str(pbz_ptr r, const char *s, int base) { pbz_init(r); return pbz_set_str(r, s, base); }

/* ---- comparison ---- */

PBN_DEF int pbz_cmp(pbz_srcptr a, pbz_srcptr b) {
    pbn_size as = SIZ(a), bs = SIZ(b);
    int c;
    if (as != bs) return as < bs ? -1 : 1;
    c = pbn_n_cmp(PTR(a), PTR(b), PBN_ABS(as));
    return as >= 0 ? c : -c;
}

PBN_DEF int pbz_cmpabs(pbz_srcptr a, pbz_srcptr b) {
    pbn_size an = PBN_ABS(SIZ(a)), bn = PBN_ABS(SIZ(b));
    if (an != bn) return an < bn ? -1 : 1;
    return pbn_n_cmp(PTR(a), PTR(b), an);
}

PBN_DEF int pbz_cmp_ui(pbz_srcptr a, unsigned long u) { PBZ_TMP_UL(t, u); return pbz_cmp(a, t); }
PBN_DEF int pbz_cmp_si(pbz_srcptr a, long s)          { PBZ_TMP_SL(t, s); return pbz_cmp(a, t); }
PBN_DEF int pbz_cmpabs_ui(pbz_srcptr a, unsigned long u) { PBZ_TMP_UL(t, u); return pbz_cmpabs(a, t); }

/* compare |a| with |d| (d finite) */
static int pbz_cmpabs_d_impl(pbz_srcptr a, double d) {
    pbz_t t;
    int c;
    double fl;
    d = fabs(d);
    if (SIZ(a) == 0) return d > 0 ? -1 : 0;
    fl = floor(d);
    pbz_init(t);
    pbz_set_d(t, fl);
    c = pbz_cmpabs(a, t);
    pbz_clear(t);
    if (c == 0 && d > fl) c = -1;
    return c;
}

PBN_DEF int pbz_cmp_d(pbz_srcptr a, double d) {
    int as, ds, c;
    if (d != d) PBN_ABORT("invalid operation (NaN)");
    if (d - d != 0) return d > 0 ? -1 : 1;
    as = pbz_sgn(a);
    ds = d < 0 ? -1 : d > 0;
    if (as != ds) return as < ds ? -1 : 1;
    if (as == 0) return 0;
    c = pbz_cmpabs_d_impl(a, d);
    return as > 0 ? c : -c;
}

PBN_DEF int pbz_cmpabs_d(pbz_srcptr a, double d) {
    if (d != d) PBN_ABORT("invalid operation (NaN)");
    if (d - d != 0) return -1;
    return pbz_cmpabs_d_impl(a, d);
}

/* ---- conversion ---- */

PBN_DEF unsigned long pbz_get_ui(pbz_srcptr x) {
    pbn_size n = PBN_ABS(SIZ(x)), i;
    unsigned long r = 0;
    for (i = 0; i < n && i < PBN_UL_LIMBS; i++)
        r |= (unsigned long)PTR(x)[i] << (unsigned)(i * PBN_B);
    return r;
}

PBN_DEF long pbz_get_si(pbz_srcptr x) {
    unsigned long u = pbz_get_ui(x);
    if (SIZ(x) >= 0) return (long)(u & (unsigned long)LONG_MAX);
    return -1 - (long)((u - 1) & (unsigned long)LONG_MAX);
}

/* bit length of |x| (x != 0) */
static pbn_bitcnt pbz_bitlen(pbz_srcptr x) {
    pbn_size n = PBN_ABS(SIZ(x));
    return (pbn_bitcnt)n * PBN_B - (pbn_bitcnt)pbn_clz(PTR(x)[n - 1]);
}

PBN_DEF double pbz_get_d(pbz_srcptr x) {
    pbn_size n = PBN_ABS(SIZ(x)), i;
    pbn_bitcnt bits;
    uint64_t t = 0;
    int sh = 64;
    double r;
    if (n == 0) return 0.0;
    bits = pbz_bitlen(x);
    /* top 64 bits, msb-aligned, truncated */
    for (i = n - 1; i >= 0 && sh > 0; i--) {
        pbn_limb v = PTR(x)[i];
        int vb = (i == n - 1) ? (int)(PBN_B - pbn_clz(v)) : PBN_B;
        if (vb <= sh) { t |= (uint64_t)v << (sh - vb); sh -= vb; }
        else          { t |= (uint64_t)(v >> (vb - sh)); sh = 0; }
    }
    t &= ~(uint64_t)0 << 11;   /* truncate to 53 bits */
    if (bits > 100000) r = HUGE_VAL;
    else r = ldexp((double)t, (int)bits - 64);
    return SIZ(x) < 0 ? -r : r;
}

PBN_DEF int pbz_fits_ulong_p(pbz_srcptr x) { return SIZ(x) >= 0 && pbz_cmp_ui(x, ULONG_MAX) <= 0; }
PBN_DEF int pbz_fits_slong_p(pbz_srcptr x) { return pbz_cmp_si(x, LONG_MAX) <= 0 && pbz_cmp_si(x, LONG_MIN) >= 0; }
PBN_DEF int pbz_fits_uint_p(pbz_srcptr x)  { return SIZ(x) >= 0 && pbz_cmp_ui(x, UINT_MAX) <= 0; }
PBN_DEF int pbz_fits_sint_p(pbz_srcptr x)  { return pbz_cmp_si(x, INT_MAX) <= 0 && pbz_cmp_si(x, INT_MIN) >= 0; }
PBN_DEF int pbz_fits_ushort_p(pbz_srcptr x){ return SIZ(x) >= 0 && pbz_cmp_ui(x, USHRT_MAX) <= 0; }
PBN_DEF int pbz_fits_sshort_p(pbz_srcptr x){ return pbz_cmp_si(x, SHRT_MAX) <= 0 && pbz_cmp_si(x, SHRT_MIN) >= 0; }

static const double pbn_log2_over_logb[63] = {
    0.0, 0.0, 1, 0.63092975357145742,
    0.5, 0.43067655807339306, 0.38685280723454157, 0.35620718710802218,
    0.33333333333333337, 0.31546487678572871, 0.30102999566398114, 0.28906482631788782,
    0.27894294565112981, 0.27023815442731974, 0.26264953503719357, 0.2559580248098155,
    0.25, 0.24465054211822601, 0.23981246656813146, 0.23540891336663824,
    0.23137821315975918, 0.22767024869695299, 0.22424382421757541, 0.22106472945750374,
    0.21810429198553155, 0.21533827903669653, 0.21274605355336315, 0.21030991785715247,
    0.20801459767650946, 0.20584683246043445, 0.20379504709050617, 0.20184908658209985,
    0.19999999999999998, 0.19823986317056053, 0.19656163223282258, 0.19495902189378631,
    0.19342640361727079, 0.19195872000656014, 0.1905514124267734, 0.18920035951687003,
    0.18790182470910757, 0.18665241123894336, 0.1854490234153689, 0.18428883314870617,
    0.18316925091363362, 0.18208790046993825, 0.1810425967800402, 0.18003132665669264,
    0.17905223175104135, 0.17810359355401109, 0.17718382013555792, 0.17629143438888209,
    0.1754250635819545, 0.17458343004804491, 0.17376534287143999, 0.1729696904450771,
    0.1721954337940981, 0.17144160057391344, 0.17070727966372012, 0.169991616286914,
    0.16929380759878143, 0.16861309868950111, 0.16794877895704194,
};

static int pbn_log2_exact(int base) {
    int k = 0;
    if (base & (base - 1)) return 0;
    while ((1 << k) < base) k++;
    return k;
}

PBN_DEF size_t pbz_sizeinbase(pbz_srcptr x, int base) {
    pbn_bitcnt bits;
    int lg;
    if (base < 2 || base > 62) base = 10;
    if (SIZ(x) == 0) return 1;
    bits = pbz_bitlen(x);
    lg = pbn_log2_exact(base);
    if (lg) return (size_t)((bits + (pbn_bitcnt)lg - 1) / (pbn_bitcnt)lg);
    return (size_t)((double)bits * pbn_log2_over_logb[base] * (1.0 + 1e-12)) + 1;
}

static const char pbn_digits_lower[] = "0123456789abcdefghijklmnopqrstuvwxyz";
static const char pbn_digit_pairs[] =
    "00010203040506070809101112131415161718192021222324252627282930313233343536373839"
    "40414243444546474849505152535455565758596061626364656667686970717273747576777879"
    "8081828384858687888990919293949596979899";
static const char pbn_digits_upper[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
static const char pbn_digits_62[]    = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

/* largest power of base fitting in a limb: bb = base^k */
static pbn_limb pbn_big_base(int base, int *k) {
    pbn_limb bb = (pbn_limb)base;
    int n = 1;
    while (bb <= PBN_LIMB_MAX / (pbn_limb)base) { bb *= (pbn_limb)base; n++; }
    *k = n;
    return bb;
}

/* ---- radix conversion: divide & conquer above a threshold
        (Brent & Zimmermann, Modern Computer Arithmetic, section 1.7) ---- */

#ifndef PBN_GET_STR_DC_THRESHOLD
#  define PBN_GET_STR_DC_THRESHOLD 32     /* limbs */
#endif
#ifndef PBN_SET_STR_DC_THRESHOLD
#  define PBN_SET_STR_DC_THRESHOLD 128    /* limbs (worth of digits) */
#endif

/* powers of the "big base" bb = base^k: pw[i] = bb^(2^i), worth k*2^i digits. They're kept
   without their low zero limbs (of which an even base has plenty: 10^k = 2^k 5^k), so
   pw[i] = {p[i], n[i]} * B^z[i], and dividing or multiplying by it works on fewer limbs */
typedef struct {
    pbn_limb *p[64];
    pbn_size  n[64];       /* limbs, without the zero ones */
    pbn_size  z[64];       /* low zero limbs */
    pbn_size  full[64];    /* n + z */
    size_t    digits[64];
    pbn_limb *mem[64];     /* allocations (p[i] points into them) */
    pbn_size  memn[64];
    int       count;
    pbn_limb  b0;          /* storage for p[0] (no allocation for small numbers) */
} pbn_powtab;

/* builds pw[0..] while pw[i] has at most maxn limbs */
static void pbn_powtab_init(pbn_powtab *t, pbn_limb bb, int k, pbn_size maxn) {
    t->b0 = bb;
    t->p[0] = &t->b0;
    t->n[0] = 1;
    t->z[0] = 0;
    t->full[0] = 1;
    t->digits[0] = (size_t)k;
    t->count = 1;
    while (t->count < 64 && 2 * t->full[t->count - 1] <= maxn + 1) {
        int i = t->count;
        pbn_size n = 2 * t->n[i - 1], z = 2 * t->z[i - 1];
        pbn_limb *p = PBN_TMP_ALLOC(n);
        t->mem[i] = p;
        t->memn[i] = n;
        pbn_n_sqr(p, t->p[i - 1], t->n[i - 1]);
        PBN_NORM(p, n);
        while (p[0] == 0) { p++; n--; z++; }
        t->p[i] = p;
        t->n[i] = n;
        t->z[i] = z;
        t->full[i] = n + z;
        t->digits[i] = 2 * t->digits[i - 1];
        t->count++;
    }
}

static void pbn_powtab_clear(pbn_powtab *t) {
    int i;
    for (i = 1; i < t->count; i++) PBN_TMP_FREE(t->mem[i], t->memn[i]);
}

/* writes exactly nd digits of {np, nn} (zero-padded; the number must fit) into out;
   destroys {np, nn} */
static void pbn_get_str_rec(char *out, size_t nd, pbn_limb *np, pbn_size nn, const pbn_powtab *t,
                            int base, const char *digs) {
    PBN_NORM(np, nn);
    if (nn < PBN_GET_STR_DC_THRESHOLD || t->count < 2) {
        pbn_limb bb = t->p[0][0];
        int k = (int)t->digits[0], j;
        size_t pos = nd;
        while (nn > 0 && pos > 0) {
            pbn_limb r = pbn_n_divrem_1(np, np, nn, bb);
            PBN_NORM(np, nn);
            if (base == 10) {
                for (j = 0; j + 2 <= k && pos >= 2; j += 2) {
                    unsigned d2 = (unsigned)(r % 100) * 2;
                    r /= 100;
                    out[--pos] = pbn_digit_pairs[d2 + 1];
                    out[--pos] = pbn_digit_pairs[d2];
                }
                for (; j < k && pos > 0; j++) { out[--pos] = (char)('0' + r % 10); r /= 10; }
            } else {
                for (j = 0; j < k && pos > 0; j++) { out[--pos] = digs[r % (pbn_limb)base]; r /= (pbn_limb)base; }
            }
        }
        while (pos > 0) out[--pos] = '0';
        return;
    }
    {
        /* split by the largest table power of at most about half the size */
        int i = t->count - 1;
        pbn_size qn, rn;
        pbn_limb *qp, *rp;
        while (i > 0 && (2 * t->full[i] > nn + 1 || t->digits[i] >= nd)) i--;
        rn = t->full[i];
        if (nn < rn) {
            pbn_get_str_rec(out + nd - t->digits[i], t->digits[i], np, nn, t, base, digs);
            memset(out, '0', nd - t->digits[i]);
            return;
        }
        qn = nn - rn + 1;
        qp = PBN_TMP_ALLOC(qn + rn);
        rp = qp + qn;
        /* n = (nh B^z + nl) by p B^z: q = nh / p, and the remainder is (nh mod p) B^z + nl */
        pbn_n_tdiv_qr(qp, rp + t->z[i], np + t->z[i], nn - t->z[i], t->p[i], t->n[i]);
        pbn_n_copy(rp, np, t->z[i]);
        pbn_get_str_rec(out, nd - t->digits[i], qp, qn, t, base, digs);
        pbn_get_str_rec(out + nd - t->digits[i], t->digits[i], rp, rn, t, base, digs);
        PBN_TMP_FREE(qp, qn + rn);
    }
}

/* {rp, return value} = the number written by the nd digit values dv (most significant
   first); rp must have room for pbn_set_str_limbs(nd) limbs */
static pbn_size pbn_set_str_limbs(size_t nd, int base) {
    return (pbn_size)((double)nd / pbn_log2_over_logb[base] / PBN_B) + 3;
}

static pbn_size pbn_set_str_rec(pbn_limb *rp, const unsigned char *dv, size_t nd, const pbn_powtab *t, int base) {
    int k = (int)t->digits[0];
    if (nd <= (size_t)PBN_SET_STR_DC_THRESHOLD * (size_t)k || t->count < 2) {
        pbn_limb bb = t->p[0][0];
        size_t first = nd % (size_t)k, i = 0, j;
        pbn_size an = 0;
        if (first == 0) first = (size_t)k;
        {
            pbn_limb chunk = 0;
            for (j = 0; j < first && i < nd; j++) chunk = chunk * (pbn_limb)base + dv[i++];
            if (chunk) rp[an++] = chunk;
        }
        while (i < nd) {
            pbn_limb chunk = 0, cy;
            for (j = 0; j < (size_t)k; j++) chunk = chunk * (pbn_limb)base + dv[i++];
            cy = pbn_n_mul_1(rp, rp, an, bb);
            cy += pbn_n_add_1(rp, rp, an, chunk);
            if (cy) rp[an++] = cy;
        }
        return an;
    }
    {
        /* n = hi * pw[i] + lo, lo being the last digits[i] digits (about half) */
        int i = t->count - 1;
        size_t ld;
        pbn_size hn, ln, hcap, lcap, rn;
        pbn_limb *hp, *lp;
        while (i > 0 && 2 * t->digits[i] > nd) i--;
        ld = t->digits[i];
        hcap = pbn_set_str_limbs(nd - ld, base);
        lcap = pbn_set_str_limbs(ld, base);
        hp = PBN_TMP_ALLOC(hcap + lcap);
        lp = hp + hcap;
        hn = pbn_set_str_rec(hp, dv, nd - ld, t, base);
        ln = pbn_set_str_rec(lp, dv + nd - ld, ld, t, base);
        if (hn == 0) {
            pbn_n_copy(rp, lp, ln);
            rn = ln;
        } else {
            pbn_size pn = t->n[i], z = t->z[i];
            if (hn >= pn) pbn_n_mul(rp + z, hp, hn, t->p[i], pn);
            else          pbn_n_mul(rp + z, t->p[i], pn, hp, hn);
            pbn_n_zero(rp, z);
            rn = hn + pn + z;
            if (ln) pbn_n_add(rp, rp, rn, lp, ln);
            PBN_NORM(rp, rn);
        }
        PBN_TMP_FREE(hp, hcap + lcap);
        return rn;
    }
}

PBN_DEF char *pbz_get_str(char *str, int base, pbz_srcptr x) {
    const char *digs = pbn_digits_lower;
    pbn_size n = PBN_ABS(SIZ(x));
    size_t cap, len = 0, start;
    char *s;
    int lg;

    if (base > 1) {
        if (base > 62) return NULL;
        if (base > 36) digs = pbn_digits_62;
    } else {
        base = -base;
        if (base > 1) {
            if (base > 36) return NULL;
            digs = pbn_digits_upper;
        } else {
            base = 10;
        }
    }

    cap = pbz_sizeinbase(x, base) + 2;
    s = str ? str : (char *)pbn_alloc_fn(cap);
    if (SIZ(x) < 0) s[len++] = '-';
    start = len;

    if (n == 0) {
        s[len++] = '0';
    } else if (base == 10 && n >= 2 && n <= 3) {
        /* small numbers: chunks of k digits, written backwards into a local buffer */
        char tmp[3 * 20 + 4];
        pbn_limb t3[3];
        pbn_size tn = n;
        int k, j;
        pbn_limb bb = pbn_big_base(10, &k);
        size_t pos = sizeof tmp;
        pbn_n_copy(t3, PTR(x), n);
        while (tn > 0) {
            pbn_limb r = tn == 1 ? t3[0] % bb : pbn_n_divrem_1(t3, t3, tn, bb);
            if (tn == 1) t3[0] /= bb;
            PBN_NORM(t3, tn);
            for (j = 0; j + 2 <= k && (tn > 0 || r >= 10); j += 2) {
                unsigned d2 = (unsigned)(r % 100) * 2;
                r /= 100;
                tmp[--pos] = pbn_digit_pairs[d2 + 1];
                tmp[--pos] = pbn_digit_pairs[d2];
            }
            for (; j < k && (tn > 0 || r > 0); j++) { tmp[--pos] = (char)('0' + r % 10); r /= 10; }
        }
        memcpy(s + len, tmp + pos, sizeof tmp - pos);
        len += sizeof tmp - pos;
    } else if (n == 1 && base == 10) {
        /* one limb: two digits per step (constant divisors only), written backwards */
        char tmp[20];
        size_t pos = sizeof tmp;
        pbn_limb v = PTR(x)[0];
        while (v >= 100) {
            unsigned d2 = (unsigned)(v % 100) * 2;
            v /= 100;
            tmp[--pos] = pbn_digit_pairs[d2 + 1];
            tmp[--pos] = pbn_digit_pairs[d2];
        }
        if (v >= 10) {
            tmp[--pos] = pbn_digit_pairs[2 * v + 1];
            tmp[--pos] = pbn_digit_pairs[2 * v];
        } else {
            tmp[--pos] = (char)('0' + v);
        }
        memcpy(s + len, tmp + pos, sizeof tmp - pos);
        len += sizeof tmp - pos;
    } else if ((lg = pbn_log2_exact(base)) != 0) {
        pbn_bitcnt bits = pbz_bitlen(x);
        pbn_bitcnt nd = (bits + (pbn_bitcnt)lg - 1) / (pbn_bitcnt)lg, i;
        const pbn_limb *xp = PTR(x);
        for (i = nd; i-- > 0;) {
            pbn_bitcnt pos = i * (pbn_bitcnt)lg;
            pbn_size li = (pbn_size)(pos / PBN_B);
            unsigned bi = (unsigned)(pos % PBN_B);
            pbn_limb v = xp[li] >> bi;
            if (bi + (unsigned)lg > PBN_B && li + 1 < n) v |= xp[li + 1] << (PBN_B - bi);
            s[len++] = digs[v & (((pbn_limb)1 << lg) - 1)];
        }
    } else {
        int k;
        pbn_limb bb = pbn_big_base(base, &k);
        size_t nd = cap - 2, z = 0;
        pbn_limb *tp = PBN_TMP_ALLOC(n);
        pbn_powtab t;
        pbn_n_copy(tp, PTR(x), n);
        pbn_powtab_init(&t, bb, k, n >= PBN_GET_STR_DC_THRESHOLD ? n : 0);
        pbn_get_str_rec(s + start, nd, tp, n, &t, base, digs);
        pbn_powtab_clear(&t);
        PBN_TMP_FREE(tp, n);
        /* nd may overestimate by one: drop leading zeros */
        while (z + 1 < nd && s[start + z] == '0') z++;
        if (z) memmove(s + start, s + start + z, nd - z);
        len = start + nd - z;
    }
    s[len] = '\0';
    if (!str && len + 1 != cap) s = (char *)pbn_realloc_fn(s, cap, len + 1);
    return s;
}

static int pbn_isspace(int c) { return c == ' ' || (c >= '\t' && c <= '\r'); }

static int pbn_digit_value(int c, int base) {
    if (c >= '0' && c <= '9') return c - '0';
    if (c >= 'A' && c <= 'Z') return c - 'A' + 10;
    if (c >= 'a' && c <= 'z') return base <= 36 ? c - 'a' + 10 : c - 'a' + 36;
    return 99;
}

PBN_DEF int pbz_set_str(pbz_ptr x, const char *str, int base) {
    const unsigned char *p = (const unsigned char *)str;
    unsigned char *dv, dvbuf[256];
    size_t nd = 0, cap, i;
    int c, neg = 0;
    pbn_size rn, an;
    pbn_limb *rp;

    if (base > 62 || base == 1 || base < 0) return -1;

    do c = *p++; while (pbn_isspace(c));
    if (c == '-') { neg = 1; c = *p++; }
    if (pbn_digit_value(c, base == 0 ? 10 : base) >= (base == 0 ? 10 : base)) return -1;

    if (base == 0) {
        base = 10;
        if (c == '0') {
            base = 8;
            c = *p++;
            if (c == 'x' || c == 'X')      { base = 16; c = *p++; }
            else if (c == 'b' || c == 'B') { base = 2;  c = *p++; }
        }
    }
    while (c == '0' || pbn_isspace(c)) c = *p++;
    if (c == 0) { SIZ(x) = 0; return 0; }

    cap = strlen((const char *)p - 1);
    dv = cap + 1 <= sizeof dvbuf ? dvbuf : (unsigned char *)pbn_alloc_fn(cap + 1);
    for (i = 0; i < cap; i++) {
        if (!pbn_isspace(c)) {
            int d = pbn_digit_value(c, base);
            if (d >= base) { if (dv != dvbuf) pbn_free_fn(dv, cap + 1); return -1; }
            dv[nd++] = (unsigned char)d;
        }
        c = *p++;
    }

    {
        int lg = pbn_log2_exact(base);
        if (lg) {
            pbn_bitcnt bits = (pbn_bitcnt)nd * (pbn_bitcnt)lg;
            rn = (pbn_size)((bits + PBN_B - 1) / PBN_B);
            rp = PBZ_GROW(x, rn);
            pbn_n_zero(rp, rn);
            for (i = 0; i < nd; i++) {
                pbn_bitcnt pos = (pbn_bitcnt)(nd - 1 - i) * (pbn_bitcnt)lg;
                pbn_size li = (pbn_size)(pos / PBN_B);
                unsigned bi = (unsigned)(pos % PBN_B);
                rp[li] |= (pbn_limb)dv[i] << bi;
                if (bi + (unsigned)lg > PBN_B) rp[li + 1] |= (pbn_limb)dv[i] >> (PBN_B - bi);
            }
            an = rn;
        } else {
            int k;
            pbn_limb bb = pbn_big_base(base, &k);
            pbn_powtab t;
            rn = pbn_set_str_limbs(nd, base);
            rp = PBZ_GROW(x, rn);
            pbn_powtab_init(&t, bb, k, nd > (size_t)PBN_SET_STR_DC_THRESHOLD * (size_t)k ? rn / 2 + 1 : 0);
            an = pbn_set_str_rec(rp, dv, nd, &t, base);
            pbn_powtab_clear(&t);
        }
    }
    if (dv != dvbuf) pbn_free_fn(dv, cap + 1);
    PBN_NORM(rp, an);
    SIZ(x) = (int)(neg ? -an : an);
    return 0;
}

/* ---- add / sub ---- */

static void pbz_addsub(pbz_ptr r, pbz_srcptr a, pbz_srcptr b, int bneg) {
    pbn_size as = SIZ(a), bs = bneg ? -SIZ(b) : SIZ(b);
    pbn_size an = PBN_ABS(as), bn = PBN_ABS(bs), rn;
    pbn_limb *rp;
    const pbn_limb *ap, *bp;

    if (an < bn) {
        pbz_srcptr t = a; a = b; b = t;
        rn = as; as = bs; bs = rn;
        rn = an; an = bn; bn = rn;
    }
    if ((as ^ bs) >= 0) {
        pbn_limb cy;
        rp = PBZ_GROW(r, an + 1);
        ap = PTR(a); bp = PTR(b);
        cy = pbn_n_add(rp, ap, an, bp, bn);
        rp[an] = cy;
        rn = an + (pbn_size)cy;
        SIZ(r) = (int)(as >= 0 ? rn : -rn);
    } else {
        rp = PBZ_GROW(r, an);
        ap = PTR(a); bp = PTR(b);
        if (an > bn || pbn_n_cmp(ap, bp, an) >= 0) {
            pbn_n_sub(rp, ap, an, bp, bn);
            rn = an;
            PBN_NORM(rp, rn);
            SIZ(r) = (int)(as >= 0 ? rn : -rn);
        } else {
            pbn_n_sub_n(rp, bp, ap, an);
            rn = an;
            PBN_NORM(rp, rn);
            SIZ(r) = (int)(bs >= 0 ? rn : -rn);
        }
    }
}

PBN_DEF void pbz_add(pbz_ptr r, pbz_srcptr a, pbz_srcptr b) { pbz_addsub(r, a, b, 0); }
PBN_DEF void pbz_sub(pbz_ptr r, pbz_srcptr a, pbz_srcptr b) { pbz_addsub(r, a, b, 1); }
/* r = a + b (bneg: a - b) for a single limb b */
static void pbz_add_limb(pbz_ptr r, pbz_srcptr a, pbn_limb b, int bneg) {
    pbn_size as = SIZ(a), an = PBN_ABS(as), rn;
    pbn_limb *rp;
    if (an == 0) {
        if (b == 0) { SIZ(r) = 0; return; }
        rp = PBZ_GROW(r, 1);
        rp[0] = b;
        SIZ(r) = bneg ? -1 : 1;
        return;
    }
    if ((as < 0) == bneg) {
        /* same signs: |r| = |a| + b */
        rp = PBZ_GROW(r, an + 1);
        rp[an] = pbn_n_add_1(rp, PTR(a), an, b);
        rn = an + (rp[an] != 0);
        SIZ(r) = (int)(as < 0 ? -rn : rn);
    } else if (an == 1 && PTR(a)[0] < b) {
        /* |a| < b: the sign flips */
        pbn_limb v = b - PTR(a)[0];
        rp = PBZ_GROW(r, 1);
        rp[0] = v;
        SIZ(r) = as < 0 ? 1 : -1;
    } else {
        rp = PBZ_GROW(r, an);
        pbn_n_sub_1(rp, PTR(a), an, b);
        rn = an;
        PBN_NORM(rp, rn);
        SIZ(r) = (int)(as < 0 ? -rn : rn);
    }
}

/* r = a * b for a single limb b (neg: the product's sign flips) */
static void pbz_mul_limb(pbz_ptr r, pbz_srcptr a, pbn_limb b, int neg) {
    pbn_size as = SIZ(a), an = PBN_ABS(as), rn;
    pbn_limb *rp;
    if (an == 0 || b == 0) { SIZ(r) = 0; return; }
    rp = PBZ_GROW(r, an + 1);
    rp[an] = pbn_n_mul_1(rp, PTR(a), an, b);
    rn = an + (rp[an] != 0);
    SIZ(r) = (int)(((as < 0) != neg) ? -rn : rn);
}

#define PBN_UL_FITS_LIMB(u) ((unsigned long)(pbn_limb)(u) == (u))

PBN_DEF void pbz_add_ui(pbz_ptr r, pbz_srcptr a, unsigned long b) {
    if (PBN_UL_FITS_LIMB(b)) { pbz_add_limb(r, a, (pbn_limb)b, 0); return; }
    { PBZ_TMP_UL(t, b); pbz_addsub(r, a, t, 0); }
}
PBN_DEF void pbz_sub_ui(pbz_ptr r, pbz_srcptr a, unsigned long b) {
    if (PBN_UL_FITS_LIMB(b)) { pbz_add_limb(r, a, (pbn_limb)b, 1); return; }
    { PBZ_TMP_UL(t, b); pbz_addsub(r, a, t, 1); }
}
PBN_DEF void pbz_ui_sub(pbz_ptr r, unsigned long a, pbz_srcptr b) {
    if (PBN_UL_FITS_LIMB(a)) { pbz_add_limb(r, b, (pbn_limb)a, 1); SIZ(r) = -SIZ(r); return; }
    { PBZ_TMP_UL(t, a); pbz_addsub(r, t, b, 1); }
}

PBN_DEF void pbz_neg(pbz_ptr r, pbz_srcptr a) { pbz_set(r, a); SIZ(r) = -SIZ(r); }
PBN_DEF void pbz_abs(pbz_ptr r, pbz_srcptr a) { pbz_set(r, a); SIZ(r) = PBN_ABS(SIZ(r)); }

/* ---- multiplication ---- */

PBN_DEF void pbz_mul(pbz_ptr r, pbz_srcptr a, pbz_srcptr b) {
    pbn_size as = SIZ(a), bs = SIZ(b), an = PBN_ABS(as), bn = PBN_ABS(bs), rn;
    int neg = (as ^ bs) < 0;
    pbn_limb *rp;

    if (an == 0 || bn == 0) { SIZ(r) = 0; return; }
    if (an < bn) {
        pbz_srcptr t = a; a = b; b = t;
        rn = an; an = bn; bn = rn;
    }
#if defined(PBN_HAVE_DLIMB)
    if (an == 2 && bn == 2) {
        /* inline 2x2 (operands read first: r may alias a or b) */
        pbn_limb a0 = PTR(a)[0], a1 = PTR(a)[1], b0 = PTR(b)[0], b1 = PTR(b)[1], r1, r2, h;
        pbn_dlimb t;
        rp = PBZ_GROW(r, 4);
        t = (pbn_dlimb)a0 * b0;
        rp[0] = (pbn_limb)t;
        t = (pbn_dlimb)a0 * b1 + (pbn_limb)(t >> PBN_B);
        r1 = (pbn_limb)t;
        r2 = (pbn_limb)(t >> PBN_B);
        t = (pbn_dlimb)a1 * b0 + r1;
        rp[1] = (pbn_limb)t;
        h = (pbn_limb)(t >> PBN_B);
        t = (pbn_dlimb)a1 * b1 + r2 + h;
        rp[2] = (pbn_limb)t;
        rp[3] = (pbn_limb)(t >> PBN_B);
        rn = 4 - (rp[3] == 0);
        SIZ(r) = (int)(neg ? -rn : rn);
        return;
    }
#endif
    if (bn == 1) {
        pbn_limb b0 = PTR(b)[0], cy;
        rp = PBZ_GROW(r, an + 1);
        cy = pbn_n_mul_1(rp, PTR(a), an, b0);
        rp[an] = cy;
        rn = an + (cy != 0);
    } else {
        int alias, fresh;
        rn = an + bn;
        alias = PTR(r) == PTR(a) || PTR(r) == PTR(b);
        if (alias && rn <= PBN_STACK_LIMBS) {
            /* small aliased product: compute on the stack, then copy */
            pbn_limb tb[PBN_STACK_LIMBS];
            if (PTR(a) == PTR(b) && an == bn) pbn_n_sqr(tb, PTR(a), an);
            else pbn_n_mul(tb, PTR(a), an, PTR(b), bn);
            rn -= tb[rn - 1] == 0;
            rp = PBZ_GROW(r, rn);
            pbn_n_copy(rp, tb, rn);
            SIZ(r) = (int)(neg ? -rn : rn);
            return;
        }
        fresh = alias || PBZ_CAP(r) < rn;
        rp = fresh ? PBN_TMP_ALLOC(rn) : PTR(r);
        if (PTR(a) == PTR(b) && an == bn) pbn_n_sqr(rp, PTR(a), an);
        else pbn_n_mul(rp, PTR(a), an, PTR(b), bn);
        if (fresh) pbz_install(r, rp, rn);
        rn -= rp[rn - 1] == 0;
    }
    SIZ(r) = (int)(neg ? -rn : rn);
}

PBN_DEF void pbz_mul_ui(pbz_ptr r, pbz_srcptr a, unsigned long b) {
    if (PBN_UL_FITS_LIMB(b)) { pbz_mul_limb(r, a, (pbn_limb)b, 0); return; }
    { PBZ_TMP_UL(t, b); pbz_mul(r, a, t); }
}
PBN_DEF void pbz_mul_si(pbz_ptr r, pbz_srcptr a, long b) {
    unsigned long m = b < 0 ? 0UL - (unsigned long)b : (unsigned long)b;
    if (PBN_UL_FITS_LIMB(m)) { pbz_mul_limb(r, a, (pbn_limb)m, b < 0); return; }
    { PBZ_TMP_SL(t, b); pbz_mul(r, a, t); }
}

PBN_DEF void pbz_addmul(pbz_ptr r, pbz_srcptr a, pbz_srcptr b) {
    PBZ_STACK(t, 16);
    pbz_mul(t, a, b);
    pbz_add(r, r, t);
    pbz_clear(t);
}
PBN_DEF void pbz_submul(pbz_ptr r, pbz_srcptr a, pbz_srcptr b) {
    PBZ_STACK(t, 16);
    pbz_mul(t, a, b);
    pbz_sub(r, r, t);
    pbz_clear(t);
}
PBN_DEF void pbz_addmul_ui(pbz_ptr r, pbz_srcptr a, unsigned long b) { PBZ_TMP_UL(t, b); pbz_addmul(r, a, t); }
PBN_DEF void pbz_submul_ui(pbz_ptr r, pbz_srcptr a, unsigned long b) { PBZ_TMP_UL(t, b); pbz_submul(r, a, t); }

PBN_DEF void pbz_mul_2exp(pbz_ptr r, pbz_srcptr a, pbn_bitcnt k) {
    pbn_size as = SIZ(a), an = PBN_ABS(as), ls, rn;
    unsigned bs;
    pbn_limb *rp;
    if (an == 0) { SIZ(r) = 0; return; }
    ls = (pbn_size)(k / PBN_B);
    bs = (unsigned)(k % PBN_B);
    rn = an + ls + 1;
    rp = PBZ_GROW(r, rn);
    if (bs) rp[an + ls] = pbn_n_lshift(rp + ls, PTR(a), an, bs);
    else { memmove(rp + ls, PTR(a), (size_t)an * sizeof(pbn_limb)); rp[an + ls] = 0; }
    pbn_n_zero(rp, ls);
    rn -= rp[rn - 1] == 0;
    SIZ(r) = (int)(as < 0 ? -rn : rn);
}

/* ---- division ---- */

enum { PBN_TRUNC = 0, PBN_FLOOR = 1, PBN_CEIL = 2 };

/* does rounding mode require moving the truncated quotient away from zero? */
#define PBN_ADJUST(mode, nsign, dsign) \
    ((mode) == PBN_FLOOR ? ((nsign) ^ (dsign)) < 0 : (mode) == PBN_CEIL ? ((nsign) ^ (dsign)) >= 0 : 0)

static void pbz_div_qr(pbz_ptr q, pbz_ptr r, pbz_srcptr n, pbz_srcptr d, int mode) {
    pbn_size ns = SIZ(n), ds = SIZ(d), nn = PBN_ABS(ns), dn = PBN_ABS(ds), qn, rn;
    pbz_t dcopy;
    int dcop = 0, adjust;
    pbn_limb *tp, *tq, *tr;
    PBN_TMP_DECL(tb);

    if (dn == 0) pbn_divzero();
    if (nn == 1 && dn == 1 && mode == PBN_TRUNC) {
        pbn_limb nv = PTR(n)[0], dv = PTR(d)[0], qv = nv / dv, rv = nv - qv * dv;
        if (q) { pbn_limb *qp = PBZ_GROW(q, 1); qp[0] = qv; SIZ(q) = qv ? ((ns ^ ds) < 0 ? -1 : 1) : 0; }
        if (r) { pbn_limb *rp = PBZ_GROW(r, 1); rp[0] = rv; SIZ(r) = rv ? (ns < 0 ? -1 : 1) : 0; }
        return;
    }
    if ((q && PTR(q) == PTR(d)) || (r && PTR(r) == PTR(d))) {
        pbz_init_set(dcopy, d);
        d = dcopy;
        dcop = 1;
    }

    if (nn < dn) {
        if (nn != 0 && PBN_ADJUST(mode, ns, ds)) {
            if (r) { if (mode == PBN_FLOOR) pbz_add(r, n, d); else pbz_sub(r, n, d); }
            if (q) pbz_set_si(q, mode == PBN_FLOOR ? -1 : 1);
        } else {
            if (r) pbz_set(r, n);
            if (q) SIZ(q) = 0;
        }
        if (dcop) pbz_clear(dcopy);
        return;
    }

    qn = nn - dn + 1;
    tp = PBN_TMP_GET(tb, qn + 1 + dn);
    tq = tp;
    tr = tp + qn + 1;
    if (dn == 1) tr[0] = pbn_n_divrem_1(tq, PTR(n), nn, PTR(d)[0]);
    else pbn_n_tdiv_qr(tq, tr, PTR(n), nn, PTR(d), dn);
    rn = dn;
    PBN_NORM(tr, rn);

    adjust = rn != 0 && PBN_ADJUST(mode, ns, ds);
    if (adjust) {
        tq[qn] = pbn_n_add_1(tq, tq, qn, 1);
        qn++;
        pbn_n_sub(tr, PTR(d), dn, tr, rn);
        rn = dn;
        PBN_NORM(tr, rn);
    }
    PBN_NORM(tq, qn);

    if (q) {
        pbn_limb *qp = PBZ_GROW(q, qn);
        pbn_n_copy(qp, tq, qn);
        SIZ(q) = (int)((ns ^ ds) < 0 ? -qn : qn);
    }
    if (r) {
        pbn_limb *rp = PBZ_GROW(r, rn);
        int rneg;
        pbn_n_copy(rp, tr, rn);
        if (!adjust) rneg = ns < 0;
        else rneg = mode == PBN_FLOOR ? ds < 0 : ds > 0;
        SIZ(r) = (int)(rneg ? -rn : rn);
    }
    PBN_TMP_PUT(tb, tp, qn + 1 + dn);
    if (dcop) pbz_clear(dcopy);
}

static unsigned long pbz_div_ui(pbz_ptr q, pbz_ptr r, pbz_srcptr n, unsigned long d, int mode) {
    pbn_size ns = SIZ(n), nn = PBN_ABS(ns), qn;
    pbn_limb rem, *qp;
    int adjust;

    if (d == 0) pbn_divzero();
    if ((pbn_limb)d != d) {
        /* divisor wider than a limb: generic path */
        pbz_t tr; unsigned long ret;
        PBZ_TMP_UL(t, d);
        pbz_init(tr);
        pbz_div_qr(q, tr, n, t, mode);
        ret = pbz_get_ui(tr);
        if (r) pbz_swap(r, tr);
        pbz_clear(tr);
        return ret;
    }
    if (nn == 0) {
        if (q) SIZ(q) = 0;
        if (r) SIZ(r) = 0;
        return 0;
    }
    if (q) {
        qp = PBZ_GROW(q, nn + 1);
        rem = pbn_n_divrem_1(qp, PTR(n), nn, (pbn_limb)d);
    } else {
        qp = NULL;
        rem = pbn_n_divrem_1(NULL, PTR(n), nn, (pbn_limb)d);
    }
    qn = nn;
    adjust = rem != 0 && PBN_ADJUST(mode, ns, 1);
    if (adjust) rem = (pbn_limb)d - rem;
    if (q) {
        if (adjust) { qp[qn] = pbn_n_add_1(qp, qp, qn, 1); qn++; }
        PBN_NORM(qp, qn);
        SIZ(q) = (int)(ns < 0 ? -qn : qn);
    }
    if (r) {
        int rneg = adjust ? mode == PBN_CEIL : ns < 0;
        pbz_set_ui(r, (unsigned long)rem);
        if (rneg) SIZ(r) = -SIZ(r);
    }
    return (unsigned long)rem;
}

PBN_DEF void pbz_tdiv_q(pbz_ptr q, pbz_srcptr n, pbz_srcptr d)             { pbz_div_qr(q, NULL, n, d, PBN_TRUNC); }
PBN_DEF void pbz_tdiv_r(pbz_ptr r, pbz_srcptr n, pbz_srcptr d)             { pbz_div_qr(NULL, r, n, d, PBN_TRUNC); }
PBN_DEF void pbz_tdiv_qr(pbz_ptr q, pbz_ptr r, pbz_srcptr n, pbz_srcptr d) { pbz_div_qr(q, r, n, d, PBN_TRUNC); }
PBN_DEF void pbz_fdiv_q(pbz_ptr q, pbz_srcptr n, pbz_srcptr d)             { pbz_div_qr(q, NULL, n, d, PBN_FLOOR); }
PBN_DEF void pbz_fdiv_r(pbz_ptr r, pbz_srcptr n, pbz_srcptr d)             { pbz_div_qr(NULL, r, n, d, PBN_FLOOR); }
PBN_DEF void pbz_fdiv_qr(pbz_ptr q, pbz_ptr r, pbz_srcptr n, pbz_srcptr d) { pbz_div_qr(q, r, n, d, PBN_FLOOR); }
PBN_DEF void pbz_cdiv_q(pbz_ptr q, pbz_srcptr n, pbz_srcptr d)             { pbz_div_qr(q, NULL, n, d, PBN_CEIL); }
PBN_DEF void pbz_cdiv_r(pbz_ptr r, pbz_srcptr n, pbz_srcptr d)             { pbz_div_qr(NULL, r, n, d, PBN_CEIL); }
PBN_DEF void pbz_cdiv_qr(pbz_ptr q, pbz_ptr r, pbz_srcptr n, pbz_srcptr d) { pbz_div_qr(q, r, n, d, PBN_CEIL); }

PBN_DEF unsigned long pbz_tdiv_q_ui(pbz_ptr q, pbz_srcptr n, unsigned long d)             { return pbz_div_ui(q, NULL, n, d, PBN_TRUNC); }
PBN_DEF unsigned long pbz_tdiv_r_ui(pbz_ptr r, pbz_srcptr n, unsigned long d)             { return pbz_div_ui(NULL, r, n, d, PBN_TRUNC); }
PBN_DEF unsigned long pbz_tdiv_qr_ui(pbz_ptr q, pbz_ptr r, pbz_srcptr n, unsigned long d) { return pbz_div_ui(q, r, n, d, PBN_TRUNC); }
PBN_DEF unsigned long pbz_tdiv_ui(pbz_srcptr n, unsigned long d)                          { return pbz_div_ui(NULL, NULL, n, d, PBN_TRUNC); }
PBN_DEF unsigned long pbz_fdiv_q_ui(pbz_ptr q, pbz_srcptr n, unsigned long d)             { return pbz_div_ui(q, NULL, n, d, PBN_FLOOR); }
PBN_DEF unsigned long pbz_fdiv_r_ui(pbz_ptr r, pbz_srcptr n, unsigned long d)             { return pbz_div_ui(NULL, r, n, d, PBN_FLOOR); }
PBN_DEF unsigned long pbz_fdiv_qr_ui(pbz_ptr q, pbz_ptr r, pbz_srcptr n, unsigned long d) { return pbz_div_ui(q, r, n, d, PBN_FLOOR); }
PBN_DEF unsigned long pbz_fdiv_ui(pbz_srcptr n, unsigned long d)                          { return pbz_div_ui(NULL, NULL, n, d, PBN_FLOOR); }
PBN_DEF unsigned long pbz_cdiv_q_ui(pbz_ptr q, pbz_srcptr n, unsigned long d)             { return pbz_div_ui(q, NULL, n, d, PBN_CEIL); }
PBN_DEF unsigned long pbz_cdiv_r_ui(pbz_ptr r, pbz_srcptr n, unsigned long d)             { return pbz_div_ui(NULL, r, n, d, PBN_CEIL); }
PBN_DEF unsigned long pbz_cdiv_qr_ui(pbz_ptr q, pbz_ptr r, pbz_srcptr n, unsigned long d) { return pbz_div_ui(q, r, n, d, PBN_CEIL); }
PBN_DEF unsigned long pbz_cdiv_ui(pbz_srcptr n, unsigned long d)                          { return pbz_div_ui(NULL, NULL, n, d, PBN_CEIL); }

static void pbz_div_q_2exp(pbz_ptr r, pbz_srcptr a, pbn_bitcnt k, int mode) {
    pbn_size as = SIZ(a), an = PBN_ABS(as), ls = (pbn_size)(k / PBN_B), rn, i;
    unsigned bs = (unsigned)(k % PBN_B);
    int inexact = 0, away;
    pbn_limb *rp;
    const pbn_limb *ap;

    away = (mode == PBN_FLOOR && as < 0) || (mode == PBN_CEIL && as > 0);
    if (ls >= an) {
        if (an != 0 && away) pbz_set_si(r, as < 0 ? -1 : 1);
        else SIZ(r) = 0;
        return;
    }
    ap = PTR(a);
    for (i = 0; i < ls && !inexact; i++) inexact = ap[i] != 0;
    if (bs && (ap[ls] & (((pbn_limb)1 << bs) - 1))) inexact = 1;

    rn = an - ls;
    rp = PBZ_GROW(r, rn + 1);
    ap = PTR(a);
    if (bs) pbn_n_rshift(rp, ap + ls, rn, bs);
    else pbn_n_copy(rp, ap + ls, rn);
    PBN_NORM(rp, rn);
    if (inexact && away) {
        pbn_limb cy = pbn_n_add_1(rp, rp, rn, 1);
        rp[rn] = cy;
        rn += (pbn_size)cy;
        if (rn == 0) { rp[0] = 1; rn = 1; }
    }
    SIZ(r) = (int)(as < 0 ? -rn : rn);
}

static void pbz_div_r_2exp(pbz_ptr r, pbz_srcptr a, pbn_bitcnt k, int mode) {
    pbn_size as = SIZ(a), an = PBN_ABS(as), ls = (pbn_size)(k / PBN_B), nl, rn, cp, i;
    unsigned bs = (unsigned)(k % PBN_B);
    pbn_limb *rp, mask = bs ? (((pbn_limb)1 << bs) - 1) : PBN_LIMB_MAX;
    int nonzero = 0, adjust;

    nl = ls + (bs ? 1 : 0);              /* limbs spanned by 2^k - 1 */
    cp = PBN_MIN(an, nl);
    for (i = 0; i < cp && !nonzero; i++) {
        pbn_limb v = PTR(a)[i];
        if (i == ls) v &= mask;
        nonzero = v != 0;
    }
    adjust = nonzero && ((mode == PBN_FLOOR && as < 0) || (mode == PBN_CEIL && as > 0));

    if (!adjust) {
        rp = PBZ_GROW(r, cp);
        pbn_n_copy(rp, PTR(a), cp);
        if (bs && cp == nl) rp[ls] &= mask;
        rn = cp;
        PBN_NORM(rp, rn);
        SIZ(r) = (int)(as < 0 ? -rn : rn);
    } else {
        rp = PBZ_GROW(r, nl);
        pbn_n_copy(rp, PTR(a), cp);
        pbn_n_zero(rp + cp, nl - cp);
        if (bs) rp[ls] &= mask;
        pbn_n_neg(rp, rp, nl);
        if (bs) rp[ls] &= mask;
        rn = nl;
        PBN_NORM(rp, rn);
        SIZ(r) = (int)(mode == PBN_FLOOR ? rn : -rn);
    }
}

PBN_DEF void pbz_tdiv_q_2exp(pbz_ptr q, pbz_srcptr n, pbn_bitcnt k) { pbz_div_q_2exp(q, n, k, PBN_TRUNC); }
PBN_DEF void pbz_fdiv_q_2exp(pbz_ptr q, pbz_srcptr n, pbn_bitcnt k) { pbz_div_q_2exp(q, n, k, PBN_FLOOR); }
PBN_DEF void pbz_cdiv_q_2exp(pbz_ptr q, pbz_srcptr n, pbn_bitcnt k) { pbz_div_q_2exp(q, n, k, PBN_CEIL); }
PBN_DEF void pbz_tdiv_r_2exp(pbz_ptr r, pbz_srcptr n, pbn_bitcnt k) { pbz_div_r_2exp(r, n, k, PBN_TRUNC); }
PBN_DEF void pbz_fdiv_r_2exp(pbz_ptr r, pbz_srcptr n, pbn_bitcnt k) { pbz_div_r_2exp(r, n, k, PBN_FLOOR); }
PBN_DEF void pbz_cdiv_r_2exp(pbz_ptr r, pbz_srcptr n, pbn_bitcnt k) { pbz_div_r_2exp(r, n, k, PBN_CEIL); }

PBN_DEF void pbz_mod(pbz_ptr r, pbz_srcptr n, pbz_srcptr d) {
    pbz_struct dabs = *d;
    pbz_t dc;
    int copied = 0;
    if (r == d) { pbz_init_set(dc, d); dabs = *dc; copied = 1; }
    dabs._mp_size = PBN_ABS(dabs._mp_size);
    pbz_div_qr(NULL, r, n, &dabs, PBN_FLOOR);
    if (copied) pbz_clear(dc);
}

PBN_DEF void pbz_divexact(pbz_ptr q, pbz_srcptr n, pbz_srcptr d) {
    if (SIZ(d) == 1 && PTR(d)[0] == 1) { pbz_set(q, n); return; }
    pbz_div_qr(q, NULL, n, d, PBN_TRUNC);
}
PBN_DEF void pbz_divexact_ui(pbz_ptr q, pbz_srcptr n, unsigned long d)    { pbz_div_ui(q, NULL, n, d, PBN_TRUNC); }

PBN_DEF int pbz_divisible_p(pbz_srcptr n, pbz_srcptr d) {
    pbz_t r;
    int res;
    if (SIZ(d) == 0) return SIZ(n) == 0;
    pbz_init(r);
    pbz_tdiv_r(r, n, d);
    res = SIZ(r) == 0;
    pbz_clear(r);
    return res;
}

PBN_DEF int pbz_divisible_ui_p(pbz_srcptr n, unsigned long d) {
    if (d == 0) return SIZ(n) == 0;
    return pbz_tdiv_ui(n, d) == 0;
}

/* ---- logic ---- */

enum { PBN_AND, PBN_IOR, PBN_XOR };

/* two's complement image of x in n limbs */
static void pbn_tc(pbn_limb *rp, pbz_srcptr x, pbn_size n) {
    pbn_size xn = PBN_ABS(SIZ(x));
    pbn_n_copy(rp, PTR(x), xn);
    pbn_n_zero(rp + xn, n - xn);
    if (SIZ(x) < 0) pbn_n_neg(rp, rp, n);
}

static void pbz_bitop(pbz_ptr r, pbz_srcptr a, pbz_srcptr b, int op) {
    pbn_size an = PBN_ABS(SIZ(a)), bn = PBN_ABS(SIZ(b)), n, i, total;
    int aneg = SIZ(a) < 0, bneg = SIZ(b) < 0, rneg;
    pbn_limb *tp, *ta, *tb, *rp;
    PBN_TMP_DECL(tbuf);

    if (!aneg && !bneg) {
        /* both non-negative: no two's complement needed */
        const pbn_limb *ap, *bp;
        if (an < bn) {
            pbz_srcptr x = a; a = b; b = x;
            n = an; an = bn; bn = n;
        }
        if (op == PBN_AND) {
            rp = PBZ_GROW(r, bn);
            ap = PTR(a); bp = PTR(b);
            for (i = 0; i < bn; i++) rp[i] = ap[i] & bp[i];
            n = bn;
        } else {
            rp = PBZ_GROW(r, an);
            ap = PTR(a); bp = PTR(b);
            if (op == PBN_IOR) for (i = 0; i < bn; i++) rp[i] = ap[i] | bp[i];
            else               for (i = 0; i < bn; i++) rp[i] = ap[i] ^ bp[i];
            pbn_n_copy(rp + bn, ap + bn, an - bn);
            n = an;
        }
        PBN_NORM(rp, n);
        SIZ(r) = (int)n;
        return;
    }

    n = PBN_MAX(an, bn) + 1;
    total = 2 * n;
    tp = PBN_TMP_GET(tbuf, total);
    ta = tp;
    tb = tp + n;
    rneg = op == PBN_AND ? (aneg & bneg) : op == PBN_IOR ? (aneg | bneg) : (aneg ^ bneg);
    pbn_tc(ta, a, n);
    pbn_tc(tb, b, n);
    switch (op) {
        case PBN_AND: for (i = 0; i < n; i++) ta[i] &= tb[i]; break;
        case PBN_IOR: for (i = 0; i < n; i++) ta[i] |= tb[i]; break;
        default:      for (i = 0; i < n; i++) ta[i] ^= tb[i]; break;
    }
    if (rneg) pbn_n_neg(ta, ta, n);
    PBN_NORM(ta, n);
    rp = PBZ_GROW(r, n);
    pbn_n_copy(rp, ta, n);
    SIZ(r) = (int)(rneg ? -n : n);
    PBN_TMP_PUT(tbuf, tp, total);
}

PBN_DEF void pbz_and(pbz_ptr r, pbz_srcptr a, pbz_srcptr b) { pbz_bitop(r, a, b, PBN_AND); }
PBN_DEF void pbz_ior(pbz_ptr r, pbz_srcptr a, pbz_srcptr b) { pbz_bitop(r, a, b, PBN_IOR); }
PBN_DEF void pbz_xor(pbz_ptr r, pbz_srcptr a, pbz_srcptr b) { pbz_bitop(r, a, b, PBN_XOR); }

PBN_DEF void pbz_com(pbz_ptr r, pbz_srcptr a) {
    pbz_add_ui(r, a, 1);
    SIZ(r) = -SIZ(r);
}

PBN_DEF pbn_bitcnt pbz_popcount(pbz_srcptr a) {
    pbn_size n = SIZ(a), i;
    pbn_bitcnt c = 0;
    if (n < 0) return ~(pbn_bitcnt)0;
    for (i = 0; i < n; i++) c += (pbn_bitcnt)pbn_popcount_limb(PTR(a)[i]);
    return c;
}

PBN_DEF int pbz_tstbit(pbz_srcptr a, pbn_bitcnt k) {
    pbn_size an = PBN_ABS(SIZ(a)), li = (pbn_size)(k / PBN_B), z = 0;
    unsigned bi = (unsigned)(k % PBN_B);
    int bit;
    if (li >= an) return SIZ(a) < 0;
    bit = (int)((PTR(a)[li] >> bi) & 1);
    if (SIZ(a) >= 0) return bit;
    /* two's complement of -m: find lowest set bit of m */
    while (PTR(a)[z] == 0) z++;
    if (li < z) return 0;
    if (li > z) return !bit;
    {
        unsigned lb = (unsigned)pbn_ctz(PTR(a)[z]);
        if (bi < lb) return 0;
        if (bi == lb) return 1;
        return !bit;
    }
}

static void pbz_addbit(pbz_ptr a, pbn_bitcnt k, int sub) {
    pbz_t t;
    pbz_init(t);
    pbz_set_ui(t, 1);
    pbz_mul_2exp(t, t, k);
    if (sub) pbz_sub(a, a, t); else pbz_add(a, a, t);
    pbz_clear(t);
}

PBN_DEF void pbz_setbit(pbz_ptr a, pbn_bitcnt k) { if (!pbz_tstbit(a, k)) pbz_addbit(a, k, 0); }
PBN_DEF void pbz_clrbit(pbz_ptr a, pbn_bitcnt k) { if (pbz_tstbit(a, k)) pbz_addbit(a, k, 1); }
PBN_DEF void pbz_combit(pbz_ptr a, pbn_bitcnt k) { pbz_addbit(a, k, pbz_tstbit(a, k)); }

/* ---- powers ---- */

PBN_DEF void pbz_pow_ui(pbz_ptr r, pbz_srcptr b, unsigned long e) {
    pbn_size bs = SIZ(b), bn = PBN_ABS(bs), zl = 0, on, pn, tn, cap, total, rn, sl;
    pbn_bitcnt tz, ob, shift;
    pbn_limb *buf, *op, *p, *t, *rp;
    unsigned sb;
    int neg = bs < 0 && (e & 1), i;
    PBN_TMP_DECL(pb);

    if (e == 0) { pbz_set_ui(r, 1); return; }
    if (bn == 0) { SIZ(r) = 0; return; }

    /* b = o * 2^tz with o odd: b^e = o^e * 2^(tz e) */
    while (PTR(b)[zl] == 0) zl++;
    tz = (pbn_bitcnt)zl * PBN_B + (pbn_bitcnt)pbn_ctz(PTR(b)[zl]);
    on = bn - zl;
#define PBN_BITCNT_HALF ((pbn_bitcnt)~(pbn_bitcnt)0 >> (sizeof(pbn_bitcnt) * CHAR_BIT / 2))
    /* overflow checks: a division only when the operands aren't small */
    if ((tz | (pbn_bitcnt)e) > PBN_BITCNT_HALF && tz && e > (~(pbn_bitcnt)0) / tz) PBN_ABORT("number too large");
    shift = tz * (pbn_bitcnt)e;

    /* o^e has at most ob * e bits */
    {
        pbn_limb top = PTR(b)[bn - 1];
        ob = (pbn_bitcnt)(bn - 1) * PBN_B + (pbn_bitcnt)(PBN_B - pbn_clz(top)) - tz;
    }
    if ((ob | (pbn_bitcnt)e) > PBN_BITCNT_HALF / 4 && e > (~(pbn_bitcnt)0 - 2 * PBN_B) / ob) PBN_ABORT("number too large");
    cap = (pbn_size)(ob * (pbn_bitcnt)e / PBN_B) + 2;
    total = on + 2 * cap;
    buf = PBN_TMP_GET(pb, total);
    op = buf;
    p = op + on;
    t = p + cap;

    if (tz % PBN_B) pbn_n_rshift(op, PTR(b) + zl, on, (unsigned)(tz % PBN_B));
    else            pbn_n_copy(op, PTR(b) + zl, on);
    PBN_NORM(op, on);

    /* o^e, left to right */
    pbn_n_copy(p, op, on);
    pn = on;
    if (!(on == 1 && op[0] == 1)) {
        for (i = 0; (e >> i) > 1; i++) ;          /* i = index of the top bit */
        for (i--; i >= 0; i--) {
            pbn_limb *x;
            if (pn == 1) {
                pbn_limb hi;
                p[0] = pbn_umul(p[0], p[0], &hi);
                if (hi) p[pn++] = hi;
            } else {
                pbn_n_sqr(t, p, pn);
                tn = 2 * pn;
                PBN_NORM(t, tn);
                x = p; p = t; t = x; pn = tn;
            }
            if ((e >> i) & 1) {
                if (on == 1) {
                    pbn_limb cy = pbn_n_mul_1(p, p, pn, op[0]);
                    if (cy) p[pn++] = cy;
                } else {
                    pbn_n_mul(t, p, pn, op, on);
                    tn = pn + on;
                    PBN_NORM(t, tn);
                    x = p; p = t; t = x; pn = tn;
                }
            }
        }
    }

    /* r = o^e * 2^(tz e) */
    sl = (pbn_size)(shift / PBN_B);
    sb = (unsigned)(shift % PBN_B);
    rn = pn + sl + 1;
    rp = PBZ_GROW(r, rn);
    if (sb) rp[pn + sl] = pbn_n_lshift(rp + sl, p, pn, sb);
    else { pbn_n_copy(rp + sl, p, pn); rp[pn + sl] = 0; }
    pbn_n_zero(rp, sl);
    PBN_NORM(rp, rn);
    SIZ(r) = (int)(neg ? -rn : rn);
    PBN_TMP_PUT(pb, buf, total);
}

PBN_DEF void pbz_ui_pow_ui(pbz_ptr r, unsigned long b, unsigned long e) {
    PBZ_TMP_UL(t, b);
    pbz_pow_ui(r, t, e);
}

/* -m^{-1} mod B, m odd */
static pbn_limb pbn_binvert_neg(pbn_limb m) {
    pbn_limb x = m;
    int i;
    for (i = 0; i < 5; i++) x *= 2 - m * x;
    return (pbn_limb)0 - x;
}

/* Montgomery reduction: rp = tp * B^-n mod m, tp (2n limbs) destroyed */
static void pbn_n_redc(pbn_limb *rp, pbn_limb *tp, const pbn_limb *mp, pbn_size n, pbn_limb minv) {
    pbn_size i;
    pbn_limb cy;
    for (i = 0; i < n; i++) {
        pbn_limb q = tp[i] * minv;
        tp[i] = pbn_n_addmul_1(tp + i, mp, n, q);
    }
    cy = pbn_n_add_n(rp, tp + n, tp, n);
    if (cy || pbn_n_cmp(rp, mp, n) >= 0) pbn_n_sub_n(rp, rp, mp, n);
}

#define PBN_GETBIT(p, i) ((int)(((p)[(i) / PBN_B] >> ((i) % PBN_B)) & 1))

static void pbz_powm_odd(pbz_ptr r, pbz_srcptr base, pbz_srcptr e, pbz_srcptr m) {
    pbn_size n = SIZ(m), tsize, i;
    const pbn_limb *mp = PTR(m), *ep = PTR(e);
    pbn_limb minv = pbn_binvert_neg(mp[0]), *tbl, *tp, *x, *rp;
    pbn_bitcnt ebits = pbz_bitlen(e);
    long bi;
    int k, first = 1;
    pbz_t t;

    k = ebits <= 7 ? 1 : ebits <= 36 ? 3 : ebits <= 140 ? 4 : ebits <= 450 ? 5 : 6;
    tsize = (pbn_size)1 << (k - 1);
    tbl = PBN_TMP_ALLOC(tsize * n + 3 * n);
    tp = tbl + tsize * n;
    x = tp + 2 * n;

    /* tbl[0] = base * B^n mod m */
    pbz_init(t);
    pbz_mul_2exp(t, base, (pbn_bitcnt)n * PBN_B);
    pbz_tdiv_r(t, t, m);
    pbn_n_copy(tbl, PTR(t), SIZ(t));
    pbn_n_zero(tbl + SIZ(t), n - SIZ(t));
    pbz_clear(t);

    if (tsize > 1) {
        /* x = base^2 (Montgomery), tbl[i] = tbl[i-1] * x */
        pbn_n_sqr(tp, tbl, n);
        pbn_n_redc(x, tp, mp, n, minv);
        for (i = 1; i < tsize; i++) {
            pbn_n_mul(tp, tbl + (i - 1) * n, n, x, n);
            pbn_n_redc(tbl + i * n, tp, mp, n, minv);
        }
    }

    bi = (long)ebits - 1;
    while (bi >= 0) {
        long j, s;
        unsigned w;
        if (!PBN_GETBIT(ep, (pbn_bitcnt)bi)) {
            pbn_n_sqr(tp, x, n);
            pbn_n_redc(x, tp, mp, n, minv);
            bi--;
            continue;
        }
        j = bi - k + 1;
        if (j < 0) j = 0;
        while (!PBN_GETBIT(ep, (pbn_bitcnt)j)) j++;
        w = 0;
        for (s = bi; s >= j; s--) w = (w << 1) | (unsigned)PBN_GETBIT(ep, (pbn_bitcnt)s);
        if (first) {
            pbn_n_copy(x, tbl + (w >> 1) * n, n);
            first = 0;
        } else {
            for (s = 0; s < bi - j + 1; s++) {
                pbn_n_sqr(tp, x, n);
                pbn_n_redc(x, tp, mp, n, minv);
            }
            pbn_n_mul(tp, x, n, tbl + (w >> 1) * n, n);
            pbn_n_redc(x, tp, mp, n, minv);
        }
        bi = j - 1;
    }

    /* leave Montgomery form */
    pbn_n_copy(tp, x, n);
    pbn_n_zero(tp + n, n);
    rp = PBZ_GROW(r, n);
    pbn_n_redc(rp, tp, mp, n, minv);
    PBN_NORM(rp, n);
    SIZ(r) = (int)n;
    PBN_TMP_FREE(tbl, tsize * PBN_ABS(SIZ(m)) + 3 * PBN_ABS(SIZ(m)));
}

static void pbz_powm_even(pbz_ptr r, pbz_srcptr base, pbz_srcptr e, pbz_srcptr m) {
    pbn_bitcnt ebits = pbz_bitlen(e);
    long i;
    pbz_t x;
    pbz_init_set(x, base);
    for (i = (long)ebits - 2; i >= 0; i--) {
        pbz_mul(x, x, x);
        pbz_tdiv_r(x, x, m);
        if (PBN_GETBIT(PTR(e), (pbn_bitcnt)i)) {
            pbz_mul(x, x, base);
            pbz_tdiv_r(x, x, m);
        }
    }
    pbz_swap(r, x);
    pbz_clear(x);
}

/* ---- powm for odd moduli of 1 or 2 limbs (Arturo's usual case): Montgomery products
        written out (CIOS), no allocation at all ---- */

/* a b / B mod m (a, b < m) */
PBN_INLINE pbn_limb pbn_mont1(pbn_limb a, pbn_limb b, pbn_limb m, pbn_limb minv) {
    pbn_limb hi, lo = pbn_umul(a, b, &hi), h2, r, c;
    pbn_umul(lo * minv, m, &h2);
    r = hi + h2;               /* (ab + qm) / B, the low halves adding up to 0 or B */
    c = r < hi;
    r += lo != 0;
    c |= r < (pbn_limb)(lo != 0);
    return c || r >= m ? r - m : r;
}

/* {r, 2} = a b / B^2 mod m (a, b < m); a*b + c + d never exceeds two limbs */
PBN_INLINE void pbn_mont2(pbn_limb *r, const pbn_limb *a, const pbn_limb *b, const pbn_limb *m, pbn_limb minv) {
    pbn_limb t0, t1, t2, t3, t4, hi, lo, c, q;
    t0 = pbn_umul(a[0], b[0], &c);
    lo = pbn_umul(a[0], b[1], &hi); t1 = lo + c; t2 = hi + (t1 < lo);
    q = t0 * minv;
    lo = pbn_umul(q, m[0], &hi); t0 += lo; c = hi + (t0 < lo);
    lo = pbn_umul(q, m[1], &hi); lo += c; hi += lo < c; t1 += lo; hi += t1 < lo;
    t2 += hi; t3 = t2 < hi;
    /* (t1, t2, t3): one limb down */
    lo = pbn_umul(a[1], b[0], &hi); t1 += lo; c = hi + (t1 < lo);
    lo = pbn_umul(a[1], b[1], &hi); lo += c; hi += lo < c; t2 += lo; hi += t2 < lo;
    t3 += hi; t4 = t3 < hi;     /* (with m close to B^2, this can carry already) */
    q = t1 * minv;
    lo = pbn_umul(q, m[0], &hi); t1 += lo; c = hi + (t1 < lo);
    lo = pbn_umul(q, m[1], &hi); lo += c; hi += lo < c; t2 += lo; hi += t2 < lo;
    t3 += hi; c = t4 + (t3 < hi);
    /* (t2, t3, c) < 2m */
    if (c || t3 > m[1] || (t3 == m[1] && t2 >= m[0])) {
        pbn_limb bw = t2 < m[0];
        t2 -= m[0];
        t3 = t3 - m[1] - bw;
    }
    r[0] = t2;
    r[1] = t3;
}

#define PBN_MONT(x, y, z) do {                                                      \
        if (n == 1) (x)[0] = pbn_mont1((y)[0], (z)[0], mp[0], minv);                \
        else pbn_mont2((x), (y), (z), mp, minv);                                    \
    } while (0)

/* r = b^e mod m, m odd with n = 1 or 2 limbs (and > 1), e > 0 */
static void pbz_powm_small(pbz_ptr r, pbz_srcptr b, pbz_srcptr e, const pbn_limb *mp, pbn_size n) {
    pbn_limb minv = pbn_binvert_neg(mp[0]), x[2] = { 0, 0 }, t[2], tbl[8][2], q[4], num[4] = { 0, 0, 0, 0 };
    const pbn_limb *ep = PTR(e);
    pbn_size bn = PBN_ABS(SIZ(b)), i;
    pbn_bitcnt ebits = pbz_bitlen(e);
    long bi;
    int k, first = 1;

    /* the base, reduced (b mod m, then m - that for b < 0) */
    if (bn > n || (bn == n && pbn_n_cmp(PTR(b), mp, n) >= 0)) {
        pbn_limb *qq = PBN_TMP_ALLOC(bn - n + 1);
        pbn_n_tdiv_qr(qq, t, PTR(b), bn, mp, n);
        PBN_TMP_FREE(qq, bn - n + 1);
    } else {
        t[1] = 0;
        pbn_n_copy(t, PTR(b), bn);
        if (bn < 2) t[1] = 0;
        if (bn == 0) t[0] = 0;
    }
    if (n == 1) t[1] = 0;
    if (t[0] == 0 && t[1] == 0) { SIZ(r) = 0; return; }
    if (SIZ(b) < 0) pbn_n_sub_n(t, mp, t, n);

    /* into Montgomery form: t B^n mod m */
    pbn_n_copy(num + n, t, n);
    {
        pbn_size nn = 2 * n;
        PBN_NORM(num, nn);
        pbn_n_tdiv_qr(q, tbl[0], num, nn, mp, n);
    }

    k = ebits <= 7 ? 1 : ebits <= 24 ? 2 : ebits <= 80 ? 3 : 4;
    if (k > 1) {
        PBN_MONT(x, tbl[0], tbl[0]);
        for (i = 1; i < ((pbn_size)1 << (k - 1)); i++) PBN_MONT(tbl[i], tbl[i - 1], x);
    }

    bi = (long)ebits - 1;
    while (bi >= 0) {
        long j, s;
        unsigned w;
        if (!PBN_GETBIT(ep, (pbn_bitcnt)bi)) {
            PBN_MONT(x, x, x);
            bi--;
            continue;
        }
        j = bi - k + 1;
        if (j < 0) j = 0;
        while (!PBN_GETBIT(ep, (pbn_bitcnt)j)) j++;
        w = 0;
        for (s = bi; s >= j; s--) w = (w << 1) | (unsigned)PBN_GETBIT(ep, (pbn_bitcnt)s);
        if (first) {
            x[0] = tbl[w >> 1][0];
            x[1] = tbl[w >> 1][1];
            first = 0;
        } else {
            for (s = 0; s < bi - j + 1; s++) PBN_MONT(x, x, x);
            PBN_MONT(x, x, tbl[w >> 1]);
        }
        bi = j - 1;
    }

    /* out of Montgomery form: x * 1 / B^n */
    t[0] = 1;
    t[1] = 0;
    PBN_MONT(x, x, t);
    {
        pbn_limb *rp = PBZ_GROW(r, n);
        pbn_size rn = n;
        pbn_n_copy(rp, x, n);
        PBN_NORM(rp, rn);
        SIZ(r) = (int)rn;
    }
}
#undef PBN_MONT

PBN_DEF void pbz_powm(pbz_ptr r, pbz_srcptr b, pbz_srcptr e, pbz_srcptr m) {
    pbz_t base, mm, ee;
    if (SIZ(m) == 0) pbn_divzero();
    {
        /* small odd moduli, e > 0: straight to the limbs (no temporaries) */
        pbn_size n = PBN_ABS(SIZ(m));
        if (n <= 2 && SIZ(e) > 0 && (PTR(m)[0] & 1) && (n == 2 || PTR(m)[0] > 1)) {
            pbz_powm_small(r, b, e, PTR(m), n);
            return;
        }
    }
    pbz_init(base);
    pbz_init(mm);
    pbz_abs(mm, m);
    pbz_init(ee);
    pbz_abs(ee, e);
    if (SIZ(e) < 0) {
        if (!pbz_invert(base, b, mm)) pbn_divzero();
    } else {
        pbz_mod(base, b, mm);
    }
    if (SIZ(mm) == 1 && PTR(mm)[0] == 1) {
        SIZ(r) = 0;
    } else if (SIZ(ee) == 0) {
        pbz_set_ui(r, 1);
    } else if (SIZ(base) == 0) {
        SIZ(r) = 0;
    } else if (PTR(mm)[0] & 1) {
        pbz_powm_odd(r, base, ee, mm);
    } else {
        pbz_powm_even(r, base, ee, mm);
    }
    pbz_clears(base, mm, ee, (pbz_ptr)NULL);
}

PBN_DEF void pbz_powm_ui(pbz_ptr r, pbz_srcptr b, unsigned long e, pbz_srcptr m) {
    PBZ_TMP_UL(t, e);
    pbz_powm(r, b, t, m);
}

/* ---- roots ---- */

/* floor(sqrt(v)) of a single limb */
static pbn_limb pbn_sqrt_limb(pbn_limb v) {
    pbn_limb q = (pbn_limb)sqrt((double)v), hi, lo;
    for (;;) {   /* too big? */
        lo = pbn_umul(q, q, &hi);
        if (hi || lo > v) q--; else break;
    }
    for (;;) {   /* too small? */
        if (q + 1 == 0) break;
        lo = pbn_umul(q + 1, q + 1, &hi);
        if (!hi && lo <= v) q++; else break;
    }
    return q;
}

/* ---- square root: Zimmermann's "Karatsuba square root", directly on limbs
        (Brent & Zimmermann, Modern Computer Arithmetic, Algorithm 1.12) ---- */

/* approximately (dh:dl) / (2s), clamped well below 2^(B-1) (only ever small in practice) */
static pbn_limb pbn_sqrt_corr(pbn_limb dh, pbn_limb dl, pbn_limb s) {
    double q = (ldexp((double)dh, PBN_B) + (double)dl) / (2.0 * (double)s);
    double cap = ldexp(1.0, PBN_B - 2);
    return q < cap ? (pbn_limb)q : (pbn_limb)cap;
}

/* root of a normalized 2-limb number a1:a0 (a1 >= B/4); the remainder a - s^2 <= 2s
   goes to *rhi:*rlo (*rhi is 0 or 1) */
static pbn_limb pbn_sqrtrem2(pbn_limb *rlo, pbn_limb *rhi, pbn_limb a1, pbn_limb a0) {
    pbn_limb s, hi, lo, dh, dl, q;
    double est = sqrt(ldexp((double)a1, PBN_B) + (double)a0);
    /* estimate (good to ~2^12 with 64-bit limbs; correctness doesn't depend on it) */
    s = est >= ldexp(1.0, PBN_B) ? PBN_LIMB_MAX : (pbn_limb)est;
    if (s < PBN_HIGHBIT) s = PBN_HIGHBIT;
    /* one Newton correction: s += (a - s^2) / (2s); |a - s^2| is small here, and an
       approximate (floating-point) quotient is enough: the adjustment below is exact */
    lo = pbn_umul(s, s, &hi);
    if (hi > a1 || (hi == a1 && lo > a0)) {
        dl = lo - a0;
        dh = hi - a1 - (lo < a0);
        q = pbn_sqrt_corr(dh, dl, s);
        s = s - q < PBN_HIGHBIT || s - q > s ? PBN_HIGHBIT : s - q;
    } else {
        dl = a0 - lo;
        dh = a1 - hi - (a0 < lo);
        q = pbn_sqrt_corr(dh, dl, s);
        s = s + q < s ? PBN_LIMB_MAX : s + q;
    }
    /* exact adjustment (a couple of steps at most) */
    for (;;) {
        lo = pbn_umul(s, s, &hi);
        if (hi > a1 || (hi == a1 && lo > a0)) s--; else break;
    }
    while (s != PBN_LIMB_MAX) {
        pbn_limb s1 = s + 1;
        lo = pbn_umul(s1, s1, &hi);
        if (hi < a1 || (hi == a1 && lo <= a0)) s = s1; else break;
    }
    lo = pbn_umul(s, s, &hi);
    *rlo = a0 - lo;
    *rhi = a1 - hi - (a0 < lo);
    return s;
}

/* sp[0..n) = floor(sqrt(a)), rp[0..n) = low limbs of a - s^2 (the high limb, 0 or 1,
   is returned), for a normalized 2n-limb a (ap[2n-1] >= B/4).
   tp: scratch of PBN_SQRT_ITCH(n) limbs; nothing may overlap */
#define PBN_SQRT_ITCH(n) (4 * (n) + 64)

static pbn_limb pbn_n_sqrtrem(pbn_limb *sp, pbn_limb *rp, const pbn_limb *ap, pbn_size n, pbn_limb *tp) {
    pbn_size l, h;
    pbn_limb *x, *qp, *q2, rc, lb, uc, sc = 0;
    int hi;

    if (n == 1) {
        pbn_limb rh;
        sp[0] = pbn_sqrtrem2(&rp[0], &rh, ap[1], ap[0]);
        return rh;
    }

    /* a = ahi*B^(2l) + a1*B^l + a0, with ahi of 2h limbs (h >= l) */
    l = n / 2;
    h = n - l;
    x = tp;
    qp = x + n;
    q2 = qp + l + 1;

    /* (s1, r1) = sqrtrem(ahi): s1 -> sp[l..n), r1 -> rp[l..n) + rc */
    rc = pbn_n_sqrtrem(sp + l, rp + l, ap + 2 * l, h, tp);    /* tp isn't live yet */

    /* (q, u) = divrem(r1*B^l + a1, 2*s1), computed as (X >> 1) / s1:
       q = floor(X/(2 s1)) = floor(floor(X/2)/s1), u = 2*(X/2 mod s1) + (X & 1) */
    pbn_n_copy(x, ap + l, l);
    pbn_n_copy(x + l, rp + l, h);
    lb = x[0] & 1;
    pbn_n_rshift(x, x, n, 1);
    x[n - 1] |= rc << (PBN_B - 1);
    pbn_n_tdiv_qr(qp, rp + l, x, n, sp + l, h);           /* qp: l+1 limbs, R: h limbs */
    uc = pbn_n_lshift(rp + l, rp + l, h, 1);
    rp[l] |= lb;

    /* s = s1*B^l + q, where q <= B^l; s may come out as B^n (sc = 1, sp = 0),
       which is always too big: the correction below brings it back */
    pbn_n_copy(sp, qp, l);
    if (qp[l]) sc = pbn_n_add_1(sp + l, sp + l, h, 1);

    /* r = u*B^l + a0 - q^2 */
    pbn_n_copy(rp, ap, l);
    hi = (int)uc;
    if (qp[l]) {
        /* q = B^l: q^2 = B^(2l) */
        if (2 * l < n) hi -= (int)pbn_n_sub_1(rp + 2 * l, rp + 2 * l, n - 2 * l, 1);
        else           hi -= 1;
    } else {
        pbn_n_sqr(q2, qp, l);
        hi -= (int)pbn_n_sub(rp, rp, n, q2, 2 * l);
    }

    /* at most one correction: r += 2s - 1, s -= 1 */
    if (hi < 0) {
        hi += 2 * (int)sc;
        hi += (int)pbn_n_add_n(rp, rp, sp, n);
        hi += (int)pbn_n_add_n(rp, rp, sp, n);
        hi -= (int)pbn_n_sub_1(rp, rp, n, 1);
        pbn_n_sub_1(sp, sp, n, 1);
    }
    return (pbn_limb)hi;
}

PBN_DEF void pbz_sqrtrem(pbz_ptr s, pbz_ptr r, pbz_srcptr x) {
    pbn_size xn = SIZ(x), N, t, sn, rn, total;
    pbn_limb *buf, *ap, *sp, *rp, *tp, *xc, rh;
    unsigned k, sh;
    PBN_TMP_DECL(tb);

    if (xn < 0) PBN_ABORT("square root of negative number");
    if (xn == 0) {
        if (s) SIZ(s) = 0;
        if (r) SIZ(r) = 0;
        return;
    }
    if (xn == 1) {
        pbn_limb v = PTR(x)[0], q = pbn_sqrt_limb(v);
        if (r) { pbn_limb *o = PBZ_GROW(r, 1); o[0] = v - q * q; SIZ(r) = o[0] != 0; }
        if (s) { pbn_limb *o = PBZ_GROW(s, 1); o[0] = q; SIZ(s) = 1; }
        return;
    }

    /* normalize: a = x * 4^k * B^t, with an even number of limbs (2N) and ap[2N-1] >= B/4 */
    N = (xn + 1) / 2;
    t = 2 * N - xn;
    k = (unsigned)pbn_clz(PTR(x)[xn - 1]) / 2;
    sh = k + (unsigned)t * (PBN_B / 2);                    /* root of x = root of a >> sh */

    total = 2 * N + N + N + PBN_SQRT_ITCH(N) + (sh ? xn : 0);
    buf = PBN_TMP_GET(tb, total);
    ap = buf;
    sp = ap + 2 * N;
    rp = sp + N;
    tp = rp + N;
    xc = tp + PBN_SQRT_ITCH(N);

    if (t) ap[0] = 0;
    pbn_n_copy(ap + t, PTR(x), xn);
    if (sh) pbn_n_copy(xc, PTR(x), xn);                    /* x may alias s or r */
    if (k) pbn_n_lshift(ap, ap, 2 * N, 2 * k);

    rh = pbn_n_sqrtrem(sp, rp, ap, N, tp);

    sn = N;
    if (sh) {
        pbn_n_rshift(sp, sp, N, sh);
        PBN_NORM(sp, sn);
    }

    if (r) {
        pbn_limb *o;
        if (!sh) {
            rn = N;
            o = PBZ_GROW(r, N + 1);
            pbn_n_copy(o, rp, N);
            if (rh) o[rn++] = 1;
        } else {
            /* r = x - s^2 (s^2 <= x, at most xn limbs once normalized) */
            pbn_limb *s2 = ap;                              /* 2N >= 2*sn limbs, free now */
            pbn_size s2n = 2 * sn;
            pbn_n_sqr(s2, sp, sn);
            PBN_NORM(s2, s2n);
            o = PBZ_GROW(r, xn);
            pbn_n_sub(o, xc, xn, s2, s2n);
            rn = xn;
        }
        PBN_NORM(o, rn);
        SIZ(r) = (int)rn;
    }
    if (s) {
        pbn_limb *o = PBZ_GROW(s, sn);
        pbn_n_copy(o, sp, sn);
        SIZ(s) = (int)sn;
    }
    PBN_TMP_PUT(tb, buf, total);
}

PBN_DEF void pbz_sqrt(pbz_ptr r, pbz_srcptr x) { pbz_sqrtrem(r, NULL, x); }

PBN_DEF int pbz_perfect_square_p(pbz_srcptr x) {
    pbz_t r;
    int res;
    if (SIZ(x) < 0) return 0;
    if (SIZ(x) == 0) return 1;
    pbz_init(r);
    pbz_sqrtrem(NULL, r, x);
    res = SIZ(r) == 0;
    pbz_clear(r);
    return res;
}

/* ---- gcd & friends ---- */

static pbn_limb pbn_gcd_limb(pbn_limb a, pbn_limb b) {
    int s;
    if (!a) return b;
    if (!b) return a;
    s = pbn_ctz(a | b);
    a >>= pbn_ctz(a);
    b >>= pbn_ctz(b);
    /* both odd: (a, b) <- (min, |a - b| >> ctz); ctz(a - b) == ctz(|a - b|), so the count
       doesn't wait for the min/abs selection */
    while (a != b) {
        pbn_limb d = a - b, lo = a < b ? a : b;
        int z = pbn_ctz(d);
        b = (a < b ? b - a : d) >> z;
        a = lo;
    }
    return a << s;
}

static uint64_t pbn_gcd_u64(uint64_t a, uint64_t b) {
    int sh;
    if (!a) return b;
    if (!b) return a;
    sh = 0;
    while (!((a | b) & 1)) { a >>= 1; b >>= 1; sh++; }
    while (!(a & 1)) a >>= 1;
    do {
        while (!(b & 1)) b >>= 1;
        if (a > b) { uint64_t t = a; a = b; b = t; }
        b -= a;
    } while (b);
    return a << sh;
}

/* bits [shift, shift + 64) of an n-limb number */
static uint64_t pbn_getbits64(const pbn_limb *p, pbn_size n, pbn_bitcnt shift) {
    pbn_size li = (pbn_size)(shift / PBN_B);
    unsigned bi = (unsigned)(shift % PBN_B);
    uint64_t r = 0;
    int got = 0;
    while (got < 64 && li < n) {
        r |= (uint64_t)(p[li] >> bi) << got;
        got += (int)(PBN_B - bi);
        bi = 0;
        li++;
    }
    return r;
}

/* rp = |x*a - y*b| style 2x2 update helper: rp[0..n) = xa - yb where result >= 0 */
static void pbn_lin2(pbn_limb *rp, pbn_limb x, const pbn_limb *ap, pbn_limb y, const pbn_limb *bp, pbn_size n) {
    pbn_n_mul_1(rp, ap, n, x);
    pbn_n_submul_1(rp, bp, n, y);
}

#define PBN_LEHMER_BITS (PBN_B - 2)

#if PBN_B == 64 && defined(__SIZEOF_INT128__) && !defined(PBN_PORTABLE)
#  define PBN_LEHMER2 1
typedef __int128 pbn_sdlimb;
#  define PBN_LEHMER2_MAXE ((int64_t)1 << 62)    /* bound on the cofactors of a double-word step */
#  ifndef PBN_GCD_LEHMER2_THRESHOLD
#    define PBN_GCD_LEHMER2_THRESHOLD 100         /* limbs: double-word steps from here on */
#  endif

/* floor(n / d) for 0 <= n, 0 < d: by subtraction when small (the usual case), else from a
   floating-point estimate, corrected; -1 if it's too big for a Lehmer step */
PBN_INLINE pbn_sdlimb pbn_lehmer_q(pbn_sdlimb n, pbn_sdlimb d) {
    pbn_sdlimb m = n, q;
    double e;
    if (m < d) return 0;
    m -= d; if (m < d) return 1;
    m -= d; if (m < d) return 2;
    m -= d; if (m < d) return 3;
    e = (double)n / (double)d;
    if (e > 1e15) return -1;
    q = (pbn_sdlimb)e;
    while (q * d > n) q--;
    while ((q + 1) * d <= n) q++;
    return q;
}

/* {na, nb}[0..n) = (x0 a - y0 b, x1 a - y1 b) in one pass (both results >= 0) */
static void pbn_lin2x2(pbn_limb *na, pbn_limb *nb, const pbn_limb *ap, const pbn_limb *bp, pbn_size n,
                       pbn_limb x0, pbn_limb y0, pbn_limb x1, pbn_limb y1, int swap0, int swap1) {
    pbn_limb c0p = 0, c0q = 0, c1p = 0, c1q = 0, w0 = 0, w1 = 0;
    pbn_size i;
    for (i = 0; i < n; i++) {
        pbn_limb a = ap[i], b = bp[i], u, v, lo;
        pbn_dlimb p0 = (pbn_dlimb)x0 * (swap0 ? b : a) + c0p, q0 = (pbn_dlimb)y0 * (swap0 ? a : b) + c0q;
        pbn_dlimb p1 = (pbn_dlimb)x1 * (swap1 ? b : a) + c1p, q1 = (pbn_dlimb)y1 * (swap1 ? a : b) + c1q;
        u = (pbn_limb)p0; v = (pbn_limb)q0;
        lo = u - v; c0p = (pbn_limb)(p0 >> 64); c0q = (pbn_limb)(q0 >> 64);
        na[i] = lo - w0; w0 = (u < v) + (lo < w0);
        u = (pbn_limb)p1; v = (pbn_limb)q1;
        lo = u - v; c1p = (pbn_limb)(p1 >> 64); c1q = (pbn_limb)(q1 >> 64);
        nb[i] = lo - w1; w1 = (u < v) + (lo < w1);
    }
}
#endif

/* One Lehmer step on a >= b (bn >= 2, abits = bits of a > 64): the cofactors (A B; C D) of
   (a, b) -> (A a + B b, C a + D b) from the leading digits (double-word from
   PBN_GCD_LEHMER2_THRESHOLD limbs). Returns 0 when the leading digits give no quotient */
static int pbn_lehmer_mat(const pbn_limb *ap, pbn_size an, const pbn_limb *bp, pbn_size bn, pbn_bitcnt abits,
                          int64_t *pA, int64_t *pB, int64_t *pC, int64_t *pD) {
    int64_t ah, bh, A, B, C, D;
#if defined(PBN_LEHMER2)
    if (abits > 128 && an >= PBN_GCD_LEHMER2_THRESHOLD) {
        /* double-word: the leading 126 bits, cofactors up to 2^62 (~63 bits per step) */
        pbn_bitcnt sh = abits - 126;
        pbn_sdlimb xa = (pbn_sdlimb)(((pbn_dlimb)pbn_getbits64(ap, an, sh + 64) << 64) | pbn_getbits64(ap, an, sh));
        pbn_sdlimb xb = (pbn_sdlimb)(((pbn_dlimb)pbn_getbits64(bp, bn, sh + 64) << 64) | pbn_getbits64(bp, bn, sh));
        int64_t a0 = 1, b0 = 0, c0 = 0, d0 = 1;
        for (;;) {
            pbn_sdlimb n1 = xa + a0, d1 = xb + c0, n2 = xa + b0, d2 = xb + d0, q, r2, tc, td;
            if (d1 <= 0 || d2 <= 0 || n1 < 0 || n2 < 0) break;
            q = pbn_lehmer_q(n1, d1);
            if (q < 0) break;
            r2 = n2 - q * d2;                 /* the other bound must give the same quotient */
            if (r2 < 0 || r2 >= d2) break;
            tc = (pbn_sdlimb)a0 - q * c0;
            td = (pbn_sdlimb)b0 - q * d0;
            if (tc >= PBN_LEHMER2_MAXE || tc <= -PBN_LEHMER2_MAXE || td >= PBN_LEHMER2_MAXE || td <= -PBN_LEHMER2_MAXE) break;
            a0 = c0; c0 = (int64_t)tc;
            b0 = d0; d0 = (int64_t)td;
            tc = xa - q * xb; xa = xb; xb = tc;
        }
        if (b0 != 0) { *pA = a0; *pB = b0; *pC = c0; *pD = d0; return 1; }
        /* no progress: try the single-word step */
    }
#endif
    (void)bn;
    ah = (int64_t)pbn_getbits64(ap, an, abits - PBN_LEHMER_BITS);
    bh = (int64_t)pbn_getbits64(bp, bn, abits - PBN_LEHMER_BITS);
    A = 1; B = 0; C = 0; D = 1;
    for (;;) {
        int64_t q, T, n1 = ah + A, d1 = bh + C, n2 = ah + B, d2 = bh + D;
        if (d1 <= 0 || d2 <= 0) break;
        /* quotient: by subtraction when small (the usual case) */
        T = n1 - d1;
        if (T < d1) q = n1 < d1 ? 0 : 1;
        else if ((T -= d1) < d1) q = 2;
        else if ((T -= d1) < d1) q = 3;
        else q = n1 / d1;
#if defined(PBN_LEHMER2)
        {   /* the other bound must give the same quotient (checked by multiplying) */
            pbn_sdlimb r2 = (pbn_sdlimb)n2 - (pbn_sdlimb)q * d2;
            if (r2 < 0 || r2 >= d2) break;
        }
#else
        if (q != n2 / d2) break;
#endif
        T = A - q * C; A = C; C = T;
        T = B - q * D; B = D; D = T;
        T = ah - q * bh; ah = bh; bh = T;
    }
    *pA = A; *pB = B; *pC = C; *pD = D;
    return B != 0;
}

/* gcd of two positive numbers given as limb arrays (both destroyed, an,bn >= 1,
   each buffer must hold max(an,bn)+1 limbs). *res points at the result, returns its size.
   tp: 2 (max(an,bn)+1) limbs */
static pbn_size pbn_n_gcd(pbn_limb **res, pbn_limb *ap, pbn_size an, pbn_limb *bp, pbn_size bn, pbn_limb *tp) {
    pbn_size cap = PBN_MAX(an, bn) + 1;
    pbn_limb *t0 = tp, *t1 = tp + cap;
    for (;;) {
        pbn_bitcnt abits;
        int64_t A, B, C, D;
        if (an < bn || (an == bn && pbn_n_cmp(ap, bp, an) < 0)) {
            pbn_limb *t = ap; pbn_size tn = an;
            ap = bp; an = bn; bp = t; bn = tn;
        }
        if (bn == 0) break;
        abits = (pbn_bitcnt)an * PBN_B - (pbn_bitcnt)pbn_clz(ap[an - 1]);
        if (abits <= 64) {
            uint64_t g = pbn_gcd_u64(pbn_getbits64(ap, an, 0), pbn_getbits64(bp, bn, 0));
            an = pbn_from_u64(ap, g);
            bn = 0;
            break;
        }
        if (bn == 1) {
            pbn_limb r = pbn_n_divrem_1(NULL, ap, an, bp[0]);
            ap[0] = (pbn_limb)pbn_gcd_u64(r, bp[0]);
            an = 1;
            break;
        }

        if (!pbn_lehmer_mat(ap, an, bp, bn, abits, &A, &B, &C, &D)) B = 0;

        if (B == 0) {
            /* no progress from the leading digits: one full division step (quotient in t1,
               remainder in t0, which becomes a) */
            pbn_limb *t;
            pbn_n_tdiv_qr(t1, t0, ap, an, bp, bn);
            t = ap; ap = t0; t0 = t;
            an = bn;
            PBN_NORM(ap, an);
        } else {
            /* (a, b) <- (A a + B b, C a + D b); A,B (and C,D) never share a strict sign */
            pbn_limb *t;
            pbn_n_zero(bp + bn, an - bn);
#if defined(PBN_LEHMER2)
            pbn_lin2x2(t0, t1, ap, bp, an,
                       (pbn_limb)(B <= 0 ? A : B), (pbn_limb)(B <= 0 ? -B : -A),
                       (pbn_limb)(D <= 0 ? C : D), (pbn_limb)(D <= 0 ? -D : -C),
                       B > 0, D > 0);
#else
            if (B <= 0) pbn_lin2(t0, (pbn_limb)A, ap, (pbn_limb)-B, bp, an);
            else        pbn_lin2(t0, (pbn_limb)B, bp, (pbn_limb)-A, ap, an);
            if (D <= 0) pbn_lin2(t1, (pbn_limb)C, ap, (pbn_limb)-D, bp, an);
            else        pbn_lin2(t1, (pbn_limb)D, bp, (pbn_limb)-C, ap, an);
#endif
            t = ap; ap = t0; t0 = t;
            t = bp; bp = t1; t1 = t;
            bn = an;
            PBN_NORM(ap, an);
            PBN_NORM(bp, bn);
        }
    }
    *res = ap;
    return an;
}

/* ---- subquadratic gcd: half-gcd, reducing from the leading halves recursively ----
   Any matrix T with det +-1 keeps the gcd when (a, b) <- T (a, b) leaves both >= 0; that is
   checked whenever a matrix found on truncated operands is applied to the full ones (one that
   fails is skipped and plain Lehmer steps take over), so a wrong result is impossible.
   T = s [[u0, -u1], [-u2, u3]] with every u_i >= 0 and s = +-1. */

#if defined(PBN_LEHMER2)
#  define PBN_HAVE_HGCD 1
#  ifndef PBN_GCD_HGCD_THRESHOLD
#    define PBN_GCD_HGCD_THRESHOLD 1000      /* limbs (of the smaller operand): half-gcd from here */
#  endif
#  ifndef PBN_HGCD_THRESHOLD
#    define PBN_HGCD_THRESHOLD 40            /* limbs: below, the half-gcd by Lehmer steps */
#  endif

typedef struct { pbz_t u[4]; int s; } pbn_hmat;

static void pbn_hmat_init(pbn_hmat *m) {
    int i;
    for (i = 0; i < 4; i++) pbz_init(m->u[i]);
    pbz_set_ui(m->u[0], 1);
    pbz_set_ui(m->u[3], 1);
    m->s = 1;
}

static void pbn_hmat_clear(pbn_hmat *m) {
    int i;
    for (i = 0; i < 4; i++) pbz_clear(m->u[i]);
}

/* r = x u + y v (limb factors, everything >= 0); r doesn't alias u, v or t */
static void pbn_hmat_lin(pbz_ptr r, pbn_limb x, pbz_srcptr u, pbn_limb y, pbz_srcptr v, pbz_ptr t) {
    pbz_mul_limb(r, u, x, 0);
    pbz_mul_limb(t, v, y, 0);
    pbz_add(r, r, t);
}

/* m <- S m, S the matrix of a Lehmer step (a, b) -> (A a + B b, C a + D b) */
static void pbn_hmat_step(pbn_hmat *m, int64_t A, int64_t B, int64_t C, int64_t D, pbz_ptr t, pbz_ptr n0, pbz_ptr n1) {
    pbn_limb x0, x1, x2, x3;
    if (B <= 0) { x0 = (pbn_limb)A;  x1 = (pbn_limb)-B; x2 = (pbn_limb)-C; x3 = (pbn_limb)D; }
    else        { x0 = (pbn_limb)-A; x1 = (pbn_limb)B;  x2 = (pbn_limb)C;  x3 = (pbn_limb)-D; m->s = -m->s; }
    pbn_hmat_lin(n0, x0, m->u[0], x1, m->u[2], t);
    pbn_hmat_lin(n1, x2, m->u[0], x3, m->u[2], t);
    pbz_swap(m->u[0], n0);
    pbz_swap(m->u[2], n1);
    pbn_hmat_lin(n0, x0, m->u[1], x1, m->u[3], t);
    pbn_hmat_lin(n1, x2, m->u[1], x3, m->u[3], t);
    pbz_swap(m->u[1], n0);
    pbz_swap(m->u[3], n1);
}

/* m <- S m for a division step (a, b) -> (b, a - q b) */
static void pbn_hmat_qstep(pbn_hmat *m, pbz_srcptr q) {
    pbz_addmul(m->u[0], q, m->u[2]);
    pbz_addmul(m->u[1], q, m->u[3]);
    pbz_swap(m->u[0], m->u[2]);
    pbz_swap(m->u[1], m->u[3]);
    m->s = -m->s;
}

/* m <- S m for swapping (a, b) */
static void pbn_hmat_swap(pbn_hmat *m) {
    pbz_swap(m->u[0], m->u[2]);
    pbz_swap(m->u[1], m->u[3]);
    m->s = -m->s;
}

/* m <- a m */
static void pbn_hmat_lmul(pbn_hmat *m, const pbn_hmat *a, pbz_ptr t) {
    pbz_t r[4];
    int i;
    for (i = 0; i < 4; i++) pbz_init(r[i]);
    pbz_mul(r[0], a->u[0], m->u[0]); pbz_mul(t, a->u[1], m->u[2]); pbz_add(r[0], r[0], t);
    pbz_mul(r[1], a->u[0], m->u[1]); pbz_mul(t, a->u[1], m->u[3]); pbz_add(r[1], r[1], t);
    pbz_mul(r[2], a->u[2], m->u[0]); pbz_mul(t, a->u[3], m->u[2]); pbz_add(r[2], r[2], t);
    pbz_mul(r[3], a->u[2], m->u[1]); pbz_mul(t, a->u[3], m->u[3]); pbz_add(r[3], r[3], t);
    for (i = 0; i < 4; i++) { pbz_swap(m->u[i], r[i]); pbz_clear(r[i]); }
    m->s *= a->s;
}

/* (a, b) <- T (a, b) if both results are >= 0 (returns 1), else leaves them (returns 0) */
static int pbn_hmat_apply(const pbn_hmat *m, pbz_ptr a, pbz_ptr b, pbz_ptr t0, pbz_ptr t1, pbz_ptr t2) {
    pbz_mul(t0, m->u[0], a); pbz_mul(t2, m->u[1], b); pbz_sub(t0, t0, t2);
    pbz_mul(t1, m->u[3], b); pbz_mul(t2, m->u[2], a); pbz_sub(t1, t1, t2);
    if (m->s < 0) { pbz_neg(t0, t0); pbz_neg(t1, t1); }
    if (SIZ(t0) < 0 || SIZ(t1) < 0) return 0;
    pbz_swap(a, t0);
    pbz_swap(b, t1);
    return 1;
}

/* (a, b) <- T (a, b) for a = ah' B^p + al, b = bh' B^p + bl, where (ah', bh') = T (ah, bh)
   was computed already (recursively): only the low parts need multiplying. Applied if both
   results are >= 0 (returns 1) */
static int pbn_hmat_adjust(const pbn_hmat *m, pbz_ptr a, pbz_ptr b, pbz_srcptr ah, pbz_srcptr bh, pbn_size p,
                           pbz_ptr t0, pbz_ptr t1, pbz_ptr t2) {
    pbz_t al, bl;
    int ok;
    pbz_init(al); pbz_init(bl);
    pbz_tdiv_r_2exp(al, a, (pbn_bitcnt)p * PBN_B);
    pbz_tdiv_r_2exp(bl, b, (pbn_bitcnt)p * PBN_B);
    pbz_mul(t0, m->u[0], al); pbz_mul(t2, m->u[1], bl); pbz_sub(t0, t0, t2);
    pbz_mul(t1, m->u[3], bl); pbz_mul(t2, m->u[2], al); pbz_sub(t1, t1, t2);
    if (m->s < 0) { pbz_neg(t0, t0); pbz_neg(t1, t1); }
    pbz_mul_2exp(t2, ah, (pbn_bitcnt)p * PBN_B); pbz_add(t0, t0, t2);
    pbz_mul_2exp(t2, bh, (pbn_bitcnt)p * PBN_B); pbz_add(t1, t1, t2);
    ok = SIZ(t0) >= 0 && SIZ(t1) >= 0;
    if (ok) {
        pbz_swap(a, t0);
        pbz_swap(b, t1);
    }
    pbz_clear(al); pbz_clear(bl);
    return ok;
}

/* Lehmer / division steps on a >= b > 0 while b has more than s limbs (into m if given) */
static void pbn_hgcd_base(pbz_ptr a, pbz_ptr b, pbn_size s, pbn_hmat *m, pbz_ptr t0, pbz_ptr t1, pbz_ptr t2) {
    while (SIZ(b) > s) {
        pbn_size an = SIZ(a), bn = SIZ(b);
        pbn_bitcnt abits = (pbn_bitcnt)an * PBN_B - (pbn_bitcnt)pbn_clz(PTR(a)[an - 1]);
        int64_t A, B, C, D;
        if (bn >= 2 && abits > 64 && pbn_lehmer_mat(PTR(a), an, PTR(b), bn, abits, &A, &B, &C, &D)) {
            pbn_limb *na = PBZ_GROW(t0, an), *nb = PBZ_GROW(t1, an), *bp = PBZ_GROW(b, an);
            pbn_size n0 = an, n1 = an;
            pbn_n_zero(bp + bn, an - bn);
            pbn_lin2x2(na, nb, PTR(a), bp, an,
                       (pbn_limb)(B <= 0 ? A : B), (pbn_limb)(B <= 0 ? -B : -A),
                       (pbn_limb)(D <= 0 ? C : D), (pbn_limb)(D <= 0 ? -D : -C),
                       B > 0, D > 0);
            PBN_NORM(na, n0);
            PBN_NORM(nb, n1);
            SIZ(t0) = (int)n0;
            SIZ(t1) = (int)n1;
            pbz_swap(a, t0);
            pbz_swap(b, t1);
            if (m) pbn_hmat_step(m, A, B, C, D, t2, t0, t1);
        } else {
            pbz_tdiv_qr(t2, t0, a, b);
            pbz_swap(a, b);
            pbz_swap(b, t0);
            if (m) pbn_hmat_qstep(m, t2);
        }
        if (pbz_cmp(a, b) < 0) {
            pbz_swap(a, b);
            if (m) pbn_hmat_swap(m);
        }
    }
}

/* reduces a >= b > 0 (n = size of a) until b has at most n/2 + 1 limbs; the transformation
   goes into m (new = T old) if given */
static void pbn_hgcd(pbz_ptr a, pbz_ptr b, pbn_hmat *m) {
    pbn_size n = SIZ(a), s = n / 2 + 1, k;
    pbz_t t0, t1, t2;
    if (SIZ(b) <= s) return;
    pbz_init(t0); pbz_init(t1); pbz_init(t2);
    if (n >= PBN_HGCD_THRESHOLD) {
        pbz_t ah, bh;
        pbn_hmat m1;
        pbz_init(ah); pbz_init(bh);
        for (k = 0; k < 2 && SIZ(b) > s; k++) {
            /* 1st pass: the leading n - n/2 limbs; 2nd: enough leading limbs to get down to s */
            pbn_size cur = SIZ(a), h = k == 0 ? n - n / 2 : 2 * (cur - s) + 2, p;
            if (h >= cur) break;
            p = cur - h;
            pbz_tdiv_q_2exp(ah, a, (pbn_bitcnt)p * PBN_B);
            pbz_tdiv_q_2exp(bh, b, (pbn_bitcnt)p * PBN_B);
            pbn_hmat_init(&m1);
            pbn_hgcd(ah, bh, &m1);
            if ((SIZ(m1.u[1]) || SIZ(m1.u[2])) && pbn_hmat_adjust(&m1, a, b, ah, bh, p, t0, t1, t2)) {
                if (pbz_cmp(a, b) < 0) {
                    pbz_swap(a, b);
                    pbn_hmat_swap(&m1);
                }
                if (m) pbn_hmat_lmul(m, &m1, t0);
            }
            pbn_hmat_clear(&m1);
        }
        pbz_clear(ah); pbz_clear(bh);
    }
    pbn_hgcd_base(a, b, s, m, t0, t1, t2);
    pbz_clear(t0); pbz_clear(t1); pbz_clear(t2);
}
#endif

PBN_DEF void pbz_gcd(pbz_ptr g, pbz_srcptr a, pbz_srcptr b) {
    pbn_size an = PBN_ABS(SIZ(a)), bn = PBN_ABS(SIZ(b)), n, rn, tn;
    pbn_limb *buf, *x, *y, *gp;
    PBN_TMP_DECL(gb);
    if (an == 0) { pbz_abs(g, b); return; }
    if (bn == 0) { pbz_abs(g, a); return; }
#if defined(PBN_HAVE_HGCD)
    if (an >= PBN_GCD_HGCD_THRESHOLD && bn >= PBN_GCD_HGCD_THRESHOLD) {
        pbz_t x, y;
        pbz_init(x); pbz_init(y);
        pbz_abs(x, a);
        pbz_abs(y, b);
        if (pbz_cmp(x, y) < 0) pbz_swap(x, y);
        while (SIZ(y) >= PBN_GCD_HGCD_THRESHOLD) {
            pbn_hgcd(x, y, NULL);
            if (SIZ(y) == 0) break;
            pbz_tdiv_r(x, x, y);           /* one division step: progress even if hgcd made none */
            pbz_swap(x, y);
        }
        pbz_gcd(g, x, y);                  /* the rest below the threshold */
        pbz_clear(x); pbz_clear(y);
        return;
    }
#endif
    if (an == 1 && bn == 1) {
        pbn_limb v = pbn_gcd_limb(PTR(a)[0], PTR(b)[0]);
        gp = PBZ_GROW(g, 1);
        gp[0] = v;
        SIZ(g) = 1;
        return;
    }
#if defined(PBN_HAVE_DLIMB)
    if (an <= 2 && bn <= 2) {
        /* binary gcd on double limbs */
        pbn_dlimb u = PTR(a)[0], v = PTR(b)[0];
        int sh = 0;
        if (an == 2) u |= (pbn_dlimb)PTR(a)[1] << PBN_B;
        if (bn == 2) v |= (pbn_dlimb)PTR(b)[1] << PBN_B;
#define PBN_CTZ_D(x) ((pbn_limb)(x) ? pbn_ctz((pbn_limb)(x)) : PBN_B + pbn_ctz((pbn_limb)((x) >> PBN_B)))
        {
            int su = PBN_CTZ_D(u), sv = PBN_CTZ_D(v);
            sh = su < sv ? su : sv;
            u >>= su;
            v >>= sv;
        }
        /* 2-limb steps only while one of them doesn't fit in a limb */
        while ((u >> PBN_B) | (v >> PBN_B)) {
            if (u > v) { u -= v; u >>= PBN_CTZ_D(u); }
            else if (v > u) { v -= u; v >>= PBN_CTZ_D(v); }
            else break;
        }
        if (!((u >> PBN_B) | (v >> PBN_B))) u = pbn_gcd_limb((pbn_limb)u, (pbn_limb)v);
        u <<= sh;
        gp = PBZ_GROW(g, 2);
        gp[0] = (pbn_limb)u;
        gp[1] = (pbn_limb)(u >> PBN_B);
        SIZ(g) = gp[1] ? 2 : 1;
        return;
    }
#endif
    n = PBN_MAX(an, bn);
    tn = 4 * n + 4;
    buf = PBN_TMP_GET(gb, 2 * (n + 1) + tn);
    x = buf;
    y = buf + n + 1;
    pbn_n_copy(x, PTR(a), an);
    pbn_n_copy(y, PTR(b), bn);
    rn = pbn_n_gcd(&x, x, an, y, bn, buf + 2 * (n + 1));
    gp = PBZ_GROW(g, rn);
    pbn_n_copy(gp, x, rn);
    SIZ(g) = (int)rn;
    PBN_TMP_PUT(gb, buf, 2 * (n + 1) + tn);
}

PBN_DEF unsigned long pbz_gcd_ui(pbz_ptr g, pbz_srcptr a, unsigned long b) {
    pbz_t t;
    unsigned long res;
    PBZ_TMP_UL(bt, b);
    pbz_init(t);
    pbz_gcd(t, a, bt);
    res = pbz_fits_ulong_p(t) ? pbz_get_ui(t) : 0;
    if (g) pbz_swap(g, t);
    pbz_clear(t);
    return res;
}

PBN_DEF void pbz_lcm(pbz_ptr r, pbz_srcptr a, pbz_srcptr b) {
    pbz_t g;
    if (SIZ(a) == 0 || SIZ(b) == 0) { SIZ(r) = 0; return; }
    pbz_init(g);
    pbz_gcd(g, a, b);
    pbz_divexact(g, a, g);
    pbz_mul(g, g, b);
    pbz_abs(r, g);
    pbz_clear(g);
}

PBN_DEF void pbz_lcm_ui(pbz_ptr r, pbz_srcptr a, unsigned long b) { PBZ_TMP_UL(t, b); pbz_lcm(r, a, t); }

PBN_DEF int pbz_invert(pbz_ptr r, pbz_srcptr a, pbz_srcptr m) {
    pbz_t mm, x, y, s0, s1, q, t;
    int ok;
    if (SIZ(m) == 0) return 0;
    pbz_inits(mm, x, y, s0, s1, q, t, (pbz_ptr)NULL);
    pbz_abs(mm, m);
    pbz_mod(x, a, mm);
    pbz_set(y, mm);
    pbz_set_ui(s0, 1);
    pbz_set_ui(s1, 0);
    while (SIZ(y) != 0) {
        pbz_tdiv_qr(q, t, x, y);
        pbz_swap(x, y);
        pbz_swap(y, t);
        pbz_mul(t, q, s1);
        pbz_sub(t, s0, t);
        pbz_swap(s0, s1);
        pbz_swap(s1, t);
    }
    ok = SIZ(x) == 1 && PTR(x)[0] == 1;
    if (!ok && pbz_cmp_ui(mm, 1) == 0) ok = 1;  /* everything is invertible mod 1 */
    if (ok) pbz_mod(r, s0, mm);
    pbz_clears(mm, x, y, s0, s1, q, t, (pbz_ptr)NULL);
    return ok;
}

/* ---- factorial ---- */

#ifndef PBN_PRODLIMBS_THRESHOLD
#  define PBN_PRODLIMBS_THRESHOLD 32
#endif

/* r = v[lo] * ... * v[hi - 1] (hi > lo, all of them nonzero) */
static void pbn_prod_limbs(pbz_ptr r, const pbn_limb *v, pbn_size lo, pbn_size hi) {
    if (hi - lo <= PBN_PRODLIMBS_THRESHOLD) {
        /* one limb at a time, into a result sized once (k limbs make at most k) */
        pbn_limb *rp = PBZ_GROW(r, hi - lo);
        pbn_size i, rn = 1;
        rp[0] = v[lo];
        for (i = lo + 1; i < hi; i++) {
            pbn_limb cy = pbn_n_mul_1(rp, rp, rn, v[i]);
            rp[rn] = cy;
            rn += cy != 0;
        }
        SIZ(r) = (int)rn;
    } else {
        pbz_t t;
        pbn_size mid = lo + (hi - lo) / 2;
        pbz_init(t);
        pbn_prod_limbs(r, v, lo, mid);
        pbn_prod_limbs(t, v, mid, hi);
        pbz_mul(r, r, t);
        pbz_clear(t);
    }
}

/* ---- factorial: Luschny's prime-swing algorithm above a threshold ----
   n! = oddpart(n!) * 2^(n - popcount(n)), and with the "swinging factorial"
   m swing = m! / floor(m/2)!^2:   oddpart(m!) = oddpart(floor(m/2)!)^2 * oddpart(m swing),
   where m swing = product of primes p <= m, each to the power sum_k (floor(m / p^k) mod 2) */

#ifndef PBN_FAC_SWING_THRESHOLD
#  define PBN_FAC_SWING_THRESHOLD 200
#endif

/* multiplies x into the packed limb list (several factors per limb) */
PBN_INLINE void pbn_fac_push(pbn_limb *v, pbn_size *cnt, pbn_limb *cur, pbn_limb x) {
    pbn_limb hi, lo = pbn_umul(*cur, x, &hi);   /* overflow check by multiplying, no division */
    if (hi) {
        v[(*cnt)++] = *cur;
        *cur = x;
    } else {
        *cur = lo;
    }
}

/* r = oddpart(m!) = the product of the odd parts of 2..m (m >= 1), packed into limbs
   and multiplied with a product tree */
#define PBN_FAC_STACK (PBN_FAC_SWING_THRESHOLD / 2 + 2)   /* packed factors of m < the threshold */

static void pbn_fac_odd(pbz_ptr r, unsigned long m) {
    pbn_size cnt = 0, cap = (pbn_size)(m / 2 + 2);
    pbn_limb cur = 1, *v, buf[PBN_FAC_STACK];
    unsigned long i;
    if (PBN_B == 32 && m > 65535UL) cap = (pbn_size)(m + 2);
    v = cap <= PBN_FAC_STACK ? buf : PBN_TMP_ALLOC(cap);
    for (i = 3; i <= m; i++)
        pbn_fac_push(v, &cnt, &cur, (pbn_limb)i >> pbn_ctz((pbn_limb)i));
    v[cnt++] = cur;
    pbn_prod_limbs(r, v, 0, cnt);
    if (v != buf) PBN_TMP_FREE(v, cap);
}

static unsigned long pbn_popcount_ul(unsigned long x) {
    unsigned long c = 0;
    while (x) { x &= x - 1; c++; }
    return c;
}

/* n! by the prime swing (n >= PBN_FAC_SWING_THRESHOLD) */
static PBN_NOINLINE void pbn_fac_swing(pbz_ptr r, unsigned long n) {
    unsigned long levels[sizeof(unsigned long) * CHAR_BIT], m, p, half;
    unsigned char *comp;
    pbn_limb *v, cur;
    pbn_size cnt, cap;
    pbz_t t;
    int nl = 0, k;

    /* n, n/2, n/4, ... down to the first value below the threshold */
    for (m = n; m >= PBN_FAC_SWING_THRESHOLD; m >>= 1) levels[nl++] = m;

    /* oddpart(m!) for the smallest level, directly */
    pbn_fac_odd(r, m);

    /* odd primes up to n: comp[i] != 0 if 2i+1 is composite */
    half = n / 2 + 1;
    comp = (unsigned char *)pbn_alloc_fn((size_t)half);
    memset(comp, 0, (size_t)half);
    for (p = 3; p <= n / p; p += 2)
        if (!comp[p / 2]) {
            unsigned long q;
            for (q = p * p; q <= n; q += 2 * p) comp[q / 2] = 1;
        }

    cap = (pbn_size)(n / 2 + 2);
    v = PBN_TMP_ALLOC(cap);
    pbz_init(t);
    for (k = nl - 1; k >= 0; k--) {
        m = levels[k];
        /* oddpart(m swing): odd prime powers */
        cnt = 0;
        cur = 1;
        for (p = 3; p <= m; p += 2) {
            if (comp[p / 2]) continue;
            if (p <= m / p) {
                unsigned long q = m, e = 0;
                while (q >= p) { q /= p; e += q & 1; }
                while (e--) pbn_fac_push(v, &cnt, &cur, (pbn_limb)p);
            } else if ((m / p) & 1) {
                pbn_fac_push(v, &cnt, &cur, (pbn_limb)p);
            }
        }
        v[cnt++] = cur;
        pbn_prod_limbs(t, v, 0, cnt);
        pbz_mul(r, r, r);
        pbz_mul(r, r, t);
    }
    pbz_clear(t);
    PBN_TMP_FREE(v, cap);
    pbn_free_fn(comp, (size_t)half);

    pbz_mul_2exp(r, r, (pbn_bitcnt)(n - pbn_popcount_ul(n)));
}

/* 0! .. 20! (the ones fitting in 64 bits) */
static const uint64_t pbn_fac_tab[21] = {
    1u, 1u, 2u,
    6u, 24u, 120u,
    720u, 5040u, 40320u,
    362880u, 3628800u, 39916800u,
    479001600u, 6227020800u, 87178291200u,
    1307674368000u, 20922789888000u, 355687428096000u,
    6402373705728000u, 121645100408832000u, 2432902008176640000u
};

/* n! below the swing threshold: the direct product of 2..n, packed into limbs (no separate
   power of 2: its shift would cost more than it saves); a function of its own, so that its
   stack buffer doesn't weigh on the n! that come from the table */
static PBN_NOINLINE void pbn_fac_small(pbz_ptr r, unsigned long n) {
    pbn_size cnt = 0, cap = (pbn_size)(n / 2 + 2);
    pbn_limb cur = 1, *v, buf[PBN_FAC_STACK];
    unsigned long i;
    if (PBN_B == 32 && n > 65535UL) cap = (pbn_size)(n + 2);
    v = cap <= PBN_FAC_STACK ? buf : PBN_TMP_ALLOC(cap);
    for (i = 2; i <= n; i++) pbn_fac_push(v, &cnt, &cur, (pbn_limb)i);
    v[cnt++] = cur;
    pbn_prod_limbs(r, v, 0, cnt);
    if (v != buf) PBN_TMP_FREE(v, cap);
}

PBN_DEF void pbz_fac_ui(pbz_ptr r, unsigned long n) {
    if (n <= (PBN_B == 64 ? 20UL : 12UL)) {
        /* n! fits in a limb */
        pbn_limb *rp = PBZ_GROW(r, 1);
        rp[0] = (pbn_limb)pbn_fac_tab[n];
        SIZ(r) = 1;
        return;
    }
    if ((pbn_limb)n != n) PBN_ABORT("factorial argument too large");
    if (n >= PBN_FAC_SWING_THRESHOLD) pbn_fac_swing(r, n);
    else pbn_fac_small(r, n);
}

/* ---- primality ---- */

static const unsigned char pbn_small_primes[] = {
    3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97,
    101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191,
    193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251
};
#define PBN_NSMALL ((int)sizeof(pbn_small_primes))

static int pbn_isprime_ul(unsigned long n) {   /* n odd, n < 2^20 */
    unsigned long d;
    for (d = 3; d * d <= n; d += 2) if (n % d == 0) return 0;
    return 1;
}

/* returns 1 if n (odd, > 251) has a small factor */
static int pbn_has_small_factor(pbz_srcptr n) {
    int i = 0;
    while (i < PBN_NSMALL) {
        pbn_limb prod = 1;
        int j = i;
        while (j < PBN_NSMALL && prod <= PBN_LIMB_MAX / pbn_small_primes[j]) prod *= pbn_small_primes[j++];
        {
            pbn_limb rem = pbn_n_divrem_1(NULL, PTR(n), SIZ(n), prod);
            for (; i < j; i++) if (rem % pbn_small_primes[i] == 0) return 1;
        }
    }
    return 0;
}

static int pbn_millerrabin(pbz_srcptr n, pbz_srcptr nm1, pbz_srcptr d, pbn_bitcnt s, pbz_srcptr a, pbz_ptr x) {
    pbn_bitcnt i;
    pbz_powm(x, a, d, n);
    if (pbz_cmp_ui(x, 1) == 0 || pbz_cmp(x, nm1) == 0) return 1;
    for (i = 1; i < s; i++) {
        pbz_mul(x, x, x);
        pbz_tdiv_r(x, x, n);
        if (pbz_cmp(x, nm1) == 0) return 1;
        if (pbz_cmp_ui(x, 1) == 0) return 0;
    }
    return 0;
}

static int pbn_jacobi_ul(unsigned long a, unsigned long n) {
    int t = 1;
    a %= n;
    while (a) {
        while (!(a & 1)) {
            unsigned long r = n & 7;
            a >>= 1;
            if (r == 3 || r == 5) t = -t;
        }
        { unsigned long tmp = a; a = n; n = tmp; }
        if ((a & 3) == 3 && (n & 3) == 3) t = -t;
        a %= n;
    }
    return n == 1 ? t : 0;
}

/* jacobi(D / n), n odd positive, D odd */
static int pbn_jacobi_small(long D, pbz_srcptr n) {
    unsigned long ad = D < 0 ? 0UL - (unsigned long)D : (unsigned long)D;
    unsigned long nm = pbz_tdiv_ui(n, ad);
    unsigned long n4 = (unsigned long)(PTR(n)[0] & 3);
    int j = pbn_jacobi_ul(nm, ad);
    if ((ad & 3) == 3 && n4 == 3) j = -j;
    if (D < 0 && n4 == 3) j = -j;
    return j;
}

/* arithmetic modulo an odd n of nn limbs in Montgomery form (x R mod n, R = B^nn) */
typedef struct { const pbn_limb *mp; pbn_size n; pbn_limb minv, *tp; } pbn_mctx;   /* tp: 2n limbs */

static void pbn_mc_mul(const pbn_mctx *c, pbn_limb *r, const pbn_limb *a, const pbn_limb *b) {
    if (a == b) pbn_n_sqr(c->tp, a, c->n);
    else        pbn_n_mul(c->tp, a, c->n, b, c->n);
    pbn_n_redc(r, c->tp, c->mp, c->n, c->minv);
}

/* r = a - b mod n */
static void pbn_mc_sub(const pbn_mctx *c, pbn_limb *r, const pbn_limb *a, const pbn_limb *b) {
    if (pbn_n_sub_n(r, a, b, c->n)) pbn_n_add_n(r, r, c->mp, c->n);
}

/* r = a + b mod n */
static void pbn_mc_add(const pbn_mctx *c, pbn_limb *r, const pbn_limb *a, const pbn_limb *b) {
    if (pbn_n_add_n(r, a, b, c->n) || pbn_n_cmp(r, c->mp, c->n) >= 0) pbn_n_sub_n(r, r, c->mp, c->n);
}

/* r = a q mod n for a small q != 0 (Montgomery form is linear: no reduction by R needed);
   a q < |q| n, so a few subtractions reduce it. t: n + 1 limbs */
static void pbn_mc_mul_si(const pbn_mctx *c, pbn_limb *r, const pbn_limb *a, long q, pbn_limb *t) {
    pbn_size n = c->n;
    pbn_limb aq = (pbn_limb)(q < 0 ? -q : q);
    t[n] = pbn_n_mul_1(t, a, n, aq);
    while (t[n] || pbn_n_cmp(t, c->mp, n) >= 0)
        t[n] -= pbn_n_sub_n(t, t, c->mp, n);
    if (q < 0) {
        pbn_size k = n;
        PBN_NORM(t, k);
        if (k) pbn_n_sub_n(r, c->mp, t, n);
        else   pbn_n_zero(r, n);
    } else {
        pbn_n_copy(r, t, n);
    }
}

/* rp[0..nn) = x R mod n (x a small signed integer) */
static void pbn_mc_from_si(pbn_limb *rp, long x, pbz_srcptr n, pbz_ptr t) {
    pbn_size nn = SIZ(n), k;
    pbz_set_si(t, x);
    pbz_mul_2exp(t, t, (pbn_bitcnt)nn * PBN_B);
    pbz_mod(t, t, n);
    k = SIZ(t);
    pbn_n_copy(rp, PTR(t), k);
    pbn_n_zero(rp + k, nn - k);
}

/* strong Lucas probable prime test, Selfridge parameters (P = 1, Q = (1 - D) / 4).
   With n + 1 = d 2^s: n passes if U_d = 0 or V_{d 2^r} = 0 (mod n) for some r < s. Only V is
   computed (Lucas chain on V_k, V_{k+1}), in Montgomery form; U_d = 0 iff 2 V_{d+1} = P V_d,
   as D U_k = 2 V_{k+1} - P V_k and D is invertible mod n (jacobi(D/n) = -1) */
static int pbn_strong_lucas(pbz_srcptr n) {
    long D = 5, Q;
    pbz_t d, t;
    pbn_bitcnt s = 0, i, bits;
    pbn_size nn = SIZ(n);
    pbn_limb *buf, *V, *V1, *Qk, *Qm, *Q1, *w;
    pbn_mctx c;
    int res = 0, j;

    for (;;) {
        j = pbn_jacobi_small(D, n);
        if (j == -1) break;
        if (j == 0 && pbz_cmpabs_ui(n, (unsigned long)PBN_ABS(D)) != 0) return 0;
        D = D > 0 ? -(D + 2) : -(D - 2);
        if (D == 17 && pbz_perfect_square_p(n)) return 0;
    }
    Q = (1 - D) / 4;

    pbz_init(d);
    pbz_init(t);
    pbz_add_ui(d, n, 1);
    while (!pbz_tstbit(d, s)) s++;
    pbz_tdiv_q_2exp(d, d, s);

    buf = PBN_TMP_ALLOC(8 * nn);
    V = buf; V1 = V + nn; Qk = V1 + nn; Qm = Qk + nn; Q1 = Qm + nn; w = Q1 + nn;
    c.mp = PTR(n);
    c.n = nn;
    c.minv = pbn_binvert_neg(c.mp[0]);
    c.tp = w + nn;     /* 2 nn limbs */

    pbn_mc_from_si(V, 1, n, t);                 /* V_1 = P */
    pbn_mc_from_si(V1, 1 - 2 * Q, n, t);        /* V_2 = P^2 - 2Q */
    pbn_mc_from_si(Qm, Q, n, t);
    pbn_n_copy(Qk, Qm, nn);                     /* Q^1 */

    bits = pbz_bitlen(d);
    for (i = bits - 1; i-- > 0;) {
        if (pbz_tstbit(d, i)) {
            /* k -> 2k + 1: V_{2k+1} = V_k V_{k+1} - P Q^k, V_{2k+2} = V_{k+1}^2 - 2 Q^{k+1} */
            pbn_mc_mul_si(&c, Q1, Qk, Q, c.tp);
            pbn_mc_mul(&c, w, V, V1);
            pbn_mc_sub(&c, V, w, Qk);
            pbn_mc_mul(&c, w, V1, V1);
            pbn_mc_sub(&c, w, w, Q1);
            pbn_mc_sub(&c, V1, w, Q1);
            pbn_mc_mul(&c, Qk, Qk, Q1);
        } else {
            /* k -> 2k: V_{2k} = V_k^2 - 2 Q^k, V_{2k+1} = V_k V_{k+1} - P Q^k */
            pbn_mc_mul(&c, w, V, V1);
            pbn_mc_sub(&c, V1, w, Qk);
            pbn_mc_mul(&c, w, V, V);
            pbn_mc_sub(&c, w, w, Qk);
            pbn_mc_sub(&c, V, w, Qk);
            pbn_mc_mul(&c, Qk, Qk, Qk);
        }
    }

    /* U_d = 0: 2 V_{d+1} - V_d = 0 */
    pbn_mc_add(&c, w, V1, V1);
    pbn_mc_sub(&c, w, w, V);
    {
        pbn_size k = nn, k2 = nn;
        PBN_NORM(w, k);
        PBN_NORM(V, k2);
        if (k == 0 || k2 == 0) { res = 1; goto done; }
    }
    for (i = 1; i < s; i++) {
        pbn_size k = nn;
        pbn_mc_mul(&c, w, V, V);
        pbn_mc_sub(&c, w, w, Qk);
        pbn_mc_sub(&c, V, w, Qk);
        PBN_NORM(V, k);
        if (k == 0) { res = 1; goto done; }
        if (i + 1 < s) pbn_mc_mul(&c, Qk, Qk, Qk);
    }
done:
    PBN_TMP_FREE(buf, 8 * nn);
    pbz_clear(d);
    pbz_clear(t);
    return res;
}

PBN_DEF int pbz_probab_prime_p(pbz_srcptr nin, int reps) {
    pbz_struct nabs = *nin;
    pbz_srcptr n = &nabs;
    pbz_t nm1, d, a, x;
    pbn_bitcnt s = 0;
    int res;

    nabs._mp_size = PBN_ABS(nabs._mp_size);
    if (pbz_cmp_ui(n, 1000000UL) <= 0) {
        unsigned long v = pbz_get_ui(n);
        if (v < 2) return 0;
        if (v == 2) return 2;
        if (!(v & 1)) return 0;
        return pbn_isprime_ul(v) ? 2 : 0;
    }
    if (!(PTR(n)[0] & 1)) return 0;
    if (pbn_has_small_factor(n)) return 0;

    pbz_inits(nm1, d, a, x, (pbz_ptr)NULL);
    pbz_sub_ui(nm1, n, 1);
    while (!pbz_tstbit(nm1, s)) s++;
    pbz_tdiv_q_2exp(d, nm1, s);
    pbz_set_ui(a, 2);
    res = pbn_millerrabin(n, nm1, d, s, a, x) && pbn_strong_lucas(n);
    if (res) {
        /* BPSW passed. Below 35*2^46 BPSW is proven exact: report 2 (same cutoff as GMP).
           Above: "probably prime" = 1, plus extra Miller-Rabin rounds for reps > 24 */
        uint64_t seed = 0x9E3779B97F4A7C15ull ^ (uint64_t)PTR(n)[0];
        int i;
        pbz_set_u64(a, (uint64_t)35 << 46);
        if (pbz_cmp(n, a) < 0) res = 2;
        for (i = 0; i < reps - 24 && res == 1; i++) {
            seed = seed * 6364136223846793005ull + 1442695040888963407ull;
            pbz_set_u64(a, seed >> 1);
            pbz_mod(a, a, nm1);
            if (pbz_cmp_ui(a, 2) < 0) pbz_set_ui(a, 3);
            res = pbn_millerrabin(n, nm1, d, s, a, x);
        }
    }
    pbz_clears(nm1, d, a, x, (pbz_ptr)NULL);
    return res;
}

PBN_DEF void pbz_nextprime(pbz_ptr r, pbz_srcptr n) {
    if (pbz_cmp_ui(n, 2) < 0) { pbz_set_ui(r, 2); return; }
    pbz_add_ui(r, n, 1);
    if (pbz_cmp_ui(r, 2) == 0) return;
    if (pbz_even_p(r)) pbz_add_ui(r, r, 1);
    while (!pbz_probab_prime_p(r, 25)) pbz_add_ui(r, r, 2);
}

/* ---- raw limb access ---- */

PBN_DEF size_t pbz_size(pbz_srcptr x) { return (size_t)PBN_ABS(SIZ(x)); }

PBN_DEF pbn_limb pbz_getlimbn(pbz_srcptr x, pbn_size n) {
    return (n >= 0 && n < PBN_ABS(SIZ(x))) ? PTR(x)[n] : 0;
}

PBN_DEF const pbn_limb *pbz_limbs_read(pbz_srcptr x) { return PTR(x); }

PBN_DEF pbn_limb *pbz_limbs_write(pbz_ptr x, pbn_size n) {
    if (n > PBZ_CAP(x)) { SIZ(x) = 0; return pbz_grow_slow(x, n); }
    return PTR(x);
}

PBN_DEF pbn_limb *pbz_limbs_modify(pbz_ptr x, pbn_size n) { return PBZ_GROW(x, n); }

PBN_DEF void pbz_limbs_finish(pbz_ptr x, pbn_size n) {
    pbn_size an = PBN_ABS(n);
    PBN_NORM(PTR(x), an);
    SIZ(x) = (int)(n < 0 ? -an : an);
}

PBN_DEF pbz_srcptr pbz_roinit_n(pbz_ptr x, const pbn_limb *p, pbn_size n) {
    pbn_size an = PBN_ABS(n);
    ALLOC(x) = 0;
    PTR(x) = (pbn_limb *)p;
    PBN_NORM(p, an);
    SIZ(x) = (int)(n < 0 ? -an : an);
    return x;
}

/* ========================================================================= */
/* pbq: rationals                                                            */
/* ========================================================================= */

#define QNUM(q) (&(q)->_mp_num)
#define QDEN(q) (&(q)->_mp_den)

static pbn_limb pbn_one_limb = 1;   /* shared read-only "1"; never written (alloc stays 0) */

static void pbz_init_one(pbz_ptr x) {
    ALLOC(x) = 0;
    SIZ(x) = 1;
    PTR(x) = &pbn_one_limb;
}

static int pbz_is_one(pbz_srcptr x) { return SIZ(x) == 1 && PTR(x)[0] == 1; }

PBN_DEF void pbq_init(pbq_ptr q) { pbz_init(QNUM(q)); pbz_init_one(QDEN(q)); }
PBN_DEF void pbq_clear(pbq_ptr q) { pbz_clear(QNUM(q)); pbz_clear(QDEN(q)); }

PBN_DEF void pbq_inits(pbq_ptr q, ...) {
    va_list ap;
    va_start(ap, q);
    while (q) { pbq_init(q); q = va_arg(ap, pbq_ptr); }
    va_end(ap);
}

PBN_DEF void pbq_clears(pbq_ptr q, ...) {
    va_list ap;
    va_start(ap, q);
    while (q) { pbq_clear(q); q = va_arg(ap, pbq_ptr); }
    va_end(ap);
}

PBN_DEF void pbq_set(pbq_ptr r, pbq_srcptr a)  { pbz_set(QNUM(r), QNUM(a)); pbz_set(QDEN(r), QDEN(a)); }
PBN_DEF void pbq_set_z(pbq_ptr r, pbz_srcptr a) { pbz_set(QNUM(r), a); pbz_set_ui(QDEN(r), 1); }
/* like GMP, 0/d is stored as 0/1; otherwise no canonicalization */
PBN_DEF void pbq_set_si(pbq_ptr r, long n, unsigned long d)          { pbz_set_si(QNUM(r), n); pbz_set_ui(QDEN(r), n ? d : 1); }
PBN_DEF void pbq_set_ui(pbq_ptr r, unsigned long n, unsigned long d) { pbz_set_ui(QNUM(r), n); pbz_set_ui(QDEN(r), n ? d : 1); }
PBN_DEF void pbq_set_num(pbq_ptr r, pbz_srcptr n) { pbz_set(QNUM(r), n); }
PBN_DEF void pbq_set_den(pbq_ptr r, pbz_srcptr d) { pbz_set(QDEN(r), d); }
PBN_DEF void pbq_get_num(pbz_ptr r, pbq_srcptr q) { pbz_set(r, QNUM(q)); }
PBN_DEF void pbq_get_den(pbz_ptr r, pbq_srcptr q) { pbz_set(r, QDEN(q)); }

PBN_DEF void pbq_swap(pbq_ptr a, pbq_ptr b) {
    pbq_struct t = *a;
    *a = *b;
    *b = t;
}

#define PBQ_TL 24   /* stack limbs per temporary */

PBN_DEF void pbq_canonicalize(pbq_ptr q) {
    PBZ_STACK(g, PBQ_TL);
    if (SIZ(QDEN(q)) == 0) pbn_divzero();
    if (SIZ(QDEN(q)) < 0) {
        SIZ(QNUM(q)) = -SIZ(QNUM(q));
        SIZ(QDEN(q)) = -SIZ(QDEN(q));
    }
    pbz_gcd(g, QNUM(q), QDEN(q));
    if (!pbz_is_one(g)) {
        pbz_divexact(QNUM(q), QNUM(q), g);
        pbz_divexact(QDEN(q), QDEN(q), g);
    }
    pbz_clear(g);
}

PBN_DEF void pbq_neg(pbq_ptr r, pbq_srcptr a) { pbq_set(r, a); SIZ(QNUM(r)) = -SIZ(QNUM(r)); }
PBN_DEF void pbq_abs(pbq_ptr r, pbq_srcptr a) { pbq_set(r, a); SIZ(QNUM(r)) = PBN_ABS(SIZ(QNUM(r))); }

PBN_DEF void pbq_inv(pbq_ptr r, pbq_srcptr a) {
    if (SIZ(QNUM(a)) == 0) pbn_divzero();
    if (r == a) {
        pbz_swap(QNUM(r), QDEN(r));
    } else {
        pbz_set(QNUM(r), QDEN(a));
        pbz_set(QDEN(r), QNUM(a));
    }
    if (SIZ(QDEN(r)) < 0) {
        SIZ(QNUM(r)) = -SIZ(QNUM(r));
        SIZ(QDEN(r)) = -SIZ(QDEN(r));
    }
}

/* r = num/den (copies: temporaries may live on the stack) */
static void pbq_store(pbq_ptr r, pbz_srcptr num, pbz_srcptr den) {
    pbz_set(QNUM(r), num);
    pbz_set(QDEN(r), den);
}

static void pbq_addsub(pbq_ptr r, pbq_srcptr a, pbq_srcptr b, int sub) {
    PBZ_STACK(g, PBQ_TL);
    PBZ_STACK(t, PBQ_TL);
    PBZ_STACK(u, PBQ_TL);
    PBZ_STACK(v, PBQ_TL);
    if (pbz_is_one(QDEN(a)) && pbz_is_one(QDEN(b))) {
        if (sub) pbz_sub(QNUM(r), QNUM(a), QNUM(b));
        else     pbz_add(QNUM(r), QNUM(a), QNUM(b));
        pbz_set_ui(QDEN(r), 1);
        return;
    }
    pbz_gcd(g, QDEN(a), QDEN(b));
    if (pbz_is_one(g)) {
        pbz_mul(t, QNUM(a), QDEN(b));
        pbz_mul(u, QNUM(b), QDEN(a));
        if (sub) pbz_sub(t, t, u); else pbz_add(t, t, u);
        pbz_mul(u, QDEN(a), QDEN(b));
    } else {
        pbz_divexact(v, QDEN(b), g);           /* b.den / g */
        pbz_mul(t, QNUM(a), v);
        pbz_divexact(u, QDEN(a), g);           /* a.den / g */
        pbz_mul(v, QNUM(b), u);
        if (sub) pbz_sub(t, t, v); else pbz_add(t, t, v);
        pbz_gcd(g, t, g);
        if (!pbz_is_one(g)) {
            pbz_divexact(t, t, g);
            pbz_divexact(v, QDEN(b), g);
            pbz_mul(u, u, v);
        } else {
            pbz_mul(u, u, QDEN(b));
        }
    }
    if (SIZ(t) == 0) pbz_set_ui(u, 1);
    pbq_store(r, t, u);
    pbz_clear(g); pbz_clear(t); pbz_clear(u); pbz_clear(v);
}

PBN_DEF void pbq_add(pbq_ptr r, pbq_srcptr a, pbq_srcptr b) { pbq_addsub(r, a, b, 0); }
PBN_DEF void pbq_sub(pbq_ptr r, pbq_srcptr a, pbq_srcptr b) { pbq_addsub(r, a, b, 1); }

PBN_DEF void pbq_mul(pbq_ptr r, pbq_srcptr a, pbq_srcptr b) {
    PBZ_STACK(g1, PBQ_TL);
    PBZ_STACK(g2, PBQ_TL);
    PBZ_STACK(n, PBQ_TL);
    PBZ_STACK(d, PBQ_TL);
    if (SIZ(QNUM(a)) == 0 || SIZ(QNUM(b)) == 0) {
        SIZ(QNUM(r)) = 0;
        pbz_set_ui(QDEN(r), 1);
        return;
    }
    if (a == b) {
        pbz_mul(n, QNUM(a), QNUM(a));
        pbz_mul(d, QDEN(a), QDEN(a));
    } else {
        pbz_gcd(g1, QNUM(a), QDEN(b));
        pbz_gcd(g2, QNUM(b), QDEN(a));
        pbz_divexact(n, QNUM(a), g1);
        pbz_divexact(d, QNUM(b), g2);
        pbz_mul(n, n, d);
        pbz_divexact(d, QDEN(a), g2);
        pbz_divexact(g2, QDEN(b), g1);
        pbz_mul(d, d, g2);
    }
    pbq_store(r, n, d);
    pbz_clear(g1); pbz_clear(g2); pbz_clear(n); pbz_clear(d);
}

PBN_DEF void pbq_div(pbq_ptr r, pbq_srcptr a, pbq_srcptr b) {
    PBZ_STACK(g1, PBQ_TL);
    PBZ_STACK(g2, PBQ_TL);
    PBZ_STACK(n, PBQ_TL);
    PBZ_STACK(d, PBQ_TL);
    if (SIZ(QNUM(b)) == 0) pbn_divzero();
    if (SIZ(QNUM(a)) == 0) {
        SIZ(QNUM(r)) = 0;
        pbz_set_ui(QDEN(r), 1);
        return;
    }
    if (a == b) { pbq_set_ui(r, 1, 1); return; }
    pbz_gcd(g1, QNUM(a), QNUM(b));
    pbz_gcd(g2, QDEN(b), QDEN(a));
    pbz_divexact(n, QNUM(a), g1);
    pbz_divexact(d, QDEN(b), g2);
    pbz_mul(n, n, d);
    pbz_divexact(d, QDEN(a), g2);
    pbz_divexact(g2, QNUM(b), g1);
    pbz_mul(d, d, g2);
    if (SIZ(d) < 0) { SIZ(d) = -SIZ(d); SIZ(n) = -SIZ(n); }
    pbq_store(r, n, d);
    pbz_clear(g1); pbz_clear(g2); pbz_clear(n); pbz_clear(d);
}

static pbn_bitcnt pbz_ctz(pbz_srcptr x) {   /* x != 0 */
    pbn_size i = 0;
    while (PTR(x)[i] == 0) i++;
    return (pbn_bitcnt)i * PBN_B + (pbn_bitcnt)pbn_ctz(PTR(x)[i]);
}

PBN_DEF void pbq_mul_2exp(pbq_ptr r, pbq_srcptr a, pbn_bitcnt k) {
    pbn_bitcnt tz, s;
    pbq_set(r, a);
    if (SIZ(QNUM(r)) == 0) return;
    tz = pbz_ctz(QDEN(r));
    s = tz < k ? tz : k;
    if (s) pbz_tdiv_q_2exp(QDEN(r), QDEN(r), s);
    if (k - s) pbz_mul_2exp(QNUM(r), QNUM(r), k - s);
}

PBN_DEF void pbq_div_2exp(pbq_ptr r, pbq_srcptr a, pbn_bitcnt k) {
    pbn_bitcnt tz, s;
    pbq_set(r, a);
    if (SIZ(QNUM(r)) == 0) return;
    tz = pbz_ctz(QNUM(r));
    s = tz < k ? tz : k;
    if (s) pbz_tdiv_q_2exp(QNUM(r), QNUM(r), s);
    if (k - s) pbz_mul_2exp(QDEN(r), QDEN(r), k - s);
}

PBN_DEF int pbq_cmp(pbq_srcptr a, pbq_srcptr b) {
    int sa = pbz_sgn(QNUM(a)), sb = pbz_sgn(QNUM(b)), c;
    PBZ_STACK(t, PBQ_TL);
    PBZ_STACK(u, PBQ_TL);
    if (sa != sb) return sa < sb ? -1 : 1;
    if (sa == 0) return 0;
    if (pbz_is_one(QDEN(a)) && pbz_is_one(QDEN(b))) return pbz_cmp(QNUM(a), QNUM(b));
    pbz_mul(t, QNUM(a), QDEN(b));
    pbz_mul(u, QNUM(b), QDEN(a));
    c = pbz_cmp(t, u);
    pbz_clear(t);
    pbz_clear(u);
    return c;
}

PBN_DEF int pbq_cmp_z(pbq_srcptr a, pbz_srcptr z) {
    pbq_struct t;
    t._mp_num = *z;
    pbz_init_one(&t._mp_den);
    return pbq_cmp(a, &t);
}

PBN_DEF int pbq_cmp_si(pbq_srcptr a, long n, unsigned long d) {
    pbq_struct t;
    PBZ_TMP_SL(tn, n);
    PBZ_TMP_UL(td, d);
    if (d == 0) pbn_divzero();
    t._mp_num = *tn;
    t._mp_den = *td;
    return pbq_cmp(a, &t);
}

PBN_DEF int pbq_cmp_ui(pbq_srcptr a, unsigned long n, unsigned long d) {
    pbq_struct t;
    PBZ_TMP_UL(tn, n);
    PBZ_TMP_UL(td, d);
    if (d == 0) pbn_divzero();
    t._mp_num = *tn;
    t._mp_den = *td;
    return pbq_cmp(a, &t);
}

PBN_DEF int pbq_equal(pbq_srcptr a, pbq_srcptr b) {
    return pbz_cmp(QNUM(a), QNUM(b)) == 0 && pbz_cmp(QDEN(a), QDEN(b)) == 0;
}

/* truncating conversion, like GMP's mpq_get_d */
PBN_DEF double pbq_get_d(pbq_srcptr q) {
    PBZ_STACK(n, PBQ_TL);
    PBZ_STACK(t, PBQ_TL);
    long k, bits, ehi, allowed;
    double d;
    if (SIZ(QNUM(q)) == 0) return 0.0;
    pbz_abs(n, QNUM(q));
    k = 55 + (long)pbz_bitlen(QDEN(q)) - (long)pbz_bitlen(n);
    if (k >= 0) pbz_mul_2exp(n, n, (pbn_bitcnt)k);
    else        pbz_tdiv_q_2exp(n, n, (pbn_bitcnt)-k);
    pbz_tdiv_q(t, n, QDEN(q));             /* |q| ~ t * 2^-k, t truncated */
    bits = (long)pbz_bitlen(t);
    ehi = bits - k;                         /* |q| in [2^(ehi-1), 2^ehi) */
    allowed = 53;
    if (ehi - 1 < -1022) allowed = ehi + 1074;
    if (allowed <= 0) {
        d = 0.0;
    } else {
        if (bits > allowed) {
            pbz_tdiv_q_2exp(t, t, (pbn_bitcnt)(bits - allowed));
            k -= bits - allowed;
        }
        d = pbz_get_d(t);
        if (-k > 2000) d = HUGE_VAL;
        else if (k > 3000) d = 0.0;
        else d = ldexp(d, (int)-k);
    }
    pbz_clear(n);
    pbz_clear(t);
    return SIZ(QNUM(q)) < 0 ? -d : d;
}

PBN_DEF void pbq_set_d(pbq_ptr r, double d) {
    int neg, e;
    uint64_t m;
    if (d != d || d - d != 0) PBN_ABORT("invalid operation (NaN or infinity)");
    if (d == 0) { SIZ(QNUM(r)) = 0; pbz_set_ui(QDEN(r), 1); return; }
    neg = d < 0;
    m = (uint64_t)ldexp(frexp(neg ? -d : d, &e), 53);
    e -= 53;
    if (e >= 0) {
        pbz_set_u64(QNUM(r), m);
        pbz_mul_2exp(QNUM(r), QNUM(r), (pbn_bitcnt)e);
        pbz_set_ui(QDEN(r), 1);
    } else {
        int tz = 0;
        while (!((m >> tz) & 1)) tz++;
        if (tz > -e) tz = -e;
        m >>= tz;
        e += tz;
        pbz_set_u64(QNUM(r), m);
        pbz_set_ui(QDEN(r), 1);
        pbz_mul_2exp(QDEN(r), QDEN(r), (pbn_bitcnt)-e);
    }
    if (neg) SIZ(QNUM(r)) = -SIZ(QNUM(r));
}

PBN_DEF int pbq_set_str(pbq_ptr r, const char *str, int base) {
    const char *slash = strchr(str, '/');
    char *num;
    size_t numlen;
    int ret;
    if (!slash) {
        pbz_set_ui(QDEN(r), 1);
        return pbz_set_str(QNUM(r), str, base);
    }
    numlen = (size_t)(slash - str);
    num = (char *)pbn_alloc_fn(numlen + 1);
    memcpy(num, str, numlen);
    num[numlen] = '\0';
    ret = pbz_set_str(QNUM(r), num, base);
    pbn_free_fn(num, numlen + 1);
    if (ret != 0) return ret;
    return pbz_set_str(QDEN(r), slash + 1, base);
}

PBN_DEF char *pbq_get_str(char *str, int base, pbq_srcptr q) {
    size_t alloc = 0, len;
    if (!str) {
        int ab = base < 0 ? -base : base;
        if (ab < 2) ab = 10;
        alloc = pbz_sizeinbase(QNUM(q), ab) + pbz_sizeinbase(QDEN(q), ab) + 3;
        str = (char *)pbn_alloc_fn(alloc);
    }
    if (!pbz_get_str(str, base, QNUM(q))) {
        if (alloc) pbn_free_fn(str, alloc);
        return NULL;
    }
    len = strlen(str);
    if (!pbz_is_one(QDEN(q))) {
        str[len++] = '/';
        pbz_get_str(str + len, base, QDEN(q));
        len += strlen(str + len);
    }
    if (alloc && alloc != len + 1) str = (char *)pbn_realloc_fn(str, alloc, len + 1);
    return str;
}

/* ========================================================================= */
/* pbf: floating point                                                       */
/* ========================================================================= */

#define PBF_EXP_ZERO  (LONG_MIN + 1)
#define PBF_EXP_NAN   (LONG_MIN + 2)
#define PBF_EXP_INF   (LONG_MIN + 3)
#define PBF_EMIN      (1L - (1L << 30))
#define PBF_EMAX      ((1L << 30) - 1)
#define FPREC(x)      ((x)->_mpfr_prec)
#define FSIGN(x)      ((x)->_mpfr_sign)
#define FEXP(x)       ((x)->_mpfr_exp)
#define FPTR(x)       ((x)->_mpfr_d)
#define PBF_NLIMBS(p) ((pbn_size)(((p) + PBN_B - 1) / PBN_B))

#if defined(_MSC_VER)
#  define PBN_TLS __declspec(thread)
#elif defined(__STDC_VERSION__) && __STDC_VERSION__ >= 201112L && !defined(__STDC_NO_THREADS__)
#  define PBN_TLS _Thread_local
#elif defined(__GNUC__) || defined(__clang__)
#  define PBN_TLS __thread
#else
#  define PBN_TLS
#endif

static PBN_TLS pbf_prec_t pbf_default_prec = 53;

PBN_DEF const char *pbf_get_version(void)        { return PBN_VERSION; }
PBN_DEF void pbf_set_default_prec(pbf_prec_t p)   { if (p >= PBF_PREC_MIN && p <= PBF_PREC_MAX) pbf_default_prec = p; }
PBN_DEF pbf_prec_t pbf_get_default_prec(void)     { return pbf_default_prec; }
PBN_DEF pbf_exp_t pbf_get_emin(void)              { return PBF_EMIN; }
PBN_DEF pbf_exp_t pbf_get_emax(void)              { return PBF_EMAX; }

PBN_DEF void pbf_init2(pbf_ptr x, pbf_prec_t p) {
    if (p < PBF_PREC_MIN || p > PBF_PREC_MAX) PBN_ABORT("invalid precision");
    FPREC(x) = p;
    FSIGN(x) = 1;
    FEXP(x) = PBF_EXP_NAN;
    FPTR(x) = PBN_TMP_ALLOC(PBF_NLIMBS(p));
}

PBN_DEF void pbf_init(pbf_ptr x) { pbf_init2(x, pbf_default_prec); }

PBN_DEF void pbf_inits(pbf_ptr x, ...) {
    va_list ap;
    va_start(ap, x);
    while (x) { pbf_init(x); x = va_arg(ap, pbf_ptr); }
    va_end(ap);
}

PBN_DEF void pbf_clear(pbf_ptr x) {
    if (FPTR(x)) PBN_TMP_FREE(FPTR(x), PBF_NLIMBS(FPREC(x)));
    FPTR(x) = NULL;
}

PBN_DEF void pbf_clears(pbf_ptr x, ...) {
    va_list ap;
    va_start(ap, x);
    while (x) { pbf_clear(x); x = va_arg(ap, pbf_ptr); }
    va_end(ap);
}

PBN_DEF void pbf_set_prec(pbf_ptr x, pbf_prec_t p) {
    pbn_size on = PBF_NLIMBS(FPREC(x)), nn;
    if (p < PBF_PREC_MIN || p > PBF_PREC_MAX) PBN_ABORT("invalid precision");
    nn = PBF_NLIMBS(p);
    if (!FPTR(x)) FPTR(x) = PBN_TMP_ALLOC(nn);
    else if (on != nn) FPTR(x) = (pbn_limb *)pbn_realloc_fn(FPTR(x), (size_t)on * sizeof(pbn_limb), (size_t)nn * sizeof(pbn_limb));
    FPREC(x) = p;
    FEXP(x) = PBF_EXP_NAN;
}

PBN_DEF pbf_prec_t pbf_get_prec(pbf_srcptr x) { return FPREC(x); }
PBN_DEF void pbf_free_str(char *s) { if (s) pbn_free_fn(s, strlen(s) + 1); }

PBN_DEF void pbf_set_nan(pbf_ptr x)            { FEXP(x) = PBF_EXP_NAN; }
PBN_DEF void pbf_set_inf(pbf_ptr x, int sign)  { FEXP(x) = PBF_EXP_INF;  FSIGN(x) = sign < 0 ? -1 : 1; }
PBN_DEF void pbf_set_zero(pbf_ptr x, int sign) { FEXP(x) = PBF_EXP_ZERO; FSIGN(x) = sign < 0 ? -1 : 1; }

PBN_DEF void pbf_swap(pbf_ptr a, pbf_ptr b) {
    pbf_struct t = *a;
    *a = *b;
    *b = t;
}

PBN_DEF int pbf_nan_p(pbf_srcptr x)     { return FEXP(x) == PBF_EXP_NAN; }
PBN_DEF int pbf_inf_p(pbf_srcptr x)     { return FEXP(x) == PBF_EXP_INF; }
PBN_DEF int pbf_zero_p(pbf_srcptr x)    { return FEXP(x) == PBF_EXP_ZERO; }
PBN_DEF int pbf_number_p(pbf_srcptr x)  { return FEXP(x) != PBF_EXP_NAN && FEXP(x) != PBF_EXP_INF; }
PBN_DEF int pbf_regular_p(pbf_srcptr x) { return FEXP(x) > PBF_EXP_INF; }
PBN_DEF int pbf_signbit(pbf_srcptr x)   { return FSIGN(x) < 0; }
PBN_DEF int pbf_sgn(pbf_srcptr x) {
    if (FEXP(x) == PBF_EXP_ZERO || FEXP(x) == PBF_EXP_NAN) return 0;
    return FSIGN(x) < 0 ? -1 : 1;
}

/* ---- operand views: a uniform (class, sign, M, e) picture of any input ---- */

enum { PBF_C_ZERO, PBF_C_NUM, PBF_C_INF, PBF_C_NAN };

typedef struct {
    int cls, sign;
    const pbn_limb *mp;   /* magnitude M (normalized, may have trailing zero bits) */
    pbn_size mn;
    long e;               /* value = sign * M * 2^e */
    long ex;              /* e + bitlen(M): value in [2^(ex-1), 2^ex) */
} pbf_view;

static long pbn_bitlen_n(const pbn_limb *p, pbn_size n) {
    return (long)n * PBN_B - pbn_clz(p[n - 1]);
}

static pbf_view pbf_view_of(pbf_srcptr x) {
    pbf_view v;
    v.sign = FSIGN(x) < 0 ? -1 : 1;
    v.mp = NULL; v.mn = 0; v.e = 0; v.ex = 0;
    if (FEXP(x) == PBF_EXP_ZERO)     v.cls = PBF_C_ZERO;
    else if (FEXP(x) == PBF_EXP_NAN) v.cls = PBF_C_NAN;
    else if (FEXP(x) == PBF_EXP_INF) v.cls = PBF_C_INF;
    else {
        pbn_size n = PBF_NLIMBS(FPREC(x)), k = 0;
        const pbn_limb *p = FPTR(x);
        while (p[k] == 0) k++;
        v.cls = PBF_C_NUM;
        v.mp = p + k;
        v.mn = n - k;
        v.e = FEXP(x) - (long)(n - k) * PBN_B;
        v.ex = FEXP(x);
    }
    return v;
}

static pbf_view pbf_view_z(pbz_srcptr z) {
    pbf_view v;
    v.sign = SIZ(z) < 0 ? -1 : 1;
    v.mp = PTR(z);
    v.mn = PBN_ABS(SIZ(z));
    v.e = 0;
    v.cls = v.mn ? PBF_C_NUM : PBF_C_ZERO;
    v.ex = v.mn ? pbn_bitlen_n(v.mp, v.mn) : 0;
    return v;
}

static pbf_view pbf_view_u64(uint64_t u, int sign, pbn_limb *buf) {
    pbf_view v;
    v.sign = sign;
    v.mp = buf;
    v.mn = pbn_from_u64(buf, u);
    v.e = 0;
    v.cls = v.mn ? PBF_C_NUM : PBF_C_ZERO;
    v.ex = v.mn ? pbn_bitlen_n(buf, v.mn) : 0;
    return v;
}

static pbf_view pbf_view_d(double d, pbn_limb *buf) {
    pbf_view v;
    int e;
    if (d != d) { v.cls = PBF_C_NAN; v.sign = 1; v.mp = NULL; v.mn = 0; v.e = v.ex = 0; return v; }
    if (d - d != 0) { v.cls = PBF_C_INF; v.sign = d < 0 ? -1 : 1; v.mp = NULL; v.mn = 0; v.e = v.ex = 0; return v; }
    if (d == 0) { v.cls = PBF_C_ZERO; v.sign = signbit(d) ? -1 : 1; v.mp = NULL; v.mn = 0; v.e = v.ex = 0; return v; }
    v = pbf_view_u64((uint64_t)ldexp(frexp(fabs(d), &e), 53), d < 0 ? -1 : 1, buf);
    v.e = e - 53;
    v.ex = e;
    return v;
}

/* bits [pos, pos+B) of an mn-limb number; pos may be negative or beyond the top */
PBN_INLINE pbn_limb pbn_bits_at(const pbn_limb *mp, pbn_size mn, long pos) {
    pbn_size li;
    unsigned bi;
    pbn_limb v;
    if (pos <= -(long)PBN_B || pos >= (long)mn * PBN_B) return 0;
    if (pos < 0) return mp[0] << (unsigned)(-pos);
    li = (pbn_size)(pos / PBN_B);
    bi = (unsigned)(pos % PBN_B);
    v = mp[li] >> bi;
    if (bi && li + 1 < mn) v |= mp[li + 1] << (PBN_B - bi);
    return v;
}

static int pbn_getbit(const pbn_limb *mp, pbn_size mn, long pos) {
    if (pos < 0 || pos >= (long)mn * PBN_B) return 0;
    return (int)((mp[pos / PBN_B] >> (pos % PBN_B)) & 1);
}

/* any bit set in positions [0, nbits) ? */
static int pbn_anybits(const pbn_limb *mp, pbn_size mn, long nbits) {
    pbn_size i, full;
    unsigned rem;
    if (nbits <= 0) return 0;
    if (nbits >= (long)mn * PBN_B) nbits = (long)mn * PBN_B;
    full = (pbn_size)(nbits / PBN_B);
    rem = (unsigned)(nbits % PBN_B);
    for (i = 0; i < full; i++) if (mp[i]) return 1;
    if (rem && (mp[full] & (((pbn_limb)1 << rem) - 1))) return 1;
    return 0;
}

/* top bits of |v| as a double in [0.5, 1) */
static double pbf_top_frac(const pbf_view *v) {
    long L = v->ex - v->e;
    uint64_t t = L >= 64 ? pbn_getbits64(v->mp, v->mn, (pbn_bitcnt)(L - 64))
                         : pbn_getbits64(v->mp, v->mn, 0) << (64 - L);
    return ldexp((double)(t >> 11), -53);
}

static double pbf_log2_abs(const pbf_view *v) { return (double)v->ex + log2(pbf_top_frac(v)); }

/* ---- rounding core ---- */

static int pbf_away(int sign, pbf_rnd_t rnd) {
    return rnd == PBF_RNDN || rnd == PBF_RNDA || (rnd == PBF_RNDU && sign > 0) || (rnd == PBF_RNDD && sign < 0);
}

static int pbf_overflow(pbf_ptr r, int sign, pbf_rnd_t rnd) {
    if (pbf_away(sign, rnd)) {
        pbf_set_inf(r, sign);
        return sign;
    } else {
        pbn_size n = PBF_NLIMBS(FPREC(r)), i;
        unsigned low = (unsigned)((long)n * PBN_B - FPREC(r));
        for (i = 0; i < n; i++) FPTR(r)[i] = PBN_LIMB_MAX;
        if (low) FPTR(r)[0] &= ~(((pbn_limb)1 << low) - 1);
        FEXP(r) = PBF_EMAX;
        FSIGN(r) = sign;
        return -sign;
    }
}

static int pbf_underflow(pbf_ptr r, int sign, pbf_rnd_t rnd, int to_min) {
    int away = rnd == PBF_RNDA || (rnd == PBF_RNDU && sign > 0) || (rnd == PBF_RNDD && sign < 0) ||
               ((rnd == PBF_RNDN || rnd == PBF_RNDF || rnd == PBF_RNDNA) && to_min);
    if (away) {
        pbn_size n = PBF_NLIMBS(FPREC(r));
        pbn_n_zero(FPTR(r), n);
        FPTR(r)[n - 1] = PBN_HIGHBIT;
        FEXP(r) = PBF_EMIN;
        FSIGN(r) = sign;
        return sign;
    }
    pbf_set_zero(r, sign);
    return -sign;
}

/* Store sign * (M + sticky*epsilon) * 2^e into r, rounded to r's precision.
   sticky means "the true value is strictly inside (M, M+1) * 2^e"; callers
   guarantee M then has at least prec+2 bits. Returns the ternary value. */
static int pbf_round(pbf_ptr r, int sign, const pbn_limb *mp, pbn_size mn, long e, int sticky,
                     pbf_rnd_t rnd, int chk) {
    pbf_prec_t p = FPREC(r);
    pbn_size n = PBF_NLIMBS(p), i;
    pbn_limb *rp = FPTR(r), *cp = NULL;
    unsigned low = (unsigned)((long)n * PBN_B - p);
    long L, ex;
    int tern;
    PBN_TMP_DECL(cb);

    PBN_NORM(mp, mn);
    if (mn == 0) { pbf_set_zero(r, sign); return 0; }
    if (rnd == PBF_RNDF || rnd == PBF_RNDNA) rnd = PBF_RNDN;
    if (mp < rp + n && mp + mn > rp) {
        cp = PBN_TMP_GET(cb, mn);
        pbn_n_copy(cp, mp, mn);
        mp = cp;
    }
    L = pbn_bitlen_n(mp, mn);
    ex = e + L;
    for (i = 0; i < n; i++) rp[i] = pbn_bits_at(mp, mn, (long)i * PBN_B - ((long)n * PBN_B - L));

    if (L <= p) {
        tern = sticky ? -sign : 0;
    } else {
        long k = L - p;
        int half = pbn_getbit(mp, mn, k - 1);
        int rest = sticky || pbn_anybits(mp, mn, k - 1);
        int inexact = half || rest, inc = 0;
        if (low) rp[0] &= ~(((pbn_limb)1 << low) - 1);
        switch (rnd) {
            case PBF_RNDN: inc = half && (rest || ((rp[0] >> low) & 1)); break;
            case PBF_RNDZ: inc = 0; break;
            case PBF_RNDA: inc = inexact; break;
            case PBF_RNDU: inc = inexact && sign > 0; break;
            case PBF_RNDD: inc = inexact && sign < 0; break;
            default:       inc = half && (rest || ((rp[0] >> low) & 1)); break;
        }
        if (inc && pbn_n_add_1(rp, rp, n, (pbn_limb)1 << low)) {
            rp[n - 1] = PBN_HIGHBIT;
            ex++;
        }
        tern = !inexact ? 0 : (inc ? sign : -sign);
    }
    if (cp) PBN_TMP_PUT(cb, cp, mn);
    FSIGN(r) = sign;
    FEXP(r) = ex;

    if (chk) {
        if (ex > PBF_EMAX) return pbf_overflow(r, sign, rnd);
        if (ex < PBF_EMIN) {
            int to_min = 0;
            if (ex == PBF_EMIN - 1) {
                int pow2 = rp[n - 1] == PBN_HIGHBIT;
                for (i = 0; i + 1 < n && pow2; i++) pow2 = rp[i] == 0;
                to_min = !pow2 || tern * sign < 0;
            }
            return pbf_underflow(r, sign, rnd, to_min);
        }
    }
    return tern;
}

static int pbf_set_v(pbf_ptr r, pbf_view v, pbf_rnd_t rnd, int chk) {
    switch (v.cls) {
        case PBF_C_NAN:  pbf_set_nan(r); return 0;
        case PBF_C_INF:  pbf_set_inf(r, v.sign); return 0;
        case PBF_C_ZERO: pbf_set_zero(r, v.sign); return 0;
        default:         return pbf_round(r, v.sign, v.mp, v.mn, v.e, 0, rnd, chk);
    }
}

PBN_DEF int pbf_set(pbf_ptr r, pbf_srcptr a, pbf_rnd_t rnd) { return pbf_set_v(r, pbf_view_of(a), rnd, 1); }
PBN_DEF int pbf_set_z(pbf_ptr r, pbz_srcptr z, pbf_rnd_t rnd) { return pbf_set_v(r, pbf_view_z(z), rnd, 1); }

PBN_DEF int pbf_set_d(pbf_ptr r, double d, pbf_rnd_t rnd) {
    pbn_limb buf[2];
    return pbf_set_v(r, pbf_view_d(d, buf), rnd, 1);
}

PBN_DEF int pbf_set_ui(pbf_ptr r, unsigned long u, pbf_rnd_t rnd) {
    pbn_limb buf[2];
    return pbf_set_v(r, pbf_view_u64((uint64_t)u, 1, buf), rnd, 1);
}

PBN_DEF int pbf_set_si(pbf_ptr r, long s, pbf_rnd_t rnd) {
    pbn_limb buf[2];
    uint64_t m = s < 0 ? (uint64_t)0 - (uint64_t)s : (uint64_t)s;
    return pbf_set_v(r, pbf_view_u64(m, s < 0 ? -1 : 1, buf), rnd, 1);
}

/* ---- comparison ---- */

static int pbf_cmpabs_v(const pbf_view *a, const pbf_view *b) {
    long la = a->ex - a->e, lb = b->ex - b->e, c;
    if (a->ex != b->ex) return a->ex > b->ex ? 1 : -1;
    for (c = 1;; c++) {
        long pa = la - c * PBN_B, pb = lb - c * PBN_B;
        pbn_limb va, vb;
        if (pa <= -(long)PBN_B && pb <= -(long)PBN_B) return 0;
        va = pbn_bits_at(a->mp, a->mn, pa);
        vb = pbn_bits_at(b->mp, b->mn, pb);
        if (va != vb) return va > vb ? 1 : -1;
    }
}

static int pbf_cmp_v(pbf_view a, pbf_view b) {
    if (a.cls == PBF_C_NAN || b.cls == PBF_C_NAN) return 0;
    if (a.cls == PBF_C_INF) return (b.cls == PBF_C_INF && a.sign == b.sign) ? 0 : a.sign;
    if (b.cls == PBF_C_INF) return -b.sign;
    if (a.cls == PBF_C_ZERO) return b.cls == PBF_C_ZERO ? 0 : -b.sign;
    if (b.cls == PBF_C_ZERO) return a.sign;
    if (a.sign != b.sign) return a.sign;
    return a.sign * pbf_cmpabs_v(&a, &b);
}

PBN_DEF int pbf_cmp(pbf_srcptr a, pbf_srcptr b) {
    if (FEXP(a) > PBF_EXP_INF && FEXP(b) > PBF_EXP_INF && PBF_NLIMBS(FPREC(a)) == PBF_NLIMBS(FPREC(b))) {
        int c;
        if (FSIGN(a) != FSIGN(b)) return FSIGN(a);
        if (FEXP(a) != FEXP(b)) return FEXP(a) > FEXP(b) ? FSIGN(a) : -FSIGN(a);
        c = pbn_n_cmp(FPTR(a), FPTR(b), PBF_NLIMBS(FPREC(a)));
        return FSIGN(a) > 0 ? c : -c;
    }
    return pbf_cmp_v(pbf_view_of(a), pbf_view_of(b));
}
PBN_DEF int pbf_cmp_d(pbf_srcptr a, double d) { pbn_limb buf[2]; return pbf_cmp_v(pbf_view_of(a), pbf_view_d(d, buf)); }
PBN_DEF int pbf_cmp_ui(pbf_srcptr a, unsigned long u) {
    pbn_limb buf[2];
    return pbf_cmp_v(pbf_view_of(a), pbf_view_u64((uint64_t)u, 1, buf));
}
PBN_DEF int pbf_cmp_si(pbf_srcptr a, long s) {
    pbn_limb buf[2];
    uint64_t m = s < 0 ? (uint64_t)0 - (uint64_t)s : (uint64_t)s;
    return pbf_cmp_v(pbf_view_of(a), pbf_view_u64(m, s < 0 ? -1 : 1, buf));
}

/* ---- arithmetic cores (chk = apply exponent range) ---- */

static int pbf_add_v(pbf_ptr r, pbf_view a, pbf_view b, pbf_rnd_t rnd, int chk) {
    pbf_prec_t p = FPREC(r);
    pbn_limb *tp;
    pbn_size tn, i;
    long u, emn;
    int tern;
    PBN_TMP_DECL(tb);

    if (a.cls == PBF_C_NAN || b.cls == PBF_C_NAN) { pbf_set_nan(r); return 0; }
    if (a.cls == PBF_C_INF) {
        if (b.cls == PBF_C_INF && a.sign != b.sign) { pbf_set_nan(r); return 0; }
        pbf_set_inf(r, a.sign);
        return 0;
    }
    if (b.cls == PBF_C_INF) { pbf_set_inf(r, b.sign); return 0; }
    if (a.cls == PBF_C_ZERO) {
        if (b.cls == PBF_C_ZERO) {
            pbf_set_zero(r, a.sign == b.sign ? a.sign : (rnd == PBF_RNDD ? -1 : 1));
            return 0;
        }
        return pbf_round(r, b.sign, b.mp, b.mn, b.e, 0, rnd, chk);
    }
    if (b.cls == PBF_C_ZERO) return pbf_round(r, a.sign, a.mp, a.mn, a.e, 0, rnd, chk);

    if (pbf_cmpabs_v(&a, &b) < 0) { pbf_view t = a; a = b; b = t; }

    u = PBN_MIN(a.e, a.ex - (long)p - 3);
    if (b.ex <= u) {
        /* b lies entirely below the rounding position: it only acts as a sticky bit */
        long sh = a.e - u;
        tn = a.mn + (pbn_size)(sh / PBN_B) + 1;
        tp = PBN_TMP_GET(tb, tn);
        for (i = 0; i < tn; i++) tp[i] = pbn_bits_at(a.mp, a.mn, (long)i * PBN_B - sh);
        if (a.sign != b.sign) pbn_n_sub_1(tp, tp, tn, 1);
        tern = pbf_round(r, a.sign, tp, tn, u, 1, rnd, chk);
        PBN_TMP_PUT(tb, tp, tn);
        return tern;
    }

    emn = PBN_MIN(a.e, b.e);
    tn = (pbn_size)((a.ex - emn) / PBN_B) + 2;
    tp = PBN_TMP_GET(tb, 2 * tn);
    for (i = 0; i < tn; i++) {
        tp[i]      = pbn_bits_at(a.mp, a.mn, (long)i * PBN_B - (a.e - emn));
        tp[tn + i] = pbn_bits_at(b.mp, b.mn, (long)i * PBN_B - (b.e - emn));
    }
    if (a.sign == b.sign) pbn_n_add_n(tp, tp, tp + tn, tn);
    else                  pbn_n_sub_n(tp, tp, tp + tn, tn);
    i = tn;
    PBN_NORM(tp, i);
    if (i == 0) {
        pbf_set_zero(r, rnd == PBF_RNDD ? -1 : 1);
        tern = 0;
    } else {
        tern = pbf_round(r, a.sign, tp, i, emn, 0, rnd, chk);
    }
    PBN_TMP_PUT(tb, tp, 2 * tn);
    return tern;
}

static int pbf_mul_v(pbf_ptr r, pbf_view a, pbf_view b, pbf_rnd_t rnd, int chk) {
    int sign = a.sign * b.sign, tern;
    pbn_limb *tp;
    pbn_size tn;
    PBN_TMP_DECL(tb);
    if (a.cls == PBF_C_NAN || b.cls == PBF_C_NAN) { pbf_set_nan(r); return 0; }
    if (a.cls == PBF_C_INF || b.cls == PBF_C_INF) {
        if (a.cls == PBF_C_ZERO || b.cls == PBF_C_ZERO) pbf_set_nan(r);
        else pbf_set_inf(r, sign);
        return 0;
    }
    if (a.cls == PBF_C_ZERO || b.cls == PBF_C_ZERO) { pbf_set_zero(r, sign); return 0; }
    if (a.mn < b.mn) { pbf_view t = a; a = b; b = t; }
    tn = a.mn + b.mn;
    tp = PBN_TMP_GET(tb, tn);
    if (a.mp == b.mp && a.mn == b.mn) pbn_n_sqr(tp, a.mp, a.mn);
    else pbn_n_mul(tp, a.mp, a.mn, b.mp, b.mn);
    tern = pbf_round(r, sign, tp, tn, a.e + b.e, 0, rnd, chk);
    PBN_TMP_PUT(tb, tp, tn);
    return tern;
}

static int pbf_div_v(pbf_ptr r, pbf_view a, pbf_view b, pbf_rnd_t rnd, int chk) {
    int sign = a.sign * b.sign, tern;
    long la, lb, s;
    pbn_size nn, qn, i, tsz;
    pbn_limb *tp, *np, *qp, *rp;
    PBN_TMP_DECL(tb);
    if (a.cls == PBF_C_NAN || b.cls == PBF_C_NAN) { pbf_set_nan(r); return 0; }
    if (a.cls == PBF_C_INF) {
        if (b.cls == PBF_C_INF) pbf_set_nan(r); else pbf_set_inf(r, sign);
        return 0;
    }
    if (b.cls == PBF_C_INF) { pbf_set_zero(r, sign); return 0; }
    if (b.cls == PBF_C_ZERO) {
        if (a.cls == PBF_C_ZERO) pbf_set_nan(r); else pbf_set_inf(r, sign);
        return 0;
    }
    if (a.cls == PBF_C_ZERO) { pbf_set_zero(r, sign); return 0; }

    la = a.ex - a.e;
    lb = b.ex - b.e;
    s = (long)FPREC(r) + 3 + lb - la;
    if (s < 0) s = 0;
    nn = (pbn_size)((la + s + PBN_B - 1) / PBN_B);
    qn = nn - b.mn + 1;
    tsz = nn + qn + b.mn;
    tp = PBN_TMP_GET(tb, tsz);
    np = tp; qp = tp + nn; rp = qp + qn;
    for (i = 0; i < nn; i++) np[i] = pbn_bits_at(a.mp, a.mn, (long)i * PBN_B - s);
    pbn_n_tdiv_qr(qp, rp, np, nn, b.mp, b.mn);
    i = b.mn;
    PBN_NORM(rp, i);
    tern = pbf_round(r, sign, qp, qn, a.e - b.e - s, i != 0, rnd, chk);
    PBN_TMP_PUT(tb, tp, tsz);
    return tern;
}

static pbf_view pbf_view_neg(pbf_view v) { v.sign = -v.sign; return v; }

/* ---- single-limb fast paths (all operands and result fit one limb; 64-bit limbs with __int128) ---- */

#if defined(PBN_HAVE_DLIMB) && PBN_B == 64
#define PBF_FAST 1
#define PBF_ONE(x) (FEXP(x) > PBF_EXP_INF && FPREC(x) <= PBN_B)

/* round S (128-bit, top bit set) * 2^(e - 128), plus sticky, into the 1-limb r */
static int pbf_round128(pbf_ptr r, int sign, pbn_dlimb S, long e, int sticky, pbf_rnd_t rnd) {
    pbf_prec_t p = FPREC(r);
    unsigned low = (unsigned)(PBN_B - p);
    pbn_limb hi = (pbn_limb)(S >> PBN_B), lo = (pbn_limb)S, T, half, rest;
    long ex = e;
    int inc, inexact, tern;
    if (low == 0) {
        T = hi;
        half = lo >> (PBN_B - 1);
        rest = (lo << 1) | (pbn_limb)sticky;
    } else {
        pbn_limb mask = ((pbn_limb)1 << low) - 1;
        T = hi & ~mask;
        half = (hi >> (low - 1)) & 1;
        rest = (hi & (mask >> 1)) | lo | (pbn_limb)sticky;
    }
    inexact = half || rest;
    switch (rnd) {
        case PBF_RNDZ: inc = 0; break;
        case PBF_RNDA: inc = inexact; break;
        case PBF_RNDU: inc = inexact && sign > 0; break;
        case PBF_RNDD: inc = inexact && sign < 0; break;
        default:       inc = half && (rest || ((T >> low) & 1)); break;
    }
    if (inc) {
        T += (pbn_limb)1 << low;
        if (T == 0) { T = PBN_HIGHBIT; ex++; }
    }
    tern = !inexact ? 0 : (inc ? sign : -sign);
    if (ex > PBF_EMAX || ex < PBF_EMIN) {
        /* rare: let the generic code handle range errors */
        pbn_limb m[2];
        m[0] = lo; m[1] = hi;
        return pbf_round(r, sign, m, 2, e - 128, sticky, rnd, 1);
    }
    FPTR(r)[0] = T;
    FEXP(r) = ex;
    FSIGN(r) = sign;
    return tern;
}

static int pbf_add1(pbf_ptr r, pbf_srcptr a, pbf_srcptr b, int bneg, pbf_rnd_t rnd) {
    pbn_limb ma = FPTR(a)[0], mb = FPTR(b)[0];
    long ea = FEXP(a), eb = FEXP(b), d;
    int sa = FSIGN(a), sb = bneg ? -FSIGN(b) : FSIGN(b), sticky = 0;
    pbn_dlimb A, B, S;
    if (ea < eb || (ea == eb && ma < mb)) {
        pbn_limb tm = ma; long te = ea; int ts = sa;
        ma = mb; ea = eb; sa = sb;
        mb = tm; eb = te; sb = ts;
    }
    if (rnd == PBF_RNDF || rnd == PBF_RNDNA) rnd = PBF_RNDN;
    d = ea - eb;
    A = (pbn_dlimb)ma << PBN_B;
    if (d >= 2 * PBN_B) { B = 0; sticky = 1; }
    else {
        B = (pbn_dlimb)mb << PBN_B;
        if (d) {
            sticky = (B << (2 * PBN_B - d)) != 0;
            B >>= d;
        }
    }
    if (sa == sb) {
        S = A + B;
        if (S < A) {                     /* carry out of 128 bits */
            sticky |= (int)(S & 1);
            S = (S >> 1) | ((pbn_dlimb)1 << (2 * PBN_B - 1));
            ea++;
        }
    } else {
        S = A - B - (pbn_dlimb)sticky;
        if (S == 0) {
            pbf_set_zero(r, rnd == PBF_RNDD ? -1 : 1);
            return 0;
        }
        while (!(S >> (2 * PBN_B - 1))) { S <<= 1; ea--; }   /* sticky implies at most one step */
    }
    return pbf_round128(r, sa, S, ea, sticky, rnd);
}
#endif

PBN_DEF int pbf_neg(pbf_ptr r, pbf_srcptr a, pbf_rnd_t rnd) { return pbf_set_v(r, pbf_view_neg(pbf_view_of(a)), rnd, 1); }
PBN_DEF int pbf_abs(pbf_ptr r, pbf_srcptr a, pbf_rnd_t rnd) {
    pbf_view v = pbf_view_of(a);
    v.sign = 1;
    return pbf_set_v(r, v, rnd, 1);
}

PBN_DEF int pbf_add(pbf_ptr r, pbf_srcptr a, pbf_srcptr b, pbf_rnd_t rnd) {
#ifdef PBF_FAST
    if (PBF_ONE(a) && PBF_ONE(b) && FPREC(r) <= PBN_B) return pbf_add1(r, a, b, 0, rnd);
#endif
    return pbf_add_v(r, pbf_view_of(a), pbf_view_of(b), rnd, 1);
}

PBN_DEF int pbf_sub(pbf_ptr r, pbf_srcptr a, pbf_srcptr b, pbf_rnd_t rnd) {
#ifdef PBF_FAST
    if (PBF_ONE(a) && PBF_ONE(b) && FPREC(r) <= PBN_B) return pbf_add1(r, a, b, 1, rnd);
#endif
    return pbf_add_v(r, pbf_view_of(a), pbf_view_neg(pbf_view_of(b)), rnd, 1);
}

PBN_DEF int pbf_mul(pbf_ptr r, pbf_srcptr a, pbf_srcptr b, pbf_rnd_t rnd) {
#ifdef PBF_FAST
    if (PBF_ONE(a) && PBF_ONE(b) && FPREC(r) <= PBN_B) {
        pbn_dlimb P = (pbn_dlimb)FPTR(a)[0] * FPTR(b)[0];
        long e = FEXP(a) + FEXP(b);
        if (!(P >> (2 * PBN_B - 1))) { P <<= 1; e--; }
        if (rnd == PBF_RNDF || rnd == PBF_RNDNA) rnd = PBF_RNDN;
        return pbf_round128(r, FSIGN(a) * FSIGN(b), P, e, 0, rnd);
    }
#endif
    return pbf_mul_v(r, pbf_view_of(a), pbf_view_of(b), rnd, 1);
}

PBN_DEF int pbf_div(pbf_ptr r, pbf_srcptr a, pbf_srcptr b, pbf_rnd_t rnd) {
#ifdef PBF_FAST
    if (PBF_ONE(a) && PBF_ONE(b) && FPREC(r) <= PBN_B - 2) {
        /* (ma * 2^127) / mb has 127 or 128 bits */
        pbn_limb ma = FPTR(a)[0], mb = FPTR(b)[0], inv = pbn_invert_limb(mb), r1, r2, q1, q2;
        pbn_dlimb Q;
        long e = FEXP(a) - FEXP(b) + 1;
        int sticky;
        /* (ma * 2^63) / mb as two limb divisions with a precomputed reciprocal */
        q1 = pbn_div_preinv(&r1, ma >> 1, ma << (PBN_B - 1), mb, inv);
        q2 = pbn_div_preinv(&r2, r1, 0, mb, inv);
        sticky = r2 != 0;
        Q = ((pbn_dlimb)q1 << PBN_B) | q2;
        while (!(Q >> (2 * PBN_B - 1))) { Q <<= 1; e--; }
        if (rnd == PBF_RNDF || rnd == PBF_RNDNA) rnd = PBF_RNDN;
        return pbf_round128(r, FSIGN(a) * FSIGN(b), Q, e, sticky, rnd);
    }
#endif
    return pbf_div_v(r, pbf_view_of(a), pbf_view_of(b), rnd, 1);
}

/* an integer zero is unsigned: x +/- 0 is just x (as in MPFR) */
PBN_DEF int pbf_add_z(pbf_ptr r, pbf_srcptr a, pbz_srcptr b, pbf_rnd_t rnd) {
    if (SIZ(b) == 0) return pbf_set(r, a, rnd);
    return pbf_add_v(r, pbf_view_of(a), pbf_view_z(b), rnd, 1);
}
PBN_DEF int pbf_sub_z(pbf_ptr r, pbf_srcptr a, pbz_srcptr b, pbf_rnd_t rnd) {
    if (SIZ(b) == 0) return pbf_set(r, a, rnd);
    return pbf_add_v(r, pbf_view_of(a), pbf_view_neg(pbf_view_z(b)), rnd, 1);
}
PBN_DEF int pbf_mul_z(pbf_ptr r, pbf_srcptr a, pbz_srcptr b, pbf_rnd_t rnd) { return pbf_mul_v(r, pbf_view_of(a), pbf_view_z(b), rnd, 1); }
PBN_DEF int pbf_div_z(pbf_ptr r, pbf_srcptr a, pbz_srcptr b, pbf_rnd_t rnd) { return pbf_div_v(r, pbf_view_of(a), pbf_view_z(b), rnd, 1); }

PBN_DEF int pbf_add_d(pbf_ptr r, pbf_srcptr a, double b, pbf_rnd_t rnd) { pbn_limb t[2]; return pbf_add_v(r, pbf_view_of(a), pbf_view_d(b, t), rnd, 1); }
PBN_DEF int pbf_sub_d(pbf_ptr r, pbf_srcptr a, double b, pbf_rnd_t rnd) { pbn_limb t[2]; return pbf_add_v(r, pbf_view_of(a), pbf_view_neg(pbf_view_d(b, t)), rnd, 1); }
PBN_DEF int pbf_mul_d(pbf_ptr r, pbf_srcptr a, double b, pbf_rnd_t rnd) { pbn_limb t[2]; return pbf_mul_v(r, pbf_view_of(a), pbf_view_d(b, t), rnd, 1); }
PBN_DEF int pbf_div_d(pbf_ptr r, pbf_srcptr a, double b, pbf_rnd_t rnd) { pbn_limb t[2]; return pbf_div_v(r, pbf_view_of(a), pbf_view_d(b, t), rnd, 1); }

/* ---- conversions out ---- */

PBN_DEF double pbf_get_d(pbf_srcptr x, pbf_rnd_t rnd) {
    pbf_view v = pbf_view_of(x);
    pbf_struct t;
    pbn_limb buf[2];
    long pe;
    double d;
    if (v.cls == PBF_C_NAN) return NAN;
    if (v.cls == PBF_C_INF) return v.sign * HUGE_VAL;
    if (v.cls == PBF_C_ZERO) return v.sign < 0 ? -0.0 : 0.0;
    if (rnd == PBF_RNDF || rnd == PBF_RNDNA) rnd = PBF_RNDN;
    if (FPREC(x) <= 53 && v.ex - 1 >= -1022 && v.ex <= 1024) {
        pbn_size n = PBF_NLIMBS(FPREC(x));
        uint64_t m;
        if (PBN_B == 64)  m = (uint64_t)FPTR(x)[n - 1];
        else if (n >= 2)  m = ((uint64_t)FPTR(x)[n - 1] << (PBN_B / 2) << (PBN_B / 2)) | (uint64_t)FPTR(x)[n - 2];
        else              m = (uint64_t)FPTR(x)[0] << (PBN_B / 2) << (PBN_B / 2);
        d = ldexp((double)(m >> 11), (int)v.ex - 53);
        return v.sign < 0 ? -d : d;
    }
    pe = 53;
    if (v.ex - 1 < -1022) pe = v.ex + 1074;
    if (pe <= 0) {
        int up;
        switch (rnd) {
            case PBF_RNDN: up = pe == 0 && !(v.mn == 1 && pbn_popcount_limb(v.mp[0]) == 1); break;
            case PBF_RNDA: up = 1; break;
            case PBF_RNDU: up = v.sign > 0; break;
            case PBF_RNDD: up = v.sign < 0; break;
            default:       up = 0; break;
        }
        d = up ? ldexp(1.0, -1074) : 0.0;
        return v.sign < 0 ? -d : d;
    }
    t._mpfr_prec = pe;
    t._mpfr_d = buf;
    pbf_round(&t, v.sign, v.mp, v.mn, v.e, 0, rnd, 0);
    if (t._mpfr_exp > 1024) {
        d = pbf_away(v.sign, rnd) ? HUGE_VAL : DBL_MAX;
    } else {
        pbn_size n = PBF_NLIMBS(pe);
        uint64_t m;
        if (PBN_B == 64)  m = (uint64_t)buf[n - 1];
        else if (n >= 2)  m = ((uint64_t)buf[n - 1] << (PBN_B / 2) << (PBN_B / 2)) | (uint64_t)buf[n - 2];
        else              m = (uint64_t)buf[0] << (PBN_B / 2) << (PBN_B / 2);
        d = ldexp((double)m, (int)t._mpfr_exp - 64);
        if (d - d != 0 && !pbf_away(v.sign, rnd)) d = DBL_MAX;
    }
    return v.sign < 0 ? -d : d;
}

/* round a regular view to an integer */
static void pbf_rint_z(pbz_ptr z, const pbf_view *v, pbf_rnd_t rnd) {
    pbz_t m;
    pbz_roinit_n(m, v->mp, v->mn);
    if (v->e >= 0) {
        pbz_mul_2exp(z, m, (pbn_bitcnt)v->e);
    } else {
        long k = -v->e;
        int half = pbn_getbit(v->mp, v->mn, k - 1);
        int rest = pbn_anybits(v->mp, v->mn, k - 1);
        int inexact = half || rest, inc;
        pbz_tdiv_q_2exp(z, m, (pbn_bitcnt)k);
        switch (rnd) {
            case PBF_RNDZ: inc = 0; break;
            case PBF_RNDA: inc = inexact; break;
            case PBF_RNDU: inc = inexact && v->sign > 0; break;
            case PBF_RNDD: inc = inexact && v->sign < 0; break;
            default:       inc = half && (rest || pbz_odd_p(z)); break;
        }
        if (inc) pbz_add_ui(z, z, 1);
    }
    if (v->sign < 0) pbz_neg(z, z);
}

PBN_DEF int pbf_fits_uint_p(pbf_srcptr x, pbf_rnd_t rnd) {
    pbf_view v = pbf_view_of(x);
    pbz_t z;
    int ok;
    if (v.cls == PBF_C_NAN || v.cls == PBF_C_INF) return 0;
    if (v.cls == PBF_C_ZERO) return 1;
    if (v.ex > (long)(sizeof(unsigned int) * CHAR_BIT) + 1) return 0;
    pbz_init(z);
    pbf_rint_z(z, &v, rnd);
    ok = SIZ(z) >= 0 && pbz_cmp_ui(z, UINT_MAX) <= 0;
    pbz_clear(z);
    return ok;
}

/* ---- string output ---- */

static int  pbf_pow_z_v(pbf_ptr r, pbf_view x, pbz_srcptr z, pbf_rnd_t rnd, int chk);
static int  pbf_can_round(pbf_srcptr b, long err, int sign, pbf_prec_t p, pbf_rnd_t rnd);

#define PBF_EXACT_LIMIT 20000   /* bits: above this, radix conversion switches to Ziv */

/* y ~ |v| * b^k with relative error < 2^(2 - prec(y)) (no exponent range checks) */
static void pbf_scale_pow(pbf_ptr y, pbf_view v, int b, long k) {
    pbf_t P, bf;
    pbz_t kz;
    pbn_limb b1[2];
    unsigned long ak = k < 0 ? 0UL - (unsigned long)k : (unsigned long)k;
    pbf_init2(P, FPREC(y));
    pbf_init2(bf, 64);
    pbz_init(kz);
    pbz_set_ui(kz, ak);
    pbf_set_v(bf, pbf_view_u64((uint64_t)b, 1, b1), PBF_RNDN, 0);
    pbf_pow_z_v(P, pbf_view_of(bf), kz, PBF_RNDN, 0);
    v.sign = 1;
    if (k >= 0) pbf_mul_v(y, v, pbf_view_of(P), PBF_RNDN, 0);
    else        pbf_div_v(y, v, pbf_view_of(P), PBF_RNDN, 0);
    pbz_clear(kz);
    pbf_clear(bf);
    pbf_clear(P);
}

/* q = |v| * b^k rounded to an integer (rnd applied with v's sign) */
static int pbf_scaled_int(pbz_ptr q, const pbf_view *v, int b, long k, pbf_rnd_t rnd) {
    int lg = pbn_log2_exact(b);
    pbf_view a = *v;
    a.sign = v->sign;
    if (lg) {
        /* power-of-two base: pure shift */
        a.e += (long)lg * k;
        a.ex += (long)lg * k;
        pbf_rint_z(q, &a, rnd);
        SIZ(q) = PBN_ABS(SIZ(q));
        return 0;   /* direction not needed for power-of-two bases */
    } else if (PBN_ABS(v->e) + (double)PBN_ABS(k) * log2((double)b) <= PBF_EXACT_LIMIT) {
        pbz_t M, num, den, rr;
        int inexact, inc, c;
        pbz_inits(num, den, rr, (pbz_ptr)NULL);
        pbz_roinit_n(M, v->mp, v->mn);
        pbz_set(num, M);
        pbz_set_ui(den, 1);
        if (v->e > 0) pbz_mul_2exp(num, num, (pbn_bitcnt)v->e);
        else if (v->e < 0) pbz_mul_2exp(den, den, (pbn_bitcnt)-v->e);
        if (k > 0) { pbz_ui_pow_ui(q, (unsigned long)b, (unsigned long)k); pbz_mul(num, num, q); }
        else if (k < 0) { pbz_ui_pow_ui(q, (unsigned long)b, (unsigned long)-k); pbz_mul(den, den, q); }
        pbz_tdiv_qr(q, rr, num, den);
        inexact = SIZ(rr) != 0;
        switch (rnd) {
            case PBF_RNDZ: inc = 0; break;
            case PBF_RNDA: inc = inexact; break;
            case PBF_RNDU: inc = inexact && v->sign > 0; break;
            case PBF_RNDD: inc = inexact && v->sign < 0; break;
            default:
                pbz_mul_2exp(rr, rr, 1);
                c = pbz_cmp(rr, den);
                inc = c > 0 || (c == 0 && pbz_odd_p(q));
                break;
        }
        if (inc) pbz_add_ui(q, q, 1);
        pbz_clears(num, den, rr, (pbz_ptr)NULL);
        return !inexact ? 0 : (inc ? 1 : -1);
    } else {
        /* huge scaling: Ziv loop until the integer rounding is decided */
        long w = (long)(a.ex - a.e) + 96 + (long)(64 * log2((double)b));
        for (;;) {
            pbf_t y;
            pbf_view yv, lv, hv;
            pbz_t lo, hi, M, eps, q2;
            long err, sc;
            pbf_init2(y, w);
            pbf_scale_pow(y, a, b, k);
            yv = pbf_view_of(y);
            err = yv.ex - w + 3;
            sc = PBN_MIN(yv.e, err);
            pbz_inits(lo, hi, eps, q2, (pbz_ptr)NULL);
            pbz_roinit_n(M, yv.mp, yv.mn);
            pbz_mul_2exp(lo, M, (pbn_bitcnt)(yv.e - sc));
            pbz_set_ui(eps, 1);
            pbz_mul_2exp(eps, eps, (pbn_bitcnt)(err - sc));
            pbz_add(hi, lo, eps);
            pbz_sub(lo, lo, eps);
            if (SIZ(lo) > 0) {
                lv = pbf_view_z(lo); lv.e = sc; lv.ex += sc; lv.sign = v->sign;
                hv = pbf_view_z(hi); hv.e = sc; hv.ex += sc; hv.sign = v->sign;
                pbf_rint_z(q, &lv, rnd);
                pbf_rint_z(q2, &hv, rnd);
                if (pbz_cmp(q, q2) == 0) {
                    /* also need N outside [lo, hi] to know the rounding direction */
                    int dir = 0;
                    SIZ(q) = PBN_ABS(SIZ(q));
                    pbz_mul_2exp(q2, q, (pbn_bitcnt)(sc < 0 ? -sc : 0));
                    if (sc > 0) { pbz_mul_2exp(lo, lo, (pbn_bitcnt)sc); pbz_mul_2exp(hi, hi, (pbn_bitcnt)sc); }
                    if (pbz_cmp(q2, lo) <= 0) dir = -1;
                    else if (pbz_cmp(q2, hi) >= 0) dir = 1;
                    if (dir) {
                        pbz_clears(lo, hi, eps, q2, (pbz_ptr)NULL);
                        pbf_clear(y);
                        return dir;
                    }
                }
            }
            pbz_clears(lo, hi, eps, q2, (pbz_ptr)NULL);
            pbf_clear(y);
            w += w / 2 + 32;
        }
    }
}

PBN_DEF size_t pbf_get_str_ndigits(int b, pbf_prec_t p) {
    int k = pbn_log2_exact(b);
    if (k) return 1 + (size_t)((p + k - 2) / k);
    return 1 + (size_t)ceil((double)p * (log(2.0) / log((double)b)));
}

static char *pbf_str_out(char *str, const char *s) {
    size_t n = strlen(s) + 1;
    if (!str) str = (char *)pbn_alloc_fn(n);
    memcpy(str, s, n);
    return str;
}

PBN_DEF char *pbf_get_str(char *str, pbf_exp_t *expptr, int b, size_t n, pbf_srcptr x, pbf_rnd_t rnd) {
    pbf_view v = pbf_view_of(x);
    size_t m, len = 0;
    char *out;
    if (b < 2 || b > 62) return NULL;
    if (v.cls == PBF_C_NAN) return pbf_str_out(str, "@NaN@");
    if (v.cls == PBF_C_INF) return pbf_str_out(str, v.sign < 0 ? "-@Inf@" : "@Inf@");
    if (rnd == PBF_RNDF || rnd == PBF_RNDNA) rnd = PBF_RNDN;
    m = n ? n : pbf_get_str_ndigits(b, FPREC(x));
    out = str ? str : (char *)pbn_alloc_fn(m + 2);
    if (v.sign < 0) out[len++] = '-';
    if (v.cls == PBF_C_ZERO) {
        memset(out + len, '0', m);
        out[len + m] = '\0';
        *expptr = 0;
    } else {
        pbz_t q, bm, bm1;
        pbz_inits(q, bm, bm1, (pbz_ptr)NULL);
        if (pbn_log2_exact(b)) {
            /* power-of-two base: single correct rounding of |x| to m digits */
            long E = (long)floor(pbf_log2_abs(&v) * (log(2.0) / log((double)b))) + 1;
            pbz_ui_pow_ui(bm, (unsigned long)b, (unsigned long)m);
            pbz_ui_pow_ui(bm1, (unsigned long)b, (unsigned long)(m - 1));
            /* find E on the truncated value (the double estimate can be off by one near
               a power of b, and a rounded value can land exactly on b^(m-1) for the wrong E),
               then round once */
            for (;;) {
                pbf_scaled_int(q, &v, b, (long)m - E, PBF_RNDZ);
                if (pbz_cmp(q, bm) >= 0) { E++; continue; }
                if (pbz_cmp(q, bm1) < 0) { E--; continue; }
                break;
            }
            pbf_scaled_int(q, &v, b, (long)m - E, rnd);
            if (pbz_cmp(q, bm) >= 0) {   /* rounded up to b^m */
                pbz_set(q, bm1);
                E++;
            }
            pbz_get_str(out + len, b, q);
            *expptr = E;
        } else {
            /* other bases: MPFR's exact algorithm. g = ceil((EXP(x)-1) log_b 2) is the
               exponent or one less; in the latter case m+1 digits are produced and the
               digit string is rounded a second time, with MPFR's rules. */
            long g = (long)ceil((double)(v.ex - 1) * (log(2.0) / log((double)b)));
            int dir = pbf_scaled_int(q, &v, b, (long)m - g, rnd);
            size_t L;
            char *d = (char *)pbn_alloc_fn(m + 4);
            pbz_get_str(d, b, q);
            L = strlen(d);
            if (L == m + 2) {
                d[0] = '1';
                memset(d + 1, '0', m - 1);
                g += 2;
            } else if (L == m + 1) {
                int last = pbn_digit_value((unsigned char)d[m], b), up;
                int away = rnd == PBF_RNDA || (rnd == PBF_RNDU && v.sign > 0) || (rnd == PBF_RNDD && v.sign < 0);
                if (dir == 0 && last == 0) up = 0;
                else if (rnd == PBF_RNDN) {
                    if (2 * last < b) up = 0;
                    else if (2 * last > b) up = 1;
                    else if (dir == 0) up = pbn_digit_value((unsigned char)d[m - 1], b) & 1;
                    else up = dir < 0;
                } else {
                    up = away && last != 0;
                }
                d[m] = '\0';
                if (up) {
                    const char *digs = b <= 36 ? pbn_digits_lower : pbn_digits_62;
                    long i = (long)m - 1;
                    while (i >= 0 && pbn_digit_value((unsigned char)d[i], b) == b - 1) d[i--] = '0';
                    if (i >= 0) d[i] = digs[pbn_digit_value((unsigned char)d[i], b) + 1];
                    else { d[0] = '1'; g++; }   /* cannot happen (MPFR asserts), kept for safety */
                }
                g += 1;
            }
            d[m] = '\0';
            memcpy(out + len, d, m + 1);
            pbn_free_fn(d, m + 4);
            *expptr = g;
        }
        pbz_clears(q, bm, bm1, (pbz_ptr)NULL);
    }
    if (!str && strlen(out) + 1 != m + 2) out = (char *)pbn_realloc_fn(out, m + 2, strlen(out) + 1);
    return out;
}

/* ---- string input ---- */

static int pbf_match_ci(const char *s, const char *w) {
    size_t i;
    for (i = 0; w[i]; i++) {
        int c = (unsigned char)s[i];
        if (c >= 'A' && c <= 'Z') c += 'a' - 'A';
        if (c != w[i]) return 0;
    }
    return (int)i;
}

static int pbf_digit(int c, int base) {
    int d = pbn_digit_value(c, base);
    return d < base ? d : -1;
}

/* value = sign * D * base^e10 * 2^e2 rounded into r */
static int pbf_set_scaled(pbf_ptr r, int sign, pbz_srcptr D, int base, long e10, long e2, pbf_rnd_t rnd) {
    PBZ_STACK(num, 16);
    PBZ_STACK(den, 16);
    PBZ_STACK(q, 16);
    PBZ_STACK(rem, 16);
    double est;
    int tern;
    pbf_view v = pbf_view_z(D);
    if (v.cls == PBF_C_ZERO) { pbf_set_zero(r, sign); return 0; }
    est = pbf_log2_abs(&v) + (double)e10 * log2((double)base) + (double)e2;
    if (est > (double)PBF_EMAX + 8) return pbf_overflow(r, sign, rnd);
    if (est < (double)PBF_EMIN - 8) return pbf_underflow(r, sign, rnd, 0);
    if (pbn_log2_exact(base)) {
        e2 += (long)pbn_log2_exact(base) * e10;
        e10 = 0;
    } else if ((double)PBN_ABS(e10) * log2((double)base) > PBF_EXACT_LIMIT) {
        long w = (long)FPREC(r) + 32;
        v.sign = sign;
        for (;;) {
            pbf_t y;
            pbf_init2(y, w);
            pbf_scale_pow(y, v, base, e10);
            FEXP(y) += e2;
            if (pbf_can_round(y, FEXP(y) - w + 3, sign, FPREC(r), rnd)) {
                pbf_view yv = pbf_view_of(y);
                tern = pbf_round(r, sign, yv.mp, yv.mn, yv.e, 0, rnd, 1);
                pbf_clear(y);
                return tern;
            }
            pbf_clear(y);
            w += w / 2 + 32;
        }
    }
    if (e10 >= 0) {
        pbz_ui_pow_ui(num, (unsigned long)base, (unsigned long)e10);
        pbz_mul(num, num, D);
        tern = pbf_round(r, sign, PTR(num), SIZ(num), e2, 0, rnd, 1);
    } else {
        long s;
        pbz_ui_pow_ui(den, (unsigned long)base, (unsigned long)-e10);
        s = (long)FPREC(r) + 3 + (long)pbz_bitlen(den) - (long)pbz_bitlen(D);
        if (s < 0) s = 0;
        pbz_mul_2exp(num, D, (pbn_bitcnt)s);
        pbz_tdiv_qr(q, rem, num, den);
        tern = pbf_round(r, sign, PTR(q), SIZ(q), e2 - s, SIZ(rem) != 0, rnd, 1);
    }
    pbz_clear(num); pbz_clear(den); pbz_clear(q); pbz_clear(rem);
    return tern;
}

static long pbf_parse_exp(const char **pp, int *ok) {
    const char *p = *pp;
    int neg = 0;
    long v = 0;
    if (*p == '+' || *p == '-') { neg = *p == '-'; p++; }
    if (*p < '0' || *p > '9') { *ok = 0; return 0; }
    while (*p >= '0' && *p <= '9') {
        if (v < LONG_MAX / 16) v = v * 10 + (*p - '0');
        p++;
    }
    *pp = p;
    *ok = 1;
    return neg ? -v : v;
}

PBN_DEF int pbf_set_str(pbf_ptr r, const char *s, int base, pbf_rnd_t rnd) {
    const char *p = s;
    int sign = 1, b = base, k, ok;
    unsigned char *dv, dvbuf[128];
    size_t nd = 0, nfrac = 0, cap;
    long e10 = 0, e2 = 0;
    PBZ_STACK(D, 16);

    if (base != 0 && (base < 2 || base > 62)) return -1;
    if (!*s) return -1;
    while (pbn_isspace((unsigned char)*p)) p++;
    if (*p == '+' || *p == '-') { sign = *p == '-' ? -1 : 1; p++; }

    /* special values */
    if ((k = pbf_match_ci(p, "@nan@")) != 0 || ((base <= 16) && (k = pbf_match_ci(p, "nan")) != 0)) {
        p += k;
        if (*p == '(') {
            const char *q = p + 1;
            while ((*q >= '0' && *q <= '9') || (*q >= 'a' && *q <= 'z') || (*q >= 'A' && *q <= 'Z') || *q == '_') q++;
            if (*q == ')') p = q + 1;
        }
        pbf_set_nan(r);
        return *p ? -1 : 0;
    }
    if ((k = pbf_match_ci(p, "@inf@")) != 0 || ((base <= 16) &&
        ((k = pbf_match_ci(p, "infinity")) != 0 || (k = pbf_match_ci(p, "inf")) != 0))) {
        p += k;
        pbf_set_inf(r, sign);
        return *p ? -1 : 0;
    }

    /* base prefixes */
    if (p[0] == '0' && (p[1] == 'x' || p[1] == 'X') && (b == 0 || b == 16) &&
        (pbf_digit((unsigned char)p[2], 16) >= 0 || (p[2] == '.' && pbf_digit((unsigned char)p[3], 16) >= 0))) {
        b = 16; p += 2;
    } else if (p[0] == '0' && (p[1] == 'b' || p[1] == 'B') && (b == 0 || b == 2) &&
               (pbf_digit((unsigned char)p[2], 2) >= 0 || (p[2] == '.' && pbf_digit((unsigned char)p[3], 2) >= 0))) {
        b = 2; p += 2;
    } else if (b == 0) {
        b = 10;
    }

    cap = strlen(p) + 1;
    dv = cap <= sizeof dvbuf ? dvbuf : (unsigned char *)pbn_alloc_fn(cap);
    while ((k = pbf_digit((unsigned char)*p, b)) >= 0) { dv[nd++] = (unsigned char)k; p++; }
    if (*p == '.') {
        const char *q = p + 1;
        if (nd > 0 || pbf_digit((unsigned char)*q, b) >= 0) {
            p = q;
            while ((k = pbf_digit((unsigned char)*p, b)) >= 0) { dv[nd++] = (unsigned char)k; nfrac++; p++; }
        }
    }
    if (nd == 0) {
        if (dv != dvbuf) pbn_free_fn(dv, cap);
        pbf_set_zero(r, 1);
        return -1;
    }
    if (*p == '@' || (b <= 10 && (*p == 'e' || *p == 'E'))) {
        const char *q = p + 1;
        long v = pbf_parse_exp(&q, &ok);
        if (ok) { e10 = v; p = q; }
    } else if ((b == 2 || b == 16) && (*p == 'p' || *p == 'P')) {
        const char *q = p + 1;
        long v = pbf_parse_exp(&q, &ok);
        if (ok) { e2 = v; p = q; }
    }
    e10 -= (long)nfrac;

    /* digits -> integer (chunks of k digits per limb operation) */
    {
        int k;
        pbn_limb bb = pbn_big_base(b, &k);
        size_t i = 0;
        pbn_size an = 0;
        pbn_limb *rp = PBZ_GROW(D, (pbn_size)((double)nd * log2((double)b) / PBN_B) + 2);
        while (i < nd) {
            pbn_limb chunk = 0, mulby = 1, cy;
            int j;
            for (j = 0; j < k && i < nd; j++, i++) { chunk = chunk * (pbn_limb)b + dv[i]; mulby *= (pbn_limb)b; }
            if (j < k) bb = mulby;
            cy = pbn_n_mul_1(rp, rp, an, bb);
            cy += pbn_n_add_1(rp, rp, an, chunk);
            if (cy) rp[an++] = cy;   /* (when an == 0, add_1 returns the chunk itself) */
        }
        PBN_NORM(rp, an);
        SIZ(D) = (int)an;
    }
    if (dv != dvbuf) pbn_free_fn(dv, cap);
    pbf_set_scaled(r, sign, D, b, e10, e2, rnd);
    pbz_clear(D);
    return *p ? -1 : 0;
}

/* ========================================================================= */
/* pbf: power function (Ziv's strategy for correct rounding)                 */
/* ========================================================================= */

/* float temporaries with stack storage for small precisions */
#define PBF_TMPN 6
typedef struct { pbf_struct f; pbn_limb buf[PBF_TMPN]; } pbf_tmp_t;

static pbf_ptr pbf_tmp_init(pbf_tmp_t *t, pbf_prec_t p) {
    t->f._mpfr_prec = p;
    t->f._mpfr_sign = 1;
    t->f._mpfr_exp = PBF_EXP_NAN;
    t->f._mpfr_d = PBF_NLIMBS(p) <= PBF_TMPN ? t->buf : PBN_TMP_ALLOC(PBF_NLIMBS(p));
    return &t->f;
}

static void pbf_tmp_clear(pbf_tmp_t *t) {
    if (t->f._mpfr_d != t->buf) PBN_TMP_FREE(t->f._mpfr_d, PBF_NLIMBS(t->f._mpfr_prec));
}

/* is every value within [b - 2^err, b + 2^err] rounded to the same p-bit number? */
static int pbf_can_round(pbf_srcptr b, long err, int sign, pbf_prec_t p, pbf_rnd_t rnd) {
    pbf_view v = pbf_view_of(b);
    long sc = PBN_MIN(v.e, err);
    pbz_t M;
    PBZ_STACK(lo, 16);
    PBZ_STACK(hi, 16);
    pbf_tmp_t t1_, t2_;

    pbf_ptr t1, t2;
    int same;
    if (v.cls != PBF_C_NUM) return 1;
    pbz_roinit_n(M, v.mp, v.mn);
    pbz_mul_2exp(lo, M, (pbn_bitcnt)(v.e - sc));
    pbz_set_ui(hi, 1);
    pbz_mul_2exp(hi, hi, (pbn_bitcnt)(err - sc));
    pbz_sub(lo, lo, hi);                                /* lo = M' - eps */
    pbz_mul_2exp(hi, hi, 1);
    pbz_add(hi, lo, hi);                                /* hi = M' + eps */
    if (SIZ(lo) <= 0) { pbz_clear(lo); pbz_clear(hi); return 0; }
    t1 = pbf_tmp_init(&t1_, p);
    t2 = pbf_tmp_init(&t2_, p);
    pbf_round(t1, sign, PTR(lo), SIZ(lo), sc, 0, rnd, 0);
    pbf_round(t2, sign, PTR(hi), SIZ(hi), sc, 0, rnd, 0);
    same = FEXP(t1) == FEXP(t2) && pbn_n_cmp(FPTR(t1), FPTR(t2), PBF_NLIMBS(p)) == 0;
    if (same) {
        /* the rounded value must lie outside [lo, hi], otherwise the direction
           of rounding (the ternary value) is still unknown */
        pbf_view rv = pbf_view_of(t1), lv = pbf_view_z(lo), hv = pbf_view_z(hi);
        rv.sign = 1;
        lv.e = hv.e = sc;
        lv.ex += sc; hv.ex += sc;
        if (pbf_cmpabs_v(&rv, &lv) >= 0 && pbf_cmpabs_v(&rv, &hv) <= 0) same = 0;
    }
    pbf_tmp_clear(&t1_); pbf_tmp_clear(&t2_);
    pbz_clear(lo); pbz_clear(hi);
    return same;
}

/* sum = atanh(s) = s + s^3/3 + s^5/5 + ..., |s| <= 1/3; returns number of terms */
static long pbf_atanh_series(pbf_ptr sum, pbf_srcptr s, pbf_prec_t wi) {
    pbf_tmp_t s2_, pw_, term_;

    pbf_ptr s2, pw, term;
    pbn_limb buf[2];
    unsigned long j;
    long n = 1;
    s2 = pbf_tmp_init(&s2_, wi); pw = pbf_tmp_init(&pw_, wi); term = pbf_tmp_init(&term_, wi);
    pbf_mul_v(s2, pbf_view_of(s), pbf_view_of(s), PBF_RNDN, 0);
    pbf_set_v(pw, pbf_view_of(s), PBF_RNDN, 0);
    pbf_set_v(sum, pbf_view_of(s), PBF_RNDN, 0);
    for (j = 3;; j += 2) {
        pbf_mul_v(pw, pbf_view_of(pw), pbf_view_of(s2), PBF_RNDN, 0);
        pbf_div_v(term, pbf_view_of(pw), pbf_view_u64(j, 1, buf), PBF_RNDN, 0);
        if (!pbf_regular_p(term) || FEXP(term) < FEXP(sum) - (long)wi - 2) break;
        pbf_add_v(sum, pbf_view_of(sum), pbf_view_of(term), PBF_RNDN, 0);
        n++;
    }
    pbf_tmp_clear(&s2_); pbf_tmp_clear(&pw_); pbf_tmp_clear(&term_);
    return n;
}

static long pbf_bits_of(unsigned long v) { long b = 0; while (v) { b++; v >>= 1; } return b; }

static PBN_TLS pbn_limb  *pbf_ln2_d = NULL;
static PBN_TLS pbf_prec_t pbf_ln2_p = 0;
static PBN_TLS long       pbf_ln2_e = 0;

/* out = ln 2 rounded to out's precision (error < 1.01 ulp) */
static void pbf_const_ln2(pbf_ptr out) {
    pbf_prec_t need = FPREC(out) + 16;
    if (pbf_ln2_p < need) {
        pbf_prec_t np = need > 2 * pbf_ln2_p ? need : 2 * pbf_ln2_p;
        pbf_prec_t wi = np + 24 + 2 * pbf_bits_of((unsigned long)np);
        pbf_t s, sum, c;
        pbn_limb buf[2];
        pbf_init2(s, wi); pbf_init2(sum, wi); pbf_init2(c, np);
        pbf_div_v(s, pbf_view_u64(1, 1, buf), pbf_view_u64(3, 1, buf + 1), PBF_RNDN, 0);
        pbf_atanh_series(sum, s, wi);
        FEXP(sum) += 1;   /* ln 2 = 2 atanh(1/3) */
        pbf_set_v(c, pbf_view_of(sum), PBF_RNDN, 0);
        if (pbf_ln2_d) PBN_TMP_FREE(pbf_ln2_d, PBF_NLIMBS(pbf_ln2_p));
        pbf_ln2_d = FPTR(c);
        pbf_ln2_p = np;
        pbf_ln2_e = FEXP(c);
        FPTR(c) = NULL;
        pbf_clears(s, sum, (pbf_ptr)NULL);
    }
    {
        pbf_struct c;
        c._mpfr_prec = pbf_ln2_p;
        c._mpfr_sign = 1;
        c._mpfr_exp = pbf_ln2_e;
        c._mpfr_d = pbf_ln2_d;
        pbf_set_v(out, pbf_view_of(&c), PBF_RNDN, 0);
    }
}

PBN_DEF void pbf_free_cache(void) {
    if (pbf_ln2_d) PBN_TMP_FREE(pbf_ln2_d, PBF_NLIMBS(pbf_ln2_p));
    pbf_ln2_d = NULL;
    pbf_ln2_p = 0;
}

/* out ~ ln(x), x > 0 regular, x != 1. returns c: relative error <= 2^(c - prec(out)) */
static long pbf_log_approx(pbf_ptr out, pbf_view x, pbf_prec_t wp) {
    pbf_prec_t wi = wp + 12 + pbf_bits_of((unsigned long)wp);
    long k = x.ex, terms = 0, c;
    pbf_view m = x;
    pbf_tmp_t num_, den_, s_, lnm_, l2_;

    pbf_ptr num, den, s, lnm, l2;
    pbn_limb buf[2];

    if (pbf_top_frac(&x) < 0.70710678118654752) k--;
    m.e -= k;
    m.ex -= k;                 /* m in [~0.707, ~1.414) */
    num = pbf_tmp_init(&num_, (x.ex - x.e) + 4);
    den = pbf_tmp_init(&den_, wi); s = pbf_tmp_init(&s_, wi); lnm = pbf_tmp_init(&lnm_, wi);
    pbf_add_v(num, m, pbf_view_u64(1, -1, buf), PBF_RNDN, 0);   /* exact */
    if (pbf_zero_p(num)) {
        pbf_set_zero(lnm, 1);
    } else {
        pbf_add_v(den, m, pbf_view_u64(1, 1, buf), PBF_RNDN, 0);
        pbf_div_v(s, pbf_view_of(num), pbf_view_of(den), PBF_RNDN, 0);
        terms = pbf_atanh_series(lnm, s, wi);
        FEXP(lnm) += 1;
    }
    if (k != 0) {
        unsigned long ak = k < 0 ? 0UL - (unsigned long)k : (unsigned long)k;
        l2 = pbf_tmp_init(&l2_, wi + pbf_bits_of(ak) + 2);
        pbf_const_ln2(l2);
        pbf_mul_v(l2, pbf_view_of(l2), pbf_view_u64(ak, k < 0 ? -1 : 1, buf), PBF_RNDN, 0);
        pbf_add_v(out, pbf_view_of(l2), pbf_view_of(lnm), PBF_RNDN, 0);
        pbf_tmp_clear(&l2_);
    } else {
        pbf_set_v(out, pbf_view_of(lnm), PBF_RNDN, 0);
    }
    pbf_tmp_clear(&num_); pbf_tmp_clear(&den_); pbf_tmp_clear(&s_); pbf_tmp_clear(&lnm_);
    c = pbf_bits_of((unsigned long)(16 * terms + 64)) - (long)(wi - wp) + 1;
    return c < 1 ? 1 : c;
}

/* out ~ exp(t). returns c: relative error <= 2^(c - prec(out)) */
static long pbf_exp_approx(pbf_ptr out, pbf_srcptr t, pbf_prec_t wp) {
    long s = (long)sqrt((double)wp) / 2 + 2, n, K = 0, i, c;
    pbf_prec_t wi = wp + s + 16 + pbf_bits_of((unsigned long)wp);
    pbf_tmp_t r_, sum_, term_, l2_;

    pbf_ptr r, sum, term, l2;
    pbn_limb buf[2];
    unsigned long j;
    double td;

    if (pbf_zero_p(t)) { pbf_set_ui(out, 1, PBF_RNDN); return 0; }
    td = pbf_get_d(t, PBF_RNDN);
    n = (long)floor(td / 0.69314718055994530942 + 0.5);
    r = pbf_tmp_init(&r_, wi); sum = pbf_tmp_init(&sum_, wi); term = pbf_tmp_init(&term_, wi);
    if (n != 0) {
        unsigned long an = n < 0 ? 0UL - (unsigned long)n : (unsigned long)n;
        l2 = pbf_tmp_init(&l2_, wi + 2 * pbf_bits_of(an) + 8);
        pbf_const_ln2(l2);
        pbf_mul_v(l2, pbf_view_of(l2), pbf_view_u64(an, n < 0 ? -1 : 1, buf), PBF_RNDN, 0);
        pbf_add_v(r, pbf_view_of(t), pbf_view_neg(pbf_view_of(l2)), PBF_RNDN, 0);
        pbf_tmp_clear(&l2_);
    } else {
        pbf_set_v(r, pbf_view_of(t), PBF_RNDN, 0);
    }
    pbf_set_ui(sum, 1, PBF_RNDN);
    if (pbf_regular_p(r)) {
        FEXP(r) -= s;
        pbf_set_ui(term, 1, PBF_RNDN);
        for (j = 1;; j++) {
            pbf_mul_v(term, pbf_view_of(term), pbf_view_of(r), PBF_RNDN, 0);
            pbf_div_v(term, pbf_view_of(term), pbf_view_u64(j, 1, buf), PBF_RNDN, 0);
            if (!pbf_regular_p(term) || FEXP(term) < FEXP(sum) - (long)wi - 2) break;
            pbf_add_v(sum, pbf_view_of(sum), pbf_view_of(term), PBF_RNDN, 0);
            K++;
        }
        for (i = 0; i < s; i++) pbf_mul_v(sum, pbf_view_of(sum), pbf_view_of(sum), PBF_RNDN, 0);
    }
    FEXP(sum) += n;
    pbf_set_v(out, pbf_view_of(sum), PBF_RNDN, 0);
    pbf_tmp_clear(&r_); pbf_tmp_clear(&sum_); pbf_tmp_clear(&term_);
    c = (long)s + pbf_bits_of((unsigned long)(2 * K + 16)) - (long)(wi - wp) + 2;
    return c < 1 ? 1 : c;
}

static int pbf_is_pow2_view(const pbf_view *v) {
    return v->mn == 1 && (v->mp[0] & (v->mp[0] - 1)) == 0;
}

/* trailing zero bits of M */
static long pbf_view_ctz(const pbf_view *v) { return (long)pbn_ctz(v->mp[0]); }

/* log2|x| as a double, accurate even when x is extremely close to 1 (may return 0 then) */
static double pbf_log2_abs_robust(const pbf_view *x) {
    if (x->ex == 0 || x->ex == 1) {
        pbf_tmp_t dm_;

        pbf_ptr dm;
        pbn_limb b1[2];
        double dd;
        pbf_view ax = *x;
        ax.sign = 1;
        dm = pbf_tmp_init(&dm_, (pbf_prec_t)(PBN_MAX(x->ex, 1) - PBN_MIN(x->e, 0) + 2));
        pbf_add_v(dm, ax, pbf_view_u64(1, -1, b1), PBF_RNDN, 0);    /* exact |x| - 1 */
        dd = pbf_get_d(dm, PBF_RNDN);
        pbf_tmp_clear(&dm_);
        return log1p(dd) / 0.69314718055994530942;
    }
    return pbf_log2_abs(x);
}

static int pbf_pow_z_v(pbf_ptr r, pbf_view x, pbz_srcptr z, pbf_rnd_t rnd, int chk) {
    int zs = pbz_sgn(z), odd = pbz_odd_p(z), sign, tern = 0;
    pbf_prec_t p = FPREC(r);
    long tz, tx, zb, w, i;
    double est;
    pbz_t xo, az;
    pbn_limb one = 1;

    if (zs == 0) return pbf_set_ui(r, 1, rnd);
    if (x.cls == PBF_C_NAN) { pbf_set_nan(r); return 0; }
    if (x.cls == PBF_C_ZERO) {
        if (zs > 0) pbf_set_zero(r, odd ? x.sign : 1); else pbf_set_inf(r, odd ? x.sign : 1);
        return 0;
    }
    if (x.cls == PBF_C_INF) {
        if (zs > 0) pbf_set_inf(r, odd ? x.sign : 1); else pbf_set_zero(r, odd ? x.sign : 1);
        return 0;
    }
    sign = (x.sign < 0 && odd) ? -1 : 1;
    if (rnd == PBF_RNDF || rnd == PBF_RNDNA) rnd = PBF_RNDN;

    est = pbz_get_d(z) * pbf_log2_abs_robust(&x);
    if (chk && est > (double)PBF_EMAX + 2) return pbf_overflow(r, sign, rnd);
    if (chk && est < (double)PBF_EMIN - 3) return pbf_underflow(r, sign, rnd, 0);

    tz = pbf_view_ctz(&x);
    tx = x.e + tz;
    pbz_init(xo);
    pbz_init(az);
    pbz_abs(az, z);
    {
        pbz_t m;
        pbz_roinit_n(m, x.mp, x.mn);
        pbz_tdiv_q_2exp(xo, m, (pbn_bitcnt)tz);
    }

    if (pbz_cmp_ui(xo, 1) == 0) {
        /* |x| = 2^tx: result is exactly 2^(tx*z) (range already checked) */
        tern = pbf_round(r, sign, &one, 1, pbz_get_si(z) * tx, 0, rnd, chk);
        goto done;
    }
    if (zs > 0 && pbz_fits_ulong_p(z) && (double)pbz_bitlen(xo) * pbz_get_d(z) <= 4.0 * (double)p + 512) {
        unsigned long zz = pbz_get_ui(z);
        pbz_pow_ui(xo, xo, zz);
        tern = pbf_round(r, sign, PTR(xo), SIZ(xo), tx * (long)zz, 0, rnd, chk);
        goto done;
    }

    zb = (long)pbz_bitlen(az);
    w = (long)p + zb + 16;
    for (;;) {
        pbf_tmp_t t_, base_;

        pbf_ptr t, base;
        pbf_view ax = x;
        ax.sign = 1;
        t = pbf_tmp_init(&t_, w);
        base = pbf_tmp_init(&base_, w);
        if (zs > 0) pbf_set_v(base, ax, PBF_RNDN, 0);
        else {
            pbn_limb b1[2];
            pbf_div_v(base, pbf_view_u64(1, 1, b1), ax, PBF_RNDN, 0);
        }
        pbf_set_v(t, pbf_view_of(base), PBF_RNDN, 0);
        for (i = zb - 2; i >= 0; i--) {
            pbf_mul_v(t, pbf_view_of(t), pbf_view_of(t), PBF_RNDN, 0);
            if (pbz_tstbit(az, (pbn_bitcnt)i)) pbf_mul_v(t, pbf_view_of(t), pbf_view_of(base), PBF_RNDN, 0);
        }
        if (pbf_can_round(t, FEXP(t) - w + zb + 3, sign, p, rnd) || w > 64 * (long)p + 100000) {
            pbf_view tv = pbf_view_of(t);
            tern = pbf_round(r, sign, tv.mp, tv.mn, tv.e, 0, rnd, chk);
            pbf_tmp_clear(&t_); pbf_tmp_clear(&base_);
            break;
        }
        pbf_tmp_clear(&t_); pbf_tmp_clear(&base_);
        w += w / 2 + 32;
    }
done:
    pbz_clear(xo);
    pbz_clear(az);
    return tern;
}

PBN_DEF int pbf_pow_z(pbf_ptr r, pbf_srcptr x, pbz_srcptr z, pbf_rnd_t rnd) {
    return pbf_pow_z_v(r, pbf_view_of(x), z, rnd, 1);
}

static int pbf_cmpabs_one(const pbf_view *x) {
    if (x->ex != 1) return x->ex > 1 ? 1 : -1;
    return pbf_is_pow2_view(x) ? 0 : 1;
}

PBN_DEF int pbf_pow(pbf_ptr r, pbf_srcptr xs, pbf_srcptr ys, pbf_rnd_t rnd) {
    pbf_view x = pbf_view_of(xs), y = pbf_view_of(ys);
    pbf_prec_t p = FPREC(r);
    int yint = 0, yodd = 0, tern;
    long tzy = 0;

    if (rnd == PBF_RNDF || rnd == PBF_RNDNA) rnd = PBF_RNDN;
    if (y.cls == PBF_C_ZERO) return pbf_set_ui(r, 1, rnd);
    if (x.cls == PBF_C_NUM && x.sign > 0 && pbf_cmpabs_one(&x) == 0) return pbf_set_ui(r, 1, rnd);
    if (x.cls == PBF_C_NAN || y.cls == PBF_C_NAN) { pbf_set_nan(r); return 0; }
    if (y.cls == PBF_C_NUM) {
        tzy = pbf_view_ctz(&y);
        yint = y.e + tzy >= 0;
        yodd = y.e + tzy == 0;
    }
    if (y.cls == PBF_C_INF) {
        int ax = x.cls == PBF_C_INF ? 1 : x.cls == PBF_C_ZERO ? -1 : pbf_cmpabs_one(&x);
        if (ax == 0) return pbf_set_ui(r, 1, rnd);                 /* (-1)^inf */
        if ((ax > 0) == (y.sign > 0)) pbf_set_inf(r, 1); else pbf_set_zero(r, 1);
        return 0;
    }
    if (x.cls == PBF_C_ZERO) {
        if (y.sign < 0) pbf_set_inf(r, yodd ? x.sign : 1); else pbf_set_zero(r, yodd ? x.sign : 1);
        return 0;
    }
    if (x.cls == PBF_C_INF) {
        int s = (x.sign < 0 && yodd) ? -1 : 1;
        if (y.sign < 0) pbf_set_zero(r, s); else pbf_set_inf(r, s);
        return 0;
    }

    if (yint) {
        pbz_t Y, m;
        if (y.ex - 1 - (x.ex - x.e) > 40) {
            /* astronomically large integer exponent */
            int s = (x.sign < 0 && yodd) ? -1 : 1;
            if (pbf_cmpabs_one(&x) == 0) return pbf_set_si(r, s, rnd);
            if ((pbf_cmpabs_one(&x) > 0) == (y.sign > 0)) return pbf_overflow(r, s, rnd);
            return pbf_underflow(r, s, rnd, 0);
        }
        pbz_init(Y);
        pbz_roinit_n(m, y.mp, y.mn);
        if (y.e >= 0) pbz_mul_2exp(Y, m, (pbn_bitcnt)y.e);
        else pbz_tdiv_q_2exp(Y, m, (pbn_bitcnt)-y.e);
        if (y.sign < 0) pbz_neg(Y, Y);
        tern = pbf_pow_z_v(r, x, Y, rnd, 1);
        pbz_clear(Y);
        return tern;
    }
    if (x.sign < 0) { pbf_set_nan(r); return 0; }

    /* exact cases: y = Y / 2^k and x a perfect 2^k-th power */
    {
        long k = -(y.e + tzy), tzx = pbf_view_ctz(&x), tx = x.e + tzx;
        unsigned long atx = tx < 0 ? 0UL - (unsigned long)tx : (unsigned long)tx;
        long ctx = tx == 0 ? 1000 : (long)pbn_ctz((pbn_limb)atx);
        pbz_t Y, m, R, rem;
        int exact = 0;
        pbz_inits(Y, R, rem, (pbz_ptr)NULL);
        pbz_roinit_n(m, y.mp, y.mn);
        pbz_tdiv_q_2exp(Y, m, (pbn_bitcnt)tzy);
        if (y.sign < 0) pbz_neg(Y, Y);
        pbz_roinit_n(m, x.mp, x.mn);
        pbz_tdiv_q_2exp(R, m, (pbn_bitcnt)tzx);
        if (ctx >= k && k <= 30 && (long)pbz_bitlen(R) < 100000) {
            long i;
            exact = 1;
            for (i = 0; i < k && exact; i++) {
                if (pbz_cmp_ui(R, 1) == 0) break;
                pbz_sqrtrem(R, rem, R);
                exact = SIZ(rem) == 0;
            }
        }
        if (exact) {
            /* root = R * 2^(tx / 2^k), result = root^Y */
            pbf_tmp_t root_;

            pbf_ptr root;
            pbf_prec_t rp = (pbf_prec_t)pbz_bitlen(R);
            root = pbf_tmp_init(&root_, rp < 2 ? 2 : rp);
            pbf_round(root, 1, PTR(R), SIZ(R), tx / (1L << k), 0, PBF_RNDN, 0);
            tern = pbf_pow_z_v(r, pbf_view_of(root), Y, rnd, 1);
            pbf_tmp_clear(&root_);
            pbz_clears(Y, R, rem, (pbz_ptr)NULL);
            return tern;
        }
        pbz_clears(Y, R, rem, (pbz_ptr)NULL);
    }

    /* general case: exp(y * ln x) */
    {
        double lnx_l2, lgT;
        int tsign;
        long lt, w = (long)p + 24;
        /* robust estimate of log2|T|, T = y ln x (x may be extremely close to 1) */
        if (x.ex == 0 || x.ex == 1) {
            pbf_tmp_t dm_;

            pbf_ptr dm;
            pbn_limb b1[2];
            double dd;
            dm = pbf_tmp_init(&dm_, (pbf_prec_t)(PBN_MAX(x.ex, 1) - PBN_MIN(x.e, 0) + 2));
            pbf_add_v(dm, x, pbf_view_u64(1, -1, b1), PBF_RNDN, 0);       /* exact x - 1 */
            tsign = FSIGN(dm) * y.sign;
            dd = pbf_get_d(dm, PBF_RNDN);
            if (dd != 0 && fabs(dd) > 1e-300) lnx_l2 = log2(fabs(log1p(dd)));
            else lnx_l2 = (double)FEXP(dm) - 0.5;
            pbf_tmp_clear(&dm_);
        } else {
            double l2 = pbf_log2_abs(&x);
            lnx_l2 = log2(fabs(l2) * 0.69314718055994530942);
            tsign = (l2 > 0 ? 1 : -1) * y.sign;
        }
        lgT = lnx_l2 + (double)y.ex + log2(pbf_top_frac(&y));
        if (lgT > 31) return tsign > 0 ? pbf_overflow(r, 1, rnd) : pbf_underflow(r, 1, rnd, 0);
        if (lgT < -(double)p - 16) {
            /* |T| tiny: exp(T) lies strictly between 1 and 1 + sign(T) 2^-(p+2) */
            pbn_size n = (pbn_size)((p + 2) / PBN_B) + 1;
            pbn_limb *mb = PBN_TMP_ALLOC(n);
            pbn_n_zero(mb, n);
            mb[(p + 2) / PBN_B] = (pbn_limb)1 << ((p + 2) % PBN_B);
            if (tsign < 0) pbn_n_sub_1(mb, mb, n, 1);
            tern = pbf_round(r, 1, mb, n, -(long)(p + 2), 1, rnd, 1);
            PBN_TMP_FREE(mb, n);
            return tern;
        }
        lt = lgT > 0 ? (long)ceil(lgT) + 1 : 0;
        for (;;) {
            long wp = w + lt, eL, eE, errrel;
            pbf_tmp_t L_, T_, E_;

            pbf_ptr L, T, E;
            L = pbf_tmp_init(&L_, wp); T = pbf_tmp_init(&T_, wp); E = pbf_tmp_init(&E_, wp);
            eL = pbf_log_approx(L, x, wp);
            pbf_mul_v(T, y, pbf_view_of(L), PBF_RNDN, 0);
            eE = pbf_exp_approx(E, T, wp);
            errrel = PBN_MAX(eE, (pbf_regular_p(T) ? FEXP(T) : -wp) + eL + 2) + 1;
            if (pbf_can_round(E, FEXP(E) + errrel - wp, 1, p, rnd) || w > 64 * (long)p + 100000) {
                pbf_view ev = pbf_view_of(E);
                tern = pbf_round(r, 1, ev.mp, ev.mn, ev.e, 0, rnd, 1);
                pbf_tmp_clear(&L_); pbf_tmp_clear(&T_); pbf_tmp_clear(&E_);
                return tern;
            }
            pbf_tmp_clear(&L_); pbf_tmp_clear(&T_); pbf_tmp_clear(&E_);
            w += w / 2 + 32;
        }
    }
}

#ifdef __cplusplus
}
#endif

#endif /* PBN_IMPLEMENTATION */
