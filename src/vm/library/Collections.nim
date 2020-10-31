######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Collections.nim
######################################################

import algorithm, strutils, tables

import nre except toSeq

#=======================================
# Libraries
#=======================================

import translator/parse
import vm/stack, vm/value

#=======================================
# Helpers
#=======================================

proc removeFirst*(str: string, what: string): string =
    let rng = str.find(what)
    if rng != -1:
        result = str[0..rng-1] & str[(rng+what.len)..^1]
    else:
        result = str

proc removeFirst*(arr: ValueArray, what: Value): ValueArray =
    result = @[]
    var searching = true
    for v in arr:
        if searching and v==what:
            searching = false
        else:
            result.add(v)

proc removeAll*(arr: ValueArray, what: Value): ValueArray =
    result = @[]
    if what.kind==Block:
        for v in arr:
            if not (v in what.a):
                result.add(v)
    else:
        for v in arr:
            if v!=what:
                result.add(v)

proc removeByIndex*(arr: ValueArray, index: int): ValueArray =
    result = @[]
    for i,v in arr:
        if i!=index:
            result.add(v)

proc removeFirst*(dict: ValueDict, what: Value, key: bool): ValueDict =
    result = initOrderedTable[string,Value]()
    var searching = true
    for k,v in pairs(dict):
        if key:
            if searching and k==what.s:
                searching = false
            else:
                result[k] = v
        else:
            if searching and v==what:
                searching = false
            else:
                result[k] = v

proc removeAll*(dict: ValueDict, what: Value, key: bool): ValueDict =
    result = initOrderedTable[string,Value]()
    for k,v in pairs(dict):
        if key:
            if k!=what.s:
                result[k] = v
        else:
            if v!=what:
                result[k] = v

proc permutate*(s: ValueArray, emit: proc(emit:ValueArray) ) =
    var s = @s
    if s.len == 0: 
        emit(s)
        return
 
    var rc {.cursor} : proc(np: int)
    rc = proc(np: int) = 

        if np == 1: 
            emit(s)
            return
 
        var 
            np1 = np - 1
            pp = s.len - np1
 
        rc(np1) # recurs prior swaps
 
        for i in countDown(pp, 1):
            swap s[i], s[i-1]
            rc(np1) # recurs swap 
 
        let w = s[0]
        s[0..<pp] = s[1..pp]
        s[pp] = w
 
    rc(s.len)

#=======================================
# Methods
#=======================================

template Append*(): untyped =
    # EXAMPLE:
    # append "hell" "o"         ; => "hello"
    # append [1 2 3] 4          ; => [1 2 3 4]
    # append [1 2 3] [4 5]      ; => [1 2 3 4 5]
    #
    # print "hell" ++ "o!"      ; hello!             
    # print [1 2 3] ++ 4 ++ 5   ; [1 2 3 4 5]
    #
    # a: "hell"
    # append 'a "o"
    # print a                   ; hello
    #
    # b: [1 2 3]
    # 'b ++ 4
    # print b                   ; [1 2 3 4]

    require(opAppend)

    if x.kind==Literal:
        if syms[x.s].kind==String:
            if y.kind==String:
                syms[x.s].s &= y.s
            elif y.kind==Char:
                syms[x.s].s &= $(y.c)
        elif syms[x.s].kind==Char:
            if y.kind==String:
                syms[x.s] = newString($(syms[x.s].c) & y.s)
            elif y.kind==Char:
                syms[x.s] = newString($(syms[x.s].c) & $(y.c))
        else:
            if y.kind==Block:
                for item in y.a:
                    syms[x.s].a.add(item)
            else:
                syms[x.s].a.add(y)
    else:
        if x.kind==String:
            if y.kind==String:
                stack.push(newString(x.s & y.s))
            elif y.kind==Char:
                stack.push(newString(x.s & $(y.c)))  
        elif x.kind==Char:
            if y.kind==String:
                stack.push(newString($(x.c) & y.s))
            elif y.kind==Char:
                stack.push(newString($(x.c) & $(y.c)))          
        else:
            var ret = newBlock(x.a)

            if y.kind==Block:
                for item in y.a:
                    ret.a.add(item)
            else:
                ret.a.add(y)
                
            stack.push(ret)

template Combine*(): untyped =
    # EXAMPLE:
    # combine ["one" "two" "three"] [1 2 3]
    # ; => [[1 "one"] [2 "two"] [3 "three"]]

    require(opCombine)

    stack.push(newBlock(zip(x.a,y.a).map((z)=>newBlock(@[z[0],z[1]]))))

