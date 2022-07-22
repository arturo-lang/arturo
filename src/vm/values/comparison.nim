######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/values/comparison.nim
######################################################

#=======================================
# Libraries
#=======================================

import rationals except Rational
import lenientops, tables, unicode

when defined(WEB):
    import std/jsbigints
    
when not defined(NOGMP):
    import extras/bignum

import helpers/colors as ColorsHelper
import helpers/quantities as QuantitiesHelper
 
import vm/exec
import vm/stack
import vm/values/value

#=======================================
# Methods
#=======================================

# TODO(Values/comparison) No `==` overload for Regex values
#  labels: bug, values
proc `==`*(x: Value, y: Value): bool {.inline.}=
    if x.kind in [Integer, Floating, Rational] and y.kind in [Integer, Floating, Rational]:
        if x.kind==Integer:
            if y.kind==Integer: 
                if x.iKind==NormalInteger and y.iKind==NormalInteger:
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
                if x.iKind==NormalInteger:
                    return toRational(x.i)==y.rat
                else:
                    return false
            else: 
                if x.iKind==NormalInteger:
                    return (float)(x.i)==y.f
                else:
                    when defined(WEB):
                        return x.bi==big((int)(y.f))
                    elif not defined(NOGMP):
                        return (x.bi)==(int)(y.f)
        elif x.kind==Rational:
            if y.kind==Integer:
                if y.iKind==NormalInteger:
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
                    return x.f==(float)(y.i)
                elif y.iKind==BigInteger:
                    when defined(WEB):
                        return big((int)(x.f))==y.bi
                    elif not defined(NOGMP):
                        return (int)(x.f)==y.bi        
            elif y.kind==Rational:
                return toRational(x.f)==y.rat
            else: return x.f==y.f
    else:
        if x.kind != y.kind: return false

        case x.kind:
            of Null: return true
            of Logical: return x.b == y.b
            of Complex: return x.z == y.z
            of Version:
                return x.major == y.major and x.minor == y.minor and x.patch == y.patch
            of Type: return x.t == y.t
            of Char: return x.c == y.c
            of String,
               Word,
               Label,
               Literal: return x.s == y.s
            of Attribute,
               AttributeLabel: return x.r == y.r
            of Symbol: return x.m == y.m
            of Inline,
               Block:
                let cleanX = cleanBlock(x.a)
                let cleanY = cleanBlock(y.a)

                if cleanX.len != cleanY.len: return false

                for i,child in cleanX:
                    if not (child==cleanY[i]): return false

                return true
            of Dictionary:
                if not x.custom.isNil and x.custom.methods.d.hasKey("compare"):
                    push y
                    push x
                    callFunction(x.custom.methods.d["compare"])
                    return (pop().i == 0)
                else:
                    if x.d.len != y.d.len: return false

                    for k,v in pairs(x.d):
                        if not y.d.hasKey(k): return false
                        if not (v==y.d[k]): return false

                    return true
            of Quantity:
                if x.unit.kind != y.unit.kind: return false
                if x.unit.name == y.unit.name:
                    return x.nm == y.nm
                else:
                    let fmultiplier = getQuantityMultiplier(y.unit, x.unit)
                    return x.nm == y.nm * newFloating(fmultiplier)
            of ValueKind.Color:
                return x.l == y.l
            of Function:
                if x.fnKind==UserFunction:
                    return x.params == y.params and x.main == y.main and x.exports == y.exports
                else:
                    return x.fname == y.fname
            of Database:
                if x.dbKind != y.dbKind: return false
                when not defined(NOSQLITE):
                    if x.dbKind==SqliteDatabase: return cast[ByteAddress](x.sqlitedb) == cast[ByteAddress](y.sqlitedb)
                    #elif x.dbKind==MysqlDatabase: return cast[ByteAddress](x.mysqldb) == cast[ByteAddress](y.mysqldb)
            of Date:
                return x.eobj == y.eobj
            else:
                return false

