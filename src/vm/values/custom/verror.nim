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
    RuntimeErr*     = VErrorKind(label: "Runtime Error", parent: nil)
    SyntaxErr*      = VErrorKind(label: "Syntax Error", parent: nil)
    CompilerErr*    = VErrorKind(label: "Compiler Error", parent: nil)
    ProgramErr*     = VErrorKind(label: "Program Error", parent: nil)

proc newRuntimeError*(lbl: string, desc: string = ""): VErrorKind =
    result = VErrorKind(label: lbl, description: desc, parent: RuntimeErr)

let 
    ArithmeticErr*      = newRuntimeError("Arithmetic Error")
    AssertionErr*       = newRuntimeError("Assertion Error")
    ConversionErr*      = newRuntimeError("Conversion Error", "Problem when converting value to given type")
    IndexErr*           = newRuntimeError("Index Error")
    PackageErr*         = newRuntimeError("Package Error")

#TypeErr, ArgumentErr, ValueErr, AttributeErr
#=======================================
# Overloads
#=======================================

func `$`*(kind: VErrorKind): string {.inline,enforceNoRaises.} =
    kind.label

func `$`*(error: VError): string {.inline,enforceNoRaises.} =
    fmt"{error.kind}: {error.msg}"