template Drop*(): untyped =
    # EXAMPLE:
    # str: drop "some text" 5
    # print str                     ; text
    #
    # arr: 1..10
    # drop 'arr 3                   ; arr: [4 5 6 7 8 9 10]

    require(opDrop)

    if x.kind==Literal:
        if syms[x.s].kind==String:
            syms[x.s].s = syms[x.s].s[y.i..^1]
        elif syms[x.s].kind==Block:
            syms[x.s].a = syms[x.s].a[y.i..^1]
    else:
        if x.kind==String:
            stack.push(newString(x.s[y.i..^1]))
        elif x.kind==Block:
            stack.push(newBlock(x.a[y.i..^1]))

template Empty*(): untyped =
    # EXAMPLE:
    # a: [1 2 3]
    # empty 'a              ; a: []
    #
    # str: "some text"
    # empty 'str            ; str: ""

    require(opEmpty)

    case syms[x.s].kind:
        of String: syms[x.s].s = ""
        of Block: syms[x.s].a = @[]
        of Dictionary: syms[x.s].d = initOrderedTable[string,Value]()
        else: discard

template Filter*(): untyped =
    # EXAMPLE:
    # print filter 1..10 [x][
    # ____even? x
    # ]
    # ; 1 3 5 7 9
    #
    # arr: 1..10
    # filter 'arr 'x -> even? x
    # print arr
    # ; 1 3 5 7 9

    require(opFilter)

    var args: ValueArray

    if y.kind==Literal: args = @[y]
    else: args = y.a

    let preevaled = doEval(z)

    var res: ValueArray = @[]

    if x.kind==Literal:
        for i,item in syms[x.s].a:
            stack.push(item)
            discard execBlock(VNULL, usePreeval=true, evaluated=preevaled, useArgs=true, args=args)
            if not stack.pop().b:
                res.add(item)

        syms[x.s].a = res
    else:
        for item in x.a:
            stack.push(item)
            discard execBlock(VNULL, usePreeval=true, evaluated=preevaled, useArgs=true, args=args)
            if not stack.pop().b:
                res.add(item)

        stack.push(newBlock(res))

template First*(): untyped = 
    # EXAMPLE:
    # print first "this is some text"       ; t
    # print first ["one" "two" "three"]     ; one
    #
    # print first.n:2 ["one" "two" "three"] ; one two

    require(opFirst)

    if (let aN = popAttr("n"); aN != VNULL):
        if x.kind==String: stack.push(newString(x.s[0..aN.i-1]))
        else: stack.push(newBlock(x.a[0..aN.i-1]))
    else:
        if x.kind==String: stack.push(newChar(x.s.runeAt(0)))
        else: stack.push(x.a[0])


template Flatten*(): untyped =
    # EXAMPLE:
    # arr: [[1 2 3] [4 5 6]]
    # print flatten arr
    # ; 1 2 3 4 5 6
    # 
    # arr: [[1 2 3] [4 5 6]]
    # flatten 'arr
    # ; arr: [1 2 3 4 5 6]

    require(opFlatten)

    if x.kind==Literal:
        syms[x.s] = syms[x.s].flattened()
    else:
        stack.push(x.flattened())

