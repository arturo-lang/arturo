######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
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

import os

import helpers/path as PathHelper
import helpers/url as UrlHelper

import vm/[common, env, globals, stack, value]

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Paths"

    builtin "extract",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
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
            path: "/this/is/some/path.txt"

            print extract.directory path        ; /this/is/some
            print extract.basename path         ; path.txt
            print extract.filename path         ; path
            print extract.extension path        ; .txt

            print extract path 
            ; [directory:/this/is/some basename:path.txt filename:path extension:.txt]

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
        rule        = PrefixPrecedence,
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
    
    builtin "normalize",
        alias       = dotslash, 
        rule        = PrefixPrecedence,
        description = "get normalized version of given path",
        args        = {
            "path"  : {String,Literal}
        },
        attrs       = {
            "executable"    : ({Boolean},"treat path as executable")
        },
        returns     = {String,Nothing},
        # TODO(Paths\normalize) add example for documentation
        #  labels: library,documentation,easy
        example     = """
        """:
            ##########################################################
            if (popAttr("executable") != VNULL):
                if x.kind==Literal:
                    InPlace.s.normalizeExe()
                else:
                    var ret = x.s
                    ret.normalizeExe()
                    stack.push(newString(ret))
            else:
                if x.kind==Literal:
                    InPlace.s.normalizePath()
                else:
                    stack.push(newString(normalizedPath(x.s)))

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
            stack.push(newString(joinPath(env.currentPath(),x.s)))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)