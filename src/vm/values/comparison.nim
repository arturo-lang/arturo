#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: vm/values/comparison.nim
#=======================================================

## Comparison operators for Value objects.

#=======================================
# Libraries
#=======================================

import lenientops, tables, times, unicode

when defined(WEB):
    import std/jsbigints
    
when not defined(NOGMP):
    import helpers/bignums as BignumsHelper

import vm/values/custom/[vcolor, vcomplex, vlogical, vquantity, vrange, vrational, vregex, vversion]
import vm/values/value
import vm/values/operators

#=======================================
# Forward declarations
#=======================================

proc `==`*(x: Value, y: Value): bool {.inline, enforceNoRaises.}

#=======================================
# Helpers
#=======================================

proc `==`*(x: ValueArray, y: ValueArray): bool {.inline, enforceNoRaises.} =
    if x.len != y.len: return false
    for i,child in x:
        if not (child==y[i]): return false
    return true

#=======================================
# Methods
#=======================================

# TODO(VM/values/comparison) Verify all value types are properly handled by all overloads
#  labels: vm, values, enhancement, unit-test

proc `==`*(x: Value, y: Value): bool =
    if x.kind in {Integer, Floating, Rational} and y.kind in {Integer, Floating, Rational}:
        if x.kind==Integer:
            if y.kind==Integer: 
                if likely(x.iKind==NormalInteger and y.iKind==NormalInteger):
                    return x.i==y.i
                elif x.iKind==NormalInteger and y.iKind==BigInteger:
                    when defined(WEB):
                        return big(x.i)==y.bi
                    elif not defined(NOGMP):
                        return x.i==y.bi
                elif x.iKind==BigInteger and y.iKind==NormalInteger:
                    when defined(WEB):
                        return x.bi==big(y.i)
                    elif not defined(NOGMP):
                        return x.bi==y.i
                else:
                    when defined(WEB) or not defined(NOGMP):
                        return x.bi==y.bi
            elif y.kind==Rational:
                if likely(x.iKind==NormalInteger):
                    return toRational(x.i)==y.rat
                else:
                    return false
            else: 
                if x.iKind==NormalInteger:
                    return float(x.i)==y.f
                else:
                    when defined(WEB):
                        return x.bi==big(int(y.f))
                    elif not defined(NOGMP):
                        return (x.bi)==int(y.f)
        elif x.kind==Rational:
            if y.kind==Integer:
                if likely(y.iKind==NormalInteger):
                    return x.rat == toRational(y.i)
                else:
                    return false
            elif y.kind==Rational:
                return x.rat == y.rat
            else:
                return x.rat == toRational(y.f)
        else:
            if y.kind==Integer: 
                if y.iKind==NormalInteger:
                    return x.f==float(y.i)
                else:
                    when defined(WEB):
                        return big(int(x.f))==y.bi
                    elif not defined(NOGMP):
                        return int(x.f)==y.bi        
            elif y.kind==Rational:
                return toRational(x.f)==y.rat
            else: return x.f==y.f
    elif x.kind == Quantity or y.kind == Quantity:
        if x.kind == Quantity:
            if y.kind == Quantity:
                if x.unit.kind != y.unit.kind: return false
                return x.nm == convertQuantityValue(y.nm, y.unit.name, x.unit.name)
            else:
                return x.nm == y
        else:
            return x == y.nm
    else:
        if x.kind != y.kind: return false

        case x.kind:
            of Null: return true
            of Logical: return x.b == y.b
            of Complex: return x.z == y.z
            of Version:
                return x.version == y.version
            of Type: return x.t == y.t
            of Char: return x.c == y.c
            of String,
               Word,
               Label,
               Literal,
               Attribute,
               AttributeLabel: return x.s == y.s
            of Path,
               PathLabel: return x.p == y.p
            of Symbol: return x.m == y.m
            of Regex: return x.rx == y.rx
            of Binary: return x.n == y.n
            of Bytecode: return x.trans[] == y.trans[]
            of Inline,
               Block:

                if x.a.len != y.a.len: return false

                for i,child in x.a:
                    if not (child==y.a[i]): return false

                return true

            of Range:
                return x.rng == y.rng

            of Dictionary:
                if x.d.len != y.d.len: return false

                for k,v in pairs(x.d):
                    if not y.d.hasKey(k): return false
                    if not (v==y.d[k]): return false

                return true

            of Object:
                if (let compareMethod = x.proto.methods.getOrDefault("compare", nil); not compareMethod.isNil):
                    return x.proto.doCompare(x,y) == 0
                else:
                    if x.o.len != y.o.len: return false

                    for k,v in pairs(x.o):
                        if not y.o.hasKey(k): return false
                        if not (v==y.o[k]): return false

                    return true
            of Store:
                return x.sto.path == y.sto.path and x.sto.kind == y.sto.kind
            of Color:
                return x.l == y.l
            of Function:
                if x.fnKind==UserFunction:
                    return x.params == y.params and x.main == y.main and x.exports == y.exports
                else:
                    return x.action == y.action
            of Database:
                if x.dbKind != y.dbKind: return false
                when not defined(NOSQLITE):
                    if x.dbKind==SqliteDatabase: return cast[uint](x.sqlitedb) == cast[uint](y.sqlitedb)
                    #elif x.dbKind==MysqlDatabase: return cast[ByteAddress](x.mysqldb) == cast[ByteAddress](y.mysqldb)
            of Date:
                return x.eobj[] == y.eobj[]
            else:
                return false

