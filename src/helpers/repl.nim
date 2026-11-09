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
    import vm/errors
    import vm/values/value

    when defined(posix):
        import posix
        import posix/termios
        import helpers/parallelism as ParallelismHelper

    #=======================================
    # Constants
    #=======================================

    const
        ReplHistoryPath = joinPath(joinPath(getHomeDir(), ".arturo"), "history.txt")
        ReplHistoryMaxLen = 1000

    #=======================================
    # Variables
    #=======================================

    var
        ReplInitialized = false
        CurrentHint: string     # linenoise reads the returned hint after the callback returns
        CurrentIndent: string   # (same for the indentation of continuation lines)

    #=======================================
    # C Exports
    #=======================================

    # linenoise returns NULL both on EOF and on Ctrl+C
    # - setting errno to EAGAIN for the latter
    var CErrno {.importc: "errno", header: "<errno.h>".}: cint
    let CEAGAIN {.importc: "EAGAIN", header: "<errno.h>".}: cint

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

    proc splitLastToken(buf: string): (string, string) =
        # split (right-trimmed) input into everything before the word
        # being typed & the word itself - which may also come right
        # after a bracket, a quote or a colon (e.g. `[pri`, `'pri`)
        let s = buf.strip(leading=false)
        var i = s.high
        while i >= 0 and s[i] notin Whitespace + {'[', '(', '\'', ':'}:
            dec i
        result = (s[0..i], s[i+1..^1])

    proc openBrackets(code: string): int =
        # how many brackets are left open, ignoring
        # anything inside strings, chars & comments
        var i = 0
        while i < code.len:
            case code[i]:
                of '"':
                    inc i
                    while i < code.len and code[i] notin {'"', '\n'}:
                        if code[i] == '\\': inc i
                        inc i
                of '{':
                    # curly-brace string (which may span many lines)
                    var depth = 1
                    inc i
                    while i < code.len and depth > 0:
                        if code[i] == '{': inc depth
                        elif code[i] == '}': dec depth
                        inc i
                    if depth > 0: inc result
                    continue
                of ';':
                    while i < code.len and code[i] != '\n': inc i
                of '\'':
                    # char literal, e.g. '['
                    if i + 2 < code.len and code[i+2] == '\'': i += 2
                of '[', '(': inc result
                of ']', ')': dec result
                else:
                    # «-strings run until the end of the line
                    if code.continuesWith("«", i):
                        while i < code.len and code[i] != '\n': inc i
            inc i

    proc initRepl*(path: string, completionsArray: ValueArray = @[], hintsTable: ValueDict = initOrderedTable[string,Value]()) =
        completions = completionsArray
        hints = hintsTable

        proc completionsCback(buf: constChar; lc: ptr LinenoiseCompletions, userdata: pointer) {.cdecl.} =
            let (copied, token) = splitLastToken($(buf))
            if token.len >= 1:
                for item in completions.map((x) => x.s).filter((x) => x.startsWith(token)):
                    linenoiseAddCompletion(lc, (copied & item).cstring)


        proc hintsCback(buf: constChar; color: var cint; bold: var cint, userdata: pointer): cstring {.cdecl.} =
            let token = splitLastToken($(buf))[1]
            if token.len >= 1:
                if (let tokenHint = hints.getOrDefault(token, nil); not tokenHint.isNil):
                    color = 35
                    bold = 0
                    CurrentHint = " " & tokenHint.s
                    return CurrentHint.cstring
            return nil
            
        proc continuationCback(buf: constChar; userdata: pointer): cstring {.cdecl.} =
            # continue on a new line, if there are brackets still open,
            # or if the line ends with a double space
            let code = $(buf)
            let open = openBrackets(code)
            if open > 0 or code.endsWith("  "):
                CurrentIndent = repeat(' ', 4 * max(open, 0))
                return CurrentIndent.cstring
            return nil

        if not ReplInitialized:
            if not fileExists(parentDir(path)):
                createDir(parentDir(path))
            discard linenoiseHistorySetMaxLen(ReplHistoryMaxLen)
            discard linenoiseHistoryLoad(path)

            discard linenoiseSetCompletionCallback(completionsCback, nil)

            linenoiseSetHintsCallback(hintsCback, nil)

            # wrap long lines, instead of scrolling them sideways
            linenoiseSetMultiLine(1)

            # Enter with brackets still open (or after a double space):
            # keep editing the same entry, on a new (indented) line
            linenoiseSetContinuationCallback(continuationCback, nil)

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
        #
        # Subtlety: the terminal sits in cooked mode (canonical + echo)
        # outside linenoise. If we just `poll(stdin)` from cooked mode,
        # the user's keystrokes are echoed and buffered until Enter,
        # which both displaces our prompt vertically and double-prints
        # the line once linenoise takes over. So we briefly switch the
        # tty to non-canonical, no-echo for the poll loop only — the
        # first byte unblocks `poll` immediately, we restore the prior
        # termios, then linenoise sets its own raw mode and renders
        # the buffered byte normally.
        when defined(posix):
            var savedTermios, polledTermios: Termios
            let isTty = isatty(0) == 1
            var termiosTouched = false
            if isTty and tcGetAttr(0, addr savedTermios) == 0:
                polledTermios = savedTermios
                polledTermios.c_lflag = polledTermios.c_lflag and
                                        not (ICANON or ECHO or ECHOE or
                                             ECHOK or ECHONL)
                if tcSetAttr(0, TCSANOW, addr polledTermios) == 0:
                    termiosTouched = true

            stdout.write(prompt)
            stdout.flushFile()
            var p: TPollfd
            p.fd = 0
            p.events = POLLIN
            while true:
                let r = poll(addr p, 1.Tnfds, 50.cint)
                if r > 0 and (p.revents and POLLIN) != 0:
                    break
                if Interrupted:
                    break
                ParallelismHelper.pumpScheduler(0)

            if termiosTouched:
                discard tcSetAttr(0, TCSANOW, addr savedTermios)

            # Ctrl+C before typing anything: just give a fresh prompt
            if Interrupted:
                Interrupted = false
                stdout.write("\n")
                stdout.flushFile()
                return ("", false)

            # Erase our manual prompt — linenoise will redraw it.
            stdout.write("\r\x1b[2K")
            stdout.flushFile()

        CErrno = 0
        let got = linenoiseReadLine(prompt.cstring)
        Interrupted = false     # a Ctrl+C while waiting for input shouldn't stop what comes next
        if got.isNil:
            # Ctrl+C: drop the line & give a fresh prompt (only Ctrl+D/EOF quits)
            if CErrno == CEAGAIN:
                return ("", false)
            return ("", true)

        if not isEmptyOrWhitespace($(got)):
            linenoiseHistoryAdd(got)
            discard linenoiseHistorySave(historyPath)
        result = ($(got),false)

        free(got)
