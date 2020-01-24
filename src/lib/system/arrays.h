/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/lib/system/numbers.h
 *****************************************************************/

#ifndef __LIB_SYSTEM_ARRAYS_H__
#define __LIB_SYSTEM_ARRAYS_H__

static INLINED int sortCmpI (const void* left, const void* right) {
    int l = I(*((Value*)left));
    int r = I(*((Value*)right));
    if (l > r) return  1;
    if (l < r) return -1;
    return 0;
}

static INLINED int sortCmpS (const void* left, const void* right) {
    String* l = S(*((Value*)left));
    String* r = S(*((Value*)right));

    return sCmp(l,r);
}

#define sys_doSort() {\
	Value arg0 = popS();\
	ValueArray* arr = aDup(Value,A(arg0));\
	switch (Kind(arr->data[0])) {\
		case IV: qsort(arr->data,arr->size,arr->typeSize,sortCmpI); break;\
		case SV: qsort(arr->data,arr->size,arr->typeSize,sortCmpS); break;\
		default: printf("cannot sort\n");\
	}\
	pushS(toA(arr));\
}

#define sys_inSort(ARG) {\
	ValueArray* arr = A(ARG);\
	switch (Kind(arr->data[0])) {\
		case IV: qsort(arr->data,arr->size,arr->typeSize,sortCmpI); break;\
		case SV: qsort(arr->data,arr->size,arr->typeSize,sortCmpS); break;\
		default: printf("cannot sort\n");\
	}\
}

#define sys_inSwap(ARG) {               	\
	ValueArray* arr = A(ARG);               \
	Value arg1 = popS();                    \
	Value arg0 = popS();                    \
	Value temp = arr->data[I(arg0)];        \
	arr->data[I(arg0)] = arr->data[I(arg1)];\
	arr->data[I(arg1)] = temp;              \
}

#define sys_getProduct() {                \
	Value arg0 = popS();                  \
	Value ret = toI(1);                   \
	ValueArray* arr = A(arg0);            \
	aEach(arr,i) {                        \
		Value old = ret;				  \
		ret = mulValues(ret,arr->data[i]);\
		if (Kind(old)==GV) bFree(G(old)); \
	}                                     \
	pushS(ret);                           \
}

#define sys_getRange() {                                   \
	Value arg1 = popS();                                   \
	Value arg0 = popS();                                   \
	Int32 startVal = I(arg0);                              \
	Int32 stopVal = I(arg1);                               \
	ValueArray* ret = aNew(Value, abs(stopVal-startVal)+1);\
	ret->size = abs(stopVal-startVal)+1;                   \
	Int32 cnt = 0;                                         \
	if (startVal<stopVal) {                                \
		stopVal++;                                         \
		for (Int32 i=startVal; i<stopVal; i++) {           \
			ret->data[cnt++] = toI(i);                     \
		}                                                  \
	}                                                      \
	else {                                                 \
		stopVal--;                                         \
		for (Int32 i=startVal; i>stopVal; i--) {           \
			ret->data[cnt++] = toI(i);                     \
		}                                                  \
	}                                                      \
	pushS(toA(ret));                                       \
}

#endif