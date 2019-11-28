#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: core/context.nim
  *****************************************************************]#

#[######################################################
    Helpers
  ======================================================]#

proc storeOrGetHash(k:cstring):int {.inline.} =
    if Hashes.hasKey(k):
        result = Hashes[k]
    else:
        let hsh = k.hash
        Hashes[k]=hsh
        result = hsh

proc storeOrGetHash(k:string):int {.inline.} =
    if Hashes.hasKey(k):
        result = Hashes[k]
    else:
        let hsh = k.hash
        Hashes[k]=hsh
        result = hsh

proc getSymbolForHash(h:int):string {.inline.} =
    for k, v in Hashes.pairs:
        if v==h:
            return $k

    return ""

#[----------------------------------------
    Context Object
  ----------------------------------------]#

##---------------------------
## Constructors
##---------------------------

template addContext() =
    ## Add a new context to the Stack

    Stack.add(@[])

template initTopContextWith(hs:int, val:Value) =
    ## Initialize topmost Context with key-val pair

    shallowCopy(Stack[^1],@[(hs,val)])
    #Stack[^1] = @[(hs,val)]

template initTopContextWith(pairs:seq[(int,Value)]) =
    ## Initialize topmost Context with key-val pairs

    shallowCopy(Stack[^1],pairs)
    #Stack[^1] = pairs

template popContext() =
    ## Discard topmost Context

    discard Stack.pop()

##---------------------------
## Methods
##---------------------------

proc keys*(ctx: Context): seq[string] {.inline.} =
    ## Get array of keys in given Context
    
    result = ctx.map((x) => getSymbolForHash(x[0]))

proc values*(ctx: Context): seq[Value] {.inline.} =
    ## Get array of values in given Context

    result = ctx.map((x) => x[1])

proc hasKey*(ctx: Context, key: string): bool {.inline.} = 
    ## Check if given Context contains key

    var i = 0
    let hs = key.hash
    while i<ctx.len:
        if ctx[i][0]==hs: return true 
        inc(i)
    return false

proc getValueForKey*(ctx: Context, key: string): Value {.inline.} =
    ## Get Value of key in a given Context

    let hs = key.hash
    var i = 0
    while i<ctx.len:
        if ctx[i][0]==hs: return ctx[i][1] 
        inc(i)
    return 0

proc updateOrSet(ctx: var Context, k: string, v: Value) {.inline.} = 
    ## In a given Context, either update a key if it exists, or create it
    var i = 0
    let hs = k.hash
    while i<ctx.len:
        if ctx[i][0]==hs: 
            ctx[i][1] = v
            return
        inc(i)

    ctx.add((hs,v))

proc updateOrSet(ctx: var Context, hs: int, v: Value) {.inline.} = 
    ## In a given Context, either update a key if it exists, or create it
    var i = 0
    #let hs = k.hash
    while i<ctx.len:
        if ctx[i][0]==hs: 
            ctx[i][1] = v
            return
        inc(i)

    ctx.add((hs,v))

proc getSymbol(hs: int): Value {.inline.} = 
    ## Get Value of key in the Stack

    var i = len(Stack) - 1
    var j: int
    while i > -1:
        j = 0
        while j<Stack[i].len:
            if Stack[i][j][0]==hs: 
                return Stack[i][j][1]
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
        while j<Stack[i].len:
            if Stack[i][j][0]==hs: 
                result = Stack[i][j][1]
                Stack[i][j][1] = v
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
        while j<Stack[i].len:
            if Stack[i][j][0]==hs: 
                Stack[i][j][1] = v
                return Stack[i][j][1]
            inc(j)

        dec(i)

    Stack[^1].updateOrSet(hs,v)
    result = v

# proc incSymbolInPlace(hs: int): Value {.inline.} = 
#     var i = len(Stack) - 1
#     var j: int
#     #let hs = k.hash
#     while i > -1:
#         j = 0
#         while j<Stack[i].len:
#             if Stack[i][j][0]==hs: 
#                 case Stack[i][j][1].kind
#                     of IV: 
#                         Stack[i][j][1]+=1
#                         return Stack[i][j][1]
#                     of BIV: 
#                         BI(Stack[i][j][1]).inc(1)
#                         return Stack[i][j][1]
#                     else: discard
#                 return
#             inc(j)

#         dec(i)

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

        for t in s:
            echo tab,$t[0]," [" & fmt"{cast[int](unsafeAddr(t[1])):#x}" & "] -> ",t[1].stringify(), " -> #: "#, $t[2]
            #if t[1].kind==IV:
            #    echo "\t\t" & fmt"{cast[int](unsafeAddr(I(t[1]))):#x}"

        inc(i)
        