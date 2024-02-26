
#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: library/Exceptions.nim
#=======================================================

## The main Exceptions module 
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import vm/lib
import vm/exec
import vm/errors
import vm/values/custom/verror

#=======================================
# Definitions
#=======================================

proc defineSymbols*() =

    #----------------------------
    # Functions
    #----------------------------

    builtin "throw",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "throw an error with given message",
        args        = {
            "message": {String, ErrorKind}
        },
        attrs       = {
            "as": ({ErrorKind}, "consider the error as one of given subtype")
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
                RuntimeErr

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
                    showError(e)
            except CatchableError, Defect:
                let e = getCurrentException()
                push newError(e)
                if verbose:
                    showError(VError(e))

    #----------------------------
    # Constants
    #----------------------------

    constant "arithmeticError",
        alias       = unaliased,
        description = "an arithmetic error":
            newErrorKind(ArithmeticErr)

    constant "assertionError",
        alias       = unaliased,
        description = "an assertion error":
            newErrorKind(AssertionErr)

    constant "conversionError",
        alias       = unaliased,
        description = "a conversion error":
            newErrorKind(ConversionErr)
    
    constant "indexError",
        alias       = unaliased,
        description = "an index error":
            newErrorKind(IndexErr)

    constant "libraryError",
        alias       = unaliased,
        description = "a library error":
            newErrorKind(LibraryErr)

    constant "nameError",
        alias       = unaliased,
        description = "a name error":
            newErrorKind(NameErr)

    constant "packageError",
        alias       = unaliased,
        description = "a package error":
            newErrorKind(PackageErr)
    
    constant "runtimeError",
        alias       = unaliased,
        description = "a generic runtime error":
            newErrorKind(RuntimeErr)

    constant "syntaxError",
        alias       = unaliased,
        description = "a syntax error":
            newErrorKind(SyntaxErr)

    constant "systemError",
        alias       = unaliased,
        description = "a system error":
            newErrorKind(SystemErr)

    constant "typeError",
        alias       = unaliased,
        description = "a type error":
            newErrorKind(TypeErr)

    constant "uiError",
        alias       = unaliased,
        description = "a UI error":
            newErrorKind(UIErr)
    
    constant "valueError",
        alias       = unaliased,
        description = "a value error":
            newErrorKind(ValueErr)

    constant "vmError",
        alias       = unaliased,
        description = "a VM error":
            newErrorKind(VMErr)

Libraries.add(defineSymbols)