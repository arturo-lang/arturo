/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/core/string.h
 *****************************************************************/

#ifndef __STRING_H__
#define __STRING_H__

#include "../arturo.h"

/**************************************
  Type definitions
 **************************************/

typedef struct {
    int refc;

    int size;
    int cap;
    char* content;
} String;

typedef char* CString;

/**************************************
  Macros
 **************************************/

//-------------------------
// Resizing
//-------------------------

#define sResize(DEST) { \
    DEST->cap = nextPowerOf2(DEST->size+1);                                 \
    safeRealloc(DEST->content, DEST->cap);                                  \
}

#define sGrow(DEST,X) \
    DEST->size += X;                                                        \
    if (DEST->size >= DEST->cap) sResize(DEST)

//-------------------------
// Aliases
//-------------------------

#define sSize(DEST) \
    DEST->size

/**************************************
  Inline Methods
 **************************************/

//-------------------------
// Constructor
//-------------------------

static INLINED String* sNew(const CString old) {
    String* ret = malloc(sizeof(String));
    ret->size = __builtin_strlen(old);
    ret->cap = nextPowerOf2(ret->size+1); 
    ret->content = malloc(ret->cap);
    ret->refc = 1;
    memcpy(ret->content, old, ret->size);
    ret->content[ret->size]='\0';
    return ret;
}

static INLINED String* sDup(const String* old) {
    String* ret = malloc(sizeof(String));
    ret->size = old->size;
    ret->cap = old->cap;
    ret->content = malloc(ret->cap);
    memcpy(ret->content, old->content, ret->size);
    ret->content[ret->size]='\0';
    return ret;
}

//-------------------------
// Main Functions
//-------------------------

static INLINED void sCat(String* dest, String* orig) {
    sGrow(dest, orig->size);
    memcpy(dest->content + (dest->size-orig->size), orig->content, orig->size);
    dest->content[dest->size]='\0';
}

static INLINED void sPrint(String* str) {
    for (int i=0; i<str->size; i++) {
        putc(str->content[i],stdout);
    }
}

static INLINED int sCmp (const String* l, const String* r) {
    unsigned int len = l->size;

    int fast = len/sizeof(size_t) + 1;
    int offset = (fast-1)*sizeof(size_t);
    int current_block = 0;

    if( len <= sizeof(size_t)){ fast = 0; }

    const char* ptr0 = l->content;
    const char* ptr1 = r->content;

    size_t *lptr0 = (size_t*)ptr0;
    size_t *lptr1 = (size_t*)ptr1;

    while( current_block < fast ){
        if( (lptr0[current_block] ^ lptr1[current_block] )){
            int pos;
            for(pos = current_block*sizeof(size_t); pos < len ; ++pos ){
                if( (ptr0[pos] ^ ptr1[pos]) || (ptr0[pos] == 0) || (ptr1[pos] == 0) ){
                    return  (int)((unsigned char)ptr0[pos] - (unsigned char)ptr1[pos]);
                }
            }
        }
        ++current_block;
    }

    while( len > offset ){
        if( (ptr0[offset] ^ ptr1[offset] )){ 
            return (int)((unsigned char)ptr0[offset] - (unsigned char)ptr1[offset]); 
        }
        ++offset;
    }
    return 0;
}

//-------------------------
// Destructor
//-------------------------

static inline void sFree(String* dest) {
    //printf("sFree: \"%s\" with refc: %d\n",dest->content, dest->refc);
    if (--(dest->refc)==0) {
        //printf("! releasing\n");
        free(dest->content);
        free(dest);
    }
}

// //String* strNew(const char* old);
// String* strDup(const String* old);
// void strCat(String* dest, String* new);
// void strPrint(String* str);
// void strFree(String* dest);

// int reallocs;

// #define aInit(DEST,TYPE,CAP) { \
//     int k=0;                                                                \
//     while (powerOfTwo[++k]<CAP);                                            \
//                                                                             \
//     DEST = malloc(sizeof(Array(TYPE)));                                     \
//     DEST->size = 0;                                                         \
//     DEST->typeSize = sizeof(TYPE);                                          \
//     DEST->cap = powerOfTwo[k];                                              \
//     DEST->data = calloc(DEST->cap, DEST->typeSize);                         \
// }

// #define aNew(NAME,TYPE,CAP) \
//     Array(TYPE)* NAME;                                                      \
//     aInit(NAME,TYPE,CAP);

// #define aResize(DEST) { \
//     DEST->cap *= 2;                                                         \
//     DEST->data = realloc(DEST->data, DEST->cap * DEST->typeSize);           \
// }

// #define aGrow(DEST,X) \
//     DEST->size += X;                                                        \
//     if (DEST->size >= DEST->cap) aResize(DEST);

// #define aAdd(DEST,X) \
//     aGrow(DEST,1);                                                          \
//     DEST->data[DEST->size-1] = X

// #define aPop(DEST) \
//     DEST->data[--DEST->size]

// #define aAppend(DEST,X) \
//     DEST->cap += X->cap;                                                    \
//     DEST->data = realloc(DEST->data, DEST->cap * DEST->typeSize);           \
//     memcpy(DEST->data + DEST->size, X->data, X->size * X->typeSize);        \
//     DEST->size += X->size

// #define aEach(DEST,INDEX) \
//     for (int INDEX=0; INDEX<DEST->size; INDEX++)

// #define aFind(DEST,LOOKUP,INDEX) \
//     INDEX = -1;                                                             \
//     aEach(DEST,i) {                                                         \
//         if (DEST->data[i]==LOOKUP) {                                        \
//             INDEX = i;                                                      \
//             break;                                                          \
//         }                                                                   \
//     }

// #define aFindCStr(DEST,LOOKUP,INDEX) \
//     INDEX = -1;                                                             \
//     aEach(DEST,i) {                                                         \
//         if (!strcmp(DEST->data[i],LOOKUP)) {                                \
//             INDEX = i;                                                      \
//             break;                                                          \
//         }                                                                   \
//     }

// #define aFindStr(DEST,LOOKUP,INDEX) \
//     INDEX = -1;                                                             \
//     aEach(DEST,i) {                                                         \
//         if (!sCompare(DEST->data[i],LOOKUP)) {                            \
//             INDEX = i;                                                      \
//             break;                                                          \
//         }                                                                   \
//     }

// #define aSize(DEST) \
//     DEST->size

// #define aFree(DEST) \
//     free(DEST->data);                                                       \
//     free(DEST)

#endif