#[----------------------------------------
    StatementList
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
    sl.list.add(s)
    result = sl

##---------------------------
## Methods
##---------------------------

proc execute(sl: StatementList): Value {.inline.} = 
    ## Execute given StatementList and return result

    var i = 0
    while i < sl.list.len:
        #try:
        result = sl.list[i].execute()
        if Returned != 0:
            return Returned
        #except ReturnValue:
        #    raise
        #except Exception as e:
        #    runtimeError(e.msg, FileName, sl.list[i].pos)

        inc(i)