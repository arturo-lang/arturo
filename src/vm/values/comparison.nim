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

import vm/values/types
import vm/values/value

import vm/values/custom/[vcolor, vcomplex, vlogical, vquantity, vrange, vrational, vregex, vversion]

#=======================================
# Constants
#=======================================

const
    GMP = not defined(NOGMP)

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

template toBig(v: untyped): untyped =
    when defined(WEB):
        big(v)
    else:
        v

#=======================================
# Methods
#=======================================

# TODO(VM/values/comparison) Should we throw errors in case of incompatible pairs?
#  For example, if we try to compare a string with a number, should we throw an error?
#  Or should we simply return false?
#  Also, this should affect `<` and `>`, more than `==` since - at least IMHO - something
#  like `2 = "hello"` still *does* make sense (it may be obviously false, but it does). 
#  `2 < "hello"`, for example, does *not*.
#  see also: https://github.com/arturo-lang/arturo/pull/1139
#  labels: enhancement,values,error handling,open discussion

# TODO(VM/value/comparison) rewrite all `==`, `<`, `>` methods to use `getValuePair`?
#  This would follow closely the implementations found in VM/values/operators
#  This could be a good idea for cleaner code, but we should thoroughly benchmark it before!
#  labels: enhancement, cleanup, benchmark,performance, values

# TODO(VM/values/comparison) Verify all value types are properly handled by all overloads
#  labels: vm, values, enhancement, unit-test

proc `==`*(x: Value, y: Value): bool =
    const 
        numericKinds = {Integer, Rational, Floating, Quantity}
        errorKinds = {Error, ErrorKind}
        numericOrErrorKinds = numericKinds + errorKinds

    if x.kind in numericOrErrorKinds or y.kind in numericOrErrorKinds:
        let pair = getValuePair()
        case pair:
            of Integer    || Integer   : return x.i   == y.i
            of Rational   || Rational  : return x.rat == y.rat
            of Floating   || Floating  : return x.f   == y.f
            of Quantity   || Quantity  : return x.q   == y.q
            
            of Integer    || Floating  : return float(x.i)      == y.f
            of Integer    || Rational  : return toRational(x.i) == y.rat
            of Integer    || Quantity  : return x.i             == y.q
        
            of Rational   || Integer   : return x.rat == toRational(y.i)
            of Rational   || Floating  : return x.rat == toRational(y.f)
            of Rational   || Quantity  : return x.rat == y.q
            
            of Floating   || Integer   : return x.f             == float(y.i)
            of Floating   || Rational  : return toRational(x.f) == y.rat
            of Floating   || Quantity  : return x.f             == y.q
            
            of Quantity   || Integer   : return x.q == y.i
            of Quantity   || Floating  : return x.q == y.f
            of Quantity   || Rational  : return x.q == y.rat
            
            of BigInteger || BigInteger: (when GMP: return x.bi == y.bi)
            
            of BigInteger || Integer   : (when GMP: return x.bi == toBig(y.i))
            of BigInteger || Rational  : return false
            of BigInteger || Floating  : (when GMP: return x.bi == toBig(int(y.f)))
            of BigInteger || Quantity  : (when GMP: return x.bi == y.q)

            of Integer    || BigInteger: (when GMP: return toBig(x.i) == y.bi)
            of Rational   || BigInteger: (when GMP: return x.rat == toRational(y.bi))
            of Floating   || BigInteger: (when GMP: return toBig(int(x.f)) == y.bi)
            of Quantity   || BigInteger: (when GMP: return x.q == y.bi)

            of Error      || ErrorKind : return x.err.kind == y.errkind
            of ErrorKind  || Error     : return x.errkind  == y.err.kind
            else:
                if x.kind != y.kind:
                    return false

    case x.kind:
        of Error:   
            return x.err == y.err
        of ErrorKind:   
            return x.errkind == y.errkind
        of Null:   
            return true
        of Logical:   
            return x.b == y.b
        of Complex:   
            return x.z == y.z
        of Version:   
            return x.version == y.version
        of Type:   
            return x.t == y.t
        of Char:   
            return x.c == y.c
        of String, Word, Label, Literal, Attribute, AttributeLabel:
            return x.s == y.s
        of Path, PathLabel, PathLiteral:
            return x.p == y.p
        of Symbol:
            return x.m == y.m
        of Regex:
            return x.rx == y.rx
        of Binary:
            return x.n == y.n
        of Bytecode:
            return x.trans[] == y.trans[]
        of Inline, Block:
            if x.a.len != y.a.len: 
                return false
            for i, child in x.a:
                if child != y.a[i]: 
                    return false
            return true
        of Range:   
            return x.rng == y.rng
        of Dictionary:
            if x.d.len != y.d.len: 
                return false
            for k, v in pairs(x.d):
                if not y.d.hasKey(k): 
                    return false
                if v != y.d[k]: 
                    return false
            return true
        of Unit:   
            return x.u == y.u
        of Object:
            if not x.proto.methods.getOrDefault("compare", nil).isNil:
                return x.proto.doCompare(x,y) == 0
            if x.o.len != y.o.len: 
                return false
            for k,v in pairs(x.o):
                if not y.o.hasKey(k): 
                    return false
                if not (v == y.o[k]): 
                    return false
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
            if x.dbKind != y.dbKind: 
                return false
            when not defined(NOSQLITE):
                if x.dbKind==SqliteDatabase: 
                    return cast[uint](x.sqlitedb) == cast[uint](y.sqlitedb)
                #elif x.dbKind==MysqlDatabase: return cast[uint](x.mysqldb) == cast[uint](y.mysqldb)
        of Date:
            return x.eobj[] == y.eobj[]
        else:   
            return false

