/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/vm/value.c
 *****************************************************************/

#include "arturo.h"

/**************************************
  Converters
 **************************************/

Float32 R(Value v) {
	union {
		float fl[2];
		Value va;
	} cast;
	cast.va = (Value)(v & UNMASK);
	
	return cast.fl[0];
}

Value toR(Float32 f) {
	uint32_t t;
	memcpy(&t, &f, sizeof(t));
	Value val = t;

	return (val | MASK(RV));
}

Value strToIntValue(char* str) {
	int ret;

	if (stoi32(&ret,str)) return toI((Int32)ret);
	else return strToBigintValue(str);
}

Value strToBigintValue(char* str) {
	return toG(bNewFromCString(str));
}
 
Value strToRealValue(char* str) {
	char* end;
	float ret = strtof(str, &end);
	return toR((Float32)ret);
}

Value strToStringValue(char* str) {
	String* newStr = sNew(str);
	return toS(newStr);
}

bool vaContains(ValueArray* va, Value v) {   
	aEach(va,i) {
		if (eqValues(va->data[i],v)) return true;
	}         
	return false;
}

/**************************************
  Arithmetic operations
 **************************************/

Value addValues(Value l, Value r) {
	switch (Kind(l)) {
		case IV: 
			switch (Kind(r)) {
				case IV: {
					Int32 res;
                    if (addWillOverflow(I(l),I(r),&res)) {
                    	Bignum* ret = bNewFromI(I(l));
                    	bAddI(ret,I(r));
    					return toG(ret);
                    }
                    else {
                    	return toI(res);
                    }
                }
                case GV: {
                	Bignum* ret = bDup(G(r));
                	bAddI(ret,I(l));
                	return toG(ret);
                }
                case RV: {
                	return toR(I(l)+R(r));
                }
                case SV: {
                	String* left = stringify(l);
                	String* right = sDup(S(r));
                	sCat(left,right);
                	sFree(right);
                	return toS(left);
                }
				default: printf("%s/%s\n",getValueTypeStr(l),getValueTypeStr(r)); invalidOperationError('+');
			}
		case GV:
			switch (Kind(r)) {
				case IV: {
					Bignum* ret = bDup(G(l));
					bAddI(ret,I(r));
					return toG(ret);
				}
				case GV: {
					Bignum* ret = bDup(G(l));
					bAdd(ret,G(r));
					return toG(ret);
				}
				default: invalidOperationError('+');
			}
		case RV: {
			switch (Kind(r)) {
				case IV: {
					return toR(R(l)+I(r));
				}
				case RV: {
					return toR(R(l)+R(r));
				}
				default: invalidOperationError('+');
			}
		}
		case SV: {
			String* left = sDup(S(l));
			if (Kind(r)==SV) {
				sCat(left,S(r));
				return toS(left);
			}
			else {
				String* right = stringify(r);
				sCat(left,right);
				sFree(right);
				return toS(left);
			}
		}
		case AV: {
			ValueArray* left = A(l);
			ValueArray* ret = aDup(Value, left);
			if (Kind(r)==AV) {
				ValueArray* right = A(r);
				aEach(right,i) {
					aAdd(ret, right->data[i]);
				}
			} 
			else {
				aAdd(ret, r);
			}
			return toA(ret);
		}
		default: printf("error: values cannot be added\n");
	}
	return NULLV;
}

Value subValues(Value l, Value r) {
	switch (Kind(l)) {
		case IV:
			switch (Kind(r)) {
				case IV: {
					Int32 res;
                    if (subWillOverflow(I(l),I(r),&res)) {
                    	Bignum* ret = bNewFromI(I(l));
                    	bSubI(ret,I(r));
    					return toG(ret);
                    }
                    else {
                    	return toI(res);
                    }
                }
                case GV: {
                	Bignum* ret = bNewFromI(I(l));
                	bSub(ret,G(r));
                	return toG(ret);
                }
                case RV: {
                	return toR(I(l)-R(r));
                }
				default: printf("error: values cannot be subtracted\n");
			}
		case GV:
			switch (Kind(r)) {
				case IV: {
					Bignum* ret = bDup(G(l));
					bSubI(ret,I(r));
					return toG(ret);
				}
				case GV: {
					Bignum* ret = bDup(G(l));
					bSub(ret,G(r));
					return toG(ret);
				}
				default: printf("error: values cannot be subtracted");
			}
		case RV: 
			switch (Kind(r)) {
				case IV: {
					return toR(R(l)-I(r));
				}
				case RV: {
					return toR(R(l)-R(r));
				}
				default: printf("errror: values cannot be subtracted");
			}
		default: printf("error: values cannot be subtracted\n");
	}
	return NULLV;
}

