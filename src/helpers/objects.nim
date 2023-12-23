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
    
import vm/values/[value, comparison]
import vm/values/custom/[vsymbol]

import vm/[exec, errors, stack]

#=======================================
# Types
#=======================================

type
    MagicMethod* = enum
        ConstructorM        = "init"

        GetM                = "get"
        SetM                = "set"

        ChangingM           = "changing"
        ChangedM            = "changed"

        CompareM            = "compare"
        EqualQM             = "equal?"
        LessQM              = "less?"
        GreaterQM           = "greater?"

        AddM                = "add"
        SubM                = "sub"
        MulM                = "mul"
        DivM                = "div"
        FDivM               = "fdiv"
        ModM                = "mod"
        PowM                = "pow"

        IncM                = "inc"
        DecM                = "dec"

        NegM                = "neg"

        KeyQM               = "key?"
        ContainsQM          = "contains?"

        AppendM             = "append"
        RemoveM             = "remove"

        ToStringM           = "toString"
        ToIntegerM          = "toInteger"
        ToFloatingM         = "toFloating"
        ToLogicalM          = "toLogical"
        ToBlockM            = "toBlock"
        ToDictionaryM       = "toDictionary"

#=======================================
# Constants
#=======================================

const
    ThisRef*            = "this"
    SuperRef*           = "super"

#=======================================
# Helpers
#=======================================

template checkArguments(pr: Prototype, values: ValueArray | ValueDict) =
    when values is ValueArray:
        if pr.fields.len != values.len:
            RuntimeError_IncorrectNumberOfArgumentsForInitializer(pr.name, values.len, toSeq(pr.fields.keys))
    else:
        if (pr.fields.len != 0 or (pr.fields.len == 0 and pr.content.hasKey($ConstructorM))) and pr.fields.len != values.len:
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

# TODO(Helpers/objects) Should check defined magic methods for validity
#  obviously, we cannot check everything beforehand (if the parems are correct
#  or if the method return what it should - or if it returns at all, for that
#  matter). But we should - at least - check if the given magic method has the
#  correct number of arguments. And if not, throw an error.
#  labels: oop, error handling
func processMagicMethods(target: Value, mm: var MagicMethods, methodName: string) =
    case methodName:
        of $ConstructorM:
            mm.doInit = proc (args: ValueArray) =
                callMethod(target, "\\" & methodName, args)
        of $GetM:
            mm.doGet = proc (self: Value, key: Value) =
                callMethod(target, "\\" & methodName, @[self, key])
        of $SetM:
            mm.doSet = proc (self: Value, key: Value, val: Value) =
                callMethod(target, "\\" & methodName, @[self, key, val])
        of $ChangingM:
            mm.doChanged = proc (self: Value, key: Value) =
                callMethod(target, "\\" & methodName, @[self, key])
        of $ChangedM:
            mm.doChanged = proc (self: Value, key: Value) =
                callMethod(target, "\\" & methodName, @[self, key])
        of $CompareM:
            mm.doCompare = proc (self: Value, other: Value): int =
                callMethod(target, "\\" & methodName, @[self, other])
                stack.pop().i
        of $EqualQM:
            mm.doEqualQ = proc (self: Value, other: Value): bool =
                callMethod(target, "\\" & methodName, @[self, other])
                isTrue(stack.pop())
        of $LessQM:
            mm.doLessQ = proc (self: Value, other: Value): bool =
                callMethod(target, "\\" & methodName, @[self, other])
                isTrue(stack.pop())
        of $GreaterQM:
            mm.doGreaterQ = proc (self: Value, other: Value): bool =
                callMethod(target, "\\" & methodName, @[self, other])
                isTrue(stack.pop())
        of $AddM:
            mm.doAdd = proc (self: Value, other: Value) =
                callMethod(target, "\\" & methodName, @[self, other])
        of $SubM:
            mm.doSub = proc (self: Value, other: Value) =
                callMethod(target, "\\" & methodName, @[self, other])
        of $MulM:
            mm.doMul = proc (self: Value, other: Value) =
                callMethod(target, "\\" & methodName, @[self, other])
        of $DivM:
            mm.doDiv = proc (self: Value, other: Value) =
                callMethod(target, "\\" & methodName, @[self, other])
        of $FDivM:
            mm.doFDiv = proc (self: Value, other: Value) =
                callMethod(target, "\\" & methodName, @[self, other])
        of $ModM:
            mm.doMod = proc (self: Value, other: Value) =
                callMethod(target, "\\" & methodName, @[self, other])
        of $PowM:
            mm.doPow = proc (self: Value, other: Value) =
                callMethod(target, "\\" & methodName, @[self, other])
        of $IncM:
            mm.doInc = proc (self: Value) =
                callMethod(target, "\\" & methodName, @[self])
        of $DecM:
            mm.doDec = proc (self: Value) =
                callMethod(target, "\\" & methodName, @[self])
        of $NegM:
            mm.doNeg = proc (self: Value) =
                callMethod(target, "\\" & methodName, @[self])
        of $KeyQM:
            mm.doKeyQ = proc (self: Value, key: Value): bool =
                callMethod(target, "\\" & methodName, @[self, key])
                isTrue(stack.pop())
        of $ContainsQM:
            mm.doContainsQ = proc (self: Value, key: Value): bool =
                callMethod(target, "\\" & methodName, @[self, key])
                isTrue(stack.pop())
        of $AppendM:
            mm.doAppend = proc (self: Value, other: Value) =
                callMethod(target, "\\" & methodName, @[self, other])
        of $RemoveM:
            mm.doRemove = proc (self: Value, other: Value) =
                callMethod(target, "\\" & methodName, @[self, other])
        of $ToStringM:
            mm.toString = proc (self: Value): Value =
                callMethod(target, "\\" & methodName, @[self])
                stack.pop()
        of $ToIntegerM:
            mm.toInteger = proc (self: Value): Value =
                callMethod(target, "\\" & methodName, @[self])
                stack.pop()
        of $ToFloatingM:
            mm.toFloating = proc (self: Value): Value =
                callMethod(target, "\\" & methodName, @[self])
                stack.pop()
        of $ToLogicalM:
            mm.toLogical = proc (self: Value): Value =
                callMethod(target, "\\" & methodName, @[self])
                stack.pop()
        of $ToBlockM:
            mm.toBlock = proc (self: Value): Value =
                callMethod(target, "\\" & methodName, @[self])
                stack.pop()
        of $ToDictionaryM:
            mm.toDictionary = proc (self: Value): Value =
                callMethod(target, "\\" & methodName, @[self])
                stack.pop()
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

    if (let constructorMethod = defs.getOrDefault($ConstructorM, nil); not constructorMethod.isNil):
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
    # process magic method accordingly
    var magicMethods = MagicMethods()
    for k,v in pr.content:
        result.o[k] = copyValue(v)
        if v.kind == Method and not v.mdistinct:
            processMagicMethods(v, magicMethods, k)

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
    if (let constructor = magicMethods.doInit; not constructor.isNil):
        args.insert(result)
        constructor(args)

    # embed magic methods as well
    result.magic = magicMethods