#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: library/Files.nim
#=======================================================

## The main Files module 
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

when not defined(WEB):

    import os, sequtils, sugar, times

    import extras/miniz
 
    when not defined(NOPARSERS):
        import helpers/html
        import helpers/markdown
        import helpers/toml
        import helpers/xml

    import helpers/csv
    import helpers/datasource
    import helpers/io
    import helpers/jsonobject
    
import vm/lib

when not defined(WEB):
    import vm/[bytecode, errors, parse]

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    # TODO(Files) more potential built-in function candidates?
    #  labels: library, enhancement, open discussion

    # TODO(Files) add function to enable writing/reading to/from binary files
    #  this should obviously support writing a 16-bit int, and all this
    #  labels: library, enhancement, new feature, open discussion

    when not defined(WEB):

        builtin "copy",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "copy file at path to given destination",
            args        = {
                "file"          : {String},
                "destination"   : {String}
            },
            attrs       = {
                "directory" : ({Logical},"path is a directory")
            },
            returns     = {Nothing},
            example     = """
            copy "testscript.art" normalize.tilde "~/Desktop/testscript.art"
            ; copied file
            ..........
            copy "testfolder" normalize.tilde "~/Desktop/testfolder"
            ; copied whole folder
            """:
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("copy")

                var target = y.s
                if (hadAttr("directory")): 
                    try:
                        copyDirWithPermissions(x.s, move target)
                    except OSError:
                        discard
                else: 
                    try:
                        copyFileWithPermissions(x.s, move target)
                    except OSError:
                        discard

        builtin "delete",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "delete file at given path",
            args        = {
                "file"  : {String}
            },
            attrs       = {
                "directory" : ({Logical},"path is a directory")
            },
            returns     = {Nothing},
            example     = """
            delete "testscript.art"
            ; file deleted
            """:
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("delete")
                
                if (hadAttr("directory")): 
                    try:
                        removeDir(x.s)
                    except OSError:
                        discard
                else: 
                    discard tryRemoveFile(x.s)

        builtin "exists?",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "check if given file exists",
            args        = {
                "file"  : {String}
            },
            attrs       = {
                "directory" : ({Logical},"check for directory")
            },
            returns     = {Logical},
            example     = """
            if exists? "somefile.txt" [ 
                print "file exists!" 
            ]
            """:
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("exists?")

                if (hadAttr("directory")): 
                    push(newLogical(dirExists(x.s)))
                else: 
                    push(newLogical(fileExists(x.s)))

        builtin "hidden?",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "check if file/folder at given path is hidden",
            args        = {
                "file"      : {String}
            },
            attrs       = NoAttrs,
            returns     = {Logical},
            example     = """
            hidden? "README.md"     ; => false
            hidden? ".git"          ; => true
            """:
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("hidden?")

                push newLogical(isHidden(x.s))

        builtin "move",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "move file at path to given destination",
            args        = {
                "file"          : {String},
                "destination"   : {String}
            },
            attrs       = {
                "directory" : ({Logical},"path is a directory")
            },
            returns     = {Nothing},
            example     = """
            move "testscript.art" normalize.tilde "~/Desktop/testscript.art"
            ; moved file
            ..........
            move "testfolder" normalize.tilde "~/Desktop/testfolder"
            ; moved whole folder
            """:
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("move")

                var target = y.s
                if (hadAttr("directory")): 
                    try:
                        moveDir(x.s, move target)
                    except OSError:
                        discard
                else: 
                    try:
                        moveFile(x.s, move target)
                    except OSError:
                        discard

        builtin "permissions",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "check permissions of given file",
            args        = {
                "file"  : {String}
            },
            attrs       = {
                "set"   : ({Dictionary},"set using given file permissions")
            },
            returns     = {Dictionary,Null},
            example     = """
            inspect permissions "bin/arturo"
            ; [ :dictionary
            ;     user    :	[ :dictionary
            ;         read     :		true :boolean
            ;         write    :		true :boolean
            ;         execute  :		true :boolean
            ;     ]
            ;     group   :	[ :dictionary
            ;         read     :		true :boolean
            ;         write    :		false :boolean
            ;         execute  :		true :boolean
            ;     ]
            ;     others  :	[ :dictionary
            ;         read     :		true :boolean
            ;         write    :		false :boolean
            ;         execute  :		true :boolean
            ;     ]
            ; ]
            ..........
            permissions.set:#[others:#[write:true]] "bin/arturo"
            ; gave write permission to 'others'
            """:
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("permissions")

                try:
                    if (checkAttr("set")):
                        var source = x.s
                        var perms: set[FilePermission]

                        if aSet.d.hasKey("user") and aSet.d["user"].d.hasKey("read"): perms.incl(fpUserRead)
                        if aSet.d.hasKey("user") and aSet.d["user"].d.hasKey("write"): perms.incl(fpUserWrite)
                        if aSet.d.hasKey("user") and aSet.d["user"].d.hasKey("execute"): perms.incl(fpUserExec)

                        if aSet.d.hasKey("group") and aSet.d["group"].d.hasKey("read"): perms.incl(fpGroupRead)
                        if aSet.d.hasKey("group") and aSet.d["group"].d.hasKey("write"): perms.incl(fpGroupWrite)
                        if aSet.d.hasKey("group") and aSet.d["group"].d.hasKey("execute"): perms.incl(fpGroupExec)

                        if aSet.d.hasKey("others") and aSet.d["others"].d.hasKey("read"): perms.incl(fpOthersRead)
                        if aSet.d.hasKey("others") and aSet.d["others"].d.hasKey("write"): perms.incl(fpOthersWrite)
                        if aSet.d.hasKey("others") and aSet.d["others"].d.hasKey("execute"): perms.incl(fpOthersExec)

                        setFilePermissions(move source, move perms)
                    else:
                        let perms = getFilePermissions(x.s)
                        var permsDict: ValueDict = {
                            "user": newDictionary({
                                "read"      : newLogical(fpUserRead in perms),
                                "write"     : newLogical(fpUserWrite in perms),
                                "execute"   : newLogical(fpUserExec in perms)
                            }.toOrderedTable),
                            "group": newDictionary({
                                "read"      : newLogical(fpGroupRead in perms),
                                "write"     : newLogical(fpGroupWrite in perms),
                                "execute"   : newLogical(fpGroupExec in perms)
                            }.toOrderedTable),
                            "others": newDictionary({
                                "read"      : newLogical(fpOthersRead in perms),
                                "write"     : newLogical(fpOthersWrite in perms),
                                "execute"   : newLogical(fpOthersExec in perms)
                            }.toOrderedTable)
                        }.toOrderedTable

                        push(newDictionary(permsDict))

                except OSError:
                    push(VNULL)

        # TODO(Files/read) add support for different delimiters when in `.csv` mode
        #  this could be something as simple as `.with:` or `.delimiter:`, or `.delimited:`
        #  also see: https://github.com/arturo-lang/arturo/pull/1008#issuecomment-1450571702
        #  labels:library,enhancement

        # TODO(Files/read) show a warning in case an unsupported attribute is used in MINI builds
        #  right now, passing e.g. `.html` in a MINI build will silently fail, but
        #  the results might be too confusing: 
        #  https://github.com/arturo-lang/arturo/pull/1008#issuecomment-1451696988
        #
        #  In that case, instead of just ignoring the passed option - as we normally do -
        #  we should something: an error? a "warning"? it doesn't matter. But something *must*
        #  be shown to avoid perplexing the user.
        #  labels: library, enhancement
        builtin "read",
            alias       = doublearrowleft, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "read file from given path",
            args        = {
                "file"  : {String}
            },
            attrs       = 
                when not defined(NOPARSERS): 
                    {
                        "lines"         : ({Logical},"read file lines into block"),
                        "json"          : ({Logical},"read Json into value"),
                        "csv"           : ({Logical},"read CSV file into a block of rows"),
                        "delimiter"     : ({Char},   "read CSV file with a specific delimiter"),
                        "withHeaders"   : ({Logical},"read CSV headers"),
                        "html"          : ({Logical},"read HTML into node dictionary"),
                        "xml"           : ({Logical},"read XML into node dictionary"),
                        "markdown"      : ({Logical},"read Markdown and convert to HTML"),
                        "toml"          : ({Logical},"read TOML into value"),
                        "bytecode"      : ({Logical},"read file as Arturo bytecode"),
                        "binary"        : ({Logical},"read as binary"),
                        "file"          : ({Logical},"read as file (throws an error if not valid)")
                    }
                else:
                    {
                        "lines"         : ({Logical},"read file lines into block"),
                        "json"          : ({Logical},"read Json into value"),
                        "csv"           : ({Logical},"read CSV file into a block of rows"),
                        "delimiter"     : ({Char},   "read CSV file with a specific delimiter"),
                        "withHeaders"   : ({Logical},"read CSV headers"),
                        "bytecode"      : ({Logical},"read file as Arturo bytecode"),
                        "binary"        : ({Logical},"read as binary"),
                        "file"          : ({Logical},"read as file (throws an error if not valid)")
                    },
            returns     = {String,Block,Binary},
            example     = """
            ; reading a simple local file
            str: read "somefile.txt"
            ..........
            ; also works with remote urls
            page: read "http://www.somewebsite.com/page.html"
            ..........
            ; we can also "read" JSON data as an object
            data: read.json "mydata.json"
            ..........
            ; or even convert Markdown to HTML on-the-fly
            html: read.markdown "## Hello"     ; "<h2>Hello</h2>"
            """:
                #=======================================================
                if (hadAttr("binary")):
                    var f: File
                    discard f.open(x.s)
                    var b: seq[byte] = newSeq[byte](f.getFileSize())
                    discard f.readBytes(b, 0, f.getFileSize())

                    f.close()

                    push(newBinary(b))
                else:
                    let (src, tp) = getSource(x.s)

                    if (hadAttr("file") and tp != FileData):
                        RuntimeError_FileNotFound(src)

                    if (hadAttr("lines")):
                        push(newStringBlock(src.splitLines()))
                    elif (hadAttr("json")):
                        push(valueFromJson(src))
                    elif (hadAttr("csv")):
                        if checkAttr("delimiter"):
                            let delimiter = aDelimiter.c.char()
                            push(parseCsvInput(src, withHeaders=hadAttr("withHeaders"), withDelimiter=delimiter))
                        else:
                            push(parseCsvInput(src, (hadAttr("withHeaders"))))
                    elif (hadAttr("bytecode")):
                        let bcode = readBytecode(x.s)
                        let parsed = doParse(bcode[0], isFile=false).a[0]
                        push(newBytecode(Translation(constants: parsed.a, instructions: bcode[1])))
                    else:
                        when not defined(NOPARSERS):
                            if (hadAttr("toml")):
                                push(parseTomlString(src))
                            elif (hadAttr("markdown")):
                                push(parseMarkdownInput(src))
                            elif (hadAttr("html")):
                                push(parseHtmlInput(src))
                            elif (hadAttr("xml")):
                                push(parseXMLInput(src))
                            else:
                                push(newString(src))
                        else:
                            push(newString(src))
                            
                    # elif attrs.hasKey("xml"):
                    #     push(parseXmlNode(parseXml(action(x.s))))

        builtin "rename",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "rename file at path using given new path name",
            args        = {
                "file"  : {String},
                "name"  : {String}
            },
            attrs       = {
                "directory" : ({Logical},"path is a directory")
            },
            returns     = {Nothing},
            example     = """
            rename "README.md" "READIT.md"
            ; file renamed
            """:
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("rename")

                var source = x.s
                var target = y.s
                if (hadAttr("directory")): 
                    try:
                        moveDir(move source, move target)
                    except OSError:
                        discard
                else: 
                    try:
                        moveFile(move source, move target)
                    except OSError:
                        discard

        builtin "symlink",
            alias       = unaliased,
            op          = opNop, 
            rule        = PrefixPrecedence,
            description = "create symbolic link of file to given destination",
            args        = {
                "file"          : {String},
                "destination"   : {String}
            },
            attrs       = {
                "hard"  : ({Logical},"create a hard link")
            },
            returns     = {Nothing},
            example     = """
            symlink relative "arturo/README.md" 
                    "/Users/drkameleon/Desktop/gotoREADME.md"
            ; creates a symbolic link to our readme file
            ; in our desktop
            ..........
            symlink.hard relative "arturo/README.md" 
                    "/Users/drkameleon/Desktop/gotoREADME.md"
            ; hard-links (effectively copies) our readme file
            ; to our desktop
            """:
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("symlink")

                var source = x.s
                var target = y.s
                try:
                    if (hadAttr("hard")):
                        createHardlink(move source, move target)
                    else:
                        createSymlink(move source, move target)
                except OSError:
                    discard
        
        builtin "timestamp",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "get file timestamps",
            args        = {
                "file"  : {String}
            },
            attrs       = NoAttrs,
            returns     = {Dictionary,Null},
            example     = """
            timestamp "README.md"
            ; =>  [created:2022-09-21T12:35:04+02:00 accessed:2022-09-21T12:35:04+02:00 modified:2022-09-21T12:35:04+02:00]

            timestamp "some-file-that-does-not-exist.txt"
            ; => null
            """:
                #=======================================================
                try:
                    push newDictionary({
                        "created": newDate(local(getCreationTime(x.s))),
                        "accessed": newDate(local(getLastAccessTime(x.s))),
                        "modified": newDate(local(getLastModificationTime(x.s)))
                    }.toOrderedTable)
                except CatchableError:
                    push VNULL
                        
        builtin "unzip",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "unzip given archive to destination",
            args        = {
                "destination"   : {String},
                "original"      : {String}
            },
            attrs       = NoAttrs,
            returns     = {Nothing},
            example     = """
            unzip "folder" "archive.zip"
            """:
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("unzip")

                miniz.unzip(y.s, x.s)

        builtin "volume",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "get file size for given path",
            args        = {
                "file"      : {String}
            },
            attrs       = NoAttrs,
            returns     = {Quantity},
            example     = """
            volume "README.md"
            ; => 13704B 
            ; (size in bytes)
            """:
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("volume")

                push newQuantity(newInteger(getFileSize(x.s)), newQuantitySpec(B))

        builtin "write",
            alias       = doublearrowright, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "write content to file at given path",
            args        = {
                "file"      : {String,Null},
                "content"   : {Any}
            },
            attrs       = {
                "append"        : ({Logical},"append to given file"),
                "directory"     : ({Logical},"create directory at path"),
                "json"          : ({Logical},"write value as Json"),
                "compact"       : ({Logical},"produce compact, non-prettified Json code"),
                "binary"        : ({Logical},"write as binary")
            },
            returns     = {Nothing},
            example     = """
            ; write some string data to given file path
            write "somefile.txt" "Hello world!"
            ..........
            ; we can also write any type of data as JSON
            write.json "data.json" myData
            ..........
            ; append to an existing file
            write.append "somefile.txt" "Yes, Hello again!"
            """:
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("write")

                if yKind==Bytecode:
                    let dataS = codify(newBlock(y.trans.constants), unwrapped=true, safeStrings=true)
                    let codeS = y.trans.instructions
                    discard writeBytecode(dataS, codeS, x.s)
                else:
                    if (hadAttr("directory")):
                        createDir(x.s)
                    else:
                        if (hadAttr("binary")):
                            writeToFile(x.s, y.n, append = (hadAttr("append")))
                        else:
                            if (hadAttr("json")):
                                let rez = jsonFromValue(y, pretty=(not hadAttr("compact")))
                                if x.kind==String:
                                    writeToFile(x.s, rez, append = (hadAttr("append")))
                                else:
                                    push(newString(rez))
                            else:
                                writeToFile(x.s, y.s, append = (hadAttr("append")))

        builtin "zip",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "zip given files to file at destination",
            args        = {
                "destination"   : {String},
                "files"         : {Block}
            },
            attrs       = NoAttrs,
            returns     = {Nothing},
            example     = """
            zip "dest.zip" ["file1.txt" "img.png"]
            """:
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("zip")

                let files: seq[string] = y.a.map((z)=>z.s)
                miniz.zip(files, x.s)

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)
