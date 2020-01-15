/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/vm/vm.c
 *****************************************************************/

#include "../arturo.h"

/**************************************
  Debugging helpers
 **************************************/

#ifdef DEBUG

	void inspectByteCode() {
		debugHeader("Data Segment");
		aEach(BData, i) {
			String* vStr = stringify(BData->data[i]);
			printf("%-4d: [%-6s]= %.*s\n",i,getValueTypeStr(BData->data[i]),vStr->size, vStr->content);
		}
		debugFooter("Data Segment");
		printf("\n");

		///

		debugHeader("Bytecode Listing");

		int IP = 0;
		int cmd = -1;

		while (true) {
			cmd++;
			printf("%-4d\e[2m:%-8d\e[0;37m",cmd,IP);
			OPCODE op = readByte(BCode,IP++);
			printf("%s",OpCodeStr[op]);

			switch(op) {
				case DSTORE:{
					Value vv = readValue(BCode,IP);
					String* vvStr = stringify(vv);
					printf(" [Value] (%s) -> %.*s\n", getValueTypeStr(vv), vvStr->size, vvStr->content);
					IP+=8;
					break;
				}
				case JUMP:
				case JMPIFNOT:
					printf(" [Dword] %d\n", readDword(BCode,IP));
					IP+=4;
					break;
				case COPY: {
					Word first = readWord(BCode,IP); IP+=2;
					Word second = readWord(BCode,IP); IP+=2;
					printf(" [Word] %d -> [Word] %d\n", first, second);
					break;
				}
				case PUSH:
				case GLOAD:
				case LLOAD:
				case GSTORE:
				case LSTORE:
				case GCALL:
				case LCALL:
				case DO_APPEND:
					printf(" [Word] %d\n", readWord(BCode,IP));
					IP+=2;
					break;
				case END:
					printf("\n");
					goto exitProfileLoop_;
				default:
					printf("\n");
			}
		}

		exitProfileLoop_:

		printf("\n");
		debugFooter("Bytecode Listing");
	}

#endif

/**************************************
  The main interpreter loop
 **************************************/

