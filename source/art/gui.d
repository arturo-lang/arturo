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
import std.variant;

import parser.expression;
import parser.expressions;
import parser.statements;

import value;

import func;
import globals;

import gobject.ObjectG;

import gtk.Application;
import gio.Application : GioApplication = Application;
import gtk.ApplicationWindow;
import gtk.Button;
import gtk.Container;
import gtk.Entry;
import gtk.HBox;
import gtk.Label;
import gtk.VBox;
import gtk.Widget;

// Utilities

string initObject(string objectClass, string objectType) {
	return "
	// copy config to new object
	Value obj = new Value(config);
	if (CHILDREN !in obj) obj[CHILDREN] = Value.array();

	// create placeholder item
	" ~ objectClass ~ " " ~ objectType ~ ";
	obj[\"_type\"] = new Value(\"" ~ objectType ~ "\");
	obj[\"_object\"] = new Value(" ~ objectType ~ ");";
}
/*
Widget processChildNode(Value child) {
	if (child["_type"].content.s=="button") {
		Button butt = new Button(child["text"].content.s);	
		butt.addOnClicked(delegate void(Button b) {
			child[":onClick"].content.f.execute();
		});
		child["_object"] = new Value(butt);
		return cast(Widget)butt;
	}
	else if (child["_type"].content.s=="vbox") {
		VBox vbox = new VBox(true,20);
		processChildrenNodes(vbox,child[CHILDREN].content.a);
		child["_object"] = new Value(vbox);
		return cast(Widget)vbox;
	}
	return null;
}*/

Widget processButton(Value obj) {
	// create the button
	Button button = new Button(obj["text"].content.s);	
	obj["_object"] = new Value(button);

	// process properties
	button.addOnClicked(delegate void(Button b) {
		obj[":onClick"].content.f.execute();
	});

	return cast(Widget)button;
}

Widget processVBox(Value obj) {
	// create the VBox
	VBox vbox = new VBox(true,20);
	obj["_object"] = new Value(vbox);

	// process children
	processChildrenNodes(vbox,obj[CHILDREN].content.a);
	
	return cast(Widget)vbox;
}

void processChildrenNodes(Container cont, Value[] children) {
	foreach (Value child; children) {
		Widget wdgt;

		switch (child["_type"].content.s) {
			case "button": wdgt = processButton(child); break;
			case "vbox": wdgt = processVBox(child); break;
			default: wdgt = null;
		}

		if (wdgt !is null) cont.add(wdgt);
	}
}

Value processWindow(Value obj, Application app) {
	// create the window
	ApplicationWindow window = new ApplicationWindow(app);
	obj["_object"] = new Value(window);
	
	// process properties
	if (":title" in obj) { 
		window.setTitle(obj[":title"].content.s); 
	}
	if (":size" in obj) { 
		window.setDefaultSize(to!int(obj[":size"][0].content.i), to!int(obj[":size"][1].content.i)); 
	}

	// process children
	processChildrenNodes(window, obj[CHILDREN].content.a);

	// show the window
	window.showAll();

	return obj;
}

// Functions

class Gui__App_ : Func {
	this(string ns="") { super(ns ~ "app","create GUI app with given string id and mainWindow",[[sV,dV]],[nV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias appId = S!(v,0);
		Value mainWindow =v[1];

		Application app = new Application("io.arturo-lang.app." ~ appId, GApplicationFlags.FLAGS_NONE);

		Value obj = Value.dictionary();

		obj["_type"] = new Value("app");
		obj["_object"] = new Value(app);
		obj["window"] = mainWindow;
		//obj["_callback"] = new Value(callback);
		obj["id"] = new Value(appId);

		obj["run"] = new Value(new Func((Value vs){ return new Value(app.run([])); }));

		app.addOnActivate(delegate void(GioApplication appli) { 
			//writeln(obj["window"].stringify());
			obj["window"]["show"].content.f.execute(new Value([obj]));
			//callback.execute(obj);
		});

		return new Value(app.run([]));

		//return obj;
	}
}

class Gui__Button_ : Func {
	this(string ns="") { super(ns ~ "button","create GUI button with given label using settings",[[sV,dV]],[dV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias text = S!(v,0);
		Value config = v[1];

		mixin(initObject("Button","button"));

		// setup object

		obj["text"] = new Value(text);

		return obj;
	}
}

class Gui__Vbox_ : Func {
	this(string ns="") { super(ns ~ "vbox","show GUI window for given app using settings",[[dV]],[dV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Value config = v[0];

		mixin(initObject("VBox","vbox"));

		// setup object

		obj["add"] = new Value(new Func((Value vs){ 
			obj[CHILDREN].addValueToArray(vs.content.a[0]);
			return new Value();
		}));

		return obj;
	}
}

class Gui__Window_ : Func {
	this(string ns="") { super(ns ~ "window","create GUI window for given app using settings",[[dV]],[dV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Value config = v[0];

		mixin(initObject("ApplicationWindow","window"));

		// setup object

		obj["add"] = new Value(new Func((Value vs){ 
			obj[CHILDREN].addValueToArray(vs.content.a[0]);
			return new Value();
		}));

		obj["close"] = new Value(new Func((Value vs){ 
			(cast(ApplicationWindow)(obj["_object"].content.go)).close(); 
			return new Value(); }));

		obj["show"] = new Value(new Func((Value vs){ 
			return processWindow(obj, cast(Application)vs.content.a[0]["_object"].content.go);
		}));

		return obj;
	}
}