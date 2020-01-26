/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/lib/system/strings.h
 *****************************************************************/

#ifndef __LIB_SYSTEM_STRINGS_H__
#define __LIB_SYSTEM_STRINGS_H__

/**************************************
  Functions
 **************************************/

#define sys_doUppercase() {\
	Value arg0 = popS();\
	String* ret = sDup(S(arg0));\
	for (int i=0; i<ret->size; i++) {\
		ret->content[i] = toupper(ret->content[i]);\
	}\
	pushS(toS(ret));\
}


#define sys_doLowercase() {\
	Value arg0 = popS();\
	String* ret = sDup(S(arg0));\
	for (int i=0; i<ret->size; i++) {\
		ret->content[i] = tolower(ret->content[i]);\
	}\
	pushS(toS(ret));\
}

#endif