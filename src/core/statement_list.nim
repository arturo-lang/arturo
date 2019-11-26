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
    result = StatementList(list: @[])

proc newStatementList(sl: seq[Statement]): StatementList =
    result = StatementList(list: sl)

proc newStatementListWithStatement(s: Statement): StatementList {.exportc.} =
    result = StatementList(list: @[s])

proc addStatement(sl: StatementList, s: Statement): StatementList {.exportc.} =
    GC_ref(sl)
    sl.list.add(s)
    result = sl

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
        