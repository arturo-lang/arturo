######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/csv.nim
######################################################

#=======================================
# Libraries
#=======================================

when not defined(NOPARSERS):
    import htmlparser
    import strtabs, tables, xmltree

import vm/values/value

#=======================================
# Methods
#=======================================

when not defined(NOPARSERS):
    proc parseHtmlNode(node: XmlNode): Value =
        result = newDictionary()
        if node.kind()==xnElement:
            result.d["attrs"] = newDictionary()
            if node.attrsLen() > 0:
                for k,v in pairs(node.attrs()):
                    result.d["attrs"].d[k] = newString(v)

            result.d["text"] = newString(node.innerText())
            for subnode in items(node):
                if subnode.kind()==xnElement:
                    if result.d.hasKey(subnode.tag()) and result.d[subnode.tag()].kind==Dictionary:
                        result.d[subnode.tag()] = newBlock(@[result.d[subnode.tag()]])

                    if result.d.hasKey(subnode.tag()):
                        result.d[subnode.tag()].a.add(parseHtmlNode(subnode))
                    else:
                        result.d[subnode.tag()] = parseHtmlNode(subnode)

    proc parseHtmlInput*(input: string): Value =
        parseHtmlNode(parseHtml(input)).d["html"]
