#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2025 Yanis Zafirópulos
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

when not defined(WEB):
    import oids

import sequtils, strutils
import sugar, tables, unicode

import helpers/conversion
import helpers/objects
import helpers/ranges

import vm/lib
import vm/[errors, exec]

#=======================================
# Definitions
#=======================================

proc defineModule*(moduleName: string) =

    # TODO(Types) Add new `extend` function?
    #  This would replace Collections\extend (see relevant comment there)
    #  and could be used for extending an existing user type. 
    #  In a few words: let's say we have `define`d a type, with its methods
    #  and everything. Or if that type has been defined in an external package.
    #  How could we add extra methods to it? By "extending" it ;-)
    #  labels: library, enhancement, open discussion

    #----------------------------
    # Functions
    #----------------------------

    builtin "constructor",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "create a type constructor method automatically using given arguments",
        args        = {
            "arguments"     : {Literal, Block}
        },
        attrs       = NoAttrs,
        returns     = {Method},
        example     = """
            define :cat [
                init: constructor [nick :string]

                meow: method [][
                    print [this\nick ":" "'meow!'"
                ]
            ]

            snowflake: to :cat [15]
            ; Assertion | [is? :string nick]
            ;     error |

            snowflake: to :cat ["Snowflake"]
            snowflake\meow
            ; Snowflake: 'meow!'
        """:
            #=======================================================
            var args: ValueArray

            if xKind == Literal: args = @[x]
            else: args = x.a

            if (let constructorMethod = generatedConstructor(args); not constructorMethod.isNil):
                push(constructorMethod)
            else:
                # TODO(Types\constructor) should show error if the constructor cannot be generated
                #  labels: library, oop, error handling
                discard

    builtin "define",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "define new type with given prototype",
        args        = {
            "type"          : {Type},
            "prototype"     : {Block, Dictionary, Type}
        },
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            ; define a simple type
            define :person [name surname]

            ; and create an object
            someone: to :person ["John" "Doe"]
            print someone       ; [name:John surname:Doe]
            ..........
            ; define a simple type
            define :person [name surname]

            ; and create an object
            ; using a dictionary with field values
            someone: to :person #[surname: "Doe", name: "John"]
            print someone       ; [name:John surname:Doe]
            ..........
            ; define a new type
            ; with custom constructor

            define :person [
                init: method [name, surname, age][
                    this\name: name
                    this\surname: surname
                    this\dob: now\year - age
                ]
            ]

            ; create an object
            jd: to :person ["John" "Doe" 38]
            print jd            ; [name:John surname:Doe dob:1986]
            ..........
            ; define type with overloaded
            ; magic methods
            define :natural [
                init: constructor [value]

                ; custom `+` overload
                add: method [x :integer :natural][
                    (integer? x)? -> this\value + x
                                  -> to :natural @[this\value + x\value]
                ]

                ; custom `to :string` overload
                string: method [][
                    to :string this\value
                ]
            ]

            ; create two new 'natural' numbers
            n1: to :natural @[3]
            n2: to :natural @[5]

            print n1 + n2           ; 8
        """:
            #=======================================================
            var definitions: ValueDict = newOrderedTable[string,Value]()
            var inherits: Value = VNULL
            var super: ValueDict = newOrderedTable[string,Value]()

            if yKind == Block:
                if (let constructorMethod = generatedConstructor(y.a); not constructorMethod.isNil):
                    definitions[$ConstructorM] = constructorMethod
                else:
                    for k,v in newDictionary(execDictionary(y)).d:
                        definitions[k] = v
            elif yKind == Dictionary:
                for k,v in y.d:
                    definitions[k] = copyValue(v)
            else:
                if y.tpKind == UserType:
                    if (let yproto = getType(y.tid); not yproto.isNil):
                        inherits = yproto.inherits
                        super = yproto.super
                        for k,v in yproto.content:
                            definitions[k] = copyValue(v)
                    else:
                        Error_UsingUndefinedType(y.tid)
                else:
                    # TODO(Types\define) check if inherited type is a BuiltinType
                    #  how do we handle this?
                    #  labels: error handling, enhancement
                    discard

            # Get fields
            let fieldTable = getFieldTable(definitions)
            setType(x.tid, newPrototype(x.tid, definitions, inherits, fieldTable, super))

            # Debugging!!
            # push newDictionary({
            #     "name": newString(x.tid),
            #     "definitions": newDictionary(definitions),
            #     "inherits": inherits,
            #     "fields": newDictionary(fieldTable)
            # }.toOrderedTable)

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
        example     = """
            define :animal [
                init: constructor [nick :string age :integer]
                
                speak: method [][
                    print "..."
                ]
            ]

            define :fish is :animal []

            define :cat is :animal [
                speak: method [][
                    print [~"|this\nick|:" "'meow!'"]
                ] 
            ]                                                   

            a: to :cat []
            ; >> Runtime | cannot initialize object of type :cat
            ;      error | wrong number of parameters: 0
            ;            | expected: 2 (nick, age)

            scooby: to :animal ["Scooby" 7]
            scooby\speak
            ; ...

            bubble: to :fish ["Bubble" 1]            
            bubble\speak
            ; ...

            snowflake: to :cat ["Snowflake" 3]
            snowflake\speak
            ; Snowflake: 'meow!'
        """:
            #=======================================================
            # Get our defined fields & methods
            # as a dictionary
            var definitions: ValueDict = newOrderedTable[string,Value]()
            var extra: ValueDict = newOrderedTable[string,Value]()
            var inherits: Value = VNULL

            var super = newOrderedTable[string,Value]()

            if x.tpKind == UserType:
                if (let xproto = getType(x.tid); not xproto.isNil):
                    inherits = x
                    
                    for k,v in xproto.content:
                        if v.kind == Method:
                            super[k] = v.uninjectingThis()

                        definitions[k] = copyValue(v)
                else:
                    Error_UsingUndefinedType(x.tid)
            else:
                # DRAFT:
                # if x.t in {Integer, Floating, Rational, Complex, Quantity}:
                #     for k,v in newDictionary(execDictionary(doParse(GenerateNumericSubtype.replace("%TYPE%",":" & ($(x.t)).toLowerAscii()), isFile=false))).d:
                #         super[k] = v.uninjectingThis()
                #         definitions[k] = copyValue(v)
                # else:
                Error_UnsupportedParentType(($(x.t)).toLowerAscii())

            if yKind == Block:
                if (let constructorMethod = generatedConstructor(y.a); not constructorMethod.isNil):
                    extra[$ConstructorM] = constructorMethod
                else:
                    for k,v in newDictionary(execDictionary(y)).d:
                        extra[k] = v
            else:
                for k,v in y.d:
                    extra[k] = copyValue(v)

            for k,v in extra:
                if v.kind == Method:
                    if (let superF = super.getOrDefault(k, nil); not superF.isNil):
                        definitions[k] = v.injectingSuper(superF)
                    else:
                        definitions[k] = copyValue(v)
                        
                    definitions[k].injectThis()
                else:
                    definitions[k] = v

            when not defined(WEB):
                let tmpTid = x.tid & "_" & $(genOid())
            else:
                let tmpTid = x.tid & "_" & "temp"
                
            setType(tmpTid, newPrototype("_" & x.tid, definitions, inherits, super))

            push newUserType(tmpTid)

    builtin "sortable",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "create a sort descriptor method automatically using given type field",
        args        = {
            "field"     : {Literal}
        },
        attrs       = NoAttrs,
        returns     = {Method},
        example     = """
            define :cat [
                init: constructor [name :string age :integer]
                compare: sortable 'age
            ]

            snowflake: to :cat ["Snowflake" 3]
            smith: to :cat ["Smith" 6]

            compare snowflake smith
            ; => -1
            snowflake < smith
            ; => true
        """:
            #=======================================================
            push(generatedCompare(x))

    # TODO(Types\to) revise attributes
    #  the attributes to this function seem to me a bit confusing. I mean, `to` is
    #  supposed to convert a value to a given type. Obviously, if we convert a Block
    #  value e.g. to a Color, we may need to check whether the contained values are HSL
    #  or HSV or whatever, but having 2 extra options, for one type only (that on top of
    #  it, I haven't ever used even myself - not once!), in a function that does 1 million
    #  other things, seems like not a good idea. Also, if we start sticking options here
    #  for different things (e.g. why not take all options from `dictionary` and include them
    #  all here as well?), this is going to end up being monstrous...
    #  labels: library, enhancement, cleanup, open discussion

    # TODO(Types\to) `.format` could become a distinct function?
    #  having a `format` function (in the Strings module?) would make a lot of sense
    #  actually, plus it would help us to start getting rid of things that don't belong to `to`
    #  leaving the function cleaner and much more to-the-point
    #  labels: library, enhancement, cleanup, open discussion
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

            to :integer 'A'               ; 65
            to :char 65                   ; 'A'

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
            ; ['h' 'e' 'l' 'l' 'o']
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
            print char? 'a'         ; true
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

    builtin "defined?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given type is defined",
        args        = {
            "type" : {Type, String, Literal, Word}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            defined? :cat
            ; => false
            defined? "cat"
            ; => false
            defined? 'cat
            ; => false

            define :cat [
                init: constructor [name :string age :integer]
            ]

            defined? :cat
            ; => true
            defined? "cat"
            ; => true
            defined? 'cat
            ; => true

            defined? :dog
            ; => false
        """:
            #=======================================================
            if xKind == Type:
                if x.tpKind == BuiltinType:
                    push(VTRUE)
                else:
                    push(newLogical(not getType(x.tid).isNil))
            else:
                try:
                    discard parseEnum[ValueKind](x.s.capitalizeAscii())
                    push(VTRUE)
                except:
                    let tp = getType(x.s, safe=true)
                    push(newLogical(not (tp.isNil or tp == NoPrototypeFound)))

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

    builtin "error?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :error",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            error? try -> throw "Some Error"
            ; => true
        """:
            #=======================================================
            push(newLogical(xKind==Error))

    builtin "errorKind?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :errorKind",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            errorKind? to :errorKind "Some error kind"
            ; => true
            errorKind? genericError
            ; => true
        """:
            #=======================================================
            push(newLogical(xKind==Errorkind))

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

    # TODO(Types\is?) should add `.strict` option for Object values?
    #  in that case, it would return true only if the object's type
    #  is the given one. If it inherits the given type - including
    #  something like `is? :object someObj` - would return false
    #  labels: library, enhancement, open discussion
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
                if x.t in {Object,Any} and x.tpKind == BuiltinType:
                    push(VTRUE)
                else:
                    if x.tpKind == BuiltinType:
                        push(VFALSE)
                    else:
                        let givenPrototype = getType(x.tid, safe=true)
                        if givenPrototype == NoPrototypeFound:
                            push(VFALSE)
                        else:
                            var found = false
                            var currentPrototype = y.proto
                            while true:
                                # TODO(Types\is?) better inheritance identification needed
                                #  right now, we're merely comparing the names of the prototypes
                                #  but what if the prototype has been redefined in the meantime?
                                #  we actually have to implement a proper `==` overload for 
                                #  Prototype values!
                                #  labels: bug, values
                                if currentPrototype.name == givenPrototype.name:
                                    found = true
                                    break

                                if y.proto.inherits == VNULL: break
                                if (let newProto = getType(y.proto.inherits.tid, safe=true); newProto != NoPrototypeFound):
                                    currentPrototype = newProto
                                else:
                                    break

                            push(newLogical(found))

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

    builtin "method?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "checks if given value is of type :method",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            greet: method [name :string][print ~"How are you, |name|?"]
            reply: function [name :string][print ~"Hi, I'm fine |name|!"]
            
            method? greet
            ; => true
            
            method? reply
            ; => false
        """:
            #=======================================================
            push(newLogical(xKind == Method))

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
