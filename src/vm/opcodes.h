/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/vm/opcodes.h
 *****************************************************************/

#ifndef __OPCODES_H__
#define __OPCODES_H__

/**************************************
  The Instruction Set
 **************************************/

#define OPCODES(OPC)                        \
                                            \
    /* integer/float/boolean constants */   \
                                            \
    OPC(IPUSH0,             0x00)           \
    OPC(IPUSH1,             0x01)           \
    OPC(IPUSH2,             0x02)           \
    OPC(IPUSH3,             0x03)           \
    OPC(IPUSH4,             0x04)           \
    OPC(IPUSH5,             0x05)           \
    OPC(IPUSH6,             0x06)           \
    OPC(IPUSH7,             0x07)           \
    OPC(IPUSH8,             0x08)           \
    OPC(IPUSH9,             0x09)           \
    OPC(IPUSH10,            0x0A)           \
                                            \
    OPC(IPUSHM1,            0x0B)           \
                                            \
    OPC(FPUSH1,             0x0C)           \
                                            \
    OPC(BPUSHT,             0x0D)           \
    OPC(BPUSHF,             0x0E)           \
                                            \
    OPC(NPUSH,              0x0F)           \
                                            \
    /* push constants */                    \
                                            \
    OPC(CPUSH0,             0x10)           \
    OPC(CPUSH1,             0x11)           \
    OPC(CPUSH2,             0x12)           \
    OPC(CPUSH3,             0x13)           \
    OPC(CPUSH4,             0x14)           \
    OPC(CPUSH5,             0x15)           \
    OPC(CPUSH6,             0x16)           \
    OPC(CPUSH7,             0x17)           \
    OPC(CPUSH8,             0x18)           \
    OPC(CPUSH9,             0x19)           \
    OPC(CPUSH10,            0x1A)           \
    OPC(CPUSH11,            0x1B)           \
    OPC(CPUSH12,            0x1C)           \
    OPC(CPUSH13,            0x1D)           \
    OPC(CPUSH14,            0x1E)           \
                                            \
    OPC(CPUSH,              0x1F)           \
                                            \
    /* load global/local variable */        \
                                            \
    OPC(GLOAD0,             0x20)           \
    OPC(GLOAD1,             0x21)           \
    OPC(GLOAD2,             0x22)           \
    OPC(GLOAD3,             0x23)           \
    OPC(GLOAD4,             0x24)           \
    OPC(GLOAD5,             0x25)           \
    OPC(GLOAD6,             0x26)           \
    OPC(GLOAD7,             0x27)           \
    OPC(GLOAD8,             0x28)           \
    OPC(GLOAD9,             0x29)           \
                                            \
    OPC(GLOAD,              0x2A)           \
                                            \
    OPC(LLOAD0,             0x2B)           \
    OPC(LLOAD1,             0x2C)           \
    OPC(LLOAD2,             0x2D)           \
    OPC(LLOAD3,             0x2E)           \
                                            \
    OPC(LLOAD,              0x2F)           \
                                            \
    /* store global/local variable */       \
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
                                            \
    OPC(GSTORE,             0x3A)           \
                                            \
    OPC(LSTORE0,            0x3B)           \
    OPC(LSTORE1,            0x3C)           \
    OPC(LSTORE2,            0x3D)           \
    OPC(LSTORE3,            0x3E)           \
                                            \
    OPC(LSTORE,             0x3F)           \
                                            \
    /* call global/local function */        \
                                            \
    OPC(GCALL0,             0x40)           \
    OPC(GCALL1,             0x41)           \
    OPC(GCALL2,             0x42)           \
    OPC(GCALL3,             0x43)           \
    OPC(GCALL4,             0x44)           \
    OPC(GCALL5,             0x45)           \
    OPC(GCALL6,             0x46)           \
    OPC(GCALL7,             0x47)           \
    OPC(GCALL8,             0x48)           \
    OPC(GCALL9,             0x49)           \
                                            \
    OPC(GCALL,              0x4A)           \
                                            \
    OPC(LCALL0,             0x4B)           \
    OPC(LCALL1,             0x4C)           \
    OPC(LCALL2,             0x4D)           \
    OPC(LCALL3,             0x4E)           \
                                            \
    OPC(LCALL,              0x4F)           \
                                            \
    /* miscellaneous stack functions */     \
                                            \
    OPC(NEWARR,             0x50)           \
    OPC(NEWDIC,             0x51)           \
                                            \
    OPC(PUSHA,              0x52)           \
    OPC(PUSHD,              0x53)           \
                                            \
    OPC(DSTORE,             0x54)           \
                                            \
    OPC(POP,                0x55)           \
    OPC(DUP,                0x56)           \
    OPC(SWAP,               0x57)           \
    OPC(NOP,                0x58)           \
                                            \
    OPC(X01,                0x59)           \
    OPC(X02,                0x5A)           \
    OPC(X03,                0x5B)           \
    OPC(X04,                0x5C)           \
    OPC(X05,                0x5D)           \
    OPC(X06,                0x5E)           \
    OPC(X07,                0x5F)           \
                                            \
    /* arithmetic/logical operators */      \
                                            \
    OPC(ADD,                0x60)           \
    OPC(SUB,                0x61)           \
    OPC(MUL,                0x62)           \
    OPC(DIV,                0x63)           \
    OPC(FDIV,               0x64)           \
    OPC(MOD,                0x65)           \
    OPC(POW,                0x66)           \
                                            \
    OPC(NEG,                0x67)           \
                                            \
    OPC(NOT,                0x68)           \
    OPC(AND,                0x69)           \
    OPC(OR,                 0x6A)           \
    OPC(XOR,                0x6B)           \
                                            \
    OPC(X08,                0x6C)           \
    OPC(X09,                0x6D)           \
    OPC(X10,                0x6E)           \
    OPC(X11,                0x6F)           \
                                            \
    /* comparisons & flow control */        \
                                            \
    OPC(CMPEQ,              0x70)           \
    OPC(CMPNE,              0x71)           \
    OPC(CMPGT,              0x72)           \
    OPC(CMPGE,              0x73)           \
    OPC(CMPLT,              0x74)           \
    OPC(CMPLE,              0x75)           \
                                            \
    OPC(JUMP,               0x76)           \
    OPC(JMPIFNOT,           0x77)           \
    OPC(RET,                0x78)           \
                                            \
    OPC(EXEC,               0x79)           \
                                            \
    OPC(END,                0x7A)           \
                                            \
    OPC(X12,                0x7B)           \
    OPC(X13,                0x7C)           \
    OPC(X14,                0x7D)           \
    OPC(X15,                0x7E)           \
    OPC(X16,                0x7F)           \
                                            \
    /* system calls (128 slots) */          \
                                            \
    OPC(DO_PRINT,           0x80)           \
    OPC(DO_INC,             0x81)           \
    OPC(DO_APPEND,          0x82)           \
    OPC(DO_LOG,             0x83)           \
    OPC(DO_GET,             0x84)           \
    OPC(GET_SIZE,           0x85)

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

#define GENERATE_OP_STRING(ENUM,_) #ENUM,

static const char *OpCodeStr[] = {
    OPCODES(GENERATE_OP_STRING)
};

/**************************************
  Aliases
 **************************************/

#define GENERATE_OP_DISPATCH(ENUM,_) &&case_##ENUM,

#endif