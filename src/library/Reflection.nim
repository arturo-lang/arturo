######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
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

import helpers/benchmark as benchmarkHelper
import helpers/helper as helperHelper

import vm/[common, env, exec, globals, stack, value]

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Reflection"

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
            ____if? attr? "with" [ 
            ________x * attr "with"
            ____] 
            ____else [ 
            ________2*x 
            ____]
            ]
            
            print multiply 5
            ; 10
            
            print multiply.with: 6 5
            ; 60
        """:
            ##########################################################
            stack.push(popAttr(x.s))

    builtin "attr?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if given attribute exists",
        args        = {
            "name"  : {String,Literal}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            # greet: function [x][
            # ____if? not? attr? 'later [
            # ________print ["Hello" x "!"]
            # ____]
            # ____else [
            # ________print [x "I'm afraid I'll greet you later!"]
            # ____]
            # ]
            #
            # greet.later "John"
            #
            # ; John I'm afraid I'll greet you later!
        """:
            ##########################################################
            if getAttr(x.s) != VNULL:
                stack.push(VTRUE)
            else:
                stack.push(VFALSE)

    builtin "attribute?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :attribute",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(x.kind==Attribute))

    builtin "attributeLabel?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :attributeLabel",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(x.kind==AttributeLabel))

    builtin "attrs",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get dictionary of set attributes",
        args        = {
            "name"  : {String,Literal}
        },
        attrs       = NoAttrs,
        returns     = {Dictionary},
        example     = """
            greet: function [x][
            ____print ["Hello" x "!"]
            ____print attrs
            ]
            
            greet.later "John"
            
            ; Hello John!
            ; [
            ;____later:    true
            ; ]
        """:
            ##########################################################
            stack.push(getAttrsDict())

    builtin "benchmark",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "benchmark given code",
        args        = {
            "action": {Block}
        },
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            benchmark [ 
            ____; some process that takes some time
            ____loop 1..10000 => prime? 
            ]
            
            ; [benchmark] time: 0.065s
        """:
            ##########################################################
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
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(x.kind==Binary))

    builtin "block?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :block",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(x.kind==Block))

    builtin "boolean?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :boolean",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(x.kind==Boolean))

    builtin "char?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :char",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(x.kind==Char))

    builtin "database?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :database",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(x.kind==Database))

    builtin "date?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :date",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(x.kind==Date))

    builtin "dictionary?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :dictionary",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(x.kind==Dictionary))

    builtin "help",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "print a list of all available builtin functions",
        args        = NoArgs,
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
        """:
            ##########################################################
            printHelp()

    builtin "info",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "print info for given symbol",
        args        = {
            "symbol": {String,Literal}
        },
        attrs       = {
            "get"   : ({Boolean},"get information as dictionary")
        },
        returns     = {Dictionary,Nothing},
        example     = """
        """:
            ##########################################################
            if (popAttr("get") != VNULL):
                stack.push(newDictionary(getInfo(x.s, Syms[x.s])))
            else:
                printInfo(x.s, Syms[x.s])

    builtin "inline?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :inline",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(x.kind==Inline))

    builtin "inspect",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "print full dump of given value to screen",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            inspect 3                 ; 3 :integer
            
            a: "some text"
            inspect a                 ; some text :string
        """:
            ##########################################################
            x.dump(0, false)

    builtin "integer?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :integer",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(x.kind==Integer))

    builtin "is?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "print full dump of given value to screen",
        args        = {
            "type"  : {Type},
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            is? :string "hello"       ; => true
            is? :block [1 2 3]        ; => true
            is? :integer "boom"       ; => false
        """:
            ##########################################################
            stack.push(newBoolean(x.t == y.kind))

    builtin "floating?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :floating",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(x.kind==Floating))

    builtin "function?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :function",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(x.kind==Function))

    builtin "label?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :label",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(x.kind==Label))

    builtin "literal?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :literal",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(x.kind==Literal))

    builtin "null?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :null",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(x.kind==Null))

    builtin "path?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :path",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(x.kind==Path))

    builtin "pathLabel?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :pathLabel",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(x.kind==PathLabel))

    builtin "set?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if given variable is defined",
        args        = {
            "symbol"    : {String,Literal}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            boom: 12
            print set? 'boom          ; true
            
            print set? 'zoom          ; false
        """:
            ##########################################################
            stack.push(newBoolean(Syms.hasKey(x.s)))

    builtin "stack",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get current stack",
        args        = NoArgs,
        attrs       = NoAttrs,
        returns     = {Dictionary},
        example     = """
        """:
            ##########################################################
            stack.push(newBlock(Stack[0..SP-1]))

    builtin "standalone?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "checks if current script runs from the command-line",
        args        = NoArgs,
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(PathStack.len == 1))

    builtin "string?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :string",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(x.kind==String))

    builtin "symbol?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :symbol",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(x.kind==Symbol))

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
            ;____a: 2
            ;____b: "hello"
            ;_]
        """:
            ##########################################################
            var symbols: ValueDict = initOrderedTable[string,Value]()
            for k,v in pairs(Syms):
                if k[0]!=toUpperAscii(k[0]):
                    symbols[k] = v
            stack.push(newDictionary(symbols))

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
            stack.push(newType(x.kind))

    builtin "type?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :type",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(x.kind==Type))

    builtin "word?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :word",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
        """:
            ##########################################################
            stack.push(newBoolean(x.kind==Word))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)