# TODO(VM/values/comparison) how should we handle Dictionary values?
#  right now, both `<` and `>` simply return false
#  but is it even a normal idea to compare a Dictionary with something else, or
#  another dictionary for that matter?
#  How do other languages (e.g. Ruby, Python) handle this?
#  If the final decision is to not support this, then we should throw an appropriate
#  error message (e.g. "cannot compare Dictionary values"), along with an appropriate
#  (new) error template at VM/errors
#  see also: https://github.com/arturo-lang/arturo/pull/1139
#  labels: enhancement,values,error handling,open discussion

# TODO(VM/values/comparison) how should we handle Object values?
#  right now, Object make feature a custom `compare` method which is called an used
#  for the comparison. However, if there is no such method, we end up having the exact
#  same issues we have with Dictionaries. So, how is that to be dealt with?
#  see also: https://github.com/arturo-lang/arturo/pull/1139
#  labels: enhancement,values,error handling,open discussion

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
#  labels: bug,values,easy

# TODO(VM/values/comparison) add `<`/`>` support for Range values
#  currently, `=` is supported but not `<` and `>`!
#  Preferrably, the implementation should go to values/custom/vrange
#  and then integrate it here.
#  The question is: when is range A smaller than range B? How do other
#  languages handle this?
#  see also: https://github.com/arturo-lang/arturo/pull/1139
#  labels: bug,values,open discussion

# TODO(VM/values/comparison) add `<`/`>` support for Inline values?
#  currently, `=` is supported but not `<` and `>`!
#  since Inline values are pretty much identical to Block values - internally -
#  comparison operators should work for them in an identical fashion.
#  The question is: when is Inline A smaller than Inline B? How do other
#  languages handle this?
#  see also: https://github.com/arturo-lang/arturo/pull/1139
#  labels: bug,values,open discussion

# TODO(VM/values/comparison) Re-visit/test handling of Block comparisons
#  How do other languages (e.g. Python, Ruby, etc) handle comparisons between blocks/arrays?
#  Do they even support it? If so, how?
#  labels: enhancement,values,open discussion,unit-test

