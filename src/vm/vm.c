/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/vm/vm.c
 *****************************************************************/

#include "../arturo.h"
#include "../lib/system.h"

/**************************************
  Debugging helpers
 **************************************/

void inspectByteCode(Byte* bcode) {
    debugHeader("Data Segment");
    aEach(BData, i) {
        String* vStr = stringify(BData->data[i]);
        printf("%-4d: [%-6s]= %.*s\n",i,getValueTypeStr(BData->data[i]),vStr->size, vStr->content);
    }
    debugFooter("Data Segment");

    ///

    debugHeader("Bytecode Listing");

    int IP = 0;
    int cmd = -1;

    while (true) {
        cmd++;
        printf("%-4d\e[2m:%-8d\e[0;37m",cmd,IP);
        OPCODE op = readByte(bcode,IP++);
        printf("%s",OpCodeStr[op]);

        switch(op) {
            case JUMP:
            case JMPIFNOT:
                printf(" [Dword] %d\n", readDword(bcode,IP));
                IP+=4;
                break;

            case CPUSH:
            case GLOAD:
            case GSTORE:
            case DSTORE:
            case GCALL:
                printf(" [Word] %d\n", readWord(bcode,IP));
                IP+=2;
                break;
            case LLOAD:
            case LSTORE:
            case LCALL:
                printf(" [Byte] %d\n", readByte(bcode,IP));
                IP+=1;
                break;
            case END:
                printf("\n");
                goto exitProfileLoop_;
            default:
                printf("\n");
        }
    }

    exitProfileLoop_:

    debugFooter("Bytecode Listing");
}

#ifdef PROFILE
    void inspectProfiler() {
        printf("\n");

        debugHeader("Profiler");

        String* countField = sNew("count");
        String* timeField = sNew("time");

        Value totalMs = 0;

        aEach(Prof->keys,i) {
            Dict* sub = D(dGet(Prof,Prof->keys->data[i]));
            totalMs += dGet(sub,timeField);
        }

        printf("\n");
        printf(" %-10s : %-13s | %-10s | %-10s | %s\n","OPCODE","Count","Total (μs)","Ratio (%)","Avg (μs/instr)");
        printf("=========================================================================\n");
        aEach(Prof->keys,i) {
            Dict* sub = D(dGet(Prof,Prof->keys->data[i]));
            printf(" %-10s : %-13llu | %-10llu | %-10llu | %-7.2f\n",Prof->keys->data[i]->content, dGet(sub,countField), dGet(sub,timeField), (dGet(sub,timeField)*100)/totalMs, (float)((float)dGet(sub,timeField)/(float)dGet(sub,countField)));
        }

        printf("\n");

        printf(" TIMINGS\n");
        printf("=========================================================================\n");
        printf(" bytecode generation   : %.3fs\n",Prof_genTime);
        printf(" code execution        : %.3fs\n",Prof_execTime);

        printf("\n");

        debugFooter("Profiler");
    }
#endif

/**************************************
  The main interpreter loop
 **************************************/

