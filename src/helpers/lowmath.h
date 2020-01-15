/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/helpers/lowmath.h
 *****************************************************************/

#ifndef __LOWMATH_H__
#define __LOWMATH_H__

/**************************************
  Constants
 **************************************/

#define LOG_INT_MAX 21.48756259     // The result of log(INT_MAX)

/**************************************
  Static methods
 **************************************/

#define powWillOverflow(X,Y) (Y * log(X) >= LOG_INT_MAX)

#endif