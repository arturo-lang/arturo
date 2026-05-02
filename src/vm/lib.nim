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

# `dispatch` and `dispatchWithLiteral` share their parser, clause grouping,
# and case-tree builder; only the per-clause emission strategy differs.
# The shared core lives below as plain compile-time helpers.

type
    DispatchOnArm = object
        attrName: string
        attrKind: string               # "" for boolean (`on attr:`)
        binding: NimNode               # nil for boolean
        body: NimNode

    DispatchClause = object
        isElse: bool                       # `_:` top-level fallback
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
        body: NimNode                      # 1-body / unified body
        valueE, inplaceS: NimNode          # split-mode bodies (dispatchWithLiteral only)
        onLadder: seq[DispatchOnArm]       # `on attr:` ladder (mutually exclusive with split)
        onElse: NimNode                    # `_:` fallback inside the ladder

proc dispatchIsWild(n: NimNode): bool =
    n != nil and n.kind == nnkIdent and $n == "_"

proc dispatchFieldAndCtor(kind: string, n: NimNode, macroName: string): (string, string) =
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
    of "Module":     ("singleton", "newModule")
    of "Date":       ("eobj", "newDate")
    of "Unit":       ("u", "newUnit")
    of "Bytecode":   ("trans", "newBytecode")
    of "SymbolLiteral": ("m", "newSymbolLiteral")
    of "Attribute":      ("s", "newAttribute")
    of "AttributeLabel": ("s", "newAttributeLabel")
    of "Word":           ("s", "newWord")
    of "Literal":        ("s", "newLiteral")
    of "Label":          ("s", "newLabel")
    of "Inline":         ("a", "newInline")
    of "Path":           ("p", "newPath")
    of "PathLabel":      ("p", "newPathLabel")
    of "PathLiteral":    ("p", "newPathLiteral")
    of "Symbol":         ("m", "newSymbol")
    of "Function":       ("funcType", "newFunction")
    of "Method":         ("methType", "newMethod")
    of "Error":          ("err", "newError")
    of "ErrorKind":      ("errKind", "newErrorKind")
    of "Version":        ("version", "newVersion")
    of "Store":          ("sto", "newStore")
    of "Socket":         ("sock", "newSocket")
    of "Type":           ("t", "newType")
    of "Null":           ("kind", "")
    of "Database":       ("dbKind", "")
    else:
        error(macroName & ": unsupported kind '" & kind & "'", n)

proc dispatchParsePat(n: NimNode, allowWild: bool, macroName: string):
     tuple[wild: bool, kind: string, binding: NimNode] =
    if allowWild and n.kind == nnkIdent and $n == "_":
        return (true, "", nil)
    if n.kind == nnkCall and n.len == 2 and n[0].kind == nnkIdent:
        if $n[0] == "_":
            error(macroName & ": `_` wildcard cannot have a binding", n)
        return (false, $n[0], n[1])
    error(macroName & ": expected `KIND(binding)`" &
          (if allowWild: " or `_`" else: ""), n)

proc dispatchAliasTemplate(name, target: NimNode): NimNode =
    # template <name>: untyped = <target>  — lvalue alias for inplace blocks
    nnkTemplateDef.newTree(
        name, newEmptyNode(), newEmptyNode(),
        nnkFormalParams.newTree(ident("untyped")),
        newEmptyNode(), newEmptyNode(),
        target
    )

proc dispatchSplitBody(b: NimNode):
     tuple[valueE, inplaceS, unifiedB: NimNode] =
    # Detect `value:`/`inplace:` split-mode; otherwise body is verbatim.
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

