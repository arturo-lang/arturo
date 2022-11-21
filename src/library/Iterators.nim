#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: library/Iterators.nim
#=======================================================

## The main Iterators module 
## (part of the standard library)

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

template iteratorLoop(forever: bool, body: untyped) {.dirty.} =
    var keepGoing{.inject.}: bool = true
    while keepGoing:
        var indx{.inject.} = 0
        var run = 0
        while indx+loopStep<=collectionLen:
            handleBranching:
                body
            do:
                run += 1
                indx += loopStep

                if not forever:
                    keepGoing = false

template prepareRange(rng: VRange) {.dirty.} =
    let numeric = rng.numeric
    
    var step = rng.step
    if not rng.forward: step *= -1

    var jr = rng.start

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

    let loopStep = 1

    when cap:
        var capturedItems{.inject}: Value

    iteratorLoop(inf):
        when cap:
            capturedItems =
                if likely(numeric): Value(kind: Integer, iKind: NormalInteger, i: jr)
                else: newChar(char(jr))

            jr += step
            
            Syms[lit] = capturedItems
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

    let loopStep = 1

    when cap:
        var capturedItems{.inject}: Value

    iteratorLoop(inf):
        when cap:
            capturedItems = blk[indx]
            
            Syms[lit] = capturedItems
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
        var capturedItems{.inject}: ValueArray

    iteratorLoop(inf):
        when cap:
            if argsLen > 0:
                capturedItems = newSeq[Value](loopStep)
                var k = indx
                var cnt = 0
                while k < indx+loopStep:
                    capturedItems[cnt] = 
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
                for capt in capturedItems:
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
        var capturedItems{.inject}: ValueArray

    iteratorLoop(inf):
        when cap:
            if argsLen > 0:
                capturedItems = blk[indx..indx+loopStep-1]
            
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
                for capt in capturedItems:
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
    if y.kind != Null:
        for item in mitems(y.a):
            if item.kind != Newline:
                params.add(item.s)

template prepareIteration(doesAcceptLiterals=true) {.dirty.} =
    let preevaled = evalOrGet(z)
    let withIndex = popAttr("with")
    let hasIndex = not withIndex.isNil
    var iterable{.cursor.} = x

    when doesAcceptLiterals:
        let inPlace = x.kind==Literal
        if inPlace: 
            ensureInPlace()
            iterable = InPlaced

template fetchIterableItems(doesAcceptLiterals=true, defaultReturn: untyped) {.dirty.} =
    var blo = 
        case iterable.kind:
            of Block,Inline:
                cleanedBlockValuesCopy(iterable)
            of Dictionary:
                iterable.d.flattenedDictionary()
            of Object:
                iterable.o.flattenedDictionary()
            of String:
                toSeq(runes(iterable.s)).map((w) => newChar(w))
            of Integer:
                (toSeq(1..iterable.i)).map((w) => newInteger(w))
            else: # block or inline
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
                
    if likely(y.kind==Literal):
        if likely(not hasIndex):
            iterateRangeWithLiteral(iterable.rng, y.s, cap=withCap, inf=withInf):
                act
                when withCounter:
                    cntr += 1
        else:
            let params = @[withIndex.s, y.s]
            iterateRangeWithParams(iterable.rng, params, rolling, hasIndex, cap=withCap, inf=withInf):
                act
                when withCounter:
                    cntr += 1
            when withCounter:
                res.setLen(cntr)

    else:
        fetchParamsBlock()
        iterateRangeWithParams(iterable.rng, params, rolling, hasIndex, cap=withCap, inf=withInf):
            act
            when withCounter:
                cntr += 1
        when withCounter:
            res.setLen(cntr)

template iterateBlock(withCap:bool, withInf:bool, withCounter:bool, rolling:bool, act: untyped) {.dirty.} =
    ## Main iteration helper for Block values
    when withCounter:
        var cntr = 0

    if likely(y.kind==Literal):
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

# TODO(Iterators) Add Ruby's equivalent of `sort_by`
#  a nice name could be `arrange`
#  labels: library, enhancement

