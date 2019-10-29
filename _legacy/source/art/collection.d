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
import func;
import globals;
import value;
import panic;

// Functions

final class Add_ : Func {
	this(string ns="") { super(ns ~ "add","add element to collection",[[aV,xV],[dV,xV]],[aV,dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		Value collection = v[0];
		Value item = v[1];

		if (collection.type==aV) {
			collection.addValueToArray(item);
		}
		else { // dictionary
			if (CHILDREN !in collection) {
				collection[CHILDREN] = Value.array();
				collection[CHILDREN].addValueToArray(item);
			}
		}

		return collection;
	}
}

final class Contains_ : Func {
	this(string ns="") { super(ns ~ "contains","check if collection contains given element",[[sV,sV],[aV,xV],[dV,xV]],[bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		Value item = v[0];

		switch (item.type) {
			case sV: return new Value(S!(item).indexOf(S!(v,1))!=-1);
			case aV: return new Value(item.arrayContains(v[1]));
			case dV: return new Value(item.dictionaryContains(v[1]));
			default: break;
		}

		return NULLV;
	}
}

final class Delete_ : Func {
	this(string ns="") { super(ns ~ "delete","delete collection element by using given value",[[aV,xV],[dV,xV]],[aV,dV]); }
	override Value execute(Expressions ex, string hId=null) {
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

final class Delete__By_ : Func {
	this(string ns="") { super(ns ~ "deleteBy","delete collection element by using given index/key",[[aV,nV],[dV,sV]],[aV,dV]); }
	override Value execute(Expressions ex, string hId=null) {
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

final class Find_ : Func {
	this(string ns="") { super(ns ~ "find","return index of string/element within string/array, or -1 if not found",[[sV,sV],[aV,xV]],[nV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		Value item = v[0];

		switch (item.type) {
			case sV: return new Value(S!(item).countUntil(S!(v,1)));
			case aV: return new Value(A!(item).countUntil(v[1]));
			default: break;
		}

		return NULLV;
	}
}

final class Get_ : Func {
	this(string ns="") { super(ns ~ "get","get element from collection using given index/key",[[aV,nV],[dV,sV]],[xV]); }
	override Value execute(Expressions ex, string hId=null) {
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

final class Is__Empty_ : Func {
	this(string ns="") { super(ns ~ "isEmpty","check if collection is empty",[[sV],[aV],[dV]],[bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		Value item = v[0];

		switch (item.type) {
			case sV: return new Value(S!(item).length==0);
			case aV: return new Value(A!(item).length==0);
			case dV: return new Value(D!(item).length==0);
			default: break;
		}

		return NULLV;
	}
}

final class Reverse_ : Func {
	this(string ns="") { super(ns ~ "reverse","reverse given array or string",[[aV],[sV]],[aV,sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		Value item = v[0];

		switch (item.type) {
			case sV: return new Value(S!(item).split("").map!(s=> new Value(to!string(s))).array.reverse.map!(m=> m.content.s).array.join(""));
			case aV: return new Value(A!(item).reverse);
			default: break;
		}
		return NULLV;
	}
}

final class Set_ : Func {
	this(string ns="") { super(ns ~ "set","set collection element using given index/key",[[aV,nV,xV],[dV,sV,xV]],[aV,dV]); }
	override Value execute(Expressions ex, string hId=null) {
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
			//return NULLV;
		}
	}
}

final class Size_ : Func {
	this(string ns="") { super(ns ~ "size","get size of collection",[[sV],[aV],[dV]],[nV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		Value item = v[0];

		switch (item.type) {
			case sV: return new Value(S!(item).length);
			case aV: return new Value(A!(item).length);
			case dV: return new Value(D!(item).length);
			default: break;
		}

		return new Value(0);
	}
}

final class Slice_ : Func {
	this(string ns="") { super(ns ~ "slice","get slice of array/string given a starting and/or end point",[[aV,nV],[aV,nV,nV],[sV,nV],[sV,nV,nV]],[aV,sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		Value item = v[0];

		switch (item.type) {
			case sV: return (v.length==3 ? new Value(S!(item)[I!(v,1)..I!(v,2)]) : new Value(S!(item)[I!(v,1)..$]));
			case aV: return (v.length==3 ? new Value(A!(item)[I!(v,1)..I!(v,2)]) : new Value(A!(item)[I!(v,1)..$]));
			default: break;
		}

		return NULLV;
	}
}