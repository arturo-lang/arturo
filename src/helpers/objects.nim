#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: helpers/objects.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import std/sequtils, sugar, tables
    
import vm/values/[value, comparison, printable]
import vm/values/custom/[vsymbol]

import vm/[exec, errors, stack]

#=======================================
# Constants
#=======================================

const
    ThisRef*            = "this"
    SuperRef*           = "super"

    # magic methods
    ConstructorM*       = "init"
    ToStringM*          = "print"
    CompareM*           = "compare"

    GetM*               = "get"
    SetM*               = "set"

    EqualQM*            = "equal?"
    LessQM*             = "less?"
    GreaterQM*          = "greater?"

    AddM*               = "add"
    SubM*               = "sub"
    MulM*               = "mul"
    DivM*               = "div"
    ModM*               = "mod"
    PowM*               = "pow"

    IncM*               = "inc"
    DecM*               = "dec"

    NegM*               = "neg"

#=======================================
# Helpers
#=======================================

template checkArguments(pr: Prototype, values: ValueArray | ValueDict) =
    when values is ValueArray:
        if pr.fields.len != values.len:
            RuntimeError_IncorrectNumberOfArgumentsForInitializer(pr.name, values.len, toSeq(pr.fields.keys))
    else:
        if (pr.fields.len != 0 or (pr.fields.len == 0 and pr.content.hasKey(ConstructorM))) and pr.fields.len != values.len:
            RuntimeError_IncorrectNumberOfArgumentsForInitializer(pr.name, values.len, toSeq(pr.fields.keys))

proc fetchConstructorArguments(pr: Prototype, values: ValueArray | ValueDict, args: var ValueArray): bool =
    result = true

    when values is ValueArray:
        for v in values:
            args.add(v)
    else:
        if pr.fields.len == 0:
            return false
        else:
            for k,v in pr.fields:
                if k != ThisRef:
                    if (let vv = values.getOrDefault(k, nil); not vv.isNil):
                        args.add(vv)
                    else:
                        RuntimeError_MissingArgumentForInitializer(pr.name, k)

func processMagicMethods(target: Value, methodName: string) =
    case methodName:
        of ConstructorM:
            target.magic.doInit = proc (args: ValueArray) =
                callMethod(target.o[methodName], "\\" & ConstructorM, args)
        of ToStringM:
            target.magic.doPrint = proc (self: Value): string =
                callMethod(target.o[methodName], "\\" & ToStringM, @[self])
                stack.pop().s
        of CompareM:
            target.magic.doCompare = proc (self: Value, other: Value): int =
                callMethod(target.o[methodName], "\\" & CompareM, @[self, other])
                stack.pop().i
        of GetM:
            target.magic.doGet = proc (self: Value, key: Value): Value =
                callMethod(target.o[methodName], "\\" & GetM, @[self, key])
                stack.pop()
        of SetM:
            target.magic.doSet = proc (self: Value, key: Value, val: Value) =
                callMethod(target.o[methodName], "\\" & SetM, @[self, key, val])
        of EqualQM:
            target.magic.doEqualQ = proc (self: Value, other: Value): bool =
                callMethod(target.o[methodName], "\\" & EqualQM, @[self, other])
                isTrue(stack.pop())
        of LessQM:
            target.magic.doEqualQ = proc (self: Value, other: Value): bool =
                callMethod(target.o[methodName], "\\" & LessQM, @[self, other])
                isTrue(stack.pop())
        of GreaterQM:
            target.magic.doEqualQ = proc (self: Value, other: Value): bool =
                callMethod(target.o[methodName], "\\" & GreaterQM, @[self, other])
                isTrue(stack.pop())
        of AddM:
            target.magic.doAdd = proc (self: Value, other: Value) =
                callMethod(target.o[methodName], "\\" & AddM, @[self, other])
        of SubM:
            target.magic.doSub = proc (self: Value, other: Value) =
                callMethod(target.o[methodName], "\\" & SubM, @[self, other])
        of MulM:
            target.magic.doMul = proc (self: Value, other: Value) =
                callMethod(target.o[methodName], "\\" & MulM, @[self, other])
        of DivM:
            target.magic.doDiv = proc (self: Value, other: Value) =
                callMethod(target.o[methodName], "\\" & DivM, @[self, other])
        of ModM:
            target.magic.doMod = proc (self: Value, other: Value) =
                callMethod(target.o[methodName], "\\" & ModM, @[self, other])
        of PowM:
            target.magic.doPow = proc (self: Value, other: Value) =
                callMethod(target.o[methodName], "\\" & PowM, @[self, other])
        of IncM:
            target.magic.doInc = proc (self: Value) =
                callMethod(target.o[methodName], "\\" & IncM, @[self])
        of DecM:
            target.magic.doDec = proc (self: Value) =
                callMethod(target.o[methodName], "\\" & DecM, @[self])
        of NegM:
            target.magic.doNeg = proc (self: Value) =
                callMethod(target.o[methodName], "\\" & NegM, @[self])
        else:
            discard

