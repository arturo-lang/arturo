######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: library/Path.nim
######################################################

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import os, sequtils, sugar

    import helpers/colors as colorsHelper
    import helpers/path
    import helpers/url

import vm/lib
when not defined(WEB):
    import vm/env
when defined(SAFE):
    import vm/errors

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Paths"

    when not defined(WEB):

        # TODO(Paths\extract) implement for Web/JS builds
        #  labels: library,enhancement,web
        builtin "extract",
            alias       = unaliased, 
            rule        = PrefixPrecedence,
            description = "extract components from path",
            args        = {
                "path"  : {String,Color}
            },
            attrs       = {
                "directory" : ({Logical},"get path directory"),
                "basename"  : ({Logical},"get path basename (filename+extension)"),
                "filename"  : ({Logical},"get path filename"),
                "extension" : ({Logical},"get path extension"),
                "scheme"    : ({Logical},"get scheme field from URL"),
                "host"      : ({Logical},"get host field from URL"),
                "port"      : ({Logical},"get port field from URL"),
                "user"      : ({Logical},"get user field from URL"),
                "password"  : ({Logical},"get password field from URL"),
                "path"      : ({Logical},"get path field from URL"),
                "query"     : ({Logical},"get query field from URL"),
                "anchor"    : ({Logical},"get anchor field from URL"),
                "red"       : ({Logical},"get red component from color"),
                "green"     : ({Logical},"get green component from color"),
                "blue"      : ({Logical},"get blue component from color"),
                "alpha"     : ({Logical},"get alpha component from color"),
                "hsl"       : ({Logical},"get HSL representation from color"),
                "hsv"       : ({Logical},"get HSV representation from color"),
                "hue"       : ({Logical},"get hue component from color"),
                "saturation": ({Logical},"get saturation component from color"),
                "luminosity": ({Logical},"get luminosity component from color")
            },
            returns     = {String,Dictionary},
            example     = """
            path: "/this/is/some/path.txt"

            print extract.directory path        ; /this/is/some
            print extract.basename path         ; path.txt
            print extract.filename path         ; path
            print extract.extension path        ; .txt

            print extract path 
            ; [directory:/this/is/some basename:path.txt filename:path extension:.txt]
            ..........
            url: "http://subdomain.website.com:8080/path/to/file.php?q=something#there"

            print extract.scheme url            ; http
            print extract.host url              ; subdomain.website.com
            print extract.port url              ; 8080
            print extract.user url              ; 
            print extract.password url          ;
            print extract.path url              ; /path/to/file.php
            print extract.query url             ; q=something
            print extract.anchor url            ; there

            print extract url
            ; [scheme:http host:subdomain.website.com port:8080 user: password: path:/path/to/file.php query:q=something anchor:there]
            ..........
            extract #magenta
            ; => [red:255 green:0 blue:255]

            extract.red #FF126D
            ; => 255

            extract.hsl #magenta
            ; => [hue:300 saturation:1.0 luminosity:0.5]

            extract.hue #magenta
            ; => 300
            """:
                ##########################################################
                if x.kind==Color:
                    if (popAttr("red") != VNULL):
                        push newInteger(RGBfromColor(x.l).r)
                    elif (popAttr("green") != VNULL):
                        push newInteger(RGBfromColor(x.l).g)
                    elif (popAttr("blue") != VNULL):
                        push newInteger(RGBfromColor(x.l).b)
                    elif (popAttr("alpha") != VNULL):
                        push newInteger(RGBfromColor(x.l).a)
                    elif (popAttr("hsl") != VNULL):
                        let hsl = RGBtoHSL(x.l)
                        push newDictionary({
                            "hue"       : newInteger(hsl.h),
                            "saturation": newFloating(hsl.s),
                            "luminosity": newFloating(hsl.l)
                        }.toOrderedTable)
                    elif (popAttr("hsv") != VNULL):
                        let hsv = RGBtoHSV(x.l)
                        push newDictionary({
                            "hue"       : newInteger(hsv.h),
                            "saturation": newFloating(hsv.s),
                            "value"     : newFloating(hsv.v)
                        }.toOrderedTable)
                    elif (popAttr("hue") != VNULL):
                        let hsl = RGBtoHSL(x.l)
                        push newInteger(hsl.h)
                    elif (popAttr("saturation") != VNULL):
                        let hsl = RGBtoHSL(x.l)
                        push newFloating(hsl.s)
                    elif (popAttr("luminosity") != VNULL):
                        let hsl = RGBtoHSL(x.l)
                        push newFloating(hsl.l)
                    else:
                        let rgb = RGBfromColor(x.l)
                        push newDictionary({
                            "red"   : newInteger(rgb.r),
                            "green" : newInteger(rgb.g),
                            "blue"  : newInteger(rgb.b),
                            "alpha" : newInteger(rgb.a)
                        }.toOrderedTable)
                else:
                    if isUrl(x.s):
                        let details = parseUrlComponents(x.s)

                        if (popAttr("scheme") != VNULL):
                            push(details["scheme"])
                        elif (popAttr("host") != VNULL):
                            push(details["host"])
                        elif (popAttr("port") != VNULL):
                            push(details["port"])
                        elif (popAttr("user") != VNULL):
                            push(details["user"])
                        elif (popAttr("password") != VNULL):
                            push(details["password"])
                        elif (popAttr("path") != VNULL):
                            push(details["path"])
                        elif (popAttr("query") != VNULL):
                            push(details["query"])
                        elif (popAttr("anchor") != VNULL):
                            push(details["anchor"])
                        else:
                            push(newDictionary(details))
                    else:
                        let details = parsePathComponents(x.s)

                        if (popAttr("directory") != VNULL):
                            push(details["directory"])
                        elif (popAttr("basename") != VNULL):
                            push(details["basename"])
                        elif (popAttr("filename") != VNULL):
                            push(details["filename"])
                        elif (popAttr("extension") != VNULL):
                            push(details["extension"])
                        else:
                            push(newDictionary(details))

        builtin "list",
            alias       = unaliased, 
            rule        = PrefixPrecedence,
            description = "get files in given path",
            args        = {
                "path"  : {String}
            },
            attrs       = {
                "recursive" : ({Logical}, "perform recursive search"),
                "relative"  : ({Logical}, "get relative paths"),
            },
            returns     = {Block},
            example     = """
            loop list "." 'file [
                print file
            ]
            
            ; tests
            ; var
            ; data.txt
            """:
                ##########################################################
                when defined(SAFE): RuntimeError_OperationNotPermitted("list")
                let recursive = (popAttr("recursive") != VNULL)
                let relative = (popAttr("relative") != VNULL)
                let path = x.s

                var contents: seq[string]

                if recursive:
                    contents = toSeq(walkDirRec(path, relative = relative))
                else:
                    contents = toSeq(walkDir(path, relative = relative)).map((x) => x[1])

                push(newStringBlock(contents))

        # TODO(Paths\module) Re-implement & change behavior of built-in function
        #  This should actually check if the aforementioned module/package is installed first.
        #  If not, it should look it up - and if available online - download it and install it.
        #  This obviously goes hand-in-hand with the development & implementation of Arturo's new package manager.
        #  labels: library, package manager, enhancement
        builtin "module",
            alias       = unaliased, 
            rule        = PrefixPrecedence,
            description = "get path for given module name",
            args        = {
                "name"  : {String,Literal}
            },
            attrs       = NoAttrs,
            returns     = {String,Null},
            example     = """
            print module 'html        ; /usr/local/lib/arturo/html.art
            ..........
            do.import module 'html    ; (imports given module)
            """:
                ##########################################################
                push(newString(HomeDir & ".arturo/lib/" & x.s & ".art"))
        
        builtin "normalize",
            alias       = dotslash, 
            rule        = PrefixPrecedence,
            description = "get normalized version of given path",
            args        = {
                "path"  : {String,Literal}
            },
            attrs       = {
                "executable"    : ({Logical},"treat path as executable"),
                "tilde"         : ({Logical},"expand tildes in path")
            },
            returns     = {String,Nothing},
            example     = """
            normalize "one/../two/../../three"
            ; => ../three

            normalize "~/one/../two/../../three"
            ; => three
            ..........
            normalize.tilde "~/one/../two/../../three"
            ; => /Users/three

            normalize.tilde "~/Documents"
            ; => /Users/drkameleon/Documents
            ..........
            normalize.executable "myscript"
            ; => ./myscript          
            """:
                ##########################################################
                if (popAttr("executable") != VNULL):
                    if x.kind==Literal:
                        if (popAttr("tilde") != VNULL):
                            InPlace.s = InPlaced.s.expandTilde()
                        InPlace.s.normalizeExe()
                    else:
                        var ret: string
                        if (popAttr("tilde") != VNULL):
                            ret = x.s.expandTilde()
                        else:
                            ret = x.s
                        ret.normalizeExe()
                        push(newString(ret))
                else:
                    if x.kind==Literal:
                        if (popAttr("tilde") != VNULL):
                            InPlace.s = InPlaced.s.expandTilde()
                        InPlace.s.normalizePath()
                    else:
                        if (popAttr("tilde") != VNULL):
                            push(newString(normalizedPath(x.s.expandTilde())))
                        else:
                            push(newString(normalizedPath(x.s)))

        constant "path",
            alias       = unaliased,
            description = "common path constants":
                newDictionary(getPathInfo())

        # TODO(Paths\relative) Test and possible re-implement built-in function
        #  Right now, Arturo's path handling is a complete mess IMHO. And `relative` is one of the main culprits - along with our handling of the "PathStack" in VM/Env.
        #  labels: vm, library, enhancement, bug, critical
        builtin "relative",
            alias       = dotslash, 
            rule        = PrefixPrecedence,
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
                push(newString(joinPath(env.currentPath(),x.s)))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)