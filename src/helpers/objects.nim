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

import std/enumerate, sequtils, sugar, tables
    
import vm/values/[value, comparison]
import vm/values/custom/[vsymbol]

import vm/[exec, errors, stack]

#=======================================
# Constants
#=======================================

const
    ConstructorField*   = "init"
    StringifyField*     = "print"
    ComparatorField*    = "compare"

#=======================================
# Helpers
#=======================================

template checkArguments(pr: Prototype, values: ValueArray | ValueDict) =
    when values is ValueArray:
        if pr.fields.len != values.len:
            RuntimeError_IncorrectNumberOfArgumentsForInitializer(pr.name, values.len, toSeq(pr.fields.keys))
    else:
        if pr.fields.len != 0 and pr.fields.len != values.len:
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
            for i,k in enumerate(pr.fields.keys):
                if (let vv = values.getOrDefault(k, nil); not vv.isNil):
                    args.add(vv)
                else:
                    RuntimeError_MissingArgumentForInitializer(pr.name, k)

func processMagicMethods(target: Value, methodName: string) =
    case methodName:
        of StringifyField:
            target.magic.doPrint = proc (self: Value): string =
                callFunction(target.o[methodName], "\\" & StringifyField, @[self])
                stack.pop().s
        of ComparatorField:
            target.magic.doCompare = proc (self: Value, other: Value): int =
                callFunction(target.o[methodName], "\\" & ComparatorField, @[self, other])
                stack.pop().i
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
                    newPathLabel(@[newWord("this"), newWord(val.s)]),
                    newWord(val.s)
                ])

        return newFunctionFromDefinition(params, constructorBody)
    
    return nil

func generatedCompare*(key: Value): Value {.inline.} =
    let compareBody = newBlock(@[
        newWord("if"), newPath(@[newWord("this"), key]), newSymbol(greaterthan), newPath(@[newWord("that"), key]), newBlock(@[newWord("return"),newInteger(1)]),
        newWord("if"), newPath(@[newWord("this"), key]), newSymbol(equal), newPath(@[newWord("that"), key]), newBlock(@[newWord("return"),newInteger(0)]),
        newWord("return"), newWord("neg"), newInteger(1)
    ])

    return newFunctionFromDefinition(@[newWord("that")], compareBody)

proc getTypeFields*(defs: ValueDict): ValueDict {.inline.} =
    result = newOrderedTable[string,Value]()

    if (let constructorMethod = defs.getOrDefault(ConstructorField, nil); not constructorMethod.isNil):
        for p in constructorMethod.params:
            result[p] = newType(Any)

        let ensureW = newWord("ensure")
        var i = 0
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

proc injectingThis*(fun: Value): Value {.inline.} =
    result = copyValue(fun)
    if result.params.len < 1 or result.params[0] != "this":
        result.params.insert("this")
        result.arity += 1

proc generateNewObject*(pr: Prototype, values: ValueArray | ValueDict): Value =
    # create basic object
    result = newObject(pr)

    # migrate all content and 
    # process internal methods accordingly
    for k,v in pr.content:
        if v.kind == Function:
            # inject `this`
            result.o[k] = injectingThis(v)

            # check if it's a magic method
            result.processMagicMethods(k)
        else:
            result.o[k] = copyValue(v)

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
    if (let constructorMethod = result.o.getOrDefault(ConstructorField, nil); (not constructorMethod.isNil) and constructorMethod.kind == Function):
        args.insert(result)
        callFunction(constructorMethod, "\\" & ConstructorField, args)

proc injectSuper*(meth: Value, parent: Value) =
    discard
    # # TODO(objects/injectSuper) should support `super` in all methods
    # #  right now, it supports it only in `init`
    # #  labels: bug, oop
    # var insertable = @[newLabel("super")]
    # echo "- injecting *super*"
    # if parent.isNil or not parent.ts.content.hasKey("init"):
    #     insertable.add(newWord("null"))
    #     echo "  .... as `null`"
    # else:
    #     echo "  .... as a function"
    #     let parentInit = parent.ts.content["init"]
    #     insertable.add(@[
    #         newWord("function"),
    #         newBlock(parentInit.params.filter(proc (zz: string): bool = zz != "this").map(proc (zz: string): Value = newWord(zz))),
    #         parentInit.main,
    #         newWord("do"),
    #         newSymbol(doublecolon)
    #     ])
    # meth.main.a.insert(insertable)