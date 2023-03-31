#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: library/Iterators.nim
#=======================================================

## The main Iterators module 
## (part of the standard library)

# TODO(Iterators) add `.rolling` option
#  this would allow us to have a rolling window of values
#  for example, if we have a list of 10 values, and we want to
#  iterate over it with a window of 3 values, we would get:
#  `[1,2,3], [2,3,4], [3,4,5], [4,5,6], [5,6,7], [6,7,8], [7,8,9], [8,9,10]`
#  labels: library, enhancement

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import algorithm, sequtils, sugar, unicode

import helpers/dictionaries
import helpers/ranges

import vm/lib
import vm/[errors, eval, exec]

import vm/values/custom/vrange

#=======================================
# Helpers
#=======================================

template iteratorLoop(justLiteral: bool, forever: bool, before: untyped, body: untyped) {.dirty.} =
    var keepGoing: bool = true
    while keepGoing:
        before

        var indx = 0
        var run = 0
        while indx+(when justLiteral: 1 else: loopStep)<=collectionLen:
            handleBranching:
                body
            do:
                run += 1
                indx += (when justLiteral: 1 else: loopStep)

        if not forever:
            keepGoing = false

template prepareRange(rng: VRange) {.dirty.} =
    let numeric = rng.numeric
    
    var step = rng.step
    if not rng.forward: step *= -1

    let collectionLen = rng.len

template prepareBlock(blk: ValueArray) {.dirty.} =
    let collectionLen = blk.len

template iterateRangeWithLiteral(
    rng: VRange,
    lit: string,
    cap: bool,
    inf: bool,
    doAction: untyped
) {.dirty.} =
    prepareRange(rng)
    prepareLeaklessOne(lit)

    when cap:
        var captured: Value

    iteratorLoop(justLiteral=true, inf):
        var jr = rng.start
    do:
        when cap:
            captured =
                if likely(numeric): Value(kind: Integer, iKind: NormalInteger, i: jr)
                else: newChar(char(jr))

            jr += step
            
            Syms[lit] = captured
        else:
            Syms[lit] = 
                if likely(numeric): Value(kind: Integer, iKind: NormalInteger, i: jr)
                else: newChar(char(jr))
            jr += step

        execUnscoped(preevaled)
        doAction

    finalizeLeaklessOne()

template iterateBlockWithLiteral(
    blk: ValueArray,
    lit: string,
    cap: bool,
    inf: bool,
    doAction: untyped
) {.dirty.} =
    prepareBlock(blk)
    prepareLeaklessOne(lit)

    when cap:
        var captured: Value

    iteratorLoop(justLiteral=true, inf):
        discard
    do:
        when cap:
            captured = blk[indx]
            
            Syms[lit] = captured
        else:
            Syms[lit] = blk[indx]

        execUnscoped(preevaled)
        doAction

    finalizeLeaklessOne()

template iterateRangeWithParams(
    rng: VRange,
    prm: seq[string],
    rll: bool,
    idx: bool,
    cap: bool,
    inf: bool,
    doAction: untyped
) {.dirty.} =
    prepareRange(rng)
    prepareLeakless(prm)

    let argsLen = 
        if idx: prm.len-1
        else: prm.len

    var loopStep = 
        if argsLen == 0: 1
        else: argsLen

    when rll:
        if loopStep > 1:
            loopStep -= 1
    
    when cap:
        var captured: ValueArray

    iteratorLoop(justLiteral=false, inf):
        var jr = rng.start
    do:
        when cap:
            captured = newSeq[Value](loopStep)
            var k = indx
            var cnt = 0
            while k < indx+loopStep:
                captured[cnt] = 
                    if likely(numeric): Value(kind: Integer, iKind: NormalInteger, i: jr)
                    else: newChar(char(jr))
                jr += step
                k += 1
                cnt += 1
            
        var ip = 0
        if idx:
            Syms[prm[ip]] = Value(kind: Integer, iKind: NormalInteger, i: run)
            inc ip

        when rll:
            if not rollingRight:
                Syms[prm[ip]] = res
                inc ip

        if argsLen > 0:
            when cap:
                for capt in captured:
                    Syms[prm[ip]] = capt
                    inc ip
            else:
                for i in indx..indx+loopStep-1:     
                    Syms[prm[ip]] =                   
                        if likely(numeric): Value(kind: Integer, iKind: NormalInteger, i: jr)
                        else: newChar(char(jr))
                    jr += step
                    inc ip

        when rll:
            if rollingRight:
                Syms[prm[ip]] = res

        execUnscoped(preevaled)
        doAction

    finalizeLeakless()

template iterateBlockWithParams(
    blk: ValueArray,
    prm: seq[string],
    rll: bool,
    idx: bool,
    cap: bool,
    inf: bool,
    doAction: untyped
) {.dirty.} =
    prepareBlock(blk)
    prepareLeakless(prm)

    let argsLen = 
        if idx: prm.len-1
        else: prm.len

    var loopStep = 
        if argsLen == 0: 1
        else: argsLen

    when rll:
        if loopStep > 1:
            loopStep -= 1

    when cap:
        var captured: ValueArray

    iteratorLoop(justLiteral=false, inf):
        discard
    do:
        when cap:
            captured = blk[indx..indx+loopStep-1]
            
        var ip = 0
        if idx:
            Syms[prm[ip]] = Value(kind: Integer, iKind: NormalInteger, i: run)
            inc ip

        when rll:
            if not rollingRight:
                Syms[prm[ip]] = res
                inc ip

        if argsLen > 0:
            when cap:
                for capt in captured:
                    Syms[prm[ip]] = capt
                    inc ip
            else:
                var j = indx
                while j < indx+loopStep:
                    Syms[prm[ip]] = blk[j]
                    inc ip
                    inc j

        when rll:
            if rollingRight:
                Syms[prm[ip]] = res

        execUnscoped(preevaled)
        doAction

    finalizeLeakless()

