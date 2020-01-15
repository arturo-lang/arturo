/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/vm/callframe.h
 *****************************************************************/

#ifndef __CALLFRAME_H__
#define __CALLFRAME_H__

#include "../arturo.h"

/**************************************
  Type definitions
 **************************************/

typedef struct {
	Value Locals[LOCALSTACK_SIZE];
	int ip;
} CallFrame;

#endif