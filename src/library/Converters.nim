######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: library/Converters.nim
######################################################

#=======================================
# Libraries
#=======================================

import sequtils, strformat, unicode
import extras/bignum

import helpers/datasource as DatasourceHelper
import helpers/strings as StringsHelper

import vm/[common, errors, exec, globals, parse, stack, value]

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Converters"

    builtin "array",
        alias       = at, 
        rule        = PrefixPrecedence,
        description = "create array from given block, by reducing/calculating all internal values",
        args        = {
            "source": {String,Block}
        },
        attrs       = NoAttrs,
        returns     = {Block},
        example     = """
            none: @[]               ; none: []
            a: @[1 2 3]             ; a: [1 2 3]
            
            b: 5
            c: @[b b+1 b+2]         ; c: [5 6 7]
            
            d: @[
                3+1
                print "we are in the block"
                123
                print "yep"
            ]
            ; we are in the block
            ; yep
            ; => [4 123]
        """:
            ##########################################################
            let stop = SP

            if x.kind==Block:
                discard execBlock(x)
            elif x.kind==String:
                let (_{.inject.}, tp) = getSource(x.s)

                if tp!=TextData:
                    discard execBlock(doParse(x.s, isFile=false))#, isIsolated=true)
                else:
                    echo "file does not exist"

            let arr: ValueArray = sTopsFrom(stop)
            SP = stop

            stack.push(newBlock(arr))

    builtin "as",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "format given value as implied type",
        args        = {
            "value" : {Any}
        },
        attrs       = {
            "binary"    : ({Boolean},"format integer as binary"),
            "hex"       : ({Boolean},"format integer as hexadecimal"),
            "octal"     : ({Boolean},"format integer as octal"),
            "ascii"     : ({Boolean},"transliterate string to ASCII"),
            "agnostic"  : ({Boolean},"convert words in block to literals, if not in context")
        },
        returns     = {Any},
        example     = """
            print as.binary 123           ; 1111011
            print as.octal 123            ; 173
            print as.hex 123              ; 7b
            
            print as.ascii "thís ìß ñot à tést"
            ; this iss not a test
        """:
            ##########################################################
            if (popAttr("binary") != VNULL):
                stack.push(newString(fmt"{x.i:b}"))
            elif (popAttr("hex") != VNULL):
                stack.push(newString(fmt"{x.i:x}"))
            elif (popAttr("octal") != VNULL):
                stack.push(newString(fmt"{x.i:o}"))
            elif (popAttr("ascii") != VNULL):
                stack.push(convertToAscii(x.s))
            elif (popAttr("agnostic") != VNULL):
                let res = x.a.map(proc(v:Value):Value =
                    if v.kind == Word and not Syms.hasKey(v.s): newLiteral(v.s)
                    else: v
                )
                stack.push(newBlock(res))
            else:
                stack.push(x)

    builtin "dictionary",
        alias       = sharp, 
        rule        = PrefixPrecedence,
        description = "create dictionary from given block or file, by getting all internal symbols",
        args        = {
            "source": {String,Block}
        },
        attrs       = {
            "with"  : ({Block},"embed given symbols"),
            "raw"   : ({Boolean},"create dictionary from raw block")
        },
        returns     = {Dictionary},
        example     = """
            none: #[]               ; none: []
            a: #[
                name: "John"
                age: 34
            ]             
            ; a: [name: "John", age: 34]
            
            d: #[
                name: "John"
                print "we are in the block"
                age: 34
                print "yep"
            ]
            ; we are in the block
            ; yep
            ; => [name: "John", age: 34]
        """:
            ##########################################################
            var dict: ValueDict

            if x.kind==Block:
                #dict = execDictionary(x)
                if (popAttr("raw") != VNULL):
                    dict = initOrderedTable[string,Value]()
                    var idx = 0
                    while idx < x.a.len:
                        dict[x.a[idx].s] = x.a[idx+1]
                        idx += 2
                else:
                    dict = execBlock(x,dictionary=true)
            elif x.kind==String:
                let (src, tp) = getSource(x.s)

                if tp!=TextData:
                    dict = execBlock(doParse(src, isFile=false), dictionary=true)#, isIsolated=true)
                else:
                    echo "file does not exist"

            if (let aWith = popAttr("with"); aWith != VNULL):
                for x in aWith.a:
                    dict[x.s] = Syms[x.s]
                    
            stack.push(newDictionary(dict))

    builtin "function",
        alias       = dollar, 
        rule        = PrefixPrecedence,
        description = "create function with given arguments and body",
        args        = {
            "arguments" : {Block},
            "body"      : {Block}
        },
        attrs       = {
            "export": ({Block},"export given symbols to parent")
        },
        returns     = {Function},
        example     = """
            f: function [x][ x + 2 ]
            print f 10                ; 12
            
            f: $[x][x+2]
            print f 10                ; 12
            
            multiply: function [x,y][
                x * y
            ]
            print multiply 3 5        ; 15
            
            publicF: function .export['x] [z][
                print ["z =>" z]
                x: 5
            ]
            
            publicF 10
            ; z => 10
            
            print x
            ; 5
        """:
            ##########################################################
            var exports = VNULL
            if (let aExport = popAttr("export"); aExport != VNULL):
                exports = aExport

            stack.push(newFunction(x,y,exports))

    builtin "to",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "convert value to given type",
        args        = {
            "type"  : {Type},
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Any},
        example     = """
            to :string 2020               ; "2020"
            to :integer "2020"            ; 2020
            
            to :integer `A`               ; 65
            to :char 65                   ; `A`
            
            to :integer 4.3               ; 4
            to :floating 4                ; 4.0
            
            to :boolean 0                 ; false
            to :boolean 1                 ; true
            to :boolean "true"            ; true
            
            to :literal "symbol"          ; 'symbol
            to :string 'symbol            ; "symbol"
            to :string :word              ; "word"
            
            to :block "one two three"     ; [one two three]
        """:
            ##########################################################
            let tp = x.t
            
            if y.kind == tp:
                stack.push y
            else:
                case y.kind:
                    of Null:
                        case tp:
                            of Boolean: stack.push VFALSE
                            of Integer: stack.push I0
                            of String: stack.push newString("null")
                            else: showConversionError()

                    of Boolean:
                        case tp:
                            of Integer:
                                if y.b: stack.push I1
                                else: stack.push I0
                            of Floating:
                                if y.b: stack.push F1
                                else: stack.push F0
                            of String:
                                if y.b: stack.push newString("true")
                                else: stack.push newString("false")
                            else: showConversionError()

                    of Integer:
                        case tp:
                            of Boolean: stack.push newBoolean(y.i!=0)
                            of Floating: stack.push newFloating((float)y.i)
                            of Char: stack.push newChar(chr(y.i))
                            of String: 
                                if y.iKind==NormalInteger: stack.push newString($(y.i))
                                else: stack.push newString($(y.bi))
                            of Binary:
                                let str = $(y.i)
                                var ret: ByteArray = newSeq[byte](str.len)
                                for i,ch in str:
                                    ret[i] = (byte)(ord(ch))
                                stack.push newBinary(ret)
                            else: showConversionError()

                    of Floating:
                        case tp:
                            of Boolean: stack.push newBoolean(y.f!=0.0)
                            of Integer: stack.push newInteger((int)y.f)
                            of Char: stack.push newChar(chr((int)y.f))
                            of String: stack.push newString($(y.f))
                            of Binary:
                                let str = $(y.f)
                                var ret: ByteArray = newSeq[byte](str.len)
                                for i,ch in str:
                                    ret[i] = (byte)(ord(ch))
                                stack.push newBinary(ret)
                            else: showConversionError()

                    of Type:
                        if tp==String: stack.push newString(($(y.t)).toLowerAscii())
                        else: showConversionError()

                    of Char:
                        case tp:
                            of Integer: stack.push newInteger(ord(y.c))
                            of Floating: stack.push newFloating((float)ord(y.c))
                            of String: stack.push newString($(y.c))
                            of Binary: stack.push newBinary(@[(byte)(ord(y.c))])
                            else: showConversionError()

                    of String:
                        case tp:
                            of Boolean: 
                                if y.s=="true": stack.push VTRUE
                                elif y.s=="false": stack.push VFALSE
                                else: invalidConversionError(y.s)
                            of Integer:
                                try:
                                    stack.push newInteger(y.s)
                                except ValueError:
                                    invalidConversionError(y.s)
                            of Floating:
                                try:
                                    stack.push newFloating(parseFloat(y.s))
                                except ValueError:
                                    invalidConversionError(y.s)
                            of Type:
                                try:
                                    stack.push newType(y.s)
                                except ValueError:
                                    invalidConversionError(y.s)
                            of Char:
                                if y.s.runeLen() == 1:
                                    stack.push newChar(y.s)
                                else:
                                    invalidConversionError(y.s)
                            of Word:
                                stack.push newWord(y.s)
                            of Literal:
                                stack.push newLiteral(y.s)
                            of Label:
                                stack.push newLabel(y.s)
                            of Attribute:
                                stack.push newAttribute(y.s)
                            of AttributeLabel:
                                stack.push newAttributeLabel(y.s)
                            of Symbol:
                                try:
                                    stack.push newSymbol(y.s)
                                except ValueError:
                                    invalidConversionError(y.s)
                            of Binary:
                                var ret: ByteArray = newSeq[byte](y.s.len)
                                for i,ch in y.s:
                                    ret[i] = (byte)(ord(ch))
                                stack.push newBinary(ret)
                            of Block:
                                stack.push doParse(y.s, isFile=false)
                            else:
                                showConversionError()

                    of Literal, 
                        Word:
                        case tp:
                            of String: 
                                stack.push newString(y.s)
                            of Literal:
                                stack.push newLiteral(y.s)
                            else:
                                showConversionError()

                    of Block:
                        case tp:
                            of Dictionary:
                                let stop = SP
                                discard execBlock(y)

                                let arr: ValueArray = sTopsFrom(stop)
                                var dict: ValueDict = initOrderedTable[string,Value]()
                                SP = stop

                                var i = 0
                                while i<arr.len:
                                    if i+1<arr.len:
                                        dict[$(arr[i])] = arr[i+1]
                                    i += 2

                                stack.push(newDictionary(dict))
                            else:
                                discard

                    of Symbol:
                        case tp:
                            of String:
                                stack.push newString($(y))
                            of Literal:
                                stack.push newLiteral($(y))
                            else:
                                showConversionError()

                    of Dictionary,
                        Function,
                        Database,
                        Nothing,
                        Any,
                        Inline,
                        Label,
                        Attribute,
                        AttributeLabel,
                        Path,
                        PathLabel,
                        Date,
                        Custom,
                        Binary: discard

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)