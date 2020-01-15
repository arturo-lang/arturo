/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/helpers/memory.h
 *****************************************************************/

#ifndef __MEMORY_H__
#define __MEMORY_H__

#include "../arturo.h"

/**************************************
  Macros
 **************************************/

#define safeRealloc(X,SIZE) \
    if (!(X = realloc(X,(SIZE)))) {                                         \
        printf("memory corruption. exiting...\n");                          \
        exit(0);                                                            \
    }

#endif