#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
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

    when defined(posix):
        import posix
        import helpers/parallelism as ParallelismHelper

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

            discard linenoiseSetCompletionCallback(completionsCback, nil)

            linenoiseSetHintsCallback(hintsCback, nil)

            ReplInitialized = true

    #=======================================
    # Methods
    #=======================================

    proc replInput*(
        prompt: string,
        historyPath: string = ReplHistoryPath,
        completionsArray: ValueArray = @[],
        hintsTable: ValueDict = initOrderedTable[string,Value]()
    ): (string, bool) =
        initRepl(historyPath, completionsArray, hintsTable)

        # Cooperative wait for stdin: while the user is thinking, drain
        # any in-process `do.async` fibers / pending I/O so background
        # tasks make progress between keystrokes. Once stdin actually
        # has data, hand off to linenoise (which owns terminal raw
        # mode and reads char-by-char until Enter).
        when defined(posix):
            stdout.write(prompt)
            stdout.flushFile()
            var p: TPollfd
            p.fd = 0
            p.events = POLLIN
            while true:
                let r = poll(addr p, 1.Tnfds, 50.cint)
                if r > 0 and (p.revents and POLLIN) != 0:
                    break
                ParallelismHelper.pumpScheduler(0)
            # Erase our manual prompt — linenoise will redraw it.
            stdout.write("\r\x1b[2K")
            stdout.flushFile()

        let got = linenoiseReadLine(prompt.cstring)
        if got.isNil:
            return ("", true)

        linenoiseHistoryAdd(got)
        discard linenoiseHistorySave(historyPath)
        result = ($(got),false)

        free(got)
