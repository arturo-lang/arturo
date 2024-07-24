#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: helpers/xml.nim
#=======================================================

#=======================================
# Libraries
#=======================================


when not defined(NOPARSERS):
    import sequtils, strtabs, sugar
    import tables, xmlparser, xmltree

import vm/values/value

#=======================================
# Methods
#=======================================

when not defined(NOPARSERS):
    # TODO(Helpers/xml) re-implement XML parsing
    #  This `parseXMLNode` supposedly "works", but we first have to define what this means: basically, what would an XML-parsing function normally yield? How are children/nodes/attributes supposed to fit in Arturo's value system: arrays, dictionaries, scalars, etc?
    #  labels: helpers, library, enhancement, bug, open discussion
    proc parseXMLNode*(n: XmlNode, level: int = 0): Value =
        let items = toSeq(n.items)
        if items.len == 1 and items[0].kind == xnText:
            return newString(items[0].text)

        var children = newBlock()
        result = newDictionary()
        for child in n.items:
            let subtags = toSeq(n.items).map((x) => x.tag)
            if count(subtags, child.tag)>1:
                children.a.add(parseXMLNode(child, level+1))
            else:
                result.d[child.tag] = parseXMLNode(child, level+1)

        if n.attrsLen > 0:
            result.d["_tag"] = newString(n.tag)
            for k,v in n.attrs.pairs:
                result.d[k] = newString(v)
            if children.a.len > 0:
                result.d["children"] = children
        else:
            if result.d.len > 0:
                result.d["children"] = children
            else:
                result = children

    proc parseXMLInput*(input: string): Value =
        parseXMLNode(parseXml(input))
