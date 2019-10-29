/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/array.d
 *****************************************************************/

module art.array;

// Imports

import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.numeric;
import std.random;
import std.range;
import std.stdio;
import std.string;

import parser.expression;
import parser.expressions;
import parser.statements;

import compiler;
import func;
import globals;
import panic;
import value;

// Functions

final class All_ : Func {
	this(string ns="") { super(ns ~ "all","check if all elements of array are true or pass the condition of given function",[[aV],[aV,fV]],[bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		alias arr = A!(v,0);

		if (v.length==2) {
			alias func = F!(v,1);

			bool ok = true;
			foreach (Value item; arr) {
				Value val = func.execute(item);
				if (val.type!=bV) throw new ERR_ExpectedValueTypeError("all", "boolean", to!string(item.type));
				if (!B!(val)) ok = false;
			}
			
			return new Value(ok);
		}
		else {
			bool ok = true;
			foreach (Value item; arr) {
				if (item.type!=bV) throw new ERR_ExpectedValueTypeError("all", "boolean", to!string(item.type));
				if (!B!(item)) ok = false;
			}
			return new Value(ok);
		}
	}
}

final class Any_ : Func {
	this(string ns="") { super(ns ~ "any","check if any of the array's elements is true or passes the condition of given function",[[aV],[aV,fV]],[bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		alias arr = A!(v,0);

		if (v.length==2) {
			alias func = F!(v,1);

			bool ok = false;
			foreach (Value item; arr) {
				Value val = func.execute(item);
				if (val.type!=bV) throw new ERR_ExpectedValueTypeError("any", "boolean", to!string(item.type));
				if (B!(val)) ok = true;
			}
			
			return new Value(ok);
		}
		else {
			bool ok = false;
			foreach (Value item; arr) {
				if (item.type!=bV) throw new ERR_ExpectedValueTypeError("any", "boolean", to!string(item.type));
				if (B!(item)) ok = true;
			}
			return new Value(ok);
		}
	}
}

final class Avg_ : Func {
	this(string ns="") { super(ns ~ "avg","get average value from array",[[aV]],[nV,rV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		alias arr = A!(v,0);
		Value sum = new Value(0);

		foreach (Value item; arr) {
			if (item.type!=nV && item.type!=rV) throw new ERR_ExpectedValueTypeError("min","number",item.type);

			sum = sum + item;
		}

		auto ret = to!real(sum.content.i)/(to!real(arr.length));

		if (to!int(ret)==ret) return new Value(to!int(ret));
		else return new Value(ret);
	}
}

final class Count_ : Func {
	this(string ns="") { super(ns ~ "count","count how many of the array's elements is true or passes the condition of given function",[[aV],[aV,fV]],[nV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		alias arr = A!(v,0);

		if (v.length==2) {
			alias func = F!(v,1);

			int oks = 0;
			foreach (Value item; arr) {
				Value val = func.execute(item);
				if (val.type!=bV) throw new ERR_ExpectedValueTypeError("count", "boolean", to!string(item.type));
				if (B!(val)) oks += 1;
			}
			
			return new Value(oks);
		}
		else {
			int oks = 0;
			foreach (Value item; arr) {
				if (item.type!=bV) throw new ERR_ExpectedValueTypeError("count", "boolean", to!string(item.type));
				if (B!(item)) oks+=1;
			}
			return new Value(oks);
		}
	}
}

final class Difference_ : Func {
	this(string ns="") { super(ns ~ "difference","get difference of two given arrays",[[aV,aV]],[aV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias arr1 = A!(v,0);
		alias arr2 = A!(v,1);

		Value[] ret = setDifference(arr1, arr2).array;

		return new Value(ret);
	}
}

final class Filter_ : Func {
	this(string ns="") { super(ns ~ "filter","get array after filtering each element using given function",[[aV,fV]],[aV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias arr = A!(v,0);
		alias func = F!(v,1);

		Value[] ret = arr.filter!(item => func.execute(item).content.b).array;
		/*
		Value[] ret;
		foreach (Value item; arr) {
			Value condition = func.execute(item);
			if (condition.type!=bV) 
				throw new ERR_ExpectedValueTypeError("filter", "boolean", condition.type);

			if (condition.content.b)
				ret ~= item;
		}*/

		return new Value(ret);
	}
}

final class First_ : Func {
	this(string ns="") { super(ns ~ "first","get first element from array",[[aV]],[xV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias arr = A!(v,0);

		if (arr.length>0) return arr[0];
		else throw new ERR_IndexNotFound(0, to!string(v[0]));
	}
}

final class Fold_ : Func {
	this(string ns="") { super(ns ~ "fold","fold array using seed value and the given function",[[aV,xV,fV]],[xV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias arr = A!(v,0);
		alias func = F!(v,2);

		Value seed = v[1];
		foreach (Value item; arr) 
			seed = func.execute(new Value([seed,item]));

		Value ret = new Value(seed);

		return ret;
	}
}

final class Gcd_ : Func {
	this(string ns="") { super(ns ~ "gcd","calculate greatest common divisor of values from array",[[aV]],[nV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		alias arr = A!(v,0);
		ulong currentGcd = I!(arr,0);

		for (int i=1; i<arr.length; i++) {
			if (arr[i].type!=nV) throw new ERR_ExpectedValueTypeError("gcd","number",arr[i].type);

			currentGcd = gcd(currentGcd,arr[i].content.i);
		}

		return new Value(currentGcd);
	}
}

final class Intersection_ : Func {
	this(string ns="") { super(ns ~ "intersection","get intersection of two given arrays",[[aV,aV]],[aV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias arr1 = A!(v,0);
		alias arr2 = A!(v,1);

		Value[] ret = setIntersection(arr1, arr2).array;

		return new Value(ret);
	}
}

final class Join_ : Func {
	this(string ns="") { super(ns ~ "join","get string by joining array elements with given delimiter",[[aV,sV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias arr = A!(v,0);
		alias delim = S!(v,1);

		auto ret = arr.map!(a=> (a.type==sV) ? a.content.s : a.stringify()).array.join(delim);

		return new Value(ret);
	}
}

final class Last_ : Func {
	this(string ns="") { super(ns ~ "last","get last element from array",[[aV]],[xV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias arr = A!(v,0);

		if (arr.length>0) return arr[arr.length-1];
		else throw new ERR_IndexNotFound(0, to!string(v[0]));
	}
}

final class Map_ : Func {
	this(string ns="") { super(ns ~ "map","get array after executing given function for each element",[[aV,fV]],[aV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias arr = A!(v,0);
		alias func = F!(v,1);

		Value[] ret = arr.map!(item => func.execute(item)).array;
		/*
		foreach (Value item; arr) 
			ret ~= func.execute(item);*/

		return new Value(ret);
	}
}

final class Max_ : Func {
	this(string ns="") { super(ns ~ "max","get maximum value from array",[[aV]],[nV,rV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		alias arr = A!(v,0);
		Value maxValue = NULLV;

		foreach (Value item; arr) {
			if (item.type!=nV && item.type!=rV) throw new ERR_ExpectedValueTypeError("max","number",item.type);
			
			if (maxValue.type==noV) maxValue = item;
			else {
				if (item>maxValue) maxValue = item;
			}
		}

		return maxValue;
	}
}

final class Median_ : Func {
	this(string ns="") { super(ns ~ "median","get median value from array",[[aV]],[nV,rV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		Value arr = v[0];

		Value sorted = arr.arraySort();

		if (sorted !is null) {
			alias sarr = A!(sorted);
			if (sarr.length%1==0) {
				return sarr[sarr.length/2+1];
			}
			else {
				return new Value((to!real(sarr[sarr.length/2].content.i) + to!real(sarr[sarr.length/2+1].content.i))/2);
			}
		}
		else throw new ERR_ArrayNotSortable(to!string(arr));
	}
}

final class Min_ : Func {
	this(string ns="") { super(ns ~ "min","get minimum value from array",[[aV]],[nV,rV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		alias arr = A!(v,0);
		Value minValue = NULLV;

		foreach (Value item; arr) {
			if (item.type!=nV && item.type!=rV) throw new ERR_ExpectedValueTypeError("min","number",item.type);

			if (minValue.type==noV) minValue = item;
			else {
				if (item<minValue) minValue = item;
			}
		}

		return minValue;
	}
}

final class Permutations_ : Func {
	this(string ns="") { super(ns ~ "permutations","get all permutations for given array",[[aV]],[aV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		Value cp = new Value(v[0]);

		Value[] ret;

		ret ~= new Value(cp.content.a);

		while (nextPermutation(cp.content.a)) {
			ret ~= new Value(cp.content.a);
		}

		return new Value(ret);
	}
}

final class Product_ : Func {
	this(string ns="") { super(ns ~ "product","return product of elements of given array",[[aV]],[nV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias arr = A!(v,0);

		Value ret = new Value(1);

		foreach (val; arr) {
			if (val.type!=nV) throw new ERR_FunctionCallValueError("sum", 0, "number", val.type);
			ret = ret * val;
		}

		return ret;
	}
}

final class Range_ : Func {
	this(string ns="") { super(ns ~ "range","get array from given range (from..to) with optional step",[[nV,nV],[nV,nV,nV]],[aV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias from = I!(v,0);
		alias to = I!(v,1);

		long step = ex.lst.length==3 ? I!(v,2) : 1;

		Value[] ret = iota(from,to+1,(from>=to?-1*step:step)).map!(i=>new Value(i)).array;
		/*
		if (from<to) {
			for (long i=from; i<=to; i+=step)
				ret ~= new Value(i);
		}
		else {
			for (long i=from; i>=to; i-=step)
				ret ~= new Value(i);
		}*/

		return new Value(ret);
	}
}

final class Sample_ : Func {
	this(string ns="") { super(ns ~ "sample","get random sample from given array",[[aV],[aV,nV]],[xV,aV,noV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias arr = A!(v,0);

		if (v.length==2) {
			alias count = I!(v,1);

			auto smpl = cast(Value[])(arr.randomSample(count).array);
			return new Value(smpl);
		} 
		else {
			auto smpl = arr.randomSample(1).array;
			if (smpl.length==1) return smpl[0];
			else return NULLV;
		}
	}
}

final class Shuffle_ : Func {
	this(string ns="") { super(ns ~ "shuffle","shuffle given array",[[aV]],[aV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias arr = A!(v,0);

		Value[] ret = arr.randomShuffle();

		return new Value(ret);
	}
}

final class Sort_ : Func {
	this(string ns="") { super(ns ~ "sort","sort given array",[[aV]],[aV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		Value arr = v[0];

		Value sorted = arr.arraySort();

		if (sorted !is null) return sorted;
		else throw new ERR_ArrayNotSortable(to!string(arr));
	}
}

final class Sum_ : Func {
	this(string ns="") { super(ns ~ "sum","return sum of elements of given array",[[aV]],[nV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias arr = A!(v,0);

		Value ret = new Value(0);

		foreach (val; arr) {
			if (val.type!=nV) throw new ERR_FunctionCallValueError("sum", 0, "number", val.type);
			ret = ret + val;
		}

		return ret;
	}
}

final class Swap_ : Func {
	this(string ns="") { super(ns ~ "swap","swap array elements at given indices",[[aV,nV,nV]],[aV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		Value arr = v[0];
		alias from = I!(v,1);
		alias to = I!(v,2);

		arr.content.a.swapAt(from,to);

		return arr;
	}
}

final class Tail_ : Func {
	this(string ns="") { super(ns ~ "tail","get last section of array excluding the first element",[[aV]],[aV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias arr = A!(v,0);

		if (arr.length>0) return new Value(arr.tail(arr.length-1));
		else return new Value(cast(Value[])([]));
	}
}

final class Union_ : Func {
	this(string ns="") { super(ns ~ "union","get union of two given arrays",[[aV,aV]],[aV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias arr1 = A!(v,0);
		alias arr2 = A!(v,1);

		Value[][] input = [ arr1, arr2 ];

		Value[] ret = multiwayUnion(input).array;

		return new Value(ret);
	}
}

final class Unique_ : Func {
	this(string ns="") { super(ns ~ "unique","get array by removing duplicates",[[aV]],[aV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias arr = A!(v,0);

		return v[0].removeDuplicatesFromArray();
	}
}

final class Zip_ : Func {
	this(string ns="") { super(ns ~ "zip","return array of element pairs using given arrays",[[aV,aV]],[aV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias arr1 = A!(v,0);
		alias arr2 = A!(v,1);

		auto minCommonLength = min(arr1.length, arr2.length);

		Value[] ret = cast(Value[])([]);

		for (int i=0; i<minCommonLength; i++) {
			ret ~= new Value([arr1[i],arr2[i]]);
		}

		return new Value(ret);
	}
}
