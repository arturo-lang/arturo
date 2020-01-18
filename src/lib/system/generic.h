/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/lib/system/generic.h
 *****************************************************************/

#ifndef __LIB_SYSTEM_GENERIC_H__
#define __LIB_SYSTEM_GENERIC_H__

#define sys_getSize() {                                 \
    Value popped = popS();                              \
    switch (Kind(popped)) {                             \
        case SV: pushS(toI(sSize(S(popped)))); break;   \
        case AV: pushS(toI(aSize(A(popped)))); break;   \
        case DV: pushS(toI(dSize(D(popped)))); break;   \
        default: print("cannot get 'size' for value: ");\
                 printLnValue(popped);                  \
                 exit(1);                               \
    }                                                   \
}

#endif