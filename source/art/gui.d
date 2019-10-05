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

import panic;

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

// Constants

enum GUI_APP_PREFIX								= "io.arturo-lang.app.";

enum _ID										= "_id";
enum _TYPE                                      = "_type";
enum _OBJECT                                   	= "_object";

enum _APPID										= ":appId";
enum _JUSTIFY									= ":justify";
enum _RESIZABLE									= ":resizable";
enum _SIZE 										= ":size";
enum _TITLE										= ":title";
enum _WINDOW 									= ":window";

enum _EVENT_ONCLICK								= ":onClick";
enum _EVENT_ONPRESSED							= ":onPressed";
enum _EVENT_ONRELEASED							= ":onReleased";

// Utilities

string getUUID() {
    Xorshift192 gen;

    gen.seed(unpredictableSeed);
    auto genUuid = randomUUID(gen);

    return genUuid.toString();
}

// Mixins

string initObject(string objectClass, string objectType) {
	return "
	// copy config to new object
	Value obj = new Value(config);
	if (CHILDREN !in obj) obj[CHILDREN] = Value.array();

	// create placeholder item
	" ~ objectClass ~ " " ~ objectType ~ ";
	obj[\"" ~ _ID ~ "\"] = new Value(getUUID());
	obj[\"" ~ _TYPE ~ "\"] = new Value(\"" ~ objectType ~ "\");
	obj[\"" ~ _OBJECT ~ "\"] = new Value(" ~ objectType ~ ");";
}

// Utilities

void verifyObjectType(string func,Value dict, string type) {
	if (_TYPE !in dict) 
		throw new ERR_ErroneousObjectTypeError(func,type,"null");
	
	if (dict[_TYPE].content.s!=type)
		throw new ERR_ErroneousObjectTypeError(func,type,dict[_TYPE].content.s);
}

Value processApp(Value obj) {
	// create the application
	Application app = new Application(GUI_APP_PREFIX ~ obj[_APPID].content.s, GApplicationFlags.FLAGS_NONE);
	obj[_OBJECT] = new Value(app);

	// process properties

	app.addOnActivate(delegate void(GioApplication a) { 
		obj[_WINDOW]["show"].content.f.execute(new Value([obj]));
	});

	return new Value(app.run([]));
}

Widget processButton(Value obj) {
	// create the button
	Button button = new Button(obj[_TITLE].content.s);	
	obj[_OBJECT] = new Value(button);

	// process properties
	if (obj.hasKey(_EVENT_ONCLICK, [fV])) {
		button.addOnClicked(delegate void(Button b) {
			obj[_EVENT_ONCLICK].content.f.execute();
		});
	}

	if (obj.hasKey(_EVENT_ONPRESSED, [fV])) {
		button.addOnPressed(delegate void(Button b) {
			obj[_EVENT_ONPRESSED].content.f.execute();
		});
	}

	if (obj.hasKey(_EVENT_ONRELEASED, [fV])) {
		button.addOnReleased(delegate void(Button b) {
			obj[_EVENT_ONRELEASED].content.f.execute();
		});
	}

	return cast(Widget)button;
}

Widget processHBox(Value obj) {
	// create the HBox
	HBox hbox = new HBox(true,20);
	obj[_OBJECT] = new Value(hbox);

	// process children
	processChildrenNodes(hbox,obj[CHILDREN].content.a);
	
	return cast(Widget)hbox;
}

Widget processLabel(Value obj) {
	// create the button
	Label label = new Label(obj[_TITLE].content.s);	
	obj[_OBJECT] = new Value(label);

	// process properties
	label.setMarkup(obj[_TITLE].content.s);

	if (obj.hasKey(_JUSTIFY,[sV])) { 
		switch (obj[_JUSTIFY].content.s) {
			case "left": label.setJustify(GtkJustification.LEFT); break;
			case "center": label.setJustify(GtkJustification.CENTER); break;
			case "right": label.setJustify(GtkJustification.RIGHT); break;
			case "fill": label.setJustify(GtkJustification.FILL); break;
			default: Panic.runtimeWarning((new WARN_ErroneousParameterValueIgnored(_JUSTIFY, obj[_JUSTIFY].content.s)).msg); break;
		}
	}

	return cast(Widget)label;
}

Widget processVBox(Value obj) {
	// create the VBox
	VBox vbox = new VBox(true,20);
	obj[_OBJECT] = new Value(vbox);

	// process children
	processChildrenNodes(vbox,obj[CHILDREN].content.a);
	
	return cast(Widget)vbox;
}

Value processWindow(Value obj, Application app) {
	// create the window
	ApplicationWindow window = new ApplicationWindow(app);
	obj[_OBJECT] = new Value(window);
	
	// process properties
	if (obj.hasKey(_TITLE,[sV])) { 
		window.setTitle(obj[_TITLE].content.s); 
	}

	if (obj.hasKey(_SIZE,[aV])) { 
		window.setDefaultSize(to!int(obj[_SIZE][0].content.i), to!int(obj[_SIZE][1].content.i)); 
	}

	if (obj.hasKey(_RESIZABLE,[bV])) { 
		window.setResizable(obj[_RESIZABLE].content.b);
	}

	// process children
	processChildrenNodes(window, obj[CHILDREN].content.a);

	// show the window
	window.showAll();

	return obj;
}

/////

void processChildrenNodes(Container cont, Value[] children) {
	foreach (Value child; children) {
		Widget wdgt;

		switch (child[_TYPE].content.s) {
			case "button": wdgt = processButton(child); break;
			case "hbox": wdgt = processHBox(child); break;
			case "label": wdgt = processLabel(child); break;
			case "vbox": wdgt = processVBox(child); break;
			default: wdgt = null;
		}

		if (wdgt !is null) cont.add(wdgt);
	}
}

// Functions

class Gui__App_ : Func {
	this(string ns="") { super(ns ~ "app","create GUI app with given string ID, main window and configuration",[[sV,dV,dV]],[nV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias appId = S!(v,0);
		Value mainWindow =v[1];
		Value config = v[2];

		// first verify the object arguments
		verifyObjectType("gui:app",mainWindow,"window");

		mixin(initObject("Application","app"));

		// setup object

		obj[_APPID] = new Value(appId);
		obj[_WINDOW] = mainWindow;

		obj["run"] = new Value(new Func((Value vs){ 
			return processApp(obj);
		}));

		return obj;
	}
}

class Gui__Button_ : Func {
	this(string ns="") { super(ns ~ "button","create GUI button with given title and configuration",[[sV,dV]],[dV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias title = S!(v,0);
		Value config = v[1];

		mixin(initObject("Button","button"));

		// setup object

		obj[_TITLE] = new Value(title);

		return obj;
	}
}

class Gui__Hbox_ : Func {
	this(string ns="") { super(ns ~ "hbox","create GUI horizontal box with given configuration",[[dV]],[dV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Value config = v[0];

		mixin(initObject("HBox","hbox"));

		// setup object

		return obj;
	}
}

class Gui__Label_ : Func {
	this(string ns="") { super(ns ~ "label","create GUI label with given title and configuration",[[sV,dV]],[dV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		alias title = S!(v,0);
		Value config = v[1];

		mixin(initObject("Label","label"));

		// setup object

		obj[_TITLE] = new Value(title);

		return obj;
	}
}

class Gui__Vbox_ : Func {
	this(string ns="") { super(ns ~ "vbox","create GUI vertical box with given configuration",[[dV]],[dV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Value config = v[0];

		mixin(initObject("VBox","vbox"));

		// setup object

		return obj;
	}
}

class Gui__Window_ : Func {
	this(string ns="") { super(ns ~ "window","create GUI window for given app and configuration",[[dV]],[dV]); }
	override Value execute(Expressions ex) {
		Value[] v = validate(ex);
		Value config = v[0];

		mixin(initObject("ApplicationWindow","window"));

		// setup object

		obj["close"] = new Value(new Func((Value vs){ 
			(cast(ApplicationWindow)(obj["_object"].content.go)).close(); 
			return new Value(); 
		}));

		obj["show"] = new Value(new Func((Value vs){ 
			return processWindow(obj, cast(Application)vs.content.a[0]["_object"].content.go);
		}));

		return obj;
	}
}