######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: library/Ui.nim
######################################################

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import vm/lib

when not defined(NOWEBVIEW):
    import os

    import helpers/jsonobject
    import helpers/url
    import helpers/webview

    import vm/[env, exec, parse]

#=======================================
# Methods
#=======================================

var 
    CallbackLookup*: ValueArray = @[]

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Ui"

    when not defined(NOWEBVIEW):

        builtin "register",
            alias       = unaliased, 
            rule        = PrefixPrecedence,
            description = "Get whatever",
            args        = {
                "valueA": {Function}
            },
            attrs       = NoAttrs,
            returns     = {Nothing},
            example     = """
            """:
                ##########################################################
                var indx = CallbackLookup.find(x)
                if indx == -1:
                    CallbackLookup.add(x)
                    indx = CallbackLookup.len - 1

                push newInteger(indx)

        builtin "webview",
            alias       = unaliased, 
            rule        = PrefixPrecedence,
            description = "show webview window with given url or html source",
            args        = {
                "content"   : {String,Literal}
            },
            attrs       = {
                "title"     : ({String},"set window title"),
                "width"     : ({Integer},"set window width"),
                "height"    : ({Integer},"set window height"),
                "fixed"     : ({Boolean},"window shouldn't be resizable"),
                "debug"     : ({Boolean},"add inspector console")
            },
            returns     = {String,Nothing},
            example     = """
                webview "Hello world!"
                ; (opens a webview windows with "Hello world!")
                
                webview .width:  200 
                        .height: 300
                        .title:  "My webview app"
                ---
                    <h1>This is my webpage</h1>
                    <p>
                        This is some content
                    </p>
                ---
                ; (opens a webview with given attributes)
            """:
                ##########################################################
                var title = "Arturo"
                var width = 640
                var height = 480
                var fixed = (popAttr("fixed")!=VNULL)
                var withDebug = (popAttr("debug")!=VNULL)

                if (let aTitle = popAttr("title"); aTitle != VNULL):
                    title = aTitle.s

                if (let aWidth = popAttr("width"); aWidth != VNULL):
                    width = aWidth.i

                if (let aHeight = popAttr("height"); aHeight != VNULL):
                    height = aHeight.i

                var targetUrl = x.s

                if not isUrl(x.s):
                    targetUrl = joinPath(TmpDir,"artview.html")
                    writeFile(targetUrl, x.s)
                    targetUrl = "file://" & targetUrl

                var callback: string

                let wv = createWebview(
                    title       = title, 
                    url         = targetUrl, 
                    width       = width, 
                    height      = height, 
                    resizable   = not fixed, 
                    debug       = withDebug,
                    handler     = proc (s: cstring, r: cstring, a: pointer) =
                        # echo "handler called"
                        # echo "s: " & $(s)
                        # echo "r: " & $(r)
                        # echo "a: " & $(cast[int](a))
                        let got = valueFromJson($r)
                        echo "got: " & $(got)
                        let meth = got.a[0]
                        let args = got.a[1]
                        push args

                        if meth.kind==String:
                            callByName(meth.s)
                        else:
                            let metho = CallbackLookup[meth.i]
                        # if meth.s[0]=='0':
                        #     let metho = meth.s.strip(chars={'0'})
                        #     echo "metho: " & $(metho)
                        #     let parsed = doParse(metho, isFile=false)
                        #     if not isNil(parsed):
                        #         discard execBlock(parsed)

                        #     let funct = pop()
                            callFunction(metho)
                        #else:
                            
                        # if meth.kind==String:
                        #     callByName(meth.s)
                        # else:
                        #     let funcAddr = cast[Value](meth.i)
                        #     callFunction(funcAddr)
                        # if got.a.len>2:
                        #     echo "it's a function"
                        #     echo "value addr: " & $(got.a[2].i)
                        #     let val = cast[Value](got.a[2].i)
                        #     echo $(val)
                        #     dump(val)
                        #     push args
                        #     callFunction(val)
                        # else:
                        #     echo "it's a method"
                        #     push args
                        #     callByName(meth)
                        # if got.a.len>2:
                        # e
                        # echo "got: " & $(got)

                        # push(GetKey(got.a[0].d, "args"))
                        # callByName(GetKey(got.a[0].d, "method").s)
                )

                builtin "exec",
                    alias       = unaliased, 
                    rule        = PrefixPrecedence,
                    description = "Get whatever",
                    args        = {
                        "value" : {String}
                    },
                    attrs       = NoAttrs,
                    returns     = {Nothing},
                    example     = """
                    """:
                        ##########################################################
                        echo "in EXEC:"
                        echo "executing exec: " & $(x.s)
                        let query = "JSON.stringify(eval(\"" & x.s & "\"))"
                        wv.eval(query)

                # var callback: Value

                # var handler = 



                builtin "eval",
                    alias       = unaliased, 
                    rule        = PrefixPrecedence,
                    description = "Get whatever",
                    args        = {
                        "valueA": {String},
                        "callback": {Function}
                    },
                    attrs       = NoAttrs,
                    returns     = {Nothing},
                    example     = """
                    """:
                        ##########################################################
                        echo "in EVAL:"
                        var indx = CallbackLookup.find(y)
                        if indx == -1:
                            CallbackLookup.add(y)
                            indx = CallbackLookup.len - 1
                        #if CallbackLookup.contains(y):

                        echo "executing eval: " & $(x.s)
                        let query = "JSON.stringify(evaluate(" & $(indx)  & ",\"" & x.s & "\"))"
                        echo "query: " & $(query)
                        #callback = y    
                        # wv.bindProc("returnVal", proc (s: cstring, r: cstring, a: pointer) {.cdecl.} =
                        #     echo "returned val: " & $(r)
                        # , nil)
                        wv.eval(query)

                # echo "before running"
                wv.run()
                # echo "after running"
                #wv.destroy()

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)