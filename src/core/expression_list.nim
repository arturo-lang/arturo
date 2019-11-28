#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: core/expression_list.nim
  *****************************************************************]#

#[----------------------------------------
    ExpressionList Object
  ----------------------------------------]#

##---------------------------
## Constructors
##---------------------------

proc newExpressionList: ExpressionList {.exportc.} =
    let ret = ExpressionList(list: @[])
    GC_ref(ret)
    result = ret

proc newExpressionList(xl: seq[Expression]): ExpressionList =
    let ret = ExpressionList(list: xl)
    GC_ref(ret)
    result = ret

proc newExpressionListWithExpression(x: Expression): ExpressionList {.exportc.} =
    let ret = ExpressionList(list: @[x])
    GC_ref(ret)
    result = ret

proc expressionListWithChainedStatement(st: Statement): ExpressionList {.exportc.} =
    newExpressionListWithExpression(expressionFromArgument(argumentFromInlineCallLiteral(st)))

template expressionListWithARGV(): ExpressionList = 
    newExpressionListWithExpression(expressionFromArgument(argumentFromIdentifier(ARGV)))

proc copyExpressionList(xl: ExpressionList): ExpressionList {.exportc.} =
    ExpressionList(list: xl.list)

proc addExpression(xl: ExpressionList, x: Expression): ExpressionList {.exportc.} =
    xl.list.add(x)
    result = xl

##---------------------------
## Methods
##---------------------------

proc evaluate(xl: ExpressionList, forceArray: bool=false): Value {.inline.} = 
    ## Evaluate given ExpressionList and return the result

    ARR(xl.list.map((x) => x.evaluate()))

    # if forceArray or xl.list.len>1:
    #     result = ARR(xl.list.map((x) => x.evaluate()))
    # else:
    #     if xl.list.len==1:
    #         result = xl.list[0].evaluate()
    #     else:
    #         result = ARR(@[])
