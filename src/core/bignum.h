/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/core/bignum.h
 *****************************************************************/

#ifndef __BIGNUM_H__
#define __BIGNUM_H__

/**************************************
  Type definitions
 **************************************/

typedef mpz_t Bignum;
typedef mpz_srcptr Bignum_p;

/**************************************
  Aliases
 **************************************/

#define newBignum()         malloc(sizeof(mpz_t))
#define bignumToCstring(X)  mpz_get_str(NULL, 10, X)

#endif