char* execute() {	
	//-------------------------
	// Our registers
	//-------------------------

	register int sp = -1;
	register int fp = -1;
	register int ip = 0;

	//-------------------------
	// The Global Table
	//-------------------------

	Value GlobalTable[GLOBAL_SIZE];

	#define storeGlobal(X) { \
		int k = Kind(GlobalTable[X]);									\
		Value popped = popS();											\
		if (k==SV) { S(popped)->refc++; sFree(S(GlobalTable[X])); }		\
		else if (k==AV) { aFree(A(GlobalTable[X])); }					\
		else if (k==GV) { mpz_clear((mpz_ptr)G(GlobalTable[X])); }		\
		GlobalTable[X] = popped;										\
	}	

	#define callGlobal(X) { \
		Func* f = F(GlobalTable[X]);									\
		CallFrame fr = { 												\
			.ip = ip 													\
		};																\
		Byte z = f->args;												\
		for (int i=0; i<z; i++) {										\
			fr.Locals[i] = Stack[sp-(z-i-1)];							\
		}																\
		pushF(fr);														\
		ip = f->ip;														\
	}	

	//-------------------------
	// The Local Table
	//-------------------------							

	#define storeLocal(X) { \
		topF0.Locals[X] = popS();										\
	}

	#define freeFrame() { \
		for (int i=0; i<fp; i++) {											\
			int k = Kind(topF0.Locals[i]);									\
			if (k==SV) { sFree(S(topF0.Locals[i])); }						\
			else if (k==AV) { aFree(A(topF0.Locals[i])); }					\
			else if (k==GV) { mpz_clear((mpz_ptr)G(topF0.Locals[i])); }		\
		}																	\
	}

	//-------------------------
	// Stack handling
	//-------------------------

	Value Stack[STACK_SIZE];

	#define pushS(X)	Stack[sp+1] = X; sp++
	#define popS()		Stack[sp--]
	#define topS0		Stack[sp]
	#define topS1		Stack[sp-1]
	#define topS2		Stack[sp-2]

	CallFrame FrameStack[FRAMESTACK_SIZE];

	#define pushF(X)	FrameStack[fp+1] = X; fp++
	#define popF()		FrameStack[fp--]
	#define topF0		FrameStack[fp]
	#define topF1		FrameStack[fp-1]
	#define topF2	 	FrameStack[fp-2]

	//-------------------------
	// Instruction handling
	//-------------------------

	OPCODE op;

	#define nextOp		readByte(BCode,ip++)
	#define nextByte 	readByte(BCode,ip++)
	#define nextWord    readWord(BCode,ip);  ip+=2;
	#define nextDword 	readDword(BCode,ip); ip+=4;
	#define nextValue	readValue(BCode,ip); ip+=8;

	//-------------------------
	// Computed Goto
	//-------------------------

	#ifdef COMPUTED_GOTO

		static void* dispatchTable[] = {
			OPCODES(GENERATE_OP_DISPATCH)
		}; 

		#define INTERPRETER_LOOP		DISPATCH();

		#define OPCASE(name)			case_##name

		#if defined(PROFILE) || defined(DEBUG)
			#define DISPATCH()											\
				op = nextOp;											\
				printf("exec: %s\n",OpCodeStr[op]); 					\
				goto *dispatchTable[op];
		#else	
			#define DISPATCH()		goto *dispatchTable[op = nextOp]
		#endif
	#else
		#ifdef PROFILE
			#define INTERPRETER_LOOP 									\
				startLoop_: 											\
					op = nextOp; 										\
					printf("exec: %s\n",OpCodeStr[op]); 				\
					switch(op)
		#else
			#define INTERPRETER_LOOP	 								\
				startLoop_:												\
					switch(op = nextOp) 			
		#endif

		#define OPCASE(name) 	case name
		#define DISPATCH()	 	goto startLoop_
	#endif

	//-------------------------
	// The main loop
	//-------------------------

	INTERPRETER_LOOP {

		//=======================================
        // Aliases
        //=======================================

        //------------------------
        // Constants
        //------------------------
		OPCASE(CONST0)	: pushS(INTV0); 	DISPATCH();
		OPCASE(CONST1) 	: pushS(INTV1); 	DISPATCH();
		OPCASE(CONST2) 	: pushS(INTV2); 	DISPATCH();
		OPCASE(CONST3) 	: pushS(INTV3); 	DISPATCH();
		OPCASE(CONST4) 	: pushS(INTV4); 	DISPATCH();
		OPCASE(CONST5) 	: pushS(INTV5); 	DISPATCH();
		OPCASE(CONST6) 	: pushS(INTV6); 	DISPATCH();
		OPCASE(CONST7) 	: pushS(INTV7); 	DISPATCH();
		OPCASE(CONST8) 	: pushS(INTV8); 	DISPATCH();
		OPCASE(CONST9) 	: pushS(INTV9); 	DISPATCH();
		OPCASE(CONST10) : pushS(INTV10); 	DISPATCH();
		OPCASE(CONST11) : pushS(INTV11); 	DISPATCH();
		OPCASE(CONST12) : pushS(INTV12); 	DISPATCH();
		
		OPCASE(CONSTT)  : pushS(TRUEV); 	DISPATCH();
		OPCASE(CONSTF)	: pushS(FALSEV); 	DISPATCH();
		OPCASE(CONSTN)	: pushS(NULLV); 	DISPATCH();

		//------------------------
        // Global Loads
        //------------------------
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
        OPCASE(GLOAD10)  : pushS(GlobalTable[10]); DISPATCH();
        OPCASE(GLOAD11)  : pushS(GlobalTable[11]); DISPATCH();
        OPCASE(GLOAD12)  : pushS(GlobalTable[12]); DISPATCH();
        OPCASE(GLOAD13)  : pushS(GlobalTable[13]); DISPATCH();
        OPCASE(GLOAD14)  : pushS(GlobalTable[14]); DISPATCH();
        
        OPCASE(GLOAD)	 : { 
        	Word ind = nextWord;
        	pushS(GlobalTable[ind]); 
        	DISPATCH();
        }

        //------------------------
        // Local Loads
        //------------------------
        OPCASE(LLOAD0)   : pushS(topF0.Locals[0]);  DISPATCH();
        OPCASE(LLOAD1)   : pushS(topF0.Locals[1]);  DISPATCH();
        OPCASE(LLOAD2)   : pushS(topF0.Locals[2]);  DISPATCH();
        OPCASE(LLOAD3)   : pushS(topF0.Locals[3]);  DISPATCH();
        OPCASE(LLOAD4)   : pushS(topF0.Locals[4]);  DISPATCH();
        OPCASE(LLOAD5)   : pushS(topF0.Locals[5]);  DISPATCH();
        OPCASE(LLOAD6)   : pushS(topF0.Locals[6]);  DISPATCH();
        OPCASE(LLOAD7)   : pushS(topF0.Locals[7]);  DISPATCH();
        OPCASE(LLOAD8)   : pushS(topF0.Locals[8]);  DISPATCH();
        OPCASE(LLOAD9)   : pushS(topF0.Locals[9]);  DISPATCH();
        OPCASE(LLOAD10)  : pushS(topF0.Locals[10]); DISPATCH();
        OPCASE(LLOAD11)  : pushS(topF0.Locals[11]); DISPATCH();
        OPCASE(LLOAD12)  : pushS(topF0.Locals[12]); DISPATCH();
        OPCASE(LLOAD13)  : pushS(topF0.Locals[13]); DISPATCH();
        OPCASE(LLOAD14)  : pushS(topF0.Locals[14]); DISPATCH();

        OPCASE(LLOAD)	 : { 
        	Word ind = nextWord;
        	pushS(topF0.Locals[ind]); 
        	DISPATCH();
        }

        //------------------------
        // Global Stores
        //------------------------
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
        OPCASE(GSTORE10) : storeGlobal(10); DISPATCH();
        OPCASE(GSTORE11) : storeGlobal(11); DISPATCH();
        OPCASE(GSTORE12) : storeGlobal(12); DISPATCH();
        OPCASE(GSTORE13) : storeGlobal(13); DISPATCH();
        OPCASE(GSTORE14) : storeGlobal(14); DISPATCH();

        OPCASE(GSTORE) 	 : {
        	Word ind = nextWord;
        	storeGlobal(ind); 
        	DISPATCH();
        }

        //------------------------
        // Local Stores
        //------------------------
        OPCASE(LSTORE0)  : storeLocal(0);  DISPATCH();
        OPCASE(LSTORE1)  : storeLocal(1);  DISPATCH();
        OPCASE(LSTORE2)  : storeLocal(2);  DISPATCH();
        OPCASE(LSTORE3)  : storeLocal(3);  DISPATCH();
        OPCASE(LSTORE4)  : storeLocal(4);  DISPATCH();
        OPCASE(LSTORE5)  : storeLocal(5);  DISPATCH();
        OPCASE(LSTORE6)  : storeLocal(6);  DISPATCH();
        OPCASE(LSTORE7)  : storeLocal(7);  DISPATCH();
        OPCASE(LSTORE8)  : storeLocal(8);  DISPATCH();
        OPCASE(LSTORE9)  : storeLocal(9);  DISPATCH();
        OPCASE(LSTORE10) : storeLocal(10); DISPATCH();
        OPCASE(LSTORE11) : storeLocal(11); DISPATCH();
        OPCASE(LSTORE12) : storeLocal(12); DISPATCH();
        OPCASE(LSTORE13) : storeLocal(13); DISPATCH();
        OPCASE(LSTORE14) : storeLocal(14); DISPATCH();

        OPCASE(LSTORE) 	 : {
        	Word ind = nextWord;
        	storeLocal(ind); 
        	DISPATCH();
        }

        //------------------------
        // Global Calls
        //------------------------
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
        OPCASE(GCALL10)  : callGlobal(10); DISPATCH();
        OPCASE(GCALL11)  : callGlobal(11); DISPATCH();
        OPCASE(GCALL12)  : callGlobal(12); DISPATCH();
        OPCASE(GCALL13)  : callGlobal(13); DISPATCH();
        OPCASE(GCALL14)  : callGlobal(14); DISPATCH();

        OPCASE(GCALL) 	 : {
        	Word ind = nextWord;
        	callGlobal(ind); 
        	DISPATCH();
        }

        //------------------------
        // Local Calls
        //------------------------
        OPCASE(LCALL0)   : 
        OPCASE(LCALL1)   : 
        OPCASE(LCALL2)   : 
        OPCASE(LCALL3)   : 
        OPCASE(LCALL4)   : 
        OPCASE(LCALL5)   : 
        OPCASE(LCALL6)   : 
        OPCASE(LCALL7)   : 
        OPCASE(LCALL8)   : 
        OPCASE(LCALL9)   : 
        OPCASE(LCALL10)  : 
        OPCASE(LCALL11)  : 
        OPCASE(LCALL12)  : 
        OPCASE(LCALL13)  : 
        OPCASE(LCALL14)  : 

        OPCASE(LCALL)  	 : DISPATCH();

        //=======================================
        // Generics
        //=======================================

        OPCASE(PUSH) 	 : { Word wrd = nextWord; pushS(BData->data[wrd]); DISPATCH(); }
		OPCASE(PUSHA)	 : {
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
		OPCASE(PUSHD) 	 : DISPATCH();
		OPCASE(POP)  	 : sp--; DISPATCH();

		OPCASE(DUP) 	 : pushS(topS0); DISPATCH();
		OPCASE(SWAP) 	 : {
			Value tmp = topS0;
			topS0 = topS1;
			topS1 = tmp;
			DISPATCH();
		}

		OPCASE(DSTORE)   : DISPATCH();

		OPCASE(NEWARR) 	 : {
			aAdd(ArrayStarts, sp+1);
			DISPATCH();
		}
		OPCASE(NEWDIC) 	 : DISPATCH();

		OPCASE(NOP) 	 : DISPATCH();

		//=======================================
        // Arithmetic & Logical Operations
        //=======================================

		OPCASE(ADD) 	 : topS1 = addValues(topS1,topS0);  sp--; DISPATCH();
		OPCASE(SUB) 	 : topS1 = subValues(topS1,topS0);  sp--; DISPATCH();
		OPCASE(MUL) 	 : topS1 = mulValues(topS1,topS0);  sp--; DISPATCH();
		OPCASE(DIV) 	 : topS1 = divValues(topS1,topS0);  sp--; DISPATCH();
		OPCASE(FDIV) 	 : topS1 = fdivValues(topS1,topS0); sp--; DISPATCH();
		OPCASE(MOD) 	 : topS1 = modValues(topS1,topS0);  sp--; DISPATCH();
		OPCASE(POW) 	 : topS1 = powValues(topS1,topS0);  sp--; DISPATCH();
		OPCASE(NEG)		 : topS0 = mulValues(topS0,INTV1M); DISPATCH();
		OPCASE(NOT) 	 : topS0 = toB(!(B(topS0))); DISPATCH();
		OPCASE(AND)	     : topS1 = toB(B(topS1) && B(topS0)); sp--; DISPATCH();
		OPCASE(OR)	     : topS1 = toB(B(topS1) || B(topS0)); sp--; DISPATCH();
		OPCASE(XOR) 	 : topS1 = toB((B(topS1) || B(topS0)) && !(B(topS1) && B(topS0))); sp--; DISPATCH();

		//=======================================
        // Control Flow
        //=======================================

		OPCASE(EXEC) 	 :
		OPCASE(JUMP) 	 : { 
			Dword addr = nextDword; 
			printf("jumping to: %d\n",addr); 
			ip=addr; 
			DISPATCH(); }
		OPCASE(JMPIFNOT) : {
			if (!B(popS())) { 
				Dword addr = nextDword; printf("jumping to %d\n",addr); 
				ip=addr; 
			} 
			DISPATCH();
		}
		OPCASE(JMPIFE)   :
		OPCASE(LOOPIF) 	 :
		OPCASE(RET) 	 : {
			freeFrame(); 
			ip = popF().ip; 
			DISPATCH();
		}
		OPCASE(RETC) 	 : DISPATCH();
		OPCASE(END)      : goto exitLoop_;

		OPCASE(CMPEQ)	 : topS1 = toB(eqValues(topS1,topS0)); sp--; DISPATCH();
		OPCASE(CMPNE) 	 : topS1 = toB(neValues(topS1,topS0)); sp--; DISPATCH();
		OPCASE(CMPGT) 	 : topS1 = toB(gtValues(topS1,topS0)); sp--; DISPATCH();
		OPCASE(CMPGE) 	 : topS1 = toB(geValues(topS1,topS0)); sp--; DISPATCH();
		OPCASE(CMPLT) 	 : topS1 = toB(ltValues(topS1,topS0)); sp--; DISPATCH();
		OPCASE(CMPLE) 	 : topS1 = toB(leValues(topS1,topS0)); sp--; DISPATCH();

		//=======================================
        // Empty Slots
        //=======================================

		OPCASE(X01) 	 :
		OPCASE(X02) 	 :
		OPCASE(X03) 	 :
		OPCASE(X04)      :
		OPCASE(X05)      :
		OPCASE(X06)      :
		OPCASE(X07)      :
		OPCASE(X08) 	 :
		OPCASE(X09) 	 :
		OPCASE(X10) 	 :
		OPCASE(X11) 	 :
		OPCASE(X12) 	 : DISPATCH();

		//=======================================
        // Core Commands [96 slots]
        //=======================================

		OPCASE(DO_PRINT) : printLnValue(popS()); DISPATCH();
		
		OPCASE(DO_APPEND): { 
			/*
			Word inPlace = nextWord; 
			if (inPlaceIsGlobal) {
				opAppend(&GlobalTable[inPlaceIndex],pop());
			}*/
			DISPATCH(); 
		}
		OPCASE(DO_INC)	 : {
			/*
			Word inPlace = nextWord;
			if (inPlaceIsGlobal) {
				int index = inPlaceIndex;
				GlobalTable[index] = addValues(GlobalTable[index],INTV1);
			}
			*/
			DISPATCH();
		}

		OPCASE(COPY)     : {
			/*
			printf("found value copy\n");
			Word nxt = nextWord;
			printf("from: %d -> ",nxt);
			nxt = nextWord;
			printf("to: %d\n",nxt);
			*/
			DISPATCH();
		}

		OPCASE(DO_LOG)	 : {
			/*
			Value popped = pop();
			printf("v: %llu = %s",popped,ss_to_c(stringify(popped)));
			if (Kind(popped)>=GV) {
				printf(" @ %p\n", (void*)(popped & UNMASK));
			}
			else {
				printf("\n");
			}*/
			DISPATCH();
		}

		OPCASE(GET_SIZE)	 : {
			Value popped = popS();
			switch (Kind(popped)) {
				case SV: pushS(toI(sSize(S(popped)))); break;
				case AV: pushS(toI(aSize(A(popped)))); break;
				default: print("cannot get 'size' for value: ");
						 printLnValue(popped);
						 exit(1);
			}
			DISPATCH();
		}

		OPCASE(DO_GET) 		: {
			Value index = popS();
			Value collection = popS();
			switch (Kind(collection)) {
				case AV: pushS(A(collection)->data[I(index)]); break;
				default: printLn("cannot get index for object\n");
			}
			DISPATCH();
		}
 	}

	exitLoop_:

	return "";
}

/**************************************
  Initialization & Finalizer
 **************************************/

static inline void vmInit() {
	ArrayStarts = aNew(int,0);
}

static inline void vmCleanUp() {
	aFree(ArrayStarts);
	aFree(BCode);
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

		#ifdef DEBUG
			inspectByteCode();
		#endif
	}

	vmCleanUp();
}

void vmRunObject(char* script) {
	vmInit();

	readObjFile(script);

	#ifdef DEBUG
		inspectByteCode();
	#endif

	execute();

	vmCleanUp();
}

char* vmRunScript(char* script) {
	vmInit();
	
	if (generateBytecode(script)) {
	
		#ifdef DEBUG
			inspectByteCode();
		#endif
		
		execute();

	}

	vmCleanUp();

	return "";
}