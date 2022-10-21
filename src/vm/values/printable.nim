######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/values/printable.nim
######################################################

# TODO(VM/values/printable) Do we even need to have this?
#  This module include a carbon copy of the `$` overloads for Value and SymbolKind values, copied verbatim from VM/values/value. Obviously, the reason for its existence must have been Nim's awkward way of resolving module imports; but there *must* be a better way.
#  labels: vm, values, cleanup

#=======================================
# Libraries
#=======================================

import sequtils, strformat, strutils
import sugar, tables, times, unicode

when defined(WEB):
    import std/jsbigints

when not defined(NOGMP):
    import helpers/bignums as BignumsHelper

import vm/exec
import vm/stack
import vm/values/value
import vm/values/clean

import vm/values/custom/[vcolor, vcomplex, vlogical, vquantity, vrational, vregex]

#=======================================
# Methods
#=======================================

proc `$`*(v: Value): string {.inline.} =
    case v.kind:
        of Null         : return "null"
        of Logical      : return $(v.b)
        of Integer      : 
            if likely(v.iKind==NormalInteger): return $(v.i)
            else:
                when defined(WEB) or not defined(NOGMP): 
                    return $(v.bi)
        of Floating     : 
            #if v.fKind==NormalFloating: 
            if v.f==Inf: return "∞"
            elif v.f==NegInf: return "-∞"
            else: return $(v.f)
            # else:
            #     when not defined(WEB) and not defined(NOGMP): 
            #         return "BIG:" & $(v.bf)
        of Complex      : 
            return $(v.z.re) & (if v.z.im >= 0: "+" else: "") & $(v.z.im) & "i"
        of Rational     :
            return $(v.rat)
        of Version      : return fmt("{v.major}.{v.minor}.{v.patch}{v.extra}")
        of Type         : 
            if v.tpKind==BuiltinType:
                return ":" & ($v.t).toLowerAscii()
            else:
                return ":" & v.ts.name
        of Char         : return $(v.c)
        of String,
           Word, 
           Literal,
           Label,
           Attribute,
           AttributeLabel        : return v.s
        of Path,
           PathLabel    :
            result = v.p.map((x) => $(x)).join("\\")
        of Symbol,
           SymbolLiteral:
            return $(v.m)
        of Quantity:
            return $(v.nm) & stringify(v.unit.name)
        of Regex:
            return $(v.rx)
        of Color        :
            return $(v.l)

        of Date     : return $(v.eobj)
        of Binary   : 
            result = v.n.map((child) => fmt"{child:02X}").join(" ")
        of Inline,
           Block     :
            # result = "["
            # for i,child in v.a:
            #     result &= $(child) & " "
            # result &= "]"

            ensureCleaned(v)
            result = "[" & cleanV.map((child) => $(child)).join(" ") & "]"

        of Dictionary   :
            var items: seq[string] = @[]
            for key,value in v.d:
                items.add(key  & ":" & $(value))

            result = "[" & items.join(" ") & "]"

        of Object:
            if (let printMethod = v.proto.methods.getOrDefault("print", nil); not printMethod.isNil):
                push v
                callFunction(printMethod)
                result = pop().s
            else:
                var items: seq[string] = @[]
                for key,value in v.o:
                    items.add(key  & ":" & $(value))

                result = "[" & items.join(" ") & "]"

        of Function     : 
            result = ""
            if v.fnKind==UserFunction:
                result &= "<function>" & $(v.params)
                result &= "(" & fmt("{cast[ByteAddress](v.main):#X}") & ")"
            else:
                result &= "<function:builtin>" 

        of Database:
            when not defined(NOSQLITE):
                if v.dbKind==SqliteDatabase: result = fmt("<database>({cast[ByteAddress](v.sqlitedb):#X})")
                #elif v.dbKind==MysqlDatabase: result = fmt("[mysql db] {cast[ByteAddress](v.mysqldb):#X}")

        of Bytecode:
            result = "<bytecode>" & "(" & fmt("{cast[ByteAddress](v):#X}") & ")"
            
        of Newline: discard
        of Nothing: discard
        of ANY: discard