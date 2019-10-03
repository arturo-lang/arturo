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

class Gui__App_ : Func {
	this(string ns="") { super(ns ~ "app","create GUI app with given string id and initialization function",[[sV,fV]],[nV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias appId = S!(v,0);
		alias callback = F!(v,1);

		Application app = new Application("io.arturo-lang.app." ~ appId, GApplicationFlags.FLAGS_NONE);

		Value obj = Value.dictionary();

		obj["_object"] = new Value(app);
		obj["_callback"] = new Value(callback);
		obj["id"] = new Value(appId);

		obj["run"] = new Value(new Func((Value vs){ return new Value(app.run([])); }));

		app.addOnActivate(delegate void(GioApplication appli) { 
			callback.execute(obj);
		});

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

		Button button = new Button(text);

		obj["_object"] = new Value(button);
		obj["text"] = new Value(text);

		if (":onClick" in setup) { 
			obj["onClick"] = setup[":onClick"]; 
			button.addOnClicked(delegate void(Button b) {
				obj["onClick"].content.f.execute();
			});
		}

		return obj;
	}
}

class Gui__Label_ : Func {
	this(string ns="") { super(ns ~ "label","create GUI label with given caption using settings",[[sV,dV]],[dV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias text = S!(v,0);
		Value setup = v[1];

		Value obj = Value.dictionary();

		Label label = new Label(text);
		label.setMarkup(text);

		obj["_object"] = new Value(label);
		obj["text"] = new Value(text);

		return obj;
	}
}

class Gui__Field_ : Func {
	this(string ns="") { super(ns ~ "field","create GUI field with given caption using settings",[[sV,dV]],[dV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias text = S!(v,0);
		Value setup = v[1];

		Value obj = Value.dictionary();

		Entry entry = new Entry(text);

		obj["_object"] = new Value(entry);
		obj["text"] = new Value(new Func((Value vs){ return new Value(entry.getText()); }));

		return obj;
	}
}


class Gui__AddToContainer_ : Func {
	this(string ns="") { super(ns ~ "addToContainer","add GUI element to given container",[[dV,dV]],[]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Value elem = v[0];
		Value container = v[1];

		auto c = cast(Container)container["_object"].content.go;
		auto e = cast(Widget)elem["_object"].content.go;

		if (cast(ApplicationWindow)c !is null) { 
			//writeln("container is window");
			(cast(ApplicationWindow)c).add(e);
		}
		if (cast(VBox)c !is null) { 
			//writeln("container is vbox");
			(cast(VBox)c).packStart(e,true,true,10);
		}
		if (cast(HBox)c !is null) { 
			//writeln("container is vbox");
			(cast(HBox)c).packStart(e,true,true,10);
		}

		return new Value();
	}
}

class Gui__Window_ : Func {
	this(string ns="") { super(ns ~ "window","create GUI window for given app using settings",[[dV,dV]],[dV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Value app = v[0];
		Value setup = v[1];

		Value obj = Value.dictionary();

		ApplicationWindow window = new ApplicationWindow(cast(Application)app["_object"].content.go);
		obj["_object"] = new Value(window);

		if (":title" in setup) { 
			obj["title"] = setup[":title"]; 
			window.setTitle(setup[":title"].content.s); 
		}

		if (":size" in setup) { 
			obj["size"] = setup[":size"]; 
			window.setDefaultSize(to!int(setup[":size"][0].content.i),to!int(setup[":size"][1].content.i)); 
		}

		obj["add"] = new Value(new Func((Value vs){ 
			auto e = cast(Widget)vs.content.a[0]["_object"].content.go;
			window.add(e);
			return new Value();
		}));
		obj["show"] = new Value(new Func((Value vs){ window.showAll(); return new Value(); }));

		return obj;
	}
}

class Gui__Vbox_ : Func {
	this(string ns="") { super(ns ~ "vbox","show GUI window for given app using settings",[[]],[dV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		Value obj = Value.dictionary();

		VBox box = new VBox(true,20);

		obj["_object"] = new Value(box);
		obj["add"] = new Value(new Func((Value vs){ 
			auto e = cast(Widget)vs.content.a[0]["_object"].content.go;
			box.packStart(e,true,true,20);
			return new Value();
		}));

		return obj;
	}
}

class Gui__Hbox_ : Func {
	this(string ns="") { super(ns ~ "hbox","show GUI window for given app using settings",[[]],[dV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);

		Value obj = Value.dictionary();

		HBox box = new HBox(true,10);

		obj["_object"] = new Value(box);
		obj["add"] = new Value(new Func((Value vs){ 
			auto e = cast(Widget)vs.content.a[0]["_object"].content.go;
			box.packStart(e,true,true,10);
			return new Value();
		}));

		return obj;
	}
}


/*

class GUI__Start_ : Func {
	this(string ns="") { super(ns ~ "app","start GUI mode with given string id",[[sV,fV]],[oV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias appId = S!(v,0);
		alias func = F!(v,1);

		ObjectG og;

		Application app = new Application("io.arturo-lang.app."~appId, GApplicationFlags.FLAGS_NONE);

		Value ret = new Value(app);

		app.addOnActivate(delegate void(GioApplication appli) { 
			func.execute(ret);
		});

		return ret;
	}
}

class GUI__Run_ : Func {
	this(string ns="") { super(ns ~ "run","run GUI app",[[goV]],[nV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Application guiApp = cast(Application)v[0].content.go;
		
		return new Value(guiApp.run([]));
	}
}

class GUI__Window_ : Func {
	this(string ns="") { super(ns ~ "window","create GUI window",[[goV,dV]],[goV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Application guiApp = cast(Application)v[0].content.go;
		Value config = v[1];

		auto window = new ApplicationWindow(guiApp);
		window.setTitle(config.getValueFromDict(":title").content.s);
		window.setDefaultSize(to!int(config.getValueFromDict(":size").content.a[0].content.i), to!int(config.getValueFromDict(":size").content.a[1].content.i));
		
		return new Value(window);
		
		//return new Value(guiApp.run([]));
	}
}

class GUI__ShowWindow_ : Func {
	this(string ns="") { super(ns ~ "show","create GUI window",[[goV]],[]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		ApplicationWindow win = cast(ApplicationWindow)v[0].content.go;

		win.showAll();
		
		return new Value();
		
		//return new Value(guiApp.run([]));
	}
}*/
/*
class Label_ : Func {
	this(string ns="") { super(ns ~ "label","get GUI label using configuration",[[dV]],[]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Value config = v[0];
		Value input;
		//new Thread({

		auto app = new Application();

		Window win = new Window();

		if ((input=config.getValueFromDict(":title")) !is null) {
			win.setTitle(S!(input));
		}
		
		if ((input=config.getValueFromDict(":fullscreen")) !is null) {
			win.setFullscreen(B!(input));
		}
		if ((input=config.getValueFromDict(":geometry")) !is null) {
			win.setGeometry(II!(A!(input),0),II!(A!(input),1),II!(A!(input),2),II!(A!(input),3));
		}

		auto frame = new Frame(win, 5, ReliefStyle.groove)    // Create a frame.
			.pack(10); 
		auto label = new Label(frame, "Hello Arturo!").pack(100);

		//app.run();

		//auto app = new Application();
		//app.mainWindow.setTitle("Worked!").setGeometry(500,200,100,100).setMinSize(500,200);
		//auto frame = new Frame(5, ReliefStyle.groove)    // Create a frame.
		//	.pack(10);    
	//auto label = new Label(frame, "Hello Arturo!")    // Create a label.
	//		.pack(100); 
	//app.run();
    // Codes to run in the newly created thread.
//}).start();
		return new Value(cast(Variant)win);
	}
}

class Window_ : Func {
	this(string ns="") { super(ns ~ "window","get GUI window using configuration",[[dV]],[]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Value config = v[0];
		Value input;
		//new Thread({

		auto app = new Application();

		Window win = new Window();

		if ((input=config.getValueFromDict(":title")) !is null) {
			win.setTitle(S!(input));
		}
		
		if ((input=config.getValueFromDict(":fullscreen")) !is null) {
			win.setFullscreen(B!(input));
		}
		if ((input=config.getValueFromDict(":geometry")) !is null) {
			win.setGeometry(II!(A!(input),0),II!(A!(input),1),II!(A!(input),2),II!(A!(input),3));
		}

		auto frame = new Frame(win, 5, ReliefStyle.groove)    // Create a frame.
			.pack(10); 
		auto label = new Label(frame, "Hello Arturo!").pack(100);

		//app.run();

		//auto app = new Application();
		//app.mainWindow.setTitle("Worked!").setGeometry(500,200,100,100).setMinSize(500,200);
		//auto frame = new Frame(5, ReliefStyle.groove)    // Create a frame.
		//	.pack(10);    
	//auto label = new Label(frame, "Hello Arturo!")    // Create a label.
	//		.pack(100); 
	//app.run();
    // Codes to run in the newly created thread.
//}).start();
		return new Value(cast(Variant)win);
	}
}


class Start__Gui_ : Func {
	this(string ns="") { super(ns ~ "startGui","start GUI using window",[[oV]],[]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias window = O!(v,0);

		auto app = new Application();

		app.mainWindow = window.get!(Window);

		app.run();

		return new Value();
	}
}*/
