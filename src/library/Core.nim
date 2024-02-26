#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
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

import algorithm, hashes, options

import helpers/datasource
when not defined(WEB):
    import helpers/ffi
    when not defined(MINI):
        import os, sequtils, sugar
        import helpers/packager

import vm/lib
import vm/[env, errors, eval, exec, parse]

#=======================================
# Definitions
#=======================================

proc defineLibrary*() =

    #----------------------------
    # Functions
    #----------------------------

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
            "function"  : {String,Word,Literal,PathLiteral,Function,Method},
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
            ; 
            ; NOTE:
            ; * If you're using GCC, just replace `clang` by `gcc`
            ; * If you're not on MacOS, replace your `dylib` by the right extension
            ;   normally they can be `.so` or `.dll` in other Operational Systems.
            
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

                if xKind in {Literal, String, Word}:
                    fun = FetchSym(x.s)
                elif xKind == PathLiteral:
                    fun = FetchPathSym(x.p)
                else:
                    fun = x

                for v in y.a.reversed:
                    push(v)

                if fun.kind == Function:
                    if fun.fnKind==UserFunction:
                        var fid: Hash
                        if xKind in {Literal,String}:
                            fid = hash(x.s)
                        else:
                            fid = hash(fun)
                            
                        execFunction(fun, fid)
                    else:
                        fun.action()()
                else:
                    var fid: Hash
                    if xKind in {Literal,String}:
                        fid = hash(x.s)
                    else:
                        fid = hash(fun)

                    execMethod(fun, fid)
        
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
            ; Note that 'attr returns null if it has no attribute          
            print coalesce attr "myAttr" "attr not found"
            print (attr "myAttr") ?? "attr not found"
            
            print (myData) ?? defaultData
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

    # TODO(Core\do) not working well with Bytecode?
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
            let y = stack.pop() # pop the value of the previous operation (hopefully an 'if?' or 'when?')
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
                if isFalse(stack.pop()):
                    AssertionError_AssertionFailed(x.codify(), aThat.s)
            else:
                execUnscoped(x)
                if isFalse(stack.pop()):
                    AssertionError_AssertionFailed(x.codify())

    builtin "function",
        alias       = dollar,
        op          = opFunc,
        rule        = PrefixPrecedence,
        description = "create function with given arguments and body",
        args        = {
            "arguments" : {Literal, Block},
            "body"      : {Block}
        },
        attrs       = {
            "import"    : ({Block},"import/embed given list of symbols from current environment"),
            "export"    : ({Block},"export given symbols to parent"),
            "memoize"   : ({Logical},"store results of function calls"),
            "inline"    : ({Logical},"execute function without scope")
        },
        returns     = {Function},
        example     = """
            f: function [x][ x + 2 ]
            print f 10                ; 12

            f: $[x][x+2]
            print f 10                ; 12
            ..........
            multiply: function [x,y][
                x * y
            ]
            print multiply 3 5        ; 15
            ..........
            ; forcing typed parameters
            addThem: function [
                x :integer
                y :integer :floating
            ][
                x + y
            ]
            ..........
            ; adding complete documentation for user function
            ; using data comments within the body
            addThem: function [
                x :integer :floating
                y :integer :floating
            ][
                ;; description: « takes two numbers and adds them up
                ;; options: [
                ;;      mul: :integer « also multiply by given number
                ;; ]
                ;; returns: :integer :floating
                ;; example: {
                ;;      addThem 10 20
                ;;      addThem.mult:3 10 20
                ;; }

                mult?: attr 'mult
                if? not? null? mult? ->
                    return mult? * x + y
                else ->
                    return x + y
            ]

            info'addThem

            ; |--------------------------------------------------------------------------------
            ; |        addThem  :function                                          0x10EF0E528
            ; |--------------------------------------------------------------------------------
            ; |                 takes two numbers and adds them up
            ; |--------------------------------------------------------------------------------
            ; |          usage  addThem x :integer :floating
            ; |                         y :integer :floating
            ; |
            ; |        options  .mult :integer -> also multiply by given number
            ; |
            ; |        returns  :integer :floating
            ; |--------------------------------------------------------------------------------
            ..........
            publicF: function .export:['x] [z][
                print ["z =>" z]
                x: 5
            ]

            publicF 10
            ; z => 10

            print x
            ; 5
            ..........
            ; memoization
            fib: $[x].memoize[
                if? x<2 [1]
                else [(fib x-1) + (fib x-2)]
            ]

            loop 1..25 [x][
                print ["Fibonacci of" x "=" fib x]
            ]
        """:
            #=======================================================
            var imports: Value = nil
            if checkAttr("import"):
                var ret = initOrderedTable[string,Value]()
                for item in aImport.a:
                    requireAttrValue("import", item, {Word, Literal})
                    ret[item.s] = FetchSym(item.s)
                imports = newDictionary(ret)

            var exports: Value = nil

            if checkAttr("export"):
                requireAttrValueBlock("export", aExport, {Word, Literal})
                exports = aExport

            var memoize = (hadAttr("memoize"))
            var inline = (hadAttr("inline"))

            let argBlock {.cursor.} =
                if xKind == Block: 
                    requireValueBlock(x, {Word, Literal, Type})
                    x.a
                else: @[x]

            push(newFunctionFromDefinition(argBlock, y, imports, exports, memoize, inline))

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

    when not defined(MINI):
        # TODO(Core/__VerbosePackager) Find an elegant way to inject hidden functions
        #  labels: library, enhancement, cleanup
        builtin "__VerbosePackager",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "",
            args        = NoArgs,
            attrs       = NoAttrs,
            returns     = {Nothing,Dictionary,Block},
            example     = """
            """:
                #=======================================================
                VerbosePackager = true

        # TODO(Core/import) `.lean` not always working properly
        #  basically, if you make 2 imports of the same package, one `.lean` and another normal one
        #  the 2nd one breaks. Does it have to do with our `execDictionary`?
        #  labels: library, bug, unit-test
        builtin "import",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "import given package",
            args        = {
                "package"   : {String,Literal,Block}
            },
            attrs       = {
                "version"   : ({Version},"specify package version"),
                "min"       : ({Logical},"get any version >= the specified one"),
                "branch"    : ({String,Literal},"use specific branch for repository url (default: main)"),
                "latest"    : ({Logical},"always check for the latest version available"),
                "lean"      : ({Logical},"return as a dictionary, instead of importing in main namespace"),
                "verbose"   : ({Logical},"output extra information")
            },
            returns     = {Nothing,Dictionary,Block},
            example     = """
                import "dummy"                      ; import the package 'dummy'
                do ::
                    print dummyFunc 10              ; and use it :)
                ..........
                import.version:0.0.3 "dummy"        ; import a specific version

                import.min.version:0.0.3 "dummy"    ; import at least the give version;
                                                    ; if there is a newer one, it will pull this one
                ..........
                import.latest "dummy"               ; whether we already have the package or not
                                                    ; always try to pull the latest version
                ..........
                import "https://github.com/arturo-lang/dummy-package"
                ; we may also import user repositories directly

                import.branch:"main" "https://github.com/arturo-lang/dummy-package"
                ; even specifying the branch to pull
                ..........
                import "somefile.art"               ; importing a local file is possible

                import "somepackage"                ; the same works if we have a folder that
                                                    ; is actually structured like a package
                ..........
                d: import.lean "dummy"              ; importing a package as a dictionary
                                                    ; for better namespace isolation

                do [
                    print d\dummyFunc 10            ; works fine :)
                ]
            """:
                #=======================================================
                var verspec = (true, NoPackageVersion)
                var branch = "main"
                let latest = hadAttr("latest")
                let verbose = hadAttr("verbose")
                let lean = hadAttr("lean")
                
                var pkgs: seq[string]
                if xKind in {String, Literal}:
                    pkgs.add(x.s)
                else:
                    pkgs = x.a.map((p)=>p.s)

                let multiple = pkgs.len > 1
                
                if checkAttr("version"):
                    verspec = (hadAttr("min"), aVersion.version)

                if checkAttr("branch"):
                    branch = aBranch.s

                let verboseBefore = VerbosePackager
                if verbose:
                    VerbosePackager = true

                var ret: ValueArray

                for pkg in pkgs:
                    if (let res = getEntryForPackage(pkg, verspec, branch, latest); res.isSome):
                        let src = res.get()

                        if not src.fileExists():
                            RuntimeError_PackageNotValid(pkg)

                        addPath(src)

                        if not lean:
                            let parsed = doParse(src, isFile=true)
                            if not parsed.isNil:
                                execUnscoped(parsed)
                        else:
                            let got = execDictionary(doParse(src, isFile=true))
                            if multiple:
                                ret.add(newDictionary(got))
                            else:
                                push(newDictionary(got))

                        discard popPath()              
                    else:
                        RuntimeError_PackageNotFound(pkg)

                VerbosePackager = verboseBefore

                if multiple:
                    push(newBlock(ret))

    builtin "let",
        alias       = colon, 
        op          = opNop,
        rule        = InfixPrecedence,
        description = "set symbol to given value",
        args        = {
            "symbol"    : {String,Literal,Block,Word},
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

    builtin "method",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "create type method with given arguments and body",
        args        = {
            "arguments" : {Literal, Block},
            "body"      : {Block}
        },
        attrs       = {
            "distinct"  : ({Logical},"shouldn't be treated as a magic method")
        },
        returns     = {Method},
        example     = """
        define :cat [
            init: method [nick :string age :integer][
                this\nick: join.with: " " @["Mr." capitalize nick]
                this\age: age
            ]

            ; Function overloading
            add: method [years :integer][
                this\age: age + this\age
            ]

            meow: method [][
                print [~"|this\nick|:" "'meow!'"]
            ]
        ]

        a: to :cat [15 15]
        ; >> Assertion | [is? :string nick]
        ;        error |  

        snowflake: to :cat ["snowflake" 3]

        snowflake\meow
        ; Mr. Snowflake: 'meow!'

        ; use `do -> snowflake\meow` instead 
        ; when running the above code from a file

        add snowflake 3
        snowflake\age
        ; => 6

        snowflake\add 3
        print snowflake\age
        ; => 9

        ; use `do [snowflake\add 3]` instead
        ; when running the above code from a file
        """:
            #=======================================================
            let isDistinct = hadAttr("distinct")
            
            let argBlock {.cursor.} =
                if xKind == Block: 
                    requireValueBlock(x, {Word, Literal, Type})
                    x.a
                else: @[x]

            push(newMethodFromDefinition(argBlock, y, isDistinct))

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
                if doDiscard: discard stack.pop()
                else: discard
            else:
                if doDiscard: 
                    var i = 0
                    while i<x.i:
                        discard stack.pop()
                        i+=1
                else:
                    var res: ValueArray
                    var i = 0
                    while i<x.i:
                        res.add stack.pop()
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

                    let popped = stack.pop()
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
            "symbol"    : {String,Literal,PathLiteral,Word}
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
            if xKind in {String,Literal,Word}:
                push(FetchSym(x.s))
            else:
                push(FetchPathSym(x.p))

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
                var popped = stack.pop()

                while not (popped.kind==Null or isFalse(popped)):
                    handleBranching:
                        execUnscoped(preevaledY)
                        execUnscoped(preevaledX)
                        popped = stack.pop()
                    do:
                        discard
    
    builtin "with",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "create closure-style block by embedding given words",
        args        = {
            "embed" : {Literal, Block},
            "body"  : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Block},
        example     = """
            f: function [x][
                with [x][
                    "the multiple of" x "is" 2*x
                ]
            ]

            multiplier: f 10

            print multiplier
            ; the multiple of 10 is 20
        """:
            #=======================================================
            var blk: ValueArray = y.a
            if xKind == Literal:
                blk.insert(FetchSym(x.s))
                blk.insert(newLabel(x.s))
            else:
                for item in x.a:
                    requireValue(item, {Word,Literal})
                    blk.insert(FetchSym(item.s))
                    blk.insert(newLabel(item.s))

            push(newBlock(blk))

    #----------------------------
    # Predicates
    #----------------------------

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

    # builtin "throws?",
    #     alias       = unaliased, 
    #     op          = opNop,
    #     rule        = PrefixPrecedence,
    #     description = "perform action, and return true if errors were thrown",
    #     args        = {
    #         "action": {Block,Bytecode}
    #     },
    #     attrs       = NoAttrs,
    #     returns     = {Logical},
    #     example     = """
    #         throws? [
    #             1 + 2
    #         ] 
    #         ; => false

    #         throws? -> 1/0
    #         ; => true
    #     """:
    #         #=======================================================
    #         try:
    #             execUnscoped(x)

    #             push(VFALSE)
    #         except CatchableError, Defect:
    #             push(VTRUE)

    # builtin "try?",
    #     alias       = unaliased, 
    #     op          = opNop,
    #     rule        = PrefixPrecedence,
    #     description = "perform action, catch possible errors and return status",
    #     args        = {
    #         "action": {Block,Bytecode}
    #     },
    #     attrs       = {
    #         "verbose"   : ({Logical},"print all error messages as usual")
    #     },
    #     returns     = {Logical},
    #     example     = """
    #         try? [
    #             ; let's try something dangerous
    #             print 10 / 0
    #         ]
    #         else [
    #             print "something went terribly wrong..."
    #         ]
            
    #         ; something went terribly wrong...
    #     """:
    #         #=======================================================
    #         let verbose = (hadAttr("verbose"))
    #         try:
    #             execUnscoped(x)

    #             push(VTRUE)
    #         except CatchableError, Defect:
    #             let e = getCurrentException()
    #             if verbose:
    #                 showVMErrors(e)
    #             push(VFALSE)

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
            let z = stack.pop()
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
                    discard stack.pop()
                    discard stack.pop()
                    push(newLogical(true))
            else:
                push(z)

    #----------------------------
    # Constants
    #----------------------------

    constant "null",
        alias       = slashedzero,
        description = "the NULL constant":
            VNULL

#=======================================
# Add Library
#=======================================

Libraries.add(defineLibrary)
