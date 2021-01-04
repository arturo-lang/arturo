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

import translator/parse
import vm/stack, vm/value

#=======================================
# Methods
#=======================================

template Break*():untyped = 
    require(opBreak)

    vmBreak = true
    return syms

template Call*():untyped =
    # EXAMPLE:
    # multiply: function [x y][
    # ____x * y
    # ]
    #
    # call 'multiply [3 5]          ; => 15
    #
    # call $[x][x+2] [5]            ; 7

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
    # EXAMPLE:
    # a: 2
    # case [a]
    # ____when? [<2] -> print "a is less than 2"
    # ____when? [=2] -> print "a is 2"
    # ____else       -> print "a is greater than 2"

    require(opCase)

    stack.push(x)
    stack.push(newBoolean(false))

template Clear*():untyped = 
    # EXAMPLE:
    # clear             ; (clears the screen)
    require(opClear)

    when not defined(windows):
        clearScreen()

template Continue*():untyped = 
    require(opContinue)
    
    vmContinue = true
    return syms

template Do*():untyped =
    # EXAMPLE:
    # do "print 123"                ; 123
    #
    # do [
    # ____x: 3
    # ____print ["x =>" x]          ; x => 3
    # ]
    #
    # do.import [
    # ____x: 3
    # ]
    # print ["x =>" x]              ; x => 3
    #
    # print do "https://raw.githubusercontent.com/arturo-lang/arturo/master/examples/projecteuler/euler1.art"
    # ; 233168

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
            let parsed = doParse(src, isFile=false)
            if not isNil(parsed):
                discard execBlock(parsed)

template Else*():untyped =
    # EXAMPLE:
    # x: 2
    # z: 3
    #
    # if? x>z [
    # ____print "x was greater than z"
    # ]
    # else [
    # ____print "nope, x was not greater than z"
    # ]

    require(opElse)

    let y = stack.pop() # pop the value of the previous operation (hopefully an 'if?' or 'when?')
    if not y.b: discard execBlock(x)

template Exit*():untyped =
    # EXAMPLE:
    # exit              ; (terminates the program)
    #
    # exit.with: 3      ; (terminates the program with code 3)

    require(opExit)

    quit()


template Globalize*():untyped =
    require(opGlobalize)

    for k,v in pairs(syms):
        withSyms[][k] = v

template If*():untyped =
    # EXAMPLE:
    # x: 2
    #
    # if x=2 -> print "yes, that's right!"
    # ; yes, that's right!

    require(opIf)
    if x.b: discard execBlock(y)

template IsIf*():untyped =
    # EXAMPLE:
    # x: 2
    #
    # result: if? x=2 -> print "yes, that's right!"
    # ; yes, that's right!
    #
    # print result
    # ; true
    #
    # z: 3
    #
    # if? x>z [
    # ____print "x was greater than z"
    # ]
    # else [
    # ____print "nope, x was not greater than z"
    # ]

    require(opIsIf)
    if x.b: discard execBlock(y)
    stack.push(x)

template Input*():untyped =
    # EXAMPLE:
    # name: input "What is your name? "
    # ; (user enters his name: Bob)
    #
    # print ["Hello" name "!"]
    # ; Hello Bob!

    require(opInput)

    stack.push(newString(readLineFromStdin(x.s)))

template IsWhen*():untyped =
    # EXAMPLE:
    # a: 2
    # case [a]
    # ____when? [<2] -> print "a is less than 2"
    # ____when? [=2] -> print "a is 2"
    # ____else       -> print "a is greater than 2"

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
    # EXAMPLE:
    # let 'x 10         ; x: 10
    # print x           ; 10

    require(opLet)

    syms[x.s] = y

template MakeArray*(): untyped = 
    # EXAMPLE:
    # none: @[]               ; none: []
    # a: @[1 2 3]             ; a: [1 2 3]
    #
    # b: 5
    # c: @[b b+1 b+2]         ; c: [5 6 7]
    #
    # d: @[
    # ____3+1
    # ____print "we are in the block"
    # ____123
    # ____print "yep"
    # ]
    # ; we are in the block
    # ; yep
    # ; => [4 123]

    require(opArray)

    let stop = SP

    if x.kind==Block:
        discard execBlock(x)
    elif x.kind==String:
        let (src, tp) = getSource(x.s)

        if tp!=TextData:
            discard execBlock(doParse(x.s, isFile=false), isIsolated=true)
        else:
            echo "file does not exist"

    let arr: ValueArray = sTopsFrom(stop)
    SP = stop

    stack.push(newBlock(arr))

