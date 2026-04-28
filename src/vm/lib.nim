#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: vm/common.nim
#=======================================================

## Helpers & utilities for Arturo's standard library.

#=======================================
# Libraries
#=======================================

import macros, strutils, tables
export strutils, tables

import vm/[checks, globals, opcodes, stack, values/comparison, values/operators, values/printable, values/value]
export checks, comparison, globals, opcodes, operators, printable, stack, value

import vm/values/custom/[vcolor, vcomplex, vlogical, vquantity, vrational, vregex, vsymbol]
export vcolor, vcomplex, vlogical, vquantity, vrational, vregex, vsymbol

import vm/bundle/resources

import vm/profiler

#=======================================
# Constants
#=======================================

const
    NoArgs*      = static {"" : {Nothing}}          ## Shortcut for no arguments
    NoAttrs*     = static {"" : ({Nothing},"")}     ## Shortcut for no attributes

#=======================================
# Helpers
#=======================================

macro dispatchWithLiteral*(body: untyped): untyped =
    ## Dispatch a builtin's body across kinds and modes.
    ##
    ## Clause forms:
    ##   `KIND(binding): expr`                      — 1-axis on `x`, single body
    ##   `(KIND(b1), KIND(b2)): expr`               — 2-axis on `(x, y)`, single body
    ##   `(KIND(b1), KIND(b2), KIND(b3)): expr`     — 3-axis on `(x, y, z)`, single body
    ##   any axis after the first may use `_` as a kind-wildcard (no binding;
    ##   the body references `y` / `z` directly)
    ##   `_: <body>`                                — top-level x-axis fallback
    ##   `KIND(b):` (or n-axis tuple) followed by:
    ##       `value:   <stmts>`                     — value-mode body (verbatim)
    ##       `inplace: <stmts>`                     — in-place stmts (verbatim)
    ##
    ## Single-body mode: the body is the *payload* of a value of the x-kind
    ## (a `string` for `String`, `Rune` for `Char`, etc.). The macro wraps it
    ## as `push(newKind(expr))` for value-mode args, or as field assignment
    ## (`InPlaced.field = expr`) for `Literal`/`PathLiteral` args.
    ##
    ## Per-mode mode: both `value:` and `inplace:` are full statement blocks
    ## that run verbatim.
    ##
    ## In all cases `x`/`y`/`z` are still in scope (injected by `require`);
    ## the binding name is an alias — a `let` for read-only access, a
    ## `template` (lvalue) when an `inplace:` block needs to mutate.
    expectKind body, nnkStmtList

    proc fieldAndCtor(kind: string, n: NimNode): (string, string) =
        case kind
        of "String":     ("s", "newString")
        of "Char":       ("c", "newChar")
        of "Block":      ("a", "newBlock")
        of "Integer":    ("i", "newInteger")
        of "Floating":   ("f", "newFloating")
        of "Logical":    ("b", "newLogical")
        of "Dictionary": ("d", "newDictionary")
        of "Binary":     ("n", "newBinary")
        of "Range":      ("rng", "newRange")
        of "Regex":      ("rx", "newRegex")
        of "Color":      ("l", "newColor")
        of "Quantity":   ("q", "newQuantity")
        of "Complex":    ("z", "newComplex")
        of "Rational":   ("rat", "newRational")
        of "Object":     ("o", "newObject")
        else:
            error("dispatchWithLiteral: unsupported kind '" & kind & "'", n)
            ("", "")

    proc parsePat(n: NimNode, allowWild: bool): tuple[wild: bool, kind: string, binding: NimNode] =
        if allowWild and n.kind == nnkIdent and $n == "_":
            return (true, "", nil)
        if n.kind == nnkCall and n.len == 2 and n[0].kind == nnkIdent:
            if $n[0] == "_":
                error("dispatchWithLiteral: `_` wildcard cannot have a binding", n)
            return (false, $n[0], n[1])
        error("dispatchWithLiteral: expected `KIND(binding)`" &
              (if allowWild: " or `_`" else: ""), n)

    proc aliasTemplate(name, target: NimNode): NimNode =
        # template <name>: untyped = <target>
        nnkTemplateDef.newTree(
            name,
            newEmptyNode(), newEmptyNode(),
            nnkFormalParams.newTree(ident("untyped")),
            newEmptyNode(), newEmptyNode(),
            target
        )

    type
        FlatClause = object
            isElse: bool   # `_:` top-level x-fallback
            xKind: string
            xBinding: NimNode
            hasY: bool
            yWild: bool
            yKind: string
            yBinding: NimNode
            hasZ: bool
            zWild: bool
            zKind: string
            zBinding: NimNode
            valueE, inplaceS, unifiedB: NimNode

    proc parseBody(b: NimNode): tuple[valueE, inplaceS, unifiedB: NimNode] =
        # detect split-mode: a stmt list of ONLY `value:` and/or `inplace:` calls
        if b.kind == nnkStmtList and b.len > 0:
            var v, p: NimNode
            var split = true
            for c in b:
                if c.kind == nnkCall and c.len == 2 and c[0].kind == nnkIdent:
                    case $c[0]
                    of "value":   v = c[1]
                    of "inplace": p = c[1]
                    else: split = false
                else:
                    split = false
                if not split: break
            if split and (v != nil or p != nil):
                return (v, p, nil)
        return (nil, nil, b)

    var flat: seq[FlatClause]
    var hasElse = false
    var elseClause: FlatClause

    for clause in body:
        var fc: FlatClause
        if clause.kind == nnkCall and clause.len == 2 and
           clause[0].kind == nnkIdent and $clause[0] == "_":
            # `_: body` — top-level x-axis fallback
            if hasElse:
                error("dispatchWithLiteral: duplicate `_:` fallback", clause)
            fc.isElse = true
            (fc.valueE, fc.inplaceS, fc.unifiedB) = parseBody(clause[1])
            elseClause = fc
            hasElse = true
            continue
        elif clause.kind == nnkCall and clause.len == 3 and clause[0].kind == nnkIdent:
            # 1-axis: KIND(binding): body
            fc.xKind = $clause[0]
            fc.xBinding = clause[1]
            (fc.valueE, fc.inplaceS, fc.unifiedB) = parseBody(clause[2])
        elif clause.kind == nnkCall and clause.len == 2 and
             clause[0].kind in {nnkPar, nnkTupleConstr}:
            # 2- or 3-axis: (KIND(b), ...): body
            let par = clause[0]
            if par.len notin {2, 3}:
                error("dispatchWithLiteral: expected 2- or 3-element tuple", par)
            let xPat = parsePat(par[0], allowWild = false)
            fc.xKind = xPat.kind; fc.xBinding = xPat.binding
            fc.hasY = true
            let yPat = parsePat(par[1], allowWild = true)
            fc.yWild = yPat.wild; fc.yKind = yPat.kind; fc.yBinding = yPat.binding
            if par.len == 3:
                fc.hasZ = true
                let zPat = parsePat(par[2], allowWild = true)
                fc.zWild = zPat.wild; fc.zKind = zPat.kind; fc.zBinding = zPat.binding
            (fc.valueE, fc.inplaceS, fc.unifiedB) = parseBody(clause[1])
        else:
            error("dispatchWithLiteral: malformed clause", clause)
        flat.add fc

    proc emitBranch(fc: FlatClause, valueMode: bool): NimNode =
        result = newStmtList()
        if fc.isElse:
            # No xKind — body uses x/y/z directly. No auto-wrap (kind unknown).
            if valueMode:
                if fc.valueE != nil:        result.add copyNimTree(fc.valueE)
                elif fc.unifiedB != nil:    result.add copyNimTree(fc.unifiedB)
                else:                       result.add nnkDiscardStmt.newTree(newEmptyNode())
            else:
                if fc.inplaceS != nil:      result.add copyNimTree(fc.inplaceS)
                elif fc.unifiedB != nil:    result.add copyNimTree(fc.unifiedB)
                else:                       result.add nnkDiscardStmt.newTree(newEmptyNode())
            return

        let (xField, xCtor) = fieldAndCtor(fc.xKind, fc.xBinding)
        let xTarget =
            if valueMode: newDotExpr(ident("x"), ident(xField))
            else: newDotExpr(ident("InPlaced"), ident(xField))

        let needsLValue = (not valueMode) and fc.inplaceS != nil
        if needsLValue:
            result.add aliasTemplate(copyNimTree(fc.xBinding), xTarget)
        else:
            result.add newLetStmt(copyNimTree(fc.xBinding), xTarget)

        if fc.hasY and not fc.yWild:
            let (yField, _) = fieldAndCtor(fc.yKind, fc.yBinding)
            result.add newLetStmt(copyNimTree(fc.yBinding),
                                  newDotExpr(ident("y"), ident(yField)))

        if fc.hasZ and not fc.zWild:
            let (zField, _) = fieldAndCtor(fc.zKind, fc.zBinding)
            result.add newLetStmt(copyNimTree(fc.zBinding),
                                  newDotExpr(ident("z"), ident(zField)))

        if valueMode:
            if fc.valueE != nil:
                result.add copyNimTree(fc.valueE)
            elif fc.unifiedB != nil:
                result.add newCall(ident("push"),
                                   newCall(ident(xCtor), copyNimTree(fc.unifiedB)))
            else:
                result.add nnkDiscardStmt.newTree(newEmptyNode())
        else:
            if fc.inplaceS != nil:
                result.add copyNimTree(fc.inplaceS)
            elif fc.unifiedB != nil:
                result.add newAssignment(copyNimTree(xTarget),
                                         copyNimTree(fc.unifiedB))
            else:
                result.add nnkDiscardStmt.newTree(newEmptyNode())

    proc buildYBranch(ycls: seq[FlatClause], valueMode: bool): NimNode =
        # ycls all share xKind & yKind (or yWild). May further dispatch on z.
        if not ycls[0].hasZ:
            if ycls.len > 1:
                error("dispatchWithLiteral: duplicate clauses for the same kind",
                      ycls[1].xBinding)
            return emitBranch(ycls[0], valueMode)
        let zCase = nnkCaseStmt.newTree(ident("zKind"))
        var zElse: NimNode = nil
        for fc in ycls:
            if fc.zWild:
                if zElse != nil:
                    error("dispatchWithLiteral: duplicate z-axis `_` wildcard",
                          fc.xBinding)
                zElse = emitBranch(fc, valueMode)
            else:
                zCase.add nnkOfBranch.newTree(ident(fc.zKind),
                                              emitBranch(fc, valueMode))
        if zElse != nil:
            zCase.add nnkElse.newTree(zElse)
        else:
            zCase.add nnkElse.newTree(nnkDiscardStmt.newTree(newEmptyNode()))
        return zCase

    proc buildCase(disc: NimNode, valueMode: bool): NimNode =
        # Group clauses by xKind preserving order
        var xOrder: seq[string]
        var xMap = initOrderedTable[string, seq[FlatClause]]()
        for fc in flat:
            if fc.xKind notin xMap:
                xMap[fc.xKind] = @[]
                xOrder.add fc.xKind
            xMap[fc.xKind].add fc

        result = nnkCaseStmt.newTree(disc)
        for xKind in xOrder:
            let cls = xMap[xKind]
            if not cls[0].hasY:
                if cls.len > 1:
                    error("dispatchWithLiteral: duplicate 1-axis clauses for kind '" & xKind & "'",
                          cls[1].xBinding)
                result.add nnkOfBranch.newTree(ident(xKind),
                                               emitBranch(cls[0], valueMode))
            else:
                # Group by (yKind, yWild)
                var yOrder: seq[string]
                var yMap = initOrderedTable[string, seq[FlatClause]]()
                for fc in cls:
                    let key = if fc.yWild: "_" else: fc.yKind
                    if key notin yMap:
                        yMap[key] = @[]; yOrder.add key
                    yMap[key].add fc

                let inner = nnkCaseStmt.newTree(ident("yKind"))
                var yElse: NimNode = nil
                for yKey in yOrder:
                    let ycls = yMap[yKey]
                    let yBody = buildYBranch(ycls, valueMode)
                    if yKey == "_":
                        yElse = yBody
                    else:
                        inner.add nnkOfBranch.newTree(ident(yKey), yBody)
                if yElse != nil:
                    inner.add nnkElse.newTree(yElse)
                else:
                    inner.add nnkElse.newTree(nnkDiscardStmt.newTree(newEmptyNode()))
                result.add nnkOfBranch.newTree(ident(xKind), inner)

        if hasElse:
            result.add nnkElse.newTree(emitBranch(elseClause, valueMode))
        else:
            result.add nnkElse.newTree(nnkDiscardStmt.newTree(newEmptyNode()))

    let outer = buildCase(ident("xKind"), valueMode = true)
    let inner = buildCase(newDotExpr(ident("InPlaced"), ident("kind")),
                          valueMode = false)

    # splice the Literal/PathLiteral branch BEFORE the outer's else
    outer.insert(outer.len - 1,
        nnkOfBranch.newTree(
            ident("Literal"), ident("PathLiteral"),
            newStmtList(newCall(ident("ensureInPlaceAny")), inner)
        ))

    result = newStmtList(outer)

