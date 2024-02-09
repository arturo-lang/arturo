#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: vm/values/custom/verror.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import std/strformat

#=======================================
# Types
#=======================================

type        
    VErrorKind* = ref object
        parent*         : VErrorKind
        label*          : string
        description*    : string

    VError* = ref object of CatchableError
        kind*       : VErrorKind
        hint*       : string

#=======================================
# Constants
#=======================================

let 
    # The core error types
    RuntimeErr*     = VErrorKind(label: "Runtime Error" , parent: nil)
    SyntaxErr*      = VErrorKind(label: "Syntax Error"  , parent: nil)
    CompilerErr*    = VErrorKind(label: "Compiler Error", parent: nil)
    ProgramErr*     = VErrorKind(label: "Program Error" , parent: nil)

proc toRuntimeErrorKind*(lbl: string, desc: string = ""): VErrorKind =
    result = VErrorKind(label: lbl, description: desc, parent: RuntimeErr)

let 
    # Derived error types to be used
    # by our error templates
    ArithmeticErr*      = toRuntimeErrorKind(
                            "Arithmetic Error",
                            "")
    AssertionErr*       = toRuntimeErrorKind(
                            "Assertion Error",
                            "")
    ConversionErr*      = toRuntimeErrorKind(
                            "Conversion Error", 
                            "Problem when converting value to given type")
    IndexErr*           = toRuntimeErrorKind(
                            "Index Error",
                            "")
    PackageErr*         = toRuntimeErrorKind(
                            "Package Error",
                            "")

#TypeErr, ArgumentErr, ValueErr, AttributeErr

#=======================================
# Constructors
#=======================================

func toError*(kind: VErrorKind, msg: string, hint: string = ""): VError =
    VError(kind: kind, msg: msg, hint: hint)

#=======================================
# Overloads
#=======================================

func `$`*(kind: VErrorKind): string {.inline,enforceNoRaises.} =
    kind.label

func `$`*(error: VError): string {.inline,enforceNoRaises.} =
    fmt"{error.kind}: {error.msg}"