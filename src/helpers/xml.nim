######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: helpers/xml.nim
######################################################

#=======================================
# Libraries
#=======================================

import sequtils, strtabs
import tables, xmltree

import vm/value

#=======================================
# Methods
#=======================================

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
