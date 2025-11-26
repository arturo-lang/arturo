#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2025 Yanis Zafirópulos
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
import sequtils, sugar

when not defined(WEB):
    import oids
    import helpers/ffi
    when not defined(MINI):
        import os
        import vm/[packager]
else:
    import random

import helpers/datasource
import helpers/objects

import vm/values/printable

import vm/lib
import vm/[errors, eval, exec, parse, runtime]

when defined(BUNDLE):
    import std/private/ospaths2
    import vm/bundle/resources

#=======================================
# Helpers
#=======================================

proc replacingAmpersands(va: Value, what: Value): Value =
    var theBlock = newBlock()
    for v in va.a:
        if v.kind == Symbol and v.m == ampersand:
            theBlock.a.add(what)
        elif v.kind == Block:
            theBlock.a.add(v.replacingAmpersands(what))
        else:
            theBlock.a.add(v)
    return theBlock

#=======================================
# Definitions
#=======================================

proc defineModule*(moduleName: string) =

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
            alias '--> 'addThem!
    
            print --> 2 3
            ; 5
            ..........
            multiplyThem: function [x, y][ x * y ]
            alias.infix {<=>} 'multiplyThem!

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

    # TODO(Core\case) could add `.match` option
    #  that would actually allow us to match and 
    #  extract pattern matches
    #  Previous implementation:
    #  ```
    #  if unlikely(doMatch):
    #      while i < arr.len-1:
    #          var comparable {.cursor.}: Value 
    #          if arr[i].kind == Block:
    #              let stop = SP
    #              execUnscoped(arr[i])
    #              let pattern: ValueArray = sTopsFrom(stop)
    #              comparable = newBlock(pattern)
    #              SP = stop
    #          else:
    #              comparable = arr[i]
    #          
    #          if x == comparable:
    #              handleBranching:
    #                  execUnscoped(arr[i+1])
    #              do:
    #                  break
    #          i += 2
    #  ```
    #  labels: library, new feature, 
    builtin "case",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "match given argument against different values and execute corresponding block",
        args        = {
            "argument"  : {Any},
            "matches"   : {Block, Dictionary}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            x: 2

            ; the main block is always evaluated!
            case x [
                1   -> print "x is one!"
                2   -> print "x is two!"
                any -> print "x is none of the above"
            ]
            ; x is two!
            ..........
            key: "one"
            case key [
                "one" 1,        ; we can also return
                "two" 2         ; simple constant values directly
            ]
            ; => 2
            ..........
            case "hello" #[
                hello: "hola"
                adios: "goodbye"
            ]
            ; => "hola"
        """:
            #=======================================================
            if likely(yKind == Block):
                let stop = SP
                execUnscoped(y)
                let arr: ValueArray = sTopsFrom(stop)
                SP = stop

                var i = 0
                while i < arr.len-1:
                    if x == arr[i]:
                        let blk {.cursor.} = arr[i+1]
                        if likely(blk.kind == Block):
                            handleBranching:
                                execUnscoped(arr[i+1])
                            do:
                                break
                        else:
                            push(blk)
                    i += 2
            else:
                var gotValue: Value = nil
                case xKind:
                    of String, Word, Literal:
                        gotValue = GetDictionaryKey(y, x.s, withError=false)
                    else:
                        gotValue = GetDictionaryKey(y, $(x), withError=false)

                if gotValue.isNil:
                    gotValue = GetDictionaryKey(y, "any", withError=false)
                
                if not gotValue.isNil:
                    if gotValue.kind == Block:
                        handleBranching:
                            execUnscoped(gotValue)
                        do:
                            discard
                    else:
                        push(gotValue)

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

    # TODO(Core\discard) could be assigned an individual *op*?
    #   this could potentially allow us to further optimize it, at a bytecode level.
    #   for example, `push - opdiscard` could be reduced to... nothing at all ;-)
    #  labels: library, bytecode, enhancement
    builtin "discard",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "discard given value, without pushing it onto the stack",
        args        = {
            "value"         : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            validInteger?: function [str][
                not? throws? [
                    discard to :integer str
                    ; we don't really need the value here -
                    ; we just want to see if the operation throws an error
                ]
            ]

            print validInteger? "123"
            ; true
        """:
            #=======================================================
            discard

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
                        pushFrame(x.s, fromFile=true)

                    let parsed = doParse(src, isFile=false)
                    if not parsed.isNil:
                        execUnscoped(parsed)

                    if tp==FileData:
                        discardFrame()
                
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

    # TODO(Core\else) should be marked as deprecated
    #   https://github.com/arturo-lang/arturo/pull/1735
    #  labels: library,→ Core, deprecated
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
            ensure.that: "Wrong calc" ->  0 = 1 + 1
            ; >> Assertion | "Wrong calc": [0 = 1 + 1]
            ;        error |
        """:
            #=======================================================
            
            if checkAttr("that"):
                execUnscoped(x)
                if isFalse(stack.pop()):
                    Error_AssertionFailed(x.codify(), aThat.s)
            else:
                execUnscoped(x)
                if isFalse(stack.pop()):
                    Error_AssertionFailed(x.codify())

    builtin "export",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "export given container children to current scope",
        args        = {
            "module"     : {Module, Dictionary, Object}
        },
        attrs       = {
            "all"   : ({Logical},"export everything, regardless of whether it's been marked as public (makes sense only for modules)")
        },
        returns     = {Nothing},
        example     = """
        greeting: module [
            greet: method.public [user :string][
                print ~"Hello, |user|!"
            ]
        ]

        export greeting!

        greet "Anonymous"   ; Hello, Anonymous!
        ..........
        ; You can't use private methods
        greeting: module [
            greet: method [user :string][
                print ~"Bye, bye, |user|!"
            ]
        ]

        export greeting!

        greet "Anonymous"
        ; Cannot resolve requested value
        ;
        ; Identifier not found: 
        ;     greet
        ;
        ; ┃ File: example.art
        ; ┃ Line: 9
        ; ┃ 
        ; ┃    7 ║  ]
        ; ┃    8 ║  
        ; ┃    9 ║► export greeting!
        ; ┃   10 ║  
        ; ┃   11 ║  greet "Anonymous"
        ; 
        ; Hint: Perhaps you meant... greeting ?
        ;                     or... repeat ?
        ;                     or... greater? ?
        ..........
        ; You can export private functions using the `.all` attribute
        greeting: module [
            greet: method [user :string][
                print ~"Bye, bye, |user|!"
            ]
        ]

        export.all greeting!

        greet "Anonymous" ; Bye, bye, Anonymous!
        """:
            #=======================================================
            let exportAll = hadAttr("all")

            if xKind in {Module, Object}:

                var internalObjName = 
                    if xKind == Module:
                        "__" & x.singleton.proto.name
                    else:
                        when not defined(WEB):
                            "__omodule" & "_" & $(genOid())
                        else:
                            "__omodule" & "_" & $(rand(1_000_000_000..2_000_000_000))

                SetSym(internalObjName, x.singleton)

                var valuePairs = 
                    if xKind == Module:
                        x.singleton.o
                    else:
                        x.o

                for k,v in valuePairs.pairs:
                    if v.kind == Method and (exportAll or v.mpublic):
                        let newParams = v.mparams.filter((prm) => prm != "this").map((prm) => newString(prm))
                        var newBody = copyValue(v.mmain)
                        newBody = newBlock(@[
                            newLabel("this"),
                            newWord(internalObjName),
                            newWord("do"),
                            newBody
                        ])

                        var inPath: ref string = nil
                        if (let methodPath = v.info.path; not methodPath.isNil):
                            new(inPath)
                            inPath[] = methodPath[]

                        let fnc = newFunctionFromDefinition(newParams,newBody, inPath=inPath)

                        SetSym(k, fnc)
            else:
                for k,v in x.d.pairs:
                    SetSym(k, v)

    builtin "express",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "convert given value to Arturo code",
        args        = {
            "value" : {Any}
        },
        attrs       = {
            "pretty"    : ({Logical},"prettify generated code"),
            "unwrapped" : ({Logical},"omit external block notation"),
            "safe"      : ({Logical},"use safe strings")
        },
        returns     = {String},
        example     = """
            example: "Hello, world"
            example                 ; => Hello, world
            express example         ; => "Hello, world"
            ..........
            d: #[name: "John"]
            d\surname: "Doe"
            
            express d
            ; => #[name: "John" surname: "Doe" ]
            ..........
            express.pretty #[name: "John" surname: "Doe"]
            ; => #[
            ;         name: "John"
            ;         surname: "Doe"
            ; ]
        """:
            #=======================================================
            push(newString(codify(x,
                pretty = (hadAttr("pretty")), 
                unwrapped = (hadAttr("unwrapped")), 
                safeStrings = (hadAttr("safe"))
            )))

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
                switch not? null? mult? 
                    -> return mult? * x + y
                    -> return x + y
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
                switch x<2 -> 1
                           -> (fib x-1) + (fib x-2)
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

            var inPath: ref string = nil
            if (let currentF = currentFrame(); currentF != entryFrame()):
                new(inPath)
                inPath[] = currentF.path

            push(newFunctionFromDefinition(argBlock, y, imports, exports, memoize, inline, inPath))

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

    when (not defined(MINI)) or defined(BUNDLE):
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
                "only"      : ({Block},"import only selected symbols, if available"),
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
                
                var branch = "main"
                let latest = hadAttr("latest")
                let verbose = hadAttr("verbose")
                let lean = hadAttr("lean")
                var importOnly: seq[string] = @[]

                when defined(BUNDLE):
                    let (src, path) = getBundledResource(x.s)
                    pushFrame(path, fromFile=true)

                    let parsed = doParse(src, isFile=false)
                    if not parsed.isNil:
                        if importOnly.len > 0:
                            let got = execScopedModule(parsed, importOnly)
                            for k,v in got.pairs:
                                if importOnly.contains(k) or k.startsWith("__module"):
                                    SetSym(k, v)
                        else:
                            execUnscoped(parsed)
                    discardFrame()
                else:
                    var verspec = (true, NoPackageVersion)
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

                    if checkAttr("only"):
                        importOnly = aOnly.a.map((w) =>  w.s)

                    let verboseBefore = VerbosePackager
                    if verbose:
                        VerbosePackager = true

                    var ret: ValueArray

                    for pkg in pkgs:
                        if (let res = getEntryForPackage(pkg, verspec, branch, latest); res.isSome):
                            let src = res.get()

                            if not src.fileExists():
                                Error_PackageNotValid(pkg)

                            pushFrame(src, fromFile=true)

                            if not lean:
                                let parsed = doParse(src, isFile=true)
                                if not parsed.isNil:
                                    if importOnly.len > 0:
                                        let got = execScopedModule(parsed, importOnly)
                                        for k,v in got.pairs:
                                            if importOnly.contains(k) or k.startsWith("__module"):
                                                SetSym(k, v)
                                    else:
                                        execUnscoped(parsed)
                            else:
                                let parsed = doParse(src, isFile=true)
                                if not parsed.isNil:
                                    let got = execScopedModule(parsed, importOnly)
                                    if multiple:
                                        ret.add(newDictionary(got))
                                    else:
                                        push(newDictionary(got))

                            discardFrame()              
                        else:
                            Error_PackageNotFound(pkg)

                    VerbosePackager = verboseBefore

                    if multiple:
                        push(newBlock(ret))


    # TOOD(Core\let) Update thrown errors
    # Basically those errors are placeholders, and need to be replaced very soon.
    # Related: https://github.com/arturo-lang/arturo/pull/1601#issuecomment-2059027876
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
            ; unpacking slices and multiple assignment
            [a [b] d c]: [1 2 3 4 5]
            print a                 ; 1
            print b                 ; [2 3]
            print c                 ; 4
            print d                 ; 5
            ..........
            ; tuple unpacking
            divmod: function [x,y][
                @[x/y x%y]
            ]
            [d,m]: divmod 10 3      ; d: 3, m: 1
        """:
            #=======================================================
            if xKind==Block and yKind!=Block:
                for symbol in x.a:
                    if symbol.kind != Word:
                        Error_OperationNotPermitted(
                                "Can't assign unknown type.")

                for symbol in x.a:
                    SetSym(symbol.s, y, safe=true)
            
            elif xKind==Block:

                if x.a.len > y.a.len:
                    # Example: [a b]: [1]
                    # Example: [a [b]]: [1]
                    Error_OperationNotPermitted("Missing values to unpack")

                let diff = y.a.len - x.a.len
                var leftItems = 0
                var blockFound = false
                
                for idx, el in x.a.pairs:
                    if el.kind notin {Block, Word, String, Literal}:
                        Error_OperationNotPermitted(
                                "Can't assign unknown type.")
                    if el.kind == Block:
                        if blockFound:
                            # Example: [[a] [b]]: [1 2]
                            Error_OperationNotPermitted(
                                "Can't unpack multiple slices.")
                        if el.a.len == 1:
                            if el.a[0].kind notin {Word, String, Literal}:
                                Error_OperationNotPermitted(
                                    "Can't assign unknown type.")
                        if el.a.len > 1:
                            # Example: [[a b]]: [1 2]
                            Error_OperationNotPermitted(
                                "Unpacking slice supports only one assignment")
                        blockFound = true
                        leftItems = idx

                if not blockFound:
                    if x.a.len < y.a.len:
                        # Example: [a]: [1 2]
                        Error_OperationNotPermitted(
                                "Missing assign variables to unpack")

                    for idx, symbol in x.a.pairs:
                        SetSym(symbol.s, y.a[idx], safe=true)
                else:

                    # Left side
                    for idx in 0..<leftItems:
                        let symbol = x.a[idx]
                        SetSym(symbol.s, y.a[idx], safe=true)

                    # Unpack
                    if x.a[leftItems].a.len != 0:
                        let 
                            symbol = x.a[leftItems].a[0]
                            unpackedBuffer = y.a[(leftItems)..(leftItems + diff)]

                        SetSym(symbol.s, newBlock(unpackedBuffer), safe=true)

                    # Right side
                    for idx in leftItems..(x.a.high):
                        let symbol = x.a[idx]
                        SetSym(symbol.s, y.a[idx + diff], safe=true)

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
            "distinct"  : ({Logical},"shouldn't be treated as a magic method"),
            "public"    : ({Logical},"make method public (relevant only in modules!)")
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
            let isPublic = hadAttr("public")
            
            let argBlock {.cursor.} =
                if xKind == Block: 
                    requireValueBlock(x, {Word, Literal, Type})
                    x.a
                else: @[x]

            var inPath: ref string = nil
            if (let currentF = currentFrame(); currentF != entryFrame()):
                new(inPath)
                inPath[] = currentF.path

            push(newMethodFromDefinition(argBlock, y, isDistinct, isPublic, inPath))

    builtin "module",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "create new module with given contents",
        args        = {
            "contents"  : {Block, Dictionary}
        },
        attrs       = {
            "with"  : ({Block},"use given initialization parameters"),
        },
        returns     = {Module},
        # TODO(Core\module) add documentation example
        #  labels: library, documentation, easy
        example     = """
        ui: module [

            namedRule: method [title :string width :integer][
                title: ~" |title| "
                pad.center.with: '=' title width
            ]

            section: method.public [title :string content :string width :integer][
                ~{
                    |\namedRule title width|
                    |content|
                    |\namedRule title width|
                }
            ]
        ]

        export ui!

        print section "Hello" "World" 50
        ; ===================== Hello ======================
        ; World
        ; ===================== Hello ======================
        print set? 'ui          ; true
        print set? 'namedRule   ; false
        print set? 'section     ; true
        ..........
        ui: [

            init: method [symbol :char][
                \symbol: symbol
            ]

            namedRule: method [title :string width :integer][
                title: ~" |title| "
                pad.center.with: \symbol title width
            ]

            section: method.public [title :string content :string width :integer][
                ~{
                    |\namedRule title width|
                    |content|
                    |\namedRule title width|
                }
            ]
        ]

        export module.with: ['~'] ui!  
        print section "Example" "This is an example" 40
        ; ~~~~~~~~~~~~~~~ Example ~~~~~~~~~~~~~~~~
        ; This is an example
        ; ~~~~~~~~~~~~~~~ Example ~~~~~~~~~~~~~~~~
        """:
            #=======================================================
            var definitions: ValueDict = newOrderedTable[string,Value]()
            var inherits: Value = VNULL
            var super: ValueDict = newOrderedTable[string,Value]()
            var initUsing: ValueArray = @[]

            if checkAttr("with"):
                initUsing = aWith.a

            if xKind == Block:
                if (let constructorMethod = generatedConstructor(x.a); not constructorMethod.isNil):
                    definitions[$ConstructorM] = constructorMethod
                else:
                    for k,v in newDictionary(execDictionary(x)).d:
                        definitions[k] = v
            elif xKind == Dictionary:
                for k,v in x.d:
                    definitions[k] = copyValue(v)

            # TODO(Core\module) should show error in case magic methods are included
            #  magic methods are of no use in that case
            #  labels: vm, error handling
            
            # Get fields
            let fieldTable = getFieldTable(definitions)

            # Generate internal module identifier
            when not defined(WEB):
                let moduleId = "module" & "_" & $(genOid())
            else:
                let moduleId = "module" & "_" & $(rand(1_000_000_000..2_000_000_000))

            let proto = newPrototype(moduleId, definitions, inherits, fieldTable, super)
            let singleton = generateNewObject(proto, initUsing)

            push(newModule(singleton))

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

    builtin "parse",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "parse given string as an Arturo value",
        args        = {
            "code"   : {String, Block}
        },
        attrs       = {
            "data"      : ({Logical},"parse input as Arturo data block (unstable!)")
        },
        returns     = {Any},
        example     = """
            parse "123"         ; 123 (:integer)
            parse "3.14"        ; 3.14 (:floating)
            parse "true"        ; true (:logical)
            parse "[1 2 3]"     ; [1 2 3] (:block)
        """:
            #=======================================================
            if xKind == String:
                let (src, _) = getSource(x.s)
                
                let ret = doParse(src, isFile=false)
                if unlikely(hadAttr("data")):
                    push(parseDataBlock(ret))
                else:
                    push(ret.a[0])
            else:
                if unlikely(hadAttr("data")):
                    push(parseDataBlock(x))
                else:
                    push(x)

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

    builtin "unset",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "undefine given symbol, if already defined",
        args        = {
            "symbol"    : {String,Literal}
        },
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            a: 2
            print a
            ; 2

            unset 'a
            print a
            ; will throw an error
        """:
            #=======================================================
            UnsetSym(x.s)

    builtin "unstack",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "pop top N values from stack",
        args        = {
            "number"    : {Integer}
        },
        attrs       = NoAttrs,
        returns     = {Any},
        example     = """
            1 2 3
            a: unstack 1        ; a: 3

            1 2 3
            b: unstack 2        ; b: [3 2]
            ..........
            ; You can also discard the values using `discard`
            1 2 3
            discard unstack 1   ; popped 3 from the stack
        """:
            #=======================================================
            if Stack[0..SP-1].len < x.i: 
                Error_StackUnderflow()
            
            if x.i==1:
                discard
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

    builtin "using",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "execute block with a pre-defined given `this` value",
        args        = {
            "this"  : {Any},
            "body"  : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            p: #[name: "John" surname: "Doe" age: 38]
            using p [
                print \name             ; access our
                print \age              ; fields directly

                \surname: "Smith"       ; or change their value
            ]
            ; John
            ; 38
        """:
            #=======================================================
            prepareLeaklessOne("this")

            SetSym("this", x, safe=true)

            let evaled: Translation = doEval(y, useStored=false)
            execUnscoped(evaled)

            finalizeLeaklessOne()

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
            print var 'a            ; 2

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

    builtin "when",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check conditions one by one and execute corresponding block accordingly",
        args        = {
            "conditions"   : {Block}
        },
        attrs       = {
            "any"   : ({Logical},"check all conditions, without breaking, regardless of success"),
            "has"   : ({Any}, "prepend given value to each of the conditions")
        },
        returns     = {Logical},
        example     = """
            ; the main block is always evaluated!
            when [
                prime? 4 -> print "yes, 4 is prime - wait, what?!"
                prime? 5 -> print "yes, 5 is prime"
                prime? 7 -> print "yes, 6 is prime"
                true     -> print "none of the above was true"
            ]
            ; yes, 5 is prime
            ..........
            when.any [
                prime? 4 -> print "yes, 4 is prime - wait, what?!"
                prime? 5 -> print "yes, 5 is prime"
                prime? 7 -> print "yes, 7 is prime"
            ]
            ; yes, 5 is prime
            ; yes, 7 is prime
            ..........
            x: 2
            when.has: x [
                [=0] -> print "x is zero!"
                [<1] -> print "x is less than 1"
                [<4] -> print "x is less than 4"
                true -> print "x is >= 4"
            ]
            ; x is less than 4
            ..........
            f: function [x][
                print ["called F with:" x]
                return odd? x
            ]
            ; short-circuiting:
            ; conditions are not evaluated unless needed
            when [
                [f 10]-> print "F 10"
                [f 11]-> print "F 11"
                [f 12]-> print "F 12"
            ]
            ; called F with: 10 
            ; called F with: 11 
            ; F 11

        """:
            #=======================================================
            let withAny = (hadAttr("any"))
            var has: Value = nil
            if checkAttr("has"):
                has = aHas
            
            let stop = SP
            execUnscoped(x)
            let arr: ValueArray = sTopsFrom(stop)
            SP = stop

            var i = 0
            while i < arr.len-1:
                var item = arr[i]

                if item.kind == Block:
                    var blk = newBlock(item.a)

                    if not has.isNil:
                        blk.a = @[has] & blk.a

                    execUnscoped(blk)
                    item = stack.pop()
                
                if not (item.kind==Null or isFalse(item)):
                    handleBranching:
                        execUnscoped(arr[i+1])
                    do:
                        if not withAny:
                            break
                i += 2

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
            "embed" : {String, Literal, Word, Block, Dictionary},
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
            if xKind in {String,Literal,Word}:
                blk.insert(FetchSym(x.s))
                blk.insert(newLabel(x.s))
            elif xKind == Dictionary:
                for k,v in x.d.pairs:
                    blk.insert(v)
                    blk.insert(newLabel(k))
            else:
                for item in x.a:
                    requireValue(item, {Word,Literal})
                    blk.insert(FetchSym(item.s))
                    blk.insert(newLabel(item.s))

            push(newBlock(blk))

    #----------------------------
    # Predicates
    #----------------------------

    builtin "set?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given variable is defined",
        args        = {
            "symbol"    : {String,Literal}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            boom: 12
            print set? 'boom          ; true
            
            print set? 'zoom          ; false
        """:
            #=======================================================
            push(newLogical(SymExists(x.s)))

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

    #----------------------------
    # Constants
    #----------------------------

    constant "any",
        alias       = underscore,
        description = "the ANY constant":
            VANY

    constant "null",
        alias       = slashedzero,
        description = "the NULL constant":
            VNULL