template MakeDictionary*(): untyped = 
    # EXAMPLE:
    # none: #[]               ; none: []
    # a: #[
    # ____name: "John"
    # ____age: 34
    # ]             
    # ; a: [name: "John", age: 34]
    #
    # d: #[
    # ____name: "John"
    # ____print "we are in the block"
    # ____age: 34
    # ____print "yep"
    # ]
    # ; we are in the block
    # ; yep
    # ; => [name: "John", age: 34]

    require(opDictionary)

    var dict: ValueDict

    if x.kind==Block:
        #dict = execDictionary(x)
        dict = execBlock(x,dictionary=true)
    elif x.kind==String:
        let (src, tp) = getSource(x.s)

        if tp!=TextData:
            dict = execBlock(doParse(src, isFile=false), dictionary=true, isIsolated=true)
        else:
            echo "file does not exist"

    stack.push(newDictionary(dict))

template MakeFunction*(): untyped = 
    # EXAMPLE:
    # f: function [x][ x + 2 ]
    # print f 10                ; 12
    #
    # f: $[x][x+2]
    # print f 10                ; 12
    #
    # multiply: function [x,y][
    # ____x * y
    # ]
    # print multiply 3 5        ; 15
    #
    # publicF: function .export['x] [z][
    # ____print ["z =>" z]
    # ____x: 5
    # ]
    #
    # publicF 10
    # ; z => 10
    #
    # print x
    # ; 5
    #
    # pureF: function.pure [sth][
    # ____print ["sth =>" sth]
    # ____print ["is x set?" set? 'x]
    # ]
    #
    # pureF 23
    # ; sth => 23
    # ; is x set? false

    require(opFunction)

    var exports = VNULL
    if (let aExport = popAttr("export"); aExport != VNULL):
        exports = aExport

    let isPure = popAttr("pure")!=VNULL

    stack.push(newFunction(x,y,exports,isPure))

template Native*():untyped =
    require(opNative)

    discard

    # echo "Executing native: " & x.s & " with " 
    # y.a[0].dump()

    # case x.s:
    #     of "execSqlite":     execSqlite(y.a[0].s)
    #     else: echo "unrecognized native"

template New*():untyped =
    require(opNew)

    stack.push(copyValue(x))

template Panic*():untyped =
    require(opPanic)

    vmPanic = true
    vmError = x.s

    showVMErrors()

    if (let aCode = popAttr("code"); aCode != VNULL):
        quit(aCode.i)
    else:
        quit()    

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
    # EXAMPLE:
    # print "Hello world!"          ; Hello world!

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
    # EXAMPLE:
    # prints "Hello "
    # prints "world"
    # print "!"             
    #
    # ; Hello world!

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

template Return*():untyped = 
    # EXAMPLE:
    # f: function [x][ 
    # ____loop 1..x 'y [ 
    # ________if y=5 [ return y*2 ] 
    # ____] 
    # ____return x*2
    # ]
    #
    # print f 3         ; 6
    # print f 6         ; 10

    require(opReturn)
    stack.push(x)

    vmReturn = true
    return syms

template Try*():untyped =
    # EXAMPLE:
    # try [
    # ____; let's try something dangerous
    # ____print 10 / 0
    # ]
    #
    # ; we catch the exception but do nothing with it

    require(opTry)

    try:
        discard execBlock(x)
    except:
        discard

template TryE*():untyped = 
    # EXAMPLE:
    # try? [
    # ____; let's try something dangerous
    # ____print 10 / 0
    # ]
    # else [
    # ____print "something went terribly wrong..."
    # ]
    #
    # ; something went terribly wrong...

    require(opTryE)

    try:
        discard execBlock(x)
        stack.push(VTRUE)
    except:
        stack.push(VFALSE)

template Until*():untyped =
    # EXAMPLE:
    # i: 0 
    # until [
    # ____print ["i =>" i] 
    # ____i: i + 1
    # ][i = 10]
    #
    # ; i => 0 
    # ; i => 1 
    # ; i => 2 
    # ; i => 3 
    # ; i => 4 
    # ; i => 5 
    # ; i => 6 
    # ; i => 7 
    # ; i => 8 
    # ; i => 9 
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
    # EXAMPLE:
    # i: 0 
    # while [i<10][
    # ____print ["i =>" i] 
    # ____i: i + 1
    # ]
    #
    # ; i => 0 
    # ; i => 1 
    # ; i => 2 
    # ; i => 3 
    # ; i => 4 
    # ; i => 5 
    # ; i => 6 
    # ; i => 7 
    # ; i => 8 
    # ; i => 9 

    require(opWhile)

    let preevaledX = doEval(x)
    let preevaledY = doEval(y)

    discard execBlock(VNULL, usePreeval=true, evaluated=preevaledX)

    while stack.pop().b:
        discard execBlock(VNULL, usePreeval=true, evaluated=preevaledY)
        discard execBlock(VNULL, usePreeval=true, evaluated=preevaledX)
