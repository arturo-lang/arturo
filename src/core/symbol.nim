#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: core/symbol.nim
  *****************************************************************]#

#[----------------------------------------
    Argument Object
  ----------------------------------------]#

##---------------------------
## Constructors
##---------------------------

proc symbolFromIdentifier(i: cstring): Symbol {.exportc.} =
    if ConstSyms.hasKey(i):
        result = ConstSyms[i]
    else:
        when defined(profileStats):
            inc(PROFILER,"new Symbol")
        result = Symbol(hash: storeOrGetHash(i), value: new RefValue)
        result.value[] = NV
        ConstSyms[i] = result

proc symbolFromSystemCommand(s: int): Symbol {.exportc.} =
    let i = getNameOfSystemFunction(s)
    if ConstSyms.hasKey(i):
        result = ConstSyms[i]
    else:
        result = Symbol(hash: storeOrGetHash(i), value: new RefValue)
        ConstSyms[i] = result

proc symbolWithValue(i: cstring, v: Value): Symbol =
    if ConstSyms.hasKey(i):
        result = ConstSyms[i]
    else:
        result = Symbol(hash: storeOrGetHash(i), value: new RefValue)
        result.value[] = v
        ConstSyms[i] = result

##---------------------------
## Helpers
##---------------------------

proc hash(s: Symbol):Hash {.inline.} =
    s.hash

##---------------------------
## Inspect
##---------------------------

proc inspectSymbols() {.inline.} =
    var list: seq[(cstring,Symbol)]
    var maxVar = 0

    proc opCmp(l: (cstring,Symbol), r: (cstring,Symbol)): int =
        if $(l[0]) <= $(r[0]): -1
        else: 1

    for k,v in ConstSyms.mpairs:
        if (($k).len + v.value[].stringify().len)>maxVar: maxVar=($k).len + v.value[].stringify().len
        list.add((k,v))

    list = list.sorted(opCmp)

    for item in list:
        let k = item[0]
        let v = item[1]
        echo unicode.alignLeft("- \x1B[1;37m" & $k & ": \x1B[0;36m" & v.value[].kind.valueKindToPrintable() & "\x1B[0;37m = \x1B[35m" & v.value[].stringify(), maxVar+40) & unicode.align("\x1B[2;37m @ " & repr(v).replace("\n","") & "\x1B[0;37m",20)

    echo ""