template Fold*(): untyped =
    # EXAMPLE:
    # fold 1..10 [x,y]-> x + y
    # ; => 55 (1+2+3+4..) 
    #
    # fold 1..10 .seed:1 [x,y][ x * y ]
    # ; => 3628800 (10!) 
    #
    # fold 1..3 [x y]-> x - y
    # ; => -6
    #
    # fold.right 1..3 [x y]-> x - y
    # ; => 2

    require(opFold)

    var args = y.a
    let preevaled = doEval(z)

    var seed = I0
    if x.kind==Literal:
        if syms[x.s].a[0].kind == String:
            seed = newString("")
    else:
        if x.a[0].kind == String:
            seed = newString("")

    if (let aSeed = popAttr("seed"); aSeed != VNULL):
        seed = aSeed

    let doRightFold = (popAttr("right")!=VNULL)

    if (x.kind==Literal and syms[x.s].a.len==0):
        discard
    elif (x.kind!=Literal and x.a.len==0):
        stack.push(x)
    else:
        if (doRightFold):
            # right fold

            if x.kind == Literal:
                var res: Value = seed
                for i in countdown(syms[x.s].a.len-1,0):
                    let a = syms[x.s].a[i]
                    let b = res

                    stack.push(b)
                    stack.push(a)

                    discard execBlock(VNULL, usePreeval=true, evaluated=preevaled, useArgs=true, args=args)

                    res = stack.pop()

                syms[x.s] = res

            else:
                var res: Value = seed
                for i in countdown(x.a.len-1,0):
                    let a = x.a[i]
                    let b = res

                    stack.push(b)
                    stack.push(a)

                    discard execBlock(VNULL, usePreeval=true, evaluated=preevaled, useArgs=true, args=args)

                    res = stack.pop()

                stack.push(res)
        else:
            # left fold

            if x.kind == Literal:
                var res: Value = seed
                for i in x.a:
                    let a = res
                    let b = i

                    stack.push(b)
                    stack.push(a)

                    discard execBlock(VNULL, usePreeval=true, evaluated=preevaled, useArgs=true, args=args)

                    res = stack.pop()

                syms[x.s] = res

            else:
                var res: Value = seed
                for i in x.a:
                    let a = res
                    let b = i

                    stack.push(b)
                    stack.push(a)

                    discard execBlock(VNULL, usePreeval=true, evaluated=preevaled, useArgs=true, args=args)

                    res = stack.pop()

                stack.push(res)

# templatee For*(): untyped =
#     require(opFor)
#     var indx = 0
#     var args = y.a
#     let preevaled = doEval(z)

#     while indx+args.len<x.a.len:
#         for item in x.a[indx..indx+x.a.len].reversed:
#             stack.push(item)

#         discard execBlock(VNULL, usePreeval=true, evaluated=preevaled, useArgs=true, args=args)

#         indx += args.len

template Get*(): untyped =
    # EXAMPLE:
    # user: #[
    # ____name: "John"
    # ____surname: "Doe"
    # ]
    #
    # print user\name               ; John
    #
    # print get user 'surname       ; Doe
    # print user \ 'username        ; Doe
    #
    # arr: ["zero" "one" "two"]
    #
    # print arr\1                   ; one
    #
    # print get arr 2               ; two
    # print arr \ 2                 ; two
    #
    # str: "Hello world!"
    #
    # print str\0                   ; H
    #
    # print get str 1               ; e
    # print str \ 1                 ; e

    require(opGet)

    case x.kind:
        of Block: stack.push(x.a[y.i])
        of Dictionary: stack.push(x.d[y.s])
        of String: stack.push(newChar(x.s.runeAtPos(y.i)))
        of Date: 
            stack.push(x.e[y.s])
        else: discard

template HasKey*(): untyped =
    # EXAMPLE:
    # user: #[
    # ____name: "John"
    # ____surname: "Doe"
    # ]
    #
    # key? user 'age            ; => false
    # if key? user 'name [
    # ____print ["Hello" user\name]
    # ]
    # ; Hello John

    require(opHasKey)

    stack.push(newBoolean(x.d.hasKey(y.s)))

template In*(): untyped =
    # EXAMPLE:
    # in [1 2 3 4] 0 "zero"
    # ; => ["zero" 1 2 3 4]
    #
    # print in "heo" 2 "ll"
    # ; hello
    #
    # dict: #[
    # ____name: John
    # ]
    #
    # in 'dict 'name "Jane"
    # ; dict: [name: "Jane"]
 
    require(opIn)

    if x.kind==Literal:
        case syms[x.s].kind:
            of String: syms[x.s].s.insert(z.s, y.i)
            of Block: syms[x.s].a.insert(z, y.i)
            of Dictionary:
                syms[x.s].d[y.s] = z
            else: discard
    else:
        case x.kind:
            of String: 
                var copied = x.s
                copied.insert(z.s, y.i)
                stack.push(newString(copied))
            of Block: 
                var copied = x.a
                copied.insert(z, y.i)
                stack.push(newBlock(copied))
            of Dictionary:
                var copied = x.d
                copied[y.s] = z
                stack.push(newDictionary(copied))
            else: discard

template Index*(): untyped =
    # EXAMPLE:
    # ind: index "hello" "e"
    # print ind                 ; 1
    #
    # print index [1 2 3] 3     ; 2
    #
    # type index "hello" "x"
    # ; :null

    require(opIndex)

    case x.kind:
        of String:
            let indx = x.s.find(y.s)
            if indx != -1: stack.push(newInteger(indx))
            else: stack.push(VNULL)
        of Block:
            let indx = x.a.find(y)
            if indx != -1: stack.push(newInteger(indx))
            else: stack.push(VNULL)
        of Dictionary:
            var found = false
            for k,v in pairs(x.d):
                if v==y:
                    stack.push(newString(k))
                    found=true
                    break

            if not found:
                stack.push(VNULL)
        else: discard

