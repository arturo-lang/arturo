
{.used.}

import vm/lib
import vm/values/custom/verror

proc defineSymbols*() =

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
        returns     = {Nothing},
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
            except CatchableError, Defect:
                let e = getCurrentException()
                if verbose:
                    showVMErrors(e)

Libraries.add(defineSymbols)