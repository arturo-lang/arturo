######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: library/Reflection.nim
######################################################

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

import helpers/terminal as terminalHelper

import vm/lib
import vm/[env, errors, exec]

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Reflection"
    
    builtin "arity",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get index of function arities",
        args        = NoArgs,
        attrs       = NoAttrs,
        returns     = {Dictionary},
        example     = """
            print arity\print   ; 1
        """:
            ##########################################################
            var ret = initOrderedTable[string,Value]()
            for k,v in pairs(Arities):
                ret[k] = newInteger(v)

            push(newDictionary(ret))
            
    builtin "attr",
        alias       = unaliased, 
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
            ##########################################################
            push(popAttr(x.s))

    builtin "attr?",
        alias       = unaliased, 
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
            ##########################################################
            if getAttr(x.s) != VNULL:
                push(VTRUE)
            else:
                push(VFALSE)

    builtin "attribute?",
        alias       = unaliased, 
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
            ##########################################################
            push(newLogical(x.kind==Attribute))

    builtin "attributeLabel?",
        alias       = unaliased, 
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
            ##########################################################
            push(newLogical(x.kind==AttributeLabel))

    builtin "attrs",
        alias       = unaliased, 
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
            ##########################################################
            push(getAttrsDict())

    builtin "benchmark",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "benchmark given code",
        args        = {
            "action": {Block}
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
            ##########################################################
            if (popAttr("get")!=VNULL):
                let time = getBenchmark:
                    discard execBlock(x)

                push newFloating(time)
            else:
                benchmark "":
                    discard execBlock(x)

    builtin "binary?",
        alias       = unaliased, 
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
            ##########################################################
            push(newLogical(x.kind==Binary))

    builtin "block?",
        alias       = unaliased, 
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
            ##########################################################
            push(newLogical(x.kind==Block))

    builtin "char?",
        alias       = unaliased, 
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
            ##########################################################
            push(newLogical(x.kind==Char))

    builtin "database?",
        alias       = unaliased, 
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
            ##########################################################
            push(newLogical(x.kind==Database))

    builtin "date?",
        alias       = unaliased, 
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
            ##########################################################
            push(newLogical(x.kind==Date))

    builtin "dictionary?",
        alias       = unaliased, 
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
            ##########################################################
            push(newLogical(x.kind==Dictionary))

    when not defined(WEB):

        builtin "info",
            alias       = unaliased, 
            rule        = PrefixPrecedence,
            description = "print info for given symbol",
            args        = {
                "symbol": {String,Literal,SymbolLiteral}
            },
            attrs       = {
                "get"       : ({Logical},"get information as dictionary"),
                "examples"  : ({Logical},"show examples for given function, if any")
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
                ##########################################################
                let showExamples = (popAttr("examples")!=VNULL)
                var searchable = ""
                var value = VNULL

                if x.kind == SymbolLiteral:
                    searchable = $(x.m)
                    for (sym, binding) in pairs(Aliases):
                        if sym == x.m:
                            searchable = binding.name.s
                            value = GetSym(searchable)
                            break

                    if value == VNULL:
                        RuntimeError_AliasNotFound($(x.m))
                else:
                    searchable = x.s
                    value = InPlace
                
                if (popAttr("get") != VNULL):
                    push(newDictionary(getInfo(searchable, value, Aliases)))
                else:
                    printInfo(searchable, value, Aliases, withExamples = showExamples)

    builtin "inline?",
        alias       = unaliased, 
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
            ##########################################################
            push(newLogical(x.kind==Inline))

    builtin "inspect",
        alias       = unaliased, 
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
            ##########################################################
            when defined(WEB):
                resetStdout()
            let mutedOutput = (popAttr("muted")!=VNULL) or NoColors
            x.dump(0, false, muted=mutedOutput)

    builtin "integer?",
        alias       = unaliased, 
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
            ##########################################################
            if (popAttr("big")!=VNULL):
                push(newLogical(x.kind==Integer and x.iKind==BigInteger))
            else:
                push(newLogical(x.kind==Integer))

    builtin "is?",
        alias       = unaliased, 
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
            ##########################################################
            if y.custom.isNil():
                if x.kind == Type:
                    if x.t == Any:
                        push(VTRUE)
                    else:
                        push(newLogical(x.t == y.kind))
                else:
                    let tp = cleanBlock(x.a)[0].t
                    var res = true
                    if tp != Any:
                        if y.kind != Block: 
                            res = false
                        else:
                            let blk = cleanBlock(y.a)
                            if blk.len==0: 
                                res = false
                            else:
                                for item in blk:
                                    if tp != item.kind:
                                        res = false
                                        break
                    push newLogical(res)
            else:
                push(newLogical(x.name == y.custom.name))

    builtin "floating?",
        alias       = unaliased, 
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
            ##########################################################
            push(newLogical(x.kind==Floating))

    builtin "function?",
        alias       = unaliased, 
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
            ##########################################################
            if (popAttr("builtin")!=VNULL):
                push(newLogical(x.kind==Function and x.fnKind==BuiltinFunction))
            else:
                push(newLogical(x.kind==Function))

    builtin "label?",
        alias       = unaliased, 
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
            ##########################################################
            push(newLogical(x.kind==Label))

    builtin "literal?",
        alias       = unaliased, 
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
            ##########################################################
            push(newLogical(x.kind==Literal))

    builtin "logical?",
        alias       = unaliased, 
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
            ##########################################################
            push(newLogical(x.kind==Logical))

    builtin "null?",
        alias       = unaliased, 
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
            ##########################################################
            push(newLogical(x.kind==Null))

    builtin "path?",
        alias       = unaliased, 
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
            ##########################################################
            push(newLogical(x.kind==Path))

    builtin "pathLabel?",
        alias       = unaliased, 
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
            ##########################################################
            push(newLogical(x.kind==PathLabel))

    builtin "set?",
        alias       = unaliased, 
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
            ##########################################################
            push(newLogical(SymExists(x.s)))

    builtin "stack",
        alias       = unaliased, 
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
            ##########################################################
            push(newBlock(Stack[0..SP-1]))

    builtin "standalone?",
        alias       = unaliased, 
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
            ##########################################################
            push(newLogical(PathStack.len == 1))

    builtin "string?",
        alias       = unaliased, 
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
            ##########################################################
            push(newLogical(x.kind==String))

    builtin "symbol?",
        alias       = unaliased, 
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
            ##########################################################
            push(newLogical(x.kind==Symbol))

    builtin "symbols",
        alias       = unaliased, 
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
            ##########################################################
            var symbols: ValueDict = initOrderedTable[string,Value]()
            for k,v in pairs(Syms):
                if k[0]!=toUpperAscii(k[0]):
                    symbols[k] = v
            push(newDictionary(symbols))

    builtin "type",
        alias       = unaliased, 
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
            ##########################################################
            if x.custom.isNil():
                push(newType(x.kind))
            else:
                push(x.custom)

    builtin "type?",
        alias       = unaliased, 
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
            ##########################################################
            push(newLogical(x.kind==Type))

    builtin "word?",
        alias       = unaliased, 
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
            ##########################################################
            push(newLogical(x.kind==Word))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)