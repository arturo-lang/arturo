#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: library/Converters.nim
#=======================================================

## The main Converters module 
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import algorithm, parseutils, sequtils, strformat, sugar, times, unicode

import helpers/arrays
when not defined(NOGMP):
    import helpers/bignums

import helpers/datasource
when not defined(NOASCIIDECODE):
    import helpers/strings

import helpers/ranges
when not defined(WEB):
    import helpers/stores

import vm/lib
import vm/[bytecode, errors, eval, exec, opcodes, parse]

import vm/values/custom/[vbinary, vrange]

#=======================================
# Helpers
#=======================================

func canBeInlined(v: Value): bool {.enforceNoRaises.} =
    for item in v.a:
        if item.kind == Label:
            return false
        elif item.kind == Block:
            if not canBeInlined(item):
                return false
    return true

proc parseFL(s: string): float =
    result = 0.0
    let L = parseutils.parseFloat(s, result, 0)
    if L != s.len or L == 0:
        raise newException(ValueError, "invalid float: " & s)

proc generateCustomObject(prot: Prototype, arguments: ValueArray | ValueDict): Value =
    newObject(arguments, prot, proc (self: Value, prot: Prototype) =
        if (let initMethod = prot.methods.getOrDefault("init", nil); not initMethod.isNil):
            prot.doInit(self)
            # push self
            # callFunction(initMethod)
    )

template throwCannotConvert(): untyped = 
    RuntimeError_CannotConvert(codify(y), $(y.kind), (if x.tpKind==UserType: x.ts.name else: $(x.t)))

template throwConversionFailed(): untyped =
    RuntimeError_ConversionFailed(codify(y), $(y.kind), (if x.tpKind==UserType: x.ts.name else: $(x.t)))

# TODO(Converters) Make sure `convertedValueToType` works fine + add tests
#  labels: library, cleanup, unit-test