char* execute(register Byte* bcode) {   
    //-------------------------
    // Our registers
    //-------------------------

    register int sp = -1;
    register int fp = -1;
    register unsigned int ip = 0;

    //-------------------------
    // The Global Table
    //-------------------------

    register Value GlobalTable[GLOBAL_SIZE];

    #define storeGlobal(X) { \
        int k = Kind(GlobalTable[X]);                                   \
        Value popped = popS();                                          \
        if (k==SV) { S(popped)->refc++; sFree(S(GlobalTable[X])); }     \
        else if (k==AV) { aFree(A(GlobalTable[X])); }                   \
        else if (k==GV) { mpz_clear((mpz_ptr)G(GlobalTable[X])); }      \
        GlobalTable[X] = popped;                                        \
    }   

    #define callGlobal(X) { \
        Func* f = F(GlobalTable[X]);                                    \
        Byte z = f->args;                                               \
        int newsp = sp-z;                                               \
        CallFrame fr = {                                                \
            .ip = ip,                                                   \
            .size = z                                                   \
        };                                                              \
        fr.Locals[0] = Stack[newsp+1];                                  \
        fr.Locals[1] = Stack[newsp+2];                                  \
        fr.Locals[2] = Stack[newsp+3];                                  \
        fr.Locals[3] = Stack[newsp+4];                                  \
        fr.Locals[4] = Stack[newsp+5];                                  \
        sp -= z;                                                        \
        pushF(fr);                                                      \
        ip = f->ip;                                                     \
    }   

    //-------------------------
    // The Local Table
    //-------------------------                         

    #define storeLocal(X) { \
        topF0.Locals[X] = popS();                                       \
    }

    #define freeFrame() { \
        Byte z = topF0.size;                                                \
        volatile Value* topLocals = topF0.Locals;                           \
        for (int i=0; i<z; i++) {                                           \
            int k = Kind(topLocals[i]);                                     \
            if (k==SV) { sFree(S(topLocals[i])); }                          \
            else if (k==AV) { aFree(A(topLocals[i])); }                     \
            else if (k==GV) { mpz_clear((mpz_ptr)G(topLocals[i])); }        \
        }                                                                   \
    }

    //-------------------------
    // Stack handling
    //-------------------------

    register Value Stack[STACK_SIZE];

    #define pushS(X)    Stack[sp+1] = X; sp++
    #define popS()      Stack[sp--]
    #define topS0       Stack[sp]
    #define topS1       Stack[sp-1]
    #define topS2       Stack[sp-2]

    register CallFrame FrameStack[FRAMESTACK_SIZE];

    #define pushF(X)    FrameStack[fp+1] = X; fp++
    #define popF()      FrameStack[fp--]
    #define topF0       FrameStack[fp]
    #define topF1       FrameStack[fp-1]
    #define topF2       FrameStack[fp-2]

    //-------------------------
    // Instruction handling
    //-------------------------

    OPCODE op = END;

    #define nextOp      readByte(bcode,ip++)
    #define nextByte    readByte(bcode,ip++)
    #define nextWord    readWord(bcode,ip);  ip+=2;
    #define nextDword   readDword(bcode,ip); ip+=4;
    #define nextValue   readValue(bcode,ip); ip+=8;

    //-------------------------
    // Computed Goto
    //-------------------------

    #ifdef COMPUTED_GOTO

        static void* dispatchTable[] = {
            OPCODES(GENERATE_OP_DISPATCH)
        }; 

        #define INTERPRETER_LOOP        DISPATCH();

        #define OPCASE(name)            case_##name

        #if defined(PROFILE)
            String* countField = sNew("count");
            String* timeField = sNew("time");
            double startTime;
            #define DISPATCH()                                          \
                if (op!=END) {                                          \
                    Value timeMs = getCurrentTime()-startTime;          \
                    String* ss = sNew((char*)OpCodeStr[op]);            \
                    Dict* sub = D(dGet(Prof,ss));                       \
                    dSet(sub,timeField,dGet(sub,timeField)+timeMs);     \
                }                                                       \
                op = nextOp;                                            \
                {                                                       \
                    String* ss = sNew((char*)OpCodeStr[op]);            \
                    if (dHasKey(Prof,ss)) {                             \
                        Dict* sub = D(dGet(Prof,ss));                   \
                        dSet(sub,countField,dGet(sub,countField)+1);    \
                    }                                                   \
                    else {                                              \
                        Dict* sub = dNew(4);                            \
                        dAdd(sub,countField,1);                         \
                        dAdd(sub,timeField,0);                          \
                        dAdd(Prof,ss,toD(sub));                         \
                    }                                                   \
                }                                                       \
                startTime = getCurrentTime();                           \
                goto *dispatchTable[op];

        #elif defined(DEBUG)
            #define DISPATCH()                                          \
                op = nextOp;                                            \
                printf("exec: %s\n",OpCodeStr[op]);                     \
                goto *dispatchTable[op];

        #else   
            #define DISPATCH()                                          \
                goto *dispatchTable[op = nextOp]

        #endif
    #else
        #ifdef PROFILE
            #define INTERPRETER_LOOP                                    \
                startLoop_:                                             \
                    op = nextOp;                                        \
                    printf("exec: %s\n",OpCodeStr[op]);                 \
                    switch(op)
        #else
            #define INTERPRETER_LOOP                                    \
                startLoop_:                                             \
                    switch(op = nextOp)             
        #endif

        #define OPCASE(name)    case name
        #define DISPATCH()      goto startLoop_
    #endif

    //-------------------------
    // The main loop
    //-------------------------

    INTERPRETER_LOOP {

        /***************************
          Core Operations
         ***************************/

        //---------------------------------------
        // integer/float/boolean constants
        //---------------------------------------

        OPCASE(IPUSH0)  : pushS(INTV0);     DISPATCH();
        OPCASE(IPUSH1)  : pushS(INTV1);     DISPATCH();
        OPCASE(IPUSH2)  : pushS(INTV2);     DISPATCH();
        OPCASE(IPUSH3)  : pushS(INTV3);     DISPATCH();
        OPCASE(IPUSH4)  : pushS(INTV4);     DISPATCH();
        OPCASE(IPUSH5)  : pushS(INTV5);     DISPATCH();
        OPCASE(IPUSH6)  : pushS(INTV6);     DISPATCH();
        OPCASE(IPUSH7)  : pushS(INTV7);     DISPATCH();
        OPCASE(IPUSH8)  : pushS(INTV8);     DISPATCH();
        OPCASE(IPUSH9)  : pushS(INTV9);     DISPATCH();
        OPCASE(IPUSH10) : pushS(INTV10);    DISPATCH();

        OPCASE(IPUSHM1) : pushS(INTV1M);    DISPATCH();

        OPCASE(FPUSH1)  : pushS(FLOATV1);   DISPATCH();
        
        OPCASE(BPUSHT)  : pushS(TRUEV);     DISPATCH();
        OPCASE(BPUSHF)  : pushS(FALSEV);    DISPATCH();

        OPCASE(NPUSH)   : pushS(NULLV);     DISPATCH();

        //---------------------------------------
        // push constants
        //---------------------------------------

        OPCASE(CPUSH0)  : pushS(BData->data[0]);    DISPATCH();
        OPCASE(CPUSH1)  : pushS(BData->data[1]);    DISPATCH();
        OPCASE(CPUSH2)  : pushS(BData->data[2]);    DISPATCH();
        OPCASE(CPUSH3)  : pushS(BData->data[3]);    DISPATCH();
        OPCASE(CPUSH4)  : pushS(BData->data[4]);    DISPATCH();
        OPCASE(CPUSH5)  : pushS(BData->data[5]);    DISPATCH();
        OPCASE(CPUSH6)  : pushS(BData->data[6]);    DISPATCH();
        OPCASE(CPUSH7)  : pushS(BData->data[7]);    DISPATCH();
        OPCASE(CPUSH8)  : pushS(BData->data[8]);    DISPATCH();
        OPCASE(CPUSH9)  : pushS(BData->data[9]);    DISPATCH();
        OPCASE(CPUSH10) : pushS(BData->data[10]);   DISPATCH();
        OPCASE(CPUSH11) : pushS(BData->data[11]);   DISPATCH();
        OPCASE(CPUSH12) : pushS(BData->data[12]);   DISPATCH();
        OPCASE(CPUSH13) : pushS(BData->data[13]);   DISPATCH();
        OPCASE(CPUSH14) : pushS(BData->data[14]);   DISPATCH();

        OPCASE(CPUSH)   : {
            Word addr = nextWord;
            pushS(BData->data[addr]);   
            DISPATCH();
        }

        //---------------------------------------
        // load global/local variable
        //---------------------------------------

        OPCASE(GLOAD0)   : pushS(GlobalTable[0]);  DISPATCH();
        OPCASE(GLOAD1)   : pushS(GlobalTable[1]);  DISPATCH();
        OPCASE(GLOAD2)   : pushS(GlobalTable[2]);  DISPATCH();
        OPCASE(GLOAD3)   : pushS(GlobalTable[3]);  DISPATCH();
        OPCASE(GLOAD4)   : pushS(GlobalTable[4]);  DISPATCH();
        OPCASE(GLOAD5)   : pushS(GlobalTable[5]);  DISPATCH();
        OPCASE(GLOAD6)   : pushS(GlobalTable[6]);  DISPATCH();
        OPCASE(GLOAD7)   : pushS(GlobalTable[7]);  DISPATCH();
        OPCASE(GLOAD8)   : pushS(GlobalTable[8]);  DISPATCH();
        OPCASE(GLOAD9)   : pushS(GlobalTable[9]);  DISPATCH();
        
        OPCASE(GLOAD)    : { 
            Word ind = nextWord;
            pushS(GlobalTable[ind]); 
            DISPATCH();
        }

        OPCASE(LLOAD0)   : pushS(topF0.Locals[0]);  DISPATCH();
        OPCASE(LLOAD1)   : pushS(topF0.Locals[1]);  DISPATCH();
        OPCASE(LLOAD2)   : pushS(topF0.Locals[2]);  DISPATCH();
        OPCASE(LLOAD3)   : pushS(topF0.Locals[3]);  DISPATCH();

        OPCASE(LLOAD)    : { 
            Word ind = nextByte;
            pushS(topF0.Locals[ind]); 
            DISPATCH();
        }

        //---------------------------------------
        // store global/local variable
        //---------------------------------------

        OPCASE(GSTORE0)  : storeGlobal(0);  DISPATCH();
        OPCASE(GSTORE1)  : storeGlobal(1);  DISPATCH();
        OPCASE(GSTORE2)  : storeGlobal(2);  DISPATCH();
        OPCASE(GSTORE3)  : storeGlobal(3);  DISPATCH();
        OPCASE(GSTORE4)  : storeGlobal(4);  DISPATCH();
        OPCASE(GSTORE5)  : storeGlobal(5);  DISPATCH();
        OPCASE(GSTORE6)  : storeGlobal(6);  DISPATCH();
        OPCASE(GSTORE7)  : storeGlobal(7);  DISPATCH();
        OPCASE(GSTORE8)  : storeGlobal(8);  DISPATCH();
        OPCASE(GSTORE9)  : storeGlobal(9);  DISPATCH();

        OPCASE(GSTORE)   : {
            Word ind = nextWord;
            storeGlobal(ind); 
            DISPATCH();
        }

        OPCASE(LSTORE0)  : storeLocal(0);  DISPATCH();
        OPCASE(LSTORE1)  : storeLocal(1);  DISPATCH();
        OPCASE(LSTORE2)  : storeLocal(2);  DISPATCH();
        OPCASE(LSTORE3)  : storeLocal(3);  DISPATCH();

        OPCASE(LSTORE)   : {
            Word ind = nextByte;
            storeLocal(ind); 
            DISPATCH();
        }

        //---------------------------------------
        // call global/local function
        //---------------------------------------

        OPCASE(GCALL0)   : callGlobal(0);  DISPATCH();
        OPCASE(GCALL1)   : callGlobal(1);  DISPATCH();
        OPCASE(GCALL2)   : callGlobal(2);  DISPATCH();
        OPCASE(GCALL3)   : callGlobal(3);  DISPATCH();
        OPCASE(GCALL4)   : callGlobal(4);  DISPATCH();
        OPCASE(GCALL5)   : callGlobal(5);  DISPATCH();
        OPCASE(GCALL6)   : callGlobal(6);  DISPATCH();
        OPCASE(GCALL7)   : callGlobal(7);  DISPATCH();
        OPCASE(GCALL8)   : callGlobal(8);  DISPATCH();
        OPCASE(GCALL9)   : callGlobal(9);  DISPATCH();

        OPCASE(GCALL)    : {
            Word ind = nextWord;
            callGlobal(ind); 
            DISPATCH();
        }

        OPCASE(LCALL0)   : /* not implemented */
        OPCASE(LCALL1)   : /* not implemented */
        OPCASE(LCALL2)   : /* not implemented */
        OPCASE(LCALL3)   : /* not implemented */

        OPCASE(LCALL)    : /* not implemented */ DISPATCH();

        //---------------------------------------
        // miscellaneous stack functions
        //---------------------------------------

        OPCASE(NEWARR)   : {
            aAdd(ArrayStarts, sp+1);
            DISPATCH();
        }
        OPCASE(NEWDIC)   : {
            aAdd(DictArray, dNew(INITIAL_DICT_SIZE));
            DISPATCH();
        }

        OPCASE(PUSHA)    : {
            int start_index  = aPop(ArrayStarts);
            int last_index = sp;
            ValueArray* ret = aNew(Value,last_index-start_index+1);

            for (int i=start_index; i<=last_index; i++) {
                aAdd(ret,Stack[i]);
                sp--;
            }
            pushS(toA(ret));
            DISPATCH();
        }
        OPCASE(PUSHD)    : pushS(toD(aPop(DictArray))); DISPATCH();

        OPCASE(DSTORE)   : {
            //Dicts[^1][S(readValue())] = pop()
            Word addr = nextWord;
            dAdd(aLast(DictArray),S(BData->data[addr]),popS());
            DISPATCH();
        }

        OPCASE(POP)      : sp--; DISPATCH();
        OPCASE(DUP)      : sp++; topS0=topS1; DISPATCH();
        OPCASE(SWAP)     : {
            Value tmp = topS0;
            topS0 = topS1;
            topS1 = tmp;
            DISPATCH();
        }
        OPCASE(NOP)      : /* no operation */ DISPATCH();

        //---------------------------------------
        // arithmetic/logical operators
        //---------------------------------------

        OPCASE(ADD)      : topS1 = addValues(topS1,topS0);  sp--; DISPATCH();
        OPCASE(SUB)      : topS1 = subValues(topS1,topS0);  sp--; DISPATCH();
        OPCASE(MUL)      : topS1 = mulValues(topS1,topS0);  sp--; DISPATCH();
        OPCASE(DIV)      : topS1 = divValues(topS1,topS0);  sp--; DISPATCH();
        OPCASE(FDIV)     : topS1 = fdivValues(topS1,topS0); sp--; DISPATCH();
        OPCASE(MOD)      : topS1 = modValues(topS1,topS0);  sp--; DISPATCH();
        OPCASE(POW)      : topS1 = powValues(topS1,topS0);  sp--; DISPATCH();

        OPCASE(NEG)      : topS0 = mulValues(topS0,INTV1M); DISPATCH();

        OPCASE(NOT)      : topS0 = toB(!(B(topS0))); DISPATCH();
        OPCASE(AND)      : topS1 = toB(B(topS1) && B(topS0)); sp--; DISPATCH();
        OPCASE(OR)       : topS1 = toB(B(topS1) || B(topS0)); sp--; DISPATCH();
        OPCASE(XOR)      : topS1 = toB((B(topS1) || B(topS0)) && !(B(topS1) && B(topS0))); sp--; DISPATCH();

        OPCASE(SHL)      : topS1 = toI(I(topS1) << I(topS0)); sp--; DISPATCH();
        OPCASE(SHR)      : topS1 = toI(I(topS1) >> I(topS1)); sp--; DISPATCH();

        //---------------------------------------
        // comparisons & flow control
        //---------------------------------------

        OPCASE(CMPEQ)    : topS1 = toB(eqValues(topS1,topS0)); sp--; DISPATCH();
        OPCASE(CMPNE)    : topS1 = toB(neValues(topS1,topS0)); sp--; DISPATCH();
        OPCASE(CMPGT)    : topS1 = toB(gtValues(topS1,topS0)); sp--; DISPATCH();
        OPCASE(CMPGE)    : topS1 = toB(geValues(topS1,topS0)); sp--; DISPATCH();
        OPCASE(CMPLT)    : topS1 = toB(ltValues(topS1,topS0)); sp--; DISPATCH();
        OPCASE(CMPLE)    : topS1 = toB(leValues(topS1,topS0)); sp--; DISPATCH();

        OPCASE(JUMP)     : { 
            Dword addr = nextDword; 
            ip=addr; 
            DISPATCH(); 
        }
        OPCASE(JMPIFNOT) : {
            Dword addr = nextDword;
            if (!B(popS())) { 
                ip=addr; 
            } 
            DISPATCH();
        }
        OPCASE(RET)      : {
            freeFrame(); 
            ip = popF().ip; 
            DISPATCH();
        }

        OPCASE(EXEC)     : /* not implemented */ DISPATCH();

        OPCASE(END)      : goto exitLoop_;

        /***************************
          System Calls
         ***************************/

        OPCASE(DO_PRINT)        : printLnValue(popS()); DISPATCH();
        OPCASE(DO_INC)          : /* not implemented */ DISPATCH();
        OPCASE(DO_APPEND)       : /* not implemented */ DISPATCH();
        OPCASE(DO_LOG)          : /* not implemented */ DISPATCH();
        OPCASE(DO_GET)          : {
            Value index = popS();
            Value collection = popS();
            switch (Kind(collection)) {
                case AV: pushS(A(collection)->data[I(index)]); break;
                case DV: pushS(dGet(D(collection),S(index))); break;
                default: printLn("cannot get index for object\n");
            }
            DISPATCH();
        }
        OPCASE(GET_SIZE)        : sys_getSize(); DISPATCH();

        /***************************
          Empty slots
         ***************************/

        OPCASE(X01)      :
        OPCASE(X02)      :
        OPCASE(X03)      :
        OPCASE(X04)      :
        OPCASE(X05)      :
        OPCASE(X06)      :
        OPCASE(X07)      :
        OPCASE(X08)      :
        OPCASE(X09)      :
        OPCASE(X10)      :
        OPCASE(X11)      :
        OPCASE(X12)      : 
        OPCASE(X13)      : 
        OPCASE(X14)      : DISPATCH();

        // //=======================================
        // // Arithmetic & Logical Operations
        // //=======================================

        // OPCASE(ADD)      : topS1 = addValues(topS1,topS0);  sp--; DISPATCH();
        // OPCASE(SUB)      : topS1 = subValues(topS1,topS0);  sp--; DISPATCH();
        // OPCASE(MUL)      : topS1 = mulValues(topS1,topS0);  sp--; DISPATCH();
        // OPCASE(DIV)      : topS1 = divValues(topS1,topS0);  sp--; DISPATCH();
        // OPCASE(FDIV)     : topS1 = fdivValues(topS1,topS0); sp--; DISPATCH();
        // OPCASE(MOD)      : topS1 = modValues(topS1,topS0);  sp--; DISPATCH();
        // OPCASE(POW)      : topS1 = powValues(topS1,topS0);  sp--; DISPATCH();
        // OPCASE(NEG)      : topS0 = mulValues(topS0,INTV1M); DISPATCH();
        // OPCASE(NOT)      : topS0 = toB(!(B(topS0))); DISPATCH();
        // OPCASE(AND)      : topS1 = toB(B(topS1) && B(topS0)); sp--; DISPATCH();
        // OPCASE(OR)       : topS1 = toB(B(topS1) || B(topS0)); sp--; DISPATCH();
        // OPCASE(XOR)      : topS1 = toB((B(topS1) || B(topS0)) && !(B(topS1) && B(topS0))); sp--; DISPATCH();

        // //=======================================
        // // Control Flow
        // //=======================================

        // OPCASE(EXEC)     :
        // OPCASE(JUMP)     : { 
        //     Dword addr = nextDword; 
        //     ip=addr; 
        //     DISPATCH(); 
        // }
        // OPCASE(JMPIFNOT) : {
        //     Dword addr = nextDword;
        //     if (!B(popS())) { 
        //         ip=addr; 
        //     } 
        //     DISPATCH();
        // }
        // OPCASE(JMPIFE)   :
        // OPCASE(LOOPIF)   :

        // OPCASE(RETC)     : DISPATCH();
        // OPCASE(END)      : goto exitLoop_;

        // OPCASE(CMPEQ)    : topS1 = toB(eqValues(topS1,topS0)); sp--; DISPATCH();
        // OPCASE(CMPNE)    : topS1 = toB(neValues(topS1,topS0)); sp--; DISPATCH();
        // OPCASE(CMPGT)    : topS1 = toB(gtValues(topS1,topS0)); sp--; DISPATCH();
        // OPCASE(CMPGE)    : topS1 = toB(geValues(topS1,topS0)); sp--; DISPATCH();
        // OPCASE(CMPLT)    : topS1 = toB(ltValues(topS1,topS0)); sp--; DISPATCH();
        // OPCASE(CMPLE)    : topS1 = toB(leValues(topS1,topS0)); sp--; DISPATCH();



        // //=======================================
        // // Core Commands [96 slots]
        // //=======================================

        // OPCASE(DO_PRINT) : printLnValue(popS()); DISPATCH();
        
        // OPCASE(DO_APPEND): { 
        //     /*
        //     Word inPlace = nextWord; 
        //     if (inPlaceIsGlobal) {
        //         opAppend(&GlobalTable[inPlaceIndex],pop());
        //     }*/
        //     DISPATCH(); 
        // }
        // OPCASE(DO_INC)   : {
        //     /*
        //     Word inPlace = nextWord;
        //     if (inPlaceIsGlobal) {
        //         int index = inPlaceIndex;
        //         GlobalTable[index] = addValues(GlobalTable[index],INTV1);
        //     }
        //     */
        //     DISPATCH();
        // }

        // OPCASE(COPY)     : {
        //     /*
        //     printf("found value copy\n");
        //     Word nxt = nextWord;
        //     printf("from: %d -> ",nxt);
        //     nxt = nextWord;
        //     printf("to: %d\n",nxt);
        //     */
        //     DISPATCH();
        // }

        // OPCASE(DO_LOG)   : {
        //     /*
        //     Value popped = pop();
        //     printf("v: %llu = %s",popped,ss_to_c(stringify(popped)));
        //     if (Kind(popped)>=GV) {
        //         printf(" @ %p\n", (void*)(popped & UNMASK));
        //     }
        //     else {
        //         printf("\n");
        //     }*/
        //     DISPATCH();
        // }

        // OPCASE(GET_SIZE)     : {
        //     Value popped = popS();
        //     switch (Kind(popped)) {
        //         case SV: pushS(toI(sSize(S(popped)))); break;
        //         case AV: pushS(toI(aSize(A(popped)))); break;
        //         default: print("cannot get 'size' for value: ");
        //                  printLnValue(popped);
        //                  exit(1);
        //     }
        //     DISPATCH();
        // }

        // OPCASE(DO_GET)      : {
        //     Value index = popS();
        //     Value collection = popS();
        //     switch (Kind(collection)) {
        //         case AV: pushS(A(collection)->data[I(index)]); break;
        //         default: printLn("cannot get index for object\n");
        //     }
        //     DISPATCH();
        // }
    }

    exitLoop_:

    return "";
}

