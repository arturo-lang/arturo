/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/core/array.h
 *****************************************************************/

#ifndef __ARRAY_H__
#define __ARRAY_H__

#include "../arturo.h"

/**************************************
  Type definitions
 **************************************/

#define Array(TYPE) \
    struct { \
        int size; \
        int cap; \
        int typeSize; \
        TYPE *data; \
    }

typedef Array(CString)          CStringArray;
typedef Array(int)              intArray;

/**************************************
  Macros
 **************************************/

//-------------------------
// Constructor
//-------------------------

#define aNew(TYPE,CAP) (TYPE##Array*)({ \
    Array(TYPE)* DEST = malloc(sizeof(Array(TYPE)));                        \
    DEST->size = 0;                                                         \
    DEST->typeSize = sizeof(TYPE);                                          \
    DEST->cap = nextPowerOf2(CAP);                                          \
    DEST->data = calloc(DEST->cap, DEST->typeSize);                         \
    DEST;                                                                   \
})

//-------------------------
// Resizing
//-------------------------

#define aResize(DEST) { \
    DEST->cap = nextPowerOf2(DEST->size);                                   \
    safeRealloc(DEST->data, DEST->cap * DEST->typeSize);                    \
}

#define aGrow(DEST,X) \
    DEST->size += X;                                                        \
    if (DEST->size >= DEST->cap) aResize(DEST)

//-------------------------
// Main Functions
//-------------------------

#define aAdd(DEST,X) \
    aGrow(DEST,1);                                                          \
    DEST->data[DEST->size-1] = X

#define aPop(DEST) \
    DEST->data[--DEST->size]

#define aLast(DEST) \
    DEST->data[DEST->size-1]

#define aAppend(DEST,X) \
    aGrow(DEST, X->size);                                                           \
    memcpy(DEST->data + (DEST->size - X->size), X->data, X->size * X->typeSize)     

#define aEach(DEST,INDEX) \
    for (int INDEX=0; INDEX<DEST->size; INDEX++)

#define aFind(DEST,LOOKUP,INDEX) \
    INDEX = -1;                                                             \
    aEach(DEST,i) {                                                         \
        if (DEST->data[i]==LOOKUP) {                                        \
            INDEX = i;                                                      \
            break;                                                          \
        }                                                                   \
    }

#define aFindCStr(DEST,LOOKUP,INDEX) \
    INDEX = -1;                                                             \
    aEach(DEST,i) {                                                         \
        if (!strcmp(DEST->data[i],LOOKUP)) {                                \
            INDEX = i;                                                      \
            break;                                                          \
        }                                                                   \
    }

#define aFindStr(DEST,LOOKUP,INDEX) \
    INDEX = -1;                                                             \
    aEach(DEST,i) {                                                         \
        if (!sCompare(DEST->data[i],LOOKUP)) {                            \
            INDEX = i;                                                      \
            break;                                                          \
        }                                                                   \
    }

#define aSize(DEST) \
    DEST->size

//-------------------------
// Destructor
//-------------------------

#define aFree(DEST) \
    free(DEST->data);                                                       \
    free(DEST)

#endif