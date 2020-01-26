/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/vm/optimizer.c
 *****************************************************************/

#include "arturo.h"

#define matchesByte(POS,M)              ((POS < BCode->size) && ( \
                                            (BCode->data[POS] == (M)) \
                                        ))
#define matchesWord(POS,M1,M2)          ((POS+1 < BCode->size) && ( \
                                            (BCode->data[POS]==M1) && (BCode->data[POS+1]==M2) \
                                        ))
#define matchesDword(POS,M1,M2,M3,M4)   ((POS+3 < BCode->size) && ( \
                                            (BCode->data[POS]==M1) && (BCode->data[POS+1]==M2) && \
                                            (BCode->data[POS+2]==M3) && (BCode->data[POS+3]==M4) \
                                        ))

#define matchesByteInRange(POS,FROM,TO) ((POS < BCode->size) && \
                                        ((BCode->data[POS]>=FROM) && (BCode->data[POS]<=TO)))

/**************************************
  Helpers
 **************************************/

static inline void optimizeMulDivs(unsigned int i) {
    // x * 2 => x << 1
    if (matchesWord(i, IPUSH2, MUL)) {
        BCode->data[i] = IPUSH1;
        BCode->data[i+1] = SHL;
    }
    // x / 2 => x >> 1
    else if (matchesWord(i, IPUSH2, DIV)) {
        BCode->data[i] = IPUSH1;
        BCode->data[i+1] = SHR;
    }
    // x * 1 => x
    else if (matchesWord(i, IPUSH1, MUL)) {
        BCode->data[i] = NOP;
        BCode->data[i+1] = NOP;
    }
}

static inline void optimizeDistributiveProperty(unsigned int i) {
    if (matchesByte(i+2,MUL) && matchesByte(i+5,MUL) && matchesByte(i+6,ADD)) {
        if ((matchesByteInRange(i, GLOAD0, GLOAD8)   || matchesByteInRange(i, LLOAD0, LLOAD4) || matchesByteInRange(i, IPUSH0, IPUSH10)) && 
            (matchesByteInRange(i+1, GLOAD0, GLOAD8) || matchesByteInRange(i+1, LLOAD0, LLOAD4) || matchesByteInRange(i+1, IPUSH0, IPUSH10))&&
            (matchesByteInRange(i+3, GLOAD0, GLOAD8) || matchesByteInRange(i+3, LLOAD0, LLOAD4) || matchesByteInRange(i+3, IPUSH0, IPUSH10))&&
            (matchesByteInRange(i+4, GLOAD0, GLOAD8) || matchesByteInRange(i, LLOAD0, LLOAD4) || matchesByteInRange(i+4, IPUSH0, IPUSH10))
           ) {
            if (BCode->data[i]==BCode->data[i+3]) {
                BCode->data[i]=BCode->data[i+1];
                BCode->data[i+1]=BCode->data[i+4];
                BCode->data[i+2]=ADD;
                BCode->data[i+4]=MUL;
                BCode->data[i+5]=NOP;
                BCode->data[i+6]=NOP;
            }
        }
    }
}

/**************************************
  Methods
 **************************************/

void optimizeBytecode() { 
    aEach(BCode, i) {
        optimizeMulDivs(i);
        optimizeDistributiveProperty(i);
    }
}