template fetchParamsBlock() {.dirty.} =
    var params: seq[string]
    if hasIndex: params.add(withIndex.s)
    if yKind != Null:
        for item in mitems(y.a):
            params.add(item.s)

template prepareIteration(doesAcceptLiterals=true) {.dirty.} =
    let preevaled = evalOrGet(z)
    let withIndex: Value = 
        if checkAttr("with"):
            aWith
        else: 
            nil
    let hasIndex = not withIndex.isNil
    var iterable{.cursor.} = x

    when doesAcceptLiterals:
        let inPlace = xKind==Literal
        if inPlace: 
            ensureInPlace()
            iterable = InPlaced

template fetchIterableRange() {.dirty.} =
    var rang = iterable.rng

template fetchIterableItems(doesAcceptLiterals=true, defaultReturn: untyped) {.dirty.} =
    var blo = 
        case iterable.kind:
            of Block,Inline:
                #cleanedBlockValuesCopy(iterable)
                iterable.a
            of Dictionary:
                iterable.d.flattenedDictionary()
            of Object:
                iterable.o.flattenedDictionary()
            of String:
                toSeq(runes(iterable.s)).map((w) => newChar(w))
            of Integer:
                (toSeq(1..iterable.i)).map((w) => newInteger(w))
            else: # won't ever reach here
                @[VNULL]

    if blo.len == 0: 
        when doesAcceptLiterals:
            when astToStr(defaultReturn) != "nil":
                if unlikely(inPlace): RawInPlaced = defaultReturn
                else: push(defaultReturn)
        else:
            when astToStr(defaultReturn) != "nil":
                push(defaultReturn)
        return

template iterateRange(withCap:bool, withInf:bool, withCounter:bool, rolling:bool, act: untyped) {.dirty.} =
    ## Main iteration helper for Range values
    when withCounter:
        var cntr = 0
                
    if likely(yKind==Literal):
        if likely(not hasIndex):
            iterateRangeWithLiteral(rang, y.s, cap=withCap, inf=withInf):
                act
                when withCounter:
                    cntr += 1
        else:
            let params = @[withIndex.s, y.s]
            iterateRangeWithParams(rang, params, rolling, hasIndex, cap=withCap, inf=withInf):
                act
                when withCounter:
                    cntr += 1
            when withCounter:
                res.setLen(cntr)

    else:
        fetchParamsBlock()
        iterateRangeWithParams(rang, params, rolling, hasIndex, cap=withCap, inf=withInf):
            act
            when withCounter:
                cntr += 1
        when withCounter:
            res.setLen(cntr)

template iterateBlock(withCap:bool, withInf:bool, withCounter:bool, rolling:bool, act: untyped) {.dirty.} =
    ## Main iteration helper for Block values
    when withCounter:
        var cntr = 0

    if likely(yKind==Literal):
        if likely(not hasIndex):
            iterateBlockWithLiteral(blo, y.s, cap=withCap, inf=withInf):
                act
                when withCounter:
                    cntr += 1
        else:
            let params = @[withIndex.s, y.s]
            iterateBlockWithParams(blo, params, rolling, hasIndex, cap=withCap, inf=withInf):
                act
                when withCounter:
                    cntr += 1
            when withCounter:
                res.setLen(cntr)
    else:
        fetchParamsBlock()
        iterateBlockWithParams(blo, params, rolling, hasIndex, cap=withCap, inf=withInf):
            act
            when withCounter:
                cntr += 1
        when withCounter:
            res.setLen(cntr)