#=======================================
# Methods
#=======================================

func generatedConstructor*(params: ValueArray): Value {.inline.} =
    if params.len > 0 and params.all((x) => x.kind in {Word, Literal, String, Type}):
        let constructorBody = newBlock()
        for val in params:
            if val.kind in {Word, Literal, String}:
                constructorBody.a.add(@[
                    newPathLabel(@[newWord(ThisRef), newWord(val.s)]),
                    newWord(val.s)
                ])

        return newMethodFromDefinition(params, constructorBody)
    
    return nil

func generatedCompare*(key: Value): Value {.inline.} =
    let compareBody = newBlock(@[
        newWord("if"), newPath(@[newWord(ThisRef), key]), newSymbol(greaterthan), newPath(@[newWord("that"), key]), newBlock(@[newWord("return"),newInteger(1)]),
        newWord("if"), newPath(@[newWord(ThisRef), key]), newSymbol(equal), newPath(@[newWord("that"), key]), newBlock(@[newWord("return"),newInteger(0)]),
        newWord("return"), newWord("neg"), newInteger(1)
    ])

    return newMethodFromDefinition(@[newWord("that")], compareBody)

proc getFieldTable*(defs: ValueDict): ValueDict {.inline.} =
    result = newOrderedTable[string,Value]()

    if (let constructorMethod = defs.getOrDefault(ConstructorM, nil); not constructorMethod.isNil):
        for p in constructorMethod.params:
            if p != "this":
                result[p] = newType(Any)

        let ensureW = newWord("ensure")
        var i = 1
        while i < constructorMethod.main.a.len - 1:
            if (let ensureBlock = constructorMethod.main.a[i+1]; constructorMethod.main.a[i] == ensureW and ensureBlock.kind == Block):
                let lastElement = ensureBlock.a[^1]
                if lastElement.kind == Word:
                    if ensureBlock.a[^2].kind == Type:
                        result[lastElement.s] = ensureBlock.a[^2]
                elif lastElement.kind == Block:
                    let sublastElement = lastElement.a[^1]
                    if sublastElement.kind == Word and lastElement.a[^2].kind == Type:
                        result[sublastElement.s] = newBlock(lastElement.a.filter((x) => x.kind == Type))
            i += 2

proc injectThis*(fun: Value) {.inline.} =
    if fun.params.len < 1 or fun.params[0] != ThisRef:
        fun.params.insert(ThisRef)
        fun.arity += 1

proc uninjectingThis*(fun: Value): Value {.inline.} =
    result = copyValue(fun)
    if result.params.len >= 1 and result.params[0] == ThisRef:
        result.params.delete(0..0)
        result.arity -= 1

proc injectingSuper*(fun: Value, super: Value): Value {.inline.} =
    result = copyValue(fun)

    let injection = @[
        newLabel(SuperRef), newWord("function"), newBlock(super.mparams.map((w)=>newWord(w))), super.mmain
    ]

    result.main.a.insert(injection)

proc generateNewObject*(pr: Prototype, values: ValueArray | ValueDict): Value =
    # create basic object
    result = newObject(pr)

    # migrate all content and 
    # process internal methods accordingly
    for k,v in pr.content:
        result.o[k] = copyValue(v)
        if v.kind == Method and not v.mdistinct:
            result.processMagicMethods(k)

    # verify arguments
    checkArguments(pr, values)

    # and process them accordingly
    var args: ValueArray = @[]
    if not fetchConstructorArguments(pr, values, args):
        when values is ValueDict:
            # if there is no constructor defined
            # and we try to initialize the object with a dictionary,
            # let's just copy the values
            for k,v in values:
                result.o[k] = v
    
    # perform initialization 
    # using the available constructor
    if (let constructor = result.magic.doInit; not constructor.isNil):
        args.insert(result)
        constructor(args)