Value mulValues(Value l, Value r) {
	Int32 res;
	switch (Kind(l)) {
		case IV:
			switch (Kind(r)) {
				case IV: 
					if (mulWillOverflow(I(l),I(r),&res)) {
						Bignum* ret = bNewFromI(I(l));
						bMulI(ret,I(r));
    					return toG(ret);
                    }
                    else {
                    	return toI(res);
                    }
                case GV: {
                	Bignum* ret = bNewFromI(I(l));
                	bMul(ret,G(r));
					return toG(ret);
                }
                case RV: {
                	return toR(I(l)*R(r));
                }
				default: printf("error: values cannot be multiplicated\n");
			}
		case GV:
			switch (Kind(r)) {
				case IV: {
					Bignum* ret = bDup(G(l));
					bMulI(ret,I(r));
					return toG(ret);
				}
				case GV: {
					Bignum* ret = bDup(G(l));
					bMul(ret,G(r));
					return toG(ret);
				}
				default: printf("error: values cannot be multiplicated\n");
			}
		default: printf("error: values cannot be multiplicated\n");
	}
	return NULLV;
}

Value divValues(Value l, Value r) {
	Int32 res;
	switch (Kind(l)) {
		case IV:
			switch (Kind(r)) {
				case IV: 
					return toI((Int32)(I(l)/I(r)));
				default: printf("error: values cannot be divided\n");
			}
		case GV:
			switch (Kind(r)) {
				case IV: {
					Bignum* ret = bDup(G(l));
					bDivI(ret,I(r));
					return toG(ret);
				}
				case GV: {
					Bignum* ret = bDup(G(l));
					bDiv(ret,G(r));
					return toG(ret);
				}
				default: printf("error: values cannot be divided\n");
			}
		default: printf("error: values cannot be divided\n");
	}
	return NULLV;
}

Value fdivValues(Value l, Value r) {
	Int32 res;
	switch (Kind(l)) {
		case IV:
			switch (Kind(r)) {
				case IV: {
					Float32 f = (Float32)(I(l))/(Float32)(I(r));
					return toR(f);
				}
				default: printf("error: values cannot be divided\n");
			}
		default: printf("error: values cannot be divided\n");
	}
	return NULLV;
}

Value modValues(Value l, Value r) {
	Int32 res;
	switch (Kind(l)) {
		case IV:
			switch (Kind(r)) {
				case IV: 
					return toI((Int32)(I(l)%I(r)));
				default: printf("error: values cannot be moduloed\n");
			}
		case GV:
			switch (Kind(r)) {
				case IV: {
					Bignum* ret = bDup(G(l));
					bModI(ret,I(r));

					// ret = newBignum();
					// mpz_init_set(*ret,G(l));
					// mpz_tdiv_r_ui(*ret,*ret,I(r));
					return toG(ret);
				}
				case GV: {
					Bignum* ret = bDup(G(l));
					bMod(ret,G(r));
					// ret = newBignum();
					// mpz_init_set(*ret,G(l));
					// mpz_tdiv_r(*ret,*ret,G(r));
					return toG(ret);
				}
				default: printf("error: values cannot be moduloed\n");
			}
		default: printf("error: values cannot be moduloed\n");
	}
	return NULLV;
}

Value powValues(Value l, Value r) {
	Int32 res;
	switch (Kind(l)) {
		case IV:
			switch (Kind(r)) {
				case IV: 
					if (powWillOverflow(I(l),I(r))) {
						Bignum* ret = bNewFromI(I(l));
						bPowI(ret,I(r));
						return toG(ret);
					}
					else {
						return toI((Int32)(pow(I(l),I(r))));
					}
				case GV: {
					printf("cannot perform operation\n");
				}
				default: printf("error: values cannot be pow'ed\n");
			}
		case GV:
			switch (Kind(r)) {
				case IV: {
					Bignum* ret = bDup(G(l));
					bPowI(ret,I(r));
					return toG(ret);
				}
				default: printf("error: values cannot be pow'ed\n");
			}
		default: printf("error: values cannot be moduloed\n");
	}
	return NULLV;
}