proc dispatchParseOnLadder(b: NimNode, macroName: string):
     tuple[arms: seq[DispatchOnArm], onElse: NimNode, isLadder: bool] =
    # Detect a body composed exclusively of `on <attr>:` (or `on <attr>(b: KIND):`)
    # commands, optionally terminated by a `_:` fallback.
    if b.kind != nnkStmtList or b.len == 0:
        return
    for c in b:
        let isOn = c.kind == nnkCommand and c.len >= 3 and
                   c[0].kind == nnkIdent and $c[0] == "on"
        let isElse = c.kind == nnkCall and c.len == 2 and
                     c[0].kind == nnkIdent and $c[0] == "_"
        if not (isOn or isElse): return
    var arms: seq[DispatchOnArm]
    var onElse: NimNode = nil
    for c in b:
        if c.kind == nnkCall:                           # `_: body`
            if onElse != nil:
                error(macroName & ": duplicate `_:` fallback in `on` ladder", c)
            onElse = c[1]
        else:                                           # `on …: body`
            var arm: DispatchOnArm
            arm.body = c[c.len - 1]
            let head = c[1]
            if head.kind == nnkIdent:
                arm.attrName = $head
            elif head.kind == nnkObjConstr and head.len == 2 and
                 head[0].kind == nnkIdent and head[1].kind == nnkExprColonExpr and
                 head[1][0].kind == nnkIdent and head[1][1].kind == nnkIdent:
                arm.attrName = $head[0]
                arm.binding = head[1][0]
                arm.attrKind = $head[1][1]
            else:
                error(macroName & ": malformed `on` clause — expected `on attr:` or `on attr(b: KIND):`", c)
            arms.add arm
    return (arms, onElse, true)

proc dispatchParseClauses(body: NimNode, macroName: string, splitBodies: bool):
     tuple[flat: seq[DispatchClause], elseClause: DispatchClause, hasElse: bool] =
    expectKind body, nnkStmtList

    proc fillBody(fc: var DispatchClause, n: NimNode) =
        # Try on-ladder first; then split-mode (if allowed); then unified.
        let onP = dispatchParseOnLadder(n, macroName)
        if onP.isLadder:
            fc.onLadder = onP.arms
            fc.onElse = onP.onElse
            return
        if splitBodies:
            let (v, p, u) = dispatchSplitBody(n)
            fc.valueE = v; fc.inplaceS = p; fc.body = u
        else:
            fc.body = n

    for clause in body:
        var fc: DispatchClause
        if clause.kind == nnkCall and clause.len == 2 and
           clause[0].kind == nnkIdent and $clause[0] == "_":
            # `_: body` — top-level x-axis fallback
            if result.hasElse:
                error(macroName & ": duplicate `_:` fallback", clause)
            fc.isElse = true
            fillBody(fc, clause[1])
            result.elseClause = fc
            result.hasElse = true
            continue
        elif clause.kind == nnkCall and clause.len == 3 and clause[0].kind == nnkIdent:
            # 1-axis: KIND(binding): body
            fc.xKind = $clause[0]
            fc.xBinding = clause[1]
            fillBody(fc, clause[2])
        elif clause.kind == nnkCall and clause.len == 2 and
             clause[0].kind in {nnkPar, nnkTupleConstr}:
            # 2- or 3-axis: (KIND(b), ...): body
            let par = clause[0]
            if par.len notin {2, 3}:
                error(macroName & ": expected 2- or 3-element tuple", par)
            let xPat = dispatchParsePat(par[0], allowWild = false, macroName)
            fc.xKind = xPat.kind; fc.xBinding = xPat.binding
            fc.hasY = true
            let yPat = dispatchParsePat(par[1], allowWild = true, macroName)
            fc.yWild = yPat.wild; fc.yKind = yPat.kind; fc.yBinding = yPat.binding
            if par.len == 3:
                fc.hasZ = true
                let zPat = dispatchParsePat(par[2], allowWild = true, macroName)
                fc.zWild = zPat.wild; fc.zKind = zPat.kind; fc.zBinding = zPat.binding
            fillBody(fc, clause[1])
        else:
            error(macroName & ": malformed clause", clause)
        result.flat.add fc

