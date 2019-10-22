/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: value.d
 *****************************************************************/

module value;

// Imports

import core.checkedint;

import std.algorithm;
import std.array;
import std.bigint;
import std.conv;
import std.digest.sha;
import std.json;
import std.range;
import std.stdio;
import std.string;
import std.variant;

version(GTK)
import gobject.ObjectG;

import parser.statements;

import art.json;

import context;
import func;
import globals;
import panic;

// Globals

__gshared Value NULLV   = new Value();
__gshared Value TRUEV   = new Value(true);
__gshared Value FALSEV  = new Value(false);

// Constants

enum LOGIFY_PADDING = 16;

// Aliases

alias nV = ValueType.numberValue;
alias rV = ValueType.realValue;
alias sV = ValueType.stringValue;
alias bV = ValueType.booleanValue;
alias aV = ValueType.arrayValue;
alias dV = ValueType.dictionaryValue;
alias fV = ValueType.functionValue;
alias xV = ValueType.anyValue;
alias noV = ValueType.noValue;
alias vV = ValueType.variadicValue;
alias oV = ValueType.objectValue;
alias goV = ValueType.gobjectValue;
        
// Definitions

enum ValueType : string
{
    numberValue = "Number",
    realValue = "Real",
    stringValue = "String",
    booleanValue = "Boolean",
    arrayValue = "Array",
    dictionaryValue = "Dictionary",
    functionValue = "Function",
    noValue = "Null",
    anyValue = "Any",
    variadicValue = "Any...",
    objectValue = "Object",
    gobjectValue = "GObject"
}

union ValueContent
{
    long i;
    BigInt bi;
    real r;
    string s;
    bool b;
    Func f;
    Value[] a;
    Context d;
    void* o;

    version (GTK)
    ObjectG go;

}

// Aliases

auto I(alias symbol,int index)(){ return symbol[index].content.i; }
auto I(alias symbol)(){ return symbol.content.i; }
auto II(alias symbol,int index)(){ return to!int(symbol[index].content.i); }
auto II(alias symbol)(){ return to!int(symbol.content.i); }
auto BI(alias symbol,int index)(){ return symbol[index].content.bi; }
auto BI(alias symbol)(){ return symbol.content.bi; }

auto R(alias symbol,int index)(){ return symbol[index].content.r; }
auto R(alias symbol)(){ return symbol.content.r; }
auto S(alias symbol,int index)(){ return symbol[index].content.s; }
auto S(alias symbol)(){ return symbol.content.s; }
auto F(alias symbol,int index)(){ return symbol[index].content.f; }
auto F(alias symbol)(){ return symbol.content.f; }
auto B(alias symbol,int index)(){ return symbol[index].content.b; }
auto B(alias symbol)(){ return symbol.content.b; }
auto A(alias symbol,int index)(){ return symbol[index].content.a; }
auto A(alias symbol)(){ return symbol.content.a; }
auto D(alias symbol,int index)(){ return symbol[index].content.d; }
auto D(alias symbol)(){ return symbol.content.d; }
auto O(alias symbol,int index)(){ return symbol[index].content.o; }
auto O(alias symbol)(){ return symbol.content.o; }
auto GO(alias symbol,int index)(){ return symbol[index].content.go; }
auto GO(alias symbol)(){ return symbol.content.go; }

// Functions

final class Value {

    ValueType type;
    ValueContent content;
    bool isBig;

    this() { 
        type = ValueType.noValue; 
    }

    this(int v) { 
        type = ValueType.numberValue; 
        isBig = false;  
        content.i = v;
    }
    
    this(BigInt v) { 
        type = ValueType.numberValue; 
        isBig = true; 
        content.bi = v; 
    }

    this(long v) { 
        type = ValueType.numberValue; 
        content.i = v; 
    }

    this(string v, bool bignum=false) { 
        if (bignum) {
            isBig = true;
            type = ValueType.numberValue;
            content.bi = BigInt(v);
        }
        else {
            type = ValueType.stringValue;   
            content.s = v; 
        }
    }

    this(bool v) { 
        type = ValueType.booleanValue;    
        content.b = v; 
    }

    this(real v) { 
        type = ValueType.realValue;       
        content.r = v; 
    }

    this(Statements v) {
        type = ValueType.functionValue;   
        content.f = new Func("", v); 
    }

    this(Statements v, string[] ids) { 
        type = ValueType.functionValue;   
        content.f = new Func("", v, [], ids); 
    }

    this(Value[] v) {
        type = ValueType.arrayValue;
        content.a = [];
        foreach (Value i; v) {
            content.a ~= i;
        }
    }

    this(Value[Value] v) {
        type = ValueType.dictionaryValue;
        content.d =  cast(Context)null;//Context(null,ContextType.dictionaryContext);
        foreach (Value k, Value c; v) {
            content.d[k.content.s] = c;
        }
    }

    this(string[] v) {
        type = ValueType.arrayValue;
        content.a = [];
        foreach (string s; v) {
            content.a ~= new Value(s);
        }
    }

    this(string[string] v) {
        type = ValueType.dictionaryValue;
        content.d = cast(Context)null;//Context(null,ContextType.dictionaryContext);
        foreach (string k, string c; v) {
            content.d[k] = new Value(c);
        }
    }

    this(Value[string] v) {
        type = ValueType.dictionaryValue;
        content.d = cast(Context)null;//Context(null,ContextType.dictionaryContext);
        foreach (string key, Value val; v) {
            content.d[key] = new Value(val);
        }
    }

    this(Func f) {
        type = ValueType.functionValue;
        content.f = f;
    }

    this(void* o) {
        type = ValueType.objectValue;
        content.o = o;
    }
     
    version (GTK)
    this(ObjectG og) {
        type = ValueType.gobjectValue;
        content.go = og;
    }

    this(Value v) {
        type = v.type;

        switch (type)
        {
            case ValueType.numberValue : if (v.isBig) { isBig = true; content.bi = v.content.bi; } else { content.i = v.content.i; } break;
            case ValueType.realValue : content.r = v.content.r; break;
            case ValueType.stringValue : content.s = v.content.s; break;
            case ValueType.booleanValue : content.b = v.content.b; break;
            case ValueType.functionValue : content.f = v.content.f; /* = v.content.f; content.f.parentThis = v.content.f.parentThis; content.f.parentContext = v.content.f.parentContext; */break;
            case ValueType.arrayValue : 
                content.a = [];
                foreach (Value vv; v.content.a) content.a ~= new Value(vv);
                break;
            case ValueType.dictionaryValue :
                content.d = cast(Context)null;//Context(null,ContextType.dictionaryContext);
                foreach (string nm, Value va; v.content.d)
                {
                    content.d[nm] = va; 
                    if (va.type==fV) {
                        va.content.f.parentThis = this;
                        va.content.f.parentContext = content.d;
                    }
                }
                break;
            case ValueType.objectValue :
                content.o = v.content.o;
                break;

            version(GTK) {
            case ValueType.gobjectValue :
                content.go = v.content.go;
                break;
            }

            default: break;
        }
    }

    this(const Value v) {
        type = v.type;

        switch (type)
        {
            case ValueType.numberValue : if (isBig) { content.bi = v.content.bi; } else { content.i = v.content.i; } break;
            case ValueType.realValue : content.r = v.content.r; break;
            case ValueType.stringValue : content.s = v.content.s; break;
            case ValueType.booleanValue : content.b = v.content.b; break;
            case ValueType.functionValue : content.f = cast(Func)(v.content.f); content.f.parentThis = cast(Value)v.content.f.parentThis; content.f.parentContext = cast(Context)v.content.f.parentContext; break;
            case ValueType.arrayValue : 
                content.a = [];
                foreach (const Value vv; v.content.a) content.a ~= new Value(vv);
                break;
            case ValueType.dictionaryValue :
                content.d = cast(Context)null;//Context(null,ContextType.dictionaryContext);
                foreach (const string nm, const Value va; v.content.d)
                    content.d[nm] = new Value(va); break;
            default: break;
        }
    }

    static Value array() {
        Value v = new Value();
        v.type = ValueType.arrayValue;
        v.content.a = [];
        return v;
    }

    static Value dictionary() {
        Value v = new Value();
        v.type = ValueType.dictionaryValue;
        v.content.d = cast(Context)null;//Context(null,ContextType.dictionaryContext);
        return v;
    }

    bool arrayContains(Value item) {
        foreach (Value v; content.a)
            if (v==item) return true;

        return false;
    }

    void addValueToArray(Value item) {
        content.a ~= item;
    }

    bool dictionaryContains(Value item) {
        return (content.d.get(item.content.s,null) !is null);
    }

    bool dictionaryContainsKey(string key) {
        return (content.d.get(key,null) !is null);
    }

    string[] dictionaryKeys() {
        return content.d.keys;
    }

    Value[] dictionaryValues() {
        return content.d.values;
    }

