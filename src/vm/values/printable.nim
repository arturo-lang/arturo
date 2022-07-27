######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/values/printable.nim
######################################################

#=======================================
# Libraries
#=======================================

import rationals except Rational

import sequtils, strformat, strutils
import sugar, tables, times, unicode

when defined(WEB):
    import std/jsbigints

when not defined(NOGMP):
    import helpers/bignums as BignumsHelper

import helpers/colors as ColorsHelper
import helpers/quantities as QuantitiesHelper
import helpers/regex as RegexHelper

import vm/exec
import vm/stack
import vm/values/value

#=======================================
# Methods
#=======================================

func `$`*(s: SymbolKind): string =
    case s:
        of thickarrowleft           : result = "<="
        of thickarrowright          : result = "=>"
        of thickarrowboth           : result = "<=>"
        of thickarrowdoubleleft     : result = "<<="
        of thickarrowdoubleright    : result = "=>>"
        of thickarrowdoubleboth     : result = "<<=>>"
        of arrowleft                : result = "<-"
        of arrowright               : result = "->"
        of arrowboth                : result = "<->"
        of arrowdoubleleft          : result = "<<-"
        of arrowdoubleright         : result = "->>"
        of arrowdoubleboth          : result = "<<->>"
        of reversearrowleft         : result = "-<"
        of reversearrowright        : result = ">-"
        of reversearrowboth         : result = ">-<"
        of reversearrowdoubleleft   : result = "-<<"
        of reversearrowdoubleright  : result = ">>-"
        of reversearrowdoubleboth   : result = ">>-<<"
        of doublearrowleft          : result = "<<"
        of doublearrowright         : result = ">>"
        of triplearrowleft          : result = "<<<"
        of triplearrowright         : result = ">>>"
        of longarrowleft            : result = "<--"
        of longarrowright           : result = "-->"
        of longarrowboth            : result = "<-->"
        of longthickarrowleft       : result = "<=="
        of longthickarrowright      : result = "==>"
        of longthickarrowboth       : result = "<==>"
        of tildeleft                : result = "<~"
        of tilderight               : result = "~>"
        of tildeboth                : result = "<~>"
        of triangleright            : result = "|>"
        of triangleleft             : result = "<|"
        of triangleboth             : result = "<|>"

        of equalless                : result = "=<"
        of greaterequal             : result = ">="
        of lessgreater              : result = "<>"

        of lesscolon                : result = "<:"
        of minuscolon               : result = "-:"
        of greatercolon             : result = ">:"

        of tilde                    : result = "~"
        of exclamation              : result = "!"
        of doubleexclamation        : result = "!!"
        of question                 : result = "?"
        of doublequestion           : result = "??"
        of at                       : result = "@"
        of sharp                    : result = "#"
        of doublesharp              : result = "##"
        of triplesharp              : result = "###"
        of quadruplesharp           : result = "####"
        of quintuplesharp           : result = "#####"
        of sextuplesharp            : result = "######"
        of dollar                   : result = "$"
        of percent                  : result = "%"
        of caret                    : result = "^"
        of ampersand                : result = "&"
        of asterisk                 : result = "*"
        of minus                    : result = "-"
        of doubleminus              : result = "--"
        of underscore               : result = "_"
        of equal                    : result = "="
        of doubleequal              : result = "=="
        of approxequal              : result = "=~"
        of plus                     : result = "+"
        of doubleplus               : result = "++"
        of lessthan                 : result = "<"
        of greaterthan              : result = ">"
        of slash                    : result = "/"
        of doubleslash              : result = "//"
        of backslash                : result = "\\"
        of doublebackslash          : result = "\\\\"
        of logicaland               : result = "/\\"
        of logicalor                : result = "\\/"
        of pipe                     : result = "|"
        of turnstile                : result = "|-"
        of doubleturnstile          : result = "|="

        of ellipsis                 : result = ".."
        of longellipsis             : result = "..."
        of dotslash                 : result = "./"
        of colon                    : result = ":"
        of doublecolon              : result = "::"
        of doublepipe               : result = "||"

        of slashedzero              : result = "ø"
        of infinite                 : result = "∞"

        of unaliased                : discard

proc `$`*(v: Value): string {.inline.} =
    case v.kind:
        of Null         : return "null"
        of Logical      : return $(v.b)
        of Integer      : 
            if v.iKind==NormalInteger: return $(v.i)
            else:
                when defined(WEB) or not defined(NOGMP): 
                    return $(v.bi)
        of Floating     : 
            if v.fKind==NormalFloating: 
                if v.f==Inf: return "∞"
                elif v.f==NegInf: return "-∞"
                else: return $(v.f)
            else:
                when defined(WEB) or not defined(NOGMP): 
                    return $(v.bf)
        of Complex      : 
            return $(v.z.re) & (if v.z.im >= 0: "+" else: "") & $(v.z.im) & "i"
        of Rational     :
            return $(v.rat)
        of Version      : return fmt("{v.major}.{v.minor}.{v.patch}{v.extra}")
        of Type         : 
            if v.tpKind==BuiltinType:
                return ":" & ($v.t).toLowerAscii()
            else:
                return ":" & v.name
        of Char         : return $(v.c)
        of String,
           Word, 
           Literal,
           Label        : return v.s
        of Attribute,
           AttributeLabel    : return v.r
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
            result = v.n.map((child) => fmt"{child:X}").join(" ")
        of Inline,
           Block     :
            # result = "["
            # for i,child in v.a:
            #     result &= $(child) & " "
            # result &= "]"

            result = "[" & cleanBlock(v.a).map((child) => $(child)).join(" ") & "]"

        of Dictionary   :
            if not v.custom.isNil and v.custom.methods.d.hasKey("print"):
                push v
                callFunction(v.custom.methods.d["print"])
                result = pop().s
            else:
                var items: seq[string] = @[]
                for key,value in v.d:
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
            result = "<bytecode>"
            
        of Newline: discard
        of Nothing: discard
        of ANY: discard