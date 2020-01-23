/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/lib/system.h
 *****************************************************************/

#ifndef __LIB_SYSTEM_H__
#define __LIB_SYSTEM_H__

// Helpers
#define CONCAT(a, b) CONCAT2(a, b)
#define CONCAT2(a, b) a ## b

// Label redirection
#define isI CONCAT(PROC, I0)
#define isR CONCAT(PROC, R0)
#define isB CONCAT(PROC, B0)
#define isG CONCAT(PROC, G0)
#define isS CONCAT(PROC, S0)
#define isA CONCAT(PROC, A0)
#define isD CONCAT(PROC, D0)
#define isF CONCAT(PROC, F0)

#define PROC_END CONCAT(PROC, procEnd)

#define FINISH() goto CONCAT(PROC, procEnd);

#define DO_ARG0(X) static void* procArg0[] = {&& CONCAT(PROC,I0), && CONCAT(PROC,R0), && CONCAT(PROC,B0), && CONCAT(PROC,G0), && CONCAT(PROC,S0), && CONCAT(PROC,A0), && CONCAT(PROC,D0), && CONCAT(PROC,F0)}; \
    goto *procArg0[X];

#include "system/generic.h"
#include "system/numbers.h"
#include "system/arrays.h"

#endif