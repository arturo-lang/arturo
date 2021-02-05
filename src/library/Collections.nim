######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
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

import algorithm, random, sequtils, strutils, sugar, unicode
import nre except toSeq

import helpers/arrays as arraysHelper  
import helpers/unisort as unisortHelper 

import vm/[common, globals, stack, value]

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
            
            print "hell" ++ "o!"      ; hello!             
            print [1 2 3] ++ 4 ++ 5   ; [1 2 3 4 5]
            
            a: "hell"
            append 'a "o"
            print a                   ; hello
            
            b: [1 2 3]
            'b ++ 4
            print b                   ; [1 2 3 4]
        """:
            ##########################################################
            if x.kind==Literal:
                if Syms[x.s].kind==String:
                    if y.kind==String:
                        Syms[x.s].s &= y.s
                    elif y.kind==Char:
                        Syms[x.s].s &= $(y.c)
                elif Syms[x.s].kind==Char:
                    if y.kind==String:
                        Syms[x.s] = newString($(Syms[x.s].c) & y.s)
                    elif y.kind==Char:
                        Syms[x.s] = newString($(Syms[x.s].c) & $(y.c))
                else:
                    if y.kind==Block:
                        for item in y.a:
                            Syms[x.s].a.add(item)
                    else:
                        Syms[x.s].a.add(y)
            else:
                if x.kind==String:
                    if y.kind==String:
                        stack.push(newString(x.s & y.s))
                    elif y.kind==Char:
                        stack.push(newString(x.s & $(y.c)))  
                elif x.kind==Char:
                    if y.kind==String:
                        stack.push(newString($(x.c) & y.s))
                    elif y.kind==Char:
                        stack.push(newString($(x.c) & $(y.c)))          
                else:
                    var ret = newBlock(x.a)

                    if y.kind==Block:
                        for item in y.a:
                            ret.a.add(item)
                    else:
                        ret.a.add(y)
                        
                    stack.push(ret)

    builtin "combine",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get combination of elements in given collections",
        args        = {
            "collectionA"   : {Block},
            "collectionB"   : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Block},
        example     = """
            combine ["one" "two" "three"] [1 2 3]
            ; => [[1 "one"] [2 "two"] [3 "three"]]
        """:
            ##########################################################
            stack.push(newBlock(zip(x.a,y.a).map((z)=>newBlock(@[z[0],z[1]]))))

    builtin "contains?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if collection contains given value",
        args        = {
            "collection"    : {String,Block,Dictionary},
            "value"         : {Any}
        },
        attrs       = {
            "regex" : ({Boolean},"match against a regular expression")
        },
        returns     = {String,Block,Dictionary,Nothing},
        example     = """
            arr: [1 2 3 4]
            
            contains? arr 5             ; => false
            contains? arr 2             ; => true
            
            user: #[
            ____name: "John"
            ____surname: "Doe"
            ]
            
            contains? dict "John"       ; => true
            contains? dict "Paul"       ; => false
            
            contains? keys dict "name"  ; => true
            
            contains? "hello" "x"       ; => false
        """:
            ##########################################################
            case x.kind:
                of String:
                    if (popAttr("regex") != VNULL):
                        stack.push(newBoolean(nre.contains(x.s, nre.re(y.s))))
                    else:
                        stack.push(newBoolean(y.s in x.s))
                of Block:
                    stack.push(newBoolean(y in x.a))
                of Dictionary: 
                    let values = toSeq(x.d.values)
                    stack.push(newBoolean(y in values))
                else:
                    discard

    builtin "drop",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "drop first <number> of elements from given collection and return the remaining ones",
        args        = {
            "collection"    : {String,Block,Literal},
            "number"        : {Integer}
        },
        attrs       = NoAttrs,
        returns     = {String,Block,Nothing},
        example     = """
            str: drop "some text" 5
            print str                     ; text
            
            arr: 1..10
            drop 'arr 3                   ; arr: [4 5 6 7 8 9 10]
        """:
            ##########################################################
            if x.kind==Literal:
                if Syms[x.s].kind==String:
                    Syms[x.s].s = Syms[x.s].s[y.i..^1]
                elif Syms[x.s].kind==Block:
                    Syms[x.s].a = Syms[x.s].a[y.i..^1]
            else:
                if x.kind==String:
                    stack.push(newString(x.s[y.i..^1]))
                elif x.kind==Block:
                    stack.push(newBlock(x.a[y.i..^1]))

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
            
            str: "some text"
            empty 'str            ; str: ""
        """:
            ##########################################################
            case Syms[x.s].kind:
                of String: Syms[x.s].s = ""
                of Block: Syms[x.s].a = @[]
                of Dictionary: Syms[x.s].d = initOrderedTable[string,Value]()
                else: discard

    builtin "empty?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if given collection is empty",
        args        = {
            "collection"    : {String,Block,Dictionary,Null}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            empty? ""             ; => true
            empty? []             ; => true
            empty? #[]            ; => true
            
            empty [1 "two" 3]     ; => false
        """:
            ##########################################################
            case x.kind:
                of Null: stack.push(VTRUE)
                of String: stack.push(newBoolean(x.s==""))
                of Block: stack.push(newBoolean(x.a.len==0))
                of Dictionary: stack.push(newBoolean(x.d.len==0))
                else: discard

    # TODO(Collections\extend) verify functionality
    #  labels: library, unit-test
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
        # TODO(Collections\extend) add example for documentation
        #  labels: library,documentation
        example     = """
        """:
            ##########################################################
            if x.kind==Literal:
                for k,v in pairs(y.d):
                    Syms[x.s].d[k] = v
            else:
                var res = copyValue(x)
                for k,v in y.d:
                    res.d[k] = v

                stack.push(res)

    builtin "first",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "return the first item of the given collection",
        args        = {
            "collection"    : {String,Block}
        },
        attrs       = {
            "n"     : ({Integer},"get first <n> items")
        },
        returns     = {Any},
        example     = """
            print first "this is some text"       ; t
            print first ["one" "two" "three"]     ; one
            
            print first.n:2 ["one" "two" "three"] ; one two
        """:
            ##########################################################
            if (let aN = popAttr("n"); aN != VNULL):
                if x.kind==String: stack.push(newString(x.s[0..aN.i-1]))
                else: stack.push(newBlock(x.a[0..aN.i-1]))
            else:
                if x.kind==String: stack.push(newChar(x.s.runeAt(0)))
                else: stack.push(x.a[0])

    builtin "flatten",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "flatten given collection by eliminating nested blocks",
        args        = {
            "collection"    : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Block},
        example     = """
            arr: [[1 2 3] [4 5 6]]
            print flatten arr
            ; 1 2 3 4 5 6
            
            arr: [[1 2 3] [4 5 6]]
            flatten 'arr
            ; arr: [1 2 3 4 5 6]
        """:
            ##########################################################
            if x.kind==Literal:
                Syms[x.s] = Syms[x.s].flattened()
            else:
                stack.push(x.flattened())

    builtin "get",
        alias       = backslash, 
        rule        = InfixPrecedence,
        description = "get collection's item by given index",
        args        = {
            "collection"    : {String,Block,Dictionary,Date},
            "index"         : {Integer,String,Literal}
        },
        attrs       = NoAttrs,
        returns     = {Any},
        example     = """
            user: #[
            ____name: "John"
            ____surname: "Doe"
            ]
            
            print user\name               ; John
            
            print get user 'surname       ; Doe
            print user \ 'username        ; Doe
            
            arr: ["zero" "one" "two"]
            
            print arr\1                   ; one
            
            print get arr 2               ; two
            print arr \ 2                 ; two
            
            str: "Hello world!"
            
            print str\0                   ; H
            
            print get str 1               ; e
            print str \ 1                 ; e
        """:
            ##########################################################
            case x.kind:
                of Block: stack.push(x.a[y.i])
                of Dictionary: stack.push(x.d[y.s])
                of String: stack.push(newChar(x.s.runeAtPos(y.i)))
                of Date: 
                    stack.push(x.e[y.s])
                else: discard

    builtin "in?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if value exists in given collection",
        args        = {
            "value"         : {Any},
            "collection"    : {String,Block,Dictionary}
        },
        attrs       = {
            "regex" : ({Boolean},"match against a regular expression")
        },
        returns     = {String,Block,Dictionary,Nothing},
        example     = """
            arr: [1 2 3 4]
            
            in? 5 arr             ; => false
            in? 2 arr             ; => true
            
            user: #[
            ____name: "John"
            ____surname: "Doe"
            ]
            
            in? "John" dict       ; => true
            in? "Paul" dict       ; => false
            
            in? "name" keys dict  ; => true
            
            in? "x" "hello"       ; => false
        """:
            ##########################################################
            case y.kind:
                of String:
                    if (popAttr("regex") != VNULL):
                        stack.push(newBoolean(nre.contains(y.s, nre.re(x.s))))
                    else:
                        stack.push(newBoolean(x.s in y.s))
                of Block:
                    stack.push(newBoolean(x in y.a))
                of Dictionary: 
                    let values = toSeq(y.d.values)
                    stack.push(newBoolean(x in values))
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
            
            print index [1 2 3] 3     ; 2
            
            type index "hello" "x"
            ; :null
        """:
            ##########################################################
            case x.kind:
                of String:
                    let indx = x.s.find(y.s)
                    if indx != -1: stack.push(newInteger(indx))
                    else: stack.push(VNULL)
                of Block:
                    let indx = x.a.find(y)
                    if indx != -1: stack.push(newInteger(indx))
                    else: stack.push(VNULL)
                of Dictionary:
                    var found = false
                    for k,v in pairs(x.d):
                        if v==y:
                            stack.push(newString(k))
                            found=true
                            break

                    if not found:
                        stack.push(VNULL)
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
            
            dict: #[
            ____name: John
            ]
            
            insert 'dict 'name "Jane"
            ; dict: [name: "Jane"]
        """:
            ##########################################################
            if x.kind==Literal:
                case Syms[x.s].kind:
                    of String: Syms[x.s].s.insert(z.s, y.i)
                    of Block: Syms[x.s].a.insert(z, y.i)
                    of Dictionary:
                        Syms[x.s].d[y.s] = z
                    else: discard
            else:
                case x.kind:
                    of String: 
                        var copied = x.s
                        copied.insert(z.s, y.i)
                        stack.push(newString(copied))
                    of Block: 
                        var copied = x.a
                        copied.insert(z, y.i)
                        stack.push(newBlock(copied))
                    of Dictionary:
                        var copied = x.d
                        copied[y.s] = z
                        stack.push(newDictionary(copied))
                    else: discard

    builtin "key?",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "check if dictionary contains given key",
        args        = {
            "collection"    : {Dictionary},
            "key"           : {String,Literal}
        },
        attrs       = NoAttrs,
        returns     = {Boolean},
        example     = """
            user: #[
            ____name: "John"
            ____surname: "Doe"
            ]
            
            key? user 'age            ; => false
            if key? user 'name [
            ____print ["Hello" user\name]
            ]
            ; Hello John
        """:
            ##########################################################
            stack.push(newBoolean(x.d.hasKey(y.s)))

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
            ____name: "John"
            ____surname: "Doe"
            ]
            
            keys user
            => ["name" "surname"]
        """:
            ##########################################################
            let s = toSeq(x.d.keys)
            stack.push(newStringBlock(s))

    builtin "last",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "return the last item of the given collection",
        args        = {
            "collection"    : {String,Block}
        },
        attrs       = {
            "n"     : ({Integer},"get last <n> items")
        },
        returns     = {Any},
        example     = """
            print last "this is some text"       ; t
            print last ["one" "two" "three"]     ; three
            
            print last.n:2 ["one" "two" "three"] ; two three
        """:
            ##########################################################
            if (let aN = getAttr("n"); aN != VNULL):
                if x.kind==String: stack.push(newString(x.s[x.s.len-aN.i..^1]))
                else: stack.push(newBlock(x.a[x.a.len-aN.i..^1]))
            else:
                if x.kind==String: 
                    stack.push(newChar(toRunes(x.s)[^1]))
                else: stack.push(x.a[x.a.len-1])

    builtin "max",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get maximum element in given collection",
        args        = {
            "collection"    : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Any,Null},
        example     = """
            print max [4 2 8 5 1 9]       ; 9
        """:
            ##########################################################
            if x.a.len==0: stack.push(VNULL)
            else:
                var maxElement = x.a[0]
                var i = 1
                while i < x.a.len:
                    if (x.a[i]>maxElement):
                        maxElement = x.a[i]
                    inc(i)

                stack.push(maxElement)

    builtin "min",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get minimum element in given collection",
        args        = {
            "collection"    : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Any,Null},
        example     = """
            print min [4 2 8 5 1 9]       ; 1
        """:
            ##########################################################
            if x.a.len==0: stack.push(VNULL)
            else:
                var minElement = x.a[0]
                var i = 1
                while i < x.a.len:
                    if (x.a[i]<minElement):
                        minElement = x.a[i]
                    inc(i)
                    
                stack.push(minElement)

    builtin "permutate",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get all possible permutations of the elements in given collection",
        args        = {
            "collection"    : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Block},
        example     = """
            permutate [A B C]
            ; => [[A B C] [A C B] [C A B] [B A C] [B C A] [C B A]]
        """:
            ##########################################################
            var ret: ValueArray = @[]
        
            permutate(x.a, proc(s: ValueArray)= 
                ret.add(newBlock(s))
            )

            stack.push(newBlock(ret))

    builtin "remove",
        alias       = doubleminus, 
        rule        = InfixPrecedence,
        description = "remove value from given collection",
        args        = {
            "collection"    : {String,Block,Dictionary,Literal},
            "value"         : {Any}
        },
        attrs       = {
            "key"   : ({Boolean},"remove dictionary key"),
            "once"  : ({Boolean},"remove only first occurence"),
            "index" : ({Integer},"remove specific index")
        },
        returns     = {String,Block,Dictionary,Nothing},
        example     = """
            remove "hello" "l"        ; => "heo"
            print "hello" -- "l"      ; heo
            
            str: "mystring"
            remove 'str "str"         
            print str                 ; mying
            
            print remove.once "hello" "l"
            ; helo
            
            remove [1 2 3 4] 4        ; => [1 2 3]
        """:
            ##########################################################
            if x.kind==Literal:
                if Syms[x.s].kind==String:
                    if (popAttr("once") != VNULL):
                        Syms[x.s] = newString(Syms[x.s].s.removeFirst(y.s))
                    else:
                        Syms[x.s] = newString(Syms[x.s].s.replace(y.s))
                elif Syms[x.s].kind==Block: 
                    if (popAttr("once") != VNULL):
                        Syms[x.s] = newBlock(Syms[x.s].a.removeFirst(y))
                    elif (let aIndex = popAttr("index"); aIndex != VNULL):
                        Syms[x.s] = newBlock(Syms[x.s].a.removeByIndex(aIndex.i))
                    else:
                        Syms[x.s] = newBlock(Syms[x.s].a.removeAll(y))
                elif Syms[x.s].kind==Dictionary:
                    let key = (popAttr("key") != VNULL)
                    if (popAttr("once") != VNULL):
                        Syms[x.s] = newDictionary(Syms[x.s].d.removeFirst(y, key))
                    else:
                        Syms[x.s] = newDictionary(Syms[x.s].d.removeAll(y, key))
            else:
                if x.kind==String:
                    if (popAttr("once") != VNULL):
                        stack.push(newString(x.s.removeFirst(y.s)))
                    else:
                        stack.push(newString(x.s.replace(y.s)))
                elif x.kind==Block: 
                    if (popAttr("once") != VNULL):
                        stack.push(newBlock(x.a.removeFirst(y)))
                    elif (let aIndex = popAttr("index"); aIndex != VNULL):
                        stack.push(newBlock(x.a.removeByIndex(aIndex.i)))
                    else:
                        stack.push(newBlock(x.a.removeAll(y)))
                elif x.kind==Dictionary:
                    let key = (popAttr("key") != VNULL)
                    if (popAttr("once") != VNULL):
                        stack.push(newDictionary(x.d.removeFirst(y, key)))
                    else:
                        stack.push(newDictionary(x.d.removeAll(y, key)))

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
            
            repeat [1 2 3] 3
            ; => [1 2 3 1 2 3 1 2 3]
            
            repeat 5 3
            ; => [5 5 5]
            
            repeat [[1 2 3]] 3
            ; => [[1 2 3] [1 2 3] [1 2 3]]
        """:
            ##########################################################
            if x.kind==Literal:
                if Syms[x.s].kind==String:
                    Syms[x.s] = newString(Syms[x.s].s.repeat(y.i))
                elif Syms[x.s].kind==Block:
                    Syms[x.s] = newBlock(Syms[x.s].a.cycle(y.i))
                else:
                    Syms[x.s] = newBlock(Syms[x.s].repeat(y.i))
            else:
                if x.kind==String:
                    stack.push(newString(x.s.repeat(y.i)))
                elif x.kind==Block:
                    stack.push(newBlock(x.a.cycle(y.i)))
                else:
                    stack.push(newBlock(x.repeat(y.i)))

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
                if Syms[x.s].kind==String:
                    Syms[x.s].s.reverse()
                else:
                    Syms[x.s].a.reverse()
            else:
                if x.kind==Block: stack.push(newBlock(x.a.reversed))
                elif x.kind==String: stack.push(newString(x.s.reversed))

    builtin "sample",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get a random element from given collection",
        args        = {
            "collection"    : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Any},
        example     = """
            sample [1 2 3]        ; (return a random number from 1 to 3)
            print sample ["apple" "appricot" "banana"]
            ; apple
        """:
            ##########################################################
            stack.push(sample(x.a))

    builtin "set",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "set collection's item at index to given value",
        args        = {
            "collection"    : {String,Block,Dictionary},
            "index"         : {Integer,String,Literal},
            "value"         : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            myDict: #[ 
            ____name: "John"
            ____age: 34
            ]
            
            set myDict 'name "Michael"        ; => [name: "Michael", age: 34]
            
            arr: [1 2 3 4]
            set arr 0 "one"                   ; => ["one" 2 3 4]
        """:
            ##########################################################
            case x.kind:
                of Block: 
                    x.a[y.i] = z
                of Dictionary:
                    x.d[y.s] = z
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
            
            arr: [2 5 9]
            shuffle 'arr
            print arr                     ; 5 9 2
        """:
            ##########################################################
            if x.kind==Literal:
                Syms[x.s].a.shuffle()
            else:
                stack.push(newBlock(x.a.dup(shuffle)))

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
            str: "some text"      
            print size str                ; 9
            
            print size "你好!"              ; 3
        """:
            ##########################################################
            if x.kind==String:
                stack.push(newInteger(runeLen(x.s)))
            elif x.kind==Dictionary:
                stack.push(newInteger(x.d.len))
            else:
                stack.push(newInteger(x.a.len))
            
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
            print slice 1..10 3 4         ; 4 5
        """:
            ##########################################################
            if x.kind==String:
                stack.push(newString(x.s.runeSubStr(y.i,z.i-y.i+1)))
            else:
                stack.push(newBlock(x.a[y.i..z.i]))

    builtin "sort",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "sort given block in ascending order",
        args        = {
            "collection"    : {Block,Literal}
        },
        attrs       = {
            "as"        : ({Literal},"localizezd by ISO 639-1 language code"),
            "sensitive" : ({Boolean},"case-sensitive sorting"),
            "descending": ({Boolean},"sort in ascending order")
        },
        returns     = {Block,Nothing},
        example     = """
            a: [3 1 6]
            print sort a                  ; 1 3 6
            
            print sort.descending a       ; 6 3 1
            
            b: ["one" "two" "three"]
            sort 'b
            print b                       ; one three two
        """:
            ##########################################################
            var sortOrdering = SortOrder.Ascending

            if (popAttr("descending")!=VNULL):
                sortOrdering = SortOrder.Descending

            if x.kind==Block: 
                if (let aAs = popAttr("as"); aAs != VNULL):
                    stack.push(newBlock(x.a.unisorted(aAs.s, sensitive = popAttr("sensitive")!=VNULL, order = sortOrdering)))
                else:
                    if (popAttr("sensitive")!=VNULL):
                        stack.push(newBlock(x.a.unisorted("en", sensitive=true, order = sortOrdering)))
                    else:
                        if x.a[0].kind==String:
                            stack.push(newBlock(x.a.unisorted("en", order = sortOrdering)))
                        else:
                            stack.push(newBlock(x.a.sorted(order = sortOrdering)))

                        
            else: 
                if (let aAs = popAttr("as"); aAs != VNULL):
                    Syms[x.s].a.unisort(aAs.s, sensitive = popAttr("sensitive")!=VNULL, order = sortOrdering)
                else:
                    if (popAttr("sensitive")!=VNULL):
                        Syms[x.s].a.unisort("en", sensitive=true, order = sortOrdering)
                    else:
                        if Syms[x.s].a[0].kind==String:
                            Syms[x.s].a.unisort("en", order = sortOrdering)
                        else:
                            Syms[x.s].a.sort(order = sortOrdering)

    builtin "split",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "split collection to components",
        args        = {
            "collection"    : {String,Block,Literal}
        },
        attrs       = {
            "words"     : ({Boolean},"split string by whitespace"),
            "lines"     : ({Boolean},"split string by lines"),
            "by"        : ({String},"split using given separator"),
            "regex"     : ({Boolean},"match against a regular expression"),
            "at"        : ({Integer},"split collection at given position"),
            "every"     : ({Integer},"split collection every <n> elements")
        },
        returns     = {Block,Nothing},
        example     = """
            split "hello"                 ; => [`h` `e` `l` `l` `o`]
            split.words "hello world"     ; => ["hello" "world"]
            
            split.every: 2 "helloworld"
            ; => ["he" "ll" "ow" "or" "ld"]
            
            split.at: 4 "helloworld"
            ; => ["hell" "oworld"]
            
            arr: 1..9
            split.at:3 'arr
            ; => [ [1 2 3 4] [5 6 7 8 9] ]
        """:
            ##########################################################
            if x.kind==Literal:
                if Syms[x.s].kind==String:
                    if (popAttr("words") != VNULL):
                        Syms[x.s] = newStringBlock(strutils.splitWhitespace(Syms[x.s].s))
                    elif (popAttr("lines") != VNULL):
                        Syms[x.s] = newStringBlock(Syms[x.s].s.splitLines())
                    elif (let aBy = popAttr("by"); aBy != VNULL):
                        Syms[x.s] = newStringBlock(Syms[x.s].s.split(aBy.s))
                    elif (let aRegex = popAttr("regex"); aRegex != VNULL):
                        Syms[x.s] = newStringBlock(Syms[x.s].s.split(nre.re(aRegex.s)))
                    elif (let aAt = popAttr("at"); aAt != VNULL):
                        Syms[x.s] = newStringBlock(@[Syms[x.s].s[0..aAt.i-1], Syms[x.s].s[aAt.i..^1]])
                    elif (let aEvery = popAttr("every"); aEvery != VNULL):
                        var ret: seq[string] = @[]
                        var length = Syms[x.s].s.len
                        var i = 0

                        while i<length:
                            ret.add(Syms[x.s].s[i..i+aEvery.i-1])
                            i += aEvery.i

                        Syms[x.s] = newStringBlock(ret)
                    else:
                        Syms[x.s] = newStringBlock(Syms[x.s].s.map(proc (x:char):string = $(x)))
                else:
                    if (let aAt = popAttr("at"); aAt != VNULL):
                        Syms[x.s] = newBlock(@[newBlock(Syms[x.s].a[0..aAt.i]), newBlock(Syms[x.s].a[aAt.i..^1])])
                    elif (let aEvery = popAttr("every"); aEvery != VNULL):
                        var ret: ValueArray = @[]
                        var length = Syms[x.s].a.len
                        var i = 0

                        while i<length:
                            ret.add(Syms[x.s].a[i..i+aEvery.i-1])
                            i += aEvery.i

                        Syms[x.s] = newBlock(ret)
                    else: discard

            elif x.kind==String:
                if (popAttr("words") != VNULL):
                    stack.push(newStringBlock(strutils.splitWhitespace(x.s)))
                elif (popAttr("lines") != VNULL):
                    stack.push(newStringBlock(x.s.splitLines()))
                elif (let aBy = popAttr("by"); aBy != VNULL):
                    stack.push(newStringBlock(x.s.split(aBy.s)))
                elif (let aRegex = popAttr("regex"); aRegex != VNULL):
                    stack.push(newStringBlock(x.s.split(nre.re(aRegex.s))))
                elif (let aAt = popAttr("at"); aAt != VNULL):
                    stack.push(newStringBlock(@[x.s[0..aAt.i-1], x.s[aAt.i..^1]]))
                elif (let aEvery = popAttr("every"); aEvery != VNULL):
                    var ret: seq[string] = @[]
                    var length = x.s.len
                    var i = 0

                    while i<length:
                        ret.add(x.s[i..i+aEvery.i-1])
                        i += aEvery.i

                    stack.push(newStringBlock(ret))
                else:
                    stack.push(newStringBlock(x.s.map(proc (x:char):string = $(x))))
            else:
                if (let aAt = popAttr("at"); aAt != VNULL):
                    stack.push(newBlock(@[newBlock(x.a[0..aAt.i-1]), newBlock(x.a[aAt.i..^1])]))
                elif (let aEvery = popAttr("every"); aEvery != VNULL):
                    var ret: ValueArray = @[]
                    var length = x.a.len
                    var i = 0

                    while i<length:
                        if i+aEvery.i > length:
                            ret.add(newBlock(x.a[i..^1]))
                        else:
                            ret.add(newBlock(x.a[i..i+aEvery.i-1]))

                        i += aEvery.i

                    stack.push(newBlock(ret))
                else: stack.push(x)


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
            
            arr: 1..10
            take 'arr 3                   ; arr: [1 2 3]
        """:
            ##########################################################
            if x.kind==Literal:
                if Syms[x.s].kind==String:
                    Syms[x.s].s = Syms[x.s].s[0..y.i-1]
                elif Syms[x.s].kind==Block:
                    Syms[x.s].a = Syms[x.s].a[0..y.i-1]
            else:
                if x.kind==String:
                    stack.push(newString(x.s[0..y.i-1]))
                elif x.kind==Block:
                    stack.push(newBlock(x.a[0..y.i-1]))

    builtin "unique",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get given block without duplicates",
        args        = {
            "collection"    : {Block,Literal}
        },
        attrs       = NoAttrs,
        returns     = {Block,Nothing},
        example     = """
            arr: [1 2 4 1 3 2]
            print unique arr              ; 1 2 4 3
            
            arr: [1 2 4 1 3 2]
            unique 'arr
            print arr                     ; 1 2 4 3
        """:
            ##########################################################
            if x.kind==Block: stack.push(newBlock(x.a.deduplicate()))
            else: Syms[x.s].a = Syms[x.s].a.deduplicate()

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
            ____name: "John"
            ____surname: "Doe"
            ]
            
            values user
            => ["John" "Doe"]
        """:
            ##########################################################
            let s = toSeq(x.d.values)
            stack.push(newBlock(s))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)