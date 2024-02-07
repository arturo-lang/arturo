#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
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

when defined(GMP):
    import helpers/bignums as BignumsHelper

import helpers/terminal as TerminalHelper

import vm/[globals, opcodes, stack]
import vm/values/value

import vm/values/custom/[vbinary, vcolor, vcomplex, verror, vlogical, vquantity, vrange, vrational, vregex, vversion]

when not defined(WEB):
    import vm/values/custom/[vsocket]
    
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

# repeated from Helpers/objects
# to avoid recursive imports
iterator objectKeys(vd: ValueDict): string =
    for k,v in vd:
        if v.kind != Method:
            yield k

# repeated from Helpers/objects
# to avoid recursive imports
iterator objectPairs(vd: ValueDict): (string, Value) =
    for k,v in vd:
        if v.kind != Method:
            yield (k,v)

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
            result = ":" & v.tid#s.name
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
                when defined(GMP): 
                    return $(v.bi)
                elif defined(WEB):
                    return ($(v.bi)).replace("n","")
        of Floating     : 
            #if v.fKind==NormalFloating: 
            if v.f==Inf: return "∞"
            elif v.f==NegInf: return "-∞"
            else: return $(v.f)
            # else:
            #     when not defined(WEB) and defined(GMP): 
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
           PathLabel,
           PathLiteral   :
            result = v.p.map((x) => $(x)).join("\\")
        of Symbol,
           SymbolLiteral:
            return $(v.m)
        of Unit:
            return $(v.u)
        of Quantity:
            return $(v.q)
        of Regex:
            return $(v.rx)
        of Error:
            return $(v.err)
        of ErrorKind:
            return $(v.errKind)
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
            if v.magic.fetch(ToStringM):
                mgk(@[v])
                return stack.pop().s
            else:
                var items: seq[string]
                for key,value in v.o.objectPairs:
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
                result &= "(" & fmt("{cast[uint](v.main):#X}") & ")"
            else:
                result &= "<function:builtin>" 

        of Method       :
            result = ""
            result &= "<method>" & $(newWordBlock(v.mparams))
            result &= "(" & fmt("{cast[uint](v.mmain):#X}") & ")"

        of Database:
            when not defined(NOSQLITE):
                if v.dbKind==SqliteDatabase: result = fmt("<database>({cast[uint](v.sqlitedb):#X})")
                #elif v.dbKind==MysqlDatabase: result = fmt("[mysql db] {cast[uint](v.mysqldb):#X}")
        
        of Socket:
            when not defined(WEB):
                result = $(v.sock)

        of Bytecode:
            result = "<bytecode>" & "(" & fmt("{cast[uint](v):#X}") & ")"
            
        of Nothing: discard
        of ANY: discard

template stdoutWrite(sss: string): untyped = 
    if target.isNil: stdout.write sss
    else: target[] &= sss