proc defineSymbols*() =

    builtin "chunk",
        alias       = unaliased,
        rule        = PrefixPrecedence,
        description = "chunk together consecutive items in collection that abide by given predicate",
        args        = {
            "collection"    : {Integer,String,Block,Range,Inline,Dictionary,Object,Literal},
            "params"        : {Literal,Block,Null},
            "condition"     : {Block,Bytecode}
        },
        attrs       = {
            "with"  : ({Literal},"use given index"),
            "value" : ({Any},"also include condition values")
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
                var currentSet: ValueArray = @[]
            do:
                let popped = move stack.pop()
                if popped != state:
                    if len(currentSet)>0:
                        if showValue: res.add(newBlock(@[state, newBlock(currentSet)]))
                        else: res.add(newBlock(currentSet))
                        currentSet = @[]
                    state = popped

                currentSet.add(capturedItems)
            do:
                if len(currentSet)>0:
                    if showValue: res.add(newBlock(@[state, newBlock(currentSet)]))
                    else: res.add(newBlock(currentSet))

                if unlikely(inPlace): RawInPlaced = newBlock(res)
                else: push(newBlock(res))

    builtin "cluster",
        alias       = unaliased,
        rule        = PrefixPrecedence,
        description = "group together items in collection that abide by given predicate",
        args        = {
            "collection"    : {Integer,String,Block,Range,Inline,Dictionary,Object,Literal},
            "params"        : {Literal,Block,Null},
            "condition"     : {Block,Bytecode}
        },
        attrs       = {
            "with"  : ({Literal},"use given index"),
            "value" : ({Any},"also include condition values")
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
                sets[popped].add(capturedItems)
            do:
                if showValue:
                    for k,v in sets.pairs:
                        res.add(newBlock(@[k, newBlock(v)]))
                else:
                    for v in sets.values:
                        res.add(newBlock(v))

                if unlikely(inPlace): RawInPlaced = newBlock(res)
                else: push(newBlock(res))

    builtin "every?",
        alias       = unaliased,
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
        returns     = {Block,Nothing},
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
                var res: ValueArray

                if onlyLast:
                    iterable = newRange(iterable.rng.reversed())
                
                iterateRange(withCap=true, withInf=false, withCounter=false, rolling=false):
                    let popped = move stack.pop()
                    if isFalse(popped):
                        res.add(capturedItems)
                    else:
                        if onlyFirst or onlyLast:
                            when capturedItems is Value:
                                filteredItems += 1
                            else:
                                filteredItems += capturedItems.len

                            if elemLimit == filteredItems:
                                stoppedAt = indx+1
                                keepGoing = false
                                break

                if (onlyFirst or onlyLast) and stoppedAt < iterable.rng.len:
                    for k in stoppedAt..iterable.rng.len-1:
                        res.add(iterable.rng[k])
                
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
                        res.add(capturedItems)
                    else:
                        if onlyFirst or onlyLast:
                            when capturedItems is Value:
                                filteredItems += 1
                            else:
                                filteredItems += capturedItems.len

                            if elemLimit == filteredItems:
                                stoppedAt = indx+1
                                keepGoing = false
                                break

                if (onlyFirst or onlyLast) and stoppedAt < blo.len:
                    res.add(blo[stoppedAt..^1])

                if onlyLast:
                    res.reverse()

                if unlikely(inPlace): RawInPlaced = newBlock(res)
                else: push(newBlock(res))

    builtin "fold",
        alias       = unaliased,
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
                var res: Value
                var seed = I0

                if rollingRight:
                    iterable = newRange(iterable.rng.reversed())

                let firstElem {.cursor.} = iterable.rng[0]

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
                res[popped].a.add(capturedItems)
            do:
                if unlikely(inPlace): RawInPlaced = newDictionary(res)
                else: push(newDictionary(res))

    builtin "loop",
        alias       = unaliased,
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
                var res: ValueArray = newSeq[Value](iterable.rng.len)
                
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

    builtin "select",
        alias       = unaliased,
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
            "last"      : ({Logical,Integer},"only return last element/s")
        },
        returns     = {Block,Nothing},
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
            doIterate(itLit=true, itCap=true, itInf=false, itCounter=false, itRolling=false, newBlock()):
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

                var res: ValueArray
            do:
                if isTrue(move stack.pop()):
                    res.add(capturedItems)

                    if onlyFirst:
                        if elemLimit == res.len:
                            keepGoing = false
                            break
            do:
                if onlyLast:
                    let rlen = res.len
                    var startFrom = 0
                    if rlen-elemLimit > 0:
                        startFrom = rlen-elemLimit
                    res = res[startFrom..rlen-1]

                if unlikely(inPlace): RawInPlaced = newBlock(res)
                else: push(newBlock(res))

    builtin "some?",
        alias       = unaliased,
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
            print every? [2 3 5 7 11 14] 'x [prime? x]
            ; false
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
