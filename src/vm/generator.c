/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/vm/generator.c
 *****************************************************************/

#include "arturo.h"

/**************************************
  Basic Helpers
 **************************************/

void emitOp(OPCODE op) {
	lastOp = op;
	writeByte(BCode, op);
}

void reemitOp(int pos, OPCODE op) {
	rewriteByte(BCode, pos, op);
}

void emitOpByte(OPCODE op, Byte b) {
	lastOp = op;
	writeByte(BCode, op);
	writeByte(BCode, b);
}

void emitOpWord(OPCODE op, Word w) {
	lastOp = op;
	writeByte(BCode, op);
	writeWord(BCode, w);
}

void emitOpDword(OPCODE op, Dword d) {
	lastOp = op;
	writeByte(BCode, op);
	writeDword(BCode, d);
}

void reemitDword(int pos, Dword d) {
	rewriteDword(BCode, pos, d);
}

void emitOpValue(OPCODE op, Value v) {
	lastOp = op;
	writeByte(BCode, op);
	writeValue(BCode, v);
}

/**************************************
  Pushes
 **************************************/

void doPushInt(Value v) {
	if (Kind(v)==IV && I(v)<=12) {
		emitOp((OPCODE)(CONST0 + I(v)));
	}
	else {
		emitOpWord(PUSH, storeValueData(v));
	}
}

/**************************************
  Data storage
 **************************************/

int storeValueData(Value v) {
	int ind;
	//printf("Storing value: %llu of type %s\n",v,getValueTypeStr(v));
	if (Kind(v)<GV) {
		aFind(BData, v, ind);
		if (ind!=-1) { return ind; }
		else {
			aAdd(BData, v);
			return BData->size-1;
		}
	}
	else if (Kind(v)==SV) {
		aEach(BData,i) {
			if ((Kind(BData->data[i])==SV) && 
				(!strcmp(S(BData->data[i])->content, S(v)->content))) { S(v)->refc++; return i; }
		}
		aAdd(BData, v);
		S(v)->refc++;
		return BData->size-1;
	}
	else if (Kind(v)==FV) {
		aEach(BData,i) {
			if ((Kind(BData->data[i])==FV) && 
				(F(BData->data[i])->ip==F(v)->ip)) { return i; }
		}
		aAdd(BData,v);
		return BData->size-1;
	}
	return -1;
}

/**************************************
  Loads, Stores & Calls
 **************************************/

void processCall(char* id) {
	if (weAreInBlock) {
		int ind;
		aFindCStr(LocalLookup, id, ind);
		if (ind!=-1) {
			if (ind<=14) { emitOp((OPCODE)(LCALL0 + ind)); }
			else 		 { emitOpWord(LCALL, ind); }
		}
		else {
			aFindCStr(GlobalLookup,id,ind);
			if (ind!=-1) {
				//printf("-- found in global scope\n");
				if (ind<=14) { emitOp((OPCODE)(GCALL0 + ind)); }
				else 		 { emitOpWord(GCALL, ind); }
			}
			else {
				// pretend it exists in global
				aAdd(GlobalLookup,id);
				ind = GlobalLookup->size-1;
				if (ind<=14) { emitOp((OPCODE)(GCALL0 + ind)); }
				else 		 { emitOpWord(GCALL, ind); }
			}
		}
	}
	else {
		int ind;
		aFindCStr(GlobalLookup, id, ind);
		if (ind!=-1) {
			if (ind<=14) { emitOp((OPCODE)(GCALL0 + ind)); }
			else 		 { emitOpWord(GCALL, ind); }
		}
		else {
			printf("!! Symbol not found: %s\n",id);
			exit(1);
		}
	}
}

void processLoad(char* id) {
	if (weAreInBlock) {
		int ind;
		aFindCStr(LocalLookup, id, ind);
		if (ind!=-1) {
			if (ind<=14) { emitOp((OPCODE)(LLOAD0 + ind)); }
			else 		 { emitOpWord(LLOAD, ind); }
		}
		else {
			aFindCStr(GlobalLookup,id,ind);
			if (ind!=-1) {
				//printf("-- found in global scope\n");
				if (ind<=14) { emitOp((OPCODE)(GLOAD0 + ind)); }
				else 		 { emitOpWord(GLOAD, ind); }
			}
			else {
				printf("Symbol not found: %s\n",id);
				exit(1);
			}
		}
	}
	else {
		int ind;
		aFindCStr(GlobalLookup, id, ind);
		if (ind!=-1) {
			if (ind<=14) { emitOp((OPCODE)(GLOAD0 + ind)); }
			else 		 { emitOpWord(GLOAD, ind); }
		}
		else {
			printf("!! Symbol not found: %s\n",id);
			exit(1);
		}
	}
}

