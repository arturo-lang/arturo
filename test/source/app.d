//---------------------
// Imports
//---------------------

import core.stdc.stdio;

import std.algorithm;
import std.array;
import std.container;
import std.conv;
import std.datetime.stopwatch;
import std.functional;
import std.range;
import std.stdio;
import std.string;
import std.typecons;

import containers.dynamicarray;

//---------------------
// Global
//---------------------
/*

struct recStruct {
	int i;
	string s;
}
alias Tuple!(int,"i", string,"s") recTuple;

DynamicArray!recStruct arr1;
//DynamicArray!recTuple arr2;
DynamicArray!recTuple arr2;*/

string[string] dict;

void preRun() {
	dict["1one"] = "1";
	dict["2two"] = "2";
	dict["3on3e"] = "1";
	dict["t4w3o"] = "2";
	dict["on2e"] = "1";
	dict["t51o"] = "2";
	dict["on2e"] = "1";
	dict["5two1"] = "2";
	dict["one2"] = "1";
	dict["t5wo3"] = "2";
	dict["one4"] = "1";
	dict["two5"] = "2";
	dict["one"] = "1";
	dict["two"] = "2";
	dict["on3e"] = "1";
	dict["tw3o"] = "2";
	dict["on2e"] = "1";
	dict["tw1o"] = "2";
	dict["on2e"] = "1";
	dict["two1"] = "2";
	dict["one2"] = "1";
	dict["two3"] = "2";
	dict["one4"] = "1";
	dict["two5"] = "2";
	dict.rehash();
}

//---------------------
// Test functions
//---------------------

string[] arr1;
string[] arr2;
DynamicArray!string arr3;

auto stmtApp = appender!(string[])();

void func1() {
	arr1 ~= "done";
	//auto k = arr1;
	//writeln("done done");
}

void func2() {
	stmtApp.put("done");
	//auto k = stmtApp.data;
	//printf("done done\n");
	//auto z = dict.keys.canFind("boom");
}	

void func3() {
	arr3 ~= "done";
	//auto k = arr3;
	
}

void func4() {
	
	
}

//---------------------
// Main
//---------------------

void main(string[] args)
{
	writeln(args);
	uint times = to!uint(args[1]);

	writeln("==================================");
	writeln(" Running tests: x" ~ args[1]);
	writeln("==================================\n");

	auto result = benchmark!(func1, func2, func3, func4)(times);

	preRun();

    writeln("func1 : " ~ to!string(cast(Duration)result[0]));
    writeln("func2 : " ~ to!string(cast(Duration)result[1]));
    writeln("func3 : " ~ to!string(cast(Duration)result[2]));
    writeln("func4 : " ~ to!string(cast(Duration)result[3]));

    writeln("\nAll tests completed.");
}
