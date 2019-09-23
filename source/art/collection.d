/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/collection.d
 *****************************************************************/

module art.collection;

// Imports

import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.stdio;
import std.string;

import parser.expression;
import parser.expressions;
import parser.statements;

import compiler;

import value;

import func;
import globals;

import panic;

// Functions

class Contains_ : Func {
	this() { super("contains","check if collection contains given element",[[sV,sV],[aV,xV],[dV,xV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Value item = v[0];

		switch (item.type) {
			case sV: return new Value(S!(item).indexOf(S!(v,1))!=-1);
			case aV: return new Value(item.arrayContains(v[1]));
			case dV: return new Value(item.dictionaryContains(v[1]));
			default: break;
		}

		return new Value(0);
	}
}

class Delete_ : Func {
	this() { super("delete","delete collection element by using given value",[[aV,xV],[dV,xV]],[aV,dV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Value item = v[0];
		Value object = v[1];

		if (item.type==aV) {
			return item.removeValueFromArray(object);
		}
		else {
			return item.removeValueFromDict(object);
		}
	}
}

class Delete__By_ : Func {
	this() { super("delete.by","delete collection element by using given index/key",[[aV,nV],[dV,sV]],[aV,dV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Value item = v[0];

		if (item.type==aV) {
			alias index = I!(v,1);

			if (index<A!(item).length) {
				return item.removeIndexFromArray(index);
			}
			else throw new ERR_IndexNotFound(index, to!string(item));
		}
		else {
			alias index = S!(v,1);
			
			if (item.getValueFromDict(index) !is null) {
				return item.removeIndexFromDict(index);
			}
			else throw new ERR_IndexNotFound(index, to!string(item));
		}
	}
}

class Get_ : Func {
	this() { super("get","get element from collection using given index/key",[[aV,nV],[dV,sV]],[xV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Value item = v[0];

		if (item.type==aV) {
			alias index = I!(v,1);

			if (index<A!(item).length) return A!(item)[index];
			else throw new ERR_IndexNotFound(index, to!string(item));
		}
		else {
			alias index = S!(v,1);
			
			Value ret = item.getValueFromDict(index);
			if (ret !is null) return ret;
			else throw new ERR_IndexNotFound(index, to!string(item));
		}
	}
}

class Is__Empty_ : Func {
	this() { super("is.empty","check if collection is empty",[[sV],[aV],[dV]],[bV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Value item = v[0];

		switch (item.type) {
			case sV: return new Value(S!(item).length==0);
			case aV: return new Value(A!(item).length==0);
			case dV: return new Value(D!(item).variables.length==0);
			default: break;
		}

		return new Value();
	}
}

class Set_ : Func {
	this() { super("set","set collection element using given index/key",[[aV,nV,xV],[dV,sV,xV]],[aV,dV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Value item = v[0];

		if (item.type==aV) {
			alias index = I!(v,1);

			if (index<A!(item).length) {
				A!(item)[index] = v[2];
				return item;
			}
			else throw new ERR_IndexNotFound(index, to!string(item));
		}
		else {
			alias index = S!(v,1);
			
			if (item.getValueFromDict(index) !is null) {
				item.setValueForDict(index,v[2]);
				return item.getValueFromDict(index);
			}
			else {
				item.setValueForDict(index,v[2]);
				return item;
			}
			//return new Value();
		}
	}
}

class Size_ : Func {
	this() { super("size","get size of collection",[[sV],[aV],[dV]],[nV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Value item = v[0];

		switch (item.type) {
			case sV: return new Value(S!(item).length);
			case aV: return new Value(A!(item).length);
			case dV: return new Value(D!(item).variables.length);
			default: break;
		}

		return new Value(0);
	}
}