proc dispatchBuildCase(disc: NimNode, flat: seq[DispatchClause],
                       elseClause: DispatchClause, hasElse: bool,
                       emit: proc(fc: DispatchClause): NimNode,
                       macroName: string): NimNode =
    proc buildYBranch(ycls: seq[DispatchClause]): NimNode =
        # All clauses share xKind & yKind (or yWild). May further dispatch on z.
        if not ycls[0].hasZ:
            if ycls.len > 1:
                error(macroName & ": duplicate clauses for the same kind",
                      ycls[1].xBinding)
            return emit(ycls[0])
        let zCase = nnkCaseStmt.newTree(ident("zKind"))
        var zElse: NimNode = nil
        for fc in ycls:
            if fc.zWild:
                if zElse != nil:
                    error(macroName & ": duplicate z-axis `_` wildcard", fc.xBinding)
                zElse = emit(fc)
            else:
                zCase.add nnkOfBranch.newTree(ident(fc.zKind), emit(fc))
        if zElse != nil:
            zCase.add nnkElse.newTree(zElse)
        else:
            zCase.add nnkElse.newTree(nnkDiscardStmt.newTree(newEmptyNode()))
        return zCase

    var xOrder: seq[string]
    var xMap = initOrderedTable[string, seq[DispatchClause]]()
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
                error(macroName & ": duplicate 1-axis clauses for kind '" & xKind & "'",
                      cls[1].xBinding)
            result.add nnkOfBranch.newTree(ident(xKind), emit(cls[0]))
        else:
            var yOrder: seq[string]
            var yMap = initOrderedTable[string, seq[DispatchClause]]()
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
            result.add nnkOfBranch.newTree(ident(xKind), inner)

    if hasElse:
        result.add nnkElse.newTree(emit(elseClause))
    else:
        result.add nnkElse.newTree(nnkDiscardStmt.newTree(newEmptyNode()))

proc dispatchBuildOnLadder(arms: seq[DispatchOnArm], elseBody: NimNode,
                           wrap: proc(armBody: NimNode): NimNode,
                           macroName: string): NimNode =
    ## Build a `block label: …` containing the chained attr-test ladder.
    ## `wrap(body)` adapts each arm body to the caller's mode (auto-wrap for
    ## dispatchWithLiteral, identity for dispatch). Typed arms with the same
    ## attribute name are coalesced into a single `case aName.kind:` so the
    ## attr is popped only once.
    let label = ident("__onLadder")
    var stmts = newStmtList()
    var seenTyped: seq[string]

    for arm in arms:
        if arm.attrKind == "":
            # boolean: `if hadAttr(name): <wrap body>; break label`
            let cond = newCall(ident("hadAttr"), newStrLitNode(arm.attrName))
            let body = newStmtList(wrap(copyNimTree(arm.body)),
                                   nnkBreakStmt.newTree(label))
            stmts.add nnkIfStmt.newTree(nnkElifBranch.newTree(cond, body))
        else:
            if arm.attrName in seenTyped: continue
            seenTyped.add arm.attrName
            # gather all typed arms with this attrName
            var sameArms: seq[DispatchOnArm]
            for a in arms:
                if a.attrKind != "" and a.attrName == arm.attrName:
                    sameArms.add a
            let aIdent = ident('a' & arm.attrName.capitalizeAscii())
            let kindCase = nnkCaseStmt.newTree(newDotExpr(aIdent, ident("kind")))
            for sa in sameArms:
                let (field, _) = dispatchFieldAndCtor(sa.attrKind, sa.binding, macroName)
                kindCase.add nnkOfBranch.newTree(
                    ident(sa.attrKind),
                    newStmtList(
                        newLetStmt(copyNimTree(sa.binding),
                                   newDotExpr(aIdent, ident(field))),
                        wrap(copyNimTree(sa.body)),
                        nnkBreakStmt.newTree(label)
                    )
                )
            kindCase.add nnkElse.newTree(nnkDiscardStmt.newTree(newEmptyNode()))
            let cond = newCall(ident("checkAttr"), newStrLitNode(arm.attrName))
            stmts.add nnkIfStmt.newTree(nnkElifBranch.newTree(cond, kindCase))

    if elseBody != nil:
        stmts.add wrap(copyNimTree(elseBody))
    else:
        stmts.add nnkDiscardStmt.newTree(newEmptyNode())

    result = nnkBlockStmt.newTree(label, stmts)

