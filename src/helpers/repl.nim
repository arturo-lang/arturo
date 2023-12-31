#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: helpers/repl.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import os

when not defined(WEB):

    import sequtils, strutils, sugar, tables
    import extras/linenoise
    import vm/values/value

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
    # C Exports
    #=======================================

    var
        completions {.exportc.} : ValueArray
        hints       {.exportc.} : ValueDict

    #=======================================
    # Helpers
    #=======================================

    # TODO(Helpers/repl) Add multi-line copy-paste capabilities for REPL
    #  It would be great to be able to copy-paste multi-line text into our REPL and handle it properly!
    #  As with Ctrl+D, given that it's based on the LineNoise library, this the place we should start looking first.
    #  labels: helpers, 3rd-party, enhancement

    proc initRepl*(path: string, completionsArray: ValueArray = @[], hintsTable: ValueDict = initOrderedTable[string,Value]()) =
        completions = completionsArray
        hints = hintsTable

        proc completionsCback(buf: constChar; lc: ptr LinenoiseCompletions, userdata: pointer) {.cdecl.} =
            var token = $(buf)
            var copied = strip($(buf))
            let tokenParts = splitWhitespace(token)
            if tokenParts.len >= 1:
                token = tokenParts[^1]
                copied.removeSuffix(token)
                for item in completions.map((x) => x.s).filter((x) => x.startsWith(token)):
                    linenoiseAddCompletion(lc, (copied & item).cstring)


        proc hintsCback(buf: constChar; color: var cint; bold: var cint, userdata: pointer): cstring {.cdecl.} =
            var token = $(buf)
            let tokenParts = splitWhitespace(token)
            if tokenParts.len >= 1:
                token = tokenParts[^1]
                if (let tokenHint = hints.getOrDefault(token, nil); not tokenHint.isNil):
                    color = 35
                    bold = 0
                    return (cstring)" " & tokenHint.s
            return nil
            
        if not ReplInitialized:
            if not fileExists(parentDir(path)):
                createDir(parentDir(path))
            discard linenoiseHistoryLoad(path)

            discard linenoiseSetCompletionCallback(cast[ptr LinenoiseCompletionCallback](completionsCback), nil)
            linenoiseSetHintsCallback(cast[ptr LinenoiseHintsCallback](hintsCback), nil)

            ReplInitialized = true

    #=======================================
    # Methods
    #=======================================

    # TODO(Helpers/repl) Special characters not working anymore?
    #  For example: accented characters or the - very useful and common - null alias `ø`
    #  labels: helpers, repl, bug, critical

    proc replInput*(
        prompt: string, 
        historyPath: string = ReplHistoryPath, 
        completionsArray: ValueArray = @[],
        hintsTable: ValueDict = initOrderedTable[string,Value]()
    ): (string, bool) =
        initRepl(historyPath, completionsArray, hintsTable)

        let got = linenoiseReadLine(prompt.cstring)
        if got.isNil:
            return ("", true)

        linenoiseHistoryAdd(got)
        discard linenoiseHistorySave(historyPath)
        result = ($(got),false)

        free(got)