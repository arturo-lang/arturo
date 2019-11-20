#[----------------------------------------
    Context
  ----------------------------------------]#

##---------------------------
## Constructors
##---------------------------

template addContext() =
    ## Add a new context to the Stack

    Stack.add(Context(list: @[]))

template initTopContextWith(hs:int, val:Value) =
    ## Initialize topmost Context with key-val pair

    Stack[^1] = Context(list: @[(hs,val)])

template initTopContextWith(pairs:seq[(int,Value)]) =
    ## Initialize topmost Context with key-val pairs

    Stack[^1] = Context(list:pairs)

template popContext() =
    ## Discard topmost Context

    discard Stack.pop()

##---------------------------
## Methods
##---------------------------

proc keys*(ctx: Context): seq[string] {.inline.} =
    ## Get array of keys in given Context
    discard
    #result = ctx.list.map((x) => x[0])

proc values*(ctx: Context): seq[Value] {.inline.} =
    ## Get array of values in given Context

    result = ctx.list.map((x) => x[1])

proc hasKey*(ctx: Context, key: string): bool {.inline.} = 
    ## Check if given Context contains key

    var i = 0
    let hs = key.hash
    while i<ctx.list.len:
        if ctx.list[i][0]==hs: return true 
        inc(i)
    return false

proc getValueForKey*(ctx: Context, key: string): Value {.inline.} =
    ## Get Value of key in a given Context

    let hs = key.hash
    var i = 0
    while i<ctx.list.len:
        if ctx.list[i][0]==hs: return ctx.list[i][1] 
        inc(i)
    return 0

proc updateOrSet(ctx: var Context, k: string, v: Value) {.inline.} = 
    ## In a given Context, either update a key if it exists, or create it
    var i = 0
    let hs = k.hash
    while i<ctx.list.len:
        if ctx.list[i][0]==hs: 
            shallowCopy(ctx.list[i][1],v)
            return
        inc(i)

    ctx.list.add((hs,v))

proc updateOrSet(ctx: var Context, hs: int, v: Value) {.inline.} = 
    ## In a given Context, either update a key if it exists, or create it
    var i = 0
    #let hs = k.hash
    while i<ctx.list.len:
        if ctx.list[i][0]==hs: 
            shallowCopy(ctx.list[i][1],v)
            return
        inc(i)

    ctx.list.add((hs,v))

proc getSymbol(hs: int): Value {.inline.} = 
    ## Get Value of key in the Stack

    var i = len(Stack) - 1
    var j: int
    while i > -1:
        j = 0
        while j<Stack[i].list.len:
            if Stack[i].list[j][0]==hs: 
                return Stack[i].list[j][1]
            inc(j)
        dec(i)

    return 0

proc getAndSetSymbol(hs: int, v: Value): Value {.inline.} = 
    ## Set key in the Stack and return previous Value

    var i = len(Stack) - 1
    var j: int
    #let hs = k.hash
    while i > -1:
        j = 0
        while j<Stack[i].list.len:
            if Stack[i].list[j][0]==hs: 
                result = Stack[i].list[j][1]
                shallowCopy(Stack[i].list[j][1],v)
                return 
            inc(j)
        dec(i)

    return 0

template resetSymbol(k: int, v: Value) =
    ##  Set key in the top Stack context

    Stack[^1].updateOrSet(k,v)

proc setSymbol(hs: int, v: Value): Value {.inline.} = 
    var i = len(Stack) - 1
    var j: int
    #let hs = k.hash
    while i > -1:
        j = 0
        while j<Stack[i].list.len:
            if Stack[i].list[j][0]==hs: 
                shallowCopy(Stack[i].list[j][1],v)
                return Stack[i].list[j][1]
            inc(j)

        dec(i)

    Stack[^1].updateOrSet(hs,v)
    result = v

##---------------------------
## Inspection
##---------------------------

proc inspectStack() =
    ## Utility method print out all Context's in the Stack

    var i = 0
    for s in Stack:
        var tab = ""
        if i>0: tab = "\t"
        echo tab,"----------------"
        echo tab,"Stack[",i,"]"
        echo tab,"----------------"

        for t in s.list:
            echo tab,$t[0]," [" & fmt"{cast[int](unsafeAddr(t[1])):#x}" & "] -> ",t[1].stringify(), " -> #: "#, $t[2]
            #if t[1].kind==IV:
            #    echo "\t\t" & fmt"{cast[int](unsafeAddr(I(t[1]))):#x}"

        inc(i)