#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: library/Core.nim
#=======================================================

## The main Core module 
## (part of the standard library)

# TODO(Core) General cleanup needed
#  labels: library, enhancement, cleanup

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import algorithm, hashes

import helpers/datasource
when not defined(WEB):
    import helpers/ffi

import vm/lib
import vm/[env, errors, eval, exec, parse]

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    # TODO(Core) add new `throw` built-in method?
    #  this could easily work with a new `:exception` built-in type
    #  labels: library, new feature,open discussion

    builtin "alias",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "assign symbol to given function",
        args        = {
            "symbol"      : {Symbol, SymbolLiteral, String, Block},
            "function"    : {Word, Literal, String}
        },
        attrs       = {
            "infix"  : ({Logical},"use infix precedence")
        },
        returns     = {Nothing},
        example     = """
            addThem: function [x, y][
                x + y
            ]
            alias --> 'addThem
    
            print --> 2 3
            ; 5
            ..........
            multiplyThem: function [x, y][ x * y ]
            alias.infix {<=>} 'multiplyThem

            print 2 <=> 3
            ; 6
        """:
            #=======================================================
            var prec = PrefixPrecedence
            if (hadAttr("infix")):
                prec = InfixPrecedence

            var sym: VSymbol
            if xKind==String:
                sym = doParse(x.s, isFile=false).a[0].m
            elif xKind==Block:
                let elem {.cursor.} = x.a[0]
                requireValue(elem, {Symbol, SymbolLiteral})

                sym = elem.m
            else:
                sym = x.m

            Aliases[sym] = AliasBinding(
                precedence: prec,
                name: newWord(y.s)
            )

    builtin "break",
        alias       = unaliased, 
        op          = opBreak,
        rule        = PrefixPrecedence,
        description = "break out of current block or loop",
        args        = NoArgs,
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            loop 1..5 'x [
                print ["x:" x]
                if x=3 -> break
                print "after check"
            ]
            print "after loop"

            ; x: 1
            ; after check
            ; x: 2
            ; after check
            ; x: 3
            ; after loop
        """:
            #=======================================================
            raise BreakTriggered()

    builtin "call",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "call function with given list of parameters",
        args        = {
            "function"  : {String,Literal,Function},
            "params"    : {Block}
        },
        attrs       = {
            "external"  : ({String},"path to external library"),
            "expect"    : ({Type},"expect given return type")
        },
        returns     = {Any},
        example     = """
            multiply: function [x y][
                x * y
            ]
            
            call 'multiply [3 5]          ; => 15
            ..........
            call $[x][x+2] [5]            ; 7
            ..........
            ; Calling external (C code) functions
            
            ; compile with:
            ; clang -c -w mylib.c
            ; clang -shared -o libmylib.dylib mylib.o
            
            ; #include <stdio.h>
            ;
            ; void sayHello(char* name){
            ;    printf("Hello %s!\n", name);
            ; }
            ;
            ; int doubleNum(int num){
            ;    return num * 2;
            ;}

            ; call an external function directly
            call.external: "mylib" 'sayHello ["John"]

            ; map an external function to a native one
            doubleNum: function [num][
                ensure -> integer? num
                call .external: "mylib"
                    .expect:   :integer
                    'doubleNum @[num]
            ]

            loop 1..3 'x [
                print ["The double of" x "is" doubleNum x]
            ]
        """:
            #=======================================================
            if checkAttr("external"):
                when not defined(WEB):
                    let externalLibrary = aExternal.s

                    var expected = Nothing
                    if checkAttr("expect"):
                        expected = aExpect.t

                    push(execForeignMethod(externalLibrary, x.s, y.a, expected))
            else:
                var fun: Value

                if xKind in {Literal, String}:
                    fun = FetchSym(x.s)
                else:
                    fun = x

                for v in y.a.reversed:
                    push(v)

                if fun.fnKind==UserFunction:
                    var fid: Hash
                    if xKind in {Literal,String}:
                        fid = hash(x.s)
                    else:
                        fid = hash(fun)

                    execFunction(fun, fid)
                else:
                    fun.action()()
        
    builtin "case",
        alias       = unaliased,
        op          = opNop, 
        rule        = PrefixPrecedence,
        description = "initiate a case block to check for different cases",
        args        = {
            "predicate" : {Block,Null}
        },
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            a: 2
            case [a]
                when? [<2] -> print "a is less than 2"
                when? [=2] -> print "a is 2"
                else       -> print "a is greater than 2"
        """:
            #=======================================================
            if xKind==Null:
                push(newBlock())
            else:
                push(x)
            push(newLogical(false))

    builtin "coalesce",
        alias       = doublequestion, 
        op          = opNop,
        rule        = InfixPrecedence,
        description = "if first value is null or false, return second value; otherwise return the first one",
        args        = {
            "value"         : {Any},
            "alternative"   : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Any},
        example     = """
        """:
            #=======================================================
            let condition = not (xKind==Null or isFalse(x))
            if condition:
                push(x)
            else:
                push(y)

    builtin "continue",
        alias       = unaliased, 
        op          = opContinue,
        rule        = PrefixPrecedence,
        description = "immediately continue with next iteration",
        args        = NoArgs,
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            loop 1..5 'x [
                print ["x:" x]
                if x=3 -> continue
                print "after check"
            ]
            print "after loop"

            ; x: 1 
            ; after check
            ; x: 2 
            ; after check
            ; x: 3 
            ; x: 4 
            ; after check
            ; x: 5 
            ; after check
            ; after loop
        """:
            #=======================================================
            raise ContinueTriggered()

    # TODO(Core/do) not working well with Bytecode?
    #  labels: bug, critical, library, values
    builtin "do",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "evaluate and execute given code",
        args        = {
            "code"  : {String,Block,Bytecode}
        },
        attrs       = {
            "times" : ({Integer},"repeat block execution given number of times")
        },
        returns     = {Any},
        example     = """
            do "print 123"                ; 123
            ..........
            do [
                x: 3
                print ["x =>" x]          ; x => 3
            ]
            ..........
            print do "https://raw.githubusercontent.com/arturo-lang/arturo/master/examples/projecteuler/euler1.art"
            ; 233168
            ..........
            do.times: 3 [
                print "Hello!"
            ]
            ; Hello!
            ; Hello!
            ; Hello!
            ..........
            ; Importing modules

            ; let's say you have a 'module.art' with  this code:
            ;
            ; pi: 3.14
            ;
            ; hello: $[name :string] [
            ;    print ["Hello" name]
            ;]

            do relative "module.art"

            print pi
            ; 3.14

            do [
                hello "John Doe"
                ; Hello John Doe
            ]
    
            ; Note: always use imported functions inside a 'do block
            ; since they need to be evaluated beforehand.
            ; On the other hand, simple variables can be used without
            ; issues, as 'pi in this example
        """:
            #=======================================================
            var times = 1
            var currentTime = 0

            if checkAttr("times"):
                times = aTimes.i

            var evaled: Translation
            if xKind != String:
                evaled = evalOrGet(x)

            while currentTime < times:
                if xKind in {Block,Bytecode}:
                    execUnscoped(evaled)
                    
                else: # string
                    let (src, tp) = getSource(x.s)

                    if tp==FileData:
                        addPath(x.s)

                    let parsed = doParse(src, isFile=false)
                    if not parsed.isNil:
                        execUnscoped(parsed)

                    if tp==FileData:
                        discard popPath()
                
                currentTime += 1

    builtin "dup",
        alias       = thickarrowleft, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "duplicate the top of the stack and convert non-returning call to a do-return call",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Any},
        example     = """
            ; a label normally consumes its inputs
            ; and returns nothing

            ; using dup before a call, the non-returning function
            ; becomes a returning one

            a: b: <= 3

            print a         ; 3
            print b         ; 3
        """:
            #=======================================================
            push(x)
            push(x)

    builtin "else",
        alias       = unaliased, 
        op          = opElse,
        rule        = PrefixPrecedence,
        description = "perform action, if last condition was not true",
        args        = {
            "otherwise" : {Block,Bytecode}
        },
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            x: 2
            z: 3
            
            if? x>z [
                print "x was greater than z"
            ]
            else [
                print "nope, x was not greater than z"
            ]
        """:
            #=======================================================
            let y = pop() # pop the value of the previous operation (hopefully an 'if?' or 'when?')
            if isFalse(y): 
                execUnscoped(x)
            
            
    builtin "ensure",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "assert given condition is true, or exit",
        args        = {
            "condition"     : {Block}
        },
        attrs       = {
            "that"   : ({String},"prints a custom message when ensure fails")
        },
        returns     = {Nothing},
        example     = """
            num: input "give me a positive number"

            ensure [num > 0]

            print "good, the number is positive indeed. let's continue..."
            ..........
            ensure.message: "Wrong calc" ->  0 = 1 + 1
            ; >> Assertion | "Wrong calc": [0 = 1 + 1]
            ;        error |
        """:
            #=======================================================
            
            if checkAttr("that"):
                execUnscoped(x)
                if isFalse(pop()):
                    AssertionError_AssertionFailed(x.codify(), aThat.s)
            else:
                execUnscoped(x)
                if isFalse(pop()):
                    AssertionError_AssertionFailed(x.codify())

    builtin "if",
        alias       = unaliased, 
        op          = opIf,
        rule        = PrefixPrecedence,
        description = "perform action, if given condition is not false or null",
        args        = {
            "condition" : {Any},
            "action"    : {Block,Bytecode}
        },
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            x: 2
            
            if x=2 -> print "yes, that's right!"
            ; yes, that's right!
        """:
            #=======================================================
            let condition = not (xKind==Null or isFalse(x))
            if condition: 
                execUnscoped(y)

    builtin "if?",
        alias       = unaliased, 
        op          = opIfE,
        rule        = PrefixPrecedence,
        description = "perform action, if given condition is not false or null and return condition result",
        args        = {
            "condition" : {Any},
            "action"    : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            x: 2
            
            result: if? x=2 -> print "yes, that's right!"
            ; yes, that's right!
            
            print result
            ; true
            ..........
            x: 2
            z: 3
            
            if? x>z [
                print "x was greater than z"
            ]
            else [
                print "nope, x was not greater than z"
            ]
        """:
            #=======================================================
            let condition = not (xKind==Null or isFalse(x))
            if condition: 
                execUnscoped(y)

            push(newLogical(condition))

    builtin "let",
        alias       = colon, 
        op          = opNop,
        rule        = InfixPrecedence,
        description = "set symbol to given value",
        args        = {
            "symbol"    : {String,Literal,Block},
            "value"     : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            let 'x 10               ; x: 10
            print x                 ; 10
            ..........
            ; variable assignments
            "a": 2                  ; a: 2
            
            {_someValue}: 3
            print var {_someValue}  ; 3
            ..........
            ; multiple assignments
            [a b]: [1 2]
            print a                 ; 1
            print b                 ; 2
            ..........
            ; multiple assignment to single value
            [a b c]: 5
            print a                 ; 5
            print b                 ; 5
            print c                 ; 5
            ..........
            ; tuple unpacking
            divmod: function [x,y][
                @[x/y x%y]
            ]
            [d,m]: divmod 10 3      ; d: 3, m: 1
        """:
            #=======================================================
            if xKind==Block:
                if yKind==Block:
                    for i,w in pairs(x.a):
                        SetSym(w.s, y.a[i], safe=true)
                else:
                    for w in items(x.a):
                        SetSym(w.s, y, safe=true)
            else:
                SetInPlace(y, safe=true)

    builtin "new",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "create new value by cloning given one",
        args        = {
            "value"     : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Any},
        example     = """
            c: "Hello"
            d: new c        ; make a copy of the older string

            ; changing one string in-place
            ; will change only the string in question

            'd ++ "World"
            print d                 ; HelloWorld
            print c                 ; Hello
        """:
            #=======================================================
            push(copyValue(x))

    constant "null",
        alias       = slashedzero,
        description = "the NULL constant":
            VNULL

    builtin "return",
        alias       = unaliased, 
        op          = opReturn,
        rule        = PrefixPrecedence,
        description = "return given value from current function",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            f: function [x][ 
                loop 1..x 'y [ 
                    if y=5 [ return y*2 ] 
                ] 
                return x*2
            ]
            
            print f 3         ; 6
            print f 6         ; 10
        """:
            #=======================================================
            push(x)
            raise ReturnTriggered()

    builtin "switch",
        alias       = question, 
        op          = opSwitch,
        rule        = InfixPrecedence,
        description = "if condition is not false or null perform given action, otherwise perform alternative action",
        args        = {
            "condition"     : {Any},
            "action"        : {Block},
            "alternative"   : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Any},
        example     = """
            x: 2
            
            switch x=2 -> print "yes, that's right!"
                       -> print "nope, that's not right!"
            ; yes, that's right!
        """:
            #=======================================================
            let condition = not (xKind==Null or isFalse(x))
            if condition: 
                execUnscoped(y)
            else:
                execUnscoped(z)

    builtin "throws?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "perform action, and return true if errors were thrown",
        args        = {
            "action": {Block,Bytecode}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            throws? [
                1 + 2
            ] 
            ; => false

            throws? -> 1/0
            ; => true
        """:
            #=======================================================
            try:
                execUnscoped(x)

                push(VFALSE)
            except CatchableError, Defect:
                push(VTRUE)

    builtin "try",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "perform action and catch possible errors",
        args        = {
            "action": {Block,Bytecode}
        },
        attrs       = {
            "verbose"   : ({Logical},"print all error messages as usual")
        },
        returns     = {Nothing},
        example     = """
            try [
                ; let's try something dangerous
                print 10 / 0
            ]
            
            ; we catch the exception but do nothing with it
        """:
            #=======================================================
            let verbose = (hadAttr("verbose"))
            try:
                execUnscoped(x)
            except CatchableError, Defect:
                let e = getCurrentException()
                if verbose:
                    showVMErrors(e)

    # TODO(Core) add new `catch` method?
    #  Currently, `try?` works with `else`, pretty much like `if?`
    #  but we cannot do anything with the exception itself, in case
    #  this `try?` has failed
    #
    #  So, why not add a `catch` method, where we could do something like:
    #  ```
    #  try? [
    #      ; let's try something dangerous
    #      print 10 / 0
    #  ]
    #  catch 'e [
    #      print "something went terribly wrong..."
    #      print e
    #  ]
    #  ```
    #  In that case, `e` would hold the Exception, which should preferrably be
    #  of a distinct Exception type.
    #  labels: library,new feature,enhancement,open discussion
    builtin "try?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "perform action, catch possible errors and return status",
        args        = {
            "action": {Block,Bytecode}
        },
        attrs       = {
            "verbose"   : ({Logical},"print all error messages as usual")
        },
        returns     = {Logical},
        example     = """
            try? [
                ; let's try something dangerous
                print 10 / 0
            ]
            else [
                print "something went terribly wrong..."
            ]
            
            ; something went terribly wrong...
        """:
            #=======================================================
            let verbose = (hadAttr("verbose"))
            try:
                execUnscoped(x)

                push(VTRUE)
            except CatchableError, Defect:
                let e = getCurrentException()
                if verbose:
                    showVMErrors(e)
                push(VFALSE)

    builtin "unless",
        alias       = unaliased, 
        op          = opUnless,
        rule        = PrefixPrecedence,
        description = "perform action, if given condition is false or null",
        args        = {
            "condition" : {Any},
            "action"    : {Block,Bytecode}
        },
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            x: 2
            
            unless x=1 -> print "yep, x is not 1!"
            ; yep, x is not 1!
        """:
            #=======================================================
            let condition = xKind==Null or isFalse(x)
            if condition: 
                execUnscoped(y)

    builtin "unless?",
        alias       = unaliased, 
        op          = opUnlessE,
        rule        = PrefixPrecedence,
        description = "perform action, if given condition is false or null and return condition result",
        args        = {
            "condition" : {Any},
            "action"    : {Block,Bytecode}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            x: 2
            
            result: unless? x=1 -> print "yep, x is not 1!"
            ; yep, x is not 1!
            
            print result
            ; true
            
            z: 1
            
            unless? x>z [
                print "yep, x was not greater than z"
            ]
            else [
                print "x was greater than z"
            ]
            ; x was greater than z
        """:
            #=======================================================
            let condition = xKind==Null or isFalse(x)
            if condition: 
                execUnscoped(y)

            push(newLogical(condition))
            
    builtin "unstack",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "pop top <number> values from stack",
        args        = {
            "number"    : {Integer}
        },
        attrs       = {
            "discard"   : ({Logical},"do not return anything")
        },
        returns     = {Any},
        example     = """
            1 2 3
            a: unstack 1        ; a: 3

            1 2 3
            b: unstack 2        ; b: [3 2]
            ..........
            1 2 3
            unstack.discard 1   ; popped 3 from the stack
        """:
            #=======================================================
            if Stack[0..SP-1].len < x.i: RuntimeError_StackUnderflow()
            
            let doDiscard = (hadAttr("discard"))
            
            if x.i==1:
                if doDiscard: discard pop()
                else: discard
            else:
                if doDiscard: 
                    var i = 0
                    while i<x.i:
                        discard pop()
                        i+=1
                else:
                    var res: ValueArray
                    var i = 0
                    while i<x.i:
                        res.add pop()
                        i+=1
                    push(newBlock(res))


    builtin "until",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "execute action until the given condition is not false or null",
        args        = {
            "action"    : {Block,Bytecode},
            "condition" : {Block,Bytecode}
        },
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            i: 0 
            until [
                print ["i =>" i] 
                i: i + 1
            ][i = 10]
            
            ; i => 0 
            ; i => 1 
            ; i => 2 
            ; i => 3 
            ; i => 4 
            ; i => 5 
            ; i => 6 
            ; i => 7 
            ; i => 8 
            ; i => 9 
        """:
            #=======================================================
            let preevaledX = evalOrGet(x)
            let preevaledY = evalOrGet(y)

            while true:
                handleBranching:
                    execUnscoped(preevaledX)
                    execUnscoped(preevaledY)

                    let popped = pop()
                    let condition = not (popped.kind==Null or isFalse(popped))
                    if condition:
                        break
                do:
                    discard

    builtin "var",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get symbol value by given name",
        args        = {
            "symbol"    : {String,Literal}
        },
        attrs       = NoAttrs,
        returns     = {Any},
        example     = """
            a: 2
            print var 'a            ; a

            f: function [x][x+2]
            print f 10              ; 12

            g: var 'f               
            print g 10              ; 12
        """:
            #=======================================================
            push(FetchSym(x.s))

    builtin "when?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if a specific condition is fulfilled and, if so, execute given action",
        args        = {
            "condition" : {Block},
            "action"    : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            a: 2
            case [a]
                when? [<2] -> print "a is less than 2"
                when? [=2] -> print "a is 2"
                else       -> print "a is greater than 2"
        """:
            #=======================================================
            let z = pop()
            if isFalse(z):

                let top = sTop()

                var newb: Value = newBlock()
                for old in top.a:
                    newb.a.add(old)
                for cond in x.a:
                    newb.a.add(cond)

                execUnscoped(newb)

                if isTrue(sTop()):
                    execUnscoped(y)
                    discard pop()
                    discard pop()
                    push(newLogical(true))
            else:
                push(z)

    builtin "while",
        alias       = unaliased, 
        op          = opWhile,
        rule        = PrefixPrecedence,
        description = "execute action while the given condition is is not false or null",
        args        = {
            "condition" : {Block,Bytecode,Null},
            "action"    : {Block,Bytecode}
        },
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            i: 0 
            while [i<10][
                print ["i =>" i] 
                i: i + 1
            ]
            
            ; i => 0 
            ; i => 1 
            ; i => 2 
            ; i => 3 
            ; i => 4 
            ; i => 5 
            ; i => 6 
            ; i => 7 
            ; i => 8 
            ; i => 9 

            while ø [
                print "something"   ; infinitely
            ]
        """:
            #=======================================================
            if xKind==Null:
                let preevaledY = evalOrGet(y)
                while true:
                    handleBranching:
                        execUnscoped(preevaledY)
                    do:
                        discard
            else:
                let preevaledX = evalOrGet(x)
                let preevaledY = evalOrGet(y)

                execUnscoped(preevaledX)
                var popped = pop()

                while not (popped.kind==Null or isFalse(popped)):
                    handleBranching:
                        execUnscoped(preevaledY)
                        execUnscoped(preevaledX)
                        popped = pop()
                    do:
                        discard

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)
