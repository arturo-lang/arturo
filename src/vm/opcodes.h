/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/vm/opcodes.h
 *****************************************************************/

#ifndef __OPCODES_H__
#define __OPCODES_H__

/**************************************
  The Instruction Set
 **************************************/

#define OPCODES(OPC)                        \
    OPC(CONST0,             0x00)           \
    OPC(CONST1,             0x01)           \
    OPC(CONST2,             0x02)           \
    OPC(CONST3,             0x03)           \
    OPC(CONST4,             0x04)           \
    OPC(CONST5,             0x05)           \
    OPC(CONST6,             0x06)           \
    OPC(CONST7,             0x07)           \
    OPC(CONST8,             0x08)           \
    OPC(CONST9,             0x09)           \
    OPC(CONST10,            0x0A)           \
    OPC(CONST11,            0x0B)           \
    OPC(CONST12,            0x0C)           \
    OPC(CONSTT,             0x0D)           \
    OPC(CONSTF,             0x0E)           \
    OPC(CONSTN,             0x0F)           \
                                            \
    OPC(GLOAD0,             0x10)           \
    OPC(GLOAD1,             0x11)           \
    OPC(GLOAD2,             0x12)           \
    OPC(GLOAD3,             0x13)           \
    OPC(GLOAD4,             0x14)           \
    OPC(GLOAD5,             0x15)           \
    OPC(GLOAD6,             0x16)           \
    OPC(GLOAD7,             0x17)           \
    OPC(GLOAD8,             0x18)           \
    OPC(GLOAD9,             0x19)           \
    OPC(GLOAD10,            0x1A)           \
    OPC(GLOAD11,            0x1B)           \
    OPC(GLOAD12,            0x1C)           \
    OPC(GLOAD13,            0x1D)           \
    OPC(GLOAD14,            0x1E)           \
    OPC(GLOAD,              0x1F)           \
                                            \
    OPC(LLOAD0,             0x20)           \
    OPC(LLOAD1,             0x21)           \
    OPC(LLOAD2,             0x22)           \
    OPC(LLOAD3,             0x23)           \
    OPC(LLOAD4,             0x24)           \
    OPC(LLOAD5,             0x25)           \
    OPC(LLOAD6,             0x26)           \
    OPC(LLOAD7,             0x27)           \
    OPC(LLOAD8,             0x28)           \
    OPC(LLOAD9,             0x29)           \
    OPC(LLOAD10,            0x2A)           \
    OPC(LLOAD11,            0x2B)           \
    OPC(LLOAD12,            0x2C)           \
    OPC(LLOAD13,            0x2D)           \
    OPC(LLOAD14,            0x2E)           \
    OPC(LLOAD,              0x2F)           \
                                            \
    OPC(GSTORE0,            0x30)           \
    OPC(GSTORE1,            0x31)           \
    OPC(GSTORE2,            0x32)           \
    OPC(GSTORE3,            0x33)           \
    OPC(GSTORE4,            0x34)           \
    OPC(GSTORE5,            0x35)           \
    OPC(GSTORE6,            0x36)           \
    OPC(GSTORE7,            0x37)           \
    OPC(GSTORE8,            0x38)           \
    OPC(GSTORE9,            0x39)           \
    OPC(GSTORE10,           0x3A)           \
    OPC(GSTORE11,           0x3B)           \
    OPC(GSTORE12,           0x3C)           \
    OPC(GSTORE13,           0x3D)           \
    OPC(GSTORE14,           0x3E)           \
    OPC(GSTORE,             0x3F)           \
                                            \
    OPC(LSTORE0,            0x40)           \
    OPC(LSTORE1,            0x41)           \
    OPC(LSTORE2,            0x42)           \
    OPC(LSTORE3,            0x43)           \
    OPC(LSTORE4,            0x44)           \
    OPC(LSTORE5,            0x45)           \
    OPC(LSTORE6,            0x46)           \
    OPC(LSTORE7,            0x47)           \
    OPC(LSTORE8,            0x48)           \
    OPC(LSTORE9,            0x49)           \
    OPC(LSTORE10,           0x4A)           \
    OPC(LSTORE11,           0x4B)           \
    OPC(LSTORE12,           0x4C)           \
    OPC(LSTORE13,           0x4D)           \
    OPC(LSTORE14,           0x4E)           \
    OPC(LSTORE,             0x4F)           \
                                            \
    OPC(GCALL0,             0x50)           \
    OPC(GCALL1,             0x51)           \
    OPC(GCALL2,             0x52)           \
    OPC(GCALL3,             0x53)           \
    OPC(GCALL4,             0x54)           \
    OPC(GCALL5,             0x55)           \
    OPC(GCALL6,             0x56)           \
    OPC(GCALL7,             0x57)           \
    OPC(GCALL8,             0x58)           \
    OPC(GCALL9,             0x59)           \
    OPC(GCALL10,            0x5A)           \
    OPC(GCALL11,            0x5B)           \
    OPC(GCALL12,            0x5C)           \
    OPC(GCALL13,            0x5D)           \
    OPC(GCALL14,            0x5E)           \
    OPC(GCALL,              0x5F)           \
                                            \
    OPC(LCALL0,             0x60)           \
    OPC(LCALL1,             0x61)           \
    OPC(LCALL2,             0x62)           \
    OPC(LCALL3,             0x63)           \
    OPC(LCALL4,             0x64)           \
    OPC(LCALL5,             0x65)           \
    OPC(LCALL6,             0x66)           \
    OPC(LCALL7,             0x67)           \
    OPC(LCALL8,             0x68)           \
    OPC(LCALL9,             0x69)           \
    OPC(LCALL10,            0x6A)           \
    OPC(LCALL11,            0x6B)           \
    OPC(LCALL12,            0x6C)           \
    OPC(LCALL13,            0x6D)           \
    OPC(LCALL14,            0x6E)           \
    OPC(LCALL,              0x6F)           \
                                            \
    OPC(PUSH,               0x70)           \
    OPC(PUSHA,              0x71)           \
    OPC(PUSHD,              0x72)           \
    OPC(POP,                0x73)           \
    OPC(DUP,                0x74)           \
    OPC(SWAP,               0x75)           \
    OPC(X01,                0x76)           \
    OPC(X02,                0x77)           \
    OPC(X03,                0x78)           \
    OPC(X04,                0x79)           \
    OPC(DSTORE,             0x7A)           \
    OPC(X05,                0x7B)           \
    OPC(X06,                0x7C)           \
    OPC(NEWARR,             0x7D)           \
    OPC(NEWDIC,             0x7E)           \
    OPC(NOP,                0x7F)           \
                                            \
    OPC(ADD,                0x80)           \
    OPC(SUB,                0x81)           \
    OPC(MUL,                0x82)           \
    OPC(DIV,                0x83)           \
    OPC(FDIV,               0x84)           \
    OPC(MOD,                0x85)           \
    OPC(POW,                0x86)           \
    OPC(NEG,                0x87)           \
    OPC(NOT,                0x88)           \
    OPC(AND,                0x89)           \
    OPC(OR,                 0x8A)           \
    OPC(XOR,                0x8B)           \
    OPC(X07,                0x8C)           \
    OPC(X08,                0x8D)           \
    OPC(X09,                0x8E)           \
    OPC(X10,                0x8F)           \
                                            \
    OPC(EXEC,               0x90)           \
    OPC(JUMP,               0x91)           \
    OPC(JMPIFNOT,           0x92)           \
    OPC(JMPIFE,             0x93)           \
    OPC(LOOPIF,             0x94)           \
    OPC(RET,                0x95)           \
    OPC(RETC,               0x96)           \
    OPC(END,                0x97)           \
    OPC(CMPEQ,              0x98)           \
    OPC(CMPNE,              0x99)           \
    OPC(CMPGT,              0x9A)           \
    OPC(CMPGE,              0x9B)           \
    OPC(CMPLT,              0x9C)           \
    OPC(CMPLE,              0x9D)           \
    OPC(X11,                0x9E)           \
    OPC(X12,                0x9F)           \
                                            \
    OPC(DO_PRINT,           0xA0)           \
    OPC(DO_APPEND,          0xA1)           \
    OPC(DO_INC,             0xA2)           \
    OPC(COPY,               0xA3)           \
    OPC(DO_LOG,             0xA4)           \
    OPC(GET_SIZE,           0xA5)           \
    OPC(DO_GET,             0xA6)   

/**************************************
  Enums
 **************************************/

#define GENERATE_OP_ENUM(ENUM,VAL) ENUM = VAL,

enum OpCode {
    OPCODES(GENERATE_OP_ENUM)
};

/**************************************
  Type definitions
 **************************************/

typedef enum OpCode OPCODE;

/**************************************
  Globals
 **************************************/

#ifdef DEBUG

    #define GENERATE_OP_STRING(ENUM,_) #ENUM,

    static const char *OpCodeStr[] = {
        OPCODES(GENERATE_OP_STRING)
    };

#endif

/**************************************
  Aliases
 **************************************/

#define GENERATE_OP_DISPATCH(ENUM,_) &&case_##ENUM,

#endif