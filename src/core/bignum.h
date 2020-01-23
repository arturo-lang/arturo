/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/core/bignum.h
 *****************************************************************/

#ifndef __BIGNUM_H__
#define __BIGNUM_H__

/**************************************
  Type definitions
 **************************************/

typedef struct {
    int refc;
    mpz_t num;
} Bignum;

/**************************************
  Configuration
 **************************************/

#define MILLER_RABIN_REPS 	20

/**************************************
  Macros
 **************************************/

#define bNew() (Bignum*)({\
	Bignum* ret = malloc(sizeof(Bignum));\
	ret->refc = 1; \
	ret;\
})

#define bAdd(DEST,X) \
	mpz_add(DEST->num,DEST->num,X->num)

#define bAddI(DEST,X) \
	mpz_add_ui(DEST->num,DEST->num,X)

#define bSub(DEST,X) \
	mpz_sub(DEST->num,DEST->num,X->num)

#define bSubI(DEST,X) \
	mpz_sub_ui(DEST->num,DEST->num,X)

#define bMul(DEST,X) \
	mpz_mul(DEST->num,DEST->num,X->num)

#define bMulI(DEST,X) \
	mpz_mul_ui(DEST->num,DEST->num,X)

#define bDiv(DEST,X) \
	mpz_tdiv_q(DEST->num,DEST->num,X->num)

#define bDivI(DEST,X) \
	mpz_tdiv_q_ui(DEST->num,DEST->num,X)

#define bMod(DEST,X) \
	mpz_tdiv_r(DEST->num,DEST->num,X->num)

#define bModI(DEST,X) \
	mpz_tdiv_r_ui(DEST->num,DEST->num,X)

#define bPowI(DEST,X) \
	mpz_pow_ui(DEST->num,DEST->num,X)

#define bCmp(DEST,X) \
	mpz_cmp(DEST->num,X->num)

#define bCmpI(DEST,X) \
	mpz_cmp_si(DEST->num,X)

#define bIsPrime(DEST) \
	mpz_probab_prime_p(DEST->num, MILLER_RABIN_REPS)

#define bToCString(DEST) \
	mpz_get_str(NULL, 10, DEST->num)

/**************************************
  Inline Methods
 **************************************/

//-------------------------
// Constructor
//-------------------------

static INLINED Bignum* bNewFromI(int i) {
	Bignum* ret = bNew();
	mpz_init_set_si(ret->num,i);
	return ret;
}

static INLINED Bignum* bNewFromCString(const char* s) {
	Bignum* ret = bNew();
	mpz_init_set_str(ret->num, s, 10);
	return ret;
}

static INLINED Bignum* bDup(const Bignum* old) {
	Bignum* ret = bNew();
	mpz_init_set(ret->num,old->num);
	return ret;
}

//-------------------------
// Destructor
//-------------------------

static inline void bFree(Bignum* dest) {
    if (--(dest->refc)==0) {
    	mpz_clear(dest->num);
        free(dest);
    }
}

// static 

// #define gNewFromI(X) (Bignum*)({ \
// 	Bignum* ret = malloc(sizeof(Bignum)); \
// 	mpz_init_set_si(ret->num,X); \
// 	ret; \                                                                 \
// })

// //-------------------------
// // Methods
// //-------------------------

// #define gAddI(DEST,X) {\
// 	mpz_add_ui(*DEST,*DEST,X); \
// }

// /**************************************
//   Aliases
//  **************************************/

// #define newBignum()         malloc(sizeof(mpz_t))
// #define bignumToCstring(X)  mpz_get_str(NULL, 10, X)

#endif