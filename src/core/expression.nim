#[----------------------------------------
    Expression
  ----------------------------------------]#

##---------------------------
## Constructors
##---------------------------

proc expressionFromArgument(a: Argument): Expression {.exportc.} =
    if a.kind == identifierArgument or a.kind == literalArgument:
        if ConstArgExprs.hasKey(a):
            result = ConstArgExprs[a]
        else:
            result = Expression(kind: argumentExpression, a: a)
            ConstArgExprs[a] = result
    else:
        result = Expression(kind: argumentExpression, a: a)
    
proc expressionFromRange(a: Argument, b: Argument): Expression {.exportc.} =
    var lst = newExpressionList(@[
        expressionFromArgument(a),
        expressionFromArgument(b)
    ])

    result = Expression(kind: argumentExpression, a: argumentFromCommand(RANGE_CMD,lst))

proc expressionFromExpressions(l: Expression, op: cstring, r: Expression): Expression {.exportc.} =
    result = Expression(kind: normalExpression, left: l, op: parseEnum[ExpressionOperator]($op), right: r)

proc expressionFromKeyPathPart(part: KeyPathPart, isFirst: bool = false): Expression =
    case part.kind
        of stringKeyPathPart:
            if isFirst: result = expressionFromArgument(argumentFromIdentifier(part.s))
            else: result = expressionFromArgument(argumentFromStringLiteral("\"" & part.s & "\""))
        of integerKeyPathPart:
            result = expressionFromArgument(argumentFromIntegerLiteral($(part.i)))
        of inlineKeyPathPart:
            result = expressionFromArgument(part.a)

##---------------------------
## Methods
##---------------------------

proc evaluate(x: Expression): Value {.inline.} =
    ## Evaluate given Expression an return the result

    case x.kind
        of argumentExpression:
            result = x.a.getValue()
        of normalExpression:
            let left = x.left.evaluate()
            let right = x.right.evaluate()

            {.computedGoto.}
            case x.op
                of PLUS_SG  : result = left ++ right
                of MINUS_SG : result = left -- right
                of MULT_SG  : result = left ** right
                of DIV_SG   : result = left // right
                of MOD_SG   : result = left %% right
                of POW_SG   : result = left ^^ right
                of EQ_OP    : result = BOOL(left.eq(right))
                of LT_OP    : result = BOOL(left.lt(right))
                of GT_OP    : result = BOOL(left.gt(right))
                of LE_OP    : result = BOOL(left.lt(right) or left.eq(right))
                of GE_OP    : result = BOOL(left.gt(right) or left.eq(right))
                of NE_OP    : result = BOOL(not (left.eq(right)))