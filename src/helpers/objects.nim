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

import sequtils
    
import vm/values/value

#=======================================
# Methods
#=======================================

proc injectThis*(meth: Value) =
    if meth.params.len < 1 or meth.params[0] != "this":
        meth.params.insert("this")
        meth.arity += 1

proc injectSuper*(meth: Value) =
    if meth.params.len < 1 or meth.params[0] != "super":
        meth.params.insert("super")
        meth.arity += 1

proc generateCustomObject*(prot: Prototype, arguments: ValueArray | ValueDict, initialize: static bool = true): Value =
    newObject(arguments, prot, proc (self: Value, prot: Prototype) =
        var magicParamsExpected = # super, this
            #if not prot.inherits.isNil:
                1
            #else:
            #    1

        for methodName, objectMethod in prot.methods:
            case methodName:
                of "init":
                    when arguments is ValueArray:
                        if arguments.len != objectMethod.arity - magicParamsExpected:
                            # TODO(generateCustomObject) should throw if number of arguments is not correct
                            #  labels: error handling, oop, vm, values
                            let cleanObjectMethodArgs = objectMethod.params.filter(proc (ss :string): bool =
                                ss != "this" and ss != "super"
                            )
                            RuntimeError_IncorrectNumberOfArgumentsForInitializer(prot.name, arguments.len, cleanObjectMethodArgs)
                        prot.doInit(self, arguments)
                    else:
                        let initArgs = objectMethod.params
                        let sortedArgs = (toSeq(pairs(arguments))).sorted(proc (xv: (string,Value), yv: (string,Value)): int =
                            let xIdx = initArgs.find(xv[0])
                            let yIdx = initArgs.find(yv[0])
                            if xIdx == -1 or yIdx == -1:
                                echo "incorrect argument"
                            cmp(xIdx, yIdx)
                        ).map(proc (rz: (string,Value)): Value = 
                            rz[1]
                        )
                        if sortedArgs.len != objectMethod.arity - magicParamsExpected:
                            echo "incorrect number of arguments"
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