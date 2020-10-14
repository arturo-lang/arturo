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

import vm/stack, vm/value
import utils

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

    let wv = newWebView(title=title, 
                           url=x.s, 
                         width=width, 
                        height=height, 
                     resizable=true, 
                         debug=false,
                            cb=nil)

    wv.run()
