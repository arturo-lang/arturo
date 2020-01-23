/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/lib/system/generic.h
 *****************************************************************/

#ifndef __LIB_SYSTEM_GENERIC_H__
#define __LIB_SYSTEM_GENERIC_H__

#define sys_getSize() {                                 \
    Value popped = popS();                              \
    switch (Kind(popped)) {                             \
        case SV: pushS(toI(sSize(S(popped)))); break;   \
        case AV: pushS(toI(aSize(A(popped)))); break;   \
        case DV: pushS(toI(dSize(D(popped)))); break;   \
        default: print("cannot get 'size' for value: ");\
                 printLnValue(popped);                  \
                 exit(1);                               \
    }                                                   \
}

#define sys_inAppend(ARG) {\
	Value arg0 = popS();\
	switch (Kind(ARG)) {\
		case SV: {\
			if (Kind(arg0)==SV) {\
				sCat(S(ARG),S(arg0));\
			}\
			else {\
				String* right = stringify(arg0);\
				sCat(S(ARG),right);\
				sFree(right);\
			}\
		}\
		break;\
		case AV: {\
			if (Kind(arg0)==AV) {\
				ValueArray* right = A(arg0);\
				aEach(right,i) {\
					aAdd(A(ARG), right->data[i]);\
				}\
			} \
			else {\
				aAdd(A(ARG), arg0);\
			}\
		}\
		break;\
		default: printf("cannot in-append\n"); exit(1);\
	}\
}

#endif