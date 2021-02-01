######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: vm/vm.nim
######################################################

#=======================================
# Libraries
#=======================================

import algorithm, asyncdispatch, asynchttpserver
import base64, cgi, db_sqlite, std/editdistance
import httpClient, json, math, md5, os, osproc
import random, rdstdin, re, sequtils, smtp
import std/sha1, strformat, strutils, sugar
import tables, times, unicode, uri, xmltree
import nre except toSeq

when not defined(windows):
    import linenoise

import extras/bignum, extras/miniz, extras/parsetoml

when not defined(MINI):
    import extras/webview

import helpers/arrays       as arraysHelper   
import helpers/csv          as csvHelper
import helpers/database     as databaseHelper
import helpers/datasource   as datasourceHelper
import helpers/helper       as helperHelper
import helpers/html         as htmlHelper
import helpers/json         as jsonHelper
import helpers/markdown     as markdownHelper
import helpers/math         as mathHelper
import helpers/path         as pathHelper
import helpers/strings      as stringsHelper
import helpers/toml         as tomlHelper
import helpers/unisort      as unisortHelper
import helpers/url          as urlHelper
import helpers/webview      as webviewHelper
import helpers/xml          as xmlHelper

import translator/eval, translator/parse
import vm/env, vm/errors, vm/exec, vm/globals, vm/stack, vm/value
import version

import utils

#=======================================
# Types
#=======================================


#=======================================
# Globals
#=======================================


#=======================================
# Constants
#=======================================

const
    NoArgs*      = static {"" : {Nothing}}
    NoAttrs*     = static {"" : ({Nothing},"")}

#=======================================
# Templates
#=======================================

template requireArgs*(name: string, spec: untyped, nopop: bool = false): untyped =
    if SP<(static spec.len) and spec!=NoArgs:
        panic "cannot perform '" & (static name) & "'; not enough parameters: " & $(static spec.len) & " required"

    when (static spec.len)>=1 and spec!=NoArgs:
        when not (ANY in static spec[0][1]):
            if not (Stack[SP-1].kind in (static spec[0][1])):
                let acceptStr = toSeq((spec[0][1]).items).map(proc(x:ValueKind):string = ":" & ($(x)).toLowerAscii()).join(" ")
                panic "cannot perform '" & (static name) & "' -> :" & ($(Stack[SP-1].kind)).toLowerAscii() & " ...; incorrect argument type for 1st parameter; accepts " & acceptStr

        when (static spec.len)>=2:
            when not (ANY in static spec[1][1]):
                if not (Stack[SP-2].kind in (static spec[1][1])):
                    let acceptStr = toSeq((spec[1][1]).items).map(proc(x:ValueKind):string = ":" & ($(x)).toLowerAscii()).join(" ")
                    panic "cannot perform '" & (static name) & "' -> :" & ($(Stack[SP-1].kind)).toLowerAscii() & " :" & ($(Stack[SP-2].kind)).toLowerAscii() & " ...; incorrect argument type for 2nd parameter; accepts " & acceptStr

            when (static spec.len)>=3:
                when not (ANY in static spec[2][1]):
                    if not (Stack[SP-3].kind in (static spec[2][1])):
                        let acceptStr = toSeq((spec[2][1]).items).map(proc(x:ValueKind):string = ":" & ($(x)).toLowerAscii()).join(" ")
                        panic "cannot perform '" & (static name) & "' -> :" & ($(Stack[SP-1].kind)).toLowerAscii() & " :" & ($(Stack[SP-2].kind)).toLowerAscii() & " :" & ($(Stack[SP-3].kind)).toLowerAscii() & " ...; incorrect argument type for third parameter; accepts " & acceptStr

    when not nopop:
        when (static spec.len)>=1 and spec!=NoArgs:
            var x {.inject.} = stack.pop()
            when (static spec.len)>=2:
                var y {.inject.} = stack.pop()
                when (static spec.len)>=3:
                    var z {.inject.} = stack.pop()

template builtin*(n: string, alias: SymbolKind, rule: PrecedenceKind, description: string, args: untyped, attrs: untyped, returns: ValueSpec, example: string, act: untyped):untyped =
    when args.len==1 and args==NoArgs:  
        const argsLen = 0
    else:                               
        const argsLen = static args.len

    const cleanExample = replace(strutils.strip(example),"\n        ","\n")
    let b = newBuiltin(n, alias, rule, static (instantiationInfo().filename).replace(".nim"), description, static argsLen, args.toOrderedTable, attrs.toOrderedTable, returns, cleanExample, proc () =
        requireArgs(n, args)
        act
    )

    Funcs[n] = static args.len
    syms[n] = b

    when alias != unaliased:
        aliases[alias] = AliasBinding(
            precedence: rule,
            name: newWord(n)
        )

template constant*(n: string, alias: SymbolKind, description: string, v: Value):untyped =
    #echo "setting constant " & $(n) & " with description = " & description
    syms[n] = (v)
    syms[n].info = description
    when alias != unaliased:
        aliases[alias] = AliasBinding(
            precedence: PrefixPrecedence,
            name: newWord(n)
        )

#=======================================
# Helpers
#=======================================


#=======================================
# Methods
#=======================================

proc run*(code: var string, args: ValueArray, isFile: bool) =
    initEnv(
        arguments = args, 
        version = Version,
        build = Build
    )

    if isFile: env.addPath(code)
    else: env.addPath(getCurrentDir())

    syms = getEnvDictionary()

    include library/Arithmetic
    include library/Binary
    include library/Collections
    include library/Comparison
    include library/Converters
    include library/Core
    include library/Crypto
    include library/Database
    include library/Dates
    include library/Files
    include library/Io
    include library/Iterators
    include library/Logic
    include library/Net
    include library/Numbers
    include library/Path
    include library/Reflection
    include library/Strings
    include library/System
    include library/Ui

    initVM()
    let parsed = doParse(move code, isFile)
    let evaled = parsed.doEval()
    discard doExec(evaled)
    showVMErrors()