/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/lib/system/numbers.h
 *****************************************************************/

#ifndef __LIB_SYSTEM_NUMBERS_H__
#define __LIB_SYSTEM_NUMBERS_H__

#define sys_getAbs() {                             			\
    Value arg0 = popS();                           			\
    switch (Kind(arg0)) {                          			\
    	case IV: pushS(toI(abs(I(arg0)))); break;        	\
    	default: printf("cannot get 'abs' for value\n"); 	\
    }                                              			\
}

#define sys_getSqrt() {										\
	Value arg0 = popS(); 									\
	switch (Kind(arg0)) {									\
		case IV: pushS(toR((float)sqrt(I(arg0)))); break;	\
		case RV: pushS(toR((float)sqrt(R(arg0)))); break;	\
		default: printf("cannot get 'sqrt' for value\n");	\
	}														\
}

#endif