# TODO(VM/values/comparison) add `<`/`>` support for Complex values
#  currently, `=` is supported but not `<` and `>`!
#  Since Complex values encapsulate a VComplex object (from values/custom/vcomplex)
#  the ideal implementation would be done there (adding a `>` and `<` operator to VComplex)
#  and then link the method here :-)
#  see also: https://github.com/arturo-lang/arturo/pull/1139
#  labels: critical,bug,values

# TODO(VM/values/comparison) add `<`/`>` support for Attribute values
#  currently, `=` is supported but not `<` and `>`!
#  the logic should be the same as with normal strings/words/etc
#  see also: https://github.com/arturo-lang/arturo/pull/1139
#  labels: bug,values

# TODO(VM/values/comparison) add `<`/`>` support for AttributeLabel values
#  currently, `=` is supported but not `<` and `>`!
#  the logic should be the same as with normal strings/words/etc
#  see also: https://github.com/arturo-lang/arturo/pull/1139
#  labels: bug,values

# TODO(VM/values/comparison) how should we handle Dictionary values?
#  right now, both `<` and `>` simply return false
#  but is it even a normal idea to compare a Dictionary with something else, or
#  another dictionary for that matter?
#  How do other languages (e.g. Ruby, Python) handle this?
#  If the final decision is to not support this, then we should throw an appropriate
#  error message (e.g. "cannot compare Dictionary values"), along with an appropriate
#  (new) error template at VM/errors
#  see also: https://github.com/arturo-lang/arturo/pull/1139
#  labels: enhancement,values,open discussion

# TODO(VM/values/comparison) how should we handle Object values?
#  right now, Object make feature a custom `compare` method which is called an used
#  for the comparison. However, if there is no such method, we end up having the exact
#  same issues we have with Dictionaries. So, how is that to be dealt with?
#  see also: https://github.com/arturo-lang/arturo/pull/1139
#  labels: enhancement,values,open discussion

# TODO(VM/values/comparison) add `<`/`>` support for Path values?
#  currently, `=` is supported but not `<` and `>`!
#  the logic should be the same as with blocks, as it's - internally -
#  technically the exact same thing.
#  But then again, it seems a bit weird as a notion. Any ideas?
#  see also: https://github.com/arturo-lang/arturo/pull/1139
#  labels: bug,values,open discussion

# TODO(VM/values/comparison) add `<`/`>` support for PathLabel values?
#  currently, `=` is supported but not `<` and `>`!
#  the logic should be the same as with blocks, as it's - internally -
#  technically the exact same thing.
#  But then again, it seems a bit weird as a notion. Any ideas?
#  see also: https://github.com/arturo-lang/arturo/pull/1139
#  labels: bug,values,open discussion

