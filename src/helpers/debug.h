/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/helpers/debug.h
 *****************************************************************/

#ifndef __DEBUG_H__
#define __DEBUG_H__

/**************************************
  Aliases
 **************************************/

#define debugHeader(X)  printf("\e[1;32m|== %s /======================>\e[0;37m\n",X)
#define debugFooter(X)  printf("\e[1;32m==/ %s =======================|\e[0;37m\n",X)

#endif