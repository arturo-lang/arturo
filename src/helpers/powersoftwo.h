/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/helpers/powersoftwo.h
 *****************************************************************/

#ifndef __POWERSOFTWO_H__
#define __POWERSOFTWO_H__

/**************************************
  Inline methods
 **************************************/

static INLINED int nextPowerOf2(int v) {
    v |= v >> 1;
    v |= v >> 2;
    v |= v >> 4;
    v |= v >> 8;
    v |= v >> 16;
    v++;
    return v;
}

#endif