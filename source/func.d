/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: func.d
 *****************************************************************/

module func;

// Imports

import std.algorithm;
import std.array;
import std.conv;
import std.digest.sha;
import std.stdio; 
import std.string;
import std.typecons;

import parser.expression;
import parser.expressions;
import parser.identifier;
import parser.statements;

import compiler;
import context;
import globals;
import panic;
import value;

// Definitions

enum FuncType
{
    userFunc,
    systemFunc
}

// Functions

class Func {

    string name;
    string description;
    FuncType type;
    Statements block;

    ExpressionType[][] expressionConstraints;
    ValueType[][] valueConstraints;
    ValueType[] returnValues;

    Value delegate(Value) innerFunc;
    bool hasInnerFunc;

    ulong minArgs;
    ulong maxArgs;

    string[] ids;

    Context parentContext;
    Value parentThis;

    string namespace;

    bool isVariadic;

    // system functions
    this (string n, string descr, ValueType[][] vc = [], ValueType[] rets = []) {
        hasInnerFunc = false;
        name = n;
        block = null;
        type = FuncType.systemFunc;

        description = descr;

        minArgs = -1;
        maxArgs = 100; 

        isVariadic = false;

        if (vc!=[]) {
            valueConstraints = vc;
            minArgs = 100;
            maxArgs = 0;
            foreach (ValueType[] constraints; valueConstraints) {
                if (constraints.canFind(vV))  {
                    isVariadic = true;
                    maxArgs = 100;
                }
                if (constraints.length<minArgs) minArgs = constraints.length;
                if (constraints.length>maxArgs) maxArgs = constraints.length;
            }
        }

        returnValues = rets;

        parentContext = null;
        parentThis = null;
/*
        if (n.indexOf(":")!=-1) {
            string[] parts = n.split(":");
            namespace = parts[0];
            name = parts[1];
        } 
        else {
            namespace = null;
        }*/
    }

    // user functions
    this (string n, Statements b = null, ValueType[][] vc = [], string[] idents = []) {
        hasInnerFunc = false;
        name = n;
        block = b;

        if (b is null) type = FuncType.systemFunc;
        else type = FuncType.userFunc;

        minArgs = -1;
        maxArgs = 100;

        isVariadic = false;

        if (vc!=[]) {
            valueConstraints = vc;
            minArgs = 100;
            maxArgs = 0;
            foreach (ValueType[] constraints; valueConstraints) {
                if (constraints.canFind(vV))  {
                    isVariadic = true;
                    maxArgs = 100;
                }
                if (constraints.length<minArgs) minArgs = constraints.length;
                if (constraints.length>maxArgs) maxArgs = constraints.length;
            }

            //debug writeln("setting func: " ~ name ~ " minArgs: " ~ to!string(minArgs) ~ ", maxArgs: " ~ to!string(maxArgs));
        }

        ids = idents;

        parentContext = null;
        parentThis = null;

        if (n.indexOf(":")!=-1) {
            string[] parts = n.split(":");
            namespace = parts[0];
            name = parts[1];
        } 
        else {
            namespace = null;
        }
    }

    this (Func f) {
        innerFunc = f.innerFunc;
        hasInnerFunc = f.hasInnerFunc;
        name = f.name;
        block = f.block;
        type = f.type;
        valueConstraints = f.valueConstraints;
        expressionConstraints = f.expressionConstraints;
        returnValues = f.returnValues;
        ids = f.ids;
        parentContext = f.parentContext;
        parentThis = f.parentThis;
        namespace = f.namespace;
    }

    this (Value delegate(Value) inner) {
        hasInnerFunc = true;
        innerFunc = inner;
    }

    string getFullName() {
        string ret = "";

        if (namespace !is null) ret ~=  namespace ~ ":";
        if (name !is null) ret ~= name;

        return ret;
    }

    Value executeInnerFunc(Value values = null) {
        return innerFunc(values);
    }

