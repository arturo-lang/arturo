######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Conversion.nim
######################################################

#=======================================
# Libraries
#=======================================

import vm/stack, vm/value

#=======================================
# Helpers
#=======================================

template showConversionError():untyped =
    echo "cannot convert argument of type :" & ($(y.kind)).toLowerAscii() & " to :" & ($(x.t)).toLowerAscii()

template invalidConversionError(origin: string):untyped =
    echo "cannot convert " & origin & " to :" & ($(x.t)).toLowerAscii()

#=======================================
# Methods
#=======================================

template As*():untyped =
    require(opAs)

    if (let aWith = popAttr("binary"); aWith != VNULL):
        stack.push(newString(fmt"{x.i:b}"))
    elif (let aWith = popAttr("hex"); aWith != VNULL):
        stack.push(newString(fmt"{x.i:x}"))
    elif (let aWith = popAttr("octal"); aWith != VNULL):
        stack.push(newString(fmt"{x.i:o}"))
    else:
        stack.push(x)

template To*(needsRequire:bool = true):untyped =
    when needsRequire:
        require(opTo)

    let tp = x.t
    
    if y.kind == tp:
        stack.push x
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
                    of Attr:
                        stack.push newAttr(y.s)
                    of AttrLabel:
                        stack.push newAttrLabel(y.s)
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

            of Symbol,
               Dictionary,
               Function,
               Any,
               Inline,
               Label,
               Attr,
               AttrLabel,
               Path,
               PathLabel,
               Date,
               Binary: discard