/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/vm/value.h
 *****************************************************************/

#ifndef __VALUE_H__
#define __VALUE_H__

/**************************************
  Enums
 **************************************/

enum ValueType {
	NV  = 0,
	IV  = 1,
	RV  = 2,
	BV  = 4,
	GV  = 8,
	SV  = 16,
	AV  = 32,
	DV  = 64,
	FV  = 128,
	ANY = 255
};

/**************************************
  Type definitions
 **************************************/

typedef int32_t Int32;
typedef float Float32;

typedef enum ValueType VALUETYPE;

typedef Array(Value)    ValueArray;

/**************************************
  Masks
 **************************************/

#define BITFIELD 56

#define MASK(x) ((Value)(x) << BITFIELD)
#define DOMASK  0xFF00000000000000
#define UNMASK  0x00FFFFFFFFFFFFFF

/**************************************
  Converters
 **************************************/

#define Kind(v)	(Byte)((VALUETYPE)((v & DOMASK) >> BITFIELD))

#define I(v)    ((Int32)(v & UNMASK))
#define B(v)	((bool)(v & UNMASK))
#define G(v) 	((Bignum_p)(v & UNMASK))
#define S(v) 	((String*)(v & UNMASK))
#define A(v)	((ValueArray*)(v & UNMASK))
#define F(v)	((Func*)(v & UNMASK))

#define toI(v)  ( (Value)(v & 0xFFFFFFFFu) | MASK(IV) )
#define toB(v)	( (v) ? TRUEV : FALSEV )
#define toG(v)  ( (Value)(v) | MASK(GV) )
#define toS(v)  ( (Value)(v) | MASK(SV) )
#define toA(v)  ( (Value)(v) | MASK(AV) )
#define toF(v)	( (Value)(v) | MASK(FV) )

/**************************************
  Constants
 **************************************/

#define INTV1M	toI(-1)

#define INTV0 	toI(0)
#define INTV1 	toI(1)
#define INTV2 	toI(2)
#define INTV3 	toI(3)
#define INTV4   toI(4)
#define INTV5 	toI(5)
#define INTV6   toI(6)
#define INTV7 	toI(7)
#define INTV8 	toI(8)
#define INTV9 	toI(9)
#define INTV10  toI(10)
#define INTV11  toI(11)
#define INTV12  toI(12)

#define TRUEV  	((Value)(1) | MASK(BV))
#define FALSEV 	((Value)(0) | MASK(BV))

#define NULLV   (Value)(0)

/**************************************
  Function declarations
 **************************************/

Float32 R(Value v);
Value toR(Float32 f);

Value strToIntValue(char* str);
Value strToBigintValue(char* str);
Value strToRealValue(char* str);
Value strToStringValue(char* str);

Value addValues(Value l, Value r);
Value subValues(Value l, Value r);
Value mulValues(Value l, Value r);
Value divValues(Value l, Value r);
Value fdivValues(Value l, Value r);
Value modValues(Value l, Value r);
Value powValues(Value l, Value r);

bool eqValues(Value l, Value r);
bool gtValues(Value l, Value r);
bool ltValues(Value l, Value r);

String* stringify(Value v);
void printValue(Value v);
void printLnValue(Value v);

/**************************************
  Static Methods
 **************************************/

static inline bool neValues(Value l, Value r) {
	return (!eqValues(l,r));
}

static inline bool geValues(Value l, Value r) {
	return (gtValues(l,r) || eqValues(l,r));
}

static inline bool leValues(Value l, Value r) {
	return (ltValues(l,r) || eqValues(l,r));
}

/**************************************
  Globals
 **************************************/

static const char *ValueTypeStr[] = {"Null","Int","Real","Bool","BInt","String","Array","Dict","Func"}; 

/**************************************
  Macros
 **************************************/

#define getValueTypeStr(X) ValueTypeStr[(int)(log2(Kind(X))+1)]

#endif