proc dump*(v: Value, level: int=0, isLast: bool=false, muted: bool=false, prepend="", target: ref string = nil) {.exportc.} = 
    
    proc dumpPrimitive(str: string, v: Value) =
        if not muted:   stdoutWrite fmt("{bold(greenColor)}{str}{fg(grayColor)} :{($(v.kind)).toLowerAscii()}{resetColor}")
        else:           stdoutWrite fmt("{str} :{($(v.kind)).toLowerAscii()}")

    proc dumpIdentifier(v: Value) =
        if not muted:   stdoutWrite fmt("{resetColor}{v.s}{fg(grayColor)} :{($(v.kind)).toLowerAscii()}{resetColor}")
        else:           stdoutWrite fmt("{v.s} :{($(v.kind)).toLowerAscii()}")

    proc dumpAttribute(v: Value) =
        if not muted:   stdoutWrite fmt("{resetColor}{v.s}{fg(grayColor)} :{($(v.kind)).toLowerAscii()}{resetColor}")
        else:           stdoutWrite fmt("{v.s} :{($(v.kind)).toLowerAscii()}")

    proc dumpSymbol(v: Value) =
        if not muted:   stdoutWrite fmt("{resetColor}{v.m}{fg(grayColor)} :{($(v.kind)).toLowerAscii()}{resetColor}")
        else:           stdoutWrite fmt("{v.m} :{($(v.kind)).toLowerAscii()}")

    proc dumpBinary(b: Byte) =
        if not muted:   stdoutWrite fmt("{resetColor}{fg(grayColor)}{b:02X} {resetColor}")
        else:           stdoutWrite fmt("{b:02X} ")

    proc dumpBlockStart(v: Value) =
        var tp = ($(v.kind)).toLowerAscii()
        if v.kind==Object: tp = v.proto.name
        if not muted:   stdoutWrite fmt("{bold(magentaColor)}[{fg(grayColor)} :{tp}{resetColor}\n")
        else:           stdoutWrite fmt("[ :{tp}\n")

    proc dumpBlockEnd() =
        for i in 0..level-1: stdoutWrite "        "
        if not muted:   stdoutWrite fmt("{bold(magentaColor)}]{resetColor}")
        else:           stdoutWrite fmt("]")

    proc dumpHeader(str: string) =
        if not muted: stdoutWrite fmt("{resetColor}{fg(cyanColor)}")
        let lln = "================================\n"
        for i in 0..level: stdoutWrite "        "
        stdoutWrite lln
        for i in 0..level: stdoutWrite "        "
        stdoutWrite " " & str & "\n"
        for i in 0..level: stdoutWrite "        "
        stdoutWrite lln
        if not muted: stdoutWrite fmt("{resetColor}")

    for i in 0..level-1: stdoutWrite "        "

    if prepend!="":
        stdoutWrite prepend

    case v.kind:
        of Null         : dumpPrimitive("null",v)
        of Logical      : dumpPrimitive($(v.b), v)
        of Integer      : 
            if likely(v.iKind==NormalInteger): dumpPrimitive($(v.i), v)
            else: 
                when defined(WEB) or defined(GMP):
                    dumpPrimitive($(v.bi), v)
        of Floating     :
            #if v.fKind==NormalFloating:
            if v.f==Inf: dumpPrimitive("∞", v)
            elif v.f==NegInf: dumpPrimitive("-∞", v)
            else: dumpPrimitive($(v.f), v)
            # else:
            #     when not defined(WEB) and defined(GMP): 
            #         dumpPrimitive($(v.bf), v)
        of Complex      : dumpPrimitive($(v.z.re) & (if v.z.im >= 0: "+" else: "") & $(v.z.im) & "i", v)
        of Rational     : dumpPrimitive($(v.rat), v)
        of Version      : dumpPrimitive($(v.version), v)
        of Type         : 
            if v.tpKind==BuiltinType:
                dumpPrimitive(($(v.t)).toLowerAscii(), v)
            else:
                dumpPrimitive(v.tid, v)
        of Char         : dumpPrimitive($(v.c), v)
        of String       : dumpPrimitive(v.s, v)
        
        of Word,
           Literal,
           Label        : dumpIdentifier(v)

        of Attribute,
           AttributeLabel    : dumpAttribute(v)

        of Path,
           PathLabel,
           PathLiteral  :
            dumpBlockStart(v)

            for i,child in v.p:
                dump(child, level+1, i==(v.a.len-1), muted=muted, target=target)

            stdoutWrite "\n"

            dumpBlockEnd()

        of Symbol, 
           SymbolLiteral: dumpSymbol(v)

        of Unit         : dumpPrimitive($(v.u), v)
        of Quantity     : dumpPrimitive($(v.q), v)

        of Error        : dumpPrimitive($(v.err), v)       
        of ErrorKind    : dumpPrimitive($(v.errKind), v)

        of Regex        : dumpPrimitive($(v.rx), v)

        of Color        : dumpPrimitive($(v.l), v)

        of Date         : 
            dumpBlockStart(v)

            let keys = toSeq(v.e.keys)

            if keys.len > 0:
                let maxLen = (keys.map(proc (x: string):int = x.len)).max + 2

                for key,value in v.e:
                    for i in 0..level: stdoutWrite "        "

                    stdoutWrite unicode.alignLeft(key & " ", maxLen) & ":"

                    dump(value, level+1, false, muted=muted, target=target)

            dumpBlockEnd()

        of Binary       : 
            dumpBlockStart(v)

            for i in 0..level: stdoutWrite "        "
            for i,child in v.n:
                dumpBinary(child)
                if (i+1) mod 20 == 0:
                    stdoutWrite "\n"
                    for i in 0..level: stdoutWrite "        "
            
            stdoutWrite "\n"

            dumpBlockEnd()

        # TODO(VM/values/value) `dump` doesn't print nested blocks/dictionaries properly
        #  try: `inspect #[a:#[b: 'c]]`
        #  labels: enhancement, values
        of Inline,
            Block        :
            dumpBlockStart(v)
            for i,child in v.a:
                dump(child, level+1, i==(v.a.len-1), muted=muted, target=target)

            stdoutWrite "\n"

            dumpBlockEnd()

        of Range        : dumpPrimitive($(v.rng), v)

        of Dictionary   : 
            dumpBlockStart(v)

            let keys = toSeq(v.d.keys)

            if keys.len > 0:
                let maxLen = (keys.map(proc (x: string):int = x.len)).max + 2

                for key,value in v.d:
                    for i in 0..level: stdoutWrite "        "

                    stdoutWrite unicode.alignLeft(key & " ", maxLen) & ":"

                    dump(value, level+1, false, muted=muted, target=target)

            dumpBlockEnd()

        of Store        :
            ensureStoreIsLoaded(v.sto)

            dumpBlockStart(v)

            let keys = toSeq(v.sto.data.keys)

            if keys.len > 0:
                let maxLen = (keys.map(proc (x: string):int = x.len)).max + 2

                for key,value in v.sto.data:
                    for i in 0..level: stdoutWrite "        "

                    stdoutWrite unicode.alignLeft(key & " ", maxLen) & ":"

                    dump(value, level+1, false, muted=muted, target=target)

            dumpBlockEnd()
        
        of Object   : 
            dumpBlockStart(v)

            let keys = toSeq(v.o.objectKeys)

            if keys.len > 0:
                let maxLen = (keys.map(proc (x: string):int = x.len)).max + 2

                for key,value in v.o.objectPairs:
                    for i in 0..level: stdoutWrite "        "

                    stdoutWrite unicode.alignLeft(key & " ", maxLen) & ":"

                    dump(value, level+1, false, muted=muted, target=target)

            dumpBlockEnd()

        of Function     : 
            dumpBlockStart(v)

            if v.fnKind==UserFunction:
                dump(newWordBlock(v.params), level+1, false, muted=muted, target=target)
                dump(v.main, level+1, true, muted=muted, target=target)
            else:
                for i in 0..level: stdoutWrite "        "
                stdoutWrite "(builtin)"

            stdoutWrite "\n"

            dumpBlockEnd()

        of Method       :
            dumpBlockStart(v)

            dump(newWordBlock(v.mparams), level+1, false, muted=muted, target=target)
            dump(v.mmain, level+1, true, muted=muted, target=target)

            stdoutWrite "\n"

            dumpBlockEnd()

        of Database     :
            when not defined(NOSQLITE):
                if v.dbKind==SqliteDatabase: stdoutWrite fmt("[sqlite db] {cast[uint](v.sqlitedb):#X}")
                #elif v.dbKind==MysqlDatabase: stdout.write fmt("[mysql db] {cast[uint](v.mysqldb):#X}")

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

                dump(child, level+1, false, muted=muted, prepend=prep, target=target)

            stdoutWrite "\n"

            dumpHeader("CODE")

            var i = 0
            while i < instrs.len:
                for i in 0..level: stdout.write "        "
                let preop = instrs[i].s
                stdoutWrite preop
                i += 1
                if i < instrs.len and instrs[i].kind==Integer:
                    stdoutWrite " ".repeat(20 - preop.len)
                    while i < instrs.len and instrs[i].kind==Integer:
                        var numstr = $(instrs[i].i)
                        if preop.contains("jmp") or preop.contains("go"):
                            numstr = "@" & numstr
                        else:
                            numstr = "#" & numstr
                        if not muted: stdoutWrite fmt("{resetColor}{fg(grayColor)} {numstr}{resetColor}")
                        else: stdoutWrite numstr
                        i += 1
                stdoutWrite "\n"

            dumpBlockEnd()

        of Nothing      : discard
        of ANY          : discard

    if not isLast:
        stdoutWrite "\n"

