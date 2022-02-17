######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
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
    import algorithm

    import helpers/url
    import helpers/webviews

    import vm/[exec, parse]

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Ui"

    when not defined(NOWEBVIEW):

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
                "fixed"     : ({Logical},"window shouldn't be resizable"),
                "debug"     : ({Logical},"add inspector console")
            },
            returns     = {String,Nothing},
            example     = """
                webview "Hello world!"
                ; (opens a webview windows with "Hello world!")
                ;;;;
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

                if (let aTitle = popAttr("title"); aTitle != VNULL): title = aTitle.s
                if (let aWidth = popAttr("width"); aWidth != VNULL): width = aWidth.i
                if (let aHeight = popAttr("height"); aHeight != VNULL): height = aHeight.i

                var targetUrl = x.s

                if not isUrl(x.s):
                    targetUrl = "data:text/html, " & x.s

                let wv: Webview = newWebview(
                    title       = title, 
                    url         = targetUrl, 
                    width       = width, 
                    height      = height, 
                    resizable   = not fixed, 
                    debug       = withDebug,
                    callHandler = proc (call: WebviewCallKind, value: Value): Value =
                        result = VNULL
                        if call==FunctionCall:
                            if Syms.hasKey(value.d["method"].s) and Syms[value.d["method"].s].kind==Function:
                                let prevSP = SP

                                let fun = Syms[value.d["method"].s]
                                for v in value.d["args"].a.reversed:
                                    push(v)

                                if fun.fnKind==UserFunction:
                                    discard execBlock(fun.main, args=fun.params.a, isFuncBlock=true, imports=fun.imports, exports=fun.exports)
                                else:
                                    fun.action()

                                if SP > prevSP:
                                    result = pop()
                        elif call==ExecuteCode:
                            let parsed = doParse(value.s, isFile=false)
                            let prevSP = SP
                            if not isNil(parsed):
                                discard execBlock(parsed)
                            if SP > prevSP:
                                result = pop()
                )

                builtin "eval",
                    alias       = unaliased, 
                    rule        = PrefixPrecedence,
                    description = "Evaluate JavaScript code in active webview",
                    args        = {
                        "js": {String}
                    },
                    attrs       = NoAttrs,
                    returns     = {Integer,Nothing},
                    example     = """
                    """:
                        ##########################################################
                        wv.evaluate(x.s)

                wv.show()

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)