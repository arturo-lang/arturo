/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/vm/value.c
 *****************************************************************/

#include "arturo.h"

/**************************************
  Converters
 **************************************/

mpz_t* bigint;

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
	bigint = newBignum();
    mpz_init_set_str(*bigint, str, 10);
    return toG(*(bigint++));
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

/**************************************
  Arithmetic operations
 **************************************/

mpz_t* ret;

Value addValues(Value l, Value r) {
	switch (Kind(l)) {
		case IV: 
			switch (Kind(r)) {
				case IV: {
					Int32 res;
                    if (addWillOverflow(I(l),I(r),&res)) {
                    	ret = newBignum();
    					mpz_init_set_si(*ret,I(l));
    					mpz_add_ui(*ret,*ret,I(r));
    					return toG(*(ret++));
                    }
                    else {
                    	return toI(res);
                    }
                }
                case GV: {
                	ret = newBignum();
                	mpz_init_set(*ret,G(r));
                	mpz_add_ui(*ret,*ret,I(l));
                	return toG(*(ret++));
                }
                case RV: {
                	return toR(I(l)+R(r));
                }
                case SV: {
                	/*
                	VString left = stringify(l);
                	VString right = dupString(S(r));
                	concatString(left, right);
                	freeString(right);
                	return toS(left);*/
                }
				default: invalidOperationError('+');
			}
		case GV:
			switch (Kind(r)) {
				case IV: {
					ret = newBignum();
					mpz_init_set(*ret,G(l));
					mpz_add_ui(*ret,*ret,I(r));
					return toG(*(ret++));
				}
				case GV: {
					ret = newBignum();
					mpz_init_set(*ret,G(l));
					mpz_add(*ret,*ret,G(r));
					return toG(*(ret++));
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
			// for (int i=0; i<A(l)->size; i++){
			// 	printf("item/%d: %s\n",i,stringify(A(l)->data[i])->data);
			// }
			//srt_vector* vec = sv_alloca_t(SV_U64,0);
			/*srt_vector* ret = sv_dup(A(l));
			// for (int i=0; i<ret->size; i++){
			// 	printf("item/%d: %s\n",i,stringify(ret->data[i])->data);
			// }
			if (Kind(r)==AV) {
				srt_vector* right = A(r);
				for (int i=0; i<sv_size(right); i++) {
					sv_push_u(&ret,sv_at_u(right,i));
				}
			}
			else {
				sv_push_u(&ret,r);
			}
			// for (int i=0; i<ret->size; i++){
			// 	printf("item/%d: %s\n",i,stringify(ret->data[i])->data);
			// }
			return toA(ret);*/
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
                    	ret = newBignum();
    					mpz_init_set_si(*ret,I(l));
    					mpz_sub_ui(*ret,*ret,I(r));
    					return toG(*(ret++));
                    }
                    else {
                    	return toI(res);
                    }
                }
                case GV: {
                	ret = newBignum();
                	mpz_init_set_si(*ret,I(l));
                	mpz_sub(*ret,*ret,G(r));
                	return toG(*(ret++));
                }
                case RV: {
                	return toR(I(l)-R(r));
                }
				default: printf("error: values cannot be subtracted\n");
			}
		case GV:
			switch (Kind(r)) {
				case IV: {
					ret = newBignum();
					mpz_init_set(*ret,G(l));
					mpz_sub_ui(*ret,*ret,I(r));
					return toG(*(ret++));
				}
				case GV: {
					ret = newBignum();
					mpz_init_set(*ret,G(l));
					mpz_sub(*ret,*ret,G(r));
					return toG(*(ret++));
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
                        ret = newBignum();
    					mpz_init_set_si(*ret,I(l));
    					mpz_mul_ui(*ret,*ret,I(r));
    					return toG(*(ret++));
                    }
                    else {
                    	return toI(res);
                    }
                case GV: {
                	ret = newBignum();
					mpz_init_set_si(*ret,I(l));
					mpz_mul(*ret,*ret,G(r));
					return toG(*(ret++));
                }
                case RV: {
                	return toR(I(l)*R(r));
                }
				default: printf("error: values cannot be multiplicated\n");
			}
		case GV:
			switch (Kind(r)) {
				case IV: {
					ret = newBignum();
					mpz_init_set(*ret,G(l));
					mpz_mul_ui(*ret,*ret,I(r));
					return toG(*(ret++));
				}
				case GV: {
					ret = newBignum();
					mpz_init_set(*ret,G(l));
					mpz_mul(*ret,*ret,G(r));
					return toG(*(ret++));
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
					ret = newBignum();
					mpz_init_set(*ret,G(l));
					mpz_tdiv_q_ui(*ret,*ret,I(r));
					return toG(*(ret++));
				}
				case GV: {
					ret = newBignum();
					mpz_init_set(*ret,G(l));
					mpz_tdiv_q(*ret,*ret,G(r));
					return toG(*(ret++));
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
					ret = newBignum();
					mpz_init_set(*ret,G(l));
					mpz_tdiv_r_ui(*ret,*ret,I(r));
					return toG(*(ret++));
				}
				case GV: {
					ret = newBignum();
					mpz_init_set(*ret,G(l));
					mpz_tdiv_r(*ret,*ret,G(r));
					return toG(*(ret++));
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
						ret = newBignum();
						mpz_init(*ret);
						mpz_ui_pow_ui(*ret,I(l),I(r));
						return toG(*(ret++));
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
					ret = newBignum();
					mpz_init_set(*ret,G(l));
					mpz_pow_ui(*ret,*ret,I(r));
					return toG(*(ret++));
				}
				default: printf("error: values cannot be pow'ed\n");
			}
		default: printf("error: values cannot be moduloed\n");
	}
	return NULLV;
}

bool eqValues(Value l, Value r) {
	switch (Kind(l)) {
		case IV:
			switch (Kind(r)) {
				case IV: return (I(l)==I(r) ? true : false);
				default: printf("error: values cannot be compared\n");
			}
		default: printf("error: values cannot be compared\n");
	}
	return false;
}

bool gtValues(Value l, Value r) {
	switch (Kind(l)) {
		case IV:
			switch (Kind(r)) {
				case IV: return (I(l)>I(r) ? true : false);
				default: printf("error: values cannot be compared\n");
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
				default: printf("error: values cannot be compared\n");
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
        case GV : print(bignumToCstring(G(v))); break;
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
        	print("printing dict");
        	break;
        }
        default : {
        	break;
        }
	}
}

inline void printLnValue(Value v) {
	switch (Kind(v)) {
		case NV : printLn("null"); break;
		case IV : {
			char buffer[15];
			i32tos(I(v),buffer);
			printLn(buffer);
        	break;
        }
        case GV : printLn(bignumToCstring(G(v))); break;
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
        	printLn("printing dict");
        	break;
        }
        default : {
        	break;
        }
	}
}