proc dumped*(v: Value, level: int=0, isLast: bool=false, muted: bool=false, prepend=""): string = 
    var ss: ref string = new(string)
    ss[] = ""
    dump(v,target=ss)
    return ss[]

# TODO Fix pretty-printing for unwrapped blocks
#  Indentation is not working right for inner dictionaries and blocks
#  Check: `print as.pretty.code.unwrapped info.get 'get`
#  labels: values,enhancement,library

# TODO(VM/values/printable) Implement `as.code` for Object values
#  we should over a magic method for that - `asCode`? - and if it's not
#  there, either throw an error, or do sth (but what?!)
#  labels: values,enhancement,oop

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
                when defined(WEB) or defined(GMP):
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
                result &= ":" & v.tid
        of Char         : result &= "'" & $(v.c) & "'"
        of String       : 
            if safeStrings:
                result &= "««" & v.s & "»»"
            else:
                if countLines(v.s)>1 or v.s.contains("\""):
                    var splitl = join(toSeq(splitLines(v.s)),"\n" & repeat("        ",level+1))
                    result &= "{\n" & repeat("        ",level+1) & splitl & "\n" & repeat("        ",level) & "}"
                else:
                    # TODO(Values/printable) `codify` could work better for String values
                    #  right now, it also escape Unicode values and that may not be what we need
                    #  on the other hand, perhaps it shouldn't even be used for that type of things(?)
                    #  labels: vm,values,open discussion
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
        of Quantity     : result &= codify(v.q)
        of Regex        : result &= "{/" & $(v.rx) & "/}"
        of Color        : result &= $(v.l)
        of Date         : result &= fmt("to :date \"{v.eobj}\"")

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

        of Method:
            result &= "method "
            result &= codify(newWordBlock(v.mparams),pretty,unwrapped,level+1, false, safeStrings=safeStrings)

            result &= " "
            result &= codify(v.mmain,pretty,unwrapped,level+1, true, safeStrings=safeStrings)

        else:
            result &= ""
    
    if pretty:
        if not isLast:
            result &= "\n"