template IsAll*(): untyped =
    require(opAll)

    var args: ValueArray

    if y.kind==Literal: args = @[y]
    else: args = y.a

    let preevaled = doEval(z)
    var all = true

    for item in x.a:
        stack.push(item)
        discard execBlock(VNULL, usePreeval=true, evaluated=preevaled, useArgs=true, args=args)
        let popped = stack.pop()
        if popped.kind==Boolean and not popped.b:
            stack.push(newBoolean(false))
            all = false
            break

    if all:
        stack.push(newBoolean(true))

template IsAny*(): untyped =
    require(opAny)

    var args: ValueArray

    if y.kind==Literal: args = @[y]
    else: args = y.a

    let preevaled = doEval(z)
    var one = false

    for item in x.a:
        stack.push(item)
        discard execBlock(VNULL, usePreeval=true, evaluated=preevaled, useArgs=true, args=args)
        let popped = stack.pop()
        if popped.kind==Boolean and popped.b:
            stack.push(newBoolean(true))
            one = true
            break

    if not one:
        stack.push(newBoolean(false))

template IsEmpty*(): untyped =
    # EXAMPLE:
    # empty? ""             ; => true
    # empty? []             ; => true
    # empty? #[]            ; => true
    #
    # empty [1 "two" 3]     ; => false

    require(opIsEmpty)    

    case x.kind:
        of String: stack.push(newBoolean(x.s==""))
        of Block: stack.push(newBoolean(x.a.len==0))
        of Dictionary: stack.push(newBoolean(x.d.len==0))
        else: discard

template IsIn*(): untyped =
    # EXAMPLE:
    # arr: [1 2 3 4]
    #
    # in? arr 5             ; => false
    # in? arr 2             ; => true
    #
    # user: #[
    # ____name: "John"
    # ____surname: "Doe"
    # ]
    #
    # in? dict "John"       ; => true
    # in? dict "Paul"       ; => false
    #
    # in? keys dict "name"  ; => true
    #
    # in? "hello" "x"       ; => false

    require(opIsIn)

    case x.kind:
        of String:
            if (popAttr("regex") != VNULL):
                stack.push(newBoolean(nre.contains(x.s, re(y.s))))
            else:
                stack.push(newBoolean(y.s in x.s))
        of Block:
           stack.push(newBoolean(y in x.a))
        of Dictionary: 
            let values = toSeq(x.d.values)
            stack.push(newBoolean(y in values))
        else:
            discard

template Join*(): untyped =
    # EXAMPLE:
    # arr: ["one" "two" "three"]
    # print join arr
    # ; onetwothree
    #
    # print join.with:"," arr
    # ; one,two,three
    #
    # join 'arr
    # ; arr: "onetwothree"

    require(opJoin)

    var sep = ""
    if (let aWith = popAttr("with"); aWith != VNULL):
        sep = aWith.s

    if x.kind==Literal:
        if x.kind==Block: syms[x.s] = newString(syms[x.s].a.map(proc (v:Value):string = v.s).join(sep))
    else:
        if x.kind==Block: stack.push(newString(x.a.map(proc (v:Value):string = v.s).join(sep)))


template Keys*(): untyped =
    # EXAMPLE:
    # user: #[
    # ____name: "John"
    # ____surname: "Doe"
    # ]
    #
    # keys user
    # => ["name" "surname"]

    require(opKeys)

    let s = toSeq(x.d.keys)

    stack.push(newStringBlock(s))

template Last*(): untyped =
    # EXAMPLE:
    # print last "this is some text"       ; t
    # print last ["one" "two" "three"]     ; three
    #
    # print last.n:2 ["one" "two" "three"] ; two three

    require(opLast)

    if (let aN = getAttr("n"); aN != VNULL):
        if x.kind==String: stack.push(newString(x.s[x.s.len-aN.i..^1]))
        else: stack.push(newBlock(x.a[x.a.len-aN.i..^1]))
    else:
        if x.kind==String: 
            stack.push(newChar(toRunes(x.s)[^1]))
        else: stack.push(x.a[x.a.len-1])


