######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Core.nim
######################################################

#=======================================
# Libraries
#=======================================

import strformat, strutils

import translator/parse
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

template Return*():untyped = 
    require(opReturn)
    stack.push(x)

    vmReturn = true
    return syms

template Do*():untyped =
    require(opDo)

    var execInParent = (popAttr("import") != VNULL)

    if x.kind==Block:
        if execInParent:
            discard execBlock(x, execInParent=true)
            showVMErrors()
        else:
            discard execBlock(x)
    else:
        if fileExists(x.s):
            if execInParent:
                discard execBlock(doParse(x.s), execInParent=true)
                showVMErrors()
            else:
                discard execBlock(doParse(x.s))
        else:
            if execInParent:
                discard execBlock(doParse(x.s, isFile=false), execInParent=true)
                showVMErrors()
            else:
                discard execBlock(doParse(x.s, isFile=false))


template If*():untyped =
    require(opIf)
    if x.b: discard execBlock(y)

template IfE*():untyped =
    require(opIfE)
    if x.b: discard execBlock(y)
    stack.push(x)

template Try*():untyped =
    require(opTry)

    try:
        discard execBlock(x)
    except:
        discard

template TryE*():untyped = 
    require(opTryE)

    try:
        discard execBlock(x)
        stack.push(VTRUE)
    except:
        stack.push(VFALSE)

template Else*():untyped =
    require(opElse)

    let y = stack.pop() # pop the value of the previous operation (hopefully an 'if?' or 'when?')
    if not y.b: discard execBlock(x)

template Case*():untyped =
    require(opCase)

    stack.push(x)
    stack.push(newBoolean(false))

template When*():untyped =
    require(opWhen)

    let z = pop()
    if not z.b:
        let top = stack.sTop()

        var newb: Value = newBlock()
        for old in top.a:
            newb.a.add(old)
        for cond in x.a:
            newb.a.add(cond)

        discard execBlock(newb)

        let res = stack.sTop()
        if res.b: 
            discard execBlock(y)
            discard pop()
            discard pop()
            push(newBoolean(true))
    else:
        push(z)

template Exit*():untyped =
    require(opExit)

    if (let aWith = popAttr("with"); aWith != VNULL):
        quit(aWith.i)
    else:
        quit()


template Print*():untyped =
    require(opPrint)

    if x.kind==Block:
        let xblock = doEval(x)
        let stop = SP
        discard doExec(xblock, depth+1, addr syms)

        var res: ValueArray = @[]
        while SP>stop:
            res.add(stack.pop())

        for r in res.reversed:
            r.print(newLine = false)
            stdout.write(" ")

        stdout.write("\n")
        stdout.flushFile()
    else:
        x.print()

template Prints*():untyped =
    require(opPrints)

    if x.kind==Block:
        let xblock = doEval(x)
        let stop = SP
        discard doExec(xblock, depth+1, addr syms)

        var res: ValueArray = @[]
        while SP>stop:
            res.add(stack.pop())

        for r in res.reversed:
            r.print(newLine = false)
            stdout.write(" ")

        stdout.flushFile()
    else:
        x.print(newLine = false)

template Input*():untyped =
    require(opInput)

    stack.push(newString(readLineFromStdin(x.s)))

template Repeat*():untyped =
    require(opRepeat)

    let preevaled = doEval(y)

    var i = 0
    while i<x.i:
        discard execBlock(VNULL, usePreeval=true, evaluated=preevaled)
        i += 1

template While*():untyped =
    require(opWhile)

    let preevaledX = doEval(x)
    let preevaledY = doEval(y)

    discard execBlock(VNULL, usePreeval=true, evaluated=preevaledX)

    while stack.pop().b:
        discard execBlock(VNULL, usePreeval=true, evaluated=preevaledY)
        discard execBlock(VNULL, usePreeval=true, evaluated=preevaledX)

template Until*():untyped =
    require(opUntil)

    let preevaledX = doEval(x)
    let preevaledY = doEval(y)

    while true:
        discard execBlock(VNULL, usePreeval=true, evaluated=preevaledX)
        discard execBlock(VNULL, usePreeval=true, evaluated=preevaledY)
        if stack.pop().b:
            break

template Globalize*():untyped =
    require(opGlobalize)

    for k,v in pairs(syms):
        withSyms[][k] = v

template Clear*():untyped = 
    require(opClear)
    clearScreen()

template Let*():untyped =
    require(opLet)

    syms[x.s] = y

template Var*():untyped =
    require(opVar)

    stack.push(syms[x.s])

template Pause*():untyped = 
    require(opPause)

    sleep(x.i)

template New*():untyped =
    require(opNew)

    stack.push(copyValue(x))

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
                    of String: stack.push newString($(y.i))
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
                        if y.s.len == 1:
                            stack.push newChar(y.s[0])
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
