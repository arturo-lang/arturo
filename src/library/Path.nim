######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Path.nim
######################################################

#=======================================
# Methods
#=======================================

builtin "extract",
    alias       = unaliased, 
    precedence  = PrefixPrecedence,
    description = "extract components from path",
    args        = {
        "path"  : {String}
    },
    attrs       = {
        "directory" : ({Boolean},"get path directory"),
        "basename"  : ({Boolean},"get path basename (filename+extension)"),
        "filename"  : ({Boolean},"get path filename"),
        "extension" : ({Boolean},"get path extension"),
        "scheme"    : ({Boolean},"get scheme field from URL"),
        "host"      : ({Boolean},"get host field from URL"),
        "port"      : ({Boolean},"get port field from URL"),
        "user"      : ({Boolean},"get user field from URL"),
        "password"  : ({Boolean},"get password field from URL"),
        "path"      : ({Boolean},"get path field from URL"),
        "query"     : ({Boolean},"get query field from URL"),
        "anchor"    : ({Boolean},"get anchor field from URL")
    },
    returns     = {String,Dictionary},
    example     = """
    """:
        ##########################################################
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

builtin "module",
    alias       = unaliased, 
    precedence  = PrefixPrecedence,
    description = "get path for given module name",
    args        = {
        "name"  : {String,Literal}
    },
    attrs       = NoAttrs,
    returns     = {String,Null},
    example     = """
        print module 'html        ; /usr/local/lib/arturo/html.art
        
        do.import module 'html    ; (imports given module)
    """:
        ##########################################################
        stack.push(newString(HomeDir & ".arturo/lib/" & x.s & ".art"))

builtin "relative",
    alias       = dotslash, 
    precedence  = PrefixPrecedence,
    description = "get relative path for given path, based on current script's location",
    args        = {
        "path"  : {String}
    },
    attrs       = NoAttrs,
    returns     = {String},
    example     = """
        ; we are in folder: /Users/admin/Desktop
        
        print relative "test.txt"
        ; /Users/admin/Desktop/test.txt
    """:
        ##########################################################
        stack.push(newString(joinPath(env.currentPath(),x.s)))
