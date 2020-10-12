######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Collections.nim
######################################################

import strutils, tables

import nre except toSeq

#=======================================
# Libraries
#=======================================

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
 
    var rc : proc(np: int)
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
# Constructors
#=======================================

template makeArray*(): untyped = 
    require(opArray)

    let stop = SP

    discard execBlock(x)

    let arr: ValueArray = sTopsFrom(stop)
    SP = stop

    stack.push(newBlock(arr))

template makeDict*(): untyped = 
    require(opDictionary)
    let dict = execBlock(x,dictionary=true)
    stack.push(newDictionary(dict))

template makeFunc*(): untyped = 
    require(opFunction)

    var exports = VNULL
    if (let aExport = popAttr("export"); aExport != VNULL):
        exports = aExport

    let isPure = popAttr("pure")!=VNULL

    stack.push(newFunction(x,y,exports,isPure))

#=======================================
# Methods
#=======================================

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

template First*(): untyped = 
    require(opFirst)

    if (let aN = popAttr("n"); aN != VNULL):
        if x.kind==String: stack.push(newString(x.s[0..aN.i-1]))
        else: stack.push(newBlock(x.a[0..aN.i-1]))
    else:
        if x.kind==String: stack.push(newChar(x.s[0]))
        else: stack.push(x.a[0])


template Last*(): untyped =
    require(opLast)

    if (let aN = getAttr("n"); aN != VNULL):
        if x.kind==String: stack.push(newString(x.s[x.s.len-aN.i..^1]))
        else: stack.push(newBlock(x.a[x.a.len-aN.i..^1]))
    else:
        if x.kind==String: stack.push(newChar(x.s[x.s.len-1]))
        else: stack.push(x.a[x.a.len-1])


template Loop*(): untyped =
    require(opLoop)

    var args: ValueArray

    if y.kind==Literal: args = @[y]
    else: args = y.a

    let preevaled = doEval(z)

    if x.kind==Dictionary:
        for k,v in pairs(x.d):
            stack.push(v)
            stack.push(newString(k))
            discard execBlock(VNULL, usePreeval=true, evaluated=preevaled, useArgs=true, args=args)
    else:
        var indx = 0
        while indx+args.len<=x.a.len:
            #echo "looping: " & $(indx)
            for item in x.a[indx..indx+args.len-1].reversed:
                #echo "pushing:"
                #item.dump()
                stack.push(item)

            discard execBlock(VNULL, usePreeval=true, evaluated=preevaled, useArgs=true, args=args)

            indx += args.len

            # echo "loop end: " & $(indx)
            # echo "args.len: " & $(args.len)
            # echo "x.a.len: " & $(x.a.len)
            # echo "indx+args.len: " & $(indx+args.len)

        # for item in x.a:
        #     stack.push(item)
        #     discard execBlock(VNULL, usePreeval=true, evaluated=preevaled, useArgs=true, args=args)

template For*(): untyped =
    require(opFor)
    var indx = 0
    var args = y.a
    let preevaled = doEval(z)

    while indx+args.len<x.a.len:
        for item in x.a[indx..indx+x.a.len].reversed:
            stack.push(item)

        discard execBlock(VNULL, usePreeval=true, evaluated=preevaled, useArgs=true, args=args)

        indx += args.len

template Map*(): untyped =
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

template Select*(): untyped =
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

template Filter*(): untyped =
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

template Range*(): untyped =
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


template Sample*(): untyped =
    require(opSample)

    stack.push(sample(x.a))

template Shuffle*(): untyped =
    require(opShuffle)

    if x.kind==Literal:
        syms[x.s].a.shuffle()
    else:
        stack.push(newBlock(x.a.dup(shuffle)))

template Slice*(): untyped =
    require(opSlice)

    if x.kind==String:
        stack.push(newString(x.s[y.i..z.i]))
    else:
        stack.push(newBlock(x.a[y.i..z.i]))

template Sort*(): untyped =
    require(opSort)

    if x.kind==Block: stack.push(newBlock(x.a.sorted()))
    else: syms[x.s].a.sort()

template Unique*(): untyped = 
    require(opUnique)

    if x.kind==Block: stack.push(newBlock(x.a.deduplicate()))
    else: syms[x.s].a = syms[x.s].a.deduplicate()

