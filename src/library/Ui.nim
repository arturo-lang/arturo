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
    import os

    import helpers/jsonobject
    import helpers/url
    import helpers/webview

    import vm/[env, exec]

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

                let wv = createWebview(
                    title       = title, 
                    url         = targetUrl, 
                    width       = width, 
                    height      = height, 
                    resizable   = not fixed, 
                    debug       = withDebug,
                    handler     = proc (w: Webview, arg: cstring) =
                        let got = valueFromJson($arg)
                        push(GetKey(got.d, "args"))
                        callByName(GetKey(got.d, "method").s)
                )

                builtin "eval",
                    alias       = unaliased, 
                    rule        = PrefixPrecedence,
                    description = "Get whatever",
                    args        = {
                        "valueA": {String}
                    },
                    attrs       = NoAttrs,
                    returns     = {Integer,Nothing},
                    example     = """
                    """:
                        ##########################################################
                        let query = "JSON.stringify(eval(\"" & x.s & "\"))"
                        var ret: Value = newString($(wv.getEval((cstring)query)))
                        push(ret)

                wv.run()
                wv.exit()

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)