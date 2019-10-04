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

Widget processChildNode(Value child) {
	writeln("CHILD: HERE");
	if (child["_type"].content.s=="button") {
		writeln("CHILD(button): HERE");
			
			//writeln("it's a button");
			//writeln(&child["onClick"].content.f);
			Button butt = new Button(child["text"].content.s);
			writeln("CHILD(button): HERE");
			//writeln("BUTT:");
			//writeln(cast(void*)butt);		
			butt.addOnClicked(delegate void(Button b) {
				writeln(cast(void*)b);
				writeln(&child[":onClick"].content.f);
				child[":onClick"].content.f.execute();
			});
			writeln("CHILD(button): HERE");
			child["_object"] = new Value(butt);
			writeln("CHILD(button): HERE");
			//writeln("FUNC:");
			//writeln(&child["onClick"].content.f);
			//writeln(&butt);
			return cast(Widget)butt;
		}
		else if (child["_type"].content.s=="vbox") {
			writeln("CHILD(vbox): HERE");
			VBox vbox = new VBox(true,20);
writeln("CHILD(vbox): HERE");
			processChildrenNodes(vbox,child[CHILDREN].content.a);
			writeln("CHILD(vbox): HERE");
			child["_object"] = new Value(vbox);
			writeln("CHILD(vbox): HERE");
			return cast(Widget)vbox;
			//cont.add(cast(VBox)child["_object"].content.go);
		}
		return null;
}

void processChildrenNodes(Container cont, Value[] children) {
	foreach (Value child; children) {
		writeln("processing child: " ~ child.stringify());
		cont.add(processChildNode(child));
	}
}

Value showWindow(Value obj, Application app) {
	// create the window
	writeln("HERE");
	ApplicationWindow window = new ApplicationWindow(app);
	writeln("HERE");
	obj["_object"] = new Value(window);
	writeln("HERE");
	obj["WORKED"] = new Value("yes!");
	writeln("HERE");
	
	// process properties
	if (":title" in obj) { 
		window.setTitle(obj[":title"].content.s); 
	}
	writeln("HERE");
	if (":size" in obj) { 
		window.setDefaultSize(to!int(obj[":size"][0].content.i),to!int(obj[":size"][1].content.i)); 
	}
	writeln("HERE");

	// process children nodes
	processChildrenNodes(window, obj[CHILDREN].content.a);

	writeln("HERE");

	// show the window
	window.showAll();

	writeln("HERE");

	return new Value();
}

// Functions
/*
class Gui__App_ : Func {
	this(string ns="") { super(ns ~ "app","create GUI app with given string id and initialization function",[[sV,fV]],[nV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias appId = S!(v,0);
		alias callback = F!(v,1);

		Application app = new Application("io.arturo-lang.app." ~ appId, GApplicationFlags.FLAGS_NONE);

		Value obj = Value.dictionary();

		obj["_type"] = new Value("app");
		obj["_object"] = new Value(app);
		obj["_callback"] = new Value(callback);
		obj["id"] = new Value(appId);

		obj["run"] = new Value(new Func((Value vs){ return new Value(app.run([])); }));

		app.addOnActivate(delegate void(GioApplication appli) { 
			callback.execute(obj);
		});

		return obj;
	}
}*/

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

class Gui__Window_ : Func {
	this(string ns="") { super(ns ~ "window","create GUI window for given app using settings",[[dV]],[dV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Value config = v[0];

		// copy config to new object
		Value obj = new Value(config);
		if (CHILDREN !in obj) obj[CHILDREN] = Value.array();

		// create placeholder item
		ApplicationWindow window;
		obj["_type"] = new Value("window");
		obj["_object"] = new Value(window);

		// setup object

		obj["add"] = new Value(new Func((Value vs){ 
			obj[CHILDREN].addValueToArray(vs.content.a[0]);
			return new Value();
		}));

		obj["close"] = new Value(new Func((Value vs){ 
			(cast(ApplicationWindow)(obj["_object"].content.go)).close(); 
			return new Value(); }));

		obj["show"] = new Value(new Func((Value vs){ 
			return showWindow(obj, cast(Application)vs.content.a[0]["_object"].content.go);
		}));

		return obj;
	}
}

class Gui__Button_ : Func {
	this(string ns="") { super(ns ~ "button","create GUI button with given label using settings",[[sV,dV]],[dV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias text = S!(v,0);
		Value config = v[1];

		// copy config to new object
		Value obj = new Value(config);
		if (CHILDREN !in obj) obj[CHILDREN] = Value.array();

		// create placeholder item
		Button button;
		obj["_type"] = new Value("button");
		obj["_object"] = new Value(button);

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

		// copy config to new object
		Value obj = new Value(config);
		if (CHILDREN !in obj) obj[CHILDREN] = Value.array();

		// create placeholder item
		VBox vbox;
		obj["_type"] = new Value("vbox");
		obj["_object"] = new Value(vbox);

		// setup object

		obj["add"] = new Value(new Func((Value vs){ 
			obj[CHILDREN].addValueToArray(vs.content.a[0]);
			return new Value();
		}));

		return obj;
	}
}