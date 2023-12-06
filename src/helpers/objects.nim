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

import sequtils, tables
    
import vm/values/value
import vm/values/custom/[vsymbol]

#=======================================
# Methods
#=======================================

proc injectThis*(meth: Value) =
    if meth.params.len < 1 or meth.params[0] != "this":
        echo "- injecting *this*"
        meth.params.insert("this")
        meth.arity += 1

proc injectSuper*(meth: Value, parent: Value) =
    # TODO(objects/injectSuper) should support `super` in all methods
    #  right now, it supports it only in `init`
    #  labels: bug, oop
    var insertable = @[newLabel("super")]
    echo "- injecting *super*"
    if parent.isNil or not parent.ts.methods.hasKey("init"):
        insertable.add(newWord("null"))
        echo "  .... as `null`"
    else:
        echo "  .... as a function"
        let parentInit = parent.ts.methods["init"]
        insertable.add(@[
            newWord("function"),
            newBlock(parentInit.params.filter(proc (zz: string): bool = zz != "this").map(proc (zz: string): Value = newWord(zz))),
            parentInit.main,
            newWord("do"),
            newSymbol(doublecolon)
        ])
    meth.main.a.insert(insertable)

proc generateCustomObject*(prot: Prototype, arguments: ValueArray | ValueDict, initialize: static bool = true): Value =
    newObject(arguments, prot, proc (self: Value, prot: Prototype) =
        var magicParamsExpected = 1

        for methodName, objectMethod in prot.methods:
            case methodName:
                of "init":
                    when arguments is ValueArray:
                        if arguments.len != objectMethod.arity - magicParamsExpected:
                            # TODO(generateCustomObject) should throw if number of arguments is not correct
                            #  labels: error handling, oop, vm, values
                            let cleanObjectMethodArgs = objectMethod.params.filter(proc (ss :string): bool = ss != "this")
                            RuntimeError_IncorrectNumberOfArgumentsForInitializer(prot.name, arguments.len, cleanObjectMethodArgs)
                        echo "==> initializing new object"
                        prot.doInit(self, arguments)
                    else:
                        let initArgs = objectMethod.params
                        let sortedArgs = (toSeq(pairs(arguments))).sorted(proc (xv: (string,Value), yv: (string,Value)): int =
                            if (let xIdx = initArgs.find(xv[0]); xIdx != -1):
                                if (let yIdx = initArgs.find(yv[0]); yIdx != -1):
                                    return cmp(xIdx, yIdx)
                                else:
                                    let cleanObjectMethodArgs = objectMethod.params.filter(proc (ss :string): bool = ss != "this")
                                    RuntimeError_IncorrectArgumentForInitializer(prot.name, yv[0], cleanObjectMethodArgs)
                            else:
                                let cleanObjectMethodArgs = objectMethod.params.filter(proc (ss :string): bool = ss != "this")
                                RuntimeError_IncorrectArgumentForInitializer(prot.name, xv[0], cleanObjectMethodArgs)
                        ).map(proc (rz: (string,Value)): Value = rz[1])

                        if sortedArgs.len != objectMethod.arity - magicParamsExpected:
                            let cleanObjectMethodArgs = objectMethod.params.filter(proc (ss :string): bool = ss != "this")
                            RuntimeError_IncorrectNumberOfArgumentsForInitializer(prot.name, arguments.len, cleanObjectMethodArgs)
                        prot.doInit(self, sortedArgs)
                of "print": discard
                of "compare": discard
                else:
                    if objectMethod.kind==Function:
                        let objMethod = copyValue(objectMethod)
                        objMethod.injectThis()
                        self.o[methodName] = objMethod
                        if (let methodInfo = objectMethod.info; not methodInfo.isNil):
                            self.o[methodName].info = methodInfo
                    else:
                        self.o[methodName] = objectMethod
    )