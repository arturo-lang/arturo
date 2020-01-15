/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/config/config.h
 *****************************************************************/

#ifndef __CONFIG_H__
#define __CONFIG_H__

/**************************************
  Tuning
 **************************************/

//---------------------
// Virtual Machine
//---------------------

#define COMPUTED_GOTO				// Use Computed Goto VS Switch
#define STACK_SIZE			5000	// Maximum Value Stack size
#define FRAMESTACK_SIZE		2000	// Maximum Call Stack size
#define LOCALSTACK_SIZE 	255		// Maxium Local Value Stack size
#define GLOBAL_SIZE			1000	// Maximum Global Table size

#define INITIAL_BCODE_SIZE	128		// Initially allocated memory for Bytecode
#define INITIAL_BDATA_SIZE	32		// Initially allocated memory for Data Segment

/**************************************
  Debugging
 **************************************/

//#define DEBUG 					// Uncomment for debugging info
//#define PROFILE 					// Uncomment for profiling info

#endif
