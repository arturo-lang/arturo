######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
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

import vm/[common, errors, eval, exec, globals, stack, value]

#=======================================
# Methods
#=======================================


proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Iterators"

    builtin "every?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if every single item in collection satisfy given condition",
        args        = {
            "collection"    : {Block},
            "params"        : {Literal,Block},
            "condition"     : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            if every? [2 4 6 8] 'x [even? x] 
                -> print "every number is an even integer"
            ; every number is an even integer

            print every? 1..10 'x -> x < 11
            ; true

            print every? [2 3 5 7 11 14] 'x [prime? x]
            ; false
        """:
            ##########################################################
            var args: ValueArray

            if y.kind==Literal: args = @[y]
            else: args = y.a

            # check if empty
            if x.a.len==0: 
                stack.push(newBoolean(false))
                return

            let preevaled = doEval(z)
            var all = true

            for item in x.a:
                stack.push(item)
                discard execBlock(VNULL, evaluated=preevaled, args=args)
                let popped = stack.pop()
                if popped.kind==Boolean and not popped.b:
                    stack.push(newBoolean(false))
                    all = false
                    break

            if all:
                stack.push(newBoolean(true))

    builtin "filter",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get collection's items by filtering those that do not fulfil given condition",
        args        = {
            "collection"    : {Block,Literal},
            "params"        : {Literal,Block},
            "condition"     : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Block,Nothing},
        example     = """
            print filter 1..10 [x][
                even? x
            ]
            ; 1 3 5 7 9
            
            arr: 1..10
            filter 'arr 'x -> even? x
            print arr
            ; 1 3 5 7 9
        """:
            ##########################################################
            var args: ValueArray

            if y.kind==Literal: args = @[y]
            else: args = y.a

            let preevaled = doEval(z)

            var res: ValueArray = @[]

            if x.kind==Literal:
                discard InPlace
                for i,item in InPlaced.a:
                    stack.push(item)
                    discard execBlock(VNULL, evaluated=preevaled, args=args)
                    if not stack.pop().b:
                        res.add(item)

                InPlaced.a = res
            else:
                for item in x.a:
                    stack.push(item)
                    discard execBlock(VNULL, evaluated=preevaled, args=args)
                    if not stack.pop().b:
                        res.add(item)

                stack.push(newBlock(res))

    builtin "fold",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "flatten given collection by eliminating nested blocks",
        args        = {
            "collection"    : {Block,Literal},
            "params"        : {Literal,Block},
            "action"        : {Block}
        },
        attrs       = {
            "seed"  : ({Any},"use specific seed value"),
            "right" : ({Boolean},"perform right folding")
        },
        returns     = {Block,Null,Nothing},
        example     = """
            fold 1..10 [x,y]-> x + y
            ; => 55 (1+2+3+4..) 
            
            fold 1..10 .seed:1 [x,y][ x * y ]
            ; => 3628800 (10!) 
            
            fold 1..3 [x y]-> x - y
            ; => -6
            
            fold.right 1..3 [x y]-> x - y
            ; => 2
        """:
            ##########################################################
            var args = y.a
            let preevaled = doEval(z)

            var seed = I0
            if x.kind==Literal:
                # check if empty
                if InPlaced.a.len==0: 
                    stack.push(VNULL)
                    return

                if InPlaced.a[0].kind == String:
                    seed = newString("")
            else:
                # check if empty
                if x.a.len==0: 
                    stack.push(VNULL)
                    return

                if x.a[0].kind == String:
                    seed = newString("")

            if (let aSeed = popAttr("seed"); aSeed != VNULL):
                seed = aSeed

            let doRightFold = (popAttr("right")!=VNULL)

            if (x.kind==Literal and InPlace.a.len==0):
                discard
            elif (x.kind!=Literal and x.a.len==0):
                stack.push(x)
            else:
                if (doRightFold):
                    # right fold

                    if x.kind == Literal:
                        var res: Value = seed
                        for i in countdown(InPlaced.a.len-1,0):
                            let a = InPlaced.a[i]
                            let b = res

                            stack.push(b)
                            stack.push(a)

                            discard execBlock(VNULL, evaluated=preevaled, args=args)

                            res = stack.pop()

                        SetInPlace(res)

                    else:
                        var res: Value = seed
                        for i in countdown(x.a.len-1,0):
                            let a = x.a[i]
                            let b = res

                            stack.push(b)
                            stack.push(a)

                            discard execBlock(VNULL, evaluated=preevaled, args=args)

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

                            discard execBlock(VNULL, evaluated=preevaled, args=args)

                            res = stack.pop()

                        SetInPlace(res)

                    else:
                        var res: Value = seed
                        for i in x.a:
                            let a = res
                            let b = i

                            stack.push(b)
                            stack.push(a)

                            discard execBlock(VNULL, evaluated=preevaled, args=args)

                            res = stack.pop()

                        stack.push(res)

    builtin "loop",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "loop through collection, using given iterator and block",
        args        = {
            "collection"    : {Integer,String,Block,Inline,Dictionary},
            "params"        : {Literal,Block},
            "action"        : {Block}
        },
        attrs       = {
            "with"      : ({Literal},"use given index"),
            "forever"   : ({Boolean},"cycle through collection infinitely")
        },
        returns     = {Nothing},
        example     = """
            loop [1 2 3] 'x [
                print x
            ]
            ; 1
            ; 2
            ; 3
            
            loop 1..3 [x][
                print ["x =>" x]
            ]
            ; x => 1
            ; x => 2
            ; x => 3
            
            loop [A a B b C c] [x y][
                print [x "=>" y]
            ]
            ; A => a
            ; B => b
            ; C => c
            
            user: #[
                name: "John"
                surname: "Doe"
            ]
            
            loop user [k v][
                print [k "=>" v]
            ]
            ; name => John
            ; surname => Doe
            
            loop.with:'i ["zero" "one" "two"] 'x [
                print ["item at:" i "=>" x]
            ]
            ; 0 => zero
            ; 1 => one
            ; 2 => two

            loop.forever [1 2 3] => print 
            ; 1 2 3 1 2 3 1 2 3 ...
        """:
            ##########################################################
            var args: ValueArray

            let forever = popAttr("forever")!=VNULL

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
                # check if empty
                if x.d.len==0: return

                var keepGoing = true
                while keepGoing:
                    for k,v in pairs(x.d):
                        stack.push(v)
                        stack.push(newString(k))
                        discard execBlock(VNULL, evaluated=preevaled, args=args)
                    if not forever:
                        keepGoing = false
            elif x.kind==String:
                var arr: seq[Value] = toSeq(runes(x.s)).map((x) => newChar(x))

                # check if empty
                if arr.len==0: return

                var keepGoing = true
                while keepGoing:
                    var indx = 0
                    var run = 0
                    while indx+args.len<=arr.len:
                        for item in arr[indx..indx+args.len-1].reversed:
                            stack.push(item)

                        if withIndex:
                            stack.push(newInteger(run))

                        discard execBlock(VNULL, evaluated=preevaled, args=allArgs)

                        run += 1
                        indx += args.len

                        if not forever:
                            keepGoing = false
            else:
                var arr: seq[Value]
                if x.kind==Integer:
                    arr = (toSeq(1..x.i)).map((x) => newInteger(x))
                else:
                    arr = x.a

                # check if empty
                if arr.len==0: return

                var keepGoing = true
                while keepGoing:
                    var indx = 0
                    var run = 0
                    while indx+args.len<=arr.len:
                        try:
                            for item in arr[indx..indx+args.len-1].reversed:
                                stack.push(item)

                            if withIndex:
                                stack.push(newInteger(run))

                            discard execBlock(VNULL, evaluated=preevaled, args=allArgs)#, isBreakable=true)
                        except BreakTriggered as e:
                            return
                        except ContinueTriggered as e:
                            discard
                        except Defect as e:
                            raise e    

                        finally:
                            run += 1
                            indx += args.len

                            if not forever:
                                keepGoing = false

    builtin "map",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "map collection's items by applying given action",
        args        = {
            "collection"    : {Block,Literal},
            "params"        : {Literal,Block},
            "action"        : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Block,Nothing},
        example     = """
            print map 1..5 [x][
                2*x
            ]
            ; 2 4 6 8 10
            
            arr: 1..5
            map 'arr 'x -> 2*x
            print arr
            ; 2 4 6 8 10
        """:
            ##########################################################
            var args: ValueArray

            if y.kind==Literal: args = @[y]
            else: args = y.a

            let preevaled = doEval(z)

            var res: ValueArray = @[]

            if x.kind==Literal:
                discard InPlace
                for i,item in InPlaced.a:
                    stack.push(item)
                    discard execBlock(VNULL, evaluated=preevaled, args=args)
                    InPlaced.a[i] = stack.pop()
            else:
                for item in x.a:
                    stack.push(item)
                    discard execBlock(VNULL, evaluated=preevaled, args=args)
                    res.add(stack.pop())
                
                stack.push(newBlock(res))

    builtin "select",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get collection's items that fulfil given condition",
        args        = {
            "collection"    : {Block,Literal},
            "params"        : {Literal,Block},
            "action"        : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Block,Nothing},
        example     = """
            print select 1..10 [x][
                even? x
            ]
            ; 2 4 6 8 10
            
            arr: 1..10
            select 'arr 'x -> even? x
            print arr
            ; 2 4 6 8 10
        """:
            ##########################################################
            var args: ValueArray

            if y.kind==Literal: args = @[y]
            else: args = y.a

            let preevaled = doEval(z)

            var res: ValueArray = @[]

            if x.kind==Literal:
                discard InPlace
                for i,item in InPlaced.a:
                    stack.push(item)
                    discard execBlock(VNULL, evaluated=preevaled, args=args)
                    if stack.pop().b:
                        res.add(item)

                InPlaced.a = res
            else:
                for item in x.a:
                    stack.push(item)
                    discard execBlock(VNULL, evaluated=preevaled, args=args)
                    if stack.pop().b:
                        res.add(item)

                stack.push(newBlock(res))

    builtin "some?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if any of collection's items satisfy given condition",
        args        = {
            "collection"    : {Block},
            "params"        : {Literal,Block},
            "condition"     : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            if some? [1 3 5 6 7] 'x [even? x] 
                -> print "at least one number is an even integer"
            ; at least one number is an even integer

            print some? 1..10 'x -> x > 9
            ; true

            print some? [4 6 8 10] 'x [prime? x]
            ; false
        """:
            ##########################################################
            var args: ValueArray

            if y.kind==Literal: args = @[y]
            else: args = y.a

            # check if empty
            if x.a.len==0: 
                stack.push(newBoolean(false))
                return

            let preevaled = doEval(z)
            var one = false

            for item in x.a:
                stack.push(item)
                discard execBlock(VNULL, evaluated=preevaled, args=args)
                let popped = stack.pop()
                if popped.kind==Boolean and popped.b:
                    stack.push(newBoolean(true))
                    one = true
                    break

            if not one:
                stack.push(newBoolean(false))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)