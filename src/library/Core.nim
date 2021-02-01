######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: library/Core.nim
######################################################

#=======================================
# Methods
#=======================================

builtin "break",
    alias       = unaliased, 
    rule        = PrefixPrecedence,
    description = "break out of current block or loop",
    args        = NoArgs,
    attrs       = NoAttrs,
    returns     = {Block},
    example     = """
    """:
        ##########################################################
        vmBreak = true
        #return syms

builtin "call",
    alias       = unaliased, 
    rule        = PrefixPrecedence,
    description = "call function with given list of parameters",
    args        = {
        "function"  : {String,Literal,Function},
        "params"    : {Block}
    },
    attrs       = NoAttrs,
    returns     = {Any},
    example     = """
        multiply: function [x y][
            x * y
        ]
        
        call 'multiply [3 5]          ; => 15
        
        call $[x][x+2] [5]            ; 7
    """:
        ##########################################################
        var fun: Value

        if x.kind==Literal or x.kind==String:
            fun = syms[x.s]
        else:
            fun = x

        for v in y.a.reversed:
            stack.push(v)

        discard execBlock(fun.main, args=fun.params.a)
    
builtin "case",
    alias       = unaliased, 
    rule        = PrefixPrecedence,
    description = "initiate a case block to check for different cases",
    args        = {
        "predicate" : {Block}
    },
    attrs       = NoAttrs,
    returns     = {Nothing},
    example     = """
        a: 2
        case [a]
            when? [<2] -> print "a is less than 2"
            when? [=2] -> print "a is 2"
            else       -> print "a is greater than 2"
    """:
        ##########################################################
        stack.push(x)
        stack.push(newBoolean(false))

builtin "continue",
    alias       = unaliased, 
    rule        = PrefixPrecedence,
    description = "immediately continue with next iteration",
    args        = NoArgs,
    attrs       = NoAttrs,
    returns     = {Block},
    example     = """
    """:
        ##########################################################
        vmContinue = true
        #return syms

builtin "do",
    alias       = unaliased, 
    rule        = PrefixPrecedence,
    description = "evaluate and execute given code",
    args        = {
        "code"  : {String,Block}
    },
    attrs       = {
        "import": ({Boolean},"execute at root level")
    },
    returns     = {Any,Nothing},
    example     = """
        do "print 123"                ; 123
        
        do [
            x: 3
            print ["x =>" x]          ; x => 3
        ]
        
        do.import [
            x: 3
        ]
        print ["x =>" x]              ; x => 3
        
        print do "https://raw.githubusercontent.com/arturo-lang/arturo/master/examples/projecteuler/euler1.art"
        ; 233168
    """:
        ##########################################################
        var execInParent = (popAttr("import") != VNULL)

        if x.kind==Block:
            # discard executeBlock(x)
            if execInParent:
                discard execBlock(x, execInParent=true)
                showVMErrors()
            else:
                discard execBlock(x)
        else:
            let (src, tp) = getSource(x.s)

            if tp==FileData:
                addPath(x.s)

            if execInParent:
                let parsed = doParse(src, isFile=false)

                if not isNil(parsed):
                    discard execBlock(parsed, execInParent=true)
                    showVMErrors()
            else:
                let parsed = doParse(src, isFile=false)
                if not isNil(parsed):
                    discard execBlock(parsed)

            if tp==FileData:
                discard popPath()

