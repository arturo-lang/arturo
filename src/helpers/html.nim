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
    # TODO(Helpers/html) consider replacing the underlying HTML parser with lexbor
    #  The current parser (vendored from Nim's stdlib at `extras/htmlparser`) is
    #  SGML/XML-ish, not HTML5-spec. It handles cleanish HTML fine but struggles
    #  with worst tag soup: unclosed `<li>` cascades, `<script>` raw-text edge
    #  cases, foreign content (inline SVG/MathML), implicit `<tbody>`, etc.
    #
    #  For real-web HTML5 parity, a future option is to vendor lexbor (C, ~600KB
    #  static lib for the HTML+DOM subset, no external deps, very fast) under
    #  `extras/lexbor/` and expose a drop-in `parseHtml` returning the same
    #  XmlNode shape, gated behind a `--define:LEXBOR` build flag. The Arturo
    #  tree shape produced by `parseHtmlInput` would not change, so external
    #  packages built on `read.html` would gain HTML5 conformance transparently.
    #
    #  Alternative: gumbo (Google's HTML5 parser; archived since 2016 but works).
    #  labels: helpers, library, enhancement, open discussion
    proc unescapeHtmlEntities*(s: string): string =
        result = newStringOfCap(s.len)
        var i = 0
        while i < s.len:
            if s[i] == '&':
                var j = i + 1
                while j < s.len and j - i < 12 and s[j] != ';':
                    inc j
                if j < s.len and s[j] == ';' and j > i + 1:
                    let decoded = entityToUtf8(s[i+1 ..< j])
                    if decoded.len > 0:
                        result.add(decoded)
                        i = j + 1
                        continue
                result.add('&')
                inc i
            else:
                result.add(s[i])
                inc i

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
        let root = parseHtml(input)
        result = newDictionary()
        result.d["kind"] = newLiteral("document")
        var children = newBlock()
        if root.kind == xnElement and root.tag == "document":
            if root.attrsLen() > 0 and root.attrs().hasKey("_doctype"):
                let dt = newDictionary()
                dt.d["kind"] = newLiteral("doctype")
                dt.d["value"] = newString(root.attrs()["_doctype"])
                children.a.add(dt)
            for sub in items(root):
                children.a.add(parseHtmlNode(sub))
        else:
            children.a.add(parseHtmlNode(root))
        result.d["children"] = children
