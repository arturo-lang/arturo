/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/system.d
 *****************************************************************/

module art.system;

// Imports

import core.thread;

import std.algorithm;
import std.conv;
import std.file;
import std.process;
import std.stdio;
import std.string;

import parser.expression;
import parser.expressions;
import parser.statements;

import func;
import globals;
import value;

// Functions

final class Delay_ : Func {
	this(string ns="") { super(ns ~ "delay","create system delay with a given duration in milliseconds",[[nV]],[]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias duration = I!(v,0);

		Thread.sleep( dur!("msecs")( duration ));

		return NULLV;
	}
}

final class Env_ : Func {
	this(string ns="") { super(ns ~ "env","get system environment variables as a dictionary",[[]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		string[string] ret = environment.toAA();

		return new Value(ret);
	}
}

final class Shell_ : Func {
	this(string ns="") { super(ns ~ "shell","execute given shell command",[[sV]],[sV,bV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias command = S!(v,0);

		auto cmd = executeShell(command);

		if (cmd.status != 0) 
			return new Value(false);
		else
			return new Value(cmd.output);
	}
}

final class Spawn_ : Func {
	this(string ns="") { super(ns ~ "spawn","spawn process using given string and get process id",[[sV]],[nV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);

		auto pid = spawnProcess(input);

		return new Value(pid.processID());
	}
}

final class Thread_ : Func {
	this(string ns="") { super(ns ~ "thread","create a background threaded process using given function",[[fV]],[]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias func = S!(v,0);

		new Thread ({
			func.execute();
		});

		return NULLV;
	}
}