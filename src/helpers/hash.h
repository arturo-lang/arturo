/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/helpers/hash.h
 *****************************************************************/

#ifndef __HASH_H__
#define __HASH_H__

#include "../arturo.h"

/**************************************
  Type definitions
 **************************************/

typedef uint32_t Hash32;
typedef unsigned __int128 Hash128;

/**************************************
  Constants
 **************************************/

static int HASH_SEED = 18966;

/**************************************
  Macros
 **************************************/

#define hash32String(STR,HSH) \
	MurmurHash3_x86_32(STR->content, STR->size, HASH_SEED, &HSH);

#define hash128String(STR,HSH) \
	MurmurHash3_x64_128(STR->content, STR->size, HASH_SEED, &HSH);

#endif