void processStore(char* id) {
	//printf("trying to see where to store: %s\n",id);
	// if ((lastOp>=GLOAD0) && (lastOp<=GLOAD15)) {
	// 	if (weAreInFunc) {

	// 	}
	// 	else {
	// 		if (weAreInDict) {

	// 		}
	// 		else {
	// 			int ind = findStringInBuffer(GlobalLookup, id);
	// 			if (ind!=-1) {
	// 				rewriteByte(BCode,COPY);
	// 				writeWord(BCode,(Word)(GLOAD15-lastOp-0xF));
	// 				writeWord(BCode,(Word)ind);
	// 				lastOp = COPY;
	// 				// rewriteByte(lastOp);
	// 				// writeWord(BCode,(Word)(GLOAD15-lastOp));
	// 				// writeWord(BCode,(Word)ind);
	// 				// if (ind<=15) { emitOp((OPCODE)(GSTORE0 + ind)); }
	// 				// else 		 { emitOpWord(GSTORE, ind); }
	// 			}
	// 			else {
	// 				writeStringToBuffer(GlobalLookup,id);
	// 				ind = findStringInBuffer(GlobalLookup, id);
	// 				rewriteByte(BCode,COPY);
	// 				writeWord(BCode,(Word)(GLOAD15-lastOp-0xF));
	// 				writeWord(BCode,(Word)ind);
	// 				lastOp = COPY;
	// 				// if (ind<=15) { emitOp((OPCODE)(GSTORE0 + ind)); }
	// 				// else 		 { emitOpWord(GSTORE, ind); }
	// 			}
	// 		}
	// 	}
	// }
	// else {
		if (weAreInBlock) {
			//printf("-- we are in a block\n");
			if (weAreInDict) {

			}
			else {
				int ind;
				aFindCStr(LocalLookup,id,ind);
				if (ind!=-1) {
					//printf("-- found in local scope\n");
					if (ind<=14) { emitOp((OPCODE)(LSTORE0 + ind)); }
					else   		 { emitOpWord(LSTORE, ind); }
				}
				else {
					//printf("-- NOT found in local scope\n");
					aFindCStr(GlobalLookup,id,ind);
					if (ind!=-1) {
						//printf("-- found in global scope\n");
						if (ind<=14) { emitOp((OPCODE)(GSTORE0 + ind)); }
						else 		 { emitOpWord(GSTORE, ind); }
					}
					else {
						//printf("-- NOT found anywhere, adding to local scope\n");
						aAdd(LocalLookup,id);
						ind = LocalLookup->size-1;
						if (ind<=14) { emitOp((OPCODE)(LSTORE0 + ind)); }
						else   		 { emitOpWord(LSTORE, ind); }
					}
				}
			}
        // if weAreInDict>0:
        //     emitOpValue(DSTORE,toS($s))
        // else:
        //     var ind = localLookup.find(s)
        //     if ind != -1:
        //         if ind<=15: emitOp(constOp(LSTORE0))
        //         else: emitOpWord(LSTORE,ind)
        //     else:
        //         ind = globalLookup.find(s)
        //         if ind != -1:
        //             if ind<=15: emitOp(constOp(GSTORE0))
        //             else: emitOpWord(GSTORE,ind)
        //         else:
        //             localLookup.add(s)
        //             ind = localLookup.find(s)
        //             if ind<=15: emitOp(constOp(LSTORE0))
        //             else: emitOpWord(LSTORE,ind)
		}
		else {
			//printf("-- we are NOT in a block\n");
			if (weAreInDict) {

			}
			else {
				int ind;
				aFindCStr(GlobalLookup,id,ind);
				if (ind!=-1) {
					//printf("-- found in global scope\n");
					if (ind<=14) { emitOp((OPCODE)(GSTORE0 + ind)); }
					else 		 { emitOpWord(GSTORE, ind); }
				}
				else {
					//printf("-- NOT found in global scope, add it\n");
					aAdd(GlobalLookup,id);
					ind = GlobalLookup->size-1;
					if (ind<=14) { emitOp((OPCODE)(GSTORE0 + ind)); }
					else 		 { emitOpWord(GSTORE, ind); }
				}
			}
		}
	// }
}

