//---------------------
// Imports
//---------------------

import std.algorithm;
import std.array;
import std.container;
import std.conv;
import std.datetime.stopwatch;
import std.functional;
import std.range;
import std.stdio;
import std.string;
/*
import containers.dynamicarray;
//import containers.hashmap;
import containers.hashset;
import containers.immutablehashset;
import containers.openhashset;*/

import memutils.hashmap;

//---------------------
// Global
//---------------------

int[string] dict;
//HashMap!(string, int) hmap;
HashMap!(string, int) hmap;

//Array!string arr;
//DynamicArray!string darr;
//HashSet!string sl;

void preRun() {
	dict["ae"] = 0;
	dict["ad"] = 1;
	dict["aa"] = 2;
	dict["ac"] = 3;
	dict["ab"] = 4;
	dict["af"] = 5;
	dict["be"] = 0;
	dict["bd"] = 1;
	dict["ba"] = 2;
	dict["bc"] = 3;
	dict["bb"] = 4;
	dict["bf"] = 5;
	dict["e"] = 0;
	dict["d"] = 1;
	dict["a"] = 2;
	dict["c"] = 3;
	dict["b"] = 4;
	dict["f"] = 5;
	dict.rehash();

	hmap["ae"] = 0;
	hmap["ad"] = 1;
	hmap["aa"] = 2;
	hmap["ac"] = 3;
	hmap["ab"] = 4;
	hmap["af"] = 5;
	hmap["be"] = 0;
	hmap["bd"] = 1;
	hmap["ba"] = 2;
	hmap["bc"] = 3;
	hmap["bb"] = 4;
	hmap["bf"] = 5;
	hmap["e"] = 0;
	hmap["d"] = 1;
	hmap["a"] = 2;
	hmap["c"] = 3;
	hmap["b"] = 4;
	hmap["f"] = 5;
/*
	arr ~= "one";
	arr ~= "two";
	arr ~= "three";
	arr ~= "one";
	arr ~= "two";
	arr ~= "three";
	arr ~= "one";
	arr ~= "two";
	arr ~= "three";
	arr ~= "one";
	arr ~= "two";
	arr ~= "three";

	darr ~= "one";
	darr ~= "two";
	darr ~= "three";
	darr ~= "one";
	darr ~= "two";
	darr ~= "three";
	darr ~= "one";
	darr ~= "two";
	darr ~= "three";
	darr ~= "one";
	darr ~= "two";
	darr ~= "three";

	sl.put("one");
	sl.put("two");
	sl.put("three");
	sl.put("one");
	sl.put("two");
	sl.put("three");
	sl.put("one");
	sl.put("two");
	sl.put("three");
	sl.put("one");
	sl.put("two");
	sl.put("three");*/
}

//---------------------
// Test functions
//---------------------

void func1() {
	dict["f"] = 6; // assign an existing key
	dict["g"] = 7; // assign a new key
	auto k = dict["f"]; // get a value by key
	auto j = "f" in dict; // check if a key exists
}

void func2() {
	hmap["f"] = 6; // assign an existing key
	hmap["g"] = 7; // assign a new key
	auto k = hmap["f"]; // get a value by key
	auto j = ("f" in hmap) ? hmap["f"] : 0; // check if a key exists
}	

void func3() {
	
	
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
