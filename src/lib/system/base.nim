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

proc Base_exec*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,FV)
    let v1 = VALID(1,ANY)

    result = FN(v0).execute(v1)

proc Base_if*[F,X,V](f: F, xl: X): V {.inline.} =
    if B(VALID(0,BV)):
        result = FN(VALID(1,FV)).execute(NULL)
    else:
        if xl.list.len == 3:
            result = FN(VALID(2,FV)).execute(NULL)
        else:
            result = FALSE

proc Base_import*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    
    result = importModule(S(v0))

proc Base_loop*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,AV|DV|BV|IV)

    {.computedGoTo.}
    case v0.kind
        of AV:
            let v1 = VALID(1,FV)
            var i = 0
            while i < A(v0).len:
                result = FN(v1).execute(A(v0)[i])
                inc(i)
        of DV:
            let v1 = VALID(1,FV)
            for val in D(v0):
                result = FN(v1).execute(ARR(@[STR(getSymbolForHash(val[0])),val[1]]))
        of BV:
            if not B(v0): return NULL
            let v1 = VALID(1,FV)
            while true:
                result = FN(v1).execute(NULL)
                if not B(VALID(0,BV)): break
        of IV:
            let v1 = VALID(1,FV)
            var i = 0
            while i < I(v0):
                result = FN(v1).execute(NULL)
                inc(i)

        else: result = NULL

proc Base_new*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,ANY)

    result = valueCopy(v0)

proc Base_panic*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    ProgramPanic(S(v0))

proc Base_return*[F,X,V](f: F, xl: X): V {.inline.} =
    Returned = VALID(0,ANY)

    result = NULL

proc Base_syms*[F,X,V](f: F, xl: X): V {.inline.} =
    inspectStack()

    result = NULL

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

# when defined(unittest):

#     suite "Library: system/core":
    