/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/helpers/prints.h
 *****************************************************************/

#ifndef __PRINTS_H__
#define __PRINTS_H__

/**************************************
  Constants
 **************************************/

#define print(X)    fputs(X,stdout)     // print str
#define printLn(X)  puts(X)             // print str WITH newline
#define printC(X)   putc(X,stdout)      // print char

#endif