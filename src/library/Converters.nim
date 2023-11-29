#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: library/Converters.nim
#=======================================================

## The main Converters module
## (part of the standard library)


# TODO(Converters) The name of this module is a total misnomer
#  I think the module needs a thorough cleanup
#  First and foremost, some of the functions don't belong here
#  Also, "converters"? The only functions that are really converting
#  something are `to`, `as` and `from`.
#  The way I see it, the module could be renamed `types` and include
#  only the functions that have to do with types: e.g. type constructors
#  such as `function`, `array`, `dictionary`, `define`, type converters,
#  e.g. `to`, along with all type-checking predicates (e.g. `integer?`)
#  that should be migrated from the Reflection module. (leaving there more
#  obscure things such as `arity` or `set?`, etc)
#  labels: library, enhancement, cleanup

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import algorithm, sequtils, strformat, sugar, unicode

import helpers/arrays

import helpers/conversion
import helpers/datasource

when not defined(NOASCIIDECODE):
    import helpers/strings

import helpers/ranges
when not defined(WEB):
    import helpers/stores

import vm/lib
import vm/[bytecode, errors, eval, exec, opcodes, parse]

import vm/values/printable

#=======================================
# Variables
#=======================================

var
    currentBuiltinName: string

#=======================================
# Helpers
#=======================================

func canBeInlined(v: Value): bool {.enforceNoRaises.} =
    for item in v.a:
        if item.kind == Label:
            return false
        elif item.kind == Block:
            if not canBeInlined(item):
                return false
    return true

#=======================================
# Definitions
#=======================================

