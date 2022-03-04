######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/toml.nim
######################################################

#=======================================
# Libraries
#=======================================

import sequtils, sugar, tables
import extras/parsetoml

import vm/values/value

#=======================================
# Methods
#=======================================

proc parseTomlNode*(n: TomlValueRef): Value =
    case n.kind
        of TomlValueKind.String  : result = newString(n.stringVal)
        of TomlValueKind.Int     : result = newInteger(n.intVal)
        of TomlValueKind.Float   : result = newFloating(n.floatVal)
        of TomlValueKind.Bool    : result = newLogical(n.boolVal)
        of TomlValueKind.None    : result = VNULL
        of TomlValueKind.Array   : result = newBlock(n.arrayVal.map((x) => parseTomlNode(x)))
        of TomlValueKind.Table   : 
            var ret: ValueDict = initOrderedTable[string,Value]()
            for k,v in n.tableVal:
                ret[k] = parseTomlNode(v)

            result = newDictionary(ret)
        else: discard

proc parseTomlString*(src: string): Value =
    parseTomlNode(parsetoml.parseString(src))

    