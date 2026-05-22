#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: helpers/csv.nim
#=======================================================

#=======================================
# Libraries
#=======================================

when defined(PARSERS):
    import extras/htmlparser
    import strtabs, tables, xmltree

import vm/values/value

#=======================================
# Methods
#=======================================

when defined(PARSERS):
    proc parseHtmlNode(node: XmlNode): Value =
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
                    children.a.add(parseHtmlNode(sub))
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

    proc parseHtmlInput*(input: string): Value =
        parseHtmlNode(parseHtml(input)).d["html"]
