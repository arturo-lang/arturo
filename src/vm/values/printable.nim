#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: vm/values/printable.nim
#=======================================================

## Printing & stringication for Value objects.

#=======================================
# Libraries
#=======================================

import sequtils, strformat, strutils
import sugar, tables, times, unicode

when defined(WEB):
    import std/jsbigints

when not defined(NOGMP):
    import helpers/bignums as BignumsHelper

import helpers/terminal as TerminalHelper

import vm/globals
import vm/opcodes
import vm/values/value

import vm/values/custom/[vbinary, vcolor, vcomplex, vlogical, vquantity, vrange, vrational, vregex, vsocket, vversion]

#=======================================
# Helpers
#=======================================

when defined(WEB):
    var stdout: string

    proc resetStdout*()=
        stdout = ""

    proc write*(buffer: var string, str: string) =
        buffer &= str
    
    proc flushFile*(buffer: var string) =
        echo buffer

#=======================================
# Methods
#=======================================

proc stringify*(vk: ValueKind): string =
    result = ":" & ($(vk)).toLowerAscii()

proc valueKind*(v: Value, withBigInfo: static bool = false): string {.inline.} =
    if v.kind==Type:
        if v.tpKind==BuiltinType:
            result = stringify(v.t)
        else:
            result = ":" & v.ts.name
    else:
        result = stringify(v.kind)
        when withBigInfo:
            if v.kind==Integer and v.iKind==BigInteger:
                result &= " (big)"

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
        of Version      : return $(v.version)
        of Type         : 
            return valueKind(v)
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
            result = $(v.n)
        of Inline,
           Block     :
            # result = "["
            # for i,child in v.a:
            #     result &= $(child) & " "
            # result &= "]"
            result = "[" & v.a.map((child) => $(child)).join(" ") & "]"

        of Range     : 
            result = $(v.rng)

        of Dictionary   :
            var items: seq[string]
            for key,value in v.d:
                items.add(key  & ":" & $(value))

            result = "[" & items.join(" ") & "]"

        of Object:
            if (let printMethod = v.proto.methods.getOrDefault("print", nil); not printMethod.isNil):
                return v.proto.doPrint(v)
            else:
                var items: seq[string]
                for key,value in v.o:
                    items.add(key  & ":" & $(value))

                result = "[" & items.join(" ") & "]"

        of Store:
            ensureStoreIsLoaded(v.sto)

            var items: seq[string]
            for key,value in v.sto.data:
                items.add(key  & ":" & $(value))

            result = "[" & items.join(" ") & "]"

        of Function     : 
            result = ""
            if v.fnKind==UserFunction:
                result &= "<function>" & $(newWordBlock(v.params))
                result &= "(" & fmt("{cast[ByteAddress](v.main):#X}") & ")"
            else:
                result &= "<function:builtin>" 

        of Database:
            when not defined(NOSQLITE):
                if v.dbKind==SqliteDatabase: result = fmt("<database>({cast[ByteAddress](v.sqlitedb):#X})")
                #elif v.dbKind==MysqlDatabase: result = fmt("[mysql db] {cast[ByteAddress](v.mysqldb):#X}")
        
        of Socket:
            when not defined(WEB):
                result = $(v.sock)

        of Bytecode:
            result = "<bytecode>" & "(" & fmt("{cast[ByteAddress](v):#X}") & ")"
            
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
        for i in 0..level-1: stdout.write "        "
        if not muted:   stdout.write fmt("{bold(magentaColor)}]{resetColor}")
        else:           stdout.write fmt("]")

    proc dumpHeader(str: string) =
        if not muted: stdout.write fmt("{resetColor}{fg(cyanColor)}")
        let lln = "================================\n"
        for i in 0..level: stdout.write "        "
        stdout.write lln
        for i in 0..level: stdout.write "        "
        stdout.write " " & str & "\n"
        for i in 0..level: stdout.write "        "
        stdout.write lln
        if not muted: stdout.write fmt("{resetColor}")

    for i in 0..level-1: stdout.write "        "

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
        of Version      : dumpPrimitive($(v.version), v)
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
                    for i in 0..level: stdout.write "        "

                    stdout.write unicode.alignLeft(key & " ", maxLen) & ":"

                    dump(value, level+1, false, muted=muted)

            dumpBlockEnd()

        of Binary       : 
            dumpBlockStart(v)

            for i in 0..level: stdout.write "        "
            for i,child in v.n:
                dumpBinary(child)
                if (i+1) mod 20 == 0:
                    stdout.write "\n"
                    for i in 0..level: stdout.write "        "
            
            stdout.write "\n"

            dumpBlockEnd()

        # TODO(VM/values/value) `dump` doesn't print nested blocks/dictionaries properly
        #  try: `inspect #[a:#[b: 'c]]`
        #  labels: enhancement, values
        of Inline,
            Block        :
            dumpBlockStart(v)
            for i,child in v.a:
                dump(child, level+1, i==(v.a.len-1), muted=muted)

            stdout.write "\n"

            dumpBlockEnd()

        of Range        : dumpPrimitive($(v.rng), v)

        of Dictionary   : 
            dumpBlockStart(v)

            let keys = toSeq(v.d.keys)

            if keys.len > 0:
                let maxLen = (keys.map(proc (x: string):int = x.len)).max + 2

                for key,value in v.d:
                    for i in 0..level: stdout.write "        "

                    stdout.write unicode.alignLeft(key & " ", maxLen) & ":"

                    dump(value, level+1, false, muted=muted)

            dumpBlockEnd()

        of Store        :
            ensureStoreIsLoaded(v.sto)

            dumpBlockStart(v)

            let keys = toSeq(v.sto.data.keys)

            if keys.len > 0:
                let maxLen = (keys.map(proc (x: string):int = x.len)).max + 2

                for key,value in v.sto.data:
                    for i in 0..level: stdout.write "        "

                    stdout.write unicode.alignLeft(key & " ", maxLen) & ":"

                    dump(value, level+1, false, muted=muted)

            dumpBlockEnd()
        
        of Object   : 
            dumpBlockStart(v)

            let keys = toSeq(v.o.keys)

            if keys.len > 0:
                let maxLen = (keys.map(proc (x: string):int = x.len)).max + 2

                for key,value in v.o:
                    for i in 0..level: stdout.write "        "

                    stdout.write unicode.alignLeft(key & " ", maxLen) & ":"

                    dump(value, level+1, false, muted=muted)

            dumpBlockEnd()

        of Function     : 
            dumpBlockStart(v)

            if v.fnKind==UserFunction:
                dump(newWordBlock(v.params), level+1, false, muted=muted)
                dump(v.main, level+1, true, muted=muted)
            else:
                for i in 0..level: stdout.write "        "
                stdout.write "(builtin)"

            stdout.write "\n"

            dumpBlockEnd()

        of Database     :
            when not defined(NOSQLITE):
                if v.dbKind==SqliteDatabase: stdout.write fmt("[sqlite db] {cast[ByteAddress](v.sqlitedb):#X}")
                #elif v.dbKind==MysqlDatabase: stdout.write fmt("[mysql db] {cast[ByteAddress](v.mysqldb):#X}")

        of Socket       : 
            when not defined(WEB):
                dumpPrimitive($(v.sock), v)

        of Bytecode     : 
            dumpBlockStart(v)

            var instrs: ValueArray
            var j = 0
            while j < v.trans.instructions.len:
                let op = OpCode(v.trans.instructions[j])
                instrs.add(newWord(stringify((OpCode(op)))))
                if op in {opPush, opStore, opDStore, opCall, opLoad, opStorl, opAttr, opEol, opJmpIf, opJmpIfNot, opJmpIfEq, opJmpIfNe, opJmpIfGt, opJmpIfGe, opJmpIfLt, opJmpIfLe, opGoto, opGoup}:
                    j += 1
                    instrs.add(newInteger(int(v.trans.instructions[j])))
                elif op in {opPushX, opStoreX, opDStore, opCallX, opLoadX, opStorlX, opEolX, opJmpIfX, opJmpIfNotX, opJmpIfEqX, opJmpIfNeX, opJmpIfGtX, opJmpIfGeX, opJmpIfLtX, opJmpIfLeX, opGotoX, opGoupX}:
                    j += 2
                    instrs.add(newInteger(int(uint16(v.trans.instructions[j-1]) shl 8 + byte(v.trans.instructions[j]))))

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
                for i in 0..level: stdout.write "        "
                let preop = instrs[i].s
                stdout.write preop
                i += 1
                if i < instrs.len and instrs[i].kind==Integer:
                    stdout.write " ".repeat(20 - preop.len)
                    while i < instrs.len and instrs[i].kind==Integer:
                        var numstr = $(instrs[i].i)
                        if preop.contains("jmp") or preop.contains("go"):
                            numstr = "@" & numstr
                        else:
                            numstr = "#" & numstr
                        if not muted: stdout.write fmt("{resetColor}{fg(grayColor)} {numstr}{resetColor}")
                        else: stdout.write numstr
                        i += 1
                stdout.write "\n"

            dumpBlockEnd()

        of Nothing      : discard
        of ANY          : discard

    if not isLast:
        stdout.write "\n"

