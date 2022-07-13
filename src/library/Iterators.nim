######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: library/Iterators.nim
######################################################

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import algorithm, sequtils, sugar, unicode

import helpers/dictionaries

import vm/lib
import vm/[errors, eval, exec]

#=======================================
# Helpers
#=======================================

template iterableItemsFromLiteralParam(prm: untyped): ValueArray =
    if InPlace.kind==Dictionary: 
        InPlaced.d.flattenedDictionary()
    elif InPlaced.kind==String:
        toSeq(runes(InPlaced.s)).map((w) => newChar(w))
    elif InPlaced.kind==Integer:
        (toSeq(1..InPlaced.i)).map((w) => newInteger(w))
    else: # block or inline
        cleanBlock(InPlaced.a)

template iterableItemsFromParam(prm: untyped): ValueArray =
    if prm.kind==Dictionary: 
        prm.d.flattenedDictionary()
    elif prm.kind==String:
        toSeq(runes(prm.s)).map((w) => newChar(w))
    elif prm.kind==Integer:
        (toSeq(1..prm.i)).map((w) => newInteger(w))
    else: # block or inline
        cleanBlock(prm.a)

template iterateThrough(
    idx: Value, 
    params: Value, 
    collection: ValueArray,
    forever: bool,
    rolling: bool,
    rollingRight: bool,
    performAction: untyped
): untyped =
    let collectionLen = collection.len

    if collectionLen > 0:
        var args: ValueArray
        if params.kind==Literal: args = @[params]
        elif params.kind==Block: args = cleanBlock(params.a)

        var argsLen = args.len
        let hasArgs = argsLen > 0
        if not hasArgs:
            argsLen = 1
        when rolling:
            if hasArgs and argsLen>1:
                argsLen -= 1

        var allArgs{.inject.}: ValueArray = args

        var withIndex = false
        if idx != VNULL:
            withIndex = true
            allArgs = concat(@[idx], allArgs)

        var capturedItems{.inject}: ValueArray

        var keepGoing{.inject.}: bool = true
        while keepGoing:
            var indx{.inject.} = 0
            var run = 0
            while indx+argsLen<=collectionLen:
                handleBranching:
                    capturedItems = collection[indx..indx+argsLen-1]
                    if hasArgs:
                        when rolling:
                            if rollingRight: push(res)

                        for item in capturedItems.reversed:
                            push(item)

                        when rolling:
                            if not rollingRight: push(res)

                    if withIndex:
                        push(newInteger(run))

                    performAction
                do:
                    run += 1
                    indx += argsLen

                    if not forever:
                        keepGoing = false

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Iterators"

    builtin "chunk",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "chunk together consecutive items in collection that abide by given predicate",
        args        = {
            "collection"    : {Integer,String,Block,Inline,Dictionary,Literal},
            "params"        : {Literal,Block,Null},
            "condition"     : {Block}
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
            ##########################################################
            let preevaled = doEval(z)
            let withIndex = popAttr("with")
            let showValue = (popAttr("value")!=VNULL)
            let doForever = false

            var items: ValueArray

            let withLiteral = x.kind==Literal
            if withLiteral: items = iterableItemsFromLiteralParam(x)
            else: items = iterableItemsFromParam(x)

            var res: ValueArray = @[]
            var state = VNULL
            var currentSet: ValueArray = @[]

            iterateThrough(withIndex, y, items, doForever, false, false):
                discard execBlock(VNULL, evaluated=preevaled, args=allArgs)
                let popped = pop()
                if popped != state:
                    if len(currentSet)>0:
                        if showValue:
                            res.add(newBlock(@[state, newBlock(currentSet)]))
                        else:
                            res.add(newBlock(currentSet))
                        currentSet = @[]
                    state = popped
                
                currentSet.add(capturedItems)

            if len(currentSet)>0:
                if showValue:
                    res.add(newBlock(@[state, newBlock(currentSet)]))
                else:
                    res.add(newBlock(currentSet))

            if withLiteral: InPlaced = newBlock(res)
            else: push(newBlock(res))

    builtin "cluster",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "group together items in collection that abide by given predicate",
        args        = {
            "collection"    : {Integer,String,Block,Inline,Dictionary,Literal},
            "params"        : {Literal,Block,Null},
            "condition"     : {Block}
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
            ##########################################################
            let preevaled = doEval(z)
            let withIndex = popAttr("with")
            let showValue = (popAttr("value")!=VNULL)
            let doForever = false

            var items: ValueArray

            let withLiteral = x.kind==Literal
            if withLiteral: items = iterableItemsFromLiteralParam(x)
            else: items = iterableItemsFromParam(x)

            var res: ValueArray = @[]
            var sets: OrderedTable[Value,ValueArray] = initOrderedTable[Value,ValueArray]()

            iterateThrough(withIndex, y, items, doForever, false, false):
                discard execBlock(VNULL, evaluated=preevaled, args=allArgs)
                let popped = pop()
                if not sets.hasKey(popped):
                    sets[popped] = @[]
                sets[popped].add(capturedItems)

            if showValue:
                for k,v in sets.pairs:
                    res.add(newBlock(@[k, newBlock(v)]))
            else:
                for v in sets.values:
                    res.add(newBlock(v))

            if withLiteral: InPlaced = newBlock(res)
            else: push(newBlock(res))

    builtin "every?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if every item in collection satisfies given condition",
        args        = {
            "collection"    : {Integer,String,Block,Inline,Dictionary},
            "params"        : {Literal,Block,Null},
            "condition"     : {Block}
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
            ##########################################################
            let preevaled = doEval(z)
            let withIndex = popAttr("with")
            let doForever = false

            var items: ValueArray
            items = iterableItemsFromParam(x)

            var all = true

            iterateThrough(withIndex, y, items, doForever, false, false):
                discard execBlock(VNULL, evaluated=preevaled, args=allArgs)

                let popped = pop()
                if popped.kind==Logical and Not(popped.b)==True:
                    push(newLogical(false))
                    all = false
                    keepGoing = false
                    break

            if all:
                push(newLogical(true))

    builtin "filter",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get collection's items by filtering those that do not fulfil given condition",
        args        = {
            "collection"    : {Integer,String,Block,Inline,Dictionary,Literal},
            "params"        : {Literal,Block,Null},
            "condition"     : {Block}
        },
        attrs       = {
            "with"      : ({Literal},"use given index"),
            "first"     : ({Logical,Integer},"only filter first element/s"),
            "last"      : ({Logical,Integer},"only filter last element/s")
        },
        returns     = {Block,Nothing},
        # TODO(Iterators\filter) add unit-test tests for `.first` and `.last`
        #  it should go in tests/unittests/lib.iterators.art
        #  labels: unit-test,easy
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
            ##########################################################
            let preevaled = doEval(z)
            let withIndex = popAttr("with")
            var onlyFirst = false
            var onlyLast = false
            var elemLimit = -1
            if (let aFirst = popAttr("first"); aFirst != VNULL):
                onlyFirst = true
                if aFirst.kind == Logical and aFirst.b == True: elemLimit = 1
                else: elemLimit = aFirst.i

            if (let aLast = popAttr("last"); aLast != VNULL):
                onlyLast = true
                if aLast.kind == Logical and aLast.b == True: elemLimit = 1
                else: elemLimit = aLast.i

            let doForever = false

            var items: ValueArray

            let withLiteral = x.kind==Literal
            if withLiteral: items = iterableItemsFromLiteralParam(x)
            else: items = iterableItemsFromParam(x)

            var res: ValueArray = @[]
            var stoppedAt = -1

            if onlyLast:
                items.reverse()

            var filteredItems = 0

            iterateThrough(withIndex, y, items, doForever, false, false):
                discard execBlock(VNULL, evaluated=preevaled, args=allArgs)
                let popped = pop()
                if popped.kind==Logical and Not(popped.b)==True:
                    res.add(capturedItems)
                else:
                    if onlyFirst or onlyLast:
                        filteredItems += capturedItems.len
                        if elemLimit == filteredItems:
                            stoppedAt = indx+1
                            keepGoing = false
                            break

            if (onlyFirst or onlyLast) and stoppedAt < items.len:
                res.add(items[stoppedAt..items.len-1])
            
            if onlyLast:
                res.reverse()

            if withLiteral: InPlaced = newBlock(res)
            else: push(newBlock(res))

    builtin "fold",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "left-fold given collection returning accumulator",
        args        = {
            "collection"    : {Integer,String,Block,Inline,Dictionary},
            "params"        : {Literal,Block,Null},
            "action"        : {Block}
        },
        attrs       = {
            "with"  : ({Literal},"use given index"),
            "seed"  : ({Any},"use specific seed value"),
            "right" : ({Logical},"perform right folding")
        },
        returns     = {Block,Null,Nothing},
        # TODO(Iterators\fold) add documentation examples for `.with` and multiple arguments
        #  labels: library,documentation,easy
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
        """:
            ##########################################################
            let preevaled = doEval(z)
            let withIndex = popAttr("with")
            let doRightFold = popAttr("right")!=VNULL
            let doForever = false

            var items: ValueArray

            let withLiteral = x.kind==Literal
            if withLiteral: items = iterableItemsFromLiteralParam(x)
            else: items = iterableItemsFromParam(x)

            if doRightFold:
                items.reverse

            var seed = I0
            if items.len > 0:
                if items[0].kind == String:     seed = newString("")
                elif items[0].kind == Floating: seed = newFloating(0.0)
                elif items[0].kind == Block:    seed = newBlock()

            if (let aSeed = popAttr("seed"); aSeed != VNULL):
                seed = aSeed

            var res: Value = seed

            iterateThrough(withIndex, y, items, doForever, true, doRightFold):
                discard execBlock(VNULL, evaluated=preevaled, args=allArgs)
                res = pop()

            if withLiteral: InPlaced = res
            else: push(res)

    builtin "loop",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "loop through collection, using given iterator and block",
        args        = {
            "collection"    : {Integer,String,Block,Inline,Dictionary},
            "params"        : {Literal,Block,Null},
            "action"        : {Block}
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
            ##########################################################
            let preevaled = doEval(z)
            let withIndex = popAttr("with")
            let doForever = popAttr("forever")!=VNULL

            var items: ValueArray
            items = iterableItemsFromParam(x)

            iterateThrough(withIndex, y, items, doForever, false, false):
                discard execBlock(VNULL, evaluated=preevaled, args=allArgs)

    builtin "map",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "map collection's items by applying given action",
        args        = {
            "collection"    : {Integer,String,Block,Inline,Dictionary,Literal},
            "params"        : {Literal,Block,Null},
            "condition"     : {Block}
        },
        attrs       = {
            "with"      : ({Literal},"use given index")
        },
        returns     = {Block,Nothing},
        # TODO(Iterators\map) add documentation examples for `.with` and multiple arguments
        #  labels: library,documentation,easy
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
        """:
            ##########################################################
            let preevaled = doEval(z)
            let withIndex = popAttr("with")
            let doForever = false

            var items: ValueArray

            let withLiteral = x.kind==Literal
            if withLiteral: items = iterableItemsFromLiteralParam(x)
            else: items = iterableItemsFromParam(x)

            var res: ValueArray = @[]

            iterateThrough(withIndex, y, items, doForever, false, false):
                discard execBlock(VNULL, evaluated=preevaled, args=allArgs)
                res.add(pop())

            if withLiteral: InPlaced = newBlock(res)
            else: push(newBlock(res))

    builtin "select",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get collection's items that fulfil given condition",
        args        = {
            "collection"    : {Integer,String,Block,Inline,Dictionary,Literal},
            "params"        : {Literal,Block,Null},
            "condition"     : {Block}
        },
        attrs       = {
            "with"      : ({Literal},"use given index"),
            "first"     : ({Logical,Integer},"only return first element/s"),
            "last"      : ({Logical,Integer},"only return last element/s")
        },
        returns     = {Block,Nothing},
        # TODO(Iterators\select) add documentation examples for `.with`, `.first`, `.last` and multiple arguments
        #  labels: library,documentation,easy
        # TODO(Iterators\select) add unit-test tests for `.first` and `.last`
        #  it should go in tests/unittests/lib.iterators.art
        #  labels: unit-test,easy
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
        """:
            ##########################################################
            let preevaled = doEval(z)
            let withIndex = popAttr("with")
            var onlyFirst = false
            var onlyLast = false
            var elemLimit = -1
            if (let aFirst = popAttr("first"); aFirst != VNULL):
                onlyFirst = true
                if aFirst.kind == Logical and aFirst.b == True: elemLimit = 1
                else: elemLimit = aFirst.i

            if (let aLast = popAttr("last"); aLast != VNULL):
                onlyLast = true
                if aLast.kind == Logical and aLast.b == True: elemLimit = 1
                else: elemLimit = aLast.i

            let doForever = false

            var items: ValueArray

            let withLiteral = x.kind==Literal
            if withLiteral: items = iterableItemsFromLiteralParam(x)
            else: items = iterableItemsFromParam(x)

            var res: ValueArray = @[]

            iterateThrough(withIndex, y, items, doForever, false, false):
                discard execBlock(VNULL, evaluated=preevaled, args=allArgs)
                let popped = pop()
                if popped.kind==Logical and popped.b==True:
                    res.add(capturedItems)

                    if onlyFirst:
                        if elemLimit == res.len:
                            keepGoing = false
                            break

            if onlyLast:
                let rlen = res.len
                var startFrom = 0
                if rlen-elemLimit > 0:
                    startFrom = rlen-elemLimit
                res = res[startFrom..rlen-1]

            if withLiteral: InPlaced = newBlock(res)
            else: push(newBlock(res))

    builtin "some?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if any of collection's items satisfy given condition",
        args        = {
            "collection"    : {Integer,String,Block,Inline,Dictionary},
            "params"        : {Literal,Block,Null},
            "condition"     : {Block}
        },
        attrs       = {
            "with"      : ({Literal},"use given index")
        },
        returns     = {Logical},
        # TODO(Iterators\some?) add documentation examples for `.with` and multiple arguments
        #  labels: library,documentation,easy
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
        """:
            ##########################################################
            let preevaled = doEval(z)
            let withIndex = popAttr("with")
            let doForever = false

            var items: ValueArray
            items = iterableItemsFromParam(x)

            var one = false

            iterateThrough(withIndex, y, items, doForever, false, false):
                discard execBlock(VNULL, evaluated=preevaled, args=allArgs)
                let popped = pop()
                if popped.kind==Logical and popped.b==True:
                    push(newLogical(true))
                    one = true
                    keepGoing = false
                    break

            if not one:
                push(newLogical(false))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)