    Value[string] dictionaryKeyValues(bool clean=false) {
        Value[string] ret;
        foreach (string nm, Value va; content.d)
        {
            if (!clean) ret[nm] = va;
            else {
                if (!nm.startsWith("_") && !nm.startsWith(":")) 
                    ret[nm] = va;
            }
        }
        return ret;
    }

    const bool dictionaryContainsKey(string key) {
        return (content.d.keys.canFind(key));
    }


    Value[] arrayValues() {
        return content.a;
    }

    Value removeDuplicatesFromArray() {
        Value ret = new Value(cast(Value[])[]);

        foreach (i, Value v; content.a) {
            if (!ret.arrayContains(v)) {
                ret.content.a ~= v;
            }
        }
        return ret;
    }

    Value removeValueFromArray(Value object) {
        foreach (i, Value v; content.a) {
            if (object==v) {
                return removeIndexFromArray(i);
            }
        }

        return this;
    }

    const Value removeValueFromArrayImmut(const Value object) {
        Value ret = new Value(this);
        foreach (i, Value v; ret.content.a) {
            if (object==v) {
                return ret.removeIndexFromArrayImmut(i);
            }
        }

        return ret;
    }

    Value removeValueFromDict(Value object) {
        foreach (string nm, Value va; content.d) {
            if (va==object) content.d.remove(nm);
        }

        return this;
    }

    const Value removeIndexFromArrayImmut(long index) {
        Value ret = new Value(this);
        ret.content.a = ret.content.a.remove(index);
        return ret;
    }

    Value removeIndexFromArray(long index) {
        content.a = content.a.remove(index);
        return this;
    }

    Value removeIndexFromDict(string key) {
        content.d.remove(key);

        return this;
    }

    Value getValueFromDictValue(Value key) {
        Value ret;
        if ((ret = content.d.get(key.content.s,null)) !is null) 
            return ret;
        else return null;
    }

    Value getValueFromDict(string key) {
        return content.d.get(key,null);
    }

    Value getSymbolFromDict(string key) {
        return content.d.get(key,null);
    }

    const Value getValueFromDictImmut(string key) {
        Value cp = new Value(this);
        return cp.content.d.get(key,null);
    }

    void setValueForDictValue(Value key, Value val) {
        content.d[key.content.s] = val;
    }

    void setSymbolForDict(string key, Value val) {
        content.d[key] = val;

        if (val.type==fV) {
            val.content.f.parentThis = this;
            val.content.f.parentContext = content.d;
        }
    }

    void setValueForDict(string key, Value val) {
        content.d[key] = val;

        if (val.type==fV) {
            val.content.f.parentThis = this;
            val.content.f.parentContext = content.d;
        }
    }

    void setValueForDictRegardless(string key, Value val) {
        content.d[key] = val;
    }

    const Value mergeDictWith(const Value dictB) {
        Value cp = new Value(this);

        foreach (const string nm, const Value va; dictB.content.d) {
            cp.setValueForDictRegardless(new Value(nm).content.s, new Value(va));
        }

        return cp;
    }

    bool arrayContainsSameTypeValues() {
        ValueType previousType = ValueType.noValue;
        foreach (Value v; content.a) {
            if (previousType==ValueType.noValue)
                previousType = v.type;
            else {
                if (previousType!=v.type)
                    return false;
            }
        }
        return true;
    }

    Value arraySort() {
        if (arrayContainsSameTypeValues()) {
            if (content.a.length>0) {
                ValueType t = content.a[0].type;
                switch (t) {
                    case nV: return new Value(content.a.map!(v => v.content.i).array.sort().map!(v => new Value(v)).array);
                    case sV: return new Value(content.a.map!(v => v.content.s).array.sort().map!(v => new Value(v)).array);
                    default: return null;
                }
            }
            else return null;
        }
        else return null;
    }

    bool hasKey(string key, ValueType[] vts) {
        if (key in this) {
            if (vts.canFind(this[key].type)) return true;
            else throw new ERR_ExpectedValueTypeError(key, vts[0], this[key].type);
        }
        else return false;
    }

    /************************************
     INDEX OPERATOR OVERLOADING
     ************************************/

    Value opIndex(size_t i) {
        if (type==aV) {
            return content.a[i];
        }
        else return null;
    }

    Value opIndex(string k) {
        if (type==dV) {
            return getValueFromDict(k);
        }
        else return null;
    }

    Value opIndexAssign(Value v, size_t i) {
        if (type==aV) {
            content.a[i] = v;
            return v;
        }
        else return null;
    }

    Value opIndexAssign(Value v, string k) {
        if (type==dV) {
            setValueForDict(k,v);
            return v;
        }
        else return null;
    }


    bool opBinaryRight(string op)(in string rhs) const if (op == "in") {
        if (type==dV) {
            return dictionaryContainsKey(rhs);
        }
        else return false;
    }

    /************************************
     ARITHMETIC OPERATIONS
     ************************************/

