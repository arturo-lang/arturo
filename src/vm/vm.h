/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/vm/vm.h
 *****************************************************************/

#ifndef __VM_H__
#define __VM_H__

/**************************************
  Methods
 **************************************/

void vmCompileScript(FILE* script, char* scriptPath);

Value vmRunObject(char* scriptPath);
Value vmRunScript(FILE* script);

/**************************************
  Globals
 **************************************/

intArray* ArrayStarts;
DictPArray* DictArray;

#endif