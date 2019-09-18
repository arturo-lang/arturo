/************************************************
 * Arturo
 * 
 * The Minimal Declarative-Like Language
 * (c) 2019 Ioannis Zafeiropoulos
 *
 * @file: art/date.d
 ************************************************/

module art.date;

// Imports

import std.algorithm;
import std.conv;
import std.datetime;
import std.file;
import std.stdio;
import std.string;

import parser.expression;
import parser.expressions;
import parser.statements;

import value;

import func;
import globals;

class Date__Now_ : Func {
	this() { super("date.now","get current date into string",[[]],[sV]); }
	override Value execute(Expressions ex) {
		SysTime now = Clock.currTime();

		auto date = cast(Date)(now);
		auto dateStr = date.toISOExtString();

		return new Value(dateStr);
	}
}

class Time__Now_ : Func {
	this() { super("time.now","get current time into string",[[]],[sV]); }
	override Value execute(Expressions ex) {
		SysTime now = Clock.currTime();

		auto time = cast(TimeOfDay)now;
		auto timeStr = time.toISOExtString();

		return new Value(timeStr);
	}
}

class DateTime__Now_ : Func {
	this() { super("datetime.now","get current date and time into string",[[]],[sV]); }
	override Value execute(Expressions ex) {
		SysTime now = Clock.currTime();

		auto datetime = now;
		auto datetimeStr = datetime.toISOExtString();

		return new Value(datetimeStr);
	}
}

class Day_ : Func {
	this() { super("day","get day from date string",[[sV]],[sV]); }
	override Value execute(Expressions ex) {
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

class Month_ : Func {
	this() { super("month","get month from date string",[[sV]],[sV]); }
	override Value execute(Expressions ex) {
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