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

import ../../translator/parse
import ../stack, ../value

#=======================================
# Methods
#=======================================

template Call*():untyped =
    require(opCall)

    var fun: Value

    if x.kind==Literal or x.kind==String:
        fun = syms[x.s]
    else:
        fun = x

    for v in y.a.reversed:
        stack.push(v)

    discard execBlock(fun.main, useArgs=true, args=fun.params.a)
    
template Case*():untyped =
    require(opCase)

    stack.push(x)
    stack.push(newBoolean(false))

template Clear*():untyped = 
    require(opClear)
    clearScreen()

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
        let (src, _) = getSource(x.s)

        if execInParent:
            let parsed = doParse(src, isFile=false)

            if not isNil(parsed):
                discard execBlock(parsed, execInParent=true)
                showVMErrors()
        else:
            let parsed = doParse(src)
            if not isNil(parsed):
                discard execBlock(parsed)

template Else*():untyped =
    require(opElse)

    let y = stack.pop() # pop the value of the previous operation (hopefully an 'if?' or 'when?')
    if not y.b: discard execBlock(x)

template Exit*():untyped =
    require(opExit)

    if (let aWith = popAttr("with"); aWith != VNULL):
        quit(aWith.i)
    else:
        quit()


template Globalize*():untyped =
    require(opGlobalize)

    for k,v in pairs(syms):
        withSyms[][k] = v

template If*():untyped =
    require(opIf)
    if x.b: discard execBlock(y)

template IfE*():untyped =
    require(opIfE)
    if x.b: discard execBlock(y)
    stack.push(x)

template Input*():untyped =
    require(opInput)

    stack.push(newString(readLineFromStdin(x.s)))

template IsWhen*():untyped =
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

template Let*():untyped =
    require(opLet)

    syms[x.s] = y

template New*():untyped =
    require(opNew)

    stack.push(copyValue(x))

template Pause*():untyped = 
    require(opPause)

    sleep(x.i)

template Pop*():untyped =
    require(opPop)

    let doDiscard = (popAttr("discard") != VNULL)

    if x.i==1:
        if doDiscard: discard stack.pop()
        else: discard
    else:
        if doDiscard: 
            var i = 0
            while i<x.i:
                discard stack.pop()
                i+=1
        else:
            var res: ValueArray = @[]
            var i = 0
            while i<x.i:
                res.add stack.pop()
                i+=1
            stack.push(newBlock(res))

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

template Push*():untyped =
    discard
    # we do not need to do anything, just leave the value there
    # as it's already been pushed

template Repeat*():untyped =
    require(opRepeat)

    let preevaled = doEval(y)

    var i = 0
    while i<x.i:
        discard execBlock(VNULL, usePreeval=true, evaluated=preevaled)
        i += 1

template Return*():untyped = 
    require(opReturn)
    stack.push(x)

    vmReturn = true
    return syms

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

template Until*():untyped =
    require(opUntil)

    let preevaledX = doEval(x)
    let preevaledY = doEval(y)

    while true:
        discard execBlock(VNULL, usePreeval=true, evaluated=preevaledX)
        discard execBlock(VNULL, usePreeval=true, evaluated=preevaledY)
        if stack.pop().b:
            break

template Var*():untyped =
    require(opVar)

    stack.push(syms[x.s])

template While*():untyped =
    require(opWhile)

    let preevaledX = doEval(x)
    let preevaledY = doEval(y)

    discard execBlock(VNULL, usePreeval=true, evaluated=preevaledX)

    while stack.pop().b:
        discard execBlock(VNULL, usePreeval=true, evaluated=preevaledY)
        discard execBlock(VNULL, usePreeval=true, evaluated=preevaledX)
