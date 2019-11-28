#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: core/statement_list.nim
  *****************************************************************]#

#[----------------------------------------
    StatementList Object
  ----------------------------------------]#

##---------------------------
## Constructors
##---------------------------

proc newStatementList: StatementList {.exportc.} =
    let ret = StatementList(list: @[])
    GC_ref(ret)
    result = ret

proc newStatementList(sl: seq[Statement]): StatementList =
    let ret = StatementList(list: sl)
    GC_ref(ret)
    result = ret

proc newStatementListWithStatement(s: Statement): StatementList {.exportc.} =
    let ret = StatementList(list: @[s])
    GC_ref(ret)
    result = ret

proc addStatement(sl: StatementList, s: Statement): StatementList {.exportc.} =
    #GC_ref(sl)
    sl.list.add(s)
    result = sl
    #let ret = sl
    #GC_ref(ret)
    #result = ret

##---------------------------
## Methods
##---------------------------

proc execute(sl: StatementList): Value {.inline.} = 
    ## Execute given StatementList and return result

    var i = 0
    while i < sl.list.len:
        result = sl.list[i].execute()

        if Returned != 0:
            return Returned

        inc(i)
    #GC_step(100)
        