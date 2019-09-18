/************************************************
 * Arturo
 * 
 * The Minimal Declarative-Like Language
 * (c) 2019 Ioannis Zafeiropoulos
 *
 * @file: stack.d
 ************************************************/

module stack;

// Imports

import std.array;
import std.conv;
import std.stdio;

// Functions

class Stack(T)
{
	T[] list;
	this()
	{

	}

	Stack!(T) copy() {
		Stack!(T) ret = new Stack!(T);

		foreach (T item; list) {
			ret.push(item);
		}

		return ret;
	}

	void push(T v)
	{
		list ~= v;
	}

	T pop()
	{
		if (!isEmpty())
		{
			T item = list[list.length-1];
			list.popBack();

			return item;
		}
		else
			return null;
	}

	bool isEmpty()
	{
		return list.length==0;
	}

	ulong size()
	{
		return list.length;
	}

	T lastItem()
	{
		return list[list.length-1];
	}

	void print()
	{
		writeln("-----------/--/---------STACK--------/--/-----------");
		writeln("Stack size : " ~ to!string(list.length));
		foreach (i, T value; list)
		{
			string tabs;
			for (int j; j<=i; j++) tabs ~= "\t";
			writefln("%s : %s%s",to!string(i),tabs,to!string(value));
		}
		writeln("-----------/--/---------end-0--------/--/-----------");
	}

	void printPath()
	{
		string ret = "";
		foreach (i, T value; list)
		{
			ret ~= to!string(value);
			if (i!=list.length-1) ret~=":";
		}
		writeln(ret);
	}
}