proc `<`*(x: Value, y: Value): bool {.inline.}=
    if x.kind in [Integer, Floating, Rational] and y.kind in [Integer, Floating, Rational]:
        if x.kind==Integer:
            if y.kind==Integer: 
                if x.iKind==NormalInteger and y.iKind==NormalInteger:
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
                        return x.bi<big((int)(y.f))
                    elif not defined(NOGMP):
                        return (x.bi)<(int)(y.f)
        elif x.kind==Rational:
            if y.kind==Integer:
                if y.iKind==NormalInteger:
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
                elif y.iKind==BigInteger:
                    when defined(WEB):
                        return big((int)(x.f))<y.bi
                    elif not defined(NOGMP):
                        return (int)(x.f)<y.bi      
            elif y.kind==Rational:
                return cmp(toRational(x.f), y.rat) < 0  
            else: return x.f<y.f
    else:
        if x.kind != y.kind: return false
        case x.kind:
            of Null: return false
            of Logical: return false
            of Version:
                if x.major < y.major: return true
                elif x.major > y.major: return false

                if x.minor < y.minor: return true
                elif x.minor > y.minor: return false

                if x.patch < y.patch: return true
                elif x.patch > y.patch: return false

                return false
            of Type: return false
            of Char: return $(x.c) < $(y.c)
            of String,
               Word,
               Label,
               Literal: return x.s < y.s
            of Symbol: return false
            of Inline,
               Block:
                return cleanBlock(x.a).len < cleanBlock(y.a).len
            of Dictionary:
                if not x.custom.isNil and x.custom.methods.d.hasKey("compare"):
                    push y
                    push x
                    callFunction(x.custom.methods.d["compare"])
                    return (pop().i == -1)
                else:
                    return false
            of Quantity:
                if x.unit.kind != y.unit.kind: return false
                if x.unit.name == y.unit.name:
                    return x.nm < y.nm
                else:
                    let fmultiplier = getQuantityMultiplier(y.unit, x.unit)
                    return x.nm < y.nm * newFloating(fmultiplier)
            else:
                return false

proc `>`*(x: Value, y: Value): bool {.inline.}=
    if x.kind in [Integer, Floating, Rational] and y.kind in [Integer, Floating, Rational]:
        if x.kind==Integer:
            if y.kind==Integer: 
                if x.iKind==NormalInteger and y.iKind==NormalInteger:
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
                    return (float)(x.i)>y.f
                else:
                    when defined(WEB):
                        return x.bi>big((int)(y.f))
                    elif not defined(NOGMP):
                        return (x.bi)>(int)(y.f)
        elif x.kind==Rational:
            if y.kind==Integer:
                if y.iKind==NormalInteger:
                    return cmp(x.rat,toRational(y.i))>0
                else:
                    return false
            elif y.kind==Rational:
                return cmp(x.rat,y.rat)>0
            else:
                return cmp(x.rat,toRational(y.f))>0
        else:
            if y.kind==Integer: 
                if y.iKind==NormalInteger:
                    return x.f>(float)(y.i)
                elif y.iKind==BigInteger:
                    when defined(WEB):
                        return big((int)(x.f))>y.bi
                    elif not defined(NOGMP):
                        return (int)(x.f)>y.bi   
            elif y.kind==Rational:
                return cmp(toRational(x.f), y.rat) > 0     
            else: return x.f>y.f
    else:
        if x.kind != y.kind: return false
        case x.kind:
            of Null: return false
            of Logical: return false
            of Version:
                if x.major > y.major: return true
                elif x.major < y.major: return false

                if x.minor > y.minor: return true
                elif x.minor < y.minor: return false

                if x.patch > y.patch: return true
                elif x.patch < y.patch: return false

                return false
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
                if not x.custom.isNil and x.custom.methods.d.hasKey("compare"):
                    push y
                    push x
                    callFunction(x.custom.methods.d["compare"])
                    return (pop().i == 1)
                else:
                    return false
            of Quantity:
                if x.unit.kind != y.unit.kind: return false
                if x.unit.name == y.unit.name:
                    return x.nm > y.nm
                else:
                    let fmultiplier = getQuantityMultiplier(y.unit, x.unit)
                    return x.nm > y.nm * newFloating(fmultiplier)
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
        if x.kind in [Inline, Block]:
            if x.a.len != y.a.len: return false

            for i,child in x.a:
                if not (child==y.a[i]): 
                    return false

            return true
        else:
            return true
    else:
        return false