template Loop*(): untyped =
    # EXAMPLE:
    # loop [1 2 3] 'x [
    # ____print x
    # ]
    # ; 1
    # ; 2
    # ; 3
    #
    # loop 1..3 [x][
    # ____print ["x =>" x]
    # ]
    # ; x => 1
    # ; x => 2
    # ; x => 3
    #
    # loop [A a B b C c] [x y][
    # ____print [x "=>" y]
    # ]
    # ; A => a
    # ; B => b
    # ; C => c
    #
    # user: #[
    # ____name: "John"
    # ____surname: "Doe"
    # ]
    #
    # loop user [k v][
    # ____print [k "=>" v]
    # ]
    # ; name => John
    # ; surname => Doe
    # 
    # loop.with:'i ["zero" "one" "two"] 'x [
    # ____print ["item at:" i "=>" x]
    # ]
    # ; 0 => zero
    # ; 1 => one
    # ; 2 => two

    require(opLoop)

    var args: ValueArray

    var withIndex = false
    let aWith = popAttr("with")

    if aWith != VNULL:
        withIndex = true

    if y.kind==Literal: args = @[y]
    else: args = y.a

    var allArgs = args

    if withIndex:
        allArgs = concat(@[aWith], args)

    let preevaled = doEval(z)

    if x.kind==Dictionary:
        for k,v in pairs(x.d):
            stack.push(v)
            stack.push(newString(k))
            discard execBlock(VNULL, usePreeval=true, evaluated=preevaled, useArgs=true, args=args)
    else:
        var indx = 0
        var run = 0
        while indx+args.len<=x.a.len:
            for item in x.a[indx..indx+args.len-1].reversed:
                stack.push(item)

            if withIndex:
                stack.push(newInteger(run))

            discard execBlock(VNULL, usePreeval=true, evaluated=preevaled, useArgs=true, args=allArgs)

            run += 1
            indx += args.len

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

template Map*(): untyped =
    # EXAMPLE:
    # print map 1..5 [x][
    # ____2*x
    # ]
    # ; 2 4 6 8 10
    #
    # arr: 1..5
    # map 'arr 'x -> 2*x
    # print arr
    # ; 2 4 6 8 10

    require(opMap)

    var args: ValueArray

    if y.kind==Literal: args = @[y]
    else: args = y.a

    let preevaled = doEval(z)

    var res: ValueArray = @[]

    if x.kind==Literal:
        for i,item in syms[x.s].a:
            stack.push(item)
            discard execBlock(VNULL, usePreeval=true, evaluated=preevaled, useArgs=true, args=args)
            syms[x.s].a[i] = stack.pop()
    else:
        for item in x.a:
            stack.push(item)
            discard execBlock(VNULL, usePreeval=true, evaluated=preevaled, useArgs=true, args=args)
            res.add(stack.pop())
        
        stack.push(newBlock(res))

template Max*(): untyped =
    # EXAMPLE:
    # print max [4 2 8 5 1 9]       ; 9

    require(opMax)

    if x.a.len==0: stack.push(VNULL)
    else:
        var maxElement = x.a[0]
        var i = 1
        while i < x.a.len:
            if (x.a[i]>maxElement):
                maxElement = x.a[i]
            inc(i)

        stack.push(maxElement)

template Min*(): untyped =
    # EXAMPLE:
    # print min [4 2 8 5 1 9]       ; 1

    require(opMin)

    if x.a.len==0: stack.push(VNULL)
    else:
        var minElement = x.a[0]
        var i = 1
        while i < x.a.len:
            if (x.a[i]<minElement):
                minElement = x.a[i]
            inc(i)
            
        stack.push(minElement)

template Permutate*(): untyped =
    # EXAMPLE:
    # permutate [A B C]
    # ; => [[A B C] [A C B] [C A B] [B A C] [B C A] [C B A]]

    require(opPermutate)

    var ret: ValueArray = @[]
 
    permutate(x.a, proc(s: ValueArray)= 
        ret.add(newBlock(s))
    )

    stack.push(newBlock(ret))
        
template Range*(): untyped =
    # EXAMPLE:
    # print range 1 4       ; 1 2 3 4
    # 1..10                 ; [1 2 3 4 5 6 7 8 9 10]

    require(opRange)

    var res = newBlock()

    var step = 1
    if (let aStep = popAttr("step"); aStep != VNULL):
        step = aStep.i

    if x.i < y.i:
        var j = x.i
        while j <= y.i:
            res.a.add(newInteger(j))
            j += step
    else:
        var j = x.i
        while j >= y.i:
            res.a.add(newInteger(j))
            j -= step

    stack.push(res)