proc defineLibrary*() =

    #----------------------------
    # Functions
    #----------------------------

    # TODO(Converters) resolving `from`/`to`/`as` clutter?
    #  Right now, we have 4 different built-in function performing different-but-similar actions.
    #  Is there any way to remove all ambiguity - by either reducing them, merging them, extending them or explaining their functionality more thoroughly?
    #  labels: library, enhancement, open discussion, documentation

    builtin "array",
        alias       = at,
        op          = opArray,
        rule        = PrefixPrecedence,
        description = "create array from given block, by reducing/calculating all internal values",
        args        = {
            "source": {Any}
        },
        attrs       = {
            "of"    : ({Integer,Block},"initialize an empty n-dimensional array with given dimensions")
        },
        returns     = {Block},
        example     = """
            none: @[]               ; none: []
            a: @[1 2 3]             ; a: [1 2 3]

            b: 5
            c: @[b b+1 b+2]         ; c: [5 6 7]

            d: @[
                3+1
                print "we are in the block"
                123
                print "yep"
            ]
            ; we are in the block
            ; yep
            ; => [4 123]
            ..........
            ; initializing empty array with initial value
            x: array.of: 2 "done"
            inspect.muted x
            ; [ :block
            ;     done :string
            ;     done :string
            ; ]
            ..........
            ; initializing empty n-dimensional array with initial value
            x: array.of: [3 4] 0          ; initialize a 3x4 2D array
                                            ; with zeros
            ; => [[0 0 0 0] [0 0 0 0] [0 0 0 0]]
        """:
            #=======================================================
            if checkAttr("of"):
                if aOf.kind == Integer:
                    let size = aOf.i
                    let blk:ValueArray = safeRepeat(x, size)
                    push newBlock(blk)
                else:
                    var val: Value = copyValue(x)
                    var blk: ValueArray

                    for item in aOf.a.reversed:
                        requireValue(item, {Integer})
                        blk = safeRepeat(val, item.i)
                        val = newBlock(blk.map((v)=>copyValue(v)))

                    push newBlock(blk)
            else:
                if xKind==Range:
                    push(newBlock(toSeq(items(x.rng))))
                else:
                    if xKind==Block:
                        let stop = SP
                        execUnscoped(x)
                        let arr: ValueArray = sTopsFrom(stop)
                        SP = stop

                        push(newBlock(arr))
                    elif xKind==String:
                        let stop = SP
                        let (_{.inject.}, tp) = getSource(x.s)

                        if tp!=TextData:
                            execUnscoped(doParse(x.s, isFile=false))
                        else:
                            RuntimeError_FileNotFound(x.s)
                        let arr: ValueArray = sTopsFrom(stop)
                        SP = stop

                        push(newBlock(arr))
                    else:
                        push(newBlock(@[x]))

    # TODO(Converters/as) is `.unwrapped` working as expected?
    #  labels: library, bug
    builtin "as",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "format given value as implied type",
        args        = {
            "value" : {Any}
        },
        attrs       =
        when not defined(NOASCIIDECODE):
            {
                "binary"    : ({Logical},"format integer as binary"),
                "hex"       : ({Logical},"format integer as hexadecimal"),
                "octal"     : ({Logical},"format integer as octal"),
                "ascii"     : ({Logical},"transliterate string to ASCII"),
                "agnostic"  : ({Logical},"convert words in block to literals, if not in context"),
                "data"      : ({Logical},"parse input as Arturo data block"),
                "code"      : ({Logical},"convert value to valid Arturo code"),
                "pretty"    : ({Logical},"prettify generated code"),
                "unwrapped" : ({Logical},"omit external block notation")
            }
        else:
            {
                "binary"    : ({Logical},"format integer as binary"),
                "hex"       : ({Logical},"format integer as hexadecimal"),
                "octal"     : ({Logical},"format integer as octal"),
                "agnostic"  : ({Logical},"convert words in block to literals, if not in context"),
                "data"      : ({Logical},"parse input as Arturo data block"),
                "code"      : ({Logical},"convert value to valid Arturo code"),
                "pretty"    : ({Logical},"prettify generated code"),
                "unwrapped" : ({Logical},"omit external block notation")
            }
        ,
        returns     = {Any},
        example     = """
            print as.binary 123           ; 1111011
            print as.octal 123            ; 173
            print as.hex 123              ; 7b
            ..........
            print as.ascii "thís ìß ñot à tést"
            ; this iss not a test
        """:
            #=======================================================
            if (hadAttr("binary")):
                push(newString(fmt"{x.i:b}"))
            elif (hadAttr("hex")):
                push(newString(fmt"{x.i:x}"))
            elif (hadAttr("octal")):
                push(newString(fmt"{x.i:o}"))
            elif (hadAttr("agnostic")):
                let res = x.a.map(proc(v:Value):Value =
                    if v.kind == Word and not SymExists(v.s): newLiteral(v.s)
                    else: v
                )
                push(newBlock(res))
            elif (hadAttr("data")):
                if xKind==Block:
                    push(parseDataBlock(x))
                elif xKind==String:
                    let (src, _) = getSource(x.s)
                    push(parseDataBlock(doParse(src, isFile=false)))
            elif (hadAttr("code")):
                push(newString(codify(x,pretty = (hadAttr("pretty")), unwrapped = (hadAttr("unwrapped")), safeStrings = (hadAttr("safe")))))
            else:
                when not defined(NOASCIIDECODE):
                    if (hadAttr("ascii")):
                        push(newString(convertToAscii(x.s)))
                    else:
                        push(x)
                else:
                    push(x)

    builtin "dictionary",
        alias       = sharp,
        op          = opDict,
        rule        = PrefixPrecedence,
        description = "create dictionary from given block or file, by getting all internal symbols",
        args        = {
            "source": {String,Block}
        },
        attrs       = {
            "with"  : ({Block},"embed given symbols"),
            "raw"   : ({Logical},"create dictionary from raw block"),
            "lower" : ({Logical},"automatically convert all keys to lowercase")
        },
        returns     = {Dictionary},
        example     = """
            none: #[]               ; none: []
            a: #[
                name: "John"
                age: 34
            ]
            ; a: [name: "John", age: 34]

            d: #[
                name: "John"
                print "we are in the block"
                age: 34
                print "yep"
            ]
            ; we are in the block
            ; yep
            ; d: [name: "John", age: 34]
            ..........
            e: #.lower [
                Name: "John"
                suRnaMe: "Doe"
                AGE: 35
            ]
            ; e: [name:John, surname:Doe, age:35]
        """:
            #=======================================================
            var dict: ValueDict

            if xKind==Block:
                if (hadAttr("raw")):
                    dict = initOrderedTable[string,Value]()
                    var idx = 0
                    while idx < x.a.len:
                        dict[x.a[idx].s] = x.a[idx+1]
                        idx += 2
                else:
                    dict = execDictionary(x)
            elif xKind==String:
                let (src, tp) = getSource(x.s)

                if tp!=TextData:
                    dict = execDictionary(doParse(src, isFile=false))#, isIsolated=true)
                else:
                    RuntimeError_FileNotFound(x.s)

            if checkAttr("with"):
                for x in aWith.a:
                    requireValue(x, {Word,Literal})
                    dict[x.s] = FetchSym(x.s)

            if (hadAttr("lower")):
                var oldDict = dict
                dict = initOrderedTable[string,Value]()
                for k,v in pairs(oldDict):
                    dict[k.toLower()] = v

            push(newDictionary(dict))

    # TODO(Converters\from) Do we really need this?
    #  We can definitely support hex/binary literals, but how would we support string to number conversion? Perhaps, with `.to` and option?
    #  It's basically rather confusing...
    #  labels: library, cleanup, enhancement, open discussion

    # TODO(Converters/from) revise use of `.opcode`
    #  labels: library, enhancement, open discussion
    builtin "from",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get value from string, using given representation",
        args        = {
            "value" : {String,Literal}
        },
        attrs       = {
            "binary"    : ({Logical},"get integer from binary representation"),
            "hex"       : ({Logical},"get integer from hexadecimal representation"),
            "octal"     : ({Logical},"get integer from octal representation"),
            "opcode"    : ({Logical},"get opcode by from opcode literal")
        },
        returns     = {Any},
        example     = """
            print from.binary "1011"        ; 11
            print from.octal "1011"         ; 521
            print from.hex "0xDEADBEEF"     ; 3735928559
            ..........
            from.opcode 'push1
            => 33
        """:
            #=======================================================
            if (hadAttr("binary")):
                try:
                    push(newInteger(parseBinInt(x.s)))
                except ValueError:
                    push(VNULL)
            elif (hadAttr("hex")):
                try:
                    push(newInteger(parseHexInt(x.s)))
                except ValueError:
                    push(VNULL)
            elif (hadAttr("octal")):
                try:
                    push(newInteger(parseOctInt(x.s)))
                except ValueError:
                    push(VNULL)
            elif (hadAttr("opcode")):
                push(newInteger(int(parseOpcode(x.s))))
            else:
                push(x)

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

            # TODO(Converters\function) Verify safety of implicit `.inline`s
            #  labels: library, benchmark, open discussion
            if not inline:
                if canBeInlined(y):
                    inline = true

            var ret: Value
            var argTypes = initOrderedTable[string,ValueSpec]()

            if argBlock.countIt(it.kind == Type) > 0:
                var args: seq[string]
                var body: ValueArray

                var i = 0
                while i < argBlock.len:
                    let varName = argBlock[i]
                    args.add(argBlock[i].s)
                    argTypes[argBlock[i].s] = {}
                    if i+1 < argBlock.len and argBlock[i+1].kind == Type:
                        var typeArr: ValueArray

                        while i+1 < argBlock.len and argBlock[i+1].kind == Type:
                            typeArr.add(newWord("is?"))
                            typeArr.add(argBlock[i+1])
                            argTypes[varName.s].incl(argBlock[i+1].t)
                            typeArr.add(varName)
                            i += 1

                        body.add(newWord("ensure"))
                        if typeArr.len == 3:
                            body.add(newBlock(typeArr))
                        else:
                            body.add(newBlock(@[
                                newWord("any?"),
                                newWord("array"),
                                newBlock(typeArr)
                            ]))
                    else:
                        argTypes[varName.s].incl(Any)
                    i += 1

                var mainBody: ValueArray = y.a
                mainBody.insert(body)

                ret = newFunction(args,newBlock(mainBody),imports,exports,memoize,inline)
            else:
                if argBlock.len > 0:
                    for arg in argBlock:
                        argTypes[arg.s] = {Any}
                else:
                    argTypes[""] = {Nothing}
                ret = newFunction(argBlock.map((w)=>w.s),y,imports,exports,memoize,inline)

            ret.info = ValueInfo(kind: Function)

            if not y.data.isNil:
                if y.data.kind==Dictionary:

                    if (let descriptionData = y.data.d.getOrDefault("description", nil); not descriptionData.isNil):
                        ret.info.descr = descriptionData.s
                        ret.info.module = ""

                    if y.data.d.hasKey("options") and y.data.d["options"].kind==Dictionary:
                        var options = initOrderedTable[string,(ValueSpec,string)]()
                        for (k,v) in pairs(y.data.d["options"].d):
                            if v.kind==Type:
                                options[k] = ({v.t}, "")
                            elif v.kind==String:
                                options[k] = ({Logical}, v.s)
                            elif v.kind==Block:
                                var vspec: ValueSpec
                                var i = 0
                                while i < v.a.len and v.a[i].kind==Type:
                                    vspec.incl(v.a[i].t)
                                    i += 1
                                if v.a[i].kind==String:
                                    options[k] = (vspec, v.a[i].s)
                                else:
                                    options[k] = (vspec, "")

                        ret.info.attrs = options

                    if (let returnsData = y.data.d.getOrDefault("returns", nil); not returnsData.isNil):
                        if returnsData.kind==Type:
                            ret.info.returns = {returnsData.t}
                        else:
                            var returns: ValueSpec
                            for tp in returnsData.a:
                                returns.incl(tp.t)
                            ret.info.returns = returns

                    when defined(DOCGEN):
                        if (let exampleData = y.data.d.getOrDefault("example", nil); not exampleData.isNil):
                            ret.info.example = exampleData.s

            ret.info.args = argTypes

            push(ret)

    builtin "range",
        alias       = ellipsis,
        op          = opRange,
        rule        = InfixPrecedence,
        description = "get list of values in given range (inclusive)",
        args        = {
            "from"  : {Integer, Char},
            "to"    : {Integer, Floating, Char}
        },
        attrs       = {
            "step"  : ({Integer},"use step between range values")
        },
        returns     = {Range},
        example     = """
        """:
            #=======================================================
            var limX: int
            var limY: int
            var numeric = true
            var infinite = false

            if xKind == Integer: limX = x.i
            else:
                numeric = false
                limX = ord(x.c)

            var forward: bool

            if yKind == Integer: limY = y.i
            elif yKind == Floating:
                if y.f == Inf or y.f == NegInf:
                    infinite = true
                    if y.f == Inf: forward = true
                    else: forward = false
                else:
                    limY = int(y.f)
            else:
                limY = ord(y.c)

            var step = 1
            if checkAttr("step"):
                step = aStep.i
                if step < 0:
                    step = -step
                elif step == 0:
                    RuntimeError_RangeWithZeroStep()

            if not infinite:
                forward = limX < limY

            push newRange(limX, limY, step, infinite, numeric, forward)

    when not defined(WEB):
        builtin "store",
            alias       = unaliased,
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "create or load a persistent store on disk",
            args        = {
                "path"  : {Literal,String}
            },
            attrs       = {
                "deferred"  : ({Logical},"save to disk only on program termination"),
                "global"    : ({Logical},"save as global store"),
                "native"    : ({Logical},"force native/Arturo format"),
                "json"      : ({Logical},"force Json format"),
                "db"        : ({Logical},"force database/SQlite format")
            },
            returns     = {Range},
            example     = """
            ; create a new store with the name `mystore`
            ; it will be automatically live-stored in a file in the same folder
            ; using the native Arturo format
            data: store "mystore"

            ; store some data
            data\name: "John"
            data\surname: "Doe"
            data\age: 36

            ; and let's retrieve our data
            data
            ; => [name:"John" surname:"Doe" age:36]
            ..........
            ; create a new "global" configuration store
            ; that will be saved automatically in ~/.arturo/stores
            globalStore: store.global "configuration"

            ; we are now ready to add or retrieve some persistent data!
            ..........
            ; create a new JSON store with the name `mystore`
            ; it will be automatically live-stored in a file in the same folder
            ; with the name `mystore.json`
            data: store.json "mystore"

            ; store some data
            da\people: []

            ; data can be as complicated as in any normal dictionary
            da\people: da\people ++ #[name: "John" surname: "Doe"]

            ; check some specific store value
            da\people\0\name
            ; => "John"
            ..........
            ; create a new deferred store with the name `mystore`
            ; it will be automatically saved in a file in the same folder
            ; using the native Arturo format
            defStore: store.deferred "mystore"

            ; let's save some data
            defStore\name: "John"
            defStore\surname: "Doe"

            ; and print it
            print defStore
            ; [name:John surname:Doe]

            ; in this case, all data is available at any given moment
            ; but will not be saved to disk for each and every operation;
            ; instead, it will be saved in its totality just before
            ; the program terminates!
            """:
                #=======================================================
                let isGlobal = hadAttr("global")
                let isAutosave = not hadAttr("deferred")

                var storeKind = UndefinedStore

                let isNative = hadAttr("native")
                let isJson = hadAttr("json")
                let isSqlite = hadAttr("db")

                if isNative:
                    storeKind = NativeStore
                elif isJson:
                    storeKind = JsonStore
                elif isSqlite:
                    storeKind = SqliteStore

                let store = initStore(
                    x.s,
                    doLoad = true,
                    forceExtension = true,
                    global = isGlobal,
                    autosave = isAutosave,
                    kind = storeKind
                )

                push newStore(store)

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
            if y.kind == Block:
                Converters.currentBuiltinName = currentBuiltinName

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

#=======================================
# Add Library
#=======================================

Libraries.add(defineLibrary)
