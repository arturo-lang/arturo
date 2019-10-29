/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/web.d
 *****************************************************************/

module art.web;

// Imports

import std.algorithm;
import std.array;
import std.conv;
import std.net.curl;
import std.stdio;
import std.random;
import std.string;
import std.uuid;

import parser.expressions;

import func;
import globals;
import value;

// Constants

enum _OBJ_ID								= "_id";
enum _OBJ_TYPE                              = "_type";

enum _ID									= ":id";
enum _CLASS									= ":class";
enum _NAME								 	= ":name";
enum _CONTENT								= ":content";
enum _HREF 									= ":href";
enum _TYPE 									= ":type";
enum _TITLE									= ":title";

// Utilities

string getUUID() {
    Xorshift192 gen;

    gen.seed(unpredictableSeed);
    auto genUuid = randomUUID(gen);

    return genUuid.toString();
}

// Mixins

string initObject(string objectType,int configIndex) {
	return "
	Value obj;

	if (v.length>="~ to!string(configIndex) ~ "+1) {
		Value config = v[" ~ to!string(configIndex) ~ "];

		// copy config to new object
		obj = new Value(config);
	} else {
		// create an empty dictionary
		obj = Value.dictionary();
	}

	if (CHILDREN !in obj) obj[CHILDREN] = Value.array();

	// create placeholder item
	if (hId !is null) {
		obj[_ID] = new Value(hId);
	}

	obj[_OBJ_TYPE] = new Value(\"" ~ objectType ~ "\");";
}

string addCommonAttributes() {
	return "
		if (obj.hasKey(_ID, [sV])) {
			ret ~= \" id='\" ~ obj[_ID].content.s ~ \"'\";
		}
		if (obj.hasKey(_CLASS, [sV])) {
			ret ~= \" class='\" ~ obj[_CLASS].content.s ~ \"'\";
		}
		ret ~= \">\";
	";
}

// Utilities

Value renderHead(Value obj) {
	string ret = "<head";
	mixin(addCommonAttributes());

	if (obj.hasKey(_TITLE, [sV])) {
		ret ~= "<title>" ~ obj[_TITLE].content.s ~ "</title>";
	}

	ret ~= processChildrenNodes(obj[CHILDREN].content.a).content.s;

	ret ~= "</head>";

	return new Value(ret);
}

Value renderMeta(Value obj) {
	string ret = "<meta";
	
	ret ~= " name='" ~ obj[_NAME].content.s ~ "'";
	ret ~= " content='" ~ obj[_CONTENT].content.s ~ "'>";

	return new Value(ret);
}

Value renderBody(Value obj) {
	string ret = "<body";
	mixin(addCommonAttributes());

	ret ~= processChildrenNodes(obj[CHILDREN].content.a).content.s;

	ret ~= "</body>";

	return new Value(ret);
}


Value renderH1(Value obj) {
	string ret = "<h1";
	mixin(addCommonAttributes());

	ret ~= obj[_CONTENT].content.s;

	ret ~= "</h1>";

	return new Value(ret);
}

Value renderH2(Value obj) {
	string ret = "<h2";
	mixin(addCommonAttributes());

	ret ~= obj[_CONTENT].content.s;

	ret ~= "</h2>";

	return new Value(ret);
}

Value renderH3(Value obj) {
	string ret = "<h3";
	mixin(addCommonAttributes());

	ret ~= obj[_CONTENT].content.s;

	ret ~= "</h3>";

	return new Value(ret);
}

Value renderH4(Value obj) {
	string ret = "<h4";
	mixin(addCommonAttributes());

	ret ~= obj[_CONTENT].content.s;

	ret ~= "</h4>";

	return new Value(ret);
}

Value renderH5(Value obj) {
	string ret = "<h5";
	mixin(addCommonAttributes());

	ret ~= obj[_CONTENT].content.s;

	ret ~= "</h5>";

	return new Value(ret);
}

Value renderH6(Value obj) {
	string ret = "<h6";
	mixin(addCommonAttributes());

	ret ~= obj[_CONTENT].content.s;

	ret ~= "</h6>";

	return new Value(ret);
}

Value renderP(Value obj) {
	string ret = "<p";
	mixin(addCommonAttributes());

	ret ~= processChildrenNodes(obj[CHILDREN].content.a).content.s;

	ret ~= "</p>";

	return new Value(ret);
}

Value renderB(Value obj) {
	string ret = "<b";
	mixin(addCommonAttributes());

	ret ~= obj[_CONTENT].content.s;

	ret ~= "</b>";

	return new Value(ret);
}

Value renderI(Value obj) {
	string ret = "<i";
	mixin(addCommonAttributes());

	ret ~= obj[_CONTENT].content.s;

	ret ~= "</i>";

	return new Value(ret);
}

Value renderDiv(Value obj) {
	string ret = "<div";
	mixin(addCommonAttributes());

	ret ~= processChildrenNodes(obj[CHILDREN].content.a).content.s;

	ret ~= "</div>";

	return new Value(ret);
}

Value renderUl(Value obj) {
	string ret = "<ul";
	mixin(addCommonAttributes());

	ret ~= processChildrenNodes(obj[CHILDREN].content.a).content.s;

	ret ~= "</ul>";

	return new Value(ret);
}

Value renderLi(Value obj) {
	string ret = "<li";
	mixin(addCommonAttributes());

	ret ~= processChildrenNodes(obj[CHILDREN].content.a).content.s;

	ret ~= "</li>";

	return new Value(ret);
}

Value renderA(Value obj) {
	string ret = "<a";
	ret ~= " href='" ~ obj[_HREF].content.s ~ "'";
	mixin(addCommonAttributes());

	ret ~= obj[_CONTENT].content.s;

	ret ~= "</a>";

	return new Value(ret);
}

Value renderCSS(Value obj) {
	string ret;
	if (obj[_CONTENT].content.s.indexOf(".css")!=-1) {
		ret = "<link rel='stylesheet' href='" ~ obj[_CONTENT].content.s ~ "'>";
	}
	else {
		ret = "<style>" ~ obj[_CONTENT].content.s ~ "</style>";
	}
	return new Value(ret);
}

Value renderJS(Value obj) {
	string ret;
	if (obj[_CONTENT].content.s.indexOf(".js")!=-1) {
		ret = "<script src='" ~ obj[_CONTENT].content.s ~ "'></script>";
	}
	else {
		ret = "<script type='text/javascript'>" ~ obj[_CONTENT].content.s ~ "</script>";
	}
	return new Value(ret);
}

Value renderBr(Value obj) {
	string ret = "<br>";

	return new Value(ret);
}

Value renderTable(Value obj) {
	string ret = "<table";
	mixin(addCommonAttributes());

	ret ~= processChildrenNodes(obj[CHILDREN].content.a).content.s;

	ret ~= "</table>";

	return new Value(ret);
}

Value renderRow(Value obj) {
	string ret = "<tr";
	mixin(addCommonAttributes());

	ret ~= processChildrenNodes(obj[CHILDREN].content.a).content.s;

	ret ~= "</tr>";

	return new Value(ret);
}

Value renderCell(Value obj) {
	string tag = "td";
	if (obj.hasKey(":header", [bV])) {
		if (obj[":header"].content.b) {
			tag = "th";
		}
	}
	string ret = "<" ~ tag;
	mixin(addCommonAttributes());

	ret ~= obj[_CONTENT].content.s;

	ret ~= "</" ~ tag ~ ">";

	return new Value(ret);
}


Value renderPage(Value obj) {
	string ret = "";
	if (obj.hasKey(_TYPE, [sV])) {
		switch (obj[_TYPE].content.s) {
			case "html5": ret ~= "<!DOCTYPE html>"; break;
			case "html4": ret ~= "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">"; break;
			case "xhtml": ret ~= "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML Basic 1.1//EN\" \"http://www.w3.org/TR/xhtml-basic/xhtml-basic11.dtd\">"; break;
			default: ret ~= "";
		}
	}

	ret ~= "<html";
	mixin(addCommonAttributes());

	ret ~= processChildrenNodes(obj[CHILDREN].content.a).content.s;

	ret ~= "</html>";

	return new Value(ret);
}

/////

Value processChildrenNodes(Value[] children) {
	string ret = "";
	foreach (i, Value child; children) {

		if (child.hasKey(_OBJ_TYPE,[sV])) {

			switch (child[_OBJ_TYPE].content.s) {
				case "head": ret ~= renderHead(child).content.s; break;
				case "meta": ret ~= renderMeta(child).content.s; break;
				case "body": ret ~= renderBody(child).content.s; break;
				case "h1": ret ~= renderH1(child).content.s; break;
				case "h2": ret ~= renderH2(child).content.s; break;
				case "h3": ret ~= renderH3(child).content.s; break;
				case "h4": ret ~= renderH4(child).content.s; break;
				case "h5": ret ~= renderH5(child).content.s; break;
				case "h6": ret ~= renderH6(child).content.s; break;
				case "p": ret ~= renderP(child).content.s; break;
				case "b": ret ~= renderB(child).content.s; break;
				case "i": ret ~= renderI(child).content.s; break;
				case "div": ret ~= renderDiv(child).content.s; break;
				case "ul": ret ~= renderUl(child).content.s; break;
				case "li": ret ~= renderLi(child).content.s; break;
				case "a": ret ~= renderA(child).content.s; break;
				case "css": ret ~= renderCSS(child).content.s; break;
				case "js": ret ~= renderJS(child).content.s; break;
				case "br": ret ~= renderBr(child).content.s; break;
				case "table": ret ~= renderTable(child).content.s; break;
				case "row": ret ~= renderRow(child).content.s; break;
				case "cell": ret ~= renderCell(child).content.s; break;
				default: ret ~= "";
			}

		}
		else {
			if (child.type==sV) ret ~= "\n" ~ child.content.s ~ "\n";
		}

	}
	return new Value(ret);
}

// Functions

final class Web__Page_ : Func {
	this(string ns="") { super(ns ~ "page","create web page with given contents",[[dV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		mixin(initObject("page",0));

		// setup object

		obj["render"] = new Value(new Func((Value vs){ 
			return renderPage(obj);
		}));

		return obj;
	}
}

final class Web__Head_ : Func {
	this(string ns="") { super(ns ~ "head","create web page head with given contents",[[dV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		mixin(initObject("head",0));

		// setup object

		obj["render"] = new Value(new Func((Value vs){ 
			return renderHead(obj);
		}));

		return obj;
	}
}

final class Web__Meta_ : Func {
	this(string ns="") { super(ns ~ "meta","create a meta tag with given name and content",[[sV,sV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias name = S!(v,0);
		alias content = S!(v,1);

		mixin(initObject("meta",666));

		// setup object

		obj[_NAME] = new Value(name);
		obj[_CONTENT] = new Value(content);

		obj["render"] = new Value(new Func((Value vs){ 
			return renderMeta(obj);
		}));

		return obj;
	}
}

final class Web__Body_ : Func {
	this(string ns="") { super(ns ~ "body","create web page body with given contents",[[dV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		mixin(initObject("body",0));

		// setup object

		obj["render"] = new Value(new Func((Value vs){ 
			return renderBody(obj);
		}));

		return obj;
	}
}

final class Web__H1_ : Func {
	this(string ns="") { super(ns ~ "h1","create H1 header with title and given configuration",[[sV],[sV,dV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias title = S!(v,0);

		mixin(initObject("h1",1));

		// setup object

		obj[_CONTENT] = new Value(title);

		obj["render"] = new Value(new Func((Value vs){ 
			return renderH1(obj);
		}));

		return obj;
	}
}

final class Web__H2_ : Func {
	this(string ns="") { super(ns ~ "h2","create H2 header with title and given configuration",[[sV],[sV,dV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias title = S!(v,0);

		mixin(initObject("h2",1));

		// setup object

		obj[_CONTENT] = new Value(title);

		obj["render"] = new Value(new Func((Value vs){ 
			return renderH2(obj);
		}));

		return obj;
	}
}

final class Web__H3_ : Func {
	this(string ns="") { super(ns ~ "h3","create H3 header with title and given configuration",[[sV],[sV,dV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias title = S!(v,0);

		mixin(initObject("h3",1));

		// setup object

		obj[_CONTENT] = new Value(title);

		obj["render"] = new Value(new Func((Value vs){ 
			return renderH3(obj);
		}));

		return obj;
	}
}

final class Web__H4_ : Func {
	this(string ns="") { super(ns ~ "h4","create H4 header with title and given configuration",[[sV],[sV,dV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias title = S!(v,0);

		mixin(initObject("h4",1));

		// setup object

		obj[_CONTENT] = new Value(title);

		obj["render"] = new Value(new Func((Value vs){ 
			return renderH4(obj);
		}));

		return obj;
	}
}

final class Web__H5_ : Func {
	this(string ns="") { super(ns ~ "h5","create H5 header with title and given configuration",[[sV],[sV,dV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias title = S!(v,0);

		mixin(initObject("h5",1));

		// setup object

		obj[_CONTENT] = new Value(title);

		obj["render"] = new Value(new Func((Value vs){ 
			return renderH5(obj);
		}));

		return obj;
	}
}

final class Web__H6_ : Func {
	this(string ns="") { super(ns ~ "h6","create H6 header with title and given configuration",[[sV],[sV,dV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias title = S!(v,0);

		mixin(initObject("h6",1));

		// setup object

		obj[_CONTENT] = new Value(title);

		obj["render"] = new Value(new Func((Value vs){ 
			return renderH6(obj);
		}));

		return obj;
	}
}

final class Web__B_ : Func {
	this(string ns="") { super(ns ~ "b","create bold caption with title and given configuration",[[sV],[sV,dV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias title = S!(v,0);

		mixin(initObject("b",1));

		// setup object

		obj[_CONTENT] = new Value(title);

		obj["render"] = new Value(new Func((Value vs){ 
			return renderB(obj);
		}));

		return obj;
	}
}

final class Web__I_ : Func {
	this(string ns="") { super(ns ~ "i","create italic caption with title and given configuration",[[sV],[sV,dV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias title = S!(v,0);

		mixin(initObject("i",1));

		// setup object

		obj[_CONTENT] = new Value(title);

		obj["render"] = new Value(new Func((Value vs){ 
			return renderI(obj);
		}));

		return obj;
	}
}

final class Web__P_ : Func {
	this(string ns="") { super(ns ~ "p","create paragraph with contents",[[dV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		mixin(initObject("p",0));

		// setup object

		obj["render"] = new Value(new Func((Value vs){ 
			return renderP(obj);
		}));

		return obj;
	}
}

final class Web__Div_ : Func {
	this(string ns="") { super(ns ~ "div","create div section with contents",[[dV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		mixin(initObject("div",0));

		// setup object

		obj["render"] = new Value(new Func((Value vs){ 
			return renderDiv(obj);
		}));

		return obj;
	}
}

final class Web__Ul_ : Func {
	this(string ns="") { super(ns ~ "ul","create unordered list section with contents",[[dV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		mixin(initObject("ul",0));

		// setup object

		obj["render"] = new Value(new Func((Value vs){ 
			return renderUl(obj);
		}));

		return obj;
	}
}

final class Web__Li_ : Func {
	this(string ns="") { super(ns ~ "li","create unordered list item with title and contents",[[dV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		mixin(initObject("li",0));

		// setup object

		obj["render"] = new Value(new Func((Value vs){ 
			return renderLi(obj);
		}));

		return obj;
	}
}

final class Web__A_ : Func {
	this(string ns="") { super(ns ~ "a","create link with title, reference and configuration",[[sV,sV],[sV,sV,dV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias title = S!(v,0);
		alias href = S!(v,1);

		mixin(initObject("a",2));

		// setup object

		obj[_CONTENT] = new Value(title);
		obj[_HREF] = new Value(href);

		obj["render"] = new Value(new Func((Value vs){ 
			return renderA(obj);
		}));

		return obj;
	}
}

final class Web__Css_ : Func {
	this(string ns="") { super(ns ~ "css","create a link or style tag, with the given CSS source",[[sV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias source = S!(v,0);

		mixin(initObject("css",666));

		// setup object

		obj[_CONTENT] = new Value(source);

		obj["render"] = new Value(new Func((Value vs){ 
			return renderCSS(obj);
		}));

		return obj;
	}
}

final class Web__Js_ : Func {
	this(string ns="") { super(ns ~ "js","create a script tag, with the given JavaScript source",[[sV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias source = S!(v,0);

		mixin(initObject("js",666));

		// setup object

		obj[_CONTENT] = new Value(source);

		obj["render"] = new Value(new Func((Value vs){ 
			return renderJS(obj);
		}));

		return obj;
	}
}

final class Web__Br_ : Func {
	this(string ns="") { super(ns ~ "br","create a line break tag",[[]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		mixin(initObject("br",666));

		// setup object

		obj["render"] = new Value(new Func((Value vs){ 
			return renderBr(obj);
		}));

		return obj;
	}
}

final class Web__Table_ : Func {
	this(string ns="") { super(ns ~ "table","create table with contents",[[dV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		mixin(initObject("table",0));

		// setup object

		obj["render"] = new Value(new Func((Value vs){ 
			return renderTable(obj);
		}));

		return obj;
	}
}

final class Web__Row_ : Func {
	this(string ns="") { super(ns ~ "row","create table row with contents",[[dV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);

		mixin(initObject("row",0));

		// setup object

		obj["render"] = new Value(new Func((Value vs){ 
			return renderRow(obj);
		}));

		return obj;
	}
}

final class Web__Cell_ : Func {
	this(string ns="") { super(ns ~ "cell","create table cell with contents",[[sV],[sV,dV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias title = S!(v,0);

		mixin(initObject("cell",1));

		// setup object

		obj[_CONTENT] = new Value(title);

		obj["render"] = new Value(new Func((Value vs){ 
			return renderRow(obj);
		}));

		return obj;
	}
}