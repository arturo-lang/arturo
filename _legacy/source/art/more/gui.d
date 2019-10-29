/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/gui.d
 *****************************************************************/

module art.gui;

version(GTK) {

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

	import gobject.ObjectG;

	import gtk.Application;
	import gio.Application : GioApplication = Application;
	import gtk.ApplicationWindow;
	import gtk.Box;
	import gtk.Button;
	import gtk.CheckButton;
	import gtk.Container;
	import gtk.Entry;
	import gtk.Frame;
	import gtk.HBox;
	import gtk.HPaned;
	import gtk.Label;
	import gtk.Notebook;
	import gtk.Paned;
	import gtk.VBox;
	import gtk.VPaned;
	import gtk.Widget;

	import parser.expression;
	import parser.expressions;
	import parser.statements;

	import func;
	import globals;
	import panic;
	import value;

	// Constants

	enum GUI_APP_PREFIX								= "io.arturo-lang.app.";

	enum _ID										= "_id";
	enum _TYPE                                      = "_type";
	enum _OBJECT                                   	= "_object";

	enum _APPID										= ":appId";
	enum _EDITABLE									= ":editable";
	enum _JUSTIFY									= ":justify";
	enum _RESIZABLE									= ":resizable";
	enum _SELECTABLE 								= ":selectable";
	enum _SIZE 										= ":size";
	enum _TITLE										= ":title";
	enum _WINDOW 									= ":window";

	enum _EVENT_ONCLICK								= ":onClick";
	enum _EVENT_ONPRESSED							= ":onPressed";
	enum _EVENT_ONRELEASED							= ":onReleased";

	// Aliases

	void WARN_PARAM(string prm, string val) { Panic.runtimeWarning((new WARN_ErroneousParameterValueIgnored(prm, val)).msg); }

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

	Widget processCheckbox(Value obj) {
		// create the checkbox
		CheckButton checkbox = new CheckButton(obj[_TITLE].content.s);	
		obj[_OBJECT] = new Value(checkbox);

		// process properties
		if (obj.hasKey(_EVENT_ONCLICK, [fV])) {
			checkbox.addOnClicked(delegate void(Button b) {
				obj[_EVENT_ONCLICK].content.f.execute();
			});
		}

		return cast(Widget)checkbox;
	}


	Widget processFrame(Value obj) {
		// create the frame
		Frame frame = new Frame(obj[_TITLE].content.s);
		obj[_OBJECT] = new Value(frame);
		
		// process properties

		// process children
		processChildrenNodes(frame,obj[CHILDREN].content.a);

		return cast(Widget)frame;
	}

	Widget processHBox(Value obj) {
		// create the HBox
		HBox hbox = new HBox(true,20);
		obj[_OBJECT] = new Value(hbox);

		// process children
		processChildrenNodes(hbox,obj[CHILDREN].content.a);
		
		return cast(Widget)hbox;
	}

	Widget processHPane(Value obj) {
		// create the HPaned
		HPaned hpane = new HPaned();
		obj[_OBJECT] = new Value(hpane);

		// process children
		processChildrenNodes(hpane,obj[CHILDREN].content.a);
		
		return cast(Widget)hpane;
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
				default: WARN_PARAM(_JUSTIFY, obj[_JUSTIFY].content.s);
			}
		}

		if (obj.hasKey(_SELECTABLE,[bV])) { 
			label.setSelectable(obj[_SELECTABLE].content.b);
		}

		return cast(Widget)label;
	}

	Widget processTabs(Value obj) {
		// create the Notebook
		Notebook tabs = new Notebook();
		obj[_OBJECT] = new Value(tabs);

		// process children
		processChildrenNodes(tabs,obj[CHILDREN].content.a);
		
		return cast(Widget)tabs;
	}

	Widget processTextfield(Value obj) {
		// create the button
		Entry textfield = new Entry(obj[_TITLE].content.s);	
		obj[_OBJECT] = new Value(textfield);

		// process properties
		if (obj.hasKey(_EDITABLE,[bV])) { 
			textfield.setEditable(obj[_EDITABLE].content.b);
		}

		return cast(Widget)textfield;
	}

	Widget processVBox(Value obj) {
		// create the VBox
		VBox vbox = new VBox(true,20);
		obj[_OBJECT] = new Value(vbox);

		// process children
		processChildrenNodes(vbox,obj[CHILDREN].content.a);
		
		return cast(Widget)vbox;
	}

	Widget processVPane(Value obj) {
		// create the VPaned
		VPaned vpane = new VPaned();
		obj[_OBJECT] = new Value(vpane);

		// process children
		processChildrenNodes(vpane,obj[CHILDREN].content.a);
		
		return cast(Widget)vpane;
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
		foreach (i, Value child; children) {
			Widget wdgt;

			switch (child[_TYPE].content.s) {
				case "button": wdgt = processButton(child); break;
				case "checkbox": wdgt = processCheckbox(child); break;
				case "textfield": wdgt = processTextfield(child); break;
				case "frame": wdgt = processFrame(child); break;
				case "hbox": wdgt = processHBox(child); break;
				case "hpane": wdgt = processHPane(child); break;
				case "label": wdgt = processLabel(child); break;
				case "tabs": wdgt = processTabs(child); break;
				case "vbox": wdgt = processVBox(child); break;
				case "vpane": wdgt = processVPane(child); break;
				default: wdgt = null;
			}

			if (wdgt !is null) {
				if (cast(Box)cont !is null) {
					(cast(Box)cont).packStart(wdgt,true,true,0);
				}
				else if (cast(Paned)cont !is null) {
					if (i==0) (cast(Paned)cont).pack1(wdgt,true,false);
					else if (i==1) (cast(Paned)cont).pack2(wdgt,true,false);
					else {
						WARN_PARAM(CHILDREN, ">2 children");
					}
				}
				else if (cast(Notebook)cont !is null) {
					string tabTitle = "";
					if (child.hasKey(_TITLE,[sV])) { 
						tabTitle = child[_TITLE].content.s;
					}

					(cast(Notebook)cont).appendPage(wdgt,tabTitle);
				}
				else {
					cont.add(wdgt);
				}
			}
		}
	}

	// Functions

	final class Gui__App_ : Func {
		this(string ns="") { super(ns ~ "app","create GUI app with given string ID, main window and configuration",[[sV,dV,dV]],[nV]); }
		override Value execute(Expressions ex, string hId=null) {
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

	final class Gui__Button_ : Func {
		this(string ns="") { super(ns ~ "button","create GUI button with given title and configuration",[[sV,dV]],[dV]); }
		override Value execute(Expressions ex, string hId=null) {
			Value[] v = validate(ex);
			alias title = S!(v,0);
			Value config = v[1];

			mixin(initObject("Button","button"));

			// setup object

			obj[_TITLE] = new Value(title);

			return obj;
		}
	}

	final class Gui__Checkbox_ : Func {
		this(string ns="") { super(ns ~ "checkbox","create GUI checkbox with given title and configuration",[[sV,dV]],[dV]); }
		override Value execute(Expressions ex, string hId=null) {
			Value[] v = validate(ex);
			alias title = S!(v,0);
			Value config = v[1];

			mixin(initObject("CheckButton","checkbox"));

			// setup object

			obj[_TITLE] = new Value(title);

			obj["get"] = new Value(new Func((Value vs){ 
				bool ret = (cast(CheckButton)(obj["_object"].content.go)).getActive(); 
				return new Value(ret); 
			}));

			obj["set"] = new Value(new Func((Value vs){ 
				(cast(CheckButton)(obj["_object"].content.go)).setActive(vs.content.a[0].content.b); 
				return NULLV; 
			}));

			return obj;
		}
	}

	final class Gui__Frame_ : Func {
		this(string ns="") { super(ns ~ "frame","create GUI frame with given title and configuration",[[sV,dV]],[dV]); }
		override Value execute(Expressions ex, string hId=null) {
			Value[] v = validate(ex);
			alias title = S!(v,0);
			Value config = v[1];

			mixin(initObject("Frame","frame"));

			// setup object

			obj[_TITLE] = new Value(title);

			return obj;
		}
	}


	final class Gui__Hbox_ : Func {
		this(string ns="") { super(ns ~ "hbox","create GUI horizontal box with given configuration",[[dV]],[dV]); }
		override Value execute(Expressions ex, string hId=null) {
			Value[] v = validate(ex);
			Value config = v[0];

			mixin(initObject("HBox","hbox"));

			// setup object

			return obj;
		}
	}

	final class Gui__Hpane_ : Func {
		this(string ns="") { super(ns ~ "hpane","create GUI horizontal pane with given configuration",[[dV]],[dV]); }
		override Value execute(Expressions ex, string hId=null) {
			Value[] v = validate(ex);
			Value config = v[0];

			mixin(initObject("HPaned","hpane"));

			// setup object

			return obj;
		}
	}

	final class Gui__Label_ : Func {
		this(string ns="") { super(ns ~ "label","create GUI label with given title and configuration",[[sV,dV]],[dV]); }
		override Value execute(Expressions ex, string hId=null) {
			Value[] v = validate(ex);
			alias title = S!(v,0);
			Value config = v[1];

			mixin(initObject("Label","label"));

			// setup object

			obj[_TITLE] = new Value(title);

			obj["get"] = new Value(new Func((Value vs){ 
				string ret = (cast(Label)(obj["_object"].content.go)).getText(); 
				return new Value(ret); 
			}));

			obj["set"] = new Value(new Func((Value vs){ 
				(cast(Label)(obj["_object"].content.go)).setMarkup(vs.content.a[0].content.s); 
				return NULLV; 
			}));

			return obj;
		}
	}

	final class Gui__Tabs_ : Func {
		this(string ns="") { super(ns ~ "tabs","create GUI tabbed view with given configuration",[[dV]],[dV]); }
		override Value execute(Expressions ex, string hId=null) {
			Value[] v = validate(ex);
			Value config = v[0];

			mixin(initObject("Notebook","tabs"));

			// setup object

			return obj;
		}
	}

	final class Gui__Textfield_ : Func {
		this(string ns="") { super(ns ~ "textfield","create GUI textfield with given title and configuration",[[sV,dV]],[dV]); }
		override Value execute(Expressions ex, string hId=null) {
			Value[] v = validate(ex);
			alias title = S!(v,0);
			Value config = v[1];

			mixin(initObject("Entry","textfield"));

			// setup object

			obj[_TITLE] = new Value(title);

			obj["get"] = new Value(new Func((Value vs){ 
				string ret = (cast(Entry)(obj["_object"].content.go)).getText(); 
				return new Value(ret); 
			}));

			obj["set"] = new Value(new Func((Value vs){ 
				(cast(Entry)(obj["_object"].content.go)).setText(vs.content.a[0].content.s); 
				return NULLV; 
			}));

			return obj;
		}
	}

	final class Gui__Vbox_ : Func {
		this(string ns="") { super(ns ~ "vbox","create GUI vertical box with given configuration",[[dV]],[dV]); }
		override Value execute(Expressions ex, string hId=null) {
			Value[] v = validate(ex);
			Value config = v[0];

			mixin(initObject("VBox","vbox"));

			// setup object

			return obj;
		}
	}

	final class Gui__Vpane_ : Func {
		this(string ns="") { super(ns ~ "vpane","create GUI vertical pane with given configuration",[[dV]],[dV]); }
		override Value execute(Expressions ex, string hId=null) {
			Value[] v = validate(ex);
			Value config = v[0];

			mixin(initObject("VPaned","vpane"));

			// setup object

			return obj;
		}
	}

	final class Gui__Window_ : Func {
		this(string ns="") { super(ns ~ "window","create GUI window for given app and configuration",[[dV]],[dV]); }
		override Value execute(Expressions ex, string hId=null) {
			Value[] v = validate(ex);
			Value config = v[0];

			mixin(initObject("ApplicationWindow","window"));

			// setup object

			obj["close"] = new Value(new Func((Value vs){ 
				(cast(ApplicationWindow)(obj["_object"].content.go)).close(); 
				return NULLV; 
			}));

			obj["show"] = new Value(new Func((Value vs){ 
				return processWindow(obj, cast(Application)vs.content.a[0]["_object"].content.go);
			}));

			return obj;
		}
	}
}