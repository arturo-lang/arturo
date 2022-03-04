######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/repl.nim
######################################################

#=======================================
# Libraries
#=======================================

import os

when defined(windows):
    {.compile(normalizedPath(currentSourcePath().splitPath.head & "../extras/linenoise/linenoise.c")).}

when not defined(WEB):

    import sequtils, strutils, sugar, tables

    import vm/values/value

    #=======================================
    # Types
    #=======================================

    type
        LinenoiseCompletions* = object
            len*: csize_t
            cvec*: cstringArray

        LinenoiseCompletionCallback*    = proc (buf: cstring; lc: ptr LinenoiseCompletions) {.cdecl.}
        LinenoiseHintsCallback*         = proc (buf: cstring; color: var cint; bold: var cint): cstring {.cdecl.}
        LinenoiseFreeHintsCallback*     = proc (buf: cstring; color: var cint; bold: var cint) {.cdecl.}

    #=======================================
    # Constants
    #=======================================

    const
        ReplHistoryPath = joinPath(joinPath(getHomeDir(), ".arturo"), "history.txt")

    #=======================================
    # Variables
    #=======================================

    var
        ReplInitialized = false

    #=======================================
    # C Imports
    #=======================================

    when defined(windows):
        {.push header: normalizedPath(currentSourcePath().splitPath.head & "../extras/linenoise/linenoise.h"), cdecl.}
    proc linenoiseSetCompletionCallback*(cback: ptr LinenoiseCompletionCallback) {.importc: "linenoiseSetCompletionCallback".}
    proc linenoiseSetHintsCallback(cback: ptr LinenoiseHintsCallback) {.importc: "linenoiseSetHintsCallback".}
    proc linenoiseAddCompletion*(a2: ptr LinenoiseCompletions; a3: cstring) {.importc: "linenoiseAddCompletion".}
    proc linenoiseReadLine*(prompt: cstring): cstring {.importc: "linenoise".}
    proc linenoiseHistoryAdd*(line: cstring): cint {.importc: "linenoiseHistoryAdd", discardable.}
    proc linenoiseHistorySetMaxLen*(len: cint): cint {.importc: "linenoiseHistorySetMaxLen".}
    proc linenoiseHistorySave*(filename: cstring): cint {.importc: "linenoiseHistorySave".}
    proc linenoiseHistoryLoad*(filename: cstring): cint {.importc: "linenoiseHistoryLoad".}
    proc linenoiseClearScreen*() {.importc: "linenoiseClearScreen".}
    proc linenoiseSetMultiLine*(ml: cint) {.importc: "linenoiseSetMultiLine".}
    proc linenoisePrintKeyCodes*() {.importc: "linenoisePrintKeyCodes".}
    when defined(windows):
        {.pop.}
    proc free*(s: cstring) {.importc: "free", header: "<stdlib.h>".}

    #=======================================
    # C Exports
    #=======================================

    var
        completions {.exportc.} : ValueArray
        hints       {.exportc.} : ValueDict

    #=======================================
    # Helpers
    #=======================================

    proc initRepl*(path: string, completionsArray: ValueArray = @[], hintsTable: ValueDict = initOrderedTable[string,Value]()) =
        completions = completionsArray
        hints = hintsTable

        proc completionsCback(buf: cstring; lc: ptr LinenoiseCompletions) {.cdecl.} =
            var token = $(buf)
            var copied = strip($(buf))
            let tokenParts = splitWhitespace(token)
            if tokenParts.len >= 1:
                token = tokenParts[^1]
                copied.removeSuffix(token)
                for item in completions.map((x) => x.s).filter((x) => x.startsWith(token)):
                    linenoiseAddCompletion(lc, (copied & item).cstring)


        proc hintsCback(buf: cstring; color: var cint; bold: var cint): cstring {.cdecl.} =
            var token = $(buf)
            let tokenParts = splitWhitespace(token)
            if tokenParts.len >= 1:
                token = tokenParts[^1]
                if hints.hasKey(token):
                    color = 35
                    bold = 0
                    return (cstring)" " & hints[token].s
            return nil
            
        if not ReplInitialized:
            if not fileExists(parentDir(path)):
                createDir(parentDir(path))
            discard linenoiseHistoryLoad(path)

            linenoiseSetCompletionCallback(cast[ptr LinenoiseCompletionCallback](completionsCback))
            linenoiseSetHintsCallback(cast[ptr LinenoiseHintsCallback](hintsCback))

            ReplInitialized = true

    #=======================================
    # Methods
    #=======================================

    proc replInput*(
        prompt: string, 
        historyPath: string = ReplHistoryPath, 
        completionsArray: ValueArray = @[],
        hintsTable: ValueDict = initOrderedTable[string,Value]()
    ): string =
        initRepl(historyPath, completionsArray, hintsTable)

        let got = linenoiseReadLine(prompt.cstring)
        linenoiseHistoryAdd(got)
        discard linenoiseHistorySave(historyPath)
        result = $(got)

        free(got)