# TODO Fix pretty-printing for unwrapped blocks
#  Indentation is not working right for inner dictionaries and blocks
#  Check: `print as.pretty.code.unwrapped info.get 'get`
#  labels: values,enhancement,library

proc codify*(v: Value, pretty = false, unwrapped = false, level: int=0, isLast: bool=false, isKeyVal: bool=false, safeStrings: bool = false): string {.inline.} =
    result = ""

    if pretty:
        if isKeyVal:
            result &= " "
        else:
            for i in 0..level-1: result &= "        "

    case v.kind:
        of Null         : result &= "null"
        of Logical      : result &= $(v.b)
        of Integer      :
            if likely(v.iKind==NormalInteger): result &= $(v.i)
            else: 
                when defined(WEB) or not defined(NOGMP):
                    result &= $(v.bi)
        of Floating     : result &= $(v.f)
        of Complex      : 
            if v.z.re < 0 and v.z.im < 0:
                result &= fmt("to :complex @[neg {v.z.re * -1} neg {v.z.im * -1}]")
            elif v.z.re < 0:
                result &= fmt("to :complex @[neg {v.z.re * -1} {v.z.im}]")
            elif v.z.im < 0:
                result &= fmt("to :complex @[{v.z.re} neg {v.z.im * -1}]")
            else:
                result &= fmt("to :complex [{v.z.re} {v.z.im}]")
        of Rational     :
            result &= codify(v.rat) 
        of Version      : result &= fmt("{v.major}.{v.minor}.{v.patch}{v.extra}")
        of Type         : 
            if v.tpKind==BuiltinType:
                result &= ":" & ($v.t).toLowerAscii()
            else:
                result &= ":" & v.ts.name
        of Char         : result &= "'" & $(v.c) & "'"
        of String       : 
            if safeStrings:
                result &= "««" & v.s & "»»"
            else:
                if countLines(v.s)>1 or v.s.contains("\""):
                    var splitl = join(toSeq(splitLines(v.s)),"\n" & repeat("        ",level+1))
                    result &= "{\n" & repeat("        ",level+1) & splitl & "\n" & repeat("        ",level) & "}"
                else:
                    result &= escape(v.s)
        of Word         : result &= v.s
        of Literal      : result &= "'" & v.s
        of Label        : result &= v.s & ":"
        of Attribute         : result &= "." & v.s
        of AttributeLabel    : result &= "." & v.s & ":"
        of Path,
           PathLabel    :
            result = v.p.map((x) => $(x)).join("\\")
            if v.kind==PathLabel:
                result &= ":"
        of Symbol       :  result &= $(v.m)
        of SymbolLiteral: result &= "'" & $(v.m)
        of Quantity     : result &= $(v.nm) & "`" & toLowerAscii($(v.unit.name))
        of Regex        : result &= "{/" & $(v.rx) & "/}"
        of Color        : result &= $(v.l)

        of Inline, Block:
            if not (pretty and unwrapped and level==0):
                if v.kind==Inline: result &= "("
                else: result &= "["

            if pretty:
                result &= "\n"
            
            var parts: seq[string]
            for i,child in v.a:
                parts.add(codify(child,pretty,unwrapped,level+1, i==(v.a.len-1), safeStrings=safeStrings))

            result &= parts.join(" ")

            if pretty:
                result &= "\n"
                for i in 0..level-1: result &= "        "

            if not (pretty and unwrapped and level==0):
                if v.kind==Inline: result &= ")"
                else: result &= "]"

        of Dictionary:
            if not (pretty and unwrapped and level==0):
                result &= "#["

            if pretty:
                result &= "\n"

            let keys = toSeq(v.d.keys)

            if keys.len > 0:

                for k,v in pairs(v.d):
                    if pretty:
                        if not (unwrapped):
                            for i in 0..level: result &= "        "
                        else:
                            for i in 0..level-1: result &= "        "
                        result &= k & ":"
                    else:
                        result &= k & ": "

                    result &= codify(v,pretty,unwrapped,level+1, false, isKeyVal=true, safeStrings=safeStrings) 

                    if not pretty:
                        result &= " "

            if pretty:
                for i in 0..level-1: result &= "        "
            
            if not (pretty and unwrapped and level==0):
                result &= "]"

        of Function:
            if v.fnKind==UserFunction:
                result &= "function "
                result &= codify(newWordBlock(v.params),pretty,unwrapped,level+1, false, safeStrings=safeStrings)
                if v.inline:
                    result &= ".inline"
                if v.memoize:
                    result &= ".memoize"
                if not v.imports.isNil:
                    result &= ".import:"
                    result &= codify(newWordBlock(toSeq(keys(v.imports.d))),pretty,unwrapped,level+1, false, safeStrings=safeStrings)
                if not v.exports.isNil:
                    result &= ".export:"
                    result &= codify(newWordBlock(v.exports.a.map((w)=>w.s)),pretty,unwrapped,level+1, false, safeStrings=safeStrings)
                result &= " "
                result &= codify(v.main,pretty,unwrapped,level+1, true, safeStrings=safeStrings)
            else:
                for sym,val in pairs(Syms):
                    if val==v:
                        result &= "var'" & sym
                        break

        else:
            result &= ""
    
    if pretty:
        if not isLast:
            result &= "\n"
