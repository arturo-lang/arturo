######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: library/Collections.nim
######################################################

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import oids

import algorithm, os, random, sequtils
import strutils, sugar, unicode
    

import helpers/arrays
import helpers/combinatorics
import helpers/regex
import helpers/strings
import helpers/unisort

import vm/exec
import vm/lib

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Collections"

    builtin "append",
        alias       = doubleplus, 
        rule        = InfixPrecedence,
        description = "append value to given collection",
        args        = {
            "collection"    : {String,Char,Block,Literal},
            "value"         : {Any}
        },
        attrs       = NoAttrs,
        returns     = {String,Block,Nothing},
        example     = """
            append "hell" "o"         ; => "hello"
            append [1 2 3] 4          ; => [1 2 3 4]
            append [1 2 3] [4 5]      ; => [1 2 3 4 5]
            ..........
            print "hell" ++ "o!"      ; hello!             
            print [1 2 3] ++ 4 ++ 5   ; [1 2 3 4 5]
            ..........
            a: "hell"
            append 'a "o"
            print a                   ; hello
            ..........
            b: [1 2 3]
            'b ++ 4
            print b                   ; [1 2 3 4]
        """:
            ##########################################################
            if x.kind==Literal:
                if InPlace.kind==String:
                    if y.kind==String:
                        InPlaced.s &= y.s
                    elif y.kind==Char:
                        InPlaced.s &= $(y.c)
                elif InPlaced.kind==Char:
                    if y.kind==String:
                        SetInPlace(newString($(InPlaced.c) & y.s))
                    elif y.kind==Char:
                        SetInPlace(newString($(InPlaced.c) & $(y.c)))
                else:
                    if y.kind==Block:
                        for item in cleanBlock(y.a):
                            InPlaced.a.add(item)
                    else:
                        InPlaced.a.add(y)
            else:
                if x.kind==String:
                    if y.kind==String:
                        push(newString(x.s & y.s))
                    elif y.kind==Char:
                        push(newString(x.s & $(y.c)))  
                elif x.kind==Char:
                    if y.kind==String:
                        push(newString($(x.c) & y.s))
                    elif y.kind==Char:
                        push(newString($(x.c) & $(y.c)))          
                else:
                    var ret = newBlock(cleanBlock(x.a))

                    if y.kind==Block:
                        for item in cleanBlock(y.a):
                            ret.a.add(item)
                    else:
                        ret.a.add(y)
                        
                    push(ret)

    builtin "chop",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "remove last item from given collection",
        args        = {
            "collection"    : {String,Block,Literal}
        },
        attrs       = NoAttrs,
        returns     = {String,Block,Nothing},
        example     = """
            print chop "books"          ; book
            print chop chop "books"     ; boo
            ..........
            str: "books"
            chop 'str                   ; str: "book"
            ..........
            chop [1 2 3 4]              ; => [1 2 3]
        """:
            ##########################################################
            if x.kind==Literal:
                if InPlace.kind==String:
                    InPlaced.s = InPlaced.s[0..^2]
                elif InPlaced.kind==Block:
                    if InPlaced.a.len > 0:
                        InPlaced.a = InPlaced.a[0..^2]
            else:
                if x.kind==String:
                    push(newString(x.s[0..^2]))
                elif x.kind==Block:
                    let blk = cleanBlock(x.a)
                    if blk.len == 0: push(newBlock())
                    else: push(newBlock(blk[0..^2]))

    builtin "combine",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get all possible combinations of the elements in given collection",
        args        = {
            "collection"    : {Block}
        },
        attrs       = {
            "by"        : ({Integer},"define size of each set"),
            "repeated"  : ({Logical},"allow for combinations with repeated elements"),
            "count"     : ({Logical},"just count the number of combinations")
        },
        returns     = {Block,Integer},
        example     = """
            combine [A B C]
            ; => [[A B C]]

            combine.repeated [A B C]
            ; => [[A A A] [A A B] [A A C] [A B B] [A B C] [A C C] [B B B] [B B C] [B C C] [C C C]]
            ..........
            combine.by:2 [A B C] 
            ; => [[A B] [A C] [B C]]

            combine.repeated.by:2 [A B C]
            ; => [[A A] [A B] [A C] [B B] [B C] [C C]]
            ..........
            combine.count [A B C]
            ; => 1

            combine.count.repeated.by:2 [A B C]
            ; => 6
        """:
            ##########################################################
            let doRepeat = popAttr("repeated")!=VNULL

            let blk = cleanBlock(x.a)

            var sz = blk.len
            if (let aBy = popAttr("by"); aBy != VNULL):
                if aBy.i > 0 and aBy.i < sz:
                    sz = aBy.i

            if popAttr("count")!=VNULL:
                push(countCombinations(blk, sz, doRepeat))
            else:
                push(newBlock(getCombinations(blk, sz, doRepeat).map((z)=>newBlock(z))))

    builtin "contains?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if collection contains given value",
        args        = {
            "collection"    : {String,Block,Dictionary},
            "value"         : {Any}
        },
        attrs       = {
            "at"    : ({Integer},"check at given location within collection")
        },
        returns     = {String,Block,Dictionary,Nothing},
        example     = """
            arr: [1 2 3 4]
            
            contains? arr 5             ; => false
            contains? arr 2             ; => true
            ..........
            user: #[
                name: "John"
                surname: "Doe"
            ]
            
            contains? dict "John"       ; => true
            contains? dict "Paul"       ; => false
            
            contains? keys dict "name"  ; => true
            ..........
            contains? "hello" "x"       ; => false
            contains? "hello" `h`       ; => true
            ..........
            contains?.at:1 "hello" "el" ; => true
            contains?.at:4 "hello" `o`  ; => true
            ..........
            print contains?.at:2 ["one" "two" "three"] "two"
            ; false

            print contains?.at:1 ["one" "two" "three"] "two"
            ; true
        """:
            ##########################################################
            if (let aAt = popAttr("at"); aAt != VNULL):
                let at = aAt.i
                case x.kind:
                    of String:
                        if y.kind==Regex:
                            push(newLogical(x.s.contains(y.rx, at)))
                        elif y.kind==Char:
                            push(newLogical(toRunes(x.s)[at] == y.c))
                        else:
                            push(newLogical(x.s.continuesWith(y.s, at)))
                    of Block:
                        push(newLogical(cleanBlock(x.a)[at] == y))
                    of Dictionary: 
                        let values = toSeq(x.d.values)
                        push(newLogical(values[at] == y))
                    else:
                        discard
            else:
                case x.kind:
                    of String:
                        if y.kind==Regex:
                            push(newLogical(x.s.contains(y.rx)))
                        elif y.kind==Char:
                            push(newLogical($(y.c) in x.s))
                        else:
                            push(newLogical(y.s in x.s))
                    of Block:
                        push(newLogical(y in cleanBlock(x.a)))
                    of Dictionary: 
                        let values = toSeq(x.d.values)
                        push(newLogical(y in values))
                    else:
                        discard

    builtin "couple",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get combination of elements in given collections as array of tuples",
        args        = {
            "collectionA"   : {Block},
            "collectionB"   : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Block},
        example     = """
            couple ["one" "two" "three"] [1 2 3]
            ; => [[1 "one"] [2 "two"] [3 "three"]]
        """:
            ##########################################################
            push(newBlock(zip(cleanBlock(x.a),cleanBlock(y.a)).map((z)=>newBlock(@[z[0],z[1]]))))

    builtin "decouple",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get tuple of collections from a coupled collection of tuples",
        args        = {
            "collection"    : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Block},
        example     = """
            c: couple ["one" "two" "three"] [1 2 3]
            ; c: [[1 "one"] [2 "two"] [3 "three"]]

            decouple c
            ; => ["one" "two" "three"] [1 2 3]
        """:
            ##########################################################
            let res = unzip(cleanBlock(x.a).map((z)=>(z.a[0],z.a[1])))
            push(newBlock(@[newBlock(res[0]), newBlock(res[1])]))

    builtin "drop",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "drop first *number* of elements from given collection and return the remaining ones",
        args        = {
            "collection"    : {String,Block,Literal},
            "number"        : {Integer}
        },
        attrs       = NoAttrs,
        returns     = {String,Block,Nothing},
        example     = """
            str: drop "some text" 5
            print str                     ; text
            ..........
            arr: 1..10
            drop 'arr 3                   ; arr: [4 5 6 7 8 9 10]
        """:
            ##########################################################
            if x.kind==Literal:
                if InPlace.kind==String:
                    InPlaced.s = InPlaced.s[y.i..^1]
                elif InPlaced.kind==Block:
                    if InPlaced.a.len > 0:
                        InPlaced.a = InPlaced.a[y.i..^1]
            else:
                if x.kind==String:
                    push(newString(x.s[y.i..^1]))
                elif x.kind==Block:
                    let blk = cleanBlock(x.a)
                    if blk.len == 0: push(newBlock())
                    else: push(newBlock(blk[y.i..^1]))

    builtin "empty",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "empty given collection",
        args        = {
            "collection"    : {Literal}
        },
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            a: [1 2 3]
            empty 'a              ; a: []
            ..........
            str: "some text"
            empty 'str            ; str: ""
        """:
            ##########################################################
            case InPlace.kind:
                of String: InPlaced.s = ""
                of Block: InPlaced.a = @[]
                of Dictionary: InPlaced.d = initOrderedTable[string,Value]()
                else: discard

    builtin "empty?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if given collection is empty",
        args        = {
            "collection"    : {String,Block,Dictionary,Null}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            empty? ""             ; => true
            empty? []             ; => true
            empty? #[]            ; => true
            
            empty? [1 "two" 3]    ; => false
        """:
            ##########################################################
            case x.kind:
                of Null: push(VTRUE)
                of String: push(newLogical(x.s==""))
                of Block: push(newLogical(cleanBlock(x.a).len==0))
                of Dictionary: push(newLogical(x.d.len==0))
                else: discard

    builtin "extend",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get new dictionary by merging given ones",
        args        = {
            "parent"        : {Dictionary},
            "additional"    : {Dictionary}
        },
        attrs       = NoAttrs,
        returns     = {Dictionary},
        example     = """
            person: #[ name: "john" surname: "doe" ]

            print extend person #[ age: 35 ]
            ; [name:john surname:doe age:35]
        """:
            ##########################################################
            if x.kind==Literal:
                discard InPlace
                for k,v in pairs(y.d):
                    InPlaced.d[k] = v
            else:
                var res = copyValue(x)
                for k,v in pairs(y.d):
                    res.d[k] = v

                push(res)

    builtin "first",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "return the first item of the given collection",
        args        = {
            "collection"    : {String,Block}
        },
        attrs       = {
            "n"     : ({Integer},"get first *n* items")
        },
        returns     = {Any,Null},
        example     = """
            print first "this is some text"       ; t
            print first ["one" "two" "three"]     ; one
            ..........
            print first.n:2 ["one" "two" "three"] ; one two
        """:
            ##########################################################
            if (let aN = popAttr("n"); aN != VNULL):
                if x.kind==String: 
                    if x.s.len==0: push(newString(""))
                    else: push(newString(x.s[0..aN.i-1]))
                else: 
                    let blk = cleanBlock(x.a)
                    if blk.len==0: push(newBlock())
                    else: push(newBlock(blk[0..aN.i-1]))
            else:
                if x.kind==String: 
                    if x.s.len==0: push(VNULL)
                    else: push(newChar(x.s.runeAt(0)))
                else: 
                    let blk = cleanBlock(x.a)
                    if blk.len==0: push(VNULL)
                    else: push(blk[0])

    builtin "flatten",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "flatten given collection by eliminating nested blocks",
        args        = {
            "collection"    : {Block},

        },
        attrs       = {
            "once"  : ({Logical},"do not perform recursive flattening")
        },
        returns     = {Block},
        example     = """
            arr: [[1 2 3] [4 5 6]]
            print flatten arr
            ; 1 2 3 4 5 6
            ..........
            arr: [[1 2 3] [4 5 6]]
            flatten 'arr
            ; arr: [1 2 3 4 5 6]
            ..........
            flatten [1 [2 3] [4 [5 6]]]
            ; => [1 2 3 4 5 6]
            ..........
            flatten.once [1 [2 3] [4 [5 6]]]
            ; => [1 2 3 4 [5 6]]
        """:
            ##########################################################
            if x.kind==Literal:
                InPlace = InPlaced.flattened(once = popAttr("once")!=VNULL)
            else:
                push(x.flattened(once = popAttr("once")!=VNULL))

    builtin "get",
        alias       = unaliased, 
        rule        = InfixPrecedence,
        description = "get collection's item by given index",
        args        = {
            "collection"    : {String,Block,Dictionary,Date},
            "index"         : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Any},
        example     = """
            user: #[
                name: "John"
                surname: "Doe"
            ]
            
            print user\name               ; John
            
            print get user 'surname       ; Doe
            print user\surname            ; Doe
            ..........
            arr: ["zero" "one" "two"]
            
            print arr\1                   ; one
            
            print get arr 2               ; two
            y: 2
            print arr\[y]                 ; two
            ..........
            str: "Hello world!"
            
            print str\0                   ; H
            
            print get str 1               ; e
            z: 0
            print str\[z+1]               ; e
        """:
            ##########################################################
            var key: Value
            if y.kind==String or y.kind==Integer: 
                key = y
            elif y.kind==Block:
                discard execBlock(y)
                key = pop()
            else:
                key = newString($(y))

            case x.kind:
                of Block: push(GetArrayIndex(cleanBlock(x.a), key.i))
                of Dictionary: 
                    push(GetKey(x.d, $(key)))
                of String: push(newChar(x.s.runeAtPos(key.i)))
                of Date: 
                    push(GetKey(x.e, key.s))
                else: discard

    builtin "in?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if value exists in given collection",
        args        = {
            "value"         : {Any},
            "collection"    : {String,Block,Dictionary}
        },
        attrs       = NoAttrs,
        returns     = {String,Block,Dictionary,Nothing},
        example     = """
            arr: [1 2 3 4]
            
            in? 5 arr             ; => false
            in? 2 arr             ; => true
            ..........
            user: #[
                name: "John"
                surname: "Doe"
            ]
            
            in? "John" dict       ; => true
            in? "Paul" dict       ; => false
            
            in? "name" keys dict  ; => true
            ..........
            in? "x" "hello"       ; => false
            in? `h` "hello"       ; => true
        """:
            ##########################################################
            case y.kind:
                of String:
                    if x.kind==Regex:
                        push(newLogical(y.s.contains(x.rx)))
                    elif x.kind==Char:
                        push(newLogical($(x.c) in y.s))
                    else:
                        push(newLogical(x.s in y.s))
                of Block:
                    push(newLogical(x in y.a))
                of Dictionary: 
                    let values = toSeq(y.d.values)
                    push(newLogical(x in values))
                else:
                    discard

    builtin "index",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "return first index of value in given collection",
        args        = {
            "collection"    : {String,Block,Dictionary},
            "value"         : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Integer,String,Null},
        example     = """
            ind: index "hello" "e"
            print ind                 ; 1
            ..........
            print index [1 2 3] 3     ; 2
            ..........
            type index "hello" "x"
            ; :null
        """:
            ##########################################################
            case x.kind:
                of String:
                    let indx = x.s.find(y.s)
                    if indx != -1: push(newInteger(indx))
                    else: push(VNULL)
                of Block:
                    let indx = cleanBlock(x.a).find(y)
                    if indx != -1: push(newInteger(indx))
                    else: push(VNULL)
                of Dictionary:
                    var found = false
                    for k,v in pairs(x.d):
                        if v==y:
                            push(newString(k))
                            found=true
                            break

                    if not found:
                        push(VNULL)
                else: discard

    builtin "insert",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "insert value in collection at given index",
        args        = {
            "collection"    : {String,Block,Dictionary,Literal},
            "index"         : {Integer,String},
            "value"         : {Any}
        },
        attrs       = NoAttrs,
        returns     = {String,Block,Dictionary,Nothing},
        example     = """
            insert [1 2 3 4] 0 "zero"
            ; => ["zero" 1 2 3 4]
            
            print insert "heo" 2 "ll"
            ; hello
            ..........
            dict: #[
                name: John
            ]
            
            insert 'dict 'name "Jane"
            ; dict: [name: "Jane"]
        """:
            ##########################################################
            if x.kind==Literal:
                case InPlace.kind:
                    of String: InPlaced.s.insert(z.s, y.i)
                    of Block: InPlaced.a.insert(z, y.i)
                    of Dictionary:
                        InPlaced.d[y.s] = z
                    else: discard
            else:
                case x.kind:
                    of String: 
                        var copied = x.s
                        copied.insert(z.s, y.i)
                        push(newString(copied))
                    of Block: 
                        var copied = cleanBlock(x.a)
                        copied.insert(z, y.i)
                        push(newBlock(copied))
                    of Dictionary:
                        var copied = x.d
                        copied[y.s] = z
                        push(newDictionary(copied))
                    else: discard

    builtin "key?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if dictionary contains given key",
        args        = {
            "collection"    : {Dictionary},
            "key"           : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            user: #[
                name: "John"
                surname: "Doe"
            ]
            
            key? user 'age            ; => false
            if key? user 'name [
                print ["Hello" user\name]
            ]
            ; Hello John
        """:
            ##########################################################
            var needle: string
            if y.kind==String:
                needle = y.s
            else:
                needle = $(y)
            push(newLogical(x.d.hasKey(needle)))

    builtin "keys",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get list of keys for given dictionary",
        args        = {
            "dictionary"    : {Dictionary}
        },
        attrs       = NoAttrs,
        returns     = {Block},
        example     = """
            user: #[
                name: "John"
                surname: "Doe"
            ]
            
            keys user
            => ["name" "surname"]
        """:
            ##########################################################
            let s = toSeq(x.d.keys)
            push(newStringBlock(s))

    builtin "last",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "return the last item of the given collection",
        args        = {
            "collection"    : {String,Block}
        },
        attrs       = {
            "n"     : ({Integer},"get last *n* items")
        },
        returns     = {Any,Null},
        example     = """
            print last "this is some text"       ; t
            print last ["one" "two" "three"]     ; three
            ..........
            print last.n:2 ["one" "two" "three"] ; two three
        """:
            ##########################################################
            if (let aN = getAttr("n"); aN != VNULL):
                if x.kind==String: 
                    if x.s.len==0: push(newString(""))
                    else: push(newString(x.s[x.s.len-aN.i..^1]))
                else: 
                    let blk = cleanBlock(x.a)
                    if blk.len==0: push(newBlock())
                    else: push(newBlock(blk[blk.len-aN.i..^1]))
            else:
                if x.kind==String: 
                    if x.s.len==0: push(VNULL)
                    else: push(newChar(toRunes(x.s)[^1]))
                else: 
                    let blk = cleanBlock(x.a)
                    if blk.len==0: push(VNULL)
                    else: push(blk[blk.len-1])

    builtin "max",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get maximum element in given collection",
        args        = {
            "collection"    : {Block}
        },
        attrs       = {
            "index" : ({Logical},"retrieve index of maximum element"),
        },
        returns     = {Any,Null},
        example     = """
            print max [4 2 8 5 1 9]       ; 9
        """:
            ##########################################################
            let blk = cleanBlock(x.a)
            if blk.len==0: push(VNULL)
            else:
                var maxElement = blk[0]
                if (popAttr("index")!=VNULL):
                    var maxIndex = 0
                    var i = 1
                    while i < blk.len:
                        if (blk[i]>maxElement):
                            maxElement = blk[i]
                            maxIndex = i
                        inc(i)

                    push(newInteger(maxIndex))
                else:
                    var i = 1
                    while i < blk.len:
                        if (blk[i]>maxElement):
                            maxElement = blk[i]
                        inc(i)

                    push(maxElement)

    builtin "min",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get minimum element in given collection",
        args        = {
            "collection"    : {Block}
        },
        attrs       = {
            "index" : ({Logical},"retrieve index of minimum element"),
        },
        returns     = {Any,Null},
        example     = """
            print min [4 2 8 5 1 9]       ; 1
        """:
            ##########################################################
            let blk = cleanBlock(x.a)
            if blk.len==0: push(VNULL)
            else:
                var minElement = blk[0]
                var minIndex = 0
                if (popAttr("index")!=VNULL):
                    var i = 1
                    while i < blk.len:
                        if (blk[i]<minElement):
                            minElement = blk[i]
                            minIndex = i
                        inc(i)
                        
                    push(newInteger(minIndex))
                else:
                    var i = 1
                    while i < blk.len:
                        if (blk[i]<minElement):
                            minElement = blk[i]
                        inc(i)
                        
                    push(minElement)

    builtin "permutate",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get all possible permutations of the elements in given collection",
        args        = {
            "collection"    : {Block}
        },
        attrs       = {
            "by"        : ({Integer},"define size of each set"),
            "repeated"  : ({Logical},"allow for permutations with repeated elements"),
            "count"     : ({Logical},"just count the number of permutations")
        },
        returns     = {Block},
        example     = """
            permutate [A B C]
            ; => [[A B C] [A C B] [B A C] [B C A] [C A B] [C B A]]

            permutate.repeated [A B C]
            ; => [[A A A] [A A B] [A A C] [A B A] [A B B] [A B C] [A C A] [A C B] [A C C] [B A A] [B A B] [B A C] [B B A] [B B B] [B B C] [B C A] [B C B] [B C C] [C A A] [C A B] [C A C] [C B A] [C B B] [C B C] [C C A] [C C B] [C C C]]
            ..........
            permutate.by:2 [A B C] 
            ; => [[A B] [A C] [B A] [B C] [C A] [C B]]

            permutate.repeated.by:2 [A B C]
            ; => [[A A] [A B] [A C] [B A] [B B] [B C] [C A] [C B] [C C]]
            ..........
            permutate.count [A B C]
            ; => 6

            permutate.count.repeated.by:2 [A B C]
            ; => 9
        """:
            ##########################################################
            let doRepeat = popAttr("repeated")!=VNULL

            let blk = cleanBlock(x.a)

            var sz = blk.len
            if (let aBy = popAttr("by"); aBy != VNULL):
                if aBy.i > 0 and aBy.i < sz:
                    sz = aBy.i

            if popAttr("count")!=VNULL:
                push(countPermutations(blk, sz, doRepeat))
            else:
                push(newBlock(getPermutations(blk, sz, doRepeat).map((z)=>newBlock(z))))

    builtin "remove",
        alias       = doubleminus, 
        rule        = InfixPrecedence,
        description = "remove value from given collection",
        args        = {
            "collection"    : {String,Block,Dictionary,Literal},
            "value"         : {Any}
        },
        attrs       = {
            "key"   : ({Logical},"remove dictionary key"),
            "once"  : ({Logical},"remove only first occurence"),
            "index" : ({Logical},"remove specific index"),
            "prefix": ({Logical},"remove first matching prefix from string"),
            "suffix": ({Logical},"remove first matching suffix from string")
        },
        returns     = {String,Block,Dictionary,Nothing},
        example     = """
            remove "hello" "l"        ; => "heo"
            print "hello" -- "l"      ; heo
            ..........
            str: "mystring"
            remove 'str "str"         
            print str                 ; mying
            ..........
            print remove.once "hello" "l"
            ; helo
            ..........
            remove [1 2 3 4] 4        ; => [1 2 3]
        """:
            ##########################################################
            if x.kind==Literal:
                if InPlace.kind==String:
                    if (popAttr("once") != VNULL):
                        SetInPlace(newString(InPlaced.s.removeFirst(y.s)))
                    elif (popAttr("prefix") != VNULL):
                        InPlace.s.removePrefix(y.s)
                    elif (popAttr("suffix") != VNULL):
                        InPlace.s.removeSuffix(y.s)
                    else:
                        SetInPlace(newString(InPlaced.s.removeAll(y)))
                elif InPlaced.kind==Block: 
                    if (popAttr("once") != VNULL):
                        SetInPlace(newBlock(InPlaced.a.removeFirst(y)))
                    elif (popAttr("index") != VNULL):
                        SetInPlace(newBlock(InPlaced.a.removeByIndex(y.i)))
                    else:
                        SetInPlace(newBlock(InPlaced.a.removeAll(y)))
                elif InPlaced.kind==Dictionary:
                    let key = (popAttr("key") != VNULL)
                    if (popAttr("once") != VNULL):
                        SetInPlace(newDictionary(InPlaced.d.removeFirst(y, key)))
                    else:
                        SetInPlace(newDictionary(InPlaced.d.removeAll(y, key)))
            else:
                if x.kind==String:
                    if (popAttr("once") != VNULL):
                        push(newString(x.s.removeFirst(y.s)))
                    elif (popAttr("prefix") != VNULL):
                        var ret = x.s
                        ret.removePrefix(y.s)
                        push(newString(ret))
                    elif (popAttr("suffix") != VNULL):
                        var ret = x.s
                        ret.removeSuffix(y.s)
                        push(newString(ret))
                    else:
                        push(newString(x.s.removeAll(y)))
                elif x.kind==Block: 
                    if (popAttr("once") != VNULL):
                        push(newBlock(cleanBlock(x.a).removeFirst(y)))
                    elif (popAttr("index") != VNULL):
                        push(newBlock(cleanBlock(x.a).removeByIndex(y.i)))
                    else:
                        push(newBlock(cleanBlock(x.a).removeAll(y)))
                elif x.kind==Dictionary:
                    let key = (popAttr("key") != VNULL)
                    if (popAttr("once") != VNULL):
                        push(newDictionary(x.d.removeFirst(y, key)))
                    else:
                        push(newDictionary(x.d.removeAll(y, key)))

    builtin "repeat",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "repeat value the given number of times and return new one",
        args        = {
            "value" : {Any,Literal},
            "times" : {Integer}
        },
        attrs       = NoAttrs,
        returns     = {String,Block},
        example     = """
            print repeat "hello" 3
            ; hellohellohello
            ..........
            repeat [1 2 3] 3
            ; => [1 2 3 1 2 3 1 2 3]
            ..........
            repeat 5 3
            ; => [5 5 5]
            ..........
            repeat [[1 2 3]] 3
            ; => [[1 2 3] [1 2 3] [1 2 3]]
        """:
            ##########################################################
            if x.kind==Literal:
                if InPlace.kind==String:
                    SetInPlace(newString(InPlaced.s.repeat(y.i)))
                elif InPlaced.kind==Block:
                    SetInPlace(newBlock(InPlaced.a.cycle(y.i)))
                else:
                    SetInPlace(newBlock(InPlaced.repeat(y.i)))
            else:
                if x.kind==String:
                    push(newString(x.s.repeat(y.i)))
                elif x.kind==Block:
                    push(newBlock(safeCycle(cleanBlock(x.a), y.i)))
                else:
                    push(newBlock(safeRepeat(x, y.i)))

    builtin "reverse",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "reverse given collection",
        args        = {
            "collection"    : {String,Block,Literal}
        },
        attrs       = NoAttrs,
        returns     = {String,Block,Nothing},
        example     = """
            print reverse [1 2 3 4]           ; 4 3 2 1
            print reverse "Hello World"       ; dlroW olleH
            ..........
            str: "my string"
            reverse 'str
            print str                         ; gnirts ym
        """:
            ##########################################################
            proc reverse(s: var string) =
                for i in 0 .. s.high div 2:
                    swap(s[i], s[s.high - i])
        
            proc reversed(s: string): string =
                result = newString(s.len)
                for i,c in s:
                    result[s.high - i] = c

            if x.kind==Literal:
                if InPlace.kind==String:
                    InPlaced.s.reverse()
                else:
                    InPlaced.a.reverse()
            else:
                if x.kind==Block: push(newBlock(cleanBlock(x.a).reversed))
                elif x.kind==String: push(newString(x.s.reversed))

    builtin "rotate",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "right-rotate collection by given distance",
        args        = {
            "collection"    : {String,Block,Literal},
            "distance"      : {Integer}
        },
        attrs       = {
            "left"  : ({Logical},"left rotation")
        },
        returns     = {String,Block,Nothing},
        example     = """
            rotate [a b c d e] 1            ; => [e a b c d]
            rotate.left [a b c d e] 1       ; => [b c d e a]

            rotate 1..6 4                   ; => [3 4 5 6 1 2]
        """:
            ##########################################################
            let distance = if (popAttr("left")==VNULL): -y.i else: y.i

            if x.kind==Literal:
                if InPlace.kind==String:
                    InPlaced = newString(toSeq(runes(x.s)).map((x) => $(x)).rotatedLeft(distance).join(""))
                elif InPlaced.kind==Block:
                    InPlaced.a.rotateLeft(distance)
            else:
                if x.kind==String:
                    push(newString(toSeq(runes(x.s)).map((x) => $(x)).rotatedLeft(distance).join("")))
                elif x.kind==Block:
                    push(newBlock(cleanBlock(x.a).rotatedLeft(distance)))

    builtin "sample",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get a random element from given collection",
        args        = {
            "collection"    : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Any, Null},
        example     = """
            sample [1 2 3]        ; (return a random number from 1 to 3)
            print sample ["apple" "appricot" "banana"]
            ; apple
        """:
            ##########################################################
            let blk = cleanBlock(x.a)
            if blk.len == 0: push(VNULL)
            else: push(sample(blk))

    builtin "set",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "set collection's item at index to given value",
        args        = {
            "collection"    : {String,Block,Dictionary},
            "index"         : {Any},
            "value"         : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            myDict: #[ 
                name: "John"
                age: 34
            ]
            
            set myDict 'name "Michael"        ; => [name: "Michael", age: 34]
            ..........
            arr: [1 2 3 4]
            set arr 0 "one"                   ; => ["one" 2 3 4]

            arr\1: "dos"                      ; => ["one" "dos" 3 4]

            x: 2    
            arr\[x]: "tres"                   ; => ["one" "dos" "tres" 4]
            ..........
            str: "hello"
            str\0: `x`
            print str
            ; xello
        """:
            ##########################################################
            var key: Value
            if y.kind==String or y.kind==Integer: 
                key = y
            elif y.kind==Block:
                discard execBlock(y)
                key = pop()
            else:
                key = newString($(y))

            case x.kind:
                of Block: 
                    cleanBlock(x.a, inplace=true)
                    SetArrayIndex(x.a, key.i, z)
                of Dictionary:
                    x.d[$(key)] = z
                of String:
                    var res: string = ""
                    var idx = 0
                    for r in x.s.runes:
                        if idx!=key.i: res.add r
                        else: res.add z.c
                        idx += 1

                    x.s = res
                else: discard

    builtin "shuffle",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get given collection shuffled",
        args        = {
            "collection"    : {Block,Literal}
        },
        attrs       = NoAttrs,
        returns     = {Block,Nothing},
        example     = """
            shuffle [1 2 3 4 5 6]         ; => [1 5 6 2 3 4 ]
            ..........
            arr: [2 5 9]
            shuffle 'arr
            print arr                     ; 5 9 2
        """:
            ##########################################################
            if x.kind==Literal:
                InPlace.a.shuffle()
            else:
                push(newBlock(cleanBlock(x.a).dup(shuffle)))

    builtin "size",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get size/length of given collection",
        args        = {
            "collection"    : {String,Block,Dictionary}
        }, 
        attrs       = NoAttrs,
        returns     = {Integer},
        example     = """
            arr: ["one" "two" "three"]
            print size arr                ; 3
            ..........
            dict: #[name: "John", surname: "Doe"]
            print size dict               ; 2
            ..........
            str: "some text"      
            print size str                ; 9
            
            print size "你好!"              ; 3
        """:
            ##########################################################
            if x.kind==String:
                push(newInteger(runeLen(x.s)))
            elif x.kind==Dictionary:
                push(newInteger(x.d.len))
            else:
                push(newInteger(cleanBlock(x.a).len))
            
    builtin "slice",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get a slice of collection between given indices",
        args        = {
            "collection"    : {String,Block},
            "from"          : {Integer},
            "to"            : {Integer}
        },
        attrs       = NoAttrs,
        returns     = {String,Block},
        example     = """
            slice "Hello" 0 3             ; => "Hell"
            ..........
            print slice 1..10 3 4         ; 4 5
        """:
            ##########################################################
            if x.kind==String:
                if x.s.len==0: push(newString(""))
                else:
                    if y.i >= 0 and z.i <= x.s.runeLen:
                        push(newString(x.s.runeSubStr(y.i,z.i-y.i+1)))
                    else:
                        push(newString(""))
            else:
                let blk = cleanBlock(x.a)
                if y.i >= 0 and z.i <= blk.len-1:
                    push(newBlock(blk[y.i..z.i]))
                else:
                    push(newBlock())

    builtin "sort",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "sort given block in ascending order",
        args        = {
            "collection"    : {Block,Dictionary,Literal}
        },
        attrs       = {
            "as"        : ({Literal},"localized by ISO 639-1 language code"),
            "sensitive" : ({Logical},"case-sensitive sorting"),
            "descending": ({Logical},"sort in ascending order"),
            "values"    : ({Logical},"sort dictionary by values"),
            "by"        : ({String,Literal},"sort array of dictionaries by given key")
        },
        returns     = {Block,Nothing},
        example     = """
            a: [3 1 6]
            print sort a                  ; 1 3 6
            ..........
            print sort.descending a       ; 6 3 1
            ..........
            b: ["one" "two" "three"]
            sort 'b
            print b                       ; one three two
        """:
            ##########################################################
            var sortOrdering = SortOrder.Ascending

            if (popAttr("descending")!=VNULL):
                sortOrdering = SortOrder.Descending

            if x.kind==Block: 
                let blk = cleanBlock(x.a)
                if blk.len==0: push(newBlock())
                else:
                    if (let aBy = popAttr("by"); aBy != VNULL):
                        var sorted: ValueArray = blk.sorted(
                            proc (v1, v2: Value): int = 
                                cmp(v1.d[aBy.s], v2.d[aBy.s]), order=sortOrdering)
                        push(newBlock(sorted))
                    else:
                        if (let aAs = popAttr("as"); aAs != VNULL):
                            push(newBlock(blk.unisorted(aAs.s, sensitive = popAttr("sensitive")!=VNULL, order = sortOrdering)))
                        else:
                            if (popAttr("sensitive")!=VNULL):
                                push(newBlock(blk.unisorted("en", sensitive=true, order = sortOrdering)))
                            else:
                                if blk[0].kind==String:
                                    push(newBlock(blk.unisorted("en", order = sortOrdering)))
                                else:
                                    push(newBlock(blk.sorted(order = sortOrdering)))

            elif x.kind==Dictionary:
                var sorted = x.d
                if (popAttr("values") != VNULL):
                    sorted.sort(proc (x, y: (string, Value)): int = cmp(x[1], y[1]), order=sortOrdering)
                else:
                    sorted.sort(system.cmp, order=sortOrdering)
                
                push(newDictionary(sorted))

            else: 
                if InPlace.kind==Block:
                    if InPlace.a.len > 0:
                        if (let aBy = popAttr("by"); aBy != VNULL):
                            InPlaced.a.sort(
                                proc (v1, v2: Value): int = 
                                    cmp(v1.d[aBy.s], v2.d[aBy.s]), order=sortOrdering)
                        else:
                            if (let aAs = popAttr("as"); aAs != VNULL):
                                InPlaced.a.unisort(aAs.s, sensitive = popAttr("sensitive")!=VNULL, order = sortOrdering)
                            else:
                                if (popAttr("sensitive")!=VNULL):
                                    InPlaced.a.unisort("en", sensitive=true, order = sortOrdering)
                                else:
                                    if InPlace.a[0].kind==String:
                                        InPlaced.a.unisort("en", order = sortOrdering)
                                    else:
                                        InPlaced.a.sort(order = sortOrdering)
                else:
                    if (popAttr("values") != VNULL):
                        InPlaced.d.sort(proc (x, y: (string,Value)): int = cmp(x[1], y[1]), order=sortOrdering)
                    else:
                        InPlaced.d.sort(system.cmp, order=sortOrdering)

    builtin "sorted?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if given collection is already sorted",
        args        = {
            "collection"    : {Block}
        },
        attrs       = {
            "descending": ({Logical},"check for sorting in ascending order")
        },
        returns     = {Logical},
        example     = """
            sorted? [1 2 3 4 5]         ; => true
            sorted? [4 3 2 1 5]         ; => false
            sorted? [5 4 3 2 1]         ; => false
            ..........
            sorted?.descending [5 4 3 2 1]      ; => true
            sorted?.descending [4 3 2 1 5]      ; => false
            sorted?.descending [1 2 3 4 5]      ; => false
        """:
            ##########################################################
            var ascending = true

            if (popAttr("descending")!=VNULL):
                ascending = false

            push newLogical(isSorted(x.a, ascending = ascending))

            
    # TODO(Collections\split) Add better support for unicode strings
    #  Currently, simple split works fine - but using different attributes (at, every, by, etc) doesn't
    #  labels: library,bug
    builtin "split",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "split collection to components",
        args        = {
            "collection"    : {String,Block,Literal}
        },
        attrs       = {
            "words"     : ({Logical},"split string by whitespace"),
            "lines"     : ({Logical},"split string by lines"),
            "by"        : ({String,Regex,Block},"split using given separator"),
            "at"        : ({Integer},"split collection at given position"),
            "every"     : ({Integer},"split collection every *n* elements"),
            "path"      : ({Logical},"split path components in string")
        },
        returns     = {Block,Nothing},
        example     = """
            split "hello"                 ; => [`h` `e` `l` `l` `o`]
            ..........
            split.words "hello world"     ; => ["hello" "world"]
            ..........
            split.every: 2 "helloworld"
            ; => ["he" "ll" "ow" "or" "ld"]
            ..........
            split.at: 4 "helloworld"
            ; => ["hell" "oworld"]
            ..........
            arr: 1..9
            split.at:3 'arr
            ; => [ [1 2 3 4] [5 6 7 8 9] ]
        """:
            ##########################################################
            if x.kind==Literal:
                if InPlace.kind==String:
                    if (popAttr("words") != VNULL):
                        SetInPlace(newStringBlock(strutils.splitWhitespace(InPlaced.s)))
                    elif (popAttr("lines") != VNULL):
                        SetInPlace(newStringBlock(InPlaced.s.splitLines()))
                    elif (popAttr("path") != VNULL):
                        SetInPlace(newStringBlock(InPlaced.s.split(DirSep)))
                    elif (let aBy = popAttr("by"); aBy != VNULL):
                        if aBy.kind==String:
                            SetInPlace(newStringBlock(InPlaced.s.split(aBy.s)))
                        elif aBy.kind==Regex:
                            SetInPlace(newStringBlock(InPlaced.s.split(aBy.rx)))
                        else:
                            SetInPlace(newStringBlock(toSeq(InPlaced.s.tokenize(aBy.a.map((k)=>k.s)))))
                    elif (let aAt = popAttr("at"); aAt != VNULL):
                        SetInPlace(newStringBlock(@[InPlaced.s[0..aAt.i-1], InPlaced.s[aAt.i..^1]]))
                    elif (let aEvery = popAttr("every"); aEvery != VNULL):
                        var ret: seq[string] = @[]
                        var length = InPlaced.s.len
                        var i = 0

                        while i<length:
                            ret.add(InPlaced.s[i..i+aEvery.i-1])
                            i += aEvery.i

                        SetInPlace(newStringBlock(ret))
                    else:
                        SetInPlace(newStringBlock(toSeq(runes(x.s)).map((x) => $(x))))
                else:
                    if (let aAt = popAttr("at"); aAt != VNULL):
                        SetInPlace(newBlock(@[newBlock(InPlaced.a[0..aAt.i]), newBlock(InPlaced.a[aAt.i..^1])]))
                    elif (let aEvery = popAttr("every"); aEvery != VNULL):
                        var ret: ValueArray = @[]
                        var length = InPlaced.a.len
                        var i = 0

                        while i<length:
                            ret.add(InPlaced.a[i..i+aEvery.i-1])
                            i += aEvery.i

                        SetInPlace(newBlock(ret))
                    else: discard

            elif x.kind==String:
                if (popAttr("words") != VNULL):
                    push(newStringBlock(strutils.splitWhitespace(x.s)))
                elif (popAttr("lines") != VNULL):
                    push(newStringBlock(x.s.splitLines()))
                elif (popAttr("path") != VNULL):
                    push(newStringBlock(x.s.split(DirSep)))
                elif (let aBy = popAttr("by"); aBy != VNULL):
                    if aBy.kind==String:
                        push(newStringBlock(x.s.split(aBy.s)))
                    elif aBy.kind==Regex:
                        push(newStringBlock(x.s.split(aBy.rx)))
                    else:
                        push(newStringBlock(toSeq(x.s.tokenize(aBy.a.map((k)=>k.s)))))
                elif (let aAt = popAttr("at"); aAt != VNULL):
                    push(newStringBlock(@[x.s[0..aAt.i-1], x.s[aAt.i..^1]]))
                elif (let aEvery = popAttr("every"); aEvery != VNULL):
                    var ret: seq[string] = @[]
                    var length = x.s.len
                    var i = 0

                    while i<length:
                        ret.add(x.s[i..i+aEvery.i-1])
                        i += aEvery.i

                    push(newStringBlock(ret))
                else:
                    push(newStringBlock(toSeq(runes(x.s)).map((x) => $(x))))
            else:
                let blk = cleanBlock(x.a)
                if (let aAt = popAttr("at"); aAt != VNULL):
                    push(newBlock(@[newBlock(blk[0..aAt.i-1]), newBlock(blk[aAt.i..^1])]))
                elif (let aEvery = popAttr("every"); aEvery != VNULL):
                    var ret: ValueArray = @[]
                    var length = blk.len
                    var i = 0

                    while i<length:
                        if i+aEvery.i > length:
                            ret.add(newBlock(blk[i..^1]))
                        else:
                            ret.add(newBlock(blk[i..i+aEvery.i-1]))

                        i += aEvery.i

                    push(newBlock(ret))
                else: push(x)

    builtin "squeeze",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "reduce adjacent elements in given collection",
        args        = {
            "collection"    : {String,Block,Literal}
        },
        attrs       = NoAttrs,
        returns     = {String,Block,Nothing},
        example     = """
            print squeeze [1 1 2 3 4 2 3 4 4 5 5 6 7]
            ; 1 2 3 4 2 3 4 5 6 7 
            ..........
            arr: [4 2 1 1 3 6 6]
            squeeze 'arr            ; a: [4 2 1 3 6]
            ..........
            print squeeze "hello world"
            ; helo world
        """:
            ##########################################################
            if x.kind==Literal:
                if InPlace.kind==String:
                    var i = 0
                    var ret = ""
                    while i<InPlaced.s.len:
                        ret &= $(InPlaced.s[i])
                        while (i+1<InPlaced.s.len and InPlaced.s[i+1]==x.s[i]):
                            i += 1
                        i += 1
                    SetInPlace(newString(ret))
                elif InPlaced.kind==Block:
                    var i = 0
                    var ret: ValueArray = @[]
                    while i<InPlaced.a.len:
                        ret.add(InPlaced.a[i])
                        while (i+1<InPlaced.a.len and InPlaced.a[i+1]==InPlaced.a[i]):
                            i += 1
                        i += 1
                    SetInPlace(newBlock(ret))
            else:
                if x.kind==String:
                    var i = 0
                    var ret = ""
                    while i<x.s.len:
                        ret &= $(x.s[i])
                        while (i+1<x.s.len and x.s[i+1]==x.s[i]):
                            i += 1
                        i += 1
                    push(newString(ret))
                elif x.kind==Block:
                    var i = 0
                    var ret: ValueArray = @[]
                    let blk = cleanBlock(x.a)
                    while i<blk.len:
                        ret.add(blk[i])
                        while (i+1<blk.len and blk[i+1]==blk[i]):
                            i += 1
                        i += 1
                    push(newBlock(ret))

    builtin "take",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "keep first <number> of elements from given collection and return the remaining ones",
        args        = {
            "collection"    : {String,Block,Literal},
            "number"        : {Integer}
        },
        attrs       = NoAttrs,
        returns     = {String,Block,Nothing},
        example     = """
            str: take "some text" 5
            print str                     ; some
            ..........
            arr: 1..10
            take 'arr 3                   ; arr: [1 2 3]
        """:
            ##########################################################
            var upperLimit = y.i-1
            if x.kind==Literal:
                if InPlace.kind==String:
                    if x.s.len > 0:
                        if upperLimit > InPlaced.s.len - 1:
                            upperLimit = InPlaced.s.len-1
                        InPlaced.s = InPlaced.s[0..upperLimit]
                elif InPlaced.kind==Block:
                    if InPlaced.a.len > 0:
                        if upperLimit > InPlaced.a.len - 1:
                            upperLimit = InPlaced.a.len-1
                        InPlaced.a = InPlaced.a[0..upperLimit]
            else:
                if x.kind==String:
                    if x.s.len==0: push(newString(""))
                    else: 
                        if upperLimit > x.s.len - 1:
                            upperLimit = x.s.len-1
                        push(newString(x.s[0..upperLimit]))
                elif x.kind==Block:
                    let blk = cleanBlock(x.a)
                    if blk.len==0: push(newBlock())
                    else: 
                        if upperLimit > x.a.len - 1:
                            upperLimit = x.a.len-1
                        push(newBlock(blk[0..upperLimit]))

    builtin "unique",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get given block without duplicates",
        args        = {
            "collection"    : {String,Block,Literal}
        },
        attrs       = {
            "id"    : ({Logical},"generate unique id using given prefix"),
        },
        returns     = {Block,Nothing},
        example     = """
            arr: [1 2 4 1 3 2]
            print unique arr              ; 1 2 4 3
            ..........
            arr: [1 2 4 1 3 2]
            unique 'arr
            print arr                     ; 1 2 4 3
        """:
            ##########################################################
            if (popAttr("id") != VNULL):
                # TODO(System\unique) make `.id` work for Web/JS builds
                #  labels: library,enhancement,web
                when not defined(WEB):
                    push newString(x.s & $(genOid()))
            else:
                if x.kind==Block: push(newBlock(cleanBlock(x.a).deduplicated()))
                else: InPlace.a = InPlaced.a.deduplicated()

    builtin "values",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get list of values for given dictionary",
        args        = {
            "dictionary"    : {Dictionary}
        },
        attrs       = NoAttrs,
        returns     = {Block},
        example     = """
            user: #[
                name: "John"
                surname: "Doe"
            ]
            
            values user
            => ["John" "Doe"]
        """:
            ##########################################################
            let s = toSeq(x.d.values)
            push(newBlock(s))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)