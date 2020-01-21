/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/helpers/benchmark.c
 *****************************************************************/

#include "arturo.h"

/**************************************
  Methods
 **************************************/

unsigned long long getCurrentTime() {
    struct timeval t;
    struct timezone tzp;
    gettimeofday(&t, &tzp);
    return t.tv_sec*1000000 + t.tv_usec;
}

unsigned long long getCurrentCycles() {
	return __builtin_readcyclecounter();
}