macro dispatch*(body: untyped): untyped =
    ## Value-mode-only kind dispatch — for functions whose args don't include
    ## `Literal`/`PathLiteral` (predicates, similarity functions, etc).
    ##
    ## Same clause grammar as `dispatchWithLiteral` (1-axis `KIND(b):` or
    ## 2-axis `(KIND(b1), KIND(b2)):`), but no in-place branch is emitted and
    ## bodies are *verbatim* full statements — the user writes their own
    ## `push(...)`. Auto-wrap doesn't apply because the result kind typically
    ## differs from the x-kind.
    expectKind body, nnkStmtList

    proc kindField(name: string, n: NimNode): string =
        case name
        of "String":     "s"
        of "Char":       "c"
        of "Block":      "a"
        of "Integer":    "i"
        of "Floating":   "f"
        of "Logical":    "b"
        of "Dictionary": "d"
        of "Binary":     "n"
        of "Range":      "rng"
        of "Regex":      "rx"
        of "Color":      "l"
        of "Quantity":   "q"
        of "Complex":    "z"
        of "Rational":   "rat"
        of "Object":     "o"
        else:
            error("dispatch: unsupported kind '" & name & "'", n); ""

    proc parsePat(n: NimNode, allowWild: bool): tuple[wild: bool, kind: string, binding: NimNode] =
        if allowWild and n.kind == nnkIdent and $n == "_":
            return (true, "", nil)
        if n.kind == nnkCall and n.len == 2 and n[0].kind == nnkIdent:
            if $n[0] == "_":
                error("dispatch: `_` wildcard cannot have a binding", n)
            return (false, $n[0], n[1])
        error("dispatch: expected `KIND(binding)`" &
              (if allowWild: " or `_`" else: ""), n)

    type Clause = object
        isElse: bool
        xKind: string
        xBinding: NimNode
        hasY: bool
        yWild: bool
        yKind: string
        yBinding: NimNode
        hasZ: bool
        zWild: bool
        zKind: string
        zBinding: NimNode
        body: NimNode

    var flat: seq[Clause]
    var hasElse = false
    var elseClause: Clause

    for clause in body:
        var fc: Clause
        if clause.kind == nnkCall and clause.len == 2 and
           clause[0].kind == nnkIdent and $clause[0] == "_":
            if hasElse: error("dispatch: duplicate `_:` fallback", clause)
            fc.isElse = true
            fc.body = clause[1]
            elseClause = fc
            hasElse = true
            continue
        elif clause.kind == nnkCall and clause.len == 3 and clause[0].kind == nnkIdent:
            fc.xKind = $clause[0]
            fc.xBinding = clause[1]
            fc.body = clause[2]
        elif clause.kind == nnkCall and clause.len == 2 and
             clause[0].kind in {nnkPar, nnkTupleConstr}:
            let par = clause[0]
            if par.len notin {2, 3}:
                error("dispatch: expected 2- or 3-element tuple", par)
            let xPat = parsePat(par[0], allowWild = false)
            fc.xKind = xPat.kind; fc.xBinding = xPat.binding
            fc.hasY = true
            let yPat = parsePat(par[1], allowWild = true)
            fc.yWild = yPat.wild; fc.yKind = yPat.kind; fc.yBinding = yPat.binding
            if par.len == 3:
                fc.hasZ = true
                let zPat = parsePat(par[2], allowWild = true)
                fc.zWild = zPat.wild; fc.zKind = zPat.kind; fc.zBinding = zPat.binding
            fc.body = clause[1]
        else:
            error("dispatch: malformed clause", clause)
        flat.add fc

    proc emitBranch(fc: Clause): NimNode =
        result = newStmtList()
        if fc.isElse:
            result.add copyNimTree(fc.body)
            return
        result.add newLetStmt(copyNimTree(fc.xBinding),
                              newDotExpr(ident("x"),
                                         ident(kindField(fc.xKind, fc.xBinding))))
        if fc.hasY and not fc.yWild:
            result.add newLetStmt(copyNimTree(fc.yBinding),
                                  newDotExpr(ident("y"),
                                             ident(kindField(fc.yKind, fc.yBinding))))
        if fc.hasZ and not fc.zWild:
            result.add newLetStmt(copyNimTree(fc.zBinding),
                                  newDotExpr(ident("z"),
                                             ident(kindField(fc.zKind, fc.zBinding))))
        result.add copyNimTree(fc.body)

    proc buildYBranch(ycls: seq[Clause]): NimNode =
        if not ycls[0].hasZ:
            if ycls.len > 1:
                error("dispatch: duplicate clauses for the same kind",
                      ycls[1].xBinding)
            return emitBranch(ycls[0])
        let zCase = nnkCaseStmt.newTree(ident("zKind"))
        var zElse: NimNode = nil
        for fc in ycls:
            if fc.zWild:
                if zElse != nil:
                    error("dispatch: duplicate z-axis `_` wildcard", fc.xBinding)
                zElse = emitBranch(fc)
            else:
                zCase.add nnkOfBranch.newTree(ident(fc.zKind), emitBranch(fc))
        if zElse != nil:
            zCase.add nnkElse.newTree(zElse)
        else:
            zCase.add nnkElse.newTree(nnkDiscardStmt.newTree(newEmptyNode()))
        return zCase

    var xOrder: seq[string]
    var xMap = initOrderedTable[string, seq[Clause]]()
    for fc in flat:
        if fc.xKind notin xMap:
            xMap[fc.xKind] = @[]
            xOrder.add fc.xKind
        xMap[fc.xKind].add fc

    let outer = nnkCaseStmt.newTree(ident("xKind"))
    for xKind in xOrder:
        let cls = xMap[xKind]
        if not cls[0].hasY:
            if cls.len > 1:
                error("dispatch: duplicate 1-axis clauses for kind '" & xKind & "'",
                      cls[1].xBinding)
            outer.add nnkOfBranch.newTree(ident(xKind), emitBranch(cls[0]))
        else:
            var yOrder: seq[string]
            var yMap = initOrderedTable[string, seq[Clause]]()
            for fc in cls:
                let key = if fc.yWild: "_" else: fc.yKind
                if key notin yMap:
                    yMap[key] = @[]; yOrder.add key
                yMap[key].add fc

            let inner = nnkCaseStmt.newTree(ident("yKind"))
            var yElse: NimNode = nil
            for yKey in yOrder:
                let yBody = buildYBranch(yMap[yKey])
                if yKey == "_":
                    yElse = yBody
                else:
                    inner.add nnkOfBranch.newTree(ident(yKey), yBody)
            if yElse != nil:
                inner.add nnkElse.newTree(yElse)
            else:
                inner.add nnkElse.newTree(nnkDiscardStmt.newTree(newEmptyNode()))
            outer.add nnkOfBranch.newTree(ident(xKind), inner)

    if hasElse:
        outer.add nnkElse.newTree(emitBranch(elseClause))
    else:
        outer.add nnkElse.newTree(nnkDiscardStmt.newTree(newEmptyNode()))

    result = newStmtList(outer)