template Remove*(): untyped =
    # EXAMPLE:
    # remove "hello" "l"        ; => "heo"
    # print "hello" -- "l"      ; heo
    #
    # str: "mystring"
    # remove 'str "str"         
    # print str                 ; mying
    #
    # print remove.once "hello" "l"
    # ; helo
    #
    # remove [1 2 3 4] 4        ; => [1 2 3]

    require(opRemove)

    if x.kind==Literal:
        if syms[x.s].kind==String:
            if (popAttr("once") != VNULL):
                syms[x.s] = newString(syms[x.s].s.removeFirst(y.s))
            else:
                syms[x.s] = newString(syms[x.s].s.replace(y.s))
        elif syms[x.s].kind==Block: 
            if (popAttr("once") != VNULL):
                syms[x.s] = newBlock(syms[x.s].a.removeFirst(y))
            elif (let aIndex = popAttr("index"); aIndex != VNULL):
                syms[x.s] = newBlock(syms[x.s].a.removeByIndex(aIndex.i))
            else:
                syms[x.s] = newBlock(syms[x.s].a.removeAll(y))
        elif syms[x.s].kind==Dictionary:
            let key = (popAttr("key") != VNULL)
            if (popAttr("once") != VNULL):
                syms[x.s] = newDictionary(syms[x.s].d.removeFirst(y, key))
            else:
                syms[x.s] = newDictionary(syms[x.s].d.removeAll(y, key))
    else:
        if x.kind==String:
            if (popAttr("once") != VNULL):
                stack.push(newString(x.s.removeFirst(y.s)))
            else:
                stack.push(newString(x.s.replace(y.s)))
        elif x.kind==Block: 
            if (popAttr("once") != VNULL):
                stack.push(newBlock(x.a.removeFirst(y)))
            elif (let aIndex = popAttr("index"); aIndex != VNULL):
                stack.push(newBlock(x.a.removeByIndex(aIndex.i)))
            else:
                stack.push(newBlock(x.a.removeAll(y)))
        elif x.kind==Dictionary:
            let key = (popAttr("key") != VNULL)
            if (popAttr("once") != VNULL):
                stack.push(newDictionary(x.d.removeFirst(y, key)))
            else:
                stack.push(newDictionary(x.d.removeAll(y, key)))


template Reverse*(): untyped =
    # EXAMPLE:
    # print reverse [1 2 3 4]           ; 4 3 2 1
    # print reverse "Hello World"       ; dlroW olleH
    #
    # str: "my string"
    # reverse 'str
    # print str                         ; gnirts ym

    proc reverse(s: var string) =
        for i in 0 .. s.high div 2:
            swap(s[i], s[s.high - i])
 
    proc reversed(s: string): string =
        result = newString(s.len)
        for i,c in s:
            result[s.high - i] = c

    require(opReverse)

    if x.kind==Literal:
        if syms[x.s].kind==String:
            syms[x.s].s.reverse()
        else:
            syms[x.s].a.reverse()
    else:
        if x.kind==Block: stack.push(newBlock(x.a.reversed))
        elif x.kind==String: stack.push(newString(x.s.reversed))

template Sample*(): untyped =
    # EXAMPLE:
    # sample [1 2 3]        ; (return a random number from 1 to 3)
    # print sample ["apple" "appricot" "banana"]
    # ; apple

    require(opSample)

    stack.push(sample(x.a))

template Select*(): untyped =
    # EXAMPLE:
    # print select 1..10 [x][
    # ____even? x
    # ]
    # ; 2 4 6 8 10
    #
    # arr: 1..10
    # select 'arr 'x -> even? x
    # print arr
    # ; 2 4 6 8 10

    require(opSelect)

    var args: ValueArray

    if y.kind==Literal: args = @[y]
    else: args = y.a

    let preevaled = doEval(z)

    var res: ValueArray = @[]

    if x.kind==Literal:
        for i,item in syms[x.s].a:
            stack.push(item)
            discard execBlock(VNULL, usePreeval=true, evaluated=preevaled, useArgs=true, args=args)
            if stack.pop().b:
                res.add(item)

        syms[x.s].a = res
    else:
        for item in x.a:
            stack.push(item)
            discard execBlock(VNULL, usePreeval=true, evaluated=preevaled, useArgs=true, args=args)
            if stack.pop().b:
                res.add(item)

        stack.push(newBlock(res))