proc convertedValueToType(x, y: Value, tp: ValueKind, aFormat:Value = nil): Value =
    if y.kind == tp and y.kind!=Quantity:
        return y
    else:
        case y.kind:
            of Null:
                case tp:
                    of Logical: return VFALSE
                    of Integer: return I0
                    of String: return newString("null")
                    else: throwCannotConvert()

            of Logical:
                case tp:
                    of Integer:
                        if isTrue(y): return I1
                        elif isFalse(y): return I0
                        else: return VNULL
                    of Floating:
                        if isTrue(y): return F1
                        elif isFalse(y): return F0
                        else: return VNULL
                    of String:
                        if y.b==True: return newString("true")
                        elif y.b==False: return newString("false")
                        else: return newString("maybe")
                    else: throwCannotConvert()

            of Integer:
                case tp:
                    of Logical: return newLogical(y.i!=0)
                    of Floating: return newFloating(float(y.i))
                    of Rational: return newRational(y.i)
                    of Char: return newChar(toUTF8(Rune(y.i)))
                    of String: 
                        if y.iKind==NormalInteger: 
                            if (not aFormat.isNil):
                                try:
                                    var ret: string
                                    formatValue(ret, y.i, aFormat.s)
                                    return newString(ret)
                                except CatchableError:
                                    throwConversionFailed()
                            else:
                                return newString($(y.i))
                        else:
                            when not defined(NOGMP): 
                                return newString($(y.bi))
                    of Quantity:
                        if checkAttr("unit", doValidate=false):
                            return newQuantity(y, parseQuantitySpec(aUnit.s))
                        else:
                            throwConversionFailed()
                    of Date:
                        return newDate(local(fromUnix(y.i)))
                    of Binary:
                        if y.iKind==NormalInteger:
                            return newBinary(numberToBinary(y.i))
                        else:
                            throwConversionFailed()
                    else: throwCannotConvert()

            of Floating:
                case tp:
                    of Logical: return newLogical(y.f!=0.0)
                    of Integer: return newInteger(int(y.f))
                    of Rational: return newRational(y.f)
                    of Char: return newChar(chr(int(y.f)))
                    of String: 
                        if (not aFormat.isNil):
                            try:
                                var ret: string
                                formatValue(ret, y.f, aFormat.s)
                                return newString(ret)
                            except CatchableError:
                                throwConversionFailed()
                        else:
                            return newString($(y.f))
                    of Quantity:
                        if checkAttr("unit", doValidate=false):
                            return newQuantity(y, parseQuantitySpec(aUnit.s))
                        else:
                            throwConversionFailed()
                    of Binary:
                        return newBinary(numberToBinary(y.f))
                    else: throwCannotConvert()

            of Complex:
                case tp:
                    of String: 
                        if (not aFormat.isNil):
                            try:
                                var ret: string
                                formatValue(ret, y.z.re, aFormat.s)
                                var ret2: string
                                formatValue(ret2, y.z.im, aFormat.s)

                                return newString($(ret) & (if y.z.im >= 0: "+" else: "") & $(ret2) & "i")
                            except CatchableError:
                                throwConversionFailed()
                        else:
                            return newString($(y))
                    of Block:
                        return newBlock(@[
                            newFloating(y.z.re),
                            newFloating(y.z.im)
                        ])
                    else: throwCannotConvert()

            of Rational:
                case tp:
                    of Integer:
                        return newInteger(toInt(y.rat))
                    of Floating:
                        return newFloating(toFloat(y.rat))
                    of String: 
                        return newString($(y))
                    of Block:
                        return newBlock(@[
                            newInteger(y.rat.num),
                            newInteger(y.rat.den)
                        ])
                    else: throwCannotConvert()

            of Version:
                if tp==String: return newString($(y))
                else: throwCannotConvert()

            of Type:
                if tp==String: return newString(($(y.t)).toLowerAscii())
                else: throwCannotConvert()

            of Char:
                case tp:
                    of Integer: return newInteger(ord(y.c))
                    of Floating: return newFloating(float(ord(y.c)))
                    of String: return newString($(y.c))
                    of Binary: return newBinary(@[byte(ord(y.c))])
                    else: throwCannotConvert()

            of String:
                case tp:
                    of Logical: 
                        if y.s=="true": return VTRUE
                        elif y.s=="false": return VFALSE
                        else: throwConversionFailed()
                    of Integer:
                        try:
                            return newInteger(y.s)
                        except ValueError:
                            throwConversionFailed()
                    of Floating:
                        try:
                            return newFloating(parseFL(y.s))
                        except ValueError:
                            throwConversionFailed()
                    of Version:
                        try:
                            return newVersion(y.s)
                        except ValueError:
                            throwConversionFailed()
                    of Type:
                        try:
                            return newType(y.s)
                        except ValueError:
                            throwConversionFailed()
                    of Char:
                        if y.s.runeLen() == 1:
                            return newChar(y.s)
                        else:
                            throwConversionFailed()
                    of Word:
                        return newWord(y.s)
                    of Literal:
                        return newLiteral(y.s)
                    of Label:
                        return newLabel(y.s)
                    of Attribute:
                        return newAttribute(y.s)
                    of AttributeLabel:
                        return newAttributeLabel(y.s)
                    of Symbol:
                        try:
                            return newSymbol(y.s)
                        except ValueError:
                            throwConversionFailed()
                    of Regex:
                        return newRegex(y.s)
                    of Binary:
                        var ret: VBinary = newSeq[byte](y.s.len)
                        for i,ch in y.s:
                            ret[i] = byte(ord(ch))
                        return newBinary(ret)
                    of Block:
                        return doParse(y.s, isFile=false)
                    of Color:
                        try:
                            return newColor(y.s)
                        except CatchableError:
                            throwConversionFailed()
                    of Date:
                        var dateFormat = "yyyy-MM-dd'T'HH:mm:sszzz"
                        if (not aFormat.isNil):
                            dateFormat = aFormat.s
                        
                        let timeFormat = initTimeFormat(dateFormat)
                        try:
                            return newDate(parse(y.s, timeFormat))
                        except CatchableError:
                            throwConversionFailed()
                    else:
                        throwCannotConvert()

            of Literal, 
               Word,
               Label:
                case tp:
                    of String: 
                        return newString(y.s)
                    of Literal:
                        return newLiteral(y.s)
                    of Word:
                        return newWord(y.s)
                    else:
                        throwCannotConvert()

            of Attribute,
               AttributeLabel:
                case tp:
                    of String: 
                        return newString(y.s)
                    of Literal:
                        return newLiteral(y.s)
                    of Word:
                        return newWord(y.s)
                    else:
                        throwCannotConvert()

            of Inline:
                case tp:
                    of Block:
                        return newBlock(y.a)
                    else:
                        throwCannotConvert()

            # TODO(Converters) Block -> String conversion not supported!
            #  as incredible as it may sound `to :string [1 2 3]` is not supported
            #  this must be fixed ASAP
            #  labels: library, bug, enhancement, critical
            of Block:
                case tp:
                    of Complex:
                        if (y.a[0].kind in {Floating, Integer} and
                            y.a[1].kind in {Floating, Integer}):
                            return newComplex(y.a[0], y.a[1])
                        else:
                            throwCannotConvert()
                    of Rational:
                        return newRational(y.a[0], y.a[1])
                    of Inline:
                        return newInline(y.a)
                    of Dictionary:
                        let stop = SP
                        execUnscoped(y)

                        let arr: ValueArray = sTopsFrom(stop)
                        var dict: ValueDict = initOrderedTable[string,Value]()
                        SP = stop

                        var i = 0
                        while i<arr.len:
                            if i+1<arr.len:
                                dict[$(arr[i])] = arr[i+1]
                            i += 2

                        return(newDictionary(dict))

                    of Object:
                        if x.tpKind==UserType:
                            let stop = SP
                            execUnscoped(y)

                            let arr: ValueArray = sTopsFrom(stop)
                            SP = stop

                            return generateCustomObject(x.ts, arr)
                        else:
                            throwCannotConvert()

                    of Quantity:
                        return newQuantity(y.a[0], parseQuantitySpec(y.a[1].s))

                    of Color:
                        if y.a.len < 3 or y.a.len > 4:
                            echo "wrong number of attributes"
                        else:
                            if (hadAttr("hsl")):
                                if y.a.len==3:
                                    return newColor(HSLtoRGB((y.a[0].i, y.a[1].f, y.a[2].f, 1.0)))
                                elif y.a.len==4:
                                    return newColor(HSLtoRGB((y.a[0].i, y.a[1].f, y.a[2].f, y.a[3].f)))
                            elif (hadAttr("hsv")):
                                if y.a.len==3:
                                    return newColor(HSVtoRGB((y.a[0].i, y.a[1].f, y.a[2].f, 1.0)))
                                elif y.a.len==4:
                                    return newColor(HSVtoRGB((y.a[0].i, y.a[1].f, y.a[2].f, y.a[3].f)))
                            else:
                                if y.a.len==3:
                                    return newColor((y.a[0].i, y.a[1].i, y.a[2].i, 255))
                                elif y.a.len==4:
                                    return newColor((y.a[0].i, y.a[1].i, y.a[2].i, y.a[3].i))

                    of Binary:
                        var res: VBinary
                        for item in y.a:
                            if item.kind==Integer:
                                res &= numberToBinary(item.i)
                            else:
                                res &= numberToBinary(item.f)
                        
                        return newBinary(res)

                    of Bytecode:
                        var evaled = doEval(y, omitNewlines=hadAttr("intrepid"))

                        return newBytecode(evaled)
                       
                    else:
                        discard

            of Range:
                if tp == Block:
                    return newBlock(toSeq(y.rng.items))
                else:
                    throwCannotConvert()

            of Dictionary:
                case tp:
                    of Object:
                        if x.tpKind==UserType:
                            return generateCustomObject(x.ts, y.d)
                        else:
                            throwCannotConvert()
                    of Bytecode:
                        var evaled = Translation(constants: y.d["data"].a, instructions: y.d["code"].a.map(proc (x:Value):byte = byte(x.i)))

                        return newBytecode(evaled)
                    else:
                        throwCannotConvert()
            
            of Object:
                case tp:
                    of Dictionary:
                        return newDictionary(y.o)
                    else:
                        throwCannotConvert()

            of Store:
                case tp:
                    of Dictionary:
                        ensureStoreIsLoaded(y.sto)
                        return newDictionary(y.sto.data)
                    else:
                        throwCannotConvert()

            of Bytecode:
                case tp:
                    of Dictionary:
                        return newDictionary({
                            "data": newBlock(y.trans.constants),
                            "code": newBlock(y.trans.instructions.map((w) => newInteger(int(w))))
                        }.toOrderedTable)
                    else:
                        throwCannotConvert()

            of Symbol:
                case tp:
                    of String:
                        return newString($(y))
                    of Literal:
                        return newLiteral($(y))
                    else:
                        throwCannotConvert()

            of SymbolLiteral:
                case tp:
                    of String:
                        return newString($(y))
                    of Literal:
                        return newLiteral($(y))
                    else:
                        throwCannotConvert()

            of Quantity:
                case tp:
                    of Integer, Floating:
                        return convertedValueToType(x, y.nm, tp, aFormat)
                    of String:
                        if (not aFormat.isNil):
                            try:
                                var ret: string
                                if y.nm.kind==Floating:
                                    formatValue(ret, y.nm.f, aFormat.s)
                                else:
                                    formatValue(ret, float(y.nm.i), aFormat.s)

                                return newString(ret & stringify(y.unit.name))
                            except CatchableError:
                                throwConversionFailed()
                        else:
                            return newString($(y))
                    of Quantity:
                        if checkAttr("unit", doValidate=false):
                            let target = parseQuantitySpec(aUnit.s).name
                            return newQuantity(convertQuantityValue(y.nm, y.unit.name, target), target)
                        else:
                            return y
                    else:
                        throwCannotConvert()

            of Regex:
                case tp:
                    of String:
                        return newString($(y))
                    else:
                        throwCannotConvert()

            of Date:
                case tp:
                    of Integer:
                        return newInteger(toUnix(toTime(y.eobj)))
                    of String:
                        var dateFormat = "yyyy-MM-dd'T'HH:mm:sszzz"
                        if (not aFormat.isNil):
                            dateFormat = aFormat.s
                        
                        try:
                            return newString(format(y.eobj, dateFormat))
                        except CatchableError:
                            throwConversionFailed()
                    else: 
                        throwCannotConvert()
            
            of Color:
                case tp:
                    of String:
                        return newString($(y))
                    else:
                        throwCannotConvert()

            of Function,
               Database,
               Socket,
               Nothing,
               Any,
               Path,
               PathLabel,
               Binary: discard

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    # TODO(Converters) resolving `from`/`to`/`as`/`in` clutter?
    #  Right now, we have 4 different built-in function performing different-but-similar actions.
    #  Is there any way to remove all ambiguity - by either reducing them, merging them, extending them or explaining their functionality more thoroughly?
    #  labels: library, enhancement, open discussion, documentation

    builtin "array",
        alias       = at, 
        op          = opArray,
        rule        = PrefixPrecedence,
        description = "create array from given block, by reducing/calculating all internal values",
        args        = {
            "source": {Any}
        },
        attrs       = {
            "of"    : ({Integer,Block},"initialize an empty n-dimensional array with given dimensions")
        },
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
            ..........
            ; initializing empty array with initial value
            x: array.of: 2 "done"
            inspect.muted x
            ; [ :block
            ;     done :string
            ;     done :string
            ; ]
            ..........
            ; initializing empty n-dimensional array with initial value
            x: array.of: [3 4] 0          ; initialize a 3x4 2D array
                                            ; with zeros
            ; => [[0 0 0 0] [0 0 0 0] [0 0 0 0]]
        """:
            #=======================================================
            if checkAttr("of"):
                if aOf.kind == Integer:
                    let size = aOf.i
                    let blk:ValueArray = safeRepeat(x, size)
                    push newBlock(blk)
                else:
                    var val: Value = copyValue(x)
                    var blk: ValueArray

                    for item in aOf.a.reversed:
                        blk = safeRepeat(val, item.i)
                        val = newBlock(blk.map((v)=>copyValue(v)))

                    push newBlock(blk)
            else:
                if xKind==Range:
                    push(newBlock(toSeq(items(x.rng))))
                else:
                    if xKind==Block:
                        let stop = SP
                        execUnscoped(x)
                        let arr: ValueArray = sTopsFrom(stop)
                        SP = stop

                        push(newBlock(arr))
                    elif xKind==String:
                        let stop = SP
                        let (_{.inject.}, tp) = getSource(x.s)

                        if tp!=TextData:
                            execUnscoped(doParse(x.s, isFile=false))
                        else:
                            echo "file does not exist"
                        let arr: ValueArray = sTopsFrom(stop)
                        SP = stop

                        push(newBlock(arr))
                    else:
                        push(newBlock(@[x]))

    # TODO(Converters/as) is `.unwrapped` working as expected?
    #  labels: library, bug
    builtin "as",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "format given value as implied type",
        args        = {
            "value" : {Any}
        },
        attrs       = 
        when not defined(NOASCIIDECODE):
            {
                "binary"    : ({Logical},"format integer as binary"),
                "hex"       : ({Logical},"format integer as hexadecimal"),
                "octal"     : ({Logical},"format integer as octal"),
                "ascii"     : ({Logical},"transliterate string to ASCII"),
                "agnostic"  : ({Logical},"convert words in block to literals, if not in context"),
                "data"      : ({Logical},"parse input as Arturo data block"),
                "code"      : ({Logical},"convert value to valid Arturo code"),
                "pretty"    : ({Logical},"prettify generated code"),
                "unwrapped" : ({Logical},"omit external block notation")
            }
        else:
            {
                "binary"    : ({Logical},"format integer as binary"),
                "hex"       : ({Logical},"format integer as hexadecimal"),
                "octal"     : ({Logical},"format integer as octal"),
                "agnostic"  : ({Logical},"convert words in block to literals, if not in context"),
                "data"      : ({Logical},"parse input as Arturo data block"),
                "code"      : ({Logical},"convert value to valid Arturo code"),
                "pretty"    : ({Logical},"prettify generated code"),
                "unwrapped" : ({Logical},"omit external block notation")
            }
        ,
        returns     = {Any},
        example     = """
            print as.binary 123           ; 1111011
            print as.octal 123            ; 173
            print as.hex 123              ; 7b
            ..........
            print as.ascii "thís ìß ñot à tést"
            ; this iss not a test
        """:
            #=======================================================
            if (hadAttr("binary")):
                push(newString(fmt"{x.i:b}"))
            elif (hadAttr("hex")):
                push(newString(fmt"{x.i:x}"))
            elif (hadAttr("octal")):
                push(newString(fmt"{x.i:o}"))
            elif (hadAttr("agnostic")):
                let res = x.a.map(proc(v:Value):Value =
                    if v.kind == Word and not SymExists(v.s): newLiteral(v.s)
                    else: v
                )
                push(newBlock(res))
            elif (hadAttr("data")):
                if xKind==Block:
                    push(parseDataBlock(x))
                elif xKind==String:
                    let (src, _) = getSource(x.s)
                    push(parseDataBlock(doParse(src, isFile=false)))
            elif (hadAttr("code")):
                push(newString(codify(x,pretty = (hadAttr("pretty")), unwrapped = (hadAttr("unwrapped")), safeStrings = (hadAttr("safe")))))
            else:
                when not defined(NOASCIIDECODE):
                    if (hadAttr("ascii")):
                        push(newString(convertToAscii(x.s)))
                    else:
                        push(x)
                else:
                    push(x)

    # TODO(Converters/define) not defined inheritance behavior when using `.as` 
    #  labels: library, enhancement
    builtin "define",
        alias       = dollar, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "define new type with given prototype",
        args        = {
            "type"      : {Type},
            "fields"    : {Block},
            "methods"   : {Block}
        },
        attrs       = {
            "as"    : ({Type}, "inherit given type")
        },
        returns     = {Nothing},
        example     = """
            define :person [name surname age][  

                ; magic method to be executed
                ; after a new object has been created
                init: [
                    this\name: capitalize this\name
                ]

                ; magic method to be executed
                ; when the object is about to be printed
                print: [
                    render "NAME: |this\name|, SURNAME: |this\surname|, AGE: |this\age|"
                ]

                ; magic method to be used
                ; when comparing objects (e.g. when sorting)
                compare: [
                    if this\age = that\age -> return 0
                    if this\age < that\age -> return neg 1
                    if this\age > that\age -> return 1
                ]
            ]

            sayHello: function [this][
                ensure -> is? :person this
                print ["Hello" this\name]
            ]

            a: to :person ["John" "Doe" 35]
            b: to :person ["jane" "Doe" 33]

            print a
            ; NAME: John, SURNAME: Doe, AGE: 35
            print b
            ; NAME: Jane, SURNAME: Doe, AGE: 33

            sayHello a
            ; Hello John 

            a > b 
            ; => true (a\age > b\age)

            print join.with:"\n" sort @[a b]
            ; NAME: Jane, SURNAME: Doe, AGE: 33
            ; NAME: John, SURNAME: Doe, AGE: 35

            print join.with:"\n" sort.descending @[a b]
            ; NAME: John, SURNAME: Doe, AGE: 35
            ; NAME: Jane, SURNAME: Doe, AGE: 33
        """:
            #=======================================================
            x.ts.fields = y.a

            if checkAttr("as"):
                x.ts.inherits = aAs.ts

            x.ts.methods = newDictionary(execDictionary(z)).d
            if (let initMethod = x.ts.methods.getOrDefault("init", nil); not initMethod.isNil):
                x.ts.methods["init"] = newFunction(
                    @["this"],
                    initMethod
                )
                x.ts.doInit = proc (v:Value) =
                    push v
                    callFunction(x.ts.methods["init"])

            if (let printMethod = x.ts.methods.getOrDefault("print", nil); not printMethod.isNil):
                x.ts.methods["print"] = newFunction(
                    @["this"],
                    printMethod
                )
                x.ts.doPrint = proc(v:Value):string =
                    push v
                    callFunction(x.ts.methods["print"])
                    stack.pop().s

            if (let compareMethod = x.ts.methods.getOrDefault("compare", nil); not compareMethod.isNil):
                if compareMethod.kind==Block:
                    x.ts.methods["compare"] = newFunction(
                        @["this","that"],
                        compareMethod
                    )
                else:
                    let key = compareMethod
                    x.ts.methods["compare"] = newFunction(
                        @["this","that"],
                        newBlock(@[
                            newWord("if"), newPath(@[newWord("this"), key]), newSymbol(greaterthan), newPath(@[newWord("that"), key]), newBlock(@[newWord("return"),newInteger(1)]),
                            newWord("if"), newPath(@[newWord("this"), key]), newSymbol(equal), newPath(@[newWord("that"), key]), newBlock(@[newWord("return"),newInteger(0)]),
                            newWord("return"), newWord("neg"), newInteger(1)
                        ])
                    )
                x.ts.doCompare = proc(v1,v2:Value):int =
                    push v2
                    push v1
                    callFunction(x.ts.methods["compare"])
                    stack.pop().i

    builtin "dictionary",
        alias       = sharp, 
        op          = opDict,
        rule        = PrefixPrecedence,
        description = "create dictionary from given block or file, by getting all internal symbols",
        args        = {
            "source": {String,Block}
        },
        attrs       = {
            "with"  : ({Block},"embed given symbols"),
            "raw"   : ({Logical},"create dictionary from raw block"),
            "lower" : ({Logical},"automatically convert all keys to lowercase")
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
            ; d: [name: "John", age: 34]
            ..........
            e: #.lower [
                Name: "John"
                suRnaMe: "Doe"
                AGE: 35
            ]
            ; e: [name:John, surname:Doe, age:35]
        """:
            #=======================================================
            var dict: ValueDict

            if xKind==Block:
                if (hadAttr("raw")):
                    dict = initOrderedTable[string,Value]()
                    var idx = 0
                    while idx < x.a.len:
                        dict[x.a[idx].s] = x.a[idx+1]
                        idx += 2
                else:
                    dict = execDictionary(x)
            elif xKind==String:
                let (src, tp) = getSource(x.s)

                if tp!=TextData:
                    dict = execDictionary(doParse(src, isFile=false))#, isIsolated=true)
                else:
                    echo "file does not exist"

            if checkAttr("with"):
                for x in aWith.a:
                    dict[x.s] = FetchSym(x.s)

            if (hadAttr("lower")):
                var oldDict = dict
                dict = initOrderedTable[string,Value]()
                for k,v in pairs(oldDict):
                    dict[k.toLower()] = v
                    
            push(newDictionary(dict))

    # TODO(Converters\from) Do we really need this?
    #  We can definitely support hex/binary literals, but how would we support string to number conversion? Perhaps, with `.to` and option?
    #  It's basically rather confusing...
    #  labels: library, cleanup, enhancement, open discussion

    # TODO(Converters/from) revise use of `.opcode`
    #  labels: library, enhancement, open discussion
    builtin "from",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get value from string, using given representation",
        args        = {
            "value" : {String,Literal}
        },
        attrs       = {
            "binary"    : ({Logical},"get integer from binary representation"),
            "hex"       : ({Logical},"get integer from hexadecimal representation"),
            "octal"     : ({Logical},"get integer from octal representation"),
            "opcode"    : ({Logical},"get opcode by from opcode literal")
        },
        returns     = {Any},
        example     = """
            print from.binary "1011"        ; 11
            print from.octal "1011"         ; 521
            print from.hex "0xDEADBEEF"     ; 3735928559
            ..........
            from.opcode 'push1
            => 33
        """:
            #=======================================================
            if (hadAttr("binary")):
                try:
                    push(newInteger(parseBinInt(x.s)))
                except ValueError:
                    push(VNULL)
            elif (hadAttr("hex")):
                try:
                    push(newInteger(parseHexInt(x.s)))
                except ValueError:
                    push(VNULL)
            elif (hadAttr("octal")):
                try:
                    push(newInteger(parseOctInt(x.s)))
                except ValueError:
                    push(VNULL)
            elif (hadAttr("opcode")):
                push(newInteger(int(parseOpcode(x.s))))
            else:
                push(x)

    builtin "function",
        alias       = dollar, 
        op          = opFunc,
        rule        = PrefixPrecedence,
        description = "create function with given arguments and body",
        args        = {
            "arguments" : {Literal, Block},
            "body"      : {Block}
        },
        attrs       = {
            "import"    : ({Block},"import/embed given list of symbols from current environment"),
            "export"    : ({Block},"export given symbols to parent"),
            "memoize"   : ({Logical},"store results of function calls"),
            "inline"    : ({Logical},"execute function without scope")
        },
        returns     = {Function},
        example     = """
            f: function [x][ x + 2 ]
            print f 10                ; 12
            
            f: $[x][x+2]
            print f 10                ; 12
            ..........
            multiply: function [x,y][
                x * y
            ]
            print multiply 3 5        ; 15
            ..........
            ; forcing typed parameters
            addThem: function [
                x :integer
                y :integer :floating
            ][
                x + y
            ]
            ..........
            ; adding complete documentation for user function
            ; using data comments within the body
            addThem: function [
                x :integer :floating
                y :integer :floating
            ][
                ;; description: « takes two numbers and adds them up
                ;; options: [
                ;;      mul: :integer « also multiply by given number
                ;; ]
                ;; returns: :integer :floating
                ;; example: {
                ;;      addThem 10 20
                ;;      addThem.mult:3 10 20
                ;; }

                mult?: attr 'mult
                if? not? null? mult? ->
                    return mult? * x + y
                else ->
                    return x + y
            ]

            info'addThem
            
            ; |--------------------------------------------------------------------------------
            ; |        addThem  :function                                          0x10EF0E528
            ; |--------------------------------------------------------------------------------
            ; |                 takes two numbers and adds them up
            ; |--------------------------------------------------------------------------------
            ; |          usage  addThem x :integer :floating
            ; |                         y :integer :floating
            ; |
            ; |        options  .mult :integer -> also multiply by given number
            ; |
            ; |        returns  :integer :floating
            ; |--------------------------------------------------------------------------------
            ..........
            publicF: function .export:['x] [z][
                print ["z =>" z]
                x: 5
            ]
            
            publicF 10
            ; z => 10
            
            print x
            ; 5
            ..........
            ; memoization
            fib: $[x].memoize[
                if? x<2 [1]
                else [(fib x-1) + (fib x-2)]
            ]

            loop 1..25 [x][
                print ["Fibonacci of" x "=" fib x]
            ]
        """:
            #=======================================================
            var imports: Value = nil
            if checkAttr("import"):
                var ret = initOrderedTable[string,Value]()
                for item in aImport.a:
                    ret[item.s] = FetchSym(item.s)
                imports = newDictionary(ret)

            var exports: Value = nil

            if checkAttr("export"):
                exports = aExport
                
            var memoize = (hadAttr("memoize"))
            var inline = (hadAttr("inline"))

            let argBlock {.cursor.} =
                if xKind == Block: x.a
                else: @[x]

            # TODO(Converters\function) Verify safety of implicit `.inline`s
            #  labels: library, benchmark, open discussion
            if not inline:
                if canBeInlined(y):
                    inline = true

            var ret: Value
            var argTypes = initOrderedTable[string,ValueSpec]()

            if argBlock.countIt(it.kind == Type) > 0:
                var args: seq[string]
                var body: ValueArray
                
                var i = 0
                while i < argBlock.len:
                    let varName = argBlock[i]
                    args.add(argBlock[i].s)
                    argTypes[argBlock[i].s] = {}
                    if i+1 < argBlock.len and argBlock[i+1].kind == Type:
                        var typeArr: ValueArray

                        while i+1 < argBlock.len and argBlock[i+1].kind == Type:
                            typeArr.add(newWord("is?"))
                            typeArr.add(argBlock[i+1])
                            argTypes[varName.s].incl(argBlock[i+1].t)
                            typeArr.add(varName)
                            i += 1

                        body.add(newWord("ensure"))
                        if typeArr.len == 3:
                            body.add(newBlock(typeArr))
                        else:
                            body.add(newBlock(@[
                                newWord("any?"),
                                newWord("array"),
                                newBlock(typeArr)
                            ]))
                    else:
                        argTypes[varName.s].incl(Any)
                    i += 1
                
                var mainBody: ValueArray = y.a
                mainBody.insert(body)

                ret = newFunction(args,newBlock(mainBody),imports,exports,memoize,inline)
            else:
                if argBlock.len > 0:
                    for arg in argBlock:
                        argTypes[arg.s] = {Any}
                else:
                    argTypes[""] = {Nothing}
                ret = newFunction(argBlock.map((w)=>w.s),y,imports,exports,memoize,inline)

            ret.info = ValueInfo(kind: Function)
            
            if not y.data.isNil:
                if y.data.kind==Dictionary:

                    if (let descriptionData = y.data.d.getOrDefault("description", nil); not descriptionData.isNil):
                        ret.info.descr = descriptionData.s
                        ret.info.module = ""

                    if y.data.d.hasKey("options") and y.data.d["options"].kind==Dictionary:
                        var options = initOrderedTable[string,(ValueSpec,string)]()
                        for (k,v) in pairs(y.data.d["options"].d):
                            if v.kind==Type:
                                options[k] = ({v.t}, "")
                            elif v.kind==String:
                                options[k] = ({Logical}, v.s)
                            elif v.kind==Block:
                                var vspec: ValueSpec
                                var i = 0
                                while i < v.a.len and v.a[i].kind==Type:
                                    vspec.incl(v.a[i].t)
                                    i += 1
                                if v.a[i].kind==String:
                                    options[k] = (vspec, v.a[i].s)
                                else:
                                    options[k] = (vspec, "")

                        ret.info.attrs = options

                    if (let returnsData = y.data.d.getOrDefault("returns", nil); not returnsData.isNil):
                        if returnsData.kind==Type:
                            ret.info.returns = {returnsData.t}
                        else:
                            var returns: ValueSpec
                            for tp in returnsData.a:
                                returns.incl(tp.t)
                            ret.info.returns = returns

                    when defined(DOCGEN):
                        if (let exampleData = y.data.d.getOrDefault("example", nil); not exampleData.isNil):
                            ret.info.example = exampleData.s
    
            ret.info.args = argTypes
            
            push(ret)

    builtin "in",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "convert quantity to given unit",
        args        = {
            "unit"  : {Literal,String,Word},
            "value" : {Integer,Floating,Quantity},
        },
        attrs       = NoAttrs,
        returns     = {Quantity},
        example     = """
            print in'cm 3:m
            ; 300.0cm

            print in'm2 1:yd2
            ; 0.836127m²
        """:
            #=======================================================
            let qs = parseQuantitySpec(x.s)
            if yKind==Quantity:
                push newQuantity(convertQuantityValue(y.nm, y.unit.name, qs.name), qs)
            else:
                push newQuantity(y, qs)
                
    builtin "range",
        alias       = ellipsis, 
        op          = opRange,
        rule        = InfixPrecedence,
        description = "get list of values in given range (inclusive)",
        args        = {
            "from"  : {Integer, Char},
            "to"    : {Integer, Floating, Char}
        },
        attrs       = {
            "step"  : ({Integer},"use step between range values")
        },
        returns     = {Range},
        example     = """
        """:
            #=======================================================
            var limX: int
            var limY: int
            var numeric = true
            var infinite = false

            if xKind == Integer: limX = x.i
            else:
                numeric = false
                limX = ord(x.c)

            var forward: bool

            if yKind == Integer: limY = y.i
            elif yKind == Floating:
                if y.f == Inf or y.f == NegInf: 
                    infinite = true
                    if y.f == Inf: forward = true
                    else: forward = false
                else:
                    limY = int(y.f)
            else:
                limY = ord(y.c)

            var step = 1
            if checkAttr("step"):
                step = aStep.i
                if step < 0:
                    step = -step
                elif step == 0:
                    step = 1
                    # preferrably show error message?

            if not infinite:
                forward = limX < limY

            push newRange(limX, limY, step, infinite, numeric, forward)

    when not defined(WEB):
        builtin "store",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "create or load a persistent store on disk",
            args        = {
                "path"  : {Literal,String}
            },
            attrs       = {
                "deferred"  : ({Logical},"save to disk only on program termination"),
                "global"    : ({Logical},"save as global store"),
                "native"    : ({Logical},"force native/Arturo format"),
                "json"      : ({Logical},"force Json format"),
                "db"        : ({Logical},"force database/SQlite format")
            },
            returns     = {Range},
            example     = """
            ; create a new store with the name `mystore`
            ; it will be automatically live-stored in a file in the same folder
            ; using the native Arturo format
            data: store "mystore"

            ; store some data
            data\name: "John"
            data\surname: "Doe"
            data\age: 36

            ; and let's retrieve our data
            data
            ; => [name:"John" surname:"Doe" age:36]
            ..........
            ; create a new "global" configuration store
            ; that will be saved automatically in ~/.arturo/stores
            globalStore: store.global "configuration"

            ; we are now ready to add or retrieve some persistent data!
            ..........
            ; create a new JSON store with the name `mystore`
            ; it will be automatically live-stored in a file in the same folder
            ; with the name `mystore.json`
            data: store.json "mystore"

            ; store some data
            da\people: []

            ; data can be as complicated as in any normal dictionary
            da\people: da\people ++ #[name: "John" surname: "Doe"]

            ; check some specific store value 
            da\people\0\name
            ; => "John" 
            ..........
            ; create a new deferred store with the name `mystore`
            ; it will be automatically saved in a file in the same folder
            ; using the native Arturo format
            defStore: store.deferred "mystore"

            ; let's save some data
            defStore\name: "John"
            defStore\surname: "Doe"

            ; and print it
            print defStore
            ; [name:John surname:Doe]

            ; in this case, all data is available at any given moment
            ; but will not be saved to disk for each and every operation;
            ; instead, it will be saved in its totality just before
            ; the program terminates!
            """:
                #=======================================================
                let isGlobal = hadAttr("global")
                let isAutosave = not hadAttr("deferred")

                var storeKind = UndefinedStore

                let isNative = hadAttr("native")
                let isJson = hadAttr("json")
                let isSqlite = hadAttr("db")

                if isNative:
                    storeKind = NativeStore
                elif isJson:
                    storeKind = JsonStore
                elif isSqlite:
                    storeKind = SqliteStore

                let store = initStore(
                    x.s,
                    doLoad = true,
                    forceExtension = true,
                    global = isGlobal,
                    autosave = isAutosave,
                    kind = storeKind
                )
                
                push newStore(store)

    builtin "to",
        alias       = unaliased, 
        op          = opTo,
        rule        = PrefixPrecedence,
        description = "convert value to given type",
        args        = {
            "type"  : {Type,Block},
            "value" : {Any}
        },
        attrs       = {
            "format"    : ({String},"use given format (for dates or floating-point numbers)"),
            "unit"      : ({String,Literal},"use given unit (for quantities)"),
            "intrepid"  : ({Logical},"convert to bytecode without error-line tracking"),
            "hsl"       : ({Logical},"convert HSL block to color"),
            "hsv"       : ({Logical},"convert HSV block to color")
        },
        returns     = {Any},
        example     = """
            to :integer "2020"            ; 2020
            
            to :integer `A`               ; 65
            to :char 65                   ; `A`
            
            to :integer 4.3               ; 4
            to :floating 4                ; 4.0

            to :complex [1 2]             ; 1.0+2.0i
            
            ; make sure you're using the `array` (`@`) converter here, since `neg` must be evaluated first
            to :complex @[2.3 neg 4.5]    ; 2.3-4.5i
            
            to :rational [1 2]            ; 1/2
            to :rational @[neg 3 5]       ; -3/5
            
            to :boolean 0                 ; false
            to :boolean 1                 ; true
            to :boolean "true"            ; true

            to :literal "symbol"          ; 'symbol
            ..........
            to :string 2020               ; "2020"
            to :string 'symbol            ; "symbol"
            to :string :word              ; "word"
        
            to :string .format:"dd/MM/yy" now
            ; 22/03/21

            to :string .format:".2f" 123.12345
            ; 123.12
            ..........
            to :block "one two three"       ; [one two three]

            do to :block "print 123"        ; 123
            ..........
            to :date 0          ; => 1970-01-01T01:00:00+01:00

            print now           ; 2021-05-22T07:39:10+02:00
            to :integer now     ; => 1621661950

            to :date .format:"dd/MM/yyyy" "22/03/2021"
            ; 2021-03-22T00:00:00+01:00
            ..........
            to [:string] [1 2 3 4]         
            ; ["1" "2" "3" "4"]

            to [:char] "hello"
            ; [`h` `e` `l` `l` `o`]
            ..........
            define :person [name surname age][]

            to :person ["John" "Doe" 35]
            ; [name:John surname:Doe age:35]
            ..........
            to :color [255 0 10]
            ; => #FF000A

            to :color .hsl [255 0.2 0.4]
            ; => #5C527A
        """:
            #=======================================================
            if xKind==Type:
                let tp = x.t
                push convertedValueToType(x, y, tp, popAttr("format"))
            else:
                var ret: ValueArray
                let tp = x.a[0].t
                    
                if yKind==String:
                    ret = toSeq(runes(y.s)).map((c) => newChar(c))
                else:
                    let aFormat = popAttr("format")
                    if yKind == Block:
                        for item in y.a:
                            ret.add(convertedValueToType(x.a[0], item, tp, aFormat))
                    else:
                        for item in items(y.rng):
                            ret.add(convertedValueToType(x.a[0], item, tp, aFormat))

                push newBlock(ret)
        

    builtin "with",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "create closure-style block by embedding given words",
        args        = {
            "embed" : {Literal, Block},
            "body"  : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Block},
        example     = """
            f: function [x][ 
                with [x][ 
                    "the multiple of" x "is" 2*x 
                ] 
            ]

            multiplier: f 10

            print multiplier
            ; the multiple of 10 is 20 
        """:
            #=======================================================
            var blk: ValueArray = y.a
            if xKind == Literal:
                blk.insert(FetchSym(x.s))
                blk.insert(newLabel(x.s))
            else:
                for item in x.a:
                    blk.insert(FetchSym(item.s))
                    blk.insert(newLabel(item.s))

            push(newBlock(blk))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)