macro attrTypes*(name: static[string], types: static[set[ValueKind]]): untyped =
    let attrRequiredTypes = ident('t' & ($name).capitalizeAscii())
    if types == {Any}:
        result = quote do:
            let `attrRequiredTypes` {.used.} = {Null..Any}
    elif types != {Logical}:
        result = quote do:
            let `attrRequiredTypes` {.used.} = `types`
    
template addOne*(attrs: untyped, idx: int): untyped =
    when attrs.len > idx:
        attrTypes(attrs[idx][0], attrs[idx][1][0])

macro addAttrTypes*(attrs: untyped): untyped =
    result = newStmtList()
    for i in 0..<20:
        result.add quote do:
            addOne(`attrs`, `i`)

template registerAlias(n: string, alias: VSymbol, rule: PrecedenceKind): untyped =
    ## Register an alias for a builtin or constant
    when alias != unaliased:
        Aliases[alias] = AliasBinding(
            precedence: rule,
            name: newWord(n)
        )

#=======================================
# Templates
#=======================================

template makeBuiltin*(n: string, alias: VSymbol, op: OpCode, rule: PrecedenceKind, description: string, args: untyped, attrs: static openArray[(string,(set[ValueKind],string))], returns: ValueSpec, example: string, act: untyped): untyped =
    when defined(DEV):
        static: echo " -> " & n

    when args.len == 1 and args == NoArgs:
        const argsLen = 0
    else:
        const argsLen = static args.len

    when defined(DOCGEN):
        const cleanExample = replace(strutils.strip(example), "\n            ", "\n")
    else:
        const cleanExample = ""

    let b = newBuiltin(
        when not defined(WEB): description else: "",
        when not defined(WEB): moduleName else: "",
        when not defined(WEB): static (instantiationInfo().line) else: 0,
        argsLen,
        when not defined(WEB): args.toOrderedTable else: initOrderedTable[string, ValueSpec](),
        when not defined(WEB): attrs.toOrderedTable else: initOrderedTable[string, (ValueSpec, string)](),
        returns,
        cleanExample,
        op,
        proc () =
            hookProcProfiler("lib/require"):
                require(n, args)

            when attrs != NoAttrs:
                addAttrTypes(attrs)

            {.emit: "////implementation: " & (static (instantiationInfo().filename.replace(".nim"))) & "/" & n .}

            hookFunctionProfiler(n):
                act

            {.emit: "////end: " & (static (instantiationInfo().filename.replace(".nim"))) & "/" & n .}
    )

    when n != "":
        SetSym(n, b)

        when n == "add":               DoAdd = b.action()
        elif n == "sub":               DoSub = b.action()
        elif n == "mul":               DoMul = b.action()
        elif n == "div":               DoDiv = b.action()
        elif n == "fdiv":              DoFdiv = b.action()
        elif n == "mod":               DoMod = b.action()
        elif n == "pow":               DoPow = b.action()
        elif n == "neg":               DoNeg = b.action()
        elif n == "inc":               DoInc = b.action()
        elif n == "dec":               DoDec = b.action()
        elif n == "not":               DoBNot = b.action()
        elif n == "and":               DoBAnd = b.action()
        elif n == "or":                DoBOr = b.action()
        elif n == "shl":               DoShl = b.action()
        elif n == "shr":               DoShr = b.action()
        elif n == "not?":              DoNot = b.action()
        elif n == "and?":              DoAnd = b.action()
        elif n == "or?":               DoOr = b.action()
        elif n == "equal?":            DoEq = b.action()
        elif n == "notEqual?":         DoNe = b.action()
        elif n == "greater?":          DoGt = b.action()
        elif n == "greaterOrEqual?":   DoGe = b.action()
        elif n == "less?":             DoLt = b.action()
        elif n == "lessOrEqual?":      DoLe = b.action()
        elif n == "get":               DoGet = b.action()
        elif n == "set":               DoSet = b.action()
        elif n == "if":                DoIf = b.action()
        elif n == "unless":            DoUnless = b.action()
        elif n == "switch":            DoSwitch = b.action()
        elif n == "while":             DoWhile = b.action()
        elif n == "return":            DoReturn = b.action()
        elif n == "break":             DoBreak = b.action()
        elif n == "continue":          DoContinue = b.action()
        elif n == "to":                DoTo = b.action()
        elif n == "array":             DoArray = b.action()
        elif n == "dictionary":        DoDict = b.action()
        elif n == "function":          DoFunc = b.action()
        elif n == "range":             DoRange = b.action()
        elif n == "loop":              DoLoop = b.action()
        elif n == "map":               DoMap = b.action()
        elif n == "select":            DoSelect = b.action()
        elif n == "size":              DoSize = b.action()
        elif n == "replace":           DoReplace = b.action()
        elif n == "split":             DoSplit = b.action()
        elif n == "join":              DoJoin = b.action()
        elif n == "reverse":           DoReverse = b.action()
        elif n == "append":            DoAppend = b.action()
        elif n == "print":             DoPrint = b.action()

        registerAlias(n, alias, rule)
    else:
        b

