/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/vm/vm.h
 *****************************************************************/

#ifndef __VM_H__
#define __VM_H__

/**************************************
  Methods
 **************************************/

void vmCompileScript(char* script);
void vmRunObject(char* script);
char* vmRunScript(char* script);

/**************************************
  Globals
 **************************************/

intArray* ArrayStarts;

#endif