######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: helpers/json.nim
######################################################

#=======================================
# Libraries
#=======================================

import std/json, sequtils, sugar
import tables, unicode

import vm/value

#=======================================
# Methods
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
        of Attribute,
           AttributeLabel: result = newJString(n.r)
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
           Database,
           Bytecode,
           Custom,
           Nothing,
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
