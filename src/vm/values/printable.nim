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

proc dump*(v: Value, level: int=0, isLast: bool=false, muted: bool=false, prepend="") {.exportc.} = 
    proc dumpPrimitive(str: string, v: Value) =
        if not muted:   stdout.write fmt("{bold(greenColor)}{str}{fg(grayColor)} :{($(v.kind)).toLowerAscii()}{resetColor}")
        else:           stdout.write fmt("{str} :{($(v.kind)).toLowerAscii()}")

    proc dumpIdentifier(v: Value) =
        if not muted:   stdout.write fmt("{resetColor}{v.s}{fg(grayColor)} :{($(v.kind)).toLowerAscii()}{resetColor}")
        else:           stdout.write fmt("{v.s} :{($(v.kind)).toLowerAscii()}")

    proc dumpAttribute(v: Value) =
        if not muted:   stdout.write fmt("{resetColor}{v.s}{fg(grayColor)} :{($(v.kind)).toLowerAscii()}{resetColor}")
        else:           stdout.write fmt("{v.s} :{($(v.kind)).toLowerAscii()}")

    proc dumpSymbol(v: Value) =
        if not muted:   stdout.write fmt("{resetColor}{v.m}{fg(grayColor)} :{($(v.kind)).toLowerAscii()}{resetColor}")
        else:           stdout.write fmt("{v.m} :{($(v.kind)).toLowerAscii()}")

    proc dumpBinary(b: Byte) =
        if not muted:   stdout.write fmt("{resetColor}{fg(grayColor)}{b:02X} {resetColor}")
        else:           stdout.write fmt("{b:02X} ")

    proc dumpBlockStart(v: Value) =
        var tp = ($(v.kind)).toLowerAscii()
        if v.kind==Object: tp = v.proto.name
        if not muted:   stdout.write fmt("{bold(magentaColor)}[{fg(grayColor)} :{tp}{resetColor}\n")
        else:           stdout.write fmt("[ :{tp}\n")

    proc dumpBlockEnd() =
        for i in 0..level-1: stdout.write "\t"
        if not muted:   stdout.write fmt("{bold(magentaColor)}]{resetColor}")
        else:           stdout.write fmt("]")

    proc dumpHeader(str: string) =
        if not muted: stdout.write fmt("{resetColor}{fg(cyanColor)}")
        let lln = "================================\n"
        for i in 0..level: stdout.write "\t"
        stdout.write lln
        for i in 0..level: stdout.write "\t"
        stdout.write " " & str & "\n"
        for i in 0..level: stdout.write "\t"
        stdout.write lln
        if not muted: stdout.write fmt("{resetColor}")

    for i in 0..level-1: stdout.write "\t"

    if prepend!="":
        stdout.write prepend

    case v.kind:
        of Null         : dumpPrimitive("null",v)
        of Logical      : dumpPrimitive($(v.b), v)
        of Integer      : 
            if likely(v.iKind==NormalInteger): dumpPrimitive($(v.i), v)
            else: 
                when defined(WEB) or not defined(NOGMP):
                    dumpPrimitive($(v.bi), v)
        of Floating     :
            #if v.fKind==NormalFloating:
            if v.f==Inf: dumpPrimitive("∞", v)
            elif v.f==NegInf: dumpPrimitive("-∞", v)
            else: dumpPrimitive($(v.f), v)
            # else:
            #     when not defined(WEB) and not defined(NOGMP): 
            #         dumpPrimitive($(v.bf), v)
        of Complex      : dumpPrimitive($(v.z.re) & (if v.z.im >= 0: "+" else: "") & $(v.z.im) & "i", v)
        of Rational     : dumpPrimitive($(v.rat), v)
        of Version      : dumpPrimitive(fmt("{v.major}.{v.minor}.{v.patch}{v.extra}"), v)
        of Type         : 
            if v.tpKind==BuiltinType:
                dumpPrimitive(($(v.t)).toLowerAscii(), v)
            else:
                dumpPrimitive(v.ts.name, v)
        of Char         : dumpPrimitive($(v.c), v)
        of String       : dumpPrimitive(v.s, v)
        
        of Word,
           Literal,
           Label        : dumpIdentifier(v)

        of Attribute,
           AttributeLabel    : dumpAttribute(v)

        of Path,
           PathLabel    :
            dumpBlockStart(v)

            for i,child in v.p:
                dump(child, level+1, i==(v.a.len-1), muted=muted)

            stdout.write "\n"

            dumpBlockEnd()

        of Symbol, 
           SymbolLiteral: dumpSymbol(v)

        of Quantity     : dumpPrimitive($(v.nm) & ":" & stringify(v.unit.name), v)

        of Regex        : dumpPrimitive($(v.rx), v)

        of Color        : dumpPrimitive($(v.l), v)

        of Date         : 
            dumpBlockStart(v)

            let keys = toSeq(v.e.keys)

            if keys.len > 0:
                let maxLen = (keys.map(proc (x: string):int = x.len)).max + 2

                for key,value in v.e:
                    for i in 0..level: stdout.write "\t"

                    stdout.write unicode.alignLeft(key & " ", maxLen) & ":"

                    dump(value, level+1, false, muted=muted)

            dumpBlockEnd()

        of Binary       : 
            dumpBlockStart(v)

            for i in 0..level: stdout.write "\t"
            for i,child in v.n:
                dumpBinary(child)
                if (i+1) mod 20 == 0:
                    stdout.write "\n"
                    for i in 0..level: stdout.write "\t"
            
            stdout.write "\n"

            dumpBlockEnd()

        # TODO(VM/values/value) `dump` doesn't print nested blocks/dictionaries properly
        #  try: `inspect #[a:#[b: 'c]]`
        #  labels: enhancement, values
        of Inline,
            Block        :
            dumpBlockStart(v)
            ensureCleaned(v)
            for i,child in cleanV:
                dump(child, level+1, i==(cleanV.len-1), muted=muted)

            stdout.write "\n"

            dumpBlockEnd()

        of Dictionary   : 
            dumpBlockStart(v)

            let keys = toSeq(v.d.keys)

            if keys.len > 0:
                let maxLen = (keys.map(proc (x: string):int = x.len)).max + 2

                for key,value in v.d:
                    for i in 0..level: stdout.write "\t"

                    stdout.write unicode.alignLeft(key & " ", maxLen) & ":"

                    dump(value, level+1, false, muted=muted)

            dumpBlockEnd()
        
        of Object   : 
            dumpBlockStart(v)

            let keys = toSeq(v.o.keys)

            if keys.len > 0:
                let maxLen = (keys.map(proc (x: string):int = x.len)).max + 2

                for key,value in v.o:
                    for i in 0..level: stdout.write "\t"

                    stdout.write unicode.alignLeft(key & " ", maxLen) & ":"

                    dump(value, level+1, false, muted=muted)

            dumpBlockEnd()

        of Function     : 
            dumpBlockStart(v)

            if v.fnKind==UserFunction:
                dump(v.params, level+1, false, muted=muted)
                dump(v.main, level+1, true, muted=muted)
            else:
                for i in 0..level: stdout.write "\t"
                stdout.write "(builtin)"

            stdout.write "\n"

            dumpBlockEnd()

        of Database     :
            when not defined(NOSQLITE):
                if v.dbKind==SqliteDatabase: stdout.write fmt("[sqlite db] {cast[ByteAddress](v.sqlitedb):#X}")
                #elif v.dbKind==MysqlDatabase: stdout.write fmt("[mysql db] {cast[ByteAddress](v.mysqldb):#X}")
        
        of Bytecode     : 
            dumpBlockStart(v)

            var instrs: ValueArray = @[]
            var j = 0
            while j < v.trans.instructions.len:
                let op = (OpCode)(v.trans.instructions[j])
                instrs.add(newWord(stringify(((OpCode)(op)))))
                if op in [opPush, opStore, opCall, opLoad, opStorl, opAttr, opEol]:
                    j += 1
                    instrs.add(newInteger((int)v.trans.instructions[j]))
                elif op in [opPushX, opStoreX, opCallX, opLoadX, opStorlX, opEolX]:
                    j += 2
                    instrs.add(newInteger((int)((uint16)(v.trans.instructions[j-1]) shl 8 + (byte)(v.trans.instructions[j]))))

                j += 1

            dumpHeader("DATA")

            for i,child in v.trans.constants:
                var prep: string
                if not muted:   prep=fmt("{resetColor}{bold(whiteColor)}{i}: {resetColor}")
                else:           prep=fmt("{i}: ")

                dump(child, level+1, false, muted=muted, prepend=prep)

            stdout.write "\n"

            dumpHeader("CODE")

            var i = 0
            while i < instrs.len:
                for i in 0..level: stdout.write "\t"
                stdout.write instrs[i].s
                i += 1
                if i < instrs.len and instrs[i].kind==Integer:
                    stdout.write "\t\t"
                    while i < instrs.len and instrs[i].kind==Integer:
                        if not muted: stdout.write fmt("{resetColor}{fg(grayColor)} #{instrs[i].i}{resetColor}")
                        else: stdout.write " #" & $(instrs[i].i)
                        i += 1
                stdout.write "\n"

            dumpBlockEnd()

        of Newline      : discard
        of Nothing      : discard
        of ANY          : discard

    if not isLast:
        stdout.write "\n"