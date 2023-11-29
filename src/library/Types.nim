#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: library/Types.nim
#=======================================================

## The main Types module 
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import algorithm, sequtils, sugar, unicode

import helpers/conversion
import helpers/objects
import helpers/ranges

import vm/lib
import vm/[exec]

#=======================================
# Definitions
#=======================================

proc defineLibrary*() =

    #----------------------------
    # Functions
    #----------------------------

    # TODO(Types/define) not defined inheritance behavior when using `.as`
    #  labels: library, enhancement
    builtin "define",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "define new type with given prototype",
        args        = {
            "type"          : {Type},
            "prototype"     : {Block, Dictionary, Type}
        },
        attrs       = {
            "having": ({Block}, "automatically initialize given fields (creates a constructor)")
        },
        returns     = {Nothing},
        # TODO(Types\define) update documentation example
        #  to reflect changes to OOP aspects of Arturo in general
        #  and the `define` function in particular
        #  labels: library, documentation, easy
        example     = """
            define :person [name surname age][

                ; magic method to be executed
                ; after a new object has been created
                init: [
                    this\name: capitalize this\name
                ]

                ; magic method to be executed
                ; when the object is about to be printed
                print: [
                    render "NAME: |this\name|, SURNAME: |this\surname|, AGE: |this\age|"
                ]

                ; magic method to be used
                ; when comparing objects (e.g. when sorting)
                compare: [
                    if this\age = that\age -> return 0
                    if this\age < that\age -> return neg 1
                    if this\age > that\age -> return 1
                ]
            ]

            sayHello: function [this][
                ensure -> is? :person this
                print ["Hello" this\name]
            ]

            a: to :person ["John" "Doe" 35]
            b: to :person ["jane" "Doe" 33]

            print a
            ; NAME: John, SURNAME: Doe, AGE: 35
            print b
            ; NAME: Jane, SURNAME: Doe, AGE: 33

            sayHello a
            ; Hello John

            a > b
            ; => true (a\age > b\age)

            print join.with:"\n" sort @[a b]
            ; NAME: Jane, SURNAME: Doe, AGE: 33
            ; NAME: John, SURNAME: Doe, AGE: 35

            print join.with:"\n" sort.descending @[a b]
            ; NAME: John, SURNAME: Doe, AGE: 35
            ; NAME: Jane, SURNAME: Doe, AGE: 33
        """:
            #=======================================================
            # Get our defined methods
            # as a dictionary
            var definedMethods: ValueDict
            if y.kind == Block:
                x.ts.inherits = nil
                definedMethods = newDictionary(execDictionary(y)).d
            elif y.kind == Dictionary:
                x.ts.inherits = nil
                definedMethods = y.d
            else:
                x.ts.inherits = y
                definedMethods = y.ts.methods

            # Important! if we don't empty them forcefully
            # if we re-define a type inside the same piece of code
            # it'll merge everything; we could obviously throw 
            # an error when a type is redefined, but... 
            # is it really an error? Arturo is not C++!
            x.ts.fields = @[]
            x.ts.methods = initOrderedTable[string,Value]()

            # check if we are to create a magic
            # constructor with given fields
            if checkAttr("having"):
                x.ts.fields.add(aHaving.a)

            for key,val in definedMethods:
                x.ts.methods[key] = val

            # setup our object initializer
            # via the magic `init` method
            if (let initMethod = x.ts.methods.getOrDefault("init", nil); not initMethod.isNil):
                # TODO(Types\define) we should verify that our `init` is properly defined
                #  and if not, throw an appropriate error
                #  mainly, that it's a Function
                #  labels: library, error handling, oop
                initMethod.injectThis()
                x.ts.doInit = proc (self: Value, arguments: ValueArray) =
                    for arg in arguments.reversed:
                        push arg
                    push self
                    callFunction(initMethod)

            # check if there is a `print` magic method;
            # the custom equivalent of the `printable` module
            # only for Object values
            if (let printMethod = x.ts.methods.getOrDefault("print", nil); not printMethod.isNil):
                # TODO(Types\define) we should verify that our `print` is properly defined
                #  and if not, throw an appropriate error
                #  mainly, that it's a Function with *no* arguments
                #  labels: library, error handling, oop
                printMethod.injectThis()
                x.ts.doPrint = proc (self: Value): string =
                    push self
                    callFunction(printMethod)
                    stack.pop().s

            # check if there is a `compare` magic method;
            # this is to be used for sorting, etc
            if (let compareMethod = x.ts.methods.getOrDefault("compare", nil); not compareMethod.isNil):
                # TODO(Types\define) we should verify that our `compare` is properly defined
                #  and if not, throw an appropriate error
                #  mainly, that it's a Function with one argument
                #  labels: library, error handling, oop
                compareMethod.injectThis()
                x.ts.doCompare = proc (self: Value, other: Value): int =
                    push other
                    push self
                    callFunction(compareMethod)
                    stack.pop().i

            # var compareMethod: Value = nil

            # if (let thisCompare = definedMethods.getOrDefault("compare", nil); not thisCompare.isNil):
            #     compareMethod = thisCompare
            # else:
            #     if inherited:
            #         if (let inheritedCompare = x.ts.inherits.ts.methods.getOrDefault("compare", nil); not inheritedCompare.isNil):
            #             compareMethod = inheritedCompare.main

            # if not compareMethod.isNil:
            #     if compareMethod.kind==Block:
            #         x.ts.methods["compare"] = newFunction(
            #             @["this","that"],
            #             compareMethod
            #         )
            #     else:
            #         let key = compareMethod
            #         x.ts.methods["compare"] = newFunction(
            #             @["this","that"],
            #             newBlock(@[
            #                 newWord("if"), newPath(@[newWord("this"), key]), newSymbol(greaterthan), newPath(@[newWord("that"), key]), newBlock(@[newWord("return"),newInteger(1)]),
            #                 newWord("if"), newPath(@[newWord("this"), key]), newSymbol(equal), newPath(@[newWord("that"), key]), newBlock(@[newWord("return"),newInteger(0)]),
            #                 newWord("return"), newWord("neg"), newInteger(1)
            #             ])
            #         )
            #     x.ts.doCompare = proc(v1,v2:Value):int =
            #         push v2
            #         push v1
            #         callFunction(x.ts.methods["compare"])
            #         stack.pop().i

    builtin "is",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get derivative type with given prototype",
        args        = {
            "type"          : {Type},
            "prototype"     : {Block,Dictionary}
        },
        attrs       = NoAttrs,
        returns     = {Type},
        # TODO(Types\is) add documentation example
        #  labels: library, documentation, easy
        example     = """
        """:
            #=======================================================
            # Get our defined methods
            # as a dictionary
            var definedMethods: ValueDict
            if y.kind == Block:
                definedMethods = newDictionary(execDictionary(y)).d
            else:
                definedMethods = y.d

            var generated = newUserType(x.ts.name, extended=true)

            for k,v in definedMethods:
                generated.ts.methods[k] = v

            push(generated)

    builtin "to",
        alias       = unaliased,
        op          = opTo,
        rule        = PrefixPrecedence,
        description = "convert value to given type",
        args        = {
            "type"  : {Type,Block},
            "value" : {Any}
        },
        attrs       = {
            "format"    : ({String},"use given format (for dates or floating-point numbers)"),
            "unit"      : ({String,Literal},"use given unit (for quantities)"),
            "intrepid"  : ({Logical},"convert to bytecode without error-line tracking"),
            "hsl"       : ({Logical},"convert HSL block to color"),
            "hsv"       : ({Logical},"convert HSV block to color")
        },
        returns     = {Any},
        example     = """
            to :integer "2020"            ; 2020

            to :integer `A`               ; 65
            to :char 65                   ; `A`

            to :integer 4.3               ; 4
            to :floating 4                ; 4.0

            to :complex [1 2]             ; 1.0+2.0i

            ; make sure you're using the `array` (`@`) converter here, since `neg` must be evaluated first
            to :complex @[2.3 neg 4.5]    ; 2.3-4.5i

            to :rational [1 2]            ; 1/2
            to :rational @[neg 3 5]       ; -3/5

            to :boolean 0                 ; false
            to :boolean 1                 ; true
            to :boolean "true"            ; true

            to :literal "symbol"          ; 'symbol
            ..........
            to :string 2020               ; "2020"
            to :string 'symbol            ; "symbol"
            to :string :word              ; "word"

            to :string .format:"dd/MM/yy" now
            ; 22/03/21

            to :string .format:".2f" 123.12345
            ; 123.12
            ..........
            to :block "one two three"       ; [one two three]

            do to :block "print 123"        ; 123
            ..........
            to :date 0          ; => 1970-01-01T01:00:00+01:00

            print now           ; 2021-05-22T07:39:10+02:00
            to :integer now     ; => 1621661950

            to :date .format:"dd/MM/yyyy" "22/03/2021"
            ; 2021-03-22T00:00:00+01:00
            ..........
            to [:string] [1 2 3 4]
            ; ["1" "2" "3" "4"]

            to [:char] "hello"
            ; [`h` `e` `l` `l` `o`]
            ..........
            define :person [name surname age][]

            to :person ["John" "Doe" 35]
            ; [name:John surname:Doe age:35]
            ..........
            to :color [255 0 10]
            ; => #FF000A

            to :color .hsl [255 0.2 0.4]
            ; => #5C527A
        """:
            #=======================================================
            if xKind==Type:
                let tp = x.t
                push convertedValueToType(x, y, tp, popAttr("format"))
            else:
                var ret: ValueArray
                let elem {.cursor.} = x.a[0]
                requireValue(elem, {Type})
                let tp = elem.t

                if yKind==String:
                    ret = toSeq(runes(y.s)).map((c) => newChar(c))
                else:
                    let aFormat = popAttr("format")
                    if yKind == Block:
                        for item in y.a:
                            ret.add(convertedValueToType(elem, item, tp, aFormat))
                    else:
                        for item in items(y.rng):
                            ret.add(convertedValueToType(elem, item, tp, aFormat))

                push newBlock(ret)

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

    #----------------------------
    # Predicates
    #----------------------------

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

    # TODO(Types\inherits?) not working correctly
    #  it seems to be returning `true` invariably...
    #  labels: library, bug
    builtin "inherits?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "check whether value inherits given type",
        args        = {
            "type"  : {Type},
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        # TODO(Types\inherits?) add documentation example
        #  labels: library, documentation, easy
        example     = """
        """:
            #=======================================================
            if yKind != Object:
                push(VFALSE)
            else:
                var currentType = y.proto.inherits
                var found = false
                while not currentType.isNil:
                    if currentType == x:
                        found = true
                        break
                    currentType = currentType.ts.inherits
                
                push(newLogical(found)) 

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

    # TODO(Types\is?) not working correctly for Object values
    #  it should definitely return true if the object's type is the given one.
    #  what happens if the object inherits from given type?
    #  should that be a matter of e.g. an extra `.strict` option?
    #  labels: library, bug, enhancement, open discussion
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

    builtin "pathLiteral?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :pathLiteral",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            pathLiteral? 'a\b\c
            ; => true
        """:
            #=======================================================
            push(newLogical(xKind==PathLiteral))

    builtin "quantity?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :quantity",
        args        = {
            "value" : {Any}
        },
        attrs       = {
            "big"   : ({Logical},"check if, internally, it's a bignum")
        },
        returns     = {Logical},
        example     = """
            print quantity? 1:m         ; true
            print quantity? 2:yd2       ; true    

            print quantity? 3           ; false 
        """:
            #=======================================================
            if (hadAttr("big")):
                push(newLogical(xKind==Quantity and x.q.original.rKind==BigRational))
            else:
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
                push(newLogical(xKind==Rational and x.rat.rKind==BigRational))
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

    builtin "socket?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :socket",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            server: listen 18966
            socket? server
            ; => true
        """:
            #=======================================================
            push(newLogical(xKind==Socket))

    builtin "store?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :store",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            store? config
            ; => true
        """:
            #=======================================================
            push(newLogical(xKind==Store))

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

    builtin "unit?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :unit",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            unit? `m
            ; => true
        """:
            #=======================================================
            push(newLogical(xKind==Unit))

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

Libraries.add(defineLibrary)