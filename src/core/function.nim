#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: core/function.nim
  *****************************************************************]#

#[----------------------------------------
    Function Object
  ----------------------------------------]#

##---------------------------
## Constructors
##---------------------------

proc newUserFunction(s: StatementList, a: seq[string]): Function =
    result = Function(id: 0, args: a.map((x)=>storeOrGetHash(x)), hasNamedArgs: (a.len!=0), body: s, hasContext: false, parentThis: 0, parentContext: @[])

##---------------------------
## Getters/Setters
##---------------------------

proc setFunctionName(f: Function, s: string) {.inline.} =
    ## Set name of given user Function
    ## ! Used only when performing a variable assignment: f: { .. }

    f.id = storeOrGetHash(s)
    f.hasContext = true

proc getSystemFunction*(n: string): int =
    ## Get System function code from given name

    var i = 0
    while i < SystemFunctions.len:
        if SystemFunctions[i].name==n:
            return i
        inc(i)

    result = -1

proc getSystemFunctionInstance*(n: string): SystemFunction {.inline.} =
    ## Get System function from given name

    var i = 0
    while i < SystemFunctions.len:
        if SystemFunctions[i].name==n:
            return SystemFunctions[i]
        inc(i)

proc getNameOfSystemFunction*(n: int): cstring {.exportc.} =
    ## Get name of System function from given code
    ## ! Used from the Bison parser to find out the name of a user variable
    ## ! that happens to have the same name as a System function

    result = SystemFunctions[n].name

##---------------------------
## Methods
##---------------------------

proc execute(f: Function, xl: ExpressionList): Value {.inline.} =
    ## Execute user function with given ExpressionList
    ## ! Call by Statement.execute

    if Stack.len == 1: addContext()
    var oldSeq:Context
    shallowCopy(oldSeq,Stack[1])

    if f.hasNamedArgs:
        var i = 0
        var args = newSeq[(int,Value)](xl.list.len)
        while i<xl.list.len:
            args[i] = (f.args[i], xl.list[i].evaluate())
            inc(i)
        initTopContextWith(args)
    else:
        initTopContextWith(ARGV_HASH,ARR(xl.list.map((x)=>x.evaluate())))

    result = f.body.execute()
    if Returned!=0: 
        Returned = 0

    shallowCopy(Stack[1],oldSeq)
    if Stack[1].len==0: popContext()

proc execute(f: Function, v: Value): Value {.inline.} =
    ## Execute user function with given Value

    # if f.hasContext:
    #     if Stack.len == 1: addContext()
    #     var oldSeq:Context
    #     shallowCopy(oldSeq,Stack[1])
    #     if f.hasNamedArgs:
    #         if v.kind == AV: 
    #             initTopContextWith(zip(f.args,A(v)))
    #         else: initTopContextWith(f.args[0],v)
    #     else: initTopContextWith(ARGV_HASH,v)

    #     result = f.body.execute()
    #     if Returned!=0: 
    #         Returned = 0

    #     shallowCopy(Stack[1],oldSeq)
    #     if Stack[1].len==0: popContext()
    # else:
    if v!=NULL:
        let stored = getAndSetSymbol(ARGV_HASH,v)
        if f.hasNamedArgs:
            if v.kind == AV: 
                var i = 0
                while i<f.args.len:
                    resetSymbol(f.args[i],A(v)[i])
                    inc(i)
            else: resetSymbol(f.args[0],v)
        result = f.body.execute()
        discard setSymbol(ARGV_HASH,stored)
    else:
        result = f.body.execute()

proc validate(xl: ExpressionList, i: int, name: string, req: int): Value {.inline.} =
    result = xl.list[i].evaluate()

    if bitand(result.kind,req)==0:
        let expected = "sth"#req.map((x) => $(x)).join(" or ")
        IncorrectArgumentValuesError(i, name, req, result.kind)
        
proc getOneLineDescription*(f: SystemFunction): string =
    ## Get one-line description for given System function
    ## ! Called only from the Console module

    let args = "(ARGS)"
    #    if f.req.len>0: f.req.map((x) => "(" & x.map((y) => valueKindToPrintable(y)).join(",") & ")").join(" / ")
    #    else: "()"

    #let ret = "[" & f.ret.join(",").valueKindToPrintable() & "]"

    result = strutils.alignLeft("\e[1m" & f.name & "\e[0m",20) & " " & args & " \x1B[0;32m->\x1B[0;37m "# & ret

proc getFullDescription*(f: SystemFunction): string =
    ## Get full description for given System function
    ## ! Called only from the Console module

    let args = "(ARGS)"
    #    if f.req.len>0: f.req.map((x) => "(" & x.map((y) => valueKindToPrintable(y)).join(",") & ")").join(" / ")
    #    else: "()"

    #let ret = "[" & f.ret.join(",").valueKindToPrintable() & "]"

    result  = "Function : \e[1m" & f.name & "\e[0m" & "\n"
    #result &= "       # : " & f.desc & "\n\n"
    #result &= "   usage : " & f.name & " " & args & "\n"
    #result &= "        \x1B[0;32m->\x1B[0;37m " & ret & "\n"

when defined(unittest):
    proc callFunction(f: string, v: seq[Value]): Value = 
        ## Call a function by string with a given array of Value's
        ## ! Used only for UnitTests

        let fun = getSystemFunctionInstance(f)
        let exprs = newExpressionList()

        for val in v:
            discard exprs.addExpression(expressionFromArgument(Argument(kind: literalArgument, v: val)))

        result = fun.call(fun,exprs)
        
    