bool eqValues(Value l, Value r) {
	switch (Kind(l)) {
		case NV:
			return (Kind(r)==NV);
		case IV:
			switch (Kind(r)) {
				case IV: return I(l)==I(r);
				case RV: return I(l)==R(r);
				case GV: return !(bCmpI(G(r),I(l)));
				default: return false;
			}
		case RV:
			switch (Kind(r)) {
				case IV: return R(l)==I(r);
				case RV: return R(l)==R(r);
				case GV: return !(bCmpI(G(r),(int)R(l)));
				default: return false;
			}
		case BV:
			if (Kind(r)==BV) return B(l)==B(r);
			else return false;
		case GV:
			switch (Kind(r)) {
				case IV: return !(bCmpI(G(l),I(r)));
				case RV: return !(bCmpI(G(l),(int)R(r)));
				case GV: return !(bCmp(G(l),G(r)));
				default: return false;
			}
		case SV:
		 	if (Kind(r)==SV) return !(sCmp(S(l),S(r)));
		 	else return false;
		case AV:
			if (Kind(r)==AV) {
				if (A(l)->size!=A(r)->size) return false;
				else {
					ValueArray* left = A(l);
					ValueArray* right = A(r);
					aEach(left,i) {
						if (!eqValues(left->data[i],right->data[i])) return false;
					}
					return true;
				}
			}
			else return false;
		case DV:
			if (Kind(r)==DV) {
				if (D(l)->size!=D(r)->size) return false;
				else {
					Dict* left = D(l);
					Dict* right = D(r);
					aEach(left->keys,i){
						if (!sCmp(left->keys->data[i], right->keys->data[i])) return false;
						if (!eqValues(dGet(left,left->keys->data[i]), dGet(right,right->keys->data[i]))) return false;
					}
					return true;
				}
			}
			else return false;
		case FV:
			return F(l)->ip==F(r)->ip;
	}
	return false;
}

bool gtValues(Value l, Value r) {
	switch (Kind(l)) {
		case IV:
			switch (Kind(r)) {
				case IV: return (I(l)>I(r) ? true : false);
				case RV: return (I(l)>R(r) ? true : false);
				case GV: return bCmpI(G(r),I(l)) <= 0;
				default: printf("error: values cannot be compared\n");
			}
		case RV:
			switch (Kind(r)) {
				case IV: return (R(l)>I(r) ? true : false);
				case RV: return (R(l)>R(r) ? true : false);
				default: printf("error: values cannot be compared\n");
			}
		case GV:
			switch (Kind(r)) {
				case IV: return bCmpI(G(l),I(r)) > 0;
				case GV: return bCmp(G(l),G(r)) > 0;
			}
		default: printf("error: values cannot be compared\n");
	}
	return false;
}

bool ltValues(Value l, Value r) {
	switch (Kind(l)) {
		case IV:
			switch (Kind(r)) {
				case IV: return (I(l)<I(r) ? true : false);
				case RV: return (I(l)<R(r) ? true : false);
				case GV: return bCmpI(G(r),I(l)) >= 0;
				default: printf("error: values cannot be compared\n");
			}
		case RV:
			switch (Kind(r)) {
				case IV: return (R(l)<I(r) ? true : false);
				case RV: return (R(l)<R(r) ? true : false);
				default: printf("error: values cannot be compared\n");
			}
		case GV:
			switch (Kind(r)) {
				case IV: return bCmpI(G(l),I(r)) < 0;
				case GV: return bCmp(G(l),G(r)) < 0;
			}
		default: printf("error: values cannot be compared\n");
	}
	return false;
}

/**************************************
  Inspection
 **************************************/

