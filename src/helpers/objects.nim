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

import vm/[exec, errors]

#=======================================
# Constants
#=======================================

let
    ConstructorField*   = "init"
    StringifyField*     = "print"

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
    result = Value(kind: Object, o: newOrderedTable[string,Value](), proto: pr, magic: MagicMethods())
    for k,v in pr.content:
        if v.kind == Function:
            result.o[k] = injectingThis(v)
        else:
            result.o[k] = copyValue(v)

    checkArguments(pr, values)

    var args: ValueArray = @[]
    
    if not fetchConstructorArguments(pr, values, args):
        when values is ValueDict:
            for k,v in values:
                result.o[k] = v
    
    if (let constructorMethod = result.o.getOrDefault(ConstructorField, nil); (not constructorMethod.isNil) and constructorMethod.kind == Function):
        args.insert(result)
        callFunction(constructorMethod, "\\" & ConstructorField, args)

    if (let stringifyMethod = result.o.getOrDefault(StringifyField, nil); (not stringifyMethod.isNil) and stringifyMethod.kind == Function):
        result.magic.doPrint = proc (self: Value) =
            callFunction(stringifyMethod, "\\" & StringifyField, @[self])

# proc injectThis*(meth: Value) =
#     if meth.params.len < 1 or meth.params[0] != "this":
#         echo "meth.arity was was: " & $(meth.arity)
#         echo "- injecting *this*"
#         meth.params.insert("this")
#         echo "meth.arity was: " & $(meth.arity)
#         meth.arity += 1
#         echo "meth.arity is: " & $(meth.arity)

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

proc prepareMethods*(proto: Prototype) =
    # setup our object initializer
    # via the magic `init` method
    if (let initMethod = proto.content.getOrDefault("init", nil); not initMethod.isNil):
        echo "there is an init method!"
        # TODO(Types\define) we should verify that our `init` is properly defined
        #  and if not, throw an appropriate error
        #  mainly, that it's a Function
        #  labels: library, error handling, oop
        #initMethod.injectThis()

        # inject a reference to the equivalent
        # method from the parent as `super` -
        # if there is one ofc
        #initMethod.injectSuper(x.ts.inherits)

        # proto.doInit = proc (self: Value, arguments: ValueArray) =
        #     echo "(in doInit)"
        #     for arg in arguments.reversed:
        #         push arg
        #     push self
        #     callFunction(initMethod)

    # # check if there is a `print` magic method;
    # # the custom equivalent of the `printable` module
    # # only for Object values
    # if (let printMethod = proto.methods.getOrDefault("print", nil); not printMethod.isNil):
    #     # TODO(Types\define) we should verify that our `print` is properly defined
    #     #  and if not, throw an appropriate error
    #     #  mainly, that it's a Function with *no* arguments
    #     #  labels: library, error handling, oop
    #     printMethod.injectThis()
    #     proto.doPrint = proc (self: Value): string =
    #         push self
    #         callFunction(printMethod)
    #         stack.pop().s

    # # check if there is a `compare` magic method;
    # # this is to be used for sorting, etc
    # if (let compareMethod = proto.methods.getOrDefault("compare", nil); not compareMethod.isNil):
    #     # TODO(Types\define) we should verify that our `compare` is properly defined
    #     #  and if not, throw an appropriate error
    #     #  mainly, that it's a Function with one argument
    #     #  labels: library, error handling, oop
    #     compareMethod.injectThis()
    #     proto.doCompare = proc (self: Value, other: Value): int =
    #         push other
    #         push self
    #         callFunction(compareMethod)
    #         stack.pop().i

# proc generateCustomObject*(prot: Prototype, arguments: ValueArray | ValueDict, initialize: static bool = true): Value =
#     newObject(arguments, prot, proc (self: Value, prot: Prototype) =
#         var magicParamsExpected = 1

#         for methodName, objectMethod in prot.content:
#             case methodName:
#                 of "init":
#                     when arguments is ValueArray:
#                         if arguments.len != objectMethod.arity - magicParamsExpected:
#                             # TODO(generateCustomObject) should throw if number of arguments is not correct
#                             #  labels: error handling, oop, vm, values
#                             let cleanObjectMethodArgs = objectMethod.params.filter(proc (ss :string): bool = ss != "this")
#                             RuntimeError_IncorrectNumberOfArgumentsForInitializer(prot.name, arguments.len, cleanObjectMethodArgs)
#                         echo "==> initializing new object"
#                         #prot.doInit(self, arguments)
#                     else:
#                         let initArgs = objectMethod.params
#                         let sortedArgs = (toSeq(pairs(arguments))).sorted(proc (xv: (string,Value), yv: (string,Value)): int =
#                             if (let xIdx = initArgs.find(xv[0]); xIdx != -1):
#                                 if (let yIdx = initArgs.find(yv[0]); yIdx != -1):
#                                     return cmp(xIdx, yIdx)
#                                 else:
#                                     let cleanObjectMethodArgs = objectMethod.params.filter(proc (ss :string): bool = ss != "this")
#                                     RuntimeError_IncorrectArgumentForInitializer(prot.name, yv[0], cleanObjectMethodArgs)
#                             else:
#                                 let cleanObjectMethodArgs = objectMethod.params.filter(proc (ss :string): bool = ss != "this")
#                                 RuntimeError_IncorrectArgumentForInitializer(prot.name, xv[0], cleanObjectMethodArgs)
#                         ).map(proc (rz: (string,Value)): Value = rz[1])

#                         if sortedArgs.len != objectMethod.arity - magicParamsExpected:
#                             let cleanObjectMethodArgs = objectMethod.params.filter(proc (ss :string): bool = ss != "this")
#                             RuntimeError_IncorrectNumberOfArgumentsForInitializer(prot.name, arguments.len, cleanObjectMethodArgs)
#                         #prot.doInit(self, sortedArgs)
#                 of "print": 
#                     #self.o[methodName] = objectMethod
#                     self.o[methodName].injectThis()
#                     echo "adding magic: doPrint"
#                     self.magic.doPrint = proc (self: Value): string =
#                         push self
#                         callFunction(self.o[methodName], "\\print")
#                         stack.pop().s
#                     echo "done"
#                 of "compare":
#                     #self.o[methodName] = objectMethod
#                     self.o[methodName].injectThis()
#                     echo "adding magic: doCompare"
#                     self.magic.doCompare = proc (self: Value, other: Value): int =
#                         push other
#                         push self
#                         callFunction(self.o[methodName], "\\compare")
#                         stack.pop().i
#                     echo "done"
#                 else:
#                     if objectMethod.kind==Function:
#                         let objMethod = copyValue(objectMethod)
#                         objMethod.injectThis()
#                         self.o[methodName] = objMethod
#                         if (let methodInfo = objectMethod.info; not methodInfo.isNil):
#                             self.o[methodName].info = methodInfo
#                     else:
#                         self.o[methodName] = objectMethod
#     )