template builtin*(n: string, alias: VSymbol, op: OpCode, rule: PrecedenceKind, description: string, args: untyped, attrs: static openArray[(string,(set[ValueKind],string))], returns: ValueSpec, example: string, act: untyped): untyped =
    ## add new builtin, function with given name, alias, 
    ## rule, etc - followed by the code block to be 
    ## executed when the function is called
    
    when not defined(BUNDLE) or BundleSymbols.contains(n):
        makeBuiltin(n, alias, op, rule, description, args, attrs, returns, example):
            act

template builtinWhen*(flag: untyped, n: string, alias: VSymbol, op: OpCode, rule: PrecedenceKind, description: string, args: untyped, attrs: static openArray[(string,(set[ValueKind],string))], returns: ValueSpec, example: string, act: untyped): untyped =
    when defined(flag):
        builtin(n, alias, op, rule, description, args, attrs, returns, example, act)
    else:
        makeBuiltin(n, alias, op, rule, description, args, attrs, returns, example):
            showUnsupportedMiniFeatureError(n)

template adhoc*(description: string, args: untyped, attrs: static openArray[(string,(set[ValueKind],string))], returns: ValueSpec, act: untyped): untyped =
    ## create new builtin, but not in the global namespace;
    ## mainly used to create function in custom
    ## dictionaries or objects at runtime,
    ## e.g. `window` methods 
    makeBuiltin("", unaliased, opNop, PrefixPrecedence, description, args, attrs, returns, ""):
        act

