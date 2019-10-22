/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/date.d
 *****************************************************************/

module art.date;

// Imports

import core.time;

import std.algorithm;
import std.conv;
import std.datetime;
import std.datetime.stopwatch : benchmark, StopWatch;
import std.file;
import std.stdio;
import std.string;

import parser.expression;
import parser.expressions;
import parser.statements;

import func;
import globals;
import value;

// Functions

final class Date__Now_ : Func {
	this(string ns="") { super(ns ~ "dateNow","get current date into string",[[]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		SysTime now = Clock.currTime();

		auto date = cast(Date)(now);
		auto dateStr = date.toISOExtString();

		return new Value(dateStr);
	}
}

final class DateTime__Now_ : Func {
	this(string ns="") { super(ns ~ "datetimeNow","get current date and time into string",[[]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		SysTime now = Clock.currTime();

		auto datetime = now;
		auto datetimeStr = datetime.toISOExtString();

		return new Value(datetimeStr);
	}
}

final class Day_ : Func {
	this(string ns="") { super(ns ~ "day","get day from date string",[[sV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		try {
			auto date = Date.fromISOExtString(input);
			auto ret = to!string(date.dayOfWeek);

			return new Value(ret);
		}
		catch (Exception ex) {
			auto datetime = SysTime.fromISOExtString(input);
			auto ret = to!string(datetime.dayOfWeek);

			return new Value(ret);
		}
	}
}

final class Month_ : Func {
	this(string ns="") { super(ns ~ "month","get month from date string",[[sV]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias input = S!(v,0);
		try {
			auto date = Date.fromISOExtString(input);
			auto ret = to!string(date.month);

			return new Value(ret);
		}
		catch (Exception ex) {
			auto datetime = SysTime.fromISOExtString(input);
			auto ret = to!string(datetime.month);

			return new Value(ret);
		}
	}
}

final class Time__Now_ : Func {
	this(string ns="") { super(ns ~ "timeNow","get current time into string",[[]],[sV]); }
	override Value execute(Expressions ex, string hId=null) {
		SysTime now = Clock.currTime();

		auto time = cast(TimeOfDay)now;
		auto timeStr = time.toISOExtString();

		return new Value(timeStr);
	}
}

final class Timer_ : Func {
	this(string ns="") { super(ns ~ "timer","time the execution of a given function in milliseconds",[[fV]],[nV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias func = F!(v,0);

		StopWatch sw;

		sw.start();
		func.execute();
		sw.stop();

		TickDuration duration = cast(TickDuration)sw.peek();
		long ret = duration.msecs;
		//ret = ret.msecs;

		return new Value(ret);
	}
}