template Set*(): untyped =
    # EXAMPLE:
    # myDict: #[ 
    # ____name: "John"
    # ____age: 34
    # ]
    #
    # set myDict 'name "Michael"        ; => [name: "Michael", age: 34]
    #
    # arr: [1 2 3 4]
    # set arr 0 "one"                   ; => ["one" 2 3 4]

    require(opSet)

    case x.kind:
        of Block: 
            x.a[y.i] = z
        of Dictionary:
            x.d[y.s] = z
        else: discard

template Shuffle*(): untyped =
    # EXAMPLE:
    # shuffle [1 2 3 4 5 6]         ; => [1 5 6 2 3 4 ]
    #
    # arr: [2 5 9]
    # shuffle 'arr
    # print arr                     ; 5 9 2

    require(opShuffle)

    if x.kind==Literal:
        syms[x.s].a.shuffle()
    else:
        stack.push(newBlock(x.a.dup(shuffle)))

template Size*(): untyped =
    # EXAMPLE:
    # str: "some text"      
    # print size str                ; 9
    #
    # print size "你好!"              ; 3
    require(opSize)

    if x.kind==String:
        stack.push(newInteger(runeLen(x.s)))
    elif x.kind==Dictionary:
        stack.push(newInteger(x.d.len))
    else:
        stack.push(newInteger(x.a.len))
        
template Slice*(): untyped =
    # EXAMPLE:
    # slice "Hello" 0 3             ; => "Hell"
    # print slice 1..10 3 4         ; 4 5

    require(opSlice)

    if x.kind==String:
        stack.push(newString(x.s.runeSubStr(y.i,z.i-y.i+1)))
    else:
        stack.push(newBlock(x.a[y.i..z.i]))

template Sort*(): untyped =
    # EXAMPLE:
    # a: [3 1 6]
    # print sort a                  ; 1 3 6
    #
    # print sort.descending a       ; 6 3 1
    #
    # b: ["one" "two" "three"]
    # sort 'b
    # print b                       ; one three two

    require(opSort)

    var sortOrdering = SortOrder.Ascending

    if (popAttr("descending")!=VNULL):
        sortOrdering = SortOrder.Descending

    if x.kind==Block: 
        if (let aAs = popAttr("as"); aAs != VNULL):
            stack.push(newBlock(x.a.unisorted(aAs.s, sensitive = popAttr("sensitive")!=VNULL, order = sortOrdering)))
        else:
            if (popAttr("sensitive")!=VNULL):
                stack.push(newBlock(x.a.unisorted("en", sensitive=true, order = sortOrdering)))
            else:
                if x.a[0].kind==String:
                    stack.push(newBlock(x.a.unisorted("en", order = sortOrdering)))
                else:
                    stack.push(newBlock(x.a.sorted(order = sortOrdering)))

                
    else: 
        if (let aAs = popAttr("as"); aAs != VNULL):
            syms[x.s].a.unisort(aAs.s, sensitive = popAttr("sensitive")!=VNULL, order = sortOrdering)
        else:
            if (popAttr("sensitive")!=VNULL):
                syms[x.s].a.unisort("en", sensitive=true, order = sortOrdering)
            else:
                if syms[x.s].a[0].kind==String:
                    syms[x.s].a.unisort("en", order = sortOrdering)
                else:
                    syms[x.s].a.sort(order = sortOrdering)

