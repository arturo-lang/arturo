/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: val.d
 *****************************************************************/

module val;

// Imports

import core.checkedint;

import std.algorithm;
import std.array;
import std.bigint;
import std.conv;
import std.digest.sha;
import std.json;
import std.range;
import std.stdio;
import std.string;
import std.variant;

import gobject.ObjectG;

import parser.statements;

import art.json;

import context;
import func;
import globals;
import panic;

// Aliases

alias nVal 	= ValType.numberValue;
alias bnVal = ValType.bigNumberValue;
alias rVal 	= ValType.realValue;
alias sVal 	= ValType.stringValue;
alias bVal 	= ValType.booleanValue;
alias aVal 	= ValType.arrayValue;
alias dVal 	= ValType.dictionaryValue;
alias fVal 	= ValType.functionValue;
alias xVal 	= ValType.anyValue;
alias noVal = ValType.noValue;
alias vVal 	= ValType.variadicValue;
alias oVal 	= ValType.objectValue;
alias goVal = ValType.gobjectValue;

// Definitions

enum ValType : string
{
    numberValue = "Number",
    bigNumberValue = "Number*",
    realValue = "Real",
    stringValue = "String",
    booleanValue = "Boolean",
    arrayValue = "Array",
    dictionaryValue = "Dictionary",
    functionValue = "Function",
    noValue = "Null",
    anyValue = "Any",
    variadicValue = "Any...",
    objectValue = "Object",
    gobjectValue = "GObject"
}

union ValContent
{
    long n;
    BigInt bn;
    real r;
    string s;
    bool b;
    Func f;
    Val[] a;
    Context d;
    void* o;
    ObjectG go;

}

struct Val {
    ValType type = ValType.noValue;
    ValContent content;

    static Val array() {
    	Val v;
        v.type = ValType.arrayValue;
        v.content.a = [];
        return v;
    }

    static Val dictionary() {
        Val v;
        v.type = ValType.dictionaryValue;
        v.content.d = new Context(ContextType.dictionaryContext);
        return v;
    }
    
    this(int v) 							{ type = nVal; content.n = v; }
    this(long v) 							{ type = nVal; content.n = v; }
    this(BigInt v) 							{ type = bnVal; content.bn = v; }
	this(string v, bool bignum=false) 		{ if (bignum) { type = bnVal; content.bn = BigInt(v); }
	    									  else { type = sVal; content.s = v; } 
    										}
    this(bool v)							{ type = bVal; content.b = v; }
    this(real v) 							{ type = rVal; content.r = v; } 
    this(Func f) 							{ type = fVal; content.f = f; }
	this(Statements v, string[] ids=null) 	{ if (ids is null) { type = fVal; content.f = new Func("", v); }
											  else { type = fVal; content.f = new Func("", v, [], ids); }
											}
	this(void* o) 							{ type = oVal; content.o = o; }
	this(ObjectG og) 						{ type = goVal; content.go = og; }

	this(Val[] v) 							{ type = aVal; content.a = []; foreach (i;v) content.a ~= i; }	
	this(string[] v) 						{ type = aVal; content.a = []; foreach (i;v) content.a ~= Val(i); }
/*
	this(Val[Val] v)						{ type = dVal; content.d = new ContextType(ContextType.dictionaryContext);
											  foreach (k,c;v) content.d._setSymbol(k.content.s, c);
											}
	this(string[string] v) 					{ type = dVal; content.d = new ContextType(ContextType.dictionaryContext);
											  foreach (k,c;v) content.d._setSymbol(k, Val(c));
											}
	this(Val[string] v) 					{ type = dVal; content.d = new ContextType(ContextType.dictionaryContext);
											  foreach (k,c;v) content.d._setSymbol(k, c);
											}
*/
	~this() {
		//writeln("destructor called");
	}
}