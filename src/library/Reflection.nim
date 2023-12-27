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
# Definitions
#=======================================

proc defineLibrary*() =

    #----------------------------
    # Functions
    #----------------------------
    
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

                push newQuantity(toQuantity(time, parseAtoms("ms")))
            else:
                benchmark "":
                    execUnscoped(preevaled)

    when not defined(WEB):

        builtin "info",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "print info for given symbol",
            args        = {
                "symbol": {String,Literal,SymbolLiteral,PathLiteral}
            },
            attrs       = {
                "get"       : ({Logical},"get information as dictionary")
            },
            returns     = {Dictionary,Nothing},
            example     = """
            info 'print

            ; |--------------------------------------------------------------------------------
            ; |          print  :function                                                   Io
            ; |--------------------------------------------------------------------------------
            ; |                 print given value to screen with newline
            ; |--------------------------------------------------------------------------------
            ; |          usage  print value :any
            ; |
            ; |        options  .lines -> print each value in block in a new line
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
                elif xKind == PathLiteral:
                    searchable = $(x.p[^1])
                    value = FetchPathSym(x.p)
                else:
                    searchable = x.s
                    value = FetchSym(x.s)
                
                if (hadAttr("get")):
                    push(newDictionary(getInfo(searchable, value, Aliases)))
                else:
                    printInfo(searchable, value, Aliases)

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

    #----------------------------
    # Predicates
    #----------------------------

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

#=======================================
# Add Library
#=======================================

Libraries.add(defineLibrary)