template Split*(): untyped =
    # EXAMPLE:
    # split "hello"                 ; => [`h` `e` `l` `l` `o`]
    # split.words "hello world"     ; => ["hello" "world"]
    #
    # split.every: 2 "helloworld"
    # ; => ["he" "ll" "ow" "or" "ld"]
    #
    # split.at: 4 "helloworld"
    # ; => ["hell" "oworld"]
    #
    # arr: 1..9
    # split.at:3 'arr
    # ; => [ [1 2 3 4] [5 6 7 8 9] ]

    require(opSplit)

    if x.kind==Literal:
        if syms[x.s].kind==String:
            if (popAttr("words") != VNULL):
                syms[x.s] = newStringBlock(strutils.splitWhitespace(syms[x.s].s))
            elif (popAttr("lines") != VNULL):
                syms[x.s] = newStringBlock(syms[x.s].s.splitLines())
            elif (let aBy = popAttr("by"); aBy != VNULL):
                syms[x.s] = newStringBlock(syms[x.s].s.split(aBy.s))
            elif (let aRegex = popAttr("regex"); aRegex != VNULL):
                syms[x.s] = newStringBlock(syms[x.s].s.split(re(aRegex.s)))
            elif (let aAt = popAttr("at"); aAt != VNULL):
                syms[x.s] = newStringBlock(@[syms[x.s].s[0..aAt.i-1], syms[x.s].s[aAt.i..^1]])
            elif (let aEvery = popAttr("every"); aEvery != VNULL):
                var ret: seq[string] = @[]
                var length = syms[x.s].s.len
                var i = 0

                while i<length:
                    ret.add(syms[x.s].s[i..i+aEvery.i-1])
                    i += aEvery.i

                syms[x.s] = newStringBlock(ret)
            else:
                syms[x.s] = newStringBlock(syms[x.s].s.map(proc (x:char):string = $(x)))
        else:
            if (let aAt = popAttr("at"); aAt != VNULL):
                syms[x.s] = newBlock(@[newBlock(syms[x.s].a[0..aAt.i]), newBlock(syms[x.s].a[aAt.i..^1])])
            elif (let aEvery = popAttr("every"); aEvery != VNULL):
                var ret: ValueArray = @[]
                var length = syms[x.s].a.len
                var i = 0

                while i<length:
                    ret.add(syms[x.s].a[i..i+aEvery.i-1])
                    i += aEvery.i

                syms[x.s] = newBlock(ret)
            else: discard

    elif x.kind==String:
        if (popAttr("words") != VNULL):
            stack.push(newStringBlock(strutils.splitWhitespace(x.s)))
        elif (popAttr("lines") != VNULL):
            stack.push(newStringBlock(x.s.splitLines()))
        elif (let aBy = popAttr("by"); aBy != VNULL):
            stack.push(newStringBlock(x.s.split(aBy.s)))
        elif (let aRegex = popAttr("regex"); aRegex != VNULL):
            stack.push(newStringBlock(x.s.split(re(aRegex.s))))
        elif (let aAt = popAttr("at"); aAt != VNULL):
            stack.push(newStringBlock(@[x.s[0..aAt.i-1], x.s[aAt.i..^1]]))
        elif (let aEvery = popAttr("every"); aEvery != VNULL):
            var ret: seq[string] = @[]
            var length = x.s.len
            var i = 0

            while i<length:
                ret.add(x.s[i..i+aEvery.i-1])
                i += aEvery.i

            stack.push(newStringBlock(ret))
        else:
            stack.push(newStringBlock(x.s.map(proc (x:char):string = $(x))))
    else:
        if (let aAt = popAttr("at"); aAt != VNULL):
            stack.push(newBlock(@[newBlock(x.a[0..aAt.i-1]), newBlock(x.a[aAt.i..^1])]))
        elif (let aEvery = popAttr("every"); aEvery != VNULL):
            var ret: ValueArray = @[]
            var length = x.a.len
            var i = 0

            while i<length:
                if i+aEvery.i > length:
                    ret.add(newBlock(x.a[i..^1]))
                else:
                    ret.add(newBlock(x.a[i..i+aEvery.i-1]))

                i += aEvery.i

            stack.push(newBlock(ret))
        else: stack.push(x)


template Take*(): untyped =
    # EXAMPLE:
    # str: take "some text" 5
    # print str                     ; some
    #
    # arr: 1..10
    # take 'arr 3                   ; arr: [1 2 3]

    require(opTake)

    if x.kind==Literal:
        if syms[x.s].kind==String:
            syms[x.s].s = syms[x.s].s[0..y.i-1]
        elif syms[x.s].kind==Block:
            syms[x.s].a = syms[x.s].a[0..y.i-1]
    else:
        if x.kind==String:
            stack.push(newString(x.s[0..y.i-1]))
        elif x.kind==Block:
            stack.push(newBlock(x.a[0..y.i-1]))

template Unique*(): untyped = 
    # EXAMPLE:
    # arr: [1 2 4 1 3 2]
    # print unique arr              ; 1 2 4 3
    #
    # arr: [1 2 4 1 3 2]
    # unique 'arr
    # print arr                     ; 1 2 4 3

    require(opUnique)

    if x.kind==Block: stack.push(newBlock(x.a.deduplicate()))
    else: syms[x.s].a = syms[x.s].a.deduplicate()

template Values*(): untyped = 
    # EXAMPLE:
    # user: #[
    # ____name: "John"
    # ____surname: "Doe"
    # ]
    #
    # values user
    # => ["John" "Doe"]

    require(opValues)

    let s = toSeq(x.d.values)

    stack.push(newBlock(s))
        