# TODO(VM/values/comparison) add `<`/`>` support for Regex values?
#  currently, `=` is supported but not `<` and `>`!
#  Another tricky one: the logic should be either the same as with strings,
#  or disallow comparison altogether and throw an error.
#  In the first case, since Regex values encapsulate a VRegex object (from values/custom/vregex)
#  the ideal implementation would be done there (adding a `>` and `<` operator to VRegex)
#  and then link the method here :-)
#  labels: bug,values,open discussion

# TODO(VM/values/comparison) add `<`/`>` support for Binary values
#  currently, `=` is supported but not `<` and `>`!
#  Preferrably, the implementation should go to values/custom/vbinary
#  and then integrate it here.
#  see also: https://github.com/arturo-lang/arturo/pull/1139
#  labels: bug,values

# TODO(VM/values/comparison) add `<`/`>` support for Range values
#  currently, `=` is supported but not `<` and `>`!
#  Preferrably, the implementation should go to values/custom/vrange
#  and then integrate it here.
#  The question is: when is range A smaller than range B? How do other
#  languages handle this?
#  see also: https://github.com/arturo-lang/arturo/pull/1139
#  labels: bug,values,open discussion


proc `<`*(x: Value, y: Value): bool {.inline.}=
    if x.kind in {Integer, Floating, Rational} and y.kind in {Integer, Floating, Rational}:
        if x.kind==Integer:
            if y.kind==Integer: 
                if likely(x.iKind==NormalInteger and y.iKind==NormalInteger):
                    return x.i<y.i
                elif x.iKind==NormalInteger and y.iKind==BigInteger:
                    when defined(WEB):
                        return big(x.i)<y.bi
                    elif not defined(NOGMP):
                        return x.i<y.bi
                elif x.iKind==BigInteger and y.iKind==NormalInteger:
                    when defined(WEB):
                        return x.bi<big(y.i)
                    elif not defined(NOGMP):
                        return x.bi<y.i
                else:
                    when defined(WEB) or not defined(NOGMP):
                        return x.bi<y.bi
            elif y.kind==Rational:
                return cmp(toRational(x.i), y.rat) < 0
            else: 
                if x.iKind==NormalInteger:
                    return x.i<y.f
                else:
                    when defined(WEB):
                        return x.bi<big(int(y.f))
                    elif not defined(NOGMP):
                        return (x.bi)<int(y.f)
        elif x.kind==Rational:
            if y.kind==Integer:
                if likely(y.iKind==NormalInteger):
                    return cmp(x.rat,toRational(y.i))<0
                else:
                    return false
            elif y.kind==Rational:
                return cmp(x.rat,y.rat)<0
            else:
                return cmp(x.rat,toRational(y.f))<0
        else:
            if y.kind==Integer: 
                if y.iKind==NormalInteger:
                    return x.f<y.i
                else:
                    when defined(WEB):
                        return big(int(x.f))<y.bi
                    elif not defined(NOGMP):
                        return int(x.f)<y.bi      
            elif y.kind==Rational:
                return cmp(toRational(x.f), y.rat) < 0  
            else: return x.f<y.f
    elif x.kind == Quantity or y.kind == Quantity:
        if x.kind == Quantity:
            if y.kind == Quantity:
                if x.unit.kind != y.unit.kind: return false
                return x.nm < convertQuantityValue(y.nm, y.unit.name, x.unit.name)
            else:
                return x.nm < y
        else:
            return x < y.nm
    else:
        if x.kind != y.kind: return false
        case x.kind:
            of Null: return false
            of Logical: return false
            of Version: return x.version < y.version
            of Type: return false
            of Char: return $(x.c) < $(y.c)
            of String,
               Word,
               Label,
               Literal: return x.s < y.s
            of Symbol: return false
            of Inline,
               Block:
                return x.a.len < y.a.len
            of Dictionary:
                return false
            of Object:
                if (let compareMethod = x.proto.methods.getOrDefault("compare", nil); not compareMethod.isNil):
                    return x.proto.doCompare(x, y) == -1
                else:
                    return false
            of Date:
                return x.eobj[] < y.eobj[]
            else:
                return false