#=======================================
# Dispatch macros
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
    ## `x`/`y`/`z` are always in scope (injected by `require`); the binding
    ## name is an alias — a `let` for read-only access, a `template` (lvalue)
    ## when an `inplace:` block needs to mutate.
    const macroName = "dispatchWithLiteral"
    let parsed = dispatchParseClauses(body, macroName, splitBodies = true)

    proc emit(fc: DispatchClause, valueMode: bool): NimNode =
        result = newStmtList()
        if fc.isElse:
            if fc.onLadder.len > 0:
                error(macroName & ": `on` ladder isn't supported in `_:` " &
                      "x-fallback (no x-kind to auto-wrap with)")
            # No xKind — body uses x/y/z directly. No auto-wrap (kind unknown).
            let chosen =
                if valueMode: (if fc.valueE   != nil: fc.valueE   else: fc.body)
                else:         (if fc.inplaceS != nil: fc.inplaceS else: fc.body)
            if chosen != nil: result.add copyNimTree(chosen)
            else: result.add nnkDiscardStmt.newTree(newEmptyNode())
            return

        let (xField, xCtor) = dispatchFieldAndCtor(fc.xKind, fc.xBinding, macroName)
        let xTarget =
            if valueMode: newDotExpr(ident("x"), ident(xField))
            else: newDotExpr(ident("InPlaced"), ident(xField))

        let needsLValue = (not valueMode) and fc.inplaceS != nil
        if not dispatchIsWild(fc.xBinding):
            if needsLValue:
                result.add dispatchAliasTemplate(copyNimTree(fc.xBinding), xTarget)
            else:
                result.add newLetStmt(copyNimTree(fc.xBinding), xTarget)

        if fc.hasY and not fc.yWild and not dispatchIsWild(fc.yBinding):
            let (yField, _) = dispatchFieldAndCtor(fc.yKind, fc.yBinding, macroName)
            result.add newLetStmt(copyNimTree(fc.yBinding),
                                  newDotExpr(ident("y"), ident(yField)))
        if fc.hasZ and not fc.zWild and not dispatchIsWild(fc.zBinding):
            let (zField, _) = dispatchFieldAndCtor(fc.zKind, fc.zBinding, macroName)
            result.add newLetStmt(copyNimTree(fc.zBinding),
                                  newDotExpr(ident("z"), ident(zField)))

        if fc.onLadder.len > 0:
            # Wrap each arm body the same way a unified body is wrapped.
            let wrap =
                if valueMode:
                    proc(armBody: NimNode): NimNode =
                        newCall(ident("push"), newCall(ident(xCtor), armBody))
                else:
                    proc(armBody: NimNode): NimNode =
                        newAssignment(copyNimTree(xTarget), armBody)
            result.add dispatchBuildOnLadder(fc.onLadder, fc.onElse, wrap, macroName)
            return

        if valueMode:
            if fc.valueE != nil:
                result.add copyNimTree(fc.valueE)
            elif fc.body != nil:
                result.add newCall(ident("push"),
                                   newCall(ident(xCtor), copyNimTree(fc.body)))
            else:
                result.add nnkDiscardStmt.newTree(newEmptyNode())
        else:
            if fc.inplaceS != nil:
                result.add copyNimTree(fc.inplaceS)
            elif fc.body != nil:
                result.add newAssignment(copyNimTree(xTarget),
                                         copyNimTree(fc.body))
            else:
                result.add nnkDiscardStmt.newTree(newEmptyNode())

    let outer = dispatchBuildCase(ident("xKind"),
                                  parsed.flat, parsed.elseClause, parsed.hasElse,
                                  proc(fc: DispatchClause): NimNode = emit(fc, valueMode = true),
                                  macroName)
    let inner = dispatchBuildCase(newDotExpr(ident("InPlaced"), ident("kind")),
                                  parsed.flat, parsed.elseClause, parsed.hasElse,
                                  proc(fc: DispatchClause): NimNode = emit(fc, valueMode = false),
                                  macroName)

    # Splice the Literal/PathLiteral branch BEFORE the outer's else
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
    ## Same clause grammar as `dispatchWithLiteral`, but no in-place branch is
    ## emitted and bodies are *verbatim* full statements — the user writes
    ## their own `push(...)`. Auto-wrap doesn't apply because the result kind
    ## typically differs from the x-kind.
    const macroName = "dispatch"
    let parsed = dispatchParseClauses(body, macroName, splitBodies = false)

    proc emit(fc: DispatchClause): NimNode =
        result = newStmtList()
        if fc.isElse:
            if fc.onLadder.len > 0:
                result.add dispatchBuildOnLadder(fc.onLadder, fc.onElse,
                    proc(b: NimNode): NimNode = b, macroName)
            else:
                result.add copyNimTree(fc.body)
            return
        if not dispatchIsWild(fc.xBinding):
            let (xField, _) = dispatchFieldAndCtor(fc.xKind, fc.xBinding, macroName)
            result.add newLetStmt(copyNimTree(fc.xBinding),
                                  newDotExpr(ident("x"), ident(xField)))
        if fc.hasY and not fc.yWild and not dispatchIsWild(fc.yBinding):
            let (yField, _) = dispatchFieldAndCtor(fc.yKind, fc.yBinding, macroName)
            result.add newLetStmt(copyNimTree(fc.yBinding),
                                  newDotExpr(ident("y"), ident(yField)))
        if fc.hasZ and not fc.zWild and not dispatchIsWild(fc.zBinding):
            let (zField, _) = dispatchFieldAndCtor(fc.zKind, fc.zBinding, macroName)
            result.add newLetStmt(copyNimTree(fc.zBinding),
                                  newDotExpr(ident("z"), ident(zField)))
        if fc.onLadder.len > 0:
            result.add dispatchBuildOnLadder(fc.onLadder, fc.onElse,
                proc(b: NimNode): NimNode = b, macroName)
        else:
            result.add copyNimTree(fc.body)

    result = newStmtList(dispatchBuildCase(ident("xKind"),
                                           parsed.flat, parsed.elseClause, parsed.hasElse,
                                           emit, macroName))

