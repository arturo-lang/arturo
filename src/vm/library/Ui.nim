######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Ui.nim
######################################################

#=======================================
# Libraries
#=======================================

import vm/env, vm/stack, vm/value

#=======================================
# Methods
#=======================================

template Webview*():untyped =
    # EXAMPLE:
    # webview "Hello world!"
    # ; (opens a webview windows with "Hello world!")
    #
    # webview .width:  200 
    #         .height: 300
    #         .title:  "My webview app"
    # ---
    # ____<h1>This is my webpage</h1>
    # ____<p>
    # ________This is some content
    # ____</p>
    # ---
    # ; (opens a webview with given attributes)

    require(opWebview)

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

    showWebview(title=title, 
                  url=targetUrl, 
                width=width, 
               height=height, 
            resizable=true, 
                debug=false)
