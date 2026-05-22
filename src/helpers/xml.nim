#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: helpers/xml.nim
#=======================================================

#=======================================
# Libraries
#=======================================


when defined(PARSERS):
    import strtabs
    import tables, parsexml, xmlparser, xmltree

    import extras/htmlparser

import vm/values/value

#=======================================
# Methods
#=======================================

when defined(PARSERS):
    proc unescapeXmlEntities*(s: string): string =
        result = newStringOfCap(s.len)
        var i = 0
        while i < s.len:
            if s[i] == '&':
                var j = i + 1
                while j < s.len and j - i < 12 and s[j] != ';':
                    inc j
                if j < s.len and s[j] == ';' and j > i + 1:
                    let body = s[i+1 ..< j]
                    var decoded = ""
                    case body:
                        of "amp":  decoded = "&"
                        of "lt":   decoded = "<"
                        of "gt":   decoded = ">"
                        of "quot": decoded = "\""
                        of "apos": decoded = "'"
                        else:
                            if body.len > 1 and body[0] == '#':
                                decoded = entityToUtf8(body)
                    if decoded.len > 0:
                        result.add(decoded)
                        i = j + 1
                        continue
                result.add('&')
                inc i
            else:
                result.add(s[i])
                inc i

    proc parseXMLNode*(node: XmlNode): Value =
        result = newDictionary()
        case node.kind:
            of xnElement:
                result.d["kind"] = newLiteral("element")
                result.d["tag"] = newString(node.tag())
                let attrsDict = newDictionary()
                if node.attrsLen() > 0:
                    for k, v in pairs(node.attrs()):
                        attrsDict.d[k] = newString(v)
                result.d["attrs"] = attrsDict
                var children = newBlock()
                for sub in items(node):
                    children.a.add(parseXMLNode(sub))
                result.d["children"] = children
            of xnText, xnVerbatimText:
                result.d["kind"] = newLiteral("text")
                result.d["value"] = newString(node.text)
            of xnComment:
                result.d["kind"] = newLiteral("comment")
                result.d["value"] = newString(node.text)
            of xnCData:
                result.d["kind"] = newLiteral("cdata")
                result.d["value"] = newString(node.text)
            of xnEntity:
                result.d["kind"] = newLiteral("entity")
                result.d["value"] = newString(node.text)

    proc parseXMLInput*(input: string): Value =
        let root = parseXml(input, options = {reportComments, reportWhitespace})
        result = newDictionary()
        result.d["kind"] = newLiteral("document")
        var children = newBlock()
        children.a.add(parseXMLNode(root))
        result.d["children"] = children
