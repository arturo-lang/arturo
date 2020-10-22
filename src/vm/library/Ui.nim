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

import ../env, ../stack, ../value
import ../../utils

#=======================================
# Methods
#=======================================

template Webview*():untyped =
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
