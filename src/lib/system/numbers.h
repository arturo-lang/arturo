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

static INLINED bool isPrime(Int32 number) {
 	if (number < 2) return false;
    if (number % 2 == 0) return (number == 2);

    Int32 root = sqrt(number);
    for (int i = 3; i <= root; i += 2) {
        if (number % i == 0) return false;
    }
    return true;
}

#define sys_checkIsPrime() {                   					\
	Value arg0 = popS();                           				\
	switch (Kind(arg0)) {                          				\
		case IV: pushS(toB(isPrime(I(arg0)))); break;  			\
		case GV: pushS(toB(bIsPrime(G(arg0)))); break; 			\
		default: printf("cannot get 'isprime' for value\n");	\
	}                                              				\
}

#define sys_getAbs() {                                         \
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

#define sys_inInc(ARG,G) {\
	ARG += 1;           \
}

#endif