macro bindAttrs*(body: untyped): untyped =
    ## Declare attribute-bound locals as a prelude to a builtin's body.
    ## (Named `bindAttrs` rather than `attrs` because `attrs` is shadowed
    ## inside a builtin body by `makeBuiltin`'s own `attrs` parameter.)
    ##
    ## Forms:
    ##   `name: Logical`                       — boolean flag, becomes `let name = hadAttr("name")`
    ##   `name: KIND = default`                — typed value attr; `var name = default;
    ##                                            if checkAttr("name"): name = aName.<field>`
    ##   `name(attrName): KIND = default`      — same, but the attribute is
    ##                                            named differently from the local
    ##
    ## Composable: the resulting locals are ordinary Nim variables visible to
    ## any subsequent code (including a `dispatchWithLiteral` block). Pair with
    ## `on attr:` ladders inside dispatch clauses for mutually-exclusive
    ## attrs.
    expectKind body, nnkStmtList
    const macroName = "bindAttrs"
    result = newStmtList()

    for decl in body:
        var localName, attrName, typeStmt: NimNode
        if decl.kind == nnkCall and decl.len == 2 and decl[0].kind == nnkIdent:
            localName = decl[0]; attrName = decl[0]; typeStmt = decl[1]
        elif decl.kind == nnkCall and decl.len == 3 and
             decl[0].kind == nnkIdent and decl[1].kind == nnkIdent:
            localName = decl[0]; attrName = decl[1]; typeStmt = decl[2]
        else:
            error(macroName & ": expected `name: KIND[=default]` or `name(attr): KIND[=default]`", decl)

        expectKind typeStmt, nnkStmtList
        if typeStmt.len != 1:
            error(macroName & ": expected a single type expression", typeStmt)
        let texp = typeStmt[0]
        var kindIdent, defaultExpr: NimNode
        if texp.kind == nnkIdent:
            kindIdent = texp
        elif texp.kind == nnkAsgn and texp.len == 2:
            kindIdent = texp[0]; defaultExpr = texp[1]
        else:
            error(macroName & ": expected `KIND` or `KIND = default`", texp)

        let kindStr = $kindIdent
        let attrLit = newStrLitNode($attrName)

        if kindStr == "Logical" and defaultExpr == nil:
            # `let name = hadAttr("attrName")`
            result.add newLetStmt(localName,
                                  newCall(ident("hadAttr"), attrLit))
        else:
            if defaultExpr == nil:
                error(macroName & ": typed attr requires a default value", decl)
            let (field, _) = dispatchFieldAndCtor(kindStr, kindIdent, macroName)
            let aIdent = ident('a' & ($attrName).capitalizeAscii())
            # var name = default
            result.add nnkVarSection.newTree(
                nnkIdentDefs.newTree(localName, newEmptyNode(), defaultExpr))
            # if checkAttr("name"): name = aName.<field>
            result.add nnkIfStmt.newTree(nnkElifBranch.newTree(
                newCall(ident("checkAttr"), attrLit),
                newAssignment(localName, newDotExpr(aIdent, ident(field)))
            ))

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