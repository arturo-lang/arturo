######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Files.nim
######################################################

#=======================================
# Libraries
#=======================================

import os, strtabs, tables

import vm/stack, vm/value

#=======================================
# Methods
#=======================================

template IsExists*():untyped =
    # EXAMPLE:
    # if exists? "somefile.txt" [ 
    # ____print "file exists!" 
    # ]

    require(opExists)

    if (popAttr("dir") != VNULL): stack.push(newBoolean(dirExists(x.s)))
    else: stack.push(newBoolean(fileExists(x.s)))

template Read*():untyped =
    # EXAMPLE:
    # ; reading a simple local file
    # str: read "somefile.txt"
    #
    # ; also works with remote urls
    # page: read "http://www.somewebsite.com/page.html"
    #
    # ; we can also "read" JSON data as an object
    # data: read.json "mydata.json"
    #
    # ; or even convert Markdown to HTML on-the-fly
    # html: read.markdown "## Hello" ____; "<h2>Hello</h2>"

    require(opRead)
    
    if (popAttr("binary") != VNULL):
        var f: File
        discard f.open(x.s)
        var b: seq[byte] = newSeq[byte](f.getFileSize())
        discard f.readBytes(b, 0, f.getFileSize())

        f.close()

        stack.push(newBinary(b))
    else:
        let (src, _{.inject.}) = getSource(x.s)

        if (popAttr("lines") != VNULL):
            stack.push(newStringBlock(src.splitLines()))
        elif (popAttr("json") != VNULL):
            stack.push(parseJsonNode(parseJson(src)))
        elif (popAttr("csv") != VNULL):
            stack.push(parseCsvInput(src, withHeaders=(popAttr("withHeaders")!=VNULL)))
        elif (popAttr("toml") != VNULL):
            stack.push(parseTomlString(src))
        elif (popAttr("html") != VNULL):
            stack.push(parseHtmlInput(src))
        elif (popAttr("markdown") != VNULL):
            stack.push(parseMarkdownInput(src))
        # elif attrs.hasKey("xml"):
        #     stack.push(parseXmlNode(parseXml(action(x.s))))
        else:
            stack.push(newString(src))

template Unzip*():untyped = 
    # EXAMPLE:
    # unzip "folder" "archive.zip"
    require(opUnzip)

    miniz.unzip(y.s, x.s)


template Write*():untyped =
    # EXAMPLE:
    # ; write some string data to given file path
    # write "somefile.txt" "Hello world!"
    #
    # ; we can also write any type of data as JSON
    # write.json "data.json" myData

    require(opWrite)

    if (popAttr("directory") != VNULL):
        createDir(x.s)
        
    else:
        if (popAttr("binary") != VNULL):
            var f: File
            discard f.open(x.s, mode=fmWrite)
            discard f.writeBytes(y.n, 0, y.n.len)

            f.close()
        else:
            if (popAttr("json") != VNULL):
                let rez = json.pretty(generateJsonNode(y), indent=4)
                if x.kind==String:
                    writeFile(x.s, rez)
                else:
                    stack.push(newString(rez))
            else:
                writeFile(x.s, y.s)
    
template Zip*():untyped = 
    # EXAMPLE:
    # zip "dest.zip" ["file1.txt" "img.png"]

    require(opZip)

    let files: seq[string] = y.a.map((z)=>z.s)

    miniz.zip(files, x.s)
