/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/vm/panic.h
 *****************************************************************/

#ifndef __PANIC_H__
#define __PANIC_H__

/**************************************
  Aliases
 **************************************/

#define cmdlineError(X) \
	printf("arturo:: cmdline error: %s\nPlease use -h for help.",X);		\
	exit(1)

#define invalidOperationError(X) \
	printf("Invalid operation for '%c'\n",X); 								\
	exit(1)

#endif