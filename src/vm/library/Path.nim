######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Path.nim
######################################################

#=======================================
# Libraries
#=======================================

import helpers/path, helpers/url

import vm/env, vm/stack, vm/value

#=======================================
# Methods
#=======================================

template Extract*():untyped =
    require(opExtract)

    if isUrl(x.s):
        let details = parseUrlComponents(x.s)

        if (popAttr("scheme") != VNULL):
            stack.push(details["scheme"])
        elif (popAttr("host") != VNULL):
            stack.push(details["host"])
        elif (popAttr("port") != VNULL):
            stack.push(details["port"])
        elif (popAttr("user") != VNULL):
            stack.push(details["user"])
        elif (popAttr("password") != VNULL):
            stack.push(details["password"])
        elif (popAttr("path") != VNULL):
            stack.push(details["path"])
        elif (popAttr("query") != VNULL):
            stack.push(details["query"])
        elif (popAttr("anchor") != VNULL):
            stack.push(details["anchor"])
        else:
            stack.push(newDictionary(details))

        discard
    else:
        let details = parsePathComponents(x.s)

        if (popAttr("directory") != VNULL):
            stack.push(details["directory"])
        elif (popAttr("basename") != VNULL):
            stack.push(details["basename"])
        elif (popAttr("filename") != VNULL):
            stack.push(details["filename"])
        elif (popAttr("extension") != VNULL):
            stack.push(details["extension"])
        else:
            stack.push(newDictionary(details))

template Module*():untyped =
    # EXAMPLE:
    # print module 'html        ; /usr/local/lib/arturo/html.art
    #
    # do.import module 'html    ; (imports given module)

    require(opModule)

    stack.push(newString("/usr/local/lib/arturo/" & x.s & ".art"))

template Relative*():untyped =
    # EXAMPLE:
    # ; we are in folder: /Users/admin/Desktop
    #
    # print relative "test.txt"
    # ; /Users/admin/Desktop/test.txt
    
    require(opRelative)

    stack.push(newString(joinPath(env.currentPath(),x.s)))