template doIterate(
    itLit:bool,         # does the iterator support in-place literals?
    itCap:bool,         # do we need to actually capture iterated elements?
    itInf:bool,         # is there a possibility that the iteration may be infinite?
    itCounter:bool,     # do we need to keep track of the element counter? 
    itRolling:bool,     # is it a fold-type rolling iteration?

    itDefVal:untyped,   # default value to return if given block is empty
    itPre:untyped,      # code to execute before the iteration
    itAct:untyped,      # code to execute for each iteration
    itPost:untyped      # code to execute after the iteration
) {.dirty.} =
    ## The main iterator helper for every method 
    ## that doesn't require any special handling, 
    ## e.g. for Range and Block values
    prepareIteration(doesAcceptLiterals=itLit)

    if iterable.kind==Range:
        fetchIterableRange()

        itPre
        iterateRange(withCap=itCap, withInf=itInf, withCounter=itCounter, rolling=itRolling):
            itAct
        itPost
    else:
        fetchIterableItems(doesAcceptLiterals=itLit):
            itDefVal

        itPre
        iterateBlock(withCap=itCap, withInf=itInf, withCounter=itCounter, rolling=itRolling):
            itAct
        itPost

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    builtin "arrange",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "sort items in collection using given action, in ascending order",
        args        = {
            "collection"    : {Integer,String,Block,Range,Inline,Dictionary,Object,Literal},
            "params"        : {Literal,Block,Null},
            "condition"     : {Block,Bytecode}
        },
        attrs       = {
            "with"          : ({Literal}, "use given index"),
            "descending"    : ({Logical}, "sort in descending order")
        },
        returns     = {Block,Nothing},
        example     = """
            arrange ["the" "brown" "fox" "jumped" "over" "the" "lazy" "dog"] => size
            ; => ["the" "fox" "the" "dog" "over" "lazy" "brown" "jumped"]
            ..........
            arrange.descending 1..10 'x -> size factors.prime x
            ; => [8 4 6 9 10 2 3 5 7 1]
        """:
            #=======================================================
            var useOrder = SortOrder.Ascending

            if hadAttr("descending"):
                useOrder = SortOrder.Descending

            doIterate(itLit=true, itCap=true, itInf=false, itCounter=false, itRolling=false, newBlock()):
                var unsorted: seq[(ValueArray,Value)]
            do:
                let popped = move stack.pop()

                when captured is ValueArray:
                    unsorted.add((captured, popped))
                else:
                    unsorted.add((@[captured], popped))
            do:
                unsorted.sort(proc (a,b: (ValueArray,Value)): int =
                    cmp(a[1], b[1])
                , order=useOrder)

                if unsorted[0][0].len == 1:
                    let res = unsorted.map((w) => 
                        w[0][0]
                    )

                    if unlikely(inPlace): RawInPlaced = newBlock(res)
                    else: push(newBlock(res))

                else:
                    let res = unsorted.map((w) => 
                        newBlock(w[0])
                    )

                    if unlikely(inPlace): RawInPlaced = newBlock(res)
                    else: push(newBlock(res))

    builtin "chunk",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "chunk together consecutive items in collection that abide by given predicate",
        args        = {
            "collection"    : {Integer,String,Block,Range,Inline,Dictionary,Object,Literal},
            "params"        : {Literal,Block,Null},
            "condition"     : {Block,Bytecode}
        },
        attrs       = {
            "with"  : ({Literal},"use given index"),
            "value" : ({Logical},"also include condition values")
        },
        returns     = {Block,Nothing},
        example     = """
            chunk [1 1 2 2 3 22 3 5 5 7 9 2 5] => even?
            ; => [[1 1] [2 2] [3] [22] [3 5 5 7 9] [2] [5]]
            ..........
            chunk.value [1 1 2 2 3 22 3 5 5 7 9 2 5] 'x [ odd? x ]
            ; => [[true [1 1]] [false [2 2]] [true [3]] [false [22]] [true [3 5 5 7 9]] [false [2]] [true [5]]]
            ..........
            chunk.with:'i ["one" "two" "three" "four" "five" "six"] [] -> i < 4
            ; => [["one" "two" "three" "four"] ["five" "six"]]
            ..........
            chunk [1 7 5 4 3 6 8 2] [x y]-> even? x+y
            ; => [[1 7] [5 4 3 6] [8 2]]
        """:
            #=======================================================
            doIterate(itLit=true, itCap=true, itInf=false, itCounter=false, itRolling=false, newBlock()):
                let showValue = hadAttr("value")
                
                var res: ValueArray

                var state: Value = VNULL # important
                var currentSet: ValueArray
            do:
                let popped = move stack.pop()
                if popped != state:
                    if len(currentSet)>0:
                        if showValue: res.add(newBlock(@[state, newBlock(currentSet)]))
                        else: res.add(newBlock(currentSet))
                        currentSet.setLen(0)
                    state = popped

                currentSet.add(captured)
            do:
                if len(currentSet)>0:
                    if showValue: res.add(newBlock(@[state, newBlock(currentSet)]))
                    else: res.add(newBlock(currentSet))

                if unlikely(inPlace): RawInPlaced = newBlock(res)
                else: push(newBlock(res))

    builtin "cluster",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "group together items in collection that abide by given predicate",
        args        = {
            "collection"    : {Integer,String,Block,Range,Inline,Dictionary,Object,Literal},
            "params"        : {Literal,Block,Null},
            "condition"     : {Block,Bytecode}
        },
        attrs       = {
            "with"  : ({Literal},"use given index"),
            "value" : ({Logical},"also include condition values")
        },
        returns     = {Block,Nothing},
        example     = """
            cluster 1..10 => odd?
            ; => [[1 3 5 7 9] [2 4 6 8 10]]

            cluster 1..10 'x -> prime? x
            ; => [[1 4 6 8 9 10] [2 3 5 7]]
            ..........
            cluster 1..10 [x y] -> 10 < x+y
            ; => [[1 2 3 4] [5 6 7 8 9 10]]
            ..........
            cluster.value 1..10 'x -> prime? x
            ; => [[false [1 4 6 8 9 10]] [true [2 3 5 7]]]
            ..........
            #.raw flatten.once cluster.value 1..10 'x [
                (prime? x)? -> "prime"
                            -> "composite"
            ]
            ; => [composite:[1 4 6 8 9 10] prime:[2 3 5 7]]
            ..........
            cluster.with: 'i ["one" "two" "three" "four" "five" "six"] [] -> even? i
            ; => [["one" "three" "five"] ["two" "four" "six"]]
        """:
            #=======================================================
            doIterate(itLit=true, itCap=true, itInf=false, itCounter=false, itRolling=false, newBlock()):
                let showValue = hadAttr("value")

                var res: ValueArray
                var sets = initOrderedTable[Value,ValueArray]()
            do:
                let popped = move stack.pop()

                discard sets.hasKeyOrPut(popped, @[])
                sets[popped].add(captured)
            do:
                if showValue:
                    for k,v in sets.pairs:
                        res.add(newBlock(@[k, newBlock(v)]))
                else:
                    for v in sets.values:
                        res.add(newBlock(v))

                if unlikely(inPlace): RawInPlaced = newBlock(res)
                else: push(newBlock(res))

    builtin "collect",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "collect items from given collection condition while is true",
        args        = {
            "collection"    : {Integer,String,Block,Range,Inline,Dictionary,Object,Literal},
            "params"        : {Literal,Block,Null},
            "condition"     : {Block,Bytecode}
        },
        attrs       = {
            "with"      : ({Literal},"use given index"),
            "after"     : ({Logical},"start collecting after given condition becomes true")
        },
        returns     = {Block,Nothing},
        example     = """
            collect [1 3 5 4 6 7] => odd?
            ; => [1 3 5]

            collect [1 2 3 4 3 2 1 2 3] 'x -> x < 4
            ; => [1 2 3]
            ..........
            collect.after [4 6 3 5 2 0 1] => odd?
            ; => [3 5 2 0 1]

            collect.after 1..10 'x -> x > 4
            ; => [5 6 7 8 9 10]
        """:
            #=======================================================
            if hadAttr("after"):
                prepareIteration()

                var stoppedAt = -1
                var res: ValueArray
                
                if iterable.kind==Range:
                    fetchIterableRange()
                
                    iterateRange(withCap=false, withInf=false, withCounter=false, rolling=false):
                        stoppedAt = indx
                        if isTrue(move stack.pop()):
                            keepGoing = false
                            break

                    if stoppedAt < rang.len:
                        res = rang[stoppedAt..rang.len-1]

                    if unlikely(inPlace): RawInPlaced = newBlock(res)
                    else: push(newBlock(res))
                else:
                    fetchIterableItems(doesAcceptLiterals=true):
                        newBlock()
                    
                    iterateBlock(withCap=false, withInf=false, withCounter=false, rolling=false):
                        stoppedAt = indx
                        if isTrue(move stack.pop()):
                            keepGoing = false
                            break

                    if stoppedAt < blo.len:
                        res = blo[stoppedAt..^1]

                    if unlikely(inPlace): RawInPlaced = newBlock(res)
                    else: push(newBlock(res))

            else:
                doIterate(itLit=true, itCap=true, itInf=false, itCounter=false, itRolling=false, newBlock()):
                    var res: ValueArray
                do:
                    if isTrue(move stack.pop()):
                        res.add(captured)
                    else:
                        keepGoing = false
                        break
                do: 
                    if unlikely(inPlace): RawInPlaced = newBlock(res)
                    else: push(newBlock(res))

    builtin "enumerate",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "calculate the number of given collection's items that satisfy condition",
        args        = {
            "collection"    : {Integer,String,Block,Range,Inline,Dictionary,Object},
            "params"        : {Literal,Block,Null},
            "condition"     : {Block,Bytecode}
        },
        attrs       = {
            "with"      : ({Literal},"use given index")
        },
        returns     = {Integer},
        example     = """
            enumerate 1..10000000 => odd? 
            ; => 5000000
            ..........
            enumerate.with:'i ["one" "two" "three" "four"] 'x -> i < 3
            ; => 3
        """:
            #=======================================================
            doIterate(itLit=false, itCap=false, itInf=false, itCounter=false, itRolling=false, VFALSE):
                var cntr = 0
            do:
                if isTrue(move stack.pop()):
                    cntr += 1
            do:
                push(newInteger(cntr))

    builtin "every?",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if every item in collection satisfies given condition",
        args        = {
            "collection"    : {Integer,String,Block,Range,Inline,Dictionary,Object},
            "params"        : {Literal,Block,Null},
            "condition"     : {Block,Bytecode}
        },
        attrs       = {
            "with"      : ({Literal},"use given index")
        },
        returns     = {Logical},
        example     = """
            if every? [2 4 6 8] 'x [even? x]
                -> print "every number is an even integer"
            ; every number is an even integer
            ..........
            print every? 1..10 'x -> x < 11
            ; true
            ..........
            print every? 1..10 [x y]-> 20 > x+y
            ; true
            ..........
            print every? [2 3 5 7 11 14] 'x [prime? x]
            ; false
            ..........
            print every?.with:'i ["one" "two" "three"] 'x -> 4 > (size x)-i
            ; true
        """:
            #=======================================================
            doIterate(itLit=false, itCap=false, itInf=false, itCounter=false, itRolling=false, VFALSE):
                discard
            do:
                if isFalse(move stack.pop()):
                    push(VFALSE)
                    return
            do:
                push(VTRUE)

    builtin "filter",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get collection's items by filtering those that do not fulfil given condition",
        args        = {
            "collection"    : {Integer,String,Block,Range,Inline,Dictionary,Object,Literal},
            "params"        : {Literal,Block,Null},
            "condition"     : {Block,Bytecode}
        },
        attrs       = {
            "with"      : ({Literal},"use given index"),
            "first"     : ({Logical,Integer},"only filter first element/s"),
            "last"      : ({Logical,Integer},"only filter last element/s")
        },
        returns     = {Block,Any,Nothing},
        example     = """
            print filter 1..10 [x][
                even? x
            ]
            ; 1 3 5 7 9
            ..........
            arr: 1..10
            filter 'arr 'x -> even? x
            print arr
            ; 1 3 5 7 9
            ..........
            filter [1 1 2 3 5 8 13 21] [x y]-> odd? x+y
            ; => [1 1 13 21]
            ..........
            filter.with:'i ["zero" "one" "two" "three" "four" "five"] []-> even? i
            ; => ["one" "three" "five"]
            ..........
            filter.first 1..10 => odd?
            => [2 3 4 5 6 7 8 9 10]

            filter.first:3 1..10 => odd?
            => [2 4 6 7 8 9 10]
            ..........
            filter.last 1..10 => odd?
            => [1 2 3 4 5 6 7 8 10]

            filter.last:3 1..10 => odd?
            => [1 2 3 4 6 8 10]
        """:
            #=======================================================
            prepareIteration()

            var elemLimit = -1
            
            let onlyFirst = 
                if checkAttr("first"):
                    if isTrue(aFirst): elemLimit = 1
                    else: elemLimit = aFirst.i
                    true
                else: false

            let onlyLast = 
                if checkAttr("last"):
                    if isTrue(aLast): elemLimit = 1
                    else: elemLimit = aLast.i
                    true
                else: false
                
            var stoppedAt = -1
            var filteredItems = 0

            if iterable.kind==Range:
                fetchIterableRange()

                var res: ValueArray

                if onlyLast:
                    rang = rang.reversed(safe=true)
                
                iterateRange(withCap=true, withInf=false, withCounter=false, rolling=false):
                    let popped = move stack.pop()
                    if isFalse(popped):
                        res.add(captured)
                    else:
                        if onlyFirst or onlyLast:
                            when captured is Value:
                                filteredItems += 1
                            else:
                                filteredItems += captured.len

                            if elemLimit == filteredItems:
                                stoppedAt = indx+1
                                keepGoing = false
                                break

                if (onlyFirst or onlyLast) and stoppedAt < rang.len and stoppedAt != -1:
                    res.add(rang[stoppedAt..rang.len-1])
                
                if onlyLast:
                    res.reverse()

                if unlikely(inPlace): RawInPlaced = newBlock(res)
                else: push(newBlock(res))
            else: 
                fetchIterableItems(doesAcceptLiterals=true):
                    newBlock()

                if onlyLast:
                    blo = blo.reversed()

                var res: ValueArray

                iterateBlock(withCap=true, withInf=false, withCounter=false, rolling=false):
                    let popped = move stack.pop()
                    if isFalse(popped):
                        res.add(captured)
                    else:
                        if onlyFirst or onlyLast:
                            when captured is Value:
                                filteredItems += 1
                            else:
                                filteredItems += captured.len

                            if elemLimit == filteredItems:
                                stoppedAt = indx+1
                                keepGoing = false
                                break

                if (onlyFirst or onlyLast) and stoppedAt < blo.len and stoppedAt != -1:
                    res.add(blo[stoppedAt..^1])

                if onlyLast:
                    res.reverse()

                if unlikely(inPlace): RawInPlaced = newBlock(res)
                else: push(newBlock(res))

    builtin "fold",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "left-fold given collection returning accumulator",
        args        = {
            "collection"    : {Integer,String,Block,Range,Inline,Dictionary,Object},
            "params"        : {Block,Null},
            "action"        : {Block,Bytecode}
        },
        attrs       = {
            "with"  : ({Literal},"use given index"),
            "seed"  : ({Any},"use specific seed value"),
            "right" : ({Logical},"perform right folding")
        },
        returns     = {Block,Null,Nothing},
        example     = """
            fold 1..10 [x,y]-> x + y
            ; => 55 (1+2+3+4..)

            fold 1..10 .seed:1 [x,y][ x * y ]
            ; => 3628800 (10!)
            ..........
            fold 1..3 [x,y]-> x - y
            ; => -6

            fold.right 1..3 [x,y]-> x - y
            ; => 2
            ..........
            fold.seed:"0" to [:string] 1..5 [x,y] ->
                "(" ++ x ++ "+" ++ y ++ ")"
            ; => (((((0+1)+2)+3)+4)+5)

            fold.right.seed:"0" to [:string] 1..5 [x,y] ->
                "(" ++ x ++ "+" ++ y ++ ")"
            ; => (1+(2+(3+(4+(5+0)))))
            ..........
            fold 1..10 [x y z] [
                print [x y z]
                x + z - y
            ]
            ; 0 1 2
            ; 1 3 4
            ; 2 5 6
            ; 3 7 8
            ; 4 9 10
            ; => 5
            ..........
            fold.with:'i 1..5 [x y][
                print [i x y]
                i * x+y
            ]
            ; 0 0 1
            ; 1 0 2
            ; 2 2 3
            ; 3 10 4
            ; 4 42 5
            ; => 188
        """:
            #=======================================================
            prepareIteration()

            let rollingRight = hadAttr("right")

            if iterable.kind==Range:
                fetchIterableRange()

                var res: Value
                var seed = I0

                if rollingRight:
                    rang = rang.reversed(safe=true)

                let firstElem {.cursor.} = rang[0]

                if firstElem.kind == String:     seed = newString("")
                elif firstElem.kind == Floating: seed = newFloating(0.0)
                elif firstElem.kind == Block:    seed = newBlock()

                if checkAttr("seed"):
                    seed = aSeed

                res = seed
                
                iterateRange(withCap=false, withInf=false, withCounter=false, rolling=true):
                    res = move stack.pop()

                if unlikely(inPlace): RawInPlaced = res
                else: push(res)
            else: 
                fetchIterableItems(doesAcceptLiterals=true):
                    newBlock()

                var res: Value
                var seed = I0

                if rollingRight:
                    blo = blo.reversed()

                let firstElem {.cursor.} = blo[0]

                if firstElem.kind == String:     seed = newString("")
                elif firstElem.kind == Floating: seed = newFloating(0.0)
                elif firstElem.kind == Block:    seed = newBlock()

                if checkAttr("seed"):
                    seed = aSeed

                res = seed

                iterateBlock(withCap=false, withInf=false, withCounter=false, rolling=true):
                    res = move stack.pop()

                if unlikely(inPlace): RawInPlaced = res
                else: push(res)

    builtin "gather",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "group items in collection by block result and return as dictionary",
        args        = {
            "collection"    : {Integer,String,Block,Range,Inline,Dictionary,Object,Literal},
            "params"        : {Literal,Block,Null},
            "condition"     : {Block,Bytecode}
        },
        attrs       = {
            "with"  : ({Literal},"use given index")
        },
        returns     = {Dictionary,Nothing},
        example     = """
            print gather [1 2 3 4 5 6] 'x [
                x % 2
            ]
            ; [1:[1 3 5] 0:[2 4 6]]

            print gather ["New York" "Washington" "Minnesota" "Montana" "New Hampshire" "New Mexico"] 'x [
                size x
            ]
            ; [8:[New York] 10:[Washington New Mexico] 9:[Minnesota] 7:[Montana] 13:[New Hampshire]]
            ..........
            gather.with:'i ["one" "two" "three" "four"] 'x -> i%2
            ; [0:[one three] 1:[two four]]
        """:
            #=======================================================
            doIterate(itLit=true, itCap=true, itInf=false, itCounter=false, itRolling=false, newDictionary()):
                var res = initOrderedTable[string,Value]()
            do:
                let popped = $(move stack.pop())
                discard res.hasKeyOrPut(popped, newBlock())
                res[popped].a.add(captured)
            do:
                if unlikely(inPlace): RawInPlaced = newDictionary(res)
                else: push(newDictionary(res))

    builtin "loop",
        alias       = unaliased,
        op          = opLoop,
        rule        = PrefixPrecedence,
        description = "loop through collection, using given iterator and block",
        args        = {
            "collection"    : {Integer,String,Block,Range,Inline,Dictionary,Object},
            "params"        : {Literal,Block,Null},
            "action"        : {Block,Bytecode}
        },
        attrs       = {
            "with"      : ({Literal},"use given index"),
            "forever"   : ({Logical},"cycle through collection infinitely")
        },
        returns     = {Nothing},
        example     = """
            loop [1 2 3] 'x [
                print x
            ]
            ; 1
            ; 2
            ; 3
            ..........
            loop 1..3 [x][
                print ["x =>" x]
            ]
            ; x => 1
            ; x => 2
            ; x => 3
            ..........
            loop [A a B b C c] [x y][
                print [x "=>" y]
            ]
            ; A => a
            ; B => b
            ; C => c
            ..........
            user: #[
                name: "John"
                surname: "Doe"
            ]

            loop user [k v][
                print [k "=>" v]
            ]
            ; name => John
            ; surname => Doe
            ..........
            loop.with:'i ["zero" "one" "two"] 'x [
                print ["item at:" i "=>" x]
            ]
            ; 0 => zero
            ; 1 => one
            ; 2 => two
            ..........
            loop.forever [1 2 3] => print
            ; 1 2 3 1 2 3 1 2 3 ...
        """:
            #=======================================================
            let doForever = hadAttr("forever")
            doIterate(itLit=false, itCap=false, itInf=doForever, itCounter=false, itRolling=false, nil):
                discard
            do:
                discard
            do:
                discard

    builtin "map",
        alias       = unaliased,
        op          = opMap,
        rule        = PrefixPrecedence,
        description = "map collection's items by applying given action",
        args        = {
            "collection"    : {Integer,String,Block,Range,Inline,Dictionary,Object,Literal},
            "params"        : {Literal,Block,Null},
            "condition"     : {Block,Bytecode}
        },
        attrs       = {
            "with"      : ({Literal},"use given index")
        },
        returns     = {Block,Nothing},
        example     = """
            print map 1..5 [x][
                2*x
            ]
            ; 2 4 6 8 10
            ..........
            arr: 1..5
            map 'arr 'x -> 2*x
            print arr
            ; 2 4 6 8 10
            ..........
            map 1..6 [x y][
                print ["mapping" x "and" y "->" x+y]
                x+y
            ]
            ; mapping 1 and 2 -> 3
            ; mapping 3 and 4 -> 7
            ; mapping 5 and 6 -> 11
            ; => [3 7 11]
            ..........
            map.with:'i ["one" "two" "three" "four"] 'x [
                (even? i)? -> upper x -> x
            ]
            ; => ["ONE" "two" "THREE" "four"]
        """:
            #=======================================================
            prepareIteration()

            if iterable.kind==Range:
                fetchIterableRange()

                var res: ValueArray = newSeq[Value](rang.len)
                
                iterateRange(withCap=false, withInf=false, withCounter=true, rolling=false):
                    res[cntr] = move stack.pop()

                if unlikely(inPlace): RawInPlaced = newBlock(res)
                else: push(newBlock(res))
            else: 
                fetchIterableItems(doesAcceptLiterals=true):
                    newBlock()

                var res: ValueArray = newSeq[Value](blo.len)

                iterateBlock(withCap=false, withInf=false, withCounter=true, rolling=false):
                    res[cntr] = move stack.pop()

                if unlikely(inPlace): RawInPlaced = newBlock(res)
                else: push(newBlock(res))

    builtin "maximum",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get maximum item from collection based on given predicate",
        args        = {
            "collection"    : {Integer,String,Block,Range,Inline,Dictionary,Object,Literal},
            "params"        : {Literal,Block,Null},
            "condition"     : {Block,Bytecode}
        },
        attrs       = {
            "with"      : ({Literal},"use given index"),
            "value"     : ({Logical},"also include predicate values")
        },
        returns     = {Block,Nothing},
        example     = """
            maximum 1..10 'x -> size factors.prime x
            ; => 8
            ; 8 has the maximum number of 
            ; prime factors: 2, 2, 2 (3)
            ..........
            maximum.value 1..10 'x -> size factors.prime x
            ; => [8 3]
        """:
            #=======================================================
            let withValue = hadAttr("value")

            doIterate(itLit=true, itCap=true, itInf=false, itCounter=false, itRolling=false, VNULL):
                var selected: ValueArray
                var maxVal: Value = VNULL
            do:
                let popped = move stack.pop()
                if selected.len == 0 or popped > maxVal:
                    maxVal = popped
                    when captured is Value:
                        selected = @[move captured]
                    else:
                        selected = move captured
            do:
                if selected.len == 1:
                    if withValue:
                        if unlikely(inPlace): RawInPlaced = newBlock(@[selected[0], maxVal])
                        else: push(newBlock(@[selected[0], maxVal]))
                    else:
                        if unlikely(inPlace): RawInPlaced = selected[0]
                        else: push(selected[0])
                else:
                    if withValue:
                        if unlikely(inPlace): RawInPlaced = newBlock(@[newBlock(selected), maxVal])
                        else: push(newBlock(@[newBlock(selected), maxVal]))
                    else:
                        if unlikely(inPlace): RawInPlaced = newBlock(selected)
                        else: push(newBlock(selected))

    builtin "minimum",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get minimum item from collection based on given predicate",
        args        = {
            "collection"    : {Integer,String,Block,Range,Inline,Dictionary,Object,Literal},
            "params"        : {Literal,Block,Null},
            "condition"     : {Block,Bytecode}
        },
        attrs       = {
            "with"      : ({Literal},"use given index"),
            "value"     : ({Logical},"also include predicate values")
        },
        returns     = {Block,Nothing},
        example     = """
            minimum [4 17 20] 'x -> size factors.prime x
            ; => 17
            ; 17 has the minimum number of 
            ; prime factors: 17 (1)
            ..........
            minimum.value [4 17 20] 'x -> size factors.prime x
            ; => [17 1]
        """:
            #=======================================================
            let withValue = hadAttr("value")

            doIterate(itLit=true, itCap=true, itInf=false, itCounter=false, itRolling=false, VNULL):
                var selected: ValueArray
                var minVal: Value = VNULL
            do:
                let popped = move stack.pop()
                if selected.len == 0 or popped < minVal:
                    minVal = popped
                    when captured is Value:
                        selected = @[move captured]
                    else:
                        selected = move captured
            do:
                if selected.len == 1:
                    if withValue:
                        if unlikely(inPlace): RawInPlaced = newBlock(@[selected[0], minVal])
                        else: push(newBlock(@[selected[0], minVal]))
                    else:
                        if unlikely(inPlace): RawInPlaced = selected[0]
                        else: push(selected[0])
                else:
                    if withValue:
                        if unlikely(inPlace): RawInPlaced = newBlock(@[newBlock(selected), minVal])
                        else: push(newBlock(@[newBlock(selected), minVal]))
                    else:
                        if unlikely(inPlace): RawInPlaced = newBlock(selected)
                        else: push(newBlock(selected))

    # TODO(Iterators/select) should `.first` & `.last` just one element?
    #  Right now, they both return a block with this one element inside. 
    #  The original idea was that since `.first` can either be a switch-type of 
    #  attribute or an attributeLabel (that is: taking an argument), it would
    #  make sense to always return a block for consistency.
    # 
    #  The problem is that having to do something like `first select.first ...`
    #  seems a bit redundant.
    #
    #  P.S. This is totally *not* the case for `filter` which does something
    #  different altogether...
    #  labels: library, enhancement
    builtin "select",
        alias       = unaliased,
        op          = opSelect,
        rule        = PrefixPrecedence,
        description = "get collection's items that fulfil given condition",
        args        = {
            "collection"    : {Integer,String,Block,Range,Inline,Dictionary,Object,Literal},
            "params"        : {Literal,Block,Null},
            "condition"     : {Block,Bytecode}
        },
        attrs       = {
            "with"      : ({Literal},"use given index"),
            "first"     : ({Logical,Integer},"only return first element/s"),
            "last"      : ({Logical,Integer},"only return last element/s"),
            "n"         : ({Integer},"only return n-th element")
        },
        returns     = {Block,Any,Nothing},
        example     = """
            print select 1..10 [x][
                even? x
            ]
            ; 2 4 6 8 10
            ..........
            arr: 1..10
            select 'arr 'x -> even? x
            print arr
            ; 2 4 6 8 10
            ..........
            select [1 1 2 3 5 8 13 21] [x y]-> odd? x+y
            ; => [2 3 5 8]
            ..........
            select.with:'i ["zero" "one" "two" "three" "four" "five"] []-> even? i
            ; => ["zero" "two" "four"]
            ..........
            select.first 1..10 => odd?
            => [1]

            select.first:3 1..10 => odd?
            => [1 3 5]
            ..........
            select.last 1..10 => odd?
            => [9]

            select.last:3 1..10 => odd?
            => [5 7 9]
        """:
            #=======================================================
            prepareIteration()

            var elemLimit = -1
                
            let onlyFirst = 
                if checkAttr("first"):
                    if isTrue(aFirst): elemLimit = 1
                    else: elemLimit = aFirst.i
                    true
                else: false

            let onlyLast = 
                if checkAttr("last"):
                    if isTrue(aLast): elemLimit = 1
                    else: elemLimit = aLast.i
                    true
                else: false

            var nth = -1
            let onlyN = 
                if checkAttr("n"):
                    nth = aN.i
                    true
                else: false

            var found: int = 0

            if iterable.kind==Range:
                fetchIterableRange()

                var res: ValueArray

                if onlyLast:
                    rang = rang.reversed(safe=true)
                
                iterateRange(withCap=true, withInf=false, withCounter=false, rolling=false):
                    if isTrue(move stack.pop()):
                        if likely(not onlyN):
                            res.add(captured)

                            if onlyFirst or onlyLast:
                                if elemLimit == res.len:
                                    keepGoing = false
                                    break
                        else:
                            found += 1
                            if found == nth:
                                when captured is ValueArray:
                                    if captured.len == 1:
                                        push(captured[0])
                                    else:
                                        push(newBlock(captured))
                                else:
                                    push(captured)
                                return
                
                if onlyLast:
                    res.reverse()
                
                if unlikely(onlyN): push(VNULL)
                else:
                    if unlikely(inPlace): RawInPlaced = newBlock(res)
                    else: push(newBlock(res))
            else: 
                fetchIterableItems(doesAcceptLiterals=true):
                    newBlock()

                if onlyLast:
                    blo = blo.reversed()

                var res: ValueArray

                iterateBlock(withCap=true, withInf=false, withCounter=false, rolling=false):
                    if isTrue(move stack.pop()):
                        if likely(not onlyN):
                            res.add(captured)

                            if onlyFirst or onlyLast:
                                if elemLimit == res.len:
                                    keepGoing = false
                                    break
                        else:
                            found += 1
                            if found == nth:
                                when captured is ValueArray:
                                    if captured.len == 1:
                                        push(captured[0])
                                    else:
                                        push(newBlock(captured))
                                else:
                                    push(captured)
                                return
                
                if onlyLast:
                    res.reverse()
                
                if unlikely(onlyN): push(VNULL)
                else:
                    if unlikely(inPlace): RawInPlaced = newBlock(res)
                    else: push(newBlock(res))

    builtin "some?",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if any of collection's items satisfy given condition",
        args        = {
            "collection"    : {Integer,String,Block,Range,Inline,Dictionary,Object},
            "params"        : {Literal,Block,Null},
            "condition"     : {Block,Bytecode}
        },
        attrs       = {
            "with"      : ({Literal},"use given index")
        },
        returns     = {Logical},
        example     = """
            if some? [1 3 5 6 7] 'x [even? x]
                -> print "at least one number is an even integer"
            ; at least one number is an even integer
            ..........
            print some? 1..10 'x -> x > 9
            ; true
            ..........
            print some? [4 6 8 10] 'x [prime? x]
            ; false
            ..........
            print some? 1..10 [x y]-> 15 < x+y
            ; true
            ..........
            print some? [2 4 6 9] 'x [prime? x]
            ; true
            ..........
            print some?.with:'i ["three" "two" "one" "four" "five"] 'x -> i >= size x
            ; true
        """:
            #=======================================================
            doIterate(itLit=false, itCap=false, itInf=false, itCounter=false, itRolling=false, VFALSE):
                discard
            do:
                if isTrue(move stack.pop()):
                    push(VTRUE)
                    return
            do:
                push(VFALSE)

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)