proc `>`*(x: Value, y: Value): bool {.inline.}=
    if x.kind in {Integer, Floating, Rational} and y.kind in {Integer, Floating, Rational}:
        if x.kind==Integer:
            if y.kind==Integer: 
                if likely(x.iKind==NormalInteger and y.iKind==NormalInteger):
                    return x.i>y.i
                elif x.iKind==NormalInteger and y.iKind==BigInteger:
                    when defined(WEB):
                        return big(x.i)>y.bi
                    elif not defined(NOGMP):
                        return x.i>y.bi
                elif x.iKind==BigInteger and y.iKind==NormalInteger:
                    when defined(WEB):
                        return x.bi>big(y.i)
                    elif not defined(NOGMP):
                        return x.bi>y.i
                else:
                    when defined(WEB) or not defined(NOGMP):
                        return x.bi>y.bi
            elif y.kind==Rational:
                return cmp(toRational(x.i), y.rat) > 0
            else: 
                if x.iKind==NormalInteger:
                    return float(x.i)>y.f
                else:
                    when defined(WEB):
                        return x.bi>big(int(y.f))
                    elif not defined(NOGMP):
                        return (x.bi)>int(y.f)
        elif x.kind==Rational:
            if y.kind==Integer:
                if likely(y.iKind==NormalInteger):
                    return cmp(x.rat,toRational(y.i))>0
                else:
                    return false
            elif y.kind==Rational:
                return cmp(x.rat,y.rat)>0
            else:
                return cmp(x.rat,toRational(y.f))>0
        else:
            if y.kind==Integer: 
                if likely(y.iKind==NormalInteger):
                    return x.f>float(y.i)
                else:
                    when defined(WEB):
                        return big(int(x.f))>y.bi
                    elif not defined(NOGMP):
                        return int(x.f)>y.bi   
            elif y.kind==Rational:
                return cmp(toRational(x.f), y.rat) > 0     
            else: return x.f>y.f
    elif x.kind == Quantity or y.kind == Quantity:
        if x.kind == Quantity:
            if y.kind == Quantity:
                if x.unit.kind != y.unit.kind: return false
                return x.nm > convertQuantityValue(y.nm, y.unit.name, x.unit.name)
            else:
                return x.nm > y
        else:
            return x > y.nm
    else:
        if x.kind != y.kind: return false
        case x.kind:
            of Null: return false
            of Logical: return false
            of Version: return x.version > y.version
            of Type: return false
            of Char: return $(x.c) > $(y.c)
            of String,
               Word,
               Label,
               Literal: return x.s > y.s
            of Symbol: return false
            of Inline,
               Block:
                return x.a.len > y.a.len
            of Dictionary:
                return false
            of Object:
                if (let compareMethod = x.proto.methods.getOrDefault("compare", nil); not compareMethod.isNil):
                    return x.proto.doCompare(x,y) == 1
                else:
                    return false
            of Date:
                return x.eobj[] > y.eobj[]
            else:
                return false

proc `<=`*(x: Value, y: Value): bool {.inline.}=
    x < y or x == y

proc `>=`*(x: Value, y: Value): bool {.inline.}=
    x > y or x == y

proc `!=`*(x: Value, y: Value): bool {.inline.}=
    not (x == y)

proc cmp*(x: Value, y: Value): int {.inline.}=
    if x < y:
        return -1
    elif x > y:
        return 1
    else:
        return 0

proc contains*(x: openArray[Value], y: Value): bool {.inline.} =
    for item in items(x):
        if y == item: return true
    return false

proc find*(a: openArray[Value], item: Value): int {.inline.}=
    result = 0
    for i in items(a):
        if i == item: return
        inc(result)
    result = -1  

proc identical*(x: Value, y: Value): bool {.inline.} =
    if x == y and x.kind == y.kind:
        if x.kind in {Inline, Block}:
            if x.a.len != y.a.len: return false

            for i,child in x.a:
                if not (child==y.a[i]): 
                    return false

            return true
        elif x.kind==Quantity:
            return identical(x.nm, y.nm) and x.unit == y.unit
        else:
            return true
    else:
        return false