builtin "else",
    alias       = unaliased, 
    rule        = PrefixPrecedence,
    description = "perform action, if last condition was not true",
    args        = {
        "otherwise" : {Block}
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
        ##########################################################
        let y = stack.pop() # pop the value of the previous operation (hopefully an 'if?' or 'when?')
        if not y.b: discard execBlock(x)

builtin "globalize",
    alias       = unaliased, 
    rule        = PrefixPrecedence,
    description = "make all symbols within current context global",
    args        = NoArgs,
    attrs       = NoAttrs,
    returns     = {Nothing},
    example     = """
    """:
        ##########################################################
        for k,v in pairs(syms):
            syms[k] = v

builtin "if",
    alias       = unaliased, 
    rule        = PrefixPrecedence,
    description = "perform action, if given condition is true",
    args        = {
        "condition" : {Boolean},
        "action"    : {Block}
    },
    attrs       = NoAttrs,
    returns     = {Nothing},
    example     = """
        x: 2
        
        if x=2 -> print "yes, that's right!"
        ; yes, that's right!
    """:
        ##########################################################
        if x.b: discard execBlock(y)

builtin "if?",
    alias       = unaliased, 
    rule        = PrefixPrecedence,
    description = "perform action, if given condition is true and return condition result",
    args        = {
        "condition" : {Boolean},
        "action"    : {Block}
    },
    attrs       = NoAttrs,
    returns     = {Boolean},
    example     = """
        x: 2
        
        result: if? x=2 -> print "yes, that's right!"
        ; yes, that's right!
        
        print result
        ; true
        
        z: 3
        
        if? x>z [
            print "x was greater than z"
        ]
        else [
            print "nope, x was not greater than z"
        ]
    """:
        ##########################################################
        if x.b: 
            discard execBlock(y)
            # if vmReturn:
            #     return ReturnResult
        stack.push(x)

builtin "let",
    alias       = colon, 
    rule        = InfixPrecedence,
    description = "set symbol to given value",
    args        = {
        "symbol"    : {String,Literal},
        "value"     : {Any}
    },
    attrs       = NoAttrs,
    returns     = {Nothing},
    example     = """
        let 'x 10         ; x: 10
        print x           ; 10
    """:
        ##########################################################
        syms[x.s] = y

builtin "new",
    alias       = unaliased, 
    rule        = PrefixPrecedence,
    description = "create new value by cloning given one",
    args        = {
        "value"     : {Any}
    },
    attrs       = NoAttrs,
    returns     = {Any},
    example     = """
    """:
        ##########################################################
        stack.push(copyValue(x))

constant "null",
    alias       = slashedzero,
    description = "the NULL constant":
        VNULL

builtin "pop",
    alias       = unaliased, 
    rule        = PrefixPrecedence,
    description = "pop top <number> values from stack",
    args        = {
        "number"    : {Integer}
    },
    attrs       = {
        "discard"   : ({Boolean},"do not return anything")
    },
    returns     = {Any},
    example     = """
    """:
        ##########################################################
        let doDiscard = (popAttr("discard") != VNULL)

        if x.i==1:
            if doDiscard: discard stack.pop()
            else: discard
        else:
            if doDiscard: 
                var i = 0
                while i<x.i:
                    discard stack.pop()
                    i+=1
            else:
                var res: ValueArray = @[]
                var i = 0
                while i<x.i:
                    res.add stack.pop()
                    i+=1
                stack.push(newBlock(res))

builtin "push",
    alias       = ampersand, 
    rule        = PrefixPrecedence,
    description = "push given value to stack twice",
    args        = {
        "value" : {Any}
    },
    attrs       = NoAttrs,
    returns     = {Nothing},
    example     = """
    """:
        ##########################################################
        stack.push(sTop())

builtin "return",
    alias       = unaliased, 
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
        ##########################################################
        stack.push(x)
        #echo "emitting: ReturnTriggered"
        raise ReturnTriggered.newException("return")
        # vmReturn = true
        # # return ReturnResult
        # #return syms

builtin "try",
    alias       = unaliased, 
    rule        = PrefixPrecedence,
    description = "perform action and catch possible errors",
    args        = {
        "action": {Block}
    },
    attrs       = NoAttrs,
    returns     = {Nothing},
    example     = """
        try [
            ; let's try something dangerous
            print 10 / 0
        ]
        
        ; we catch the exception but do nothing with it
    """:
        ##########################################################
        try:
            discard execBlock(x)
        except:
            discard

builtin "try?",
    alias       = unaliased, 
    rule        = PrefixPrecedence,
    description = "perform action, catch possible errors and return status",
    args        = {
        "action": {Block}
    },
    attrs       = NoAttrs,
    returns     = {Boolean},
    example     = """
        try? [
            ; let's try something dangerous
            print 10 / 0
        ]
        else [
            print "something went terribly wrong..."
        ]
        
        ; something went terribly wrong...
    """:
        ##########################################################
        try:
            discard execBlock(x)
            stack.push(VTRUE)
        except:
            stack.push(VFALSE)

builtin "until",
    alias       = unaliased, 
    rule        = PrefixPrecedence,
    description = "execute action until the given condition is true",
    args        = {
        "action"    : {Block},
        "condition" : {Block}
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
        ##########################################################
        let preevaledX = doEval(x)
        let preevaledY = doEval(y)

        while true:
            discard execBlock(VNULL, evaluated=preevaledX)
            discard execBlock(VNULL, evaluated=preevaledY)
            if stack.pop().b:
                break

builtin "var",
    alias       = unaliased, 
    rule        = PrefixPrecedence,
    description = "get symbol value by given name",
    args        = {
        "symbol"    : {String,Literal}
    },
    attrs       = NoAttrs,
    returns     = {Any},
    example     = """
    """:
        ##########################################################
        stack.push(syms[x.s])

builtin "when?",
    alias       = unaliased, 
    rule        = PrefixPrecedence,
    description = "check if a specific condition is fulfilled and, if so, execute given action",
    args        = {
        "condition" : {Block},
        "action"    : {Block}
    },
    attrs       = NoAttrs,
    returns     = {Boolean},
    example     = """
        a: 2
        case [a]
            when? [<2] -> print "a is less than 2"
            when? [=2] -> print "a is 2"
            else       -> print "a is greater than 2"
    """:
        ##########################################################
        let z = pop()
        if not z.b:
            let top = stack.sTop()

            var newb: Value = newBlock()
            for old in top.a:
                newb.a.add(old)
            for cond in x.a:
                newb.a.add(cond)

            discard execBlock(newb)

            let res = stack.sTop()
            if res.b: 
                discard execBlock(y)
                discard pop()
                discard pop()
                push(newBoolean(true))
        else:
            push(z)

builtin "while",
    alias       = unaliased, 
    rule        = PrefixPrecedence,
    description = "execute action while the given condition is true",
    args        = {
        "condition" : {Block},
        "action"    : {Block}
    },
    attrs       = {
        "import": ({Boolean},"execute at root level")
    },
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
    """:
        ##########################################################
        var execInParent = (popAttr("import") != VNULL)

        let preevaledX = doEval(x)
        let preevaledY = doEval(y)

        discard execBlock(VNULL, evaluated=preevaledX)

        while stack.pop().b:
            if execInParent:
                discard execBlock(VNULL, evaluated=preevaledY, execInParent=true)
            else:
                discard execBlock(VNULL, evaluated=preevaledY)
            discard execBlock(VNULL, evaluated=preevaledX)
