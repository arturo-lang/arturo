#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: library/Reflection.nim
#=======================================================

## The main Reflection module 
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import helpers/benchmark
when not defined(WEB):
    import helpers/helper

import helpers/terminal as TerminalHelper

import vm/lib
import vm/[env, errors, eval, exec]

#=======================================
# Methods
#=======================================

proc defineSymbols*() =
    
    builtin "arity",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get index of function arities",
        args        = NoArgs,
        attrs       = NoAttrs,
        returns     = {Dictionary},
        example     = """
            print arity\print   ; 1
        """:
            #=======================================================
            var ret = initOrderedTable[string,Value]()
            for k,v in Syms.pairs:
                if v.kind == Function:
                    ret[k] = newInteger(v.arity)

            push(newDictionary(ret))
            
    builtin "attr",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get given attribute, if it exists",
        args        = {
            "name"  : {String,Literal}
        },
        attrs       = NoAttrs,
        returns     = {Any,Null},
        example     = """
            multiply: function [x][
                if? attr? "with" [ 
                    x * attr "with"
                ] 
                else [ 
                    2*x 
                ]
            ]
            
            print multiply 5
            ; 10
            
            print multiply.with: 6 5
            ; 60
        """:
            #=======================================================
            let val = popAttr(x.s)
            if val.isNil:
                push(VNULL)
            else:
                push(val)

    builtin "attr?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check if given attribute exists",
        args        = {
            "name"  : {String,Literal}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            greet: function [x][
                if? not? attr? 'later [
                    print ["Hello" x "!"]
                ]
                else [
                    print [x "I'm afraid I'll greet you later!"]
                ]
            ]
            
            greet.later "John"
            
            ; John I'm afraid I'll greet you later!
        """:
            #=======================================================
            if getAttr(x.s) != VNULL:
                push(VTRUE)
            else:
                push(VFALSE)

    builtin "attribute?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :attribute",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            attribute? first [.something x]
            ; => true
        """:
            #=======================================================
            push(newLogical(xKind==Attribute))

    builtin "attributeLabel?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :attributeLabel",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            attributeLabel? first [.something: x]
            ; => true
        """:
            #=======================================================
            push(newLogical(xKind==AttributeLabel))

    builtin "attrs",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get dictionary of set attributes",
        args        = NoArgs,
        attrs       = NoAttrs,
        returns     = {Dictionary},
        example     = """
            greet: function [x][
                print ["Hello" x "!"]
                print attrs
            ]
            
            greet.later "John"
            
            ; Hello John!
            ; [
            ;    later:    true
            ; ]
        """:
            #=======================================================
            push(getAttrsDict())

    builtin "benchmark",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "benchmark given code",
        args        = {
            "action": {Block,Bytecode}
        },
        attrs       = {
            "get"   : ({Logical},"get benchmark time")
        },
        returns     = {Nothing,Floating},
        example     = """
            benchmark [ 
                ; some process that takes some time
                loop 1..10000 => prime? 
            ]
            
            ; [benchmark] time: 0.065s
            ..........
            benchmark.get [
                loop 1..10000 => prime?
            ]
            ; => 0.3237628936767578
        """:
            #=======================================================
            let preevaled = evalOrGet(x)
            if (hadAttr("get")):
                let time = getBenchmark:
                    execUnscoped(preevaled)

                push newQuantity(newFloating(time), newQuantitySpec(MS))
            else:
                benchmark "":
                    execUnscoped(preevaled)

    builtin "binary?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :binary",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            binary? to :binary "string"
            ; => true
        """:
            #=======================================================
            push(newLogical(xKind==Binary))

    builtin "block?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :block",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print block? [1 2 3]            ; true
            print block? #[name: "John"]    ; false
            print block? "hello"            ; false
            print block? 123                ; false
        """:
            #=======================================================
            push(newLogical(xKind==Block))

    builtin "bytecode?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :bytecode",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            code: [print 1 + 2]
            bcode: to :bytecode code

            print bytecode? bcode      ; true
            print bytecode? code       ; false
        """:
            #=======================================================
            push(newLogical(xKind==Bytecode))

    builtin "char?",
        alias       = unaliased,
        op          = opNop, 
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :char",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print char? `a`         ; true
            print char? 123         ; false
        """:
            #=======================================================
            push(newLogical(xKind==Char))

    builtin "color?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :color",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print color? #FF0000        ; true
            print color? #green         ; true

            print color? 123            ; false
        """:
            #=======================================================
            push(newLogical(xKind==Color))

    builtin "complex?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :complex",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            c: to :complex [1 2]
            print complex? c            ; true

            print complex? 123          ; false
        """:
            #=======================================================
            push(newLogical(xKind==Complex))

    builtin "database?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :database",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            database? open "my.db"
            ; => true
        """:
            #=======================================================
            push(newLogical(xKind==Database))

    builtin "date?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :date",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print date? now             ; true
            print date? "hello"         ; false
        """:
            #=======================================================
            push(newLogical(xKind==Date))

    builtin "dictionary?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :dictionary",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print dictionary? #[name: "John"]   ; true
            print dictionary? 123               ; false
        """:
            #=======================================================
            push(newLogical(xKind==Dictionary))

    when not defined(WEB):

        builtin "info",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "print info for given symbol",
            args        = {
                "symbol": {String,Literal,SymbolLiteral}
            },
            attrs       = {
                "get"       : ({Logical},"get information as dictionary")
            },
            returns     = {Dictionary,Nothing},
            example     = """
            info 'print

            ; |--------------------------------------------------------------------------------
            ; |          print  :function                                          0x1028B3410
            ; |--------------------------------------------------------------------------------
            ; |                 print given value to screen with newline
            ; |--------------------------------------------------------------------------------
            ; |          usage  print value :any
            ; |
            ; |        returns  :nothing
            ; |--------------------------------------------------------------------------------
            ..........
            info '++

            ; |--------------------------------------------------------------------------------
            ; |         append  :function                                          0x107555A10
            ; |          alias  ++
            ; |--------------------------------------------------------------------------------
            ; |                 append value to given collection
            ; |--------------------------------------------------------------------------------
            ; |          usage  append collection :char :string :literal :block
            ; |                        value :any
            ; |
            ; |        returns  :string :block :nothing
            ; |--------------------------------------------------------------------------------
            ..........
            print info.get 'print
            ; [name:print address:0x1028B3410 type::function module:Io args:[value:[:any]] attrs:[] returns:[:nothing] description:print given value to screen with newline example:print "Hello world!"          ; Hello world!]
            """:
                #=======================================================
                var searchable: string
                var value: Value = nil

                if xKind == SymbolLiteral:
                    searchable = $(x.m)
                    for (sym, binding) in pairs(Aliases):
                        if sym == x.m:
                            searchable = binding.name.s
                            value = FetchSym(searchable)
                            break

                    if value.isNil:
                        RuntimeError_AliasNotFound($(x.m))
                else:
                    searchable = x.s
                    value = FetchSym(x.s)
                
                if (hadAttr("get")):
                    push(newDictionary(getInfo(searchable, value, Aliases)))
                else:
                    printInfo(searchable, value, Aliases)

    builtin "inline?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :inline",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            inline? first [(something) x]
            ; => true
        """:
            #=======================================================
            push(newLogical(xKind==Inline))

    builtin "inspect",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "print full dump of given value to screen",
        args        = {
            "value" : {Any}
        },
        attrs       = {
            "muted" : ({Logical},"don't use color output")
        },
        returns     = {Nothing},
        example     = """
            inspect 3                 ; 3 :integer
            
            a: "some text"
            inspect a                 ; some text :string
        """:
            #=======================================================
            when defined(WEB):
                resetStdout()
            let mutedOutput = (hadAttr("muted")) or NoColors
            x.dump(0, false, muted=mutedOutput)

    builtin "integer?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :integer",
        args        = {
            "value" : {Any}
        },
        attrs       = {
            "big"   : ({Logical},"check if, internally, it's a bignum")
        },
        returns     = {Logical},
        example     = """
            print integer? 123                  ; true
            print integer? "hello"              ; false
            ..........
            integer?.big 123                    ; => false
            integer?.big 12345678901234567890   ; => true
        """:
            #=======================================================
            if (hadAttr("big")):
                push(newLogical(xKind==Integer and x.iKind==BigInteger))
            else:
                push(newLogical(xKind==Integer))

    builtin "is?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check whether value is of given type",
        args        = {
            "type"  : {Type,Block},
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            is? :string "hello"       ; => true
            is? :block [1 2 3]        ; => true
            is? :integer "boom"       ; => false

            is? [:string] ["one" "two"]     ; => true
            is? [:integer] [1 "two]         ; => false
        """:
            #=======================================================
            if yKind != Object:
                if xKind == Type:
                    if x.t == Any:
                        push(VTRUE)
                    else:
                        push(newLogical(x.t == yKind))
                else:
                    let elem {.cursor.} = x.a[0]
                    requireValue(elem, {Type})

                    let tp = elem.t
                    var res = true
                    if tp != Any:
                        if yKind != Block: 
                            res = false
                        else:
                            if y.a.len==0: 
                                res = false
                            else:
                                for item in y.a:
                                    if tp != item.kind:
                                        res = false
                                        break
                    push newLogical(res)
            else:
                if x.t in {Object,Any}:
                    push(VTRUE)
                else:
                    if x.tpKind == BuiltinType:
                        push(newLogical(x == newType(y.proto.name)))
                    else:
                        push(newLogical(x.ts.name == y.proto.name))

    builtin "floating?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :floating",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print floating? 3.14        ; true
            print floating? 123         ; false
            print floating? "hello"     ; false
        """:
            #=======================================================
            push(newLogical(xKind==Floating))

    builtin "function?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :function",
        args        = {
            "value" : {Any}
        },
        attrs       = {
            "builtin"   : ({Logical},"check if, internally, it's a built-in")
        },
        returns     = {Logical},
        example     = """
            print function? $[x][2*x]       ; true
            print function? var 'print      ; true
            print function? "print"         ; false
            print function? 123             ; false
            ..........
            f: function [x][x+2]

            function? var'f                 ; => true
            function? var'print             ; => true
            function?.builtin var'f         ; => false
            function?.builtin var'print     ; => true
        """:
            #=======================================================
            if (hadAttr("builtin")):
                push(newLogical(xKind==Function and x.fnKind==BuiltinFunction))
            else:
                push(newLogical(xKind==Function))

    builtin "label?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :label",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            label? first [something: x]
            ; => true
        """:
            #=======================================================
            push(newLogical(xKind==Label))

    builtin "literal?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :literal",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print literal? 'x           ; true
            print literal? "x"          ; false
            print literal? 123          ; false
        """:
            #=======================================================
            push(newLogical(xKind==Literal))

    builtin "logical?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :logical",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print logical? true         ; true
            print logical? false        ; true
            print logical? maybe        ; true
            ..........
            print logical? 1=1          ; true
            print logical? 123          ; false
        """:
            #=======================================================
            push(newLogical(xKind==Logical))

    builtin "null?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :null",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print null? null            ; true
            print null? ø               ; true

            print null? 123             ; false
        """:
            #=======================================================
            push(newLogical(xKind==Null))

    builtin "object?",
        alias       = unaliased, 
        op          = opNop, 
        rule        = PrefixPrecedence,
        description = "checks if given value is a custom-type object",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            define :person [name,surname][]
            
            x: to :person ["John","Doe"]

            print object? x             ; true
            print object? "hello"       ; false
        """:
            #=======================================================
            push(newLogical(xKind==Object))

    builtin "path?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :path",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            path? first [a\b\c x]
            ; => true
        """:
            #=======================================================
            push(newLogical(xKind==Path))

    builtin "pathLabel?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :pathLabel",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            pathLabel? first [a\b\c: x]
            ; => true
        """:
            #=======================================================
            push(newLogical(xKind==PathLabel))

    builtin "quantity?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :quantity",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print quantity? 1:m         ; true
            print quantity? 2:yd2       ; true    

            print quantity? 3           ; false 
        """:
            #=======================================================
            push(newLogical(xKind==Quantity))

    builtin "range?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :range",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            r: 1..3                     ; r: [1 2 3]

            print range? r              ; true
            print range? [1 2 3]        ; false
        """:
            #=======================================================
            push(newLogical(xKind==Range))

    builtin "rational?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :rational",
        args        = {
            "value" : {Any}
        },
        attrs       = {
            "big"   : ({Logical},"check if, internally, it's a bignum")
        },
        returns     = {Logical},
        example     = """
            r: to :rational 3.14        ; r: 157/50

            print rational? r           ; true
            print rational? 3.14        ; false
        """:
            #=======================================================
            if (hadAttr("big")):
                push(newLogical(xKind==Rational and x.rKind==BigRational))
            else:
                push(newLogical(xKind==Rational))

    builtin "regex?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :regex",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print regex? {/[a-z]+/}     ; true
            print regex? "[a-z]+"       ; false
            print regex? 123            ; false
        """:
            #=======================================================
            push(newLogical(xKind==Regex))

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

    builtin "stack",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get current stack",
        args        = NoArgs,
        attrs       = NoAttrs,
        returns     = {Dictionary},
        example     = """
            1 2 3 "done"

            print stack
            ; 1 2 3 done
        """:
            #=======================================================
            push(newBlock(Stack[0..SP-1]))

    builtin "standalone?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if current script runs from the command-line",
        args        = NoArgs,
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            doSomething: function [x][
                print ["I'm doing something with" x]
            ]
            
            if standalone? [
                print "It's running from command line and not included."
                print "Nothing to do!"
            ]
        """:
            #=======================================================
            push(newLogical(PathStack.len == 1))

    builtin "string?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :string",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print string? "x"           ; true
            print string? 'x            ; false
            print string? 123           ; false
        """:
            #=======================================================
            push(newLogical(xKind==String))

    builtin "symbol?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :symbol",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            symbol? first [+ x]
            ; => true
        """:
            #=======================================================
            push(newLogical(xKind==Symbol))

    builtin "symbolLiteral?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :symbolLiteral",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            symbolLiteral? '++
            ; => true
        """:
            #=======================================================
            push(newLogical(xKind==SymbolLiteral))

    builtin "symbols",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get currently defined symbols",
        args        = NoArgs,
        attrs       = NoAttrs,
        returns     = {Dictionary},
        example     = """
            a: 2
            b: "hello"
            
            print symbols
            
            ; [
            ;    a: 2
            ;    b: "hello"
            ;_]
        """:
            #=======================================================
            var symbols: ValueDict = initOrderedTable[string,Value]()
            for k,v in pairs(Syms):
                if k[0]!=toUpperAscii(k[0]):
                    symbols[k] = v
            push(newDictionary(symbols))

    builtin "type",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get type of given value",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Type},
        example     = """
            print type 18966          ; :integer
            print type "hello world"  ; :string
        """:
            #=======================================================
            if xKind != Object:
                push(newType(xKind))
            else:
                push(newUserType(x.proto.name))

    builtin "type?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :type",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print type? :string         ; true
            print type? "string"        ; false
            print type? 123             ; false
        """:
            #=======================================================
            push(newLogical(xKind==Type))

    builtin "version?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :version",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            print version? 1.0.2        ; true
            print version? "1.0.2"      ; false
        """:
            #=======================================================
            push(newLogical(xKind==Version))

    builtin "word?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :word",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            word? first [something x]
            ; => true
        """:
            #=======================================================
            push(newLogical(xKind==Word))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)