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
    import tables, xmlparser, xmltree

import vm/values/value

#=======================================
# Methods
#=======================================

when defined(PARSERS):
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
        let root = parseXml(input)
        result = newDictionary()
        result.d["kind"] = newLiteral("document")
        var children = newBlock()
        children.a.add(parseXMLNode(root))
        result.d["children"] = children
