/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/vm/objfile.h
 *****************************************************************/

#ifndef __OBJFILE_H__
#define __OBJFILE_H__

/**************************************
  Methods
 **************************************/

void writeObjFile(const char* filename);
void readObjFile(const char* filename);

#endif