template adhocPrivate*(args: untyped, attrs: static openArray[(string,(set[ValueKind],string))], act: untyped): untyped =
    ## create new "internal" builtin, but not in the global namespace;
    ## mainly used to create function in custom
    ## dictionaries or objects at runtime,
    ## e.g. `window` methods 
    ## these ones are not meant to be documented in code.
    adhoc("", args, attrs, {Nothing}, act)

# TODO(VM/lib) Merge constants and builtin's?
#  Do we really - really - need another "constant" type? I doubt it whether it makes any serious performance difference, with the only exception being constants like `true`, `false`, etc.
#  But then, it also over-complicates documentation generation for constants.
#  So, we should either make documentation possible for constants as well, or merge the two things into one concept
#  labels: vm, library, enhancement, open discussion

template constant*(n: string, alias: VSymbol, description: string, v: Value): untyped =
    ## add new constant with given name, alias, description - 
    ## followed by the value it's assigned to
    
    when not defined(BUNDLE) or BundleSymbols.contains(n):
    
        when defined(DEV):
            static: echo " -> " & n

        SetSym(n, v)
        var vInfo = ValueInfo(
            descr: description,
            module: moduleName,
            kind: v.kind
        )

        when defined(DOCGEN):
            vInfo.line = static (instantiationInfo().line)

        GetSym(n).info = vInfo

        registerAlias(n, alias, PrefixPrecedence)