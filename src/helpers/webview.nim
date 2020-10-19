######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: helpers/webview.nim
######################################################

#=======================================
# Libraries
#=======================================

when not defined(MINI):
    import extras/webview

import vm/stack, vm/value

#=======================================
# Methods
#=======================================

when not defined(MINI):
    proc showWebview*(title="WebView", url="", 
                      width=640, height=480, 
                      resizable=true, debug=false) =

        let wv = newWebview(title=title, 
                              url=url, 
                            width=width, 
                           height=height, 
                        resizable=true, 
                            debug=false,
                               cb=nil)
        wv.run()
        wv.exit()

else:
    proc showWebview*(title="WebView", url="", 
                      width=640, height=480, 
                      resizable=true, debug=false) =

        echo "- feature not supported in MINI builds"