/**************************************
  Initialization & Finalizer
 **************************************/

static inline void vmInit() {
    ArrayStarts = aNew(int,0);
    DictArray = aNew(DictP,0);

    #ifdef PROFILE
        Prof = dNew(128);
    #endif
}

static inline void vmCleanUp() {
    aFree(ArrayStarts);
    aFree(DictArray);
    aFree(BCode);

    #ifdef PROFILE
        dFree(Prof);
    #endif
}

/**************************************
  Methods
 **************************************/

void vmCompileScript(char* script) {
    vmInit();

    if (generateBytecode(script)) {
        String* target = sNew(script);
        String* ext = sNew(".obj");
        sCat(target,ext);

        writeObjFile(target->content);

        sFree(target);
        sFree(ext);

        if (Env.debugBytecode) {
            inspectByteCode(BCode->data);
        }
    }

    vmCleanUp();
}

void vmRunObject(char* script) {
    vmInit();

    #ifdef PROFILE
        unsigned long long timer = getCurrentTime();
    #endif

    readObjFile(script);

    #ifdef PROFILE
        Prof_genTime = (float)(getCurrentTime()-timer)/1000000;
    #endif

    if (Env.debugBytecode) {
        inspectByteCode(BCode->data);
    }

    #ifdef PROFILE
        timer = getCurrentTime();
    #endif

    execute(BCode->data);

    #ifdef PROFILE
        Prof_execTime = (float)(getCurrentTime()-timer)/1000000;

        inspectProfiler();
    #endif

    vmCleanUp();
}

char* vmRunScript(char* script) {
    vmInit();

    #ifdef PROFILE
        unsigned long long timer = getCurrentTime();
    #endif
    
    if (generateBytecode(script)) {

        #ifdef PROFILE
            Prof_genTime = (float)(getCurrentTime()-timer)/1000000;
        #endif
    
        if (Env.debugBytecode) {
            inspectByteCode(BCode->data);
        }
        
        #ifdef PROFILE
            timer = getCurrentTime();
        #endif

        execute(BCode->data);

        #ifdef PROFILE
            Prof_execTime = (float)(getCurrentTime()-timer)/1000000;

            inspectProfiler();
        #endif
    }

    vmCleanUp();

    return "";
}