inline String* stringify(Value v) {
	String* ret;
	switch (Kind(v)) {
		case NV	: return sNew("null"); //sInit(ret,"null"); return ret;
		case IV : {
			char buffer[15];
			i32tos(I(v),buffer);
			ret = sNew(buffer);
			return ret;
		}
		case GV :
			ret = sNew(bToCString(G(v)));
			return ret;
			//return dupCstring(bignumToCstring(G(v)));
		case RV : {
			//String* ret;

			//VStringing ret = newString("");
			//ret = vfmtCatString(ret,"%f",R(v));
			//VString str = dupCstring("float!");
			//return str;
			//return bformat("%f",R(v));//ret;
		}
		case BV :
			if (v==TRUEV) { return sNew("true"); /*sInit(ret,"true");*/ }
			else { return sNew("false"); /*sInit(ret,"false");*/ }
			//return ret;
		case SV : return sDup(S(v)); /*sDup(ret,S(v)); return ret;*/
		case AV : {
			//VString ret = dupCstring("@[");
/*
			for (int i=0; i<sv_size(A(v)); i++) {
				concatString(ret, stringify(sv_at_u(A(v),i)));
				if (i!=sv_size(A(v))-1) {
					concatCstring(ret,",");
				}
			}*/
			//concatCstring(ret,"]");
			return ret;
		}
		case FV : {
			String* ret = sNew("function <");
			char buffer[15];
			i32tos(F(v)->ip,buffer);
			sCat(ret,sNew(buffer));
			sCat(ret,sNew(","));
			i32tos(F(v)->args,buffer);
			sCat(ret,sNew(buffer));
			sCat(ret,sNew(">"));
			return ret;
		}
		default :
			printf("Fuck it; not implemented yet\n");
			return NULL;
			//return dupCstring("stringify(): not implemented yet");
	}
}

inline void printValue(Value v) {
	switch (Kind(v)) {
		case NV : fputs("null",stdout); break;
		case IV : {
			char buffer[15];
			i32tos(I(v),buffer);
			print(buffer);
        	break;
        }
        case GV : print(bToCString(G(v))); break;
        case RV : {
        	printf("%f",R(v));
        	break;
        }
        case BV : {
        	if (v==TRUEV) { print("true"); }
        	else { print("false"); }
        	break;
        }
        case SV : printf("\"%.*s\"", S(v)->size, S(v)->content); break; //fputs(strToC(S(v)),stdout); break;
        case AV : {
        	ValueArray* arr = A(v);
        	printC('@'); 
        	printC('[');
        	aEach(arr,i) {
        		printValue(arr->data[i]);
        		if (i!=arr->size-1) printC(',');
        	}
        	printC(']');
        	break;
        }
        case DV : {
        	Dict* dict = D(v);
        	printC('#');
        	printC('[');
        	aEach(dict->keys,i) {
        		print(dict->keys->data[i]->content);
        		printC(':');
        		printValue(dGet(dict,dict->keys->data[i]));
        		if (i!=dict->size-1) {
        			printC(',');
        			printC(' ');
        		}
        	}
        	printC(']');
        }
        default : {
        	break;
        }
	}
}

inline void printLnValue(Value v) {
	// printf("trying to print v: %llu\n",v);
	// printf("kind: %d\n",Kind(v));
	switch (Kind(v)) {
		case NV : printLn("null"); break;
		case IV : {
			char buffer[15];
			i32tos(I(v),buffer);
			printLn(buffer);
        	break;
        }
        case GV : printLn(bToCString(G(v))); break;
        case RV : {
        	//VString s = realToString(R(v),s);
        	printf("%f\n",R(v));
        	//printLn(toCstring(s));
        	break;
        }
        case BV : {
        	if (v==TRUEV) { printLn("true"); }
        	else { printLn("false"); }
        	break;
        }
        case SV : {
        	printLn(S(v)->content);
        	//fwrite(S(v)->content, 1, S(v)->size, stdout);
        	break;
    	}
        case AV : {
        	ValueArray* arr = A(v);
        	printC('@'); 
        	printC('[');
        	aEach(arr,i) {
        		printValue(arr->data[i]);
        		if (i!=arr->size-1) printC(',');
        	}
        	printLn("]");
        	break;
        }
        case DV : {
        	Dict* dict = D(v);
        	printC('#');
        	printC('[');
        	aEach(dict->keys,i) {
        		print(dict->keys->data[i]->content);
        		printC(':');
        		printValue(dGet(dict,dict->keys->data[i]));
        		if (i!=dict->size-1) {
        			printC(',');
        			printC(' ');
        		}
        	}
        	printLn("]");
        	break;
        }
        case FV : {
        	Func* func = F(v);
        	printf("<func: %p>\n",func);
        	break;
        }
        default : {
        	break;
        }
	}
}