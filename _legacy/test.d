module arturo.test;

import std.functional;
import std.stdio;

import std.algorithm;
import std.array;
import std.datetime.stopwatch;
import std.range;
import std.stdio: write, writeln, writef, writefln;
import std.conv : to;
import std.string;

class MyVal {
	int val;
	this(int v){
		val = v;
	}

	MyVal opBinary(string op)(in MyVal rhs) const if (op == "+") {
		return new MyVal(val+rhs.val);
	}
}

struct MyValStruct {
	int val;
	this(int v){
		val = v;
	}

	MyValStruct opBinary(string op)(in MyValStruct rhs) const if (op == "+") {
		return MyValStruct(val+rhs.val);
	}
}

float mul(float a, float b) @safe pure nothrow {
	return a*b;
}

void main() {
	pragma(inline,true);

	//void f0() { auto a = mul(1.0,2.0); }
    //void f1() { auto a = memoize!mul(1.0,2.0); }

    void f0() { 
    	auto k = "this is a string".indexOf(":")!=-1;
    }
    void f1() { 
    	auto k = "this is a string".canFind(":");
   	}

    auto r = benchmark!(f0, f1)(1_000_000);
    Duration f0Result = r[0];
    Duration f1Result = r[1]; 
    
    writeln("f0 : " ~ to!string(f0Result));
    writeln("f1 : " ~ to!string(f1Result));
}