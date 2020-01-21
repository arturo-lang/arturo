/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/helpers/expect.h
 *****************************************************************/

#ifndef __EXPECT_H__
#define __EXPECT_H__

#define LIKELY(X) 		(__builtin_expect(X,1))
#define UNLIKELY(X)		(__builtin_expect(X,0))

#endif