/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/gui.d
 *****************************************************************/

module art.gui;

// Imports

import core.thread;

import std.algorithm;
import std.array;
import std.ascii;
import std.conv;
import std.file;
import std.random;
import std.regex;
import std.stdio;
import std.string;
import std.uuid;

import parser.expression;
import parser.expressions;
import parser.statements;

import value;

import func;
import globals;

import tkd.tkdapplication;
import helpers.tk;

// Functions

class Show__Window_ : Func {
	this(string ns="") { super(ns ~ "showWindow","show GUI window using configuration",[[dV]],[]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Value config = v[0];
		Value input;
		//new Thread({

		auto app = new Application();

		if ((input=config.getValueFromDict(":title")) !is null) {
			app.mainWindow.setTitle(S!(input));
		}
		
		if ((input=config.getValueFromDict(":fullscreen")) !is null) {
			app.mainWindow.setFullscreen(B!(input));
		}/*
		if ((input=config.getValueFromDict(":topmost")) !is null) {
			app.mainWindow.setTopmost(B!(input));
		}*/
		if ((input=config.getValueFromDict(":geometry")) !is null) {
			app.mainWindow.setGeometry(II!(A!(input),0),II!(A!(input),1),II!(A!(input),2),II!(A!(input),3));
		}

		auto frame = new Frame(app.mainWindow, 5, ReliefStyle.groove)    // Create a frame.
			.pack(10); 
		auto label = new Label(frame, "Hello Arturo!").pack(100);

		//app.run();*/

		//auto app = new Application();
		//app.mainWindow.setTitle("Worked!").setGeometry(500,200,100,100).setMinSize(500,200);
		//auto frame = new Frame(5, ReliefStyle.groove)    // Create a frame.
		//	.pack(10);    
	//auto label = new Label(frame, "Hello Arturo!")    // Create a label.
	//		.pack(100); 
	app.run();
    // Codes to run in the newly created thread.
//}).start();
		return new Value();
	}
}
