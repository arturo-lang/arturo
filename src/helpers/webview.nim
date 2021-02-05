######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: helpers/webview.nim
######################################################

#=======================================
# Libraries
#=======================================

import std/json, os, osproc, strutils, tables

when not defined(MINI):
    import extras/webview
    import helpers/json as jsonHelper
    import vm/value

#=======================================
# Methods
#=======================================

proc openChromeWindow*(port: int, flags: seq[string] = @[]) =
    var args = " --app=http://localhost:" & port.intToStr & "/ --disable-http-cache"
    for flag in flags:
        args &= " " & flag.strip

    var chromePath: string

    when hostOS == "macosx":
        chromePath = r"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
        if fileExists(absolutePath(chromePath)):
            chromePath = chromePath.replace(" ", r"\ ")
    elif hostOS == "windows":
        chromePath = r"\Program Files (x86)\Google\Chrome\Application\chrome.exe"
    elif hostOS == "linux":
        const chromeNames = ["google-chrome", "chromium-browser", "chromium"]
        for name in chromeNames:
            if execCmd("which " & name) == 0:
                chromePath = name
                break

    let command = chromePath & args
    if execCmd(command) != 0:
        echo "could not open a Chrome window"

when not defined(MINI):
    proc bindMethod*(w: Webview, scope, name: string, p: (proc(param: Value): string)) =

        proc hook(hookParam: string): string =
            var 
                paramVal: Value
                retVal: string
            try:
                paramVal = parseJsonNode(parseJson(hookParam))
                # echo $(jnode)
                # paramVal = jnode.to(P)
            except:
                return "parse args failed: " & getCurrentExceptionMsg()
            
            retVal = p(paramVal)
            return $(%*retVal) # ==> json
        
        discard eps.hasKeyOrPut(w, newTable[string, TableRef[string, CallHook]]())
        discard hasKeyOrPut(eps[w], scope, newTable[string, CallHook]())
        eps[w][scope][name] = hook
        w.dispatch(proc() = discard w.eval(jsTemplate%[name, scope]))

when not defined(MINI):
    ## Something

else:
    proc showWebview*(title="WebView", url="", 
                      width=640, height=480, 
                      resizable=true, debug=false) =

        echo "- feature not supported in MINI builds"

# proc showWebview*(title="WebView", url="", 
#                   width=640, height=480, 
#                   resizable=true, debug=false, bindings:ValueDict) =

#     let wv = newWebview(title=title, 
#                           url=url, 
#                         width=width, 
#                        height=height, 
#                     resizable=true, 
#                         debug=true,
#                            cb=nil)

#     for key,binding in bindings:
#         let meth = key

#         wv.bindMethod("webview", meth, proc (param: Value): string =
#             echo "calling method: " & meth
#             echo " - with argument: " & $(param)
#             echo " - for parameter: " & $(binding.params.a[0])

#             var args: ValueArray = @[binding.params.a[0]]

#             echo "calling function!"
#             discard execBlock(binding.main, execInParent=true, useArgs=true, args=args)
#             let got = stack.pop().s
#             echo " - got: " & $(got)

#             discard wv.eval(got)
#         )

#     # proc wvCallback (param: seq[string]): string =
#     #     echo "wvCallback :: " & param
#     #     echo "executing something..."
#     #     discard wv.eval("console.log('execd in JS');")
#     #     echo "returning value..."
#     #     return "returned value"

#     # wv.bindProc("webview","run",wvCallback)

#     wv.run()
#     wv.exit()