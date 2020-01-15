/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/helpers/stoi32.c
 *****************************************************************/

#include "arturo.h"

/**************************************
  Methods
 **************************************/

int stoi32(int* res, const char* str) {
    int val = 0;

    while( *str ) {
        val = val*10 + (*str++ - '0');
    }

    if (val>INT_MAX) return false;
    else {
        *res = val;
        return true;
    }
}