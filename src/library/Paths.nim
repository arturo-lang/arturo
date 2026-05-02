#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: library/Path.nim
#=======================================================

## The main Paths module 
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import os, sequtils, sugar

    import helpers/path
    import helpers/url

    import vm/lib
    import vm/runtime

#=======================================
# Definitions
#=======================================

proc defineModule*(moduleName: string) =

    #----------------------------
    # Functions
    #----------------------------

    when not defined(WEB):

        builtin "absolute",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "get absolute path for given path, based on current script's location",
            args        = {
                "path"  : {String}
            },
            attrs       = NoAttrs,
            returns     = {String},
            example     = """
            ; we are in folder: /Users/admin/Desktop
            ; and have a file at: /Users/admin/Desktop/subfolder/test.txt
            
            print absolute "../subfolder/test.txt"
            ; /Users/admin/subfolder/test.txt
            
            print absolute "./test.txt"
            ; /Users/admin/Desktop/test.txt
            """:
                #=======================================================
                dispatch:
                    String(s):
                        let relativePath = joinPath(currentFrame().folder, s)
                        let fullPath = joinPath(getCurrentDir(), relativePath)

                        push(newString(normalizedPath(fullPath)))

        # TODO(Paths\extract) implement for Web/JS builds
        #  labels: library,enhancement,web
        builtin "extract",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "extract components from path, url, or color",
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
                #=======================================================
                dispatch:
                    Color(c):
                        on red:        push newInteger(RGBfromColor(c).r)
                        on green:      push newInteger(RGBfromColor(c).g)
                        on blue:       push newInteger(RGBfromColor(c).b)
                        on alpha:      push newInteger(RGBfromColor(c).a)
                        on hsl:
                            let hsl = RGBtoHSL(c)
                            push newDictionary({
                                "hue"       : newInteger(hsl.h),
                                "saturation": newFloating(hsl.s),
                                "luminosity": newFloating(hsl.l)
                            }.toOrderedTable)
                        on hsv:
                            let hsv = RGBtoHSV(c)
                            push newDictionary({
                                "hue"       : newInteger(hsv.h),
                                "saturation": newFloating(hsv.s),
                                "value"     : newFloating(hsv.v)
                            }.toOrderedTable)
                        on hue:        push newInteger(RGBtoHSL(c).h)
                        on saturation: push newFloating(RGBtoHSL(c).s)
                        on luminosity: push newFloating(RGBtoHSL(c).l)
                        _:
                            let rgb = RGBfromColor(c)
                            push newDictionary({
                                "red"   : newInteger(rgb.r),
                                "green" : newInteger(rgb.g),
                                "blue"  : newInteger(rgb.b),
                                "alpha" : newInteger(rgb.a)
                            }.toOrderedTable)
                    String(s):
                        if isUrl(s):
                            let details = parseUrlComponents(s)
                            if   hadAttr("scheme"):   push(details["scheme"])
                            elif hadAttr("host"):     push(details["host"])
                            elif hadAttr("port"):     push(details["port"])
                            elif hadAttr("user"):     push(details["user"])
                            elif hadAttr("password"): push(details["password"])
                            elif hadAttr("path"):     push(details["path"])
                            elif hadAttr("query"):    push(details["query"])
                            elif hadAttr("anchor"):   push(details["anchor"])
                            else:                     push(newDictionary(details))
                        else:
                            let details = parsePathComponents(s)
                            if   hadAttr("directory"): push(details["directory"])
                            elif hadAttr("basename"):  push(details["basename"])
                            elif hadAttr("filename"):  push(details["filename"])
                            elif hadAttr("extension"): push(details["extension"])
                            else:                      push(newDictionary(details))

        builtin "list",
            alias       = unaliased, 
            op          = opNop,
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
                #=======================================================
                bindAttrs:
                    recursive: Logical
                    relative:  Logical

                dispatch:
                    String(path):
                        var contents: seq[string]

                        if recursive:
                            contents = toSeq(walkDirRec(path, relative = relative))
                        else:
                            contents = toSeq(walkDir(path, relative = relative)).map((x) => x[1])

                        push(newStringBlock(contents))

        builtin "normalize",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "get normalized version of given path",
            args        = {
                "path"  : {String,Literal,PathLiteral}
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
                #=======================================================
                bindAttrs:
                    executable: Logical
                    tilde:      Logical

                dispatchWithLiteral:
                    String(s):
                        value:
                            var ret = if tilde: s.expandTilde() else: s
                            if executable:
                                ret.normalizeExe()
                                push(newString(ret))
                            else:
                                push(newString(normalizedPath(ret)))
                        inplace:
                            if tilde:
                                s = s.expandTilde()
                            if executable: s.normalizeExe()
                            else:          s.normalizePath()

        builtin "relative",
            alias       = dotslash, 
            op          = opNop,
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
                #=======================================================
                push(newString(joinPath(currentFrame().folder, x.s)))

    #----------------------------
    # Predicates
    #----------------------------

    when not defined(WEB):
        
        builtin "absolute?",
            alias       = unaliased,
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "check if given path is an absolute path",
            args        = {
                "path"  : {String}
            },
            attrs       = NoAttrs,
            returns     = {Logical},
            example     = """
            absolute? "/usr/bin"        ; => true
            absolute? "usr/bin"         ; => false
            """:
                #=======================================================
                push(newLogical(isAbsolute(x.s)))
