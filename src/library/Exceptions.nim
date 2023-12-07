
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
            "message": {String, ErrorKind}
        },
        attrs       = {
            "as": ({ErrorKind}, "throws an :error as some specific :errorKind")
        },
        returns     = {Nothing},
        example     = """
            err: try -> throw "Page not found"
            err\kind
            ; => Generic Error
            err\message
            ; => Page not found

            ; or you can alternatively use custom errorKind

            pageNotFound: to :errorKind "404: Page not Found"

            err: try -> throw.as: pageNotFound "Seems that the page does not exist"
            err\kind
            ; => 404: Page not Found
            err\message
            ; => Seems that the page does not exist

            ; Or even use the :errorKind's label as the message itself

            err: try -> throw pageNotFound
            err\kind
            ; => 404: Page not Found
            err\message
            ; => 404: Page not Found

        """:
            #=======================================================
            let kind: VErrorKind = if checkAttr "as":
                aAs.errKind
            elif xkind == ErrorKind:
                x.errKind
            else:
                verror.genericErrorKind

            var error = verror.VError(kind: kind)
            if xkind == String:
                error.msg = x.s
            elif xkind == ErrorKind:
                error.msg = x.errkind.label

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
            err: try [
                ; let's try something dangerous
                print 10 / 0
            ]

            type err
            ; => :error

            ; Tips: mixing errors and returned values
            
            f: $[][ throw "some error" ]
            g: $[][ return "hi" ]
            
            (genericError = err: <= try -> val: f)?
                -> print err
                -> print val
            ; => Generic Error: some error

            (genericError = err: <= try -> val: g)?
                -> print err
                -> print val
            ; => hi
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