proc `<`*(x: Value, y: Value): bool {.inline.}=
    const numericKinds = {Integer, Rational, Floating, Quantity}

    if x.kind in numericKinds or y.kind in numericKinds:
        let pair = getValuePair()
        case pair:
            of Integer    || Integer   :   return x.i   < y.i
            of Rational   || Rational  :   return x.rat < y.rat
            of Floating   || Floating  :   return x.f   < y.f
            of Quantity   || Quantity  :   return x.q   < y.q
            
            of Integer    || Floating  :   return float(x.i)      < y.f
            of Integer    || Rational  :   return toRational(x.i) < y.rat
            of Integer    || Quantity  :   return x.i             < y.q
        
            of Rational   || Integer   :   return x.rat < toRational(y.i)
            of Rational   || Floating  :   return x.rat < toRational(y.f)
            of Rational   || Quantity  :   return x.rat < y.q
            
            of Floating   || Integer   :   return x.f             < float(y.i)
            of Floating   || Rational  :   return toRational(x.f) < y.rat
            of Floating   || Quantity  :   return x.f             < y.q
            
            of Quantity   || Integer   :   return x.q < y.i
            of Quantity   || Floating  :   return x.q < y.f
            of Quantity   || Rational  :   return x.q < y.rat
            
            of BigInteger || BigInteger:   (when GMP: return x.bi < y.bi)
            
            of BigInteger || Integer   :   (when GMP: return x.bi < toBig(y.i))
            of BigInteger || Rational  :   return false
            of BigInteger || Floating  :   (when GMP: return x.bi < toBig(int(y.f)))
            of BigInteger || Quantity  :   (when GMP: return x.bi < y.q)

            of Integer    || BigInteger:   (when GMP: return toBig(x.i)      < y.bi)
            of Rational   || BigInteger:   (when GMP: return x.rat           < toRational(y.bi))
            of Floating   || BigInteger:   (when GMP: return toBig(int(x.f)) < y.bi)
            of Quantity   || BigInteger:   (when GMP: return x.q             < y.bi)
            else:
                if x.kind != y.kind:
                    return false

    case x.kind:
        of Null: 
            return false
        of Logical: 
            return false
        of Complex:
            if x.z.re == y.z.re:
                return x.z.im < y.z.im
            else:
                return x.z.re < y.z.re
        of Version: 
            return x.version < y.version
        of Type: 
            return false
        of Char: 
            return $(x.c) < $(y.c)
        of String, Word, Label, Literal, Attribute, AttributeLabel: 
            return x.s < y.s
        of Symbol: 
            return false
        of Inline, Block: 
            return x.a.len < y.a.len
        of Dictionary: 
            return false
        of Unit: 
            return false
        of Object:
            if not x.proto.methods.getOrDefault("compare", nil).isNil:
                return x.proto.doCompare(x, y) == -1
            else:
                return false
        of Date: 
            return x.eobj[] < y.eobj[]
        else: 
            return false

proc `>`*(x: Value, y: Value): bool {.inline.}=
    const numericKinds = {Integer, Rational, Floating, Quantity}

    if x.kind in numericKinds or y.kind in numericKinds:
        let pair = getValuePair()
        case pair:
            of Integer    || Integer   :   return x.i   > y.i
            of Rational   || Rational  :   return x.rat > y.rat
            of Floating   || Floating  :   return x.f   > y.f
            of Quantity   || Quantity  :   return x.q   > y.q
            
            of Integer    || Floating  :   return float(x.i)      > y.f
            of Integer    || Rational  :   return toRational(x.i) > y.rat
            of Integer    || Quantity  :   return x.i             > y.q
        
            of Rational   || Integer   :   return x.rat > toRational(y.i)
            of Rational   || Floating  :   return x.rat > toRational(y.f)
            of Rational   || Quantity  :   return x.rat > y.q
            
            of Floating   || Integer   :   return x.f             > float(y.i)
            of Floating   || Rational  :   return toRational(x.f) > y.rat
            of Floating   || Quantity  :   return x.f             > y.q
            
            of Quantity   || Integer   :   return x.q > y.i
            of Quantity   || Floating  :   return x.q > y.f
            of Quantity   || Rational  :   return x.q > y.rat
            
            of BigInteger || BigInteger:   (when GMP: return x.bi > y.bi)
            
            of BigInteger || Integer   :   (when GMP: return x.bi > toBig(y.i))
            of BigInteger || Rational  :   return false
            of BigInteger || Floating  :   (when GMP: return x.bi > toBig(int(y.f)))
            of BigInteger || Quantity  :   (when GMP: return x.bi > y.q)

            of Integer    || BigInteger:   (when GMP: return toBig(x.i)      > y.bi)
            of Rational   || BigInteger:   (when GMP: return x.rat           > toRational(y.bi))
            of Floating   || BigInteger:   (when GMP: return toBig(int(x.f)) > y.bi)
            of Quantity   || BigInteger:   (when GMP: return x.q             > y.bi)
            else:
                if x.kind != y.kind:
                    return false

    case x.kind:
        of Null:   
            return false
        of Logical:   
            return false
        of Complex:
            if x.z.re == y.z.re:
                return x.z.im > y.z.im
            else:
                return x.z.re > y.z.re
        of Version:   
            return x.version > y.version
        of Type:   
            return false
        of Char:   
            return $(x.c) > $(y.c)
        of String, Word, Label, Literal, Attribute, AttributeLabel:   
            return x.s > y.s
        of Symbol:   
            return false
        of Inline, Block:   
            return x.a.len > y.a.len
        of Dictionary:   
            return false
        of Unit:   
            return false
        of Object:
            if not x.proto.methods.getOrDefault("compare", nil).isNil:
                return x.proto.doCompare(x, y) == 1
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

# TODO(VM/values/comparison) Should we convert `!=` into a template?
#  Does it make sense performance/binarysize-wise?
#  labels: enhancement, performance, benchmark, open discussion

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
            return (x.q.original == y.q.original) and (x.q.atoms == y.q.atoms)
        else:
            return true
    else:
        return false