template Empty*(): untyped =
    require(opEmpty)

    case syms[x.s].kind:
        of String: syms[x.s].s = ""
        of Block: syms[x.s].a = @[]
        of Dictionary: syms[x.s].d = initOrderedTable[string,Value]()
        else: discard

template IsEmpty*(): untyped =
    require(opIsEmpty)    

    case x.kind:
        of String: stack.push(newBoolean(x.s==""))
        of Block: stack.push(newBoolean(x.a.len==0))
        of Dictionary: stack.push(newBoolean(x.d.len==0))
        else: discard

template In*(): untyped =
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

template IsIn*(): untyped =
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

template Index*(): untyped =
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

template HasKey*(): untyped =
    require(opHasKey)

    stack.push(newBoolean(x.d.hasKey(y.s)))

template Reverse*(): untyped =
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

template Join*(): untyped =
    require(opJoin)

    var sep = ""
    if (let aWith = popAttr("with"); aWith != VNULL):
        sep = aWith.s

    if x.kind==Literal:
        if x.kind==Block: syms[x.s] = newString(syms[x.s].a.map(proc (v:Value):string = v.s).join(sep))
    else:
        if x.kind==Block: stack.push(newString(x.a.map(proc (v:Value):string = v.s).join(sep)))


template Max*(): untyped =
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

template Keys*(): untyped =
    require(opKeys)

    let s = toSeq(x.d.keys)

    stack.push(newStringBlock(s))

template Values*(): untyped = 
    require(opValues)

    let s = toSeq(x.d.values)

    stack.push(newBlock(s))

template Take*(): untyped =
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

template Drop*(): untyped =
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

template Append*(): untyped =
    require(opAppend)

    if x.kind==Literal:
        if syms[x.s].kind==String:
            syms[x.s].s &= y.s
        else:
            if y.kind==Block:
                for item in y.a:
                    syms[x.s].a.add(item)
            else:
                syms[x.s].a.add(y)
    else:
        if x.kind==String:
            stack.push(newString(x.s & y.s))
        else:
            var ret = newBlock(x.a)

            if y.kind==Block:
                for item in y.a:
                    ret.a.add(item)
            else:
                ret.a.add(y)
                
            stack.push(ret)

template Remove*(): untyped =
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


template Split*(): untyped =
    require(opSplit)

    if x.kind==Literal:
        if syms[x.s].kind==String:
            if (popAttr("words") != VNULL):
                syms[x.s] = newStringBlock(syms[x.s].s.splitWhitespace())
            elif (popAttr("lines") != VNULL):
                syms[x.s] = newStringBlock(syms[x.s].s.splitLines())
            elif (let aBy = popAttr("by"); aBy != VNULL):
                syms[x.s] = newStringBlock(syms[x.s].s.split(aBy.s))
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
            stack.push(newStringBlock(x.s.splitWhitespace()))
        elif (popAttr("lines") != VNULL):
            stack.push(newStringBlock(x.s.splitLines()))
        elif (let aBy = popAttr("by"); aBy != VNULL):
            stack.push(newStringBlock(x.s.split(aBy.s)))
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


template Combine*(): untyped =
    require(opCombine)

    stack.push(newBlock(zip(x.a,y.a).map((z)=>newBlock(@[z[0],z[1]]))))

template Fold*(): untyped =
    require(opFold)

    var val: Value

    if (let aFirst = popAttr("first"); aFirst != VNULL):
        val = aFirst
    else:
        if x.a[0].kind == Integer:
            val = I0
        elif x.a[0].kind == String:
            val = newString("")

    let args = y.a
    let preevaled = doEval(z)

    for item in x.a:
        stack.push(item)
        stack.push(val)
        discard execBlock(VNULL, usePreeval=true, evaluated=preevaled, useArgs=true, args=args)
        val = stack.pop()

    stack.push(val)

template Permutate*(): untyped =
    require(opPermutate)

    var ret: ValueArray = @[]
 
    permutate(x.a, proc(s: ValueArray)= 
        ret.add(newBlock(s))
    )

    stack.push(newBlock(ret))