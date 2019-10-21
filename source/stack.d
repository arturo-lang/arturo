/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: stack.d
 *****************************************************************/

module stack;

// Imports

import std.array;
import std.conv;
import std.stdio;

import containers.dynamicarray;

// Functions

alias lastItem(X) = X.list[X.length-1];

class Stack(T)
{
    DynamicArray!T list;
    //T[] list;
    this() {
        //list = [];
    }

    Stack!(T) copy() {
        Stack!(T) ret = new Stack!(T);

        foreach (T item; list) {
            ret.push(item);
        }

        return ret;
    }

    void push(T v) {
        list ~= v;
    }

    T pop() {
        if (!isEmpty()) {
            T item = list.back();//list[list.length-1];
            list.removeBack();//list.popBack();

            return item;
        }
        else return cast(T)(null);
    }

    bool isEmpty() {
        return list.empty();
        //return list.length==0;
    }

    ulong size() {
        return list.length();
        //return list.length;
    }

    T lastItem() {
        return list.back();
        //return list[list.length-1];
    }

    void print() {
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

    string str() {
        string[] ret;
        foreach (i, T value; list) {
            ret ~= to!string(value);
        }

        return ret.join(", ");
    }

    void printPath() {
        string ret = "";
        foreach (i, T value; list)
        {
            ret ~= to!string(value);
            if (i!=list.length-1) ret~=":";
        }
        writeln(ret);
    }
}