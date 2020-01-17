/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/vm/optimizer.c
 *****************************************************************/

#include "arturo.h"

/**************************************
  Helpers
 **************************************/

static inline void optimizeMulDivs() {
  int IP = 0;
    int cmd = -1;
    OPCODE last_op;
    int last_op_IP;

    aEach(BCode,i) {
        if (BCode->data[i]==IPUSH2) {
            if (i+1<BCode->size) {
                if (BCode->data[i+1]==MUL) {
                    BCode->data[i] = IPUSH1;
                    BCode->data[i+1] = SHL;
                }
                else if (BCode->data[i+1]==DIV) {
                    BCode->data[i] = IPUSH1;
                    BCode->data[i+1] = SHR;
                }
            }
        }
    }

}

/**************************************
  Methods
 **************************************/

void optimizeBytecode() { 
  printf("optimizing...\n");
  optimizeMulDivs();
}