#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: core/symbol_list.nim
  *****************************************************************]#

#[----------------------------------------
    SymbolList Object
  ----------------------------------------]#

##---------------------------
## Constructors
##---------------------------

proc newSymbolListWithSymbol(s: Symbol): SymbolList {.exportc.} =
    let ret = SymbolList(list: @[s])
    GC_ref(ret)
    result = ret

proc addSymbolToList(sl: SymbolList, s: Symbol): SymbolList {.exportc.} =
    sl.list.add(s)
    result = sl
