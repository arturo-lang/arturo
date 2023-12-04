
{.used.}

import vm/lib
import vm/exec
import vm/errors
import vm/values/custom/verror

proc defineSymbols*() =

    constant "genericError",
        alias       = unaliased,
        description = "A generic :errorKind":
            newErrorKind(verror.genericErrorKind)

    builtin "throw",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "throws an :error",
        args        = {
            "message": {String}
        },
        attrs       = {
            "as": ({ErrorKind}, "throws an :error as some specific :errorKind")
        },
        returns     = {Nothing},
        example     = """
        """:
            #=======================================================
            let kind: VErrorKind = if checkAttr "as":
                aAs.errKind
            else:
                verror.genericErrorKind

            var error = verror.VError(kind: kind)
            error.msg = x.s

            raise error 

    builtin "throws?",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "perform action, and return true if errors were thrown",
        args        = {
            "action": {Block,Bytecode}
        },
        attrs       = NoAttrs,
        returns     = {Logical},
        example     = """
            throws? [
                1 + 2
            ] 
            ; => false

            throws? -> 1/0
            ; => true
        """:
            #=======================================================
            try:
                execUnscoped(x)

                push(VFALSE)
            except CatchableError, Defect, VError:
                push(VTRUE)

    builtin "try",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "perform action and catch possible errors",
        args        = {
            "action": {Block,Bytecode}
        },
        attrs       = {
            "verbose"   : ({Logical},"print all error messages as usual")
        },
        returns     = {Error, Null},
        example     = """
            try [
                ; let's try something dangerous
                print 10 / 0
            ]
            
            ; we catch the exception but do nothing with it
        """:
            #=======================================================
            let verbose = hadAttr "verbose" 
            try:
                execUnscoped(x)
                push(VNULL)
            except VError as e:
                push newError(e)
                if verbose:
                    showVMErrors(e)
            except CatchableError, Defect:
                let e = getCurrentException()
                push newError(e)
                if verbose:
                    showVMErrors(e)

Libraries.add(defineSymbols)