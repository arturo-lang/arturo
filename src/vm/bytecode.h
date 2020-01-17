/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/core/bytecode.h
 *****************************************************************/

#ifndef __BYTECODE_H__
#define __BYTECODE_H__

#include "../arturo.h"

/**************************************
  Type definitions
 **************************************/

typedef Array(Byte)     ByteArray;

/**************************************
  Macros
 **************************************/

#define writeByte(DEST,B) \
	aGrow(DEST,1);											\
	DEST->data[DEST->size - 1] = B;

#define rewriteByte(DEST,POS,B) \
	DEST->data[POS] = B;

#define readByte(DATA,POS) \
	(Byte)(DATA[POS])

#define writeWord(DEST,W) \
	aGrow(DEST,2);											\
	DEST->data[DEST->size - 2] = (Byte)(W >> 8);			\
	DEST->data[DEST->size - 1] = (Byte)(W)

#define readWord(DATA,POS) \
	(Word)DATA[POS] << 8 | 									\
	(Word)DATA[POS+1]

#define writeDword(DEST,D) \
	aGrow(DEST,4);											\
	DEST->data[DEST->size - 4] = (Byte)(D >> 24);			\
	DEST->data[DEST->size - 3] = (Byte)(D >> 16);			\
	DEST->data[DEST->size - 2] = (Byte)(D >> 8);			\
	DEST->data[DEST->size - 1] = (Byte)(D);		

#define rewriteDword(DEST,POS,D) \
	DEST->data[POS]   = (Byte)(D >> 24);					\
	DEST->data[POS+1] = (Byte)(D >> 16);					\
	DEST->data[POS+2] = (Byte)(D >> 8);						\
	DEST->data[POS+3] = (Byte)(D)			

#define readDword(DATA,POS) \
	(Dword)DATA[POS]   << 24 | 								\
	(Dword)DATA[POS+1] << 16 | 								\
	(Dword)DATA[POS+2] << 8  | 								\
	(Dword)DATA[POS+3]

#define writeValue(DEST,V) \
	aGrow(DEST,8);											\
	DEST->data[DEST->size - 8] = (Byte)(V >> 56);			\
	DEST->data[DEST->size - 7] = (Byte)(V >> 48);			\
	DEST->data[DEST->size - 6] = (Byte)(V >> 40);			\
	DEST->data[DEST->size - 5] = (Byte)(V >> 32);			\
	DEST->data[DEST->size - 4] = (Byte)(V >> 24);			\
	DEST->data[DEST->size - 3] = (Byte)(V >> 16);			\
	DEST->data[DEST->size - 2] = (Byte)(V >> 8);			\
	DEST->data[DEST->size - 1] = (Byte)(V);

#define readValue(DATA,POS) \
	(Value)DATA[POS]   << 56 | 								\
	(Value)DATA[POS+1] << 48 | 								\
	(Value)DATA[POS+2] << 40 | 								\
	(Value)DATA[POS+3] << 32 | 								\
	(Value)DATA[POS+4] << 24 | 								\
	(Value)DATA[POS+5] << 16 | 								\
	(Value)DATA[POS+6] << 8  | 								\
	(Value)DATA[POS+7]

#endif