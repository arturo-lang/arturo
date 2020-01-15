/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/helpers/builtin.h
 *****************************************************************/

#ifndef __BUILTIN_H__
#define __BUILTIN_H__

/**************************************
  Builtin aliases
 **************************************/

#define addWillOverflow(x,y,z) __builtin_sadd_overflow(x,y,z)
#define subWillOverflow(x,y,z) __builtin_ssub_overflow(x,y,z)
#define mulWillOverflow(x,y,z) __builtin_smul_overflow(x,y,z)

#endif