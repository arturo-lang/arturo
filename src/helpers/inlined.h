/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/helpers/inlined.h
 *****************************************************************/

#ifndef __INLINED_H__
#define __INLINED_H__

#ifdef __GNUC__
	#define INLINED __attribute__((always_inline)) inline
#else
	#define INLINED inline
#endif

#endif