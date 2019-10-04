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

Widget processChild(Value child) {
	if (child["_type"].content.s=="button") {
			
			//writeln("it's a button");
			//writeln(&child["onClick"].content.f);
			Button butt = new Button(child["text"].content.s);
			//writeln("BUTT:");
			//writeln(cast(void*)butt);		
			butt.addOnClicked(delegate void(Button b) {
				//writeln(cast(void*)b);
				//writeln(&child["onClick"].content.f);
				child["onClick"].content.f.execute();
			});
			child["_object"] = new Value(butt);
			//writeln("FUNC:");
			//writeln(&child["onClick"].content.f);
			//writeln(&butt);
			return cast(Widget)butt;
		}
		else if (child["_type"].content.s=="vbox") {
			VBox vbox = new VBox(true,20);

			addChildren(vbox,child["children"].content.a);
			
			child["_object"] = new Value(vbox);
			return cast(Widget)vbox;
			//cont.add(cast(VBox)child["_object"].content.go);
		}
		return null;
}

void addChildren(Container cont, Value[] children) {
	foreach (Value child; children) {
		writeln("processing child: " ~ child.stringify());
		cont.add(processChild(child));
	}
}

class Gui__Window_ : Func {
	this(string ns="") { super(ns ~ "window","create GUI window for given app using settings",[[dV]],[dV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		//Value app = v[0];
		Value setup = v[0];

		Value obj = Value.dictionary();

		ApplicationWindow window;// = new ApplicationWindow(cast(Application)app["_object"].content.go);
		obj["_type"] = new Value("window");
		obj["_object"] = new Value(window);

		if ("_" in setup) {
			obj["_"] = setup["_"];
		}

		if (":title" in setup) { 
			obj["title"] = setup[":title"]; 
			//window.setTitle(setup[":title"].content.s); 
		}

		if (":size" in setup) { 
			obj["size"] = setup[":size"]; 
			//window.setDefaultSize(to!int(setup[":size"][0].content.i),to!int(setup[":size"][1].content.i)); 
		}

		if (":children" in setup) { 
			obj["children"] = setup[":children"]; 
		}
		else {
			obj["children"] = new Value(cast(Value[])[]);
		}

		obj["add"] = new Value(new Func((Value vs){ 
			obj["children"].addValueToArray(vs.content.a[0]);
			return new Value();
			//auto e = cast(Widget)vs.content.a[0]["_object"].content.go;
			//window.add(e);
			//return new Value();
		}));
		//obj["show"] = new Value(new Func((Value vs){ (cast(ApplicationWindow)obj["_object"]).showAll(); return new Value(); }));

		obj["close"] = new Value(new Func((Value vs){ writeln("closing mainWindow"); (cast(ApplicationWindow)(obj["_object"].content.go)).close(); writeln("closed window"); return new Value(); }));

		obj["show"] = new Value(new Func((Value vs){ 

			window = new ApplicationWindow(cast(Application)vs.content.a[0]["_object"].content.go);
			obj["_object"] = new Value(window);
			if ("title" in obj) { window.setTitle(obj["title"].content.s); }
			if ("size" in obj) { window.setDefaultSize(to!int(obj["size"][0].content.i),to!int(obj["size"][1].content.i)); }

			//writeln("adding children");
			addChildren(window, obj["children"].content.a);
			/*
			foreach (Value child; obj["children"].content.a) {
				writeln("processing child: " ~ child.stringify());
				if (child["_type"].content.s=="button") {
					Button butt = new Button(child["text"].content.s);
					
					butt.addOnClicked(delegate void(Button b) {
						child["onClick"].content.f.execute();
					});
					child["_object"] = new Value(butt);
					window.add(cast(Button)child["_object"].content.go);
				}
				else if (child["_type"].content.s=="vbox") {
					VBox vbox = new VBox(true,20);

					foreach (Value subchild; child["children"].content.a) {
						//add them somehow (external function?)
					}

					child["_object"] = new Value(vbox);
					window.add(cast(VBox)child["_object"].content.go);
				}
			}*/

			window.showAll();
			return new Value();
		}));

		return obj;
	}
}

class Gui__Button_ : Func {
	this(string ns="") { super(ns ~ "button","create GUI button with given label using settings",[[sV,dV]],[dV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias text = S!(v,0);
		Value setup = v[1];

		Value obj = Value.dictionary();

		Button button;// = new Button(text);

		obj["_type"] = new Value("button");
		obj["_object"] = new Value(button);
		obj["text"] = new Value(text);

		if (":onClick" in setup) { 
			obj["onClick"] = setup[":onClick"]; 
			//button.addOnClicked(delegate void(Button b) {
			//	obj["onClick"].content.f.execute();
			//}
			//);
		}

		return obj;
	}
}

class Gui__Vbox_ : Func {
	this(string ns="") { super(ns ~ "vbox","show GUI window for given app using settings",[[dV]],[dV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Value setup = v[0];

		Value obj = Value.dictionary();

		VBox box;// = new VBox(true,20);

		obj["_type"] = new Value("vbox");
		obj["_object"] = new Value(box);
		if (":children" in setup) { 
			obj["children"] = setup[":children"]; 
		}
		else {
			obj["children"] = new Value(cast(Value[])[]);
		}
		obj["add"] = new Value(new Func((Value vs){ 
			obj["children"].addValueToArray(vs.content.a[0]);
			return new Value();
			//auto e = cast(Widget)vs.content.a[0]["_object"].content.go;
			//box.packStart(e,true,true,20);
			//return new Value();
		}));

		return obj;
	}
}