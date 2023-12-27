#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: helpers/conversion.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import algorithm, parseutils, sequtils, strformat, strutils, sugar, tables, times, unicode

when not defined(NOGMP):
    import helpers/bignums

import helpers/objects

import helpers/ranges
when not defined(WEB):
    import helpers/stores

import vm/[checks, errors, eval, exec, parse, stack]

import vm/values/[value, printable]
import vm/values/custom/[vbinary, vcolor, verror, vlogical, vrange, vrational]

#=======================================
# Constants
#=======================================

let currentBuiltinName = "to"
    
#=======================================
# Helpers
#=======================================

proc parseFL(s: string): float =
    result = 0.0
    let L = parseutils.parseFloat(s, result, 0)
    if L != s.len or L == 0:
        raise newException(ValueError, "invalid float: " & s)

template throwCannotConvert(): untyped =
    RuntimeError_CannotConvert(codify(y), $(y.kind), (if x.tpKind==UserType: x.tid else: $(x.t)))

template throwConversionFailed(): untyped =
    RuntimeError_ConversionFailed(codify(y), $(y.kind), (if x.tpKind==UserType: x.tid else: $(x.t)))

#=======================================
# Methods
#=======================================

# TODO(Converters) Make sure `convertedValueToType` works fine + add tests
#  labels: library, cleanup, unit-test
proc convertedValueToType*(x, y: Value, tp: ValueKind, aFormat:Value = nil): Value =
    if unlikely(y.kind == tp):
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
                    of Rational: 
                        if y.iKind == NormalInteger:
                            return newRational(y.i)
                        else:
                            when not defined(NOGMP):
                                return newRational(y.bi)
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
                        return newQuantity(y, @[])
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
                        return newQuantity(y, @[])
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
                        if y.rat.rKind == NormalRational:
                            return newBlock(@[
                                newInteger(getNumerator(y.rat)),
                                newInteger(getDenominator(y.rat))
                            ])
                        else:
                            return newBlock(@[
                                newInteger(getNumerator(y.rat, big=true)),
                                newInteger(getDenominator(y.rat, big=true))
                            ])
                    of Quantity:
                        return newQuantity(y, @[])
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
                    of ErrorKind:
                        return newErrorKind(y.s)
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
                        requireBlockSize(y, 2)

                        let firstElem {.cursor} = y.a[0]
                        let secondElem {.cursor} = y.a[1]
                        requireValue(firstElem, {Floating, Integer})
                        requireValue(secondElem, {Floating, Integer})
                        
                        return newComplex(firstElem, secondElem)
                    of Rational:
                        requireBlockSize(y, 2)
                        
                        let firstElem {.cursor} = y.a[0]
                        let secondElem {.cursor} = y.a[1]
                        requireValue(firstElem, {Floating, Integer})
                        requireValue(secondElem, {Floating, Integer})
                        
                        return newRational(firstElem, secondElem)
                    of String:
                        return newString($(y))
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
                        # TODO(convertedValueToType) should throw in case the user type is not initialized
                        #  right now, if we do `to :person []` without first having done `define :person ...`
                        #  seems to be working. But what is that supposed to do?
                        #  labels: error handling, bug, oop, vm, values
                        if x.tpKind==UserType:
                            let stop = SP
                            execUnscoped(y)

                            let arr: ValueArray = sTopsFrom(stop)
                            SP = stop

                            return generateNewObject(getType(x.tid), arr)
                        else:
                            throwCannotConvert()

                    of Quantity:
                        requireBlockSize(y, 2)
                        
                        let firstElem {.cursor} = y.a[0]
                        let secondElem {.cursor} = y.a[1]
                        requireValue(firstElem, {Integer, Floating, Rational})
                        requireValue(secondElem, {Unit, Word, Literal, String})
                        
                        if secondElem.kind == Unit:
                            return newQuantity(firstElem, secondElem.u)
                        else:
                            return newQuantity(firstElem, secondElem.s)

                    of Color:
                        requireBlockSize(y, 3, 4)

                        if (hadAttr("hsl")):
                            requireValue(y.a[0], {Integer})
                            requireValue(y.a[1], {Floating})
                            requireValue(y.a[2], {Floating})
                            if y.a.len==3:
                                return newColor(HSLtoRGB((y.a[0].i, y.a[1].f, y.a[2].f, 1.0)))
                            elif y.a.len==4:
                                requireValue(y.a[3], {Floating})
                                return newColor(HSLtoRGB((y.a[0].i, y.a[1].f, y.a[2].f, y.a[3].f)))
                        elif (hadAttr("hsv")):
                            requireValue(y.a[0], {Integer})
                            requireValue(y.a[1], {Floating})
                            requireValue(y.a[2], {Floating})
                            if y.a.len==3:
                                return newColor(HSVtoRGB((y.a[0].i, y.a[1].f, y.a[2].f, 1.0)))
                            elif y.a.len==4:
                                requireValue(y.a[3], {Floating})
                                return newColor(HSVtoRGB((y.a[0].i, y.a[1].f, y.a[2].f, y.a[3].f)))
                        else:
                            requireValueBlock(y, {Integer})
                            if y.a.len==3:
                                return newColor((y.a[0].i, y.a[1].i, y.a[2].i, 255))
                            elif y.a.len==4:
                                return newColor((y.a[0].i, y.a[1].i, y.a[2].i, y.a[3].i))

                    of Binary:
                        var res: VBinary
                        for item in y.a:
                            requireValue(item, {Integer, Floating})
                            if item.kind==Integer:
                                res &= numberToBinary(item.i)
                            else:
                                res &= numberToBinary(item.f)

                        return newBinary(res)

                    of Bytecode:
                        var evaled = doEval(y, omitNewlines=hadAttr("intrepid"))

                        return newBytecode(evaled)

                    else:
                        throwCannotConvert()

            of Range:
                if tp == Block:
                    return newBlock(toSeq(y.rng.items))
                else:
                    throwCannotConvert()

            of Dictionary:
                case tp:
                    of String:
                        return newString($(y))
                    of Object:
                        if x.tpKind==UserType:
                            return generateNewObject(getType(x.tid), y.d)
                        else:
                            throwCannotConvert()
                    of Bytecode:
                        var evaled = Translation(constants: y.d["data"].a, instructions: y.d["code"].a.map(proc (x:Value):byte = byte(x.i)))

                        return newBytecode(evaled)
                    else:
                        throwCannotConvert()

            of Object:
                case tp:
                    of String:
                        if y.magic.fetch(ToStringM):
                            mgk(@[y])
                            return stack.pop()
                        else:
                            return newString($(y))
                    of Integer:
                        if y.magic.fetch(ToIntegerM):
                            mgk(@[y])
                            return stack.pop()
                        else:
                            throwCannotConvert()
                    of Floating:
                        if y.magic.fetch(ToFloatingM):
                            mgk(@[y])
                            return stack.pop()
                        else:
                            throwCannotConvert()
                    of Rational:
                        if y.magic.fetch(ToRationalM):
                            mgk(@[y])
                            return stack.pop()
                        else:
                            throwCannotConvert()
                    of Complex:
                        if y.magic.fetch(ToComplexM):
                            mgk(@[y])
                            return stack.pop()
                        else:
                            throwCannotConvert()
                    of Quantity:
                        if y.magic.fetch(ToQuantityM):
                            mgk(@[y])
                            return stack.pop()
                        else:
                            throwCannotConvert()
                    of Logical:
                        if y.magic.fetch(ToLogicalM):
                            mgk(@[y])
                            return stack.pop()
                        else:
                            throwCannotConvert()
                    of Block:
                        if y.magic.fetch(ToBlockM):
                            mgk(@[y])
                            return stack.pop()
                        else:
                            throwCannotConvert()
                    of Dictionary:
                        if y.magic.fetch(ToDictionaryM):
                            mgk(@[y])
                            return stack.pop()
                        else:
                            let dd = newOrderedTable[string,Value]()
                            for k,v in y.o.objectPairs:
                                dd[k] = copyValue(v)

                            return newDictionary(dd)
                    else:
                        throwCannotConvert()

            of Store:
                case tp:
                    of String:
                        return newString($(y))
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
                    of Floating:
                        return newFloating(toFloat(y.q.original))
                    of Rational:
                        return newRational(y.q.original)
                    of String:
                        return newString($(y.q))
                    of Unit:
                        return newUnit(y.q.atoms)
                    else:
                        throwCannotConvert()

            of Unit:
                if tp == String:
                    return newString($(y.u))
                else:
                    throwCannotConvert()

            of Error:
                case tp: 
                    of String:
                        return newString($(y.err.kind.label))
                    of Literal:
                        return newLiteral($(y.err.kind.label))
                    else:
                        throwCannotConvert()

            of ErrorKind:
                case tp: 
                    of String:
                        return newString($(y.errKind.label))
                    of Literal:
                        return newLiteral($(y.errKind.label))
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
               Method,
               Database,
               Socket,
               Nothing,
               Any,
               Path,
               PathLabel,
               PathLiteral,
               Binary: throwCannotConvert()