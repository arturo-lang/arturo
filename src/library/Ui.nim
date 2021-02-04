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

import os
import extras/webview

import helpers/url as UrlHelper
import helpers/webview as WebviewHelper

import vm/[common, env, exec, globals, stack, value]

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Ui"

    # TODO needs cleanup & revision
    builtin "webview",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "show webview window with given url or html and dictionary of callback functions",
        args        = {
            "content"   : {String,Literal},
            "callbacks" : {Dictionary}
        },
        attrs       = {
            "title"     : ({String},"set window title"),
            "width"     : ({Integer},"set window width"),
            "height"    : ({Integer},"set window height")
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

            # discard webview(title.cstring, targetUrl.cstring, width.cint, height.cint, 1.cint)

            when not defined(MINI):

                let wv = newWebview(title=title, 
                                    url=targetUrl, 
                                    width=width, 
                                height=height, 
                                resizable=true, 
                                    debug=true,
                                    cb=nil)

                for key,binding in y.d:
                    let meth = key

                    wv.bindMethod("webview", meth, proc (param: Value): string =
                        # echo "calling method: " & meth
                        # echo " - with argument: " & $(param)
                        # echo " - for parameter: " & $(binding.params.a[0])

                        var args: ValueArray = @[binding.params.a[0]]
                        stack.push(param)
                        discard execBlock(binding.main, execInParent=true, args=args)
                        let got = stack.pop().s
                        #echo " - got: " & $(got)

                        discard wv.eval(got)
                    )

                # proc wvCallback (param: seq[string]): string =
                #     echo "wvCallback :: " & param
                #     echo "executing something..."
                #     discard wv.eval("console.log('execd in JS');")
                #     echo "returning value..."
                #     return "returned value"

                # wv.bindProc("webview","run",wvCallback)

                wv.run()
                wv.exit()

                # # showWebview(title=title, 
                # #               url=targetUrl, 
                # #             width=width, 
                # #            height=height, 
                # #         resizable=true, 
                # #             debug=false,
                # #          bindings=y.d)

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)