    Value opBinary(string op)(in Value rhs) const if (op == "+") {
        if (type==ValueType.numberValue) {
            if (isBig) {
                BigInt lhs = content.bi;

                switch (rhs.type) {
                    case ValueType.numberValue      : if (rhs.isBig) { return new Value(BigInt(lhs + rhs.content.bi)); } else { return new Value(BigInt(lhs + rhs.content.i)); }
                    case ValueType.realValue        : throw new ERR_OperationNotPermitted("(+)","Big Number","Real");
                    case ValueType.stringValue      : return new Value(to!string(lhs) ~ rhs.content.s);
                    case ValueType.booleanValue     : if (rhs.content.b) return new Value(lhs + 1); else return new Value(lhs);
                    case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(+)","Number","Array");
                    case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(+)","Number","Dictionary");
                    case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(+)","Number","Function");
                    case ValueType.noValue          : return NULLV; // null
                    default                         : break;
                }

            }
            else {
                long lhs = content.i;

                switch (rhs.type) {
                    case ValueType.numberValue      : if (rhs.isBig) { return new Value(BigInt(lhs + rhs.content.bi)); } 
                                                      else { 
                                                        bool overflow;
                                                        auto result = adds(lhs, rhs.content.i, overflow);
                                                        if (!overflow) return new Value(result);
                                                        else return new Value(BigInt(lhs) + BigInt(rhs.content.i)); 
                                                      }
                    case ValueType.realValue        : return new Value(lhs + rhs.content.r);
                    case ValueType.stringValue      : return new Value(to!string(lhs) ~ rhs.content.s);
                    case ValueType.booleanValue     : if (rhs.content.b) {
                                                        bool overflow;
                                                        auto result = adds(lhs, 1, overflow);
                                                        if (!overflow) return new Value(result);
                                                        else return new Value(BigInt(lhs) + BigInt(1));
                                                      } else return new Value(lhs);
                    case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(+)","Number","Array");
                    case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(+)","Number","Dictionary");
                    case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(+)","Number","Function");
                    case ValueType.noValue          : return NULLV; // null
                    default                         : break;
                }
            }
        }
        else if (type==ValueType.realValue) {
            real lhs = content.r;

            switch (rhs.type) {
                case ValueType.realValue        : return new Value(lhs + rhs.content.r);
                case ValueType.numberValue      : if (rhs.isBig) { throw new ERR_OperationNotPermitted("(+)","Real","Big Number"); } else { return new Value(lhs + rhs.content.i); }
                case ValueType.stringValue      : return new Value(to!string(lhs) ~ rhs.content.s);
                case ValueType.booleanValue     : return new Value(lhs + to!int(rhs.content.b));
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(+)","Real","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(+)","Real","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(+)","Real","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.stringValue) {
            string lhs = content.s;

            switch (rhs.type) {
                case ValueType.numberValue      : if (rhs.isBig) { return new Value(lhs ~ to!string(rhs.content.bi)); } else { return new Value(lhs ~ to!string(rhs.content.i)); }
                case ValueType.realValue        : return new Value(lhs ~ to!string(rhs.content.r));
                case ValueType.stringValue      : return new Value(lhs ~ rhs.content.s);
                case ValueType.booleanValue     : return new Value(lhs ~ rhs.stringifyImmut());
                case ValueType.arrayValue       : return new Value(lhs ~ rhs.stringifyImmut());
                case ValueType.dictionaryValue  : return new Value(lhs ~ rhs.stringifyImmut());
                case ValueType.functionValue    : return new Value(lhs ~ rhs.stringifyImmut());
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.booleanValue) {
            bool lhs = content.b;

            switch (rhs.type) {
                case ValueType.numberValue      : if (rhs.isBig) { return new Value(to!int(lhs) + rhs.content.bi); }    
                                                  else { 
                                                    bool overflow;
                                                    auto result = adds(to!int(lhs), rhs.content.i, overflow);
                                                    if (!overflow) return new Value(result);
                                                    else return new Value(BigInt(to!int(lhs)) + BigInt(rhs.content.i));
                                                  }
                case ValueType.realValue        : return new Value(to!int(lhs) + to!int(rhs.content.r));
                case ValueType.stringValue      : return new Value(to!string(lhs) ~ rhs.content.s);
                case ValueType.booleanValue     : return new Value(to!int(lhs) + to!int(rhs.content.b));
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(+)","Boolean","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(+)","Boolean","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(+)","Boolean","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.arrayValue) {
            Value newV = new Value(cast(Value)(this));
            if (rhs.type!=ValueType.arrayValue) {
                newV.content.a ~= cast(Value)rhs;
            }
            else {
                foreach (const Value vv; rhs.content.a) {
                    newV.content.a ~= cast(Value)vv;
                }
            }
            return newV;
        }
        else if (type==ValueType.dictionaryValue) {
            switch (rhs.type) {
                case ValueType.numberValue      : throw new ERR_OperationNotPermitted("(+)","Dictionary","Number"); 
                case ValueType.realValue        : throw new ERR_OperationNotPermitted("(+)","Dictionary","Real");
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(+)","Dictionary","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(+)","Dictionary","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(+)","Dictionary","Array");
                case ValueType.dictionaryValue  : return mergeDictWith(rhs);
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(+)","Dictionary","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.functionValue) {
            switch (rhs.type) {
                case ValueType.numberValue      : throw new ERR_OperationNotPermitted("(+)","Function","Number");
                case ValueType.realValue        : throw new ERR_OperationNotPermitted("(+)","Function","Real");
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(+)","Function","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(+)","Function","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(+)","Function","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(+)","Function","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(+)","Function","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.noValue) {
            return NULLV; // null
        }

        return NULLV; // Control never reaches this point
    }

    Value opBinary(string op)(in Value rhs) const if (op == "-") {
        if (type==ValueType.numberValue) {
            if (isBig) {
                BigInt lhs = content.bi;

                switch (rhs.type) {
                    case ValueType.numberValue      : if (rhs.isBig) { return new Value(BigInt(lhs - rhs.content.bi)); } else { return new Value(BigInt(lhs - rhs.content.i)); }
                    case ValueType.realValue        : throw new ERR_OperationNotPermitted("(-)","Big Number","Real");
                    case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(-)","Number","String");
                    case ValueType.booleanValue     : if (rhs.content.b) return new Value(lhs - 1); else return new Value(lhs);
                    case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(-)","Number","Array");
                    case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(-)","Number","Dictionary");
                    case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(-)","Number","Function");
                    case ValueType.noValue          : return NULLV; // null
                    default                         : break;
                }
            }
            else {
                long lhs = content.i;

                switch (rhs.type) {
                    case ValueType.numberValue      : if (rhs.isBig) { return new Value(BigInt(lhs - rhs.content.bi)); } 
                                                      else { 
                                                        bool overflow;
                                                        auto result = subs(lhs, rhs.content.i, overflow);
                                                        if (!overflow) return new Value(result);
                                                        else return new Value(BigInt(lhs) - BigInt(rhs.content.i)); 
                                                      }
                    case ValueType.realValue        : return new Value(lhs - rhs.content.r);
                    case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(-)","Number","String");
                    case ValueType.booleanValue     : if (rhs.content.b) {
                                                        bool overflow;
                                                        auto result = subs(lhs, 1, overflow);
                                                        if (!overflow) return new Value(result);
                                                        else return new Value(BigInt(lhs) - BigInt(1));
                                                      } else return new Value(lhs);
                    case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(-)","Number","Array");
                    case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(-)","Number","Dictionary");
                    case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(-)","Number","Function");
                    case ValueType.noValue          : return NULLV; // null
                    default                         : break;
                }
            }
        }
        else if (type==ValueType.realValue) {
            real lhs = content.r;

            switch (rhs.type) {
                case ValueType.numberValue      : if (rhs.isBig) { throw new ERR_OperationNotPermitted("(-)","Real","Big Number"); } else { return new Value(lhs - rhs.content.i); }
                case ValueType.realValue        : return new Value(lhs - rhs.content.r);
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(-)","Real","String");
                case ValueType.booleanValue     : return new Value(lhs - to!int(rhs.content.b));
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(-)","Real","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(-)","Real","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(-)","Real","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.stringValue) {
            string lhs = content.s;

            switch (rhs.type) {
                case ValueType.numberValue      : if (rhs.isBig) { return new Value(replace(lhs, to!string(rhs.content.bi),"")); } else { return new Value(replace(lhs, to!string(rhs.content.i),"")); }
                case ValueType.realValue        : return new Value(replace(lhs, to!string(rhs.content.r),""));
                case ValueType.stringValue      : return new Value(replace(lhs, rhs.content.s,""));
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(-)","String","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(-)","String","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(-)","String","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(-)","String","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.booleanValue) {
            bool lhs = content.b;

            switch (rhs.type) {
                case ValueType.numberValue      : if (rhs.isBig) { return new Value(to!int(lhs) - rhs.content.bi); }    
                                                  else { 
                                                    bool overflow;
                                                    auto result = subs(to!int(lhs), rhs.content.i, overflow);
                                                    if (!overflow) return new Value(result);
                                                    else return new Value(BigInt(to!int(lhs)) - BigInt(rhs.content.i));
                                                  }
                case ValueType.realValue        : return new Value(to!int(lhs) - to!int(rhs.content.r));
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(-)","Boolean","String");
                case ValueType.booleanValue     : return new Value(to!int(lhs) - to!int(rhs.content.b));
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(-)","Boolean","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(-)","Boolean","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(-)","Boolean","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.arrayValue) {
            return removeValueFromArrayImmut(rhs);
        }
        else if (type==ValueType.dictionaryValue) {   
            Value cp = new Value(this);
            Value cprhs = new Value(rhs);
            return cp.removeValueFromDict(cprhs);
        }
        else if (type==ValueType.functionValue) {
            switch (rhs.type) {
                case ValueType.numberValue      : throw new ERR_OperationNotPermitted("(-)","Function","Number");
                case ValueType.realValue        : throw new ERR_OperationNotPermitted("(-)","Function","Real");
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(-)","Function","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(-)","Function","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(-)","Function","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(-)","Function","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(-)","Function","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.noValue) {
            return NULLV; // null
        }

        return NULLV; // Control never reaches this point
    }

    Value opBinary(string op)(in Value rhs) const if (op == "*") {
        /*
        if (isBig) {
            write("multiplying: (big) " ~ stringifyImmut());
        }
        else {
            write("multiplying: " ~ stringifyImmut());
        }
        if (rhs.isBig) {
            writeln(" with: (big) " ~ rhs.stringifyImmut());
        }
        else {
            writeln(" with: " ~ rhs.stringifyImmut());
        }*/
        if (type==ValueType.numberValue) {
            if (isBig) {
                BigInt lhs = content.bi;

                switch (rhs.type) {
                    case ValueType.numberValue      : if (rhs.isBig) { return new Value(BigInt(lhs * rhs.content.bi)); } else { return new Value(BigInt(lhs * rhs.content.i)); }
                    case ValueType.realValue        : throw new ERR_OperationNotPermitted("(-)","Big Number","Real");
                    case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(*)","Big Number","String");
                    case ValueType.booleanValue     : if (rhs.content.b) return new Value(lhs * 1); else return new Value(0);
                    case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(*)","Big Number","Array");
                    case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(*)","Number","Dictionary");
                    case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(*)","Number","Function");
                    case ValueType.noValue          : return NULLV; // null
                    default                         : break;
                }
            }
            else {
                long lhs = content.i;

                switch (rhs.type) {
                    case ValueType.numberValue      : if (rhs.isBig) { return new Value(BigInt(lhs * rhs.content.bi)); } 
                                                      else { 
                                                        bool overflow;
                                                        auto result = muls(lhs, rhs.content.i, overflow);
                                                        if (!overflow) return new Value(result);
                                                        else return new Value(BigInt(lhs) * BigInt(rhs.content.i)); 
                                                      }
                    case ValueType.realValue        : return new Value(lhs * rhs.content.r);
                    case ValueType.stringValue      : return new Value(replicate(rhs.content.s,lhs));
                    case ValueType.booleanValue     : if (rhs.content.b) return new Value(lhs * 1); else return new Value(0);
                    case ValueType.arrayValue       : return new Value(replicate(cast(Value[])(rhs.content.a),lhs));
                    case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(*)","Number","Dictionary");
                    case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(*)","Number","Function");
                    case ValueType.noValue          : return NULLV; // null
                    default                         : break;
                }
            }
            
        }
        else if (type==ValueType.realValue) {
            real lhs = content.r;

            switch (rhs.type) {
                case ValueType.numberValue      : if (rhs.isBig) { throw new ERR_OperationNotPermitted("(*)","Real","Big Number"); } else { return new Value(lhs * rhs.content.i); }
                case ValueType.realValue        : return new Value(lhs * rhs.content.r);
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(*)","Real","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(*)","Real","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(*)","Real","Real");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(*)","Real","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(*)","Real","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }

        else if (type==ValueType.stringValue) {
            string lhs = content.s;

            switch (rhs.type) {
                case ValueType.numberValue      : if (rhs.isBig) { throw new ERR_OperationNotPermitted("(*)","String","Big Number"); } else { return new Value(replicate(lhs,rhs.content.i)); } 
                case ValueType.realValue        : throw new ERR_OperationNotPermitted("(*)","String","Real");
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(*)","String","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(*)","String","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(*)","String","String");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(*)","String","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(*)","String","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.booleanValue) {
            bool lhs = content.b;

            switch (rhs.type) {
                case ValueType.numberValue      : if (rhs.isBig) { return new Value(to!int(lhs) - rhs.content.bi); }    
                                                  else { 
                                                    bool overflow;
                                                    auto result = muls(to!int(lhs), rhs.content.i, overflow);
                                                    if (!overflow) return new Value(result);
                                                    else return new Value(BigInt(to!int(lhs)) * BigInt(rhs.content.i));
                                                  }
                case ValueType.realValue        : return new Value(to!int(lhs) * to!int(rhs.content.r));
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(*)","Boolean","String");
                case ValueType.booleanValue     : return new Value(to!int(lhs) * to!int(rhs.content.b));
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(*)","Boolean","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(*)","Boolean","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(*)","Boolean","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.arrayValue) {
            Value[] lhs = cast(Value[])(content.a);

            switch (rhs.type) {
                case ValueType.numberValue      : if (rhs.isBig) { throw new ERR_OperationNotPermitted("(*)","Array","Big Number"); } else { return new Value(replicate(lhs,rhs.content.i)); }
                case ValueType.realValue        : throw new ERR_OperationNotPermitted("(*)","Array","Real");
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(*)","Array","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(*)","Array","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(*)","Array","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(*)","Array","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(*)","Array","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.dictionaryValue) {
            switch (rhs.type) {
                case ValueType.numberValue      : throw new ERR_OperationNotPermitted("(*)","Dictionary","Number");
                case ValueType.realValue        : throw new ERR_OperationNotPermitted("(*)","Dictionary","Real");
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(*)","Dictionary","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(*)","Dictionary","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(*)","Dictionary","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(*)","Dictionary","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(*)","Dictionary","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.functionValue) {
            switch (rhs.type) {
                case ValueType.numberValue      : throw new ERR_OperationNotPermitted("(*)","Function","Number");
                case ValueType.realValue        : throw new ERR_OperationNotPermitted("(*)","Function","Real");
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(*)","Function","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(*)","Function","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(*)","Function","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(*)","Function","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(*)","Function","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.noValue) {
            return NULLV; // null
        }

        return NULLV; // Control never reaches this point
    }

    Value opBinary(string op)(in Value rhs) const if (op == "/") {
        if (type==ValueType.numberValue) {
            if (isBig) {
                BigInt lhs = content.bi;

                switch (rhs.type) {
                    case ValueType.numberValue      : if (rhs.isBig) { return new Value(lhs / rhs.content.bi); } else { return new Value(lhs / rhs.content.i); }
                    case ValueType.realValue        : throw new ERR_OperationNotPermitted("(/)","Big Number","Real");
                    case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(/)","Number","String");
                    case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(/)","Number","Boolean");
                    case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(/)","Number","Array");
                    case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(/)","Number","Dictionary");
                    case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(/)","Number","Function");
                    case ValueType.noValue          : return NULLV; // null
                    default                         : break;
                }
            }
            else {
                long lhs = content.i;

                switch (rhs.type) {
                    case ValueType.numberValue      : if (rhs.isBig) { return new Value(lhs / rhs.content.bi); } else { return new Value(lhs / rhs.content.i); }
                    case ValueType.realValue        : return new Value(lhs / rhs.content.r);
                    case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(/)","Number","String");
                    case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(/)","Number","Boolean");
                    case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(/)","Number","Array");
                    case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(/)","Number","Dictionary");
                    case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(/)","Number","Function");
                    case ValueType.noValue          : return NULLV; // null
                    default                         : break;
                }
            }
            
        }
        else if (type==ValueType.realValue)  {
            real lhs = content.r;

            switch (rhs.type) {
                case ValueType.numberValue      : if (rhs.isBig) { throw new ERR_OperationNotPermitted("(/)","Real","Big Number"); } else { return new Value(lhs / rhs.content.i); }
                case ValueType.realValue        : return new Value(lhs / rhs.content.r);
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(/)","Real","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(/)","Real","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(/)","Real","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(/)","Real","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(/)","Real","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.stringValue) {
            string lhs = content.s;

            switch (rhs.type) {
                case ValueType.numberValue      : Value[] ret;
                                                  string resp = "";
                                                  if (rhs.isBig) {
                                                      for (int kk=0; kk<lhs.length; kk++){
                                                        resp ~= content.s[kk];
                                                        if ((kk+1)%rhs.content.bi==0){ret ~= new Value(resp);resp = "";}
                                                      }
                                                  }
                                                  else {
                                                      for (int kk=0; kk<lhs.length; kk++){
                                                        resp ~= content.s[kk];
                                                        if ((kk+1)%rhs.content.i==0){ret ~= new Value(resp);resp = "";}
                                                      }
                                                  }
                                                  return new Value(ret);
                case ValueType.realValue        : throw new ERR_OperationNotPermitted("(/)","String","Real");
                case ValueType.stringValue      : return new Value(lhs.split(rhs.content.s));
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(/)","String","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(/)","String","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(/)","String","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(/)","String","Function");
                default                         : break;
            }
        }
        else if (type==ValueType.booleanValue) {
            bool lhs = content.b;

            switch (rhs.type) {
                case ValueType.numberValue      : throw new ERR_OperationNotPermitted("(/)","Boolean","Number");
                case ValueType.realValue        : throw new ERR_OperationNotPermitted("(/)","Boolean","Real");
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(/)","Boolean","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(/)","Boolean","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(/)","Boolean","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(/)","Boolean","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(/)","Boolean","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.arrayValue) {
            Value[] lhs = cast(Value[])(content.a);

            switch (rhs.type) {
                case ValueType.numberValue      : Value[] ret;
                                                  string resp = "";
                                                  if (rhs.isBig) {
                                                      for (int kk=0; kk<lhs.length; kk++){
                                                        if ((kk+1)%rhs.content.bi==0){ret ~= new Value(content.a[kk]);}
                                                      }
                                                  }
                                                  else {
                                                      for (int kk=0; kk<lhs.length; kk++){
                                                        if ((kk+1)%rhs.content.i==0){ret ~= new Value(content.a[kk]);}
                                                      }
                                                  }
                                                  return new Value(ret);
                case ValueType.realValue        : throw new ERR_OperationNotPermitted("(/)","Array","Real");
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(/)","Array","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(/)","Array","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(/)","Array","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(/)","Array","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(/)","Array","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.dictionaryValue) {
            switch (rhs.type) {
                case ValueType.numberValue      : throw new ERR_OperationNotPermitted("(/)","Dictionary","Number");
                case ValueType.realValue        : throw new ERR_OperationNotPermitted("(/)","Dictionary","Real");
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(/)","Dictionary","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(/)","Dictionary","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(/)","Dictionary","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(/)","Dictionary","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(/)","Dictionary","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.functionValue) {
            switch (rhs.type) {
                case ValueType.numberValue      : throw new ERR_OperationNotPermitted("(/)","Function","Number");
                case ValueType.realValue        : throw new ERR_OperationNotPermitted("(/)","Function","Real");
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(/)","Function","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(/)","Function","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(/)","Function","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(/)","Function","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(/)","Function","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.noValue) {
            return NULLV; // null
        }

        return NULLV; // Control never reaches this point
    }

    Value opBinary(string op)(in Value rhs) const if (op == "%") {
        if (type==ValueType.numberValue) {
            if (isBig) {
                BigInt lhs = content.bi;

                switch (rhs.type) {
                    case ValueType.numberValue      : if (rhs.isBig) { return new Value(lhs % rhs.content.bi); } else { return new Value(lhs % rhs.content.i); }
                    case ValueType.realValue        : throw new ERR_OperationNotPermitted("(%)","Big Number","Real");
                    case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(%)","Number","String");
                    case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(%)","Number","Boolean");
                    case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(%)","Number","Array");
                    case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(%)","Number","Dictionary");
                    case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(%)","Number","Function");
                    case ValueType.noValue          : return NULLV; // null
                    default                         : break;
                }
            }
            else {
                long lhs = content.i;

                switch (rhs.type) {
                    case ValueType.numberValue      : if (rhs.isBig) { return new Value(lhs % rhs.content.bi); } else { return new Value(lhs % rhs.content.i); }
                    case ValueType.realValue        : return new Value(lhs % rhs.content.r);
                    case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(%)","Number","String");
                    case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(%)","Number","Boolean");
                    case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(%)","Number","Array");
                    case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(%)","Number","Dictionary");
                    case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(%)","Number","Function");
                    case ValueType.noValue          : return NULLV; // null
                    default                         : break;
                }
            }
            
        }
        else if (type==ValueType.realValue) {
            real lhs = content.r;

            switch (rhs.type) {
                case ValueType.numberValue      : if (rhs.isBig) { throw new ERR_OperationNotPermitted("(%)","Real","Big Number"); } else { return new Value(lhs % rhs.content.i); }
                case ValueType.realValue        : return new Value(lhs % rhs.content.r);
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(%)","Real","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(%)","Real","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(%)","Real","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(%)","Real","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(%)","Real","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.stringValue) {
            string lhs = content.s;

            switch (rhs.type) {
                case ValueType.numberValue      : if (rhs.isBig) {
                                                    long len = lhs.length % rhs.content.bi;
                                                    return new Value(lhs[$-len..$]);
                                                  } 
                                                  else {
                                                    long len = lhs.length % rhs.content.i;
                                                    return new Value(lhs[$-len..$]);
                                                  }
                case ValueType.realValue        : throw new ERR_OperationNotPermitted("(%)","String","Real");
                case ValueType.stringValue      : return new Value(lhs.split(rhs.content.s));
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(%)","String","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(%)","String","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(%)","String","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(%)","String","Function");
                default                         : break;
            }
        }
        else if (type==ValueType.booleanValue) {
            bool lhs = content.b;

            switch (rhs.type) {
                case ValueType.numberValue      : throw new ERR_OperationNotPermitted("(%)","Boolean","Number");
                case ValueType.realValue        : throw new ERR_OperationNotPermitted("(%)","Boolean","Real");
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(%)","Boolean","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(%)","Boolean","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(%)","Boolean","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(%)","Boolean","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(%)","Boolean","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.arrayValue) {
            Value[] lhs = cast(Value[])(content.a);

            switch (rhs.type) {
                case ValueType.numberValue      : if (rhs.isBig) {
                                                    long len = lhs.length % rhs.content.bi;
                                                    return new Value(lhs[$-len..$]);
                                                  } 
                                                  else {
                                                    long len = lhs.length % rhs.content.i;
                                                    return new Value(lhs[$-len..$]);
                                                  }
                case ValueType.realValue        : throw new ERR_OperationNotPermitted("(%)","Array","Real");
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(%)","Array","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(%)","Array","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(%)","Array","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(%)","Array","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(%)","Array","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.dictionaryValue) {
            switch (rhs.type) {
                case ValueType.numberValue      : throw new ERR_OperationNotPermitted("(%)","Dictionary","Number");
                case ValueType.realValue        : throw new ERR_OperationNotPermitted("(%)","Dictionary","Real");
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(%)","Dictionary","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(%)","Dictionary","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(%)","Dictionary","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(%)","Dictionary","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(%)","Dictionary","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.functionValue) {
            switch (rhs.type) {
                case ValueType.numberValue      : throw new ERR_OperationNotPermitted("(%)","Function","Number");
                case ValueType.realValue        : throw new ERR_OperationNotPermitted("(%)","Function","Real");
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(%)","Function","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(%)","Function","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(%)","Function","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(%)","Function","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(%)","Function","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.noValue) {
            return NULLV; // null
        }

        return NULLV; // Control never reaches this point
    }

    Value opBinary(string op)(in Value rhs) const if (op == "^^") {
        if (type==ValueType.numberValue)
        {
            if (isBig) {
                BigInt lhs = content.bi;

                switch (rhs.type) {
                    case ValueType.numberValue      : if (rhs.isBig) { throw new ERR_OperationNotPermitted("(^)","Big Number","Big Number"); } else { return new Value(lhs ^^ rhs.content.i); }
                    case ValueType.realValue        : throw new ERR_OperationNotPermitted("(^)","Big Number","Real");
                    case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(^)","Number","String");
                    case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(^)","Number","Boolean");
                    case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(^)","Number","Array");
                    case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(^)","Number","Dictionary");
                    case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(^)","Number","Function");
                    case ValueType.noValue          : return NULLV; // null
                    default                         : break;
                }
            }
            else {
                long lhs = content.i;

                switch (rhs.type) {
                    case ValueType.numberValue      : if (rhs.isBig) { throw new ERR_OperationNotPermitted("(^)","Number","Big Number"); } else { return new Value(BigInt(lhs) ^^ rhs.content.i); }
                    case ValueType.realValue        : return new Value(lhs ^^ rhs.content.r);
                    case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(^)","Number","String");
                    case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(^)","Number","Boolean");
                    case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(^)","Number","Array");
                    case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(^)","Number","Dictionary");
                    case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(^)","Number","Function");
                    case ValueType.noValue          : return NULLV; // null
                    default                         : break;
                }
            }
            
        }
        else if (type==ValueType.realValue) {
            real lhs = content.r;

            switch (rhs.type) {
                case ValueType.numberValue      : if (rhs.isBig) { throw new ERR_OperationNotPermitted("(^)","Real","Big Number"); } else { return new Value(lhs ^^ rhs.content.i); }
                case ValueType.realValue        : return new Value(lhs ^^ rhs.content.r);
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(^)","Real","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(^)","Real","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(^)","Real","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(^)","Real","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(^)","Real","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.stringValue) {
            string lhs = content.s;

            switch (rhs.type) {
                case ValueType.numberValue      : throw new ERR_OperationNotPermitted("(^)","String","Number");
                case ValueType.realValue        : throw new ERR_OperationNotPermitted("(^)","String","Real");
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(^)","String","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(^)","String","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(^)","String","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(^)","String","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(^)","String","Function");
                default                         : break;
            }
        }
        else if (type==ValueType.booleanValue) {
            bool lhs = content.b;

            switch (rhs.type) {
                case ValueType.numberValue      : throw new ERR_OperationNotPermitted("(^)","Boolean","Number");
                case ValueType.realValue        : throw new ERR_OperationNotPermitted("(^)","Boolean","Real");
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(^)","Boolean","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(^)","Boolean","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(^)","Boolean","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(^)","Boolean","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(^)","Boolean","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.arrayValue) {
            Value[] lhs = cast(Value[])(content.a);

            switch (rhs.type) {
                case ValueType.numberValue      : throw new ERR_OperationNotPermitted("(^)","Array","Number");
                case ValueType.realValue        : throw new ERR_OperationNotPermitted("(^)","Array","Real");
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(^)","Array","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(^)","Array","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(^)","Array","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(^)","Array","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(^)","Array","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.dictionaryValue) {
            switch (rhs.type) {
                case ValueType.numberValue      : throw new ERR_OperationNotPermitted("(^)","Dictionary","Number");
                case ValueType.realValue        : throw new ERR_OperationNotPermitted("(^)","Dictionary","Real");
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(^)","Dictionary","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(^)","Dictionary","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(^)","Dictionary","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(^)","Dictionary","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(^)","Dictionary","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.functionValue) {
            switch (rhs.type) {
                case ValueType.numberValue      : throw new ERR_OperationNotPermitted("(^)","Function","Number");
                case ValueType.realValue        : throw new ERR_OperationNotPermitted("(^)","Function","Real");
                case ValueType.stringValue      : throw new ERR_OperationNotPermitted("(^)","Function","String");
                case ValueType.booleanValue     : throw new ERR_OperationNotPermitted("(^)","Function","Boolean");
                case ValueType.arrayValue       : throw new ERR_OperationNotPermitted("(^)","Function","Array");
                case ValueType.dictionaryValue  : throw new ERR_OperationNotPermitted("(^)","Function","Dictionary");
                case ValueType.functionValue    : throw new ERR_OperationNotPermitted("(^)","Function","Function");
                case ValueType.noValue          : return NULLV; // null
                default                         : break;
            }
        }
        else if (type==ValueType.noValue) {
            return NULLV; // null
        }

        return NULLV; // Control never reaches this point
    }

    Value opBinary(string op)(in Value rhs) const if (op == "<<") {
        if (type==ValueType.numberValue) {
            if (isBig) {
                BigInt lhs = content.bi;

                if (rhs.type==ValueType.numberValue) {
                    if (rhs.isBig) { return new Value(lhs << rhs.content.bi); }
                    else { return new Value(lhs << rhs.content.i); }
                }
                else throw new ERR_OperationNotPermitted("(<<)","Number",rhs.type);
            }
            else {
                long lhs = content.i;

                if (rhs.type==ValueType.numberValue) {
                    if (rhs.isBig) { return new Value(lhs << rhs.content.bi); }
                    else { return new Value(lhs << rhs.content.i); }
                }
                else throw new ERR_OperationNotPermitted("(<<)","Number",rhs.type);
            }
        }
        else throw new ERR_OperationNotPermitted("(<<)",type,rhs.type);
    }

    Value opBinary(string op)(in Value rhs) const if (op == ">>") {
        if (type==ValueType.numberValue) {
            if (isBig) {
                BigInt lhs = content.bi;

                if (rhs.type==ValueType.numberValue) {
                    if (rhs.isBig) { return new Value(lhs >> rhs.content.bi); }
                    else { return new Value(lhs >> rhs.content.i); }
                }
                else throw new ERR_OperationNotPermitted("(>>)","Number",rhs.type);
            }
            else {
                long lhs = content.i;

                if (rhs.type==ValueType.numberValue) {
                    if (rhs.isBig) { return new Value(lhs >> rhs.content.bi); }
                    else { return new Value(lhs >> rhs.content.i); }
                }
                else throw new ERR_OperationNotPermitted("(>>)","Number",rhs.type);
            }
        }
        else throw new ERR_OperationNotPermitted("(>>)",type,rhs.type);
    }

    Value opBinary(string op)(in Value rhs) const if (op == "&") {
        if (type==ValueType.numberValue) {
            if (isBig) {
                BigInt lhs = content.bi;

                if (rhs.type==ValueType.numberValue) {
                    if (rhs.isBig) { return new Value(lhs & rhs.content.bi); }
                    else { return new Value(lhs & rhs.content.i); }
                }
                else throw new ERR_OperationNotPermitted("(&)","Number",rhs.type);
            }
            else {
                long lhs = content.i;

                if (rhs.type==ValueType.numberValue) {
                    if (rhs.isBig) { return new Value(lhs & rhs.content.bi); }
                    else { return new Value(lhs & rhs.content.i); }
                }
                else throw new ERR_OperationNotPermitted("(&)","Number",rhs.type);
            }
        }
        else throw new ERR_OperationNotPermitted("(&)",type,rhs.type);
    }

    Value opBinary(string op)(in Value rhs) const if (op == "|") {
        if (type==ValueType.numberValue) {
            if (isBig) {
                BigInt lhs = content.bi;

                if (rhs.type==ValueType.numberValue) {
                    if (rhs.isBig) { return new Value(lhs | rhs.content.bi); }
                    else { return new Value(lhs | rhs.content.i); }
                }
                else throw new ERR_OperationNotPermitted("(|)","Number",rhs.type);
            }
            else {
                long lhs = content.i;

                if (rhs.type==ValueType.numberValue) {
                    if (rhs.isBig) { return new Value(lhs | rhs.content.bi); }
                    else { return new Value(lhs | rhs.content.i); }
                }
                else throw new ERR_OperationNotPermitted("(|)","Number",rhs.type);
            }
        }
        else throw new ERR_OperationNotPermitted("(|)",type,rhs.type);
    }

    Value opBinary(string op)(in Value rhs) const if (op == "^") {
        if (type==ValueType.numberValue) {
            if (isBig) {
                BigInt lhs = content.bi;

                if (rhs.type==ValueType.numberValue) {
                    if (rhs.isBig) { return new Value(lhs ^ rhs.content.bi); }
                    else { return new Value(lhs ^ rhs.content.i); }
                }
                else throw new ERR_OperationNotPermitted("(^)","Number",rhs.type);
            }
            else {
                long lhs = content.i;

                if (rhs.type==ValueType.numberValue) {
                    if (rhs.isBig) { return new Value(lhs ^ rhs.content.bi); }
                    else { return new Value(lhs ^ rhs.content.i); }
                }
                else throw new ERR_OperationNotPermitted("(^)","Number",rhs.type);
            }
        }
        else throw new ERR_OperationNotPermitted("(^)",type,rhs.type);
    }

    Value opUnary(string op)() const if (op == "~") {
        if (type==ValueType.numberValue) {
            if (isBig) {
                BigInt lhs = content.bi;

                return new Value(~content.bi);
            }
            else {
                long lhs = content.i;

                return new Value(~content.i);
            }
        }
        else throw new ERR_OperationNotPermitted("(~)",type,"");
    }

    override bool opEquals(Object rh) {
        Value rhs = cast(Value)(rh);

        if (type==ValueType.numberValue) {
            if (isBig) {
                BigInt lhs = content.bi;

                switch (rhs.type) {
                    case ValueType.numberValue      : if (rhs.isBig) { return (lhs==rhs.content.bi); } else { return (lhs==rhs.content.i); }
                    case ValueType.realValue        : return false; //return (lhs == rhs.content.r);
                    case ValueType.booleanValue     : return false; //return (lhs == rhs.content.b);
                    default                         : return false;
                }

            }
            else {
                long lhs = content.i;

                switch (rhs.type) {
                    case ValueType.numberValue      : if (rhs.isBig) { return (lhs==rhs.content.bi); } else { return (lhs==rhs.content.i); }
                    case ValueType.realValue        : return (lhs == rhs.content.r);
                    case ValueType.booleanValue     : return (lhs == rhs.content.b);
                    default                         : return false;
                }
            }
        }
        else if (type==ValueType.realValue) {
            real lhs = content.r;

            switch (rhs.type) {
                case ValueType.numberValue      : if (rhs.isBig) { return false; /*return (lhs==rhs.content.bi);*/ } else { return (lhs==rhs.content.i); }
                case ValueType.realValue        : return (lhs == rhs.content.r);
                case ValueType.booleanValue     : return (lhs == rhs.content.b);
                default                         : return false;
            }
        }
        else if (type==ValueType.stringValue) {
            if (rhs.type==ValueType.stringValue) {
                return (content.s == rhs.content.s);
            }
            else return false;
        }
        else if (type==ValueType.booleanValue) {
            bool lhs = content.b;

            switch (rhs.type) {
                case ValueType.numberValue      : if (rhs.isBig) { return false; /*return (lhs==rhs.content.bi);*/ } else { return (lhs==rhs.content.i); }
                case ValueType.realValue        : return false; //return (lhs == rhs.content.r);
                case ValueType.booleanValue     : return (lhs==rhs.content.b);
                default                         : return false;
            }
        }
        else if (type==ValueType.arrayValue) {
            Value[] lhs = content.a;

            if (lhs.length != rhs.content.a.length) return false;

            foreach (i, Value item; lhs) {
                if (item != rhs.content.a[i]) return false;
            }

            return true;
        }
        else if (type==ValueType.dictionaryValue) {
            Context lhs = content.d;
            foreach (string nm, Value va; lhs) {
                Value dv = rhs.getValueFromDict(nm);

                if (dv is null) { return false; }
                else {
                    if (va!=dv) return false;
                }
            }

            return true;
        }
        else if (type==ValueType.functionValue) {
            if (rhs.type==ValueType.functionValue) {
                return (content.f == rhs.content.f);
            }
            else return false;
        }
        else if (type==ValueType.noValue) {
            if (rhs.type==ValueType.noValue) return true;
            else return false;
        }

        return (false);
    }

    int opCmp(in Value rhs) {
        if (this==rhs) return 0;

        if (type==ValueType.numberValue) {
            if (isBig) {
                BigInt lhs = content.bi;

                switch (rhs.type) {
                    case ValueType.numberValue      : if (rhs.isBig) { if (lhs > rhs.content.bi) return 1; else return -1; } else { if (lhs > rhs.content.i) return 1; else return -1; }
                    case ValueType.realValue        : throw new ERR_CannotCompareTypesError("Big Number",rhs.type); /*if (lhs > rhs.content.r) return 1; else return -1;*/
                    default                         : throw new ERR_CannotCompareTypesError(type,rhs.type);
                }
            }
            else {
                long lhs = content.i;

                switch (rhs.type) {
                    case ValueType.numberValue      : if (rhs.isBig) { if (lhs > rhs.content.bi) return 1; else return -1; } else { if (lhs > rhs.content.i) return 1; else return -1; }
                    case ValueType.realValue        : if (lhs > rhs.content.r) return 1; else return -1;
                    default                         : throw new ERR_CannotCompareTypesError(type,rhs.type);
                }
            }
        }
        else if (type==ValueType.realValue) {
            real lhs = content.r;

            switch (rhs.type) {
                case ValueType.numberValue      : if (rhs.isBig) { throw new ERR_CannotCompareTypesError(type,"Big Number"); } else { if (lhs > rhs.content.i) return 1; else return -1; }
                case ValueType.realValue        : if (lhs > rhs.content.r) return 1; else return -1;
                default                         : throw new ERR_CannotCompareTypesError(type,rhs.type);
            }
        }
        else if (type==ValueType.stringValue) {
            string lhs = content.s;

            switch (rhs.type) {
                case ValueType.stringValue      : if (lhs > rhs.content.s) return 1; else return -1;
                default                         : throw new ERR_CannotCompareTypesError(type,rhs.type);
            }
        }

        throw new ERR_CannotCompareTypesError(type,rhs.type);
    }

    string str() {
        switch (type) {
            case ValueType.numberValue      : if (isBig) { return to!string(content.bi); } else { return to!string(content.i); }
            case ValueType.realValue        : return to!string(content.r);
            case ValueType.booleanValue     : return to!string(content.b);
            case ValueType.stringValue      : return content.s;
            default                         : return "NULL";
        }
    }

    const string strImmut() {
        switch (type) {
            case ValueType.numberValue      : if (isBig) { return to!string(content.bi); } else { return to!string(content.i); }
            case ValueType.realValue        : return to!string(content.r);
            case ValueType.booleanValue     : return to!string(content.b);
            case ValueType.stringValue      : return content.s;
            default                         : return "NULL";
        }
    }

    string logify(int prepend=0, bool isKeyVal=false) {
        switch (type) {
            case ValueType.numberValue      : if (isBig) { return "\x1B[0;35m" ~ to!string(content.bi) ~ "\x1B[0;37m"; } else { return "\x1B[0;35m" ~ to!string(content.i) ~ "\x1B[0;37m"; }
            case ValueType.realValue        : return "\x1B[0;35m" ~ to!string(content.r) ~ "\x1B[0;37m";
            case ValueType.booleanValue     : return "\x1B[0;35m" ~ to!string(content.b) ~ "\x1B[0;37m";
            case ValueType.stringValue      : return "\x1B[0;33m" ~ "\"" ~ content.s ~ "\"" ~ "\x1B[0;37m";
            case ValueType.functionValue    : return "<function: 0x" ~ to!string(&content.f) ~ ">";
            case ValueType.arrayValue       : 
                string ret = "#(\n";
                string[] items;
                if (content.a.length==0) return "#()";
                foreach (Value v; content.a) {
                    items ~= replicate("\t",prepend)  ~ replicate(" ",isKeyVal ? LOGIFY_PADDING : 0) ~ "\t" ~ v.logify(prepend+1,isKeyVal) ~ "\n";
                }
                ret ~= items.join("");
                ret ~= replicate("\t",prepend) ~ replicate(" ",isKeyVal ? LOGIFY_PADDING : 0) ~ ")";
                return ret;
            case ValueType.dictionaryValue  :
                string ret = "#{\n";
                string[] items;
                auto sortedKeys = content.d.keys.array.sort();
                if (sortedKeys.length==0) return "#{}";
                foreach (string key; sortedKeys) {
                    Value v = getValueFromDict(key);
                    if (key.startsWith(":")) {
                        items ~= replicate("\t",prepend) ~ replicate(" ",isKeyVal ? LOGIFY_PADDING : 0) ~ "\t" ~ "\x1B[1;32m" ~ leftJustify(key,LOGIFY_PADDING) ~ "\x1B[0;37m" ~ "" ~ v.logify(prepend+1,true) ~ "\n";
                    }
                    else if (key.startsWith("_")) {
                        items ~= replicate("\t",prepend) ~ replicate(" ",isKeyVal ? LOGIFY_PADDING : 0) ~ "\t" ~ "\x1B[1;38;5;242m" ~ leftJustify(key,LOGIFY_PADDING) ~ "\x1B[0;37m" ~ "" ~ v.logify(prepend+1,true) ~ "\n";
                    }
                    else {
                        items ~= replicate("\t",prepend) ~ replicate(" ",isKeyVal ? LOGIFY_PADDING : 0) ~ "\t" ~ "\x1B[1;37m" ~ leftJustify(key,LOGIFY_PADDING) ~ "\x1B[0;37m" ~ "" ~ v.logify(prepend+1,true) ~ "\n";
                    }
                }
                ret ~= items.join("");
                ret ~= replicate("\t",prepend) ~ replicate(" ",isKeyVal ? LOGIFY_PADDING : 0) ~ "}";
                if (ret=="#{  }") ret = "#{}";
                return ret;
            case ValueType.objectValue      : return "<object: 0x" ~ to!string(&content.o) ~ ">";
            version(GTK) {
            case ValueType.gobjectValue     : return "<gobject: 0x" ~ to!string(&content.go) ~ ">";
            }
            case ValueType.noValue          : return "\x1B[0;31m" ~ "null" ~ "\x1B[0;37m";
            default                         : return "NULL"; // should never reach this point
        }
    }

    void doWrite(bool filterHiddenKeys=false) {
        switch (type) {
            case ValueType.numberValue      : if (isBig) { write(content.bi); } else { write(content.i); } break;
            case ValueType.realValue        : write(content.r); break;
            case ValueType.booleanValue     : write(content.b); break;
            case ValueType.stringValue      : write(content.s); break;
            case ValueType.functionValue    : write("<function: 0x" ~ to!string(&content.f) ~ ">"); break;
            case ValueType.arrayValue       : 
                string ret = "#(";
                string[] items;
                foreach (Value v; content.a) {
                    items ~= v.stringify();
                }
                ret ~= items.join(" ");
                ret ~= ")";
                write(ret);
                break;
            case ValueType.dictionaryValue  :
                string ret = "#{ ";
                string[] items;
                auto sortedKeys = content.d.keys.array.sort();
                foreach (string key; sortedKeys) {
                    if (!filterHiddenKeys || (filterHiddenKeys && !key.startsWith("_"))) {
                        Value v = getValueFromDict(key);
                        items ~= key ~ " " ~ v.stringify();
                    }
                }
                ret ~= items.join(", ");
                ret ~= " }";
                if (ret=="#{  }") ret = "#{}";
                write(ret);
                break;
            case ValueType.noValue          : write("null"); break;
            case ValueType.objectValue      : write("<object: 0x" ~ to!string(&content.o) ~ ">"); break;
            version(GTK) {
            case ValueType.gobjectValue     : write("<gobject: 0x" ~ to!string(&content.go) ~ ">"); break;
            }
            default                         : write("NULL"); break; // should never reach this point
        }
    }

    void doWriteln(bool filterHiddenKeys=false) {
        switch (type) {
            case ValueType.numberValue      : if (isBig) { writeln(content.bi); } else { writeln(content.i); } break;
            case ValueType.realValue        : writeln(content.r); break;
            case ValueType.booleanValue     : writeln(content.b); break;
            case ValueType.stringValue      : writeln(content.s); break;
            case ValueType.functionValue    : writeln("<function: 0x" ~ to!string(&content.f) ~ ">"); break;
            case ValueType.arrayValue       : 
                string ret = "#(";
                string[] items;
                foreach (Value v; content.a) {
                    items ~= v.stringify();
                }
                ret ~= items.join(" ");
                ret ~= ")";
                writeln(ret);
                break;
            case ValueType.dictionaryValue  :
                string ret = "#{ ";
                string[] items;
                auto sortedKeys = content.d.keys.array.sort();
                foreach (string key; sortedKeys) {
                    if (!filterHiddenKeys || (filterHiddenKeys && !key.startsWith("_"))) {
                        Value v = getValueFromDict(key);
                        items ~= key ~ " " ~ v.stringify();
                    }
                }
                ret ~= items.join(", ");
                ret ~= " }";
                if (ret=="#{  }") ret = "#{}";
                writeln(ret);
                break;
            case ValueType.noValue          : writeln("null"); break;
            case ValueType.objectValue      : writeln("<object: 0x" ~ to!string(&content.o) ~ ">"); break;
            version(GTK) {
            case ValueType.gobjectValue     : writeln("<gobject: 0x" ~ to!string(&content.go) ~ ">"); break;
            }
            default                         : writeln("NULL"); break; // should never reach this point
        }
    }

    string stringify(bool withquotes=true, bool filterHiddenKeys=false) {
        switch (type) {
            case ValueType.numberValue      : if (isBig) { return to!string(content.bi); } else { return to!string(content.i); }
            case ValueType.realValue        : return to!string(content.r);
            case ValueType.booleanValue     : return to!string(content.b);
            case ValueType.stringValue      : if (withquotes) { return "\"" ~ content.s ~ "\""; } else { return content.s; }
            case ValueType.functionValue    : return "<function: 0x" ~ to!string(&content.f) ~ ">";
            case ValueType.arrayValue       : 
                string ret = "#(";
                string[] items;
                foreach (Value v; content.a) {
                    items ~= v.stringify();
                }
                ret ~= items.join(" ");
                ret ~= ")";
                return ret;
            case ValueType.dictionaryValue  :
                string ret = "#{ ";
                string[] items;
                auto sortedKeys = content.d.keys.array.sort();
                foreach (string key; sortedKeys) {
                    if (!filterHiddenKeys || (filterHiddenKeys && !key.startsWith("_"))) {
                        Value v = getValueFromDict(key);
                        items ~= key ~ " " ~ v.stringify();
                    }
                }
                ret ~= items.join(", ");
                ret ~= " }";
                if (ret=="#{  }") ret = "#{}";
                return ret;
            case ValueType.noValue          : return "null";
            case ValueType.objectValue      : return "<object: 0x" ~ to!string(&content.o) ~ ">";
            version(GTK) {
            case ValueType.gobjectValue      : return "<gobject: 0x" ~ to!string(&content.go) ~ ">";
            }
            default                         : return "NULL"; // should never reach this point
        }
    }

    string stringifyb(bool withquotes=true) { 
        switch (type) {
            case ValueType.numberValue      : if (isBig) { return to!string(content.bi); } else { return to!string(content.i); }
            case ValueType.realValue        : return to!string(content.r);
            case ValueType.booleanValue     : return to!string(content.b);
            case ValueType.stringValue      : if (withquotes) { return "\"" ~ content.s ~ "\""; } else { return content.s; }
            case ValueType.functionValue    : return "<function: 0x" ~ to!string(&content.f) ~ ">";
            case ValueType.arrayValue       : 
                string ret = "#(";
                string[] items;
                foreach (Value v; content.a) {
                    items ~= v.stringifyb();
                }
                ret ~= items.join(" ");
                ret ~= ")";
                return ret;
            case ValueType.dictionaryValue  :
                string ret = "#{ ";
                string[] items;
                auto sortedKeys = content.d.keys.array.sort();
                foreach (string key; sortedKeys) {
                    Value v = getValueFromDict(key);
                    items ~= key ~ " " ~ v.stringifyb();
                }
                ret ~= items.join(", ");
                ret ~= " }";
            
                return ret;
            case ValueType.noValue          : return "null";
            case ValueType.objectValue      : return "<object: 0x" ~ to!string(&content.o) ~ ">";
            version(GTK) {
            case ValueType.gobjectValue      : return "<gobject: 0x" ~ to!string(&content.go) ~ ">";
            }
            default                         : return "NULL";
        }
    }

    const string stringifyImmut() {
        switch (type) {
            case ValueType.numberValue      : if (isBig) { return to!string(content.bi); } else { return to!string(content.i); }
            case ValueType.realValue        : return to!string(content.r);
            case ValueType.booleanValue     : return to!string(content.b);
            case ValueType.stringValue      : return "\"" ~ content.s ~ "\"";
            case ValueType.functionValue    : return "<function: 0x" ~ to!string(&content.f) ~ ">";
            case ValueType.arrayValue       : 
                string ret = "#(";
                string[] items;
                foreach (const Value v; content.a) {
                    items ~= v.stringifyImmut();
                }
                ret ~= items.join(" ");
                ret ~= ")";
                return ret;
            case ValueType.dictionaryValue  :
                string ret = "#{ ";
                string[] items;
                auto sortedKeys = content.d.keys.array.sort();
                foreach (string key; sortedKeys) {
                    Value v = getValueFromDictImmut(key);
                    items ~= key ~ " " ~ v.stringifyImmut();
                }
                ret ~= items.join(", ");
                ret ~= " }";
                return ret;
            case ValueType.noValue          : return "null";
            default                         : return "NULL";
        }
    }

    void print() {
        switch (type) {
            case ValueType.numberValue      :   if (isBig) { write(to!string(content.bi)); } else { write(to!string(content.i)); } break;
            case ValueType.realValue        :   write(to!string(content.r)); break;
            case ValueType.booleanValue     :   write(to!string(content.b)); break;
            case ValueType.stringValue      :   write(content.s); break;
            case ValueType.arrayValue       :
                write("[");
                for (int i=0; i<content.a.length; i++) {
                    content.a[i].print();
                    if (i!=content.a.length-1) write(",");
                }
                write("]"); break;

            case ValueType.dictionaryValue  :
                write("[");
                int i;
                foreach (string nm, Value va; content.d) {
                    write(nm);
                    write(" : ");
                    va.print();
                    if (i!=content.d.length-1) write(",");
                    i++;
                }
                write("]"); break;
            default:
                break;
        }
    }

    override string toString() {
        string ret = "";
        switch (type) {
            case ValueType.numberValue      :   if (isBig) { ret ~= "bigint(" ~ to!string(content.bi) ~ ")"; } else { ret ~= "int(" ~ to!string(content.i) ~ ")"; } break;
            case ValueType.realValue        :   ret ~= "real(" ~ to!string(content.r) ~ ")"; break;
            case ValueType.booleanValue     :   ret ~= "bool(" ~ to!string(content.b) ~ ")"; break;
            case ValueType.stringValue      :   ret ~= "str(" ~ to!string("\"" ~ content.s ~ "\"") ~ ")"; break;
            case ValueType.arrayValue       :
                ret ~= "array([";
                for (int i=0; i<content.a.length; i++) {
                    ret ~= content.a[i].toString();
                    if (i!=content.a.length-1) ret ~= ", ";
                }
                ret ~= "])"; break;

            case ValueType.dictionaryValue  :
                ret ~= "dict([";
                int i;
                foreach (string nm, Value va; content.d) {
                    ret ~= nm ~ ":" ~ va.toString();
                    if (i!=content.d.length-1) ret ~= ", ";
                    i++;
                }
                ret ~= "])"; break;
            default:
                break;
        }
        return ret;
    }

    const string toString() {
        string ret = "";
        switch (type) {
            case ValueType.numberValue      :   if (isBig) { ret ~= "bigint(" ~ to!string(content.bi) ~ ")"; } else { ret ~= "int(" ~ to!string(content.i) ~ ")"; } break;
            case ValueType.realValue        :   ret ~= "real(" ~ to!string(content.r) ~ ")"; break;
            case ValueType.booleanValue     :   ret ~= "bool(" ~ to!string(content.b) ~ ")"; break;
            case ValueType.stringValue      :   ret ~= "str(" ~ to!string("\"" ~ content.s ~ "\"") ~ ")"; break;
            case ValueType.arrayValue       :
                ret ~= "array([";
                for (int i=0; i<content.a.length; i++) {
                    ret ~= content.a[i].toString();
                    if (i!=content.a.length-1) ret ~= ", ";
                }
                ret ~= "])"; break;

            case ValueType.dictionaryValue  :
                ret ~= "dict([";
                int i;
                foreach (const string nm, const Value va; content.d) {
                    ret ~= nm ~ ":" ~ va.toString();
                    if (i!=content.d.length-1) ret ~= ", ";
                    i++;
                }
                ret ~= "])"; break;
            default:
                break;
        }
        return ret;
    }

    alias HashValue = (X) => toHexString((new SHA1Digest()).digest(X));

    string hash() {
        switch (type) {
            case ValueType.numberValue      :   if (isBig) { return "BIG"; } else { return HashValue(to!string(content.i)); }
            case ValueType.realValue        :   return HashValue(to!string(content.r));
            case ValueType.stringValue      :   return HashValue(content.s);
            case ValueType.booleanValue     :   return HashValue(to!string(content.b));
            case ValueType.arrayValue       :   return HashValue(content.a.map!(v=> v.hash()).join(""));
            case ValueType.dictionaryValue  :   string ret = "";
                                                foreach (string nm, Value va; content.d) {
                                                    ret ~= (new Value(nm)).hash() ~ va.hash();
                                                }
                                                return HashValue(ret);
            case ValueType.functionValue    :   return HashValue(to!string(&content.f));
            case ValueType.noValue          :   return "NIL";
            default                         :   return "";
        }
    }

    Value dup() {
        Value ret = new Value();
        ret.type = type;

        switch (type) {
            case ValueType.numberValue : if (isBig) { ret.content.bi = content.bi; } else { ret.content.i = content.i; } break;
            case ValueType.realValue : ret.content.r = content.r; break;
            case ValueType.stringValue : ret.content.s = content.s.dup; break;
            case ValueType.booleanValue : ret.content.b = content.b; break;
            case ValueType.functionValue : ret.content.f = content.f.dup; break;
            case ValueType.arrayValue : 
                ret.content.a = [];
                foreach (Value vv; content.a) content.a ~= vv.dup();
                break;
            case ValueType.dictionaryValue :
                content.d = cast(Context)null;//Context(null,ContextType.dictionaryContext);
                foreach (string nm, Value va; content.d)
                    content.d[nm] = va.dup; break;
            default: break;
        }

        return ret;
    }

    ~this() {
        //writeln("Destructor called");
        //debug writeln("Destroying: " ~ to!string(this));
    }
}

///////////////////////
/// Unittests
///////////////////////

unittest {
    // constructors
    assert((new Value(2)).content.i==2);
    assert((new Value("test")).content.s=="test");
    assert((new Value(BigInt("1231312312312312312312313"))).content.bi==BigInt("1231312312312312312312313"));
    assert((new Value(true)).content.b==true);
}

unittest {
    // opEquals
    assert((new Value(2))==(new Value(2)));
    assert((new Value("test"))==(new Value("test")));
    assert((new Value("test"))==(new Value("test")));
    assert((new Value(BigInt("1231312312312312312312313")))==(new Value(BigInt("1231312312312312312312313"))));
    assert((new Value(true))==(new Value(true)));
    assert((new Value([new Value(1),new Value("test"),new Value(true)]))==(new Value([new Value(1),new Value("test"),new Value(true)])));
    assert((new Value(["one","two","three"]))==(new Value([new Value("one"),new Value("two"),new Value("three")])));
}