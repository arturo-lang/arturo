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

import httpClient, json, re, sequtils
import strformat, strtabs, sugar, tables, xmltree

import vm/stack, vm/value

#=======================================
# Helpers
#=======================================

proc generateJsonNode*(n: Value): JsonNode =
    case n.kind
        of Null         : result = newJNull()
        of Boolean      : result = newJBool(n.b)
        of Integer      : result = newJInt(n.i)
        of Floating     : result = newJFloat(n.f)
        of Type         : result = newJString($(n.t))
        of Char         : result = newJString($(n.c))
        of String,
           Word,
           Literal,
           Label        : result = newJString(n.s)
        of Attr,
           AttrLabel    : result = newJString(n.r)
        of Path,
           PathLabel    : 
           result = newJArray()
           for v in n.p:
                result.add(generateJsonNode(v))
        of Symbol       : result = newJString($(n.m))
        of Date         : discard
        of Binary       : discard
        of Inline,
           Block        : 
           result = newJArray()
           for v in n.a:
                result.add(generateJsonNode(v))
        of Dictionary   :
            result = newJObject()
            for k,v in pairs(n.d):
                result.add(k, generateJsonNode(v))

        of Function,
           Any          : discard

proc parseJsonNode*(n: JsonNode): Value =

    case n.kind
        of JString  : result = newString(n.str)
        of JInt     : result = newInteger(int(n.num))
        of JFloat   : result = newFloating(n.fnum)
        of JBool    : result = newBoolean(n.bval)
        of JNull    : result = VNULL
        of JArray   : result = newBlock(n.elems.map((x) => parseJsonNode(x)))
        of JObject  : 
            var ret: ValueDict = initOrderedTable[string,Value]()
            for k,v in n.fields:
                ret[k] = parseJsonNode(v)

            result = newDictionary(ret)

proc parseXMLNode*(n: XmlNode): Value =
    let items = toSeq(n.items)
    if n.len==1 and items[0].kind==xnText:
        if n.attrsLen>0:
            var ret = newDictionary()
            ret.d["attrs"] = newDictionary()
            for k,v in n.attrs.pairs:
                ret.d["attrs"].d[k] = newString(v)
            ret.d["content"] = newString(items[0].text)
            return ret
        else:
            return newString(items[0].text)
    else:
        var ret = initOrderedTable[string,Value]()
        for child in n.items:
            let key = child.tag
            let childContent = parseXMLNode(child)

            if ret.hasKey(key):
                if ret[key].kind==String:
                    ret[key] = newBlock(@[ret[key]])
                    ret[key].a.add(childContent)
                else:
                    ret[key].a.add(childContent)
            else:
                ret[key] = childContent
            #else:
            #    ret[key] = newString(child.text)
        result = newDictionary(ret)

proc isUrl*(s: string): bool {.inline.} =
    return s.match(re"^(?:http(s)?:\/\/)[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$")

#=======================================
# Methods
#=======================================

template Read*():untyped =
    require(opRead)

    var action: proc(path:string):string
    var download = false
    
    if (popAttr("binary") != VNULL):
        var f: File
        discard f.open(x.s)
        var b: seq[byte] = newSeq[byte](f.getFileSize())
        discard f.readBytes(b, 0, f.getFileSize())

        f.close()

        stack.push(newBinary(b))
    else:
        if x.s.isUrl():
            action = proc (path:string):string =
                newHttpClient().getContent(path)
            download = true
        else:
            action = proc (path:string):string =
                readFile(path)

        if (popAttr("lines") != VNULL):
            if download:
                stack.push(newStringBlock(action(x.s).split('\n')))
            else:
                stack.push(newStringBlock(toSeq(x.s.lines)))
        elif (popAttr("json") != VNULL):
            stack.push(parseJsonNode(parseJson(action(x.s))))
        # elif attrs.hasKey("html"):
        #     echo "parsing as html"
        #     # let ret = parseHtml(action(x.s))
        #     # echo repr ret
        #     #stack.push(parseXmlNode())
        # elif attrs.hasKey("xml"):
        #     stack.push(parseXmlNode(parseXml(action(x.s))))
        else:
            stack.push(newString(action(x.s)))


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

    