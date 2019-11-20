#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/json.nim
  * @description: JSON parsing/generation
  *****************************************************************]#

#[######################################################
    Helpers
  ======================================================]#

proc generateJsonNode*(n: Value): JsonNode =
    case n.kind
        of SV       : result = newJString(S(n))
        of IV       : result = newJInt(I(n))
        of RV       : result = newJFloat(R(n))
        of BV       : result = newJBool(B(n))
        of NV       : result = newJNull()
        of AV       : 
            result = newJArray()
            for v in A(n):
                result.add(generateJsonNode(v))
        # of DV       : 
        #     result = newJObject()
        #     for kv in D(n).list:
        #         result.add(kv[0],generateJsonNode(kv[1]))
        else: discard

proc parseJsonNode*(n: JsonNode): Value =
    case n.kind
        of JString  : result = STR(n.str)
        of JInt     : result = SINT(int(n.num))
        of JFloat   : result = REAL(n.fnum)
        of JBool    : result = BOOL(n.bval)
        of JNull    : result = NULL
        of JArray   : result = ARR(n.elems.map((x) => parseJsonNode(x)))
        of JObject  : 
            var ret: seq[(string,Value)]
            for k,v in n.fields:
                ret.add((k,parseJsonNode(v)))

            result = DICT(ret)

#[######################################################
    Functions
  ======================================================]#

proc Json_generateJson*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    let root = generateJsonNode(v[0])
    result = STR(root.pretty(indent=4))

proc Json_parseJson*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)
    
    let root = parseJson(S(v[0]))
    result = parseJsonNode(root)

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

# when defined(unittest):

#     suite "Library: system/dictionary":

#         test "shuffle":
#             check(not eq( callFunction("shuffle",@[ARR(@[INT(1),INT(2),INT(3),INT(4),INT(5),INT(6),INT(7),INT(8),INT(9)])]), ARR(@[INT(1),INT(2),INT(3),INT(4),INT(5),INT(6),INT(7),INT(8),INT(9)]) ))

#         test "swap":
#             check(eq( callFunction("swap",@[ARR(@[INT(1),INT(2),INT(3)]),INT(0),INT(2)]), ARR(@[INT(3),INT(2),INT(1)]) ))