void processInPlace(OPCODE op, char* id) {
	if (weAreInBlock) {

	}
	else {
		if (weAreInDict) {

		}
		else {
			int ind;
			aFindCStr(GlobalLookup,id,ind);
			if (ind!=-1) {
				emitOpWord(op, (0x8000|(Word)ind));
			}
			else {
				aAdd(GlobalLookup,id);
				ind = GlobalLookup->size-1;
				emitOpWord(op, (0x8000|(Word)ind));
			}
		}
	}
}

/**************************************
  Arrays
 **************************************/

void signalGotInArray() {
	emitOp(NEWARR);
}

void signalFoundArray() {
	emitOp(PUSHA);
}

/**************************************
  Dictionaries
 **************************************/

void signalGotInDictionary() {
	emitOp(NEWDIC);
}

void signalFoundDictionary() {
	emitOp(PUSHD);
}

/**************************************
  Blocks
 **************************************/

void signalFoundIf() {
	inIf = true;
	ifsFound+=2;
}

void finalizeIf() {
	int target = aPop(IfStarts);
	Dword addr = readDword(BCode, target+1);
	reemitOp(target, JMPIFNOT);
	if (BCode->data[addr]==JUMP) {
		reemitDword(target+1, addr+5);
	}
}

void signalGotInBlock() {
	//printf("got in block! @ %d\n",BCode->size);
	if (inIf) {
		aAdd(IfStarts,BCode->size);
	}
	aAdd(BlockStarts, BCode->size);
	//printf("pushing to lookup stack\n");
	//printf("LocalLookup->size before: %zu\n",LocalLookup->size);

	//if (ifsFound%2==0) {
	//	printf("ifsFound%2==0 : emit JUMP\n");
		emitOpDword(JUMP,0);
	//}
}

void signalGotOutOfBlock() {
	inIf = false;
	//emitOp(RET);
	//printf("got out of block @ %d\n",BCode->size);
	int pos = aPop(BlockStarts)+1; 				// move pointer to Dword after JUMP (1 byte)
	  	// fix JMP param to point to current pointer
	reemitDword(pos,BCode->size);
	/*if (ifsFound>0) {
		if (ifsFound%2==0) {
			printf("converting JUMP to JMPIFNOT\n");
			
			reemitOp(pos-1, JMPIFNOT);
			reemitDword(pos,BCode->size + 5);
		}
		ifsFound--;
		printf("decreased ifsFound :: %d\n", ifsFound);
	}	*/		
	//Func* f = fNew(pos+4,0);
	//printf("created new func: %p :: ip: %d, args: %d\n",f,f->ip,f->args);
	//emitOpValue(PUSH,toF(f));	   	// move pointer to next instruction (Dword = 4 bytes)
}

void signalGotInFunction() {

	if (LocalLookupStack->size > 0) {
		aAdd(LocalLookupStack, LocalLookup->size);
	}
	else {
		aAdd(LocalLookupStack,0);
		// aAdd(LocalLookups, aNew(CString, 0));
	}
	weAreInBlock = true;
	argCounter = 0;
}

void signalFoundFunction() {
	LocalLookup->size = aPop(LocalLookupStack);
	if (LocalLookupStack->size==0) {
		weAreInBlock = false;
	}
	emitOp(RET);
	int pos = BlockStarts->data[BlockStarts->size] + 1;
	reemitDword(pos,BCode->size);
	Func* f = fNew(pos+4,argCounter);
	//printf("created new func: %p :: ip: %d, args: %d\n",f,f->ip,f->args);
	emitOpWord(PUSH,storeValueData(toF(f)));	   	// move pointer to next instruction (Dword = 4 bytes)
	argCounter = 0;
}

/**************************************
  Initialization & Finalization
 **************************************/

inline void generatorSetup() {
	BCode 			= aNew(Byte, INITIAL_BCODE_SIZE);
	BData 			= aNew(Value, INITIAL_BDATA_SIZE);

	GlobalLookup 		= aNew(CString, 0);
	LocalLookup 		= aNew(CString, 0);
	LocalLookupStack	= aNew(int, 0);

	BlockStarts 	= aNew(int,0);
	IfStarts 		= aNew(int,0);

	ifsFound 		= 0;
	inIf 			= false;

	argCounter 		= 0;

	weAreInBlock 	= false;
	weAreInDict 	= false;
}

inline void generatorFinalize() {
	aFree(GlobalLookup);
	aFree(LocalLookupStack);
	aFree(LocalLookup);

	aFree(BlockStarts);
	aFree(IfStarts);
}

inline bool generateBytecode(const char* script) {
	generatorSetup();
	
	yyin = fopen(script, "r");
	bool result = !yyparse();

	if (Env.optimize) {
		optimizeBytecode();
	}

	generatorFinalize();

	return result;
}