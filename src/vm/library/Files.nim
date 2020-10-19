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

import sequtils
import strformat, strtabs, sugar
import tables, unicode

import vm/stack, vm/value

import utils

#=======================================
# Methods
#=======================================

template Read*():untyped =
    require(opRead)
    
    if (popAttr("binary") != VNULL):
        var f: File
        discard f.open(x.s)
        var b: seq[byte] = newSeq[byte](f.getFileSize())
        discard f.readBytes(b, 0, f.getFileSize())

        f.close()

        stack.push(newBinary(b))
    else:
        let (src,srcType) = getSource(x.s)

        if (popAttr("lines") != VNULL):
            stack.push(newStringBlock(src.splitLines()))
        elif (popAttr("json") != VNULL):
            stack.push(parseJsonNode(parseJson(src)))
        elif (popAttr("csv") != VNULL):
            stack.push(parseCsvInput(src, withHeaders=(popAttr("withHeaders")!=VNULL)))
        # elif attrs.hasKey("html"):
        #     echo "parsing as html"
        #     # let ret = parseHtml(action(x.s))
        #     # echo repr ret
        #     #stack.push(parseXmlNode())
        # elif attrs.hasKey("xml"):
        #     stack.push(parseXmlNode(parseXml(action(x.s))))
        else:
            stack.push(newString(src))


template Write*():untyped =
    require(opWrite)

    if (popAttr("binary") != VNULL):
        var f: File
        discard f.open(x.s, mode=fmWrite)
        discard f.writeBytes(y.n, 0, y.n.len)

        f.close()
    else:
        if (popAttr("json") != VNULL):
            writeFile(x.s, json.pretty(generateJsonNode(y), indent=4))
        else:
            writeFile(x.s, y.s)


template IsExists*():untyped =
    require(opExists)

    if (popAttr("dir") != VNULL): stack.push(newBoolean(dirExists(x.s)))
    else: stack.push(newBoolean(fileExists(x.s)))

    