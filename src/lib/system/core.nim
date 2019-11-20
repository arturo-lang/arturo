#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/core.nim
  * @description: core operations
  *****************************************************************]#

#[######################################################
    Helpers
  ======================================================]#

proc importModule(path: string): Value =
    ## Import a specific module from given path and return value
    ## ! Used mainly from the Core.import function

    var pathIndex = 0
    var finalPath = Paths[pathIndex].joinPath(path)

    while not fileExists(finalPath) and pathIndex<Paths.len:
        inc(pathIndex)
        finalPath = Paths[pathIndex].joinPath(path)    

    if not fileExists(finalPath): 
        cmdlineError("path not found: '" & path & "'")

    var (dir, _, _) = splitFile(path)
    Paths.add(dir)

    var buff = yy_scan_string(readFile(finalPath))

    yylineno = 0
    yyfilename = finalPath
    FileName = finalPath

    QuitOnError = true

    yy_switch_to_buffer(buff)
    
    MainProgram = nil
    if yyparse()==0:
        yy_delete_buffer(buff)

        result = MainProgram.execute()

#[######################################################
    Functions
  ======================================================]#

proc Core_exec*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = FN(v[0]).execute(v[1])

proc Core_if*[F,X,V](f: F, xl: X): V {.inline.} =
    if B(VALID(0,BV)):
        result = FN(VALID(1,FV)).execute(NULL)
    else:
        if xl.list.len == 3:
            result = FN(VALID(2,FV)).execute(NULL)
        else:
            result = FALSE

proc Core_import*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)
    
    result = importModule(S(v[0]))

proc Core_loop*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV or BV or IV) #xl.list[0].validate("loop",AV or BV or IV)#xl.validate(f)

    case v0.kind
        of AV:
            var i = 0
            while i < A(v0).len:
                result = FN(VALID(1,FV)).execute(A(v0)[i])
                inc(i)
        # of DV:
        #     for val in D(v[0]).list:
        #         result = FN(v[1]).execute(ARR(@[STR(val[0]),val[1]]))
        of BV:
            if not B(v0): return NULL
            while true:
                result = FN(VALID(1,FV)).execute(NULL)
                if not B(xl.list[0].evaluate()): break
        of IV:
            var i = 0
            while i < I(v0):
                result = FN(VALID(1,FV)).execute(NULL)
                inc(i)

        else: result = NULL

proc Core_new*[F,X,V](f: F, xl: X): V {.inline.} =
    let v =  xl.validate(f)

    result = valueCopy(v[0])

proc Core_panic*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    ProgramPanic(S(v[0]))

proc Core_return*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    Returned = v[0]

    result = NULL
    #var ret = newException(ReturnValue, "return")
    #ret.value = v[0]

    #raise ret

proc Core_syms*[F,X,V](f: F, xl: X): V {.inline.} =
    inspectStack()

    result = NULL

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

# when defined(unittest):

#     suite "Library: system/core":
    