    Value execute(Value values = null, Value* v=null, string memo=null) {
        if (hasInnerFunc) return executeInnerFunc(values);

        //writeln(Glob.memoize);
        string hsh = null;
        if (memo !is null) { 
            if (Glob.memoize.canFind(memo)) {
                hsh = memo ~ "_" ~ values.hash();

                if ((hsh in Glob.memoized) !is null) {
                    //writeln("Found memoized result for: " ~ values.stringify());
                    return Glob.memoized[hsh];
                }
            }
        }
        /*
        if (Glob.memoize.canFind(to!string(f))) {

            Glob.blockStack.push((*f).block);

            Value ret = (*f).executeMemoized(expressions,to!string(f),v);

            if (Glob.blockStack.lastItem() is (*f).block) {
                Glob.blockStack.pop();
            }

            return ret;
        }
        */
        //writeln("FUNC::execute [begin] -> " ~ name);
        if (parentContext !is null) { 
            Glob.contextStack.push(parentContext);
        }

        bool thisWasAlreadySet = false;

        if (parentContext !is null) {
            if (Glob.getSymbol(new Identifier("this")) !is null) thisWasAlreadySet = true;
            Glob.setGlobalSymbol("this", parentThis);
        }

        if (name=="" || name is null) Glob.contextStack.push(new Context());
        else Glob.contextStack.push(new Context(ContextType.functionContext));

        if (Glob.trace && name !is null && name.strip()!="") {
            write(" ".replicate(Glob.contextStack.size()) ~ to!string(Glob.contextStack.size()) ~ "- " ~ name ~ " : ");
        }

        if ((ids.length>0) && (values is null)) {
            string funcName;
            if (name==null) funcName = "<user function>";
            else funcName = name;

            throw new ERR_FunctionCallErrorNotEnough(name,ids.length,0,true);
        }

        if ((ids.length>0) && (values !is null)) {
            if (values.type==aV) {
                 if (values.content.a.length!=ids.length) {
                    string funcName;
                    if (name==null) funcName = "<user function>";
                    else funcName = name;

                    if (ids.length>values.content.a.length) throw new ERR_FunctionCallErrorNotEnough(name,ids.length,values.content.a.length,true);
                    else throw new ERR_FunctionCallErrorTooMany(name,ids.length,values.content.a.length,true);
                }
            } else {
                if (1!=ids.length) {
                    string funcName;
                    if (name==null) funcName = "<user function>";
                    else funcName = name;

                    if (ids.length>1) throw new ERR_FunctionCallErrorNotEnough(name,ids.length,1,true);
                    else throw new ERR_FunctionCallErrorTooMany(name,ids.length,1,true);
                }
            }
            
        }

        if (values !is null) {
            //writeln("executing function: " ~ name ~ " with ids: " ~ to!string(ids));
            if (values.type==aV) {
                foreach (i, string ident; ids) {
                    Glob.setSymbol(new Identifier(ident), values.content.a[i], true);
                }   
            }
            else {
                if (ids.length==1) {
                    Glob.setSymbol(new Identifier(ids[0]), values, true);
                }
            }

            if (values !is null) {
                Glob.setSymbol(new Identifier(ARGS), values, true);
                if (Glob.trace) {
                    if (values.type==aV)
                        writeln(values.content.a.map!(v=>v.stringify()).array.join(", "));
                }
            }
        }

        try {
            // ADDED
            //writeln("FUNC::execute  -> pushing block to stack and executing: " ~ name);
            Glob.blockStack.push(block);

            debug writeln("contextStack: " ~ Glob.contextStack.str());
            
            Value ret = block.execute(v);

            if (sourceTree.statements is block) {
                //writeln("FUNC====> STATEMENTS is ROOT");
            }
            else {
                //writeln("FUNC====> Statements is some random block");
            }

            // ADDED
            if (!Glob.blockStack.isEmpty() && Glob.blockStack.lastItem() is block) {
                //writeln("FUNC::execute -> popping block from stack after executing: " ~ name);
                Glob.blockStack.pop();
            } else {
                // something was returned before
                if ((name=="" || name is null) && (Glob.blockStack.size()>0)) {

                    //writeln("Glob.globStack => " ~ Glob.blockStack.str());

                    //writeln("FUNC::execute -> reTHROW (not named block)");
                    if (!thisWasAlreadySet) Glob.unsetGlobalSymbol("this");

                    debug writeln("contextStack: " ~ Glob.contextStack.str());

                    if (parentContext !is null && Glob.contextStack.size() > 1) { 
                        debug writeln("POP: contextStack");
                        Glob.contextStack.pop();
                    }

                    debug writeln("contextStack: " ~ Glob.contextStack.str());

                    if (Glob.contextStack.size() > 1) {
                        debug writeln("POP: contextStack");
                        Glob.contextStack.pop();
                    }

                    debug writeln("contextStack: " ~ Glob.contextStack.str());

                    throw new ReturnResult(ret);
                }
            }

            // cleanup

            if (!thisWasAlreadySet) Glob.unsetGlobalSymbol("this");

            debug writeln("contextStack: " ~ Glob.contextStack.str());

            if (parentContext !is null && Glob.contextStack.size() > 1) { 
                debug writeln("POP: contextStack");
                Glob.contextStack.pop();
            }

            debug writeln("contextStack: " ~ Glob.contextStack.str());

            if (Glob.contextStack.size() > 1) {
                debug writeln("POP: contextStack");
                Glob.contextStack.pop();
            }

            debug writeln("contextStack: " ~ Glob.contextStack.str());

            //writeln("FUNC::execute [end] -> " ~ name);

            if (hsh !is null) {
                //writeln("STORE memoized result for: " ~ values.stringify());
                Glob.memoized[hsh] = ret;
            }

            return ret;

        }
        catch(Exception e) {
            //debug writeln("FUNC::execute  (" ~ name ~ ")-> got exception; reTHROW");
            throw e;
        }
    }

    Value execute(Expressions ex, string hId=null) {
        Value values = ex.evaluate(true);

        return execute(values);
    }

    Value executeWithRef(Expressions ex,Value* v=null) {
        Value values = ex.evaluate(true);

        return execute(values,v);
    }

    Value executeMemoized(Expressions ex, string memo,Value* v=null) {
        Value values = ex.evaluate(true);

        string hsh = memo ~ "_" ~ values.hash();

        if ((hsh in Glob.memoized) is null) {
            Value ret = execute(values,v);
            Glob.memoized[hsh] = ret;

            return ret;
        }
        else {
            return Glob.memoized[hsh];
        }
    }

    string getAcceptedConstraintsDescription() {
        string[] acceptedConstraints = [];
        foreach (ValueType[] constraints; valueConstraints) {
            acceptedConstraints ~= constraints.map!(c => "" ~ c).array.join("/");
            //debug writeln(constraints.map!(c => "" ~ c).array.join("/"));
        }
        return acceptedConstraints.join(" or ");
    }

    string getReturnValuesDescription() {
        return returnValues.map!(m => "" ~ m).array.join(" or ");
    }

    Value[] validate(Expressions ex) {
        if (ex.lst.length < minArgs) throw new ERR_FunctionCallErrorNotEnough(name, minArgs, ex.lst.length);

        if (!isVariadic) {
            if (ex.lst.length > maxArgs) throw new ERR_FunctionCallErrorTooMany(name, maxArgs, ex.lst.length);
        }

        Value[] ret;
        
        foreach (Expression e; ex.lst) {
            Value vv = e.evaluate();
            ret ~= vv;
        }

        if (!isVariadic) {
            foreach (ValueType[] constraints; valueConstraints.filter!(c => c.length == ex.lst.length)) {
                bool passingConstraint = true;
                foreach (i, ValueType constraint; constraints) {
                    if (constraint != xV) {
                        if (constraint != ret[i].type) {
                            passingConstraint = false;
                        }
                    }
                }
                if (passingConstraint) return ret;
            }
        }
        else {
            foreach (ValueType[] constraints; valueConstraints) {
                bool passingConstraint = true;
                foreach (i, ValueType constraint; constraints) {
                    if (constraint != xV && constraint != vV) {
                        if (constraint != ret[i].type) {
                            passingConstraint = false;
                        }
                    }
                }
                if (passingConstraint) return ret;
            }
        }

        string givenTypes = ret.map!(c => "" ~ c.type).array.join("/");

        throw new ERR_FunctionCallConstraintsError(name,getAcceptedConstraintsDescription(),givenTypes);
    }

    Value validateValue(Expressions ex, int i, ValueType[] vts) {
        Value evaluated = ex.lst[i].evaluate();

        bool valueOK = false;

        foreach (ValueType vt; vts) {
            if (evaluated.type == vt) valueOK = true;
        }

        if (valueOK) return evaluated;
        else {
            throw new ERR_FunctionCallValueError(name, i, vts.map!(v => "" ~ v).array.join(" or "), evaluated.type);
        }
    }

    string markdownish() {
        return "| **" ~ getFullName() ~ "** | " ~ description ~ " | [" ~ getAcceptedConstraintsDescription() ~ "] -> " ~ getReturnValuesDescription() ~ " |";
    }

    string markdownishWithNamespace() {
        return "| " ~ namespace ~ " | **" ~ name ~ "** | " ~ description ~ " | [" ~ getAcceptedConstraintsDescription() ~ "] -> " ~ getReturnValuesDescription() ~ " |";
    }

    string sublimeish() {
        if (getFullName()!=name)
            return getFullName() ~ "|" ~ name ~ "|";
        else
            return name;
    }

    string sublimeishWithNamespace(bool isCore) {
        if (isCore) return namespace ~ ":" ~ name ~ "|" ~ name ~ "|";
        else return namespace ~ ":" ~ name ~ "|";
    }

    void inspect(string useName=this.name, bool full=false) {
        if (full) {
            writeln("  Function : \x1B[37m\x1B[1m" ~ getFullName() ~ "\x1B[0m");
            writeln("         # | " ~ description);
            writeln();
            writeln("     usage | " ~ useName ~ " [" ~  getAcceptedConstraintsDescription() ~ "]");
            writeln("        -> | " ~  getReturnValuesDescription());
        }
        else {
            write("  " ~ leftJustify(useName,30) ~ " ");

            auto parts = useName.split(":");
            if (Glob.activeNamespaces.canFind(parts[0])) write(" * ");
            else write("   ");
            
            writeln("[" ~ getAcceptedConstraintsDescription() ~ "] -> " ~ getReturnValuesDescription());
        }
    }

    Func dup() {
        Func ret = new Func(name,block,valueConstraints,ids);
        ret.parentContext = parentContext.dup;
        ret.parentThis = parentThis.dup;

        return ret;
    }
}