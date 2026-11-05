#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: vm/crashes.nim
#=======================================================

## Reporting of fatal crashes (invalid memory access, stack overflow).
## 
## We can't recover from these: with goto-based exceptions, raising
## from a signal handler (as `std/segfaults` does) just re-runs the 
## faulting instruction forever. So, we say where it happened & exit.

#=======================================
# Libraries
#=======================================

when not defined(windows):
    import posix

    import vm/errors
    import vm/runtime

#=======================================
# Variables
#=======================================

when not defined(windows):
    var
        signalStack: array[65536, byte]     ## needed for reporting stack overflows

#=======================================
# Helpers
#=======================================

when not defined(windows):
    # Only async-signal-safe stuff here: no allocations whatsoever

    proc say(s: cstring) =
        discard posix.write(2, s, s.len)

    proc sayNumber(num: int) =
        var buffer: array[20, char]
        var i = buffer.len
        var n = num
        while true:
            dec(i)
            buffer[i] = char(ord('0') + n mod 10)
            n = n div 10
            if n == 0: break
        discard posix.write(2, addr buffer[i], buffer.len - i)

    proc crashHandler(sig: cint) {.noconv.} =
        say("\n══╡ Internal Error ╞══\n\n  Invalid memory access or stack overflow\n")
        if FSP > 0 and currentFrame().path.len > 0:
            say("\n  ┃ File: ")
            say(cstring(currentFrame().path))
            say("\n  ┃ Line: ")
            sayNumber(CurrentLine)
            say("\n")
        say("\n")
        exitnow(128 + sig)

#=======================================
# Methods
#=======================================

proc setupCrashHandler*() =
    ## Make sure crashes are reported, 
    ## replacing any previous handler
    when not defined(windows):
        var stk: Stack
        var old: Stack
        stk.ss_sp = addr signalStack
        stk.ss_size = signalStack.len
        stk.ss_flags = 0
        discard sigaltstack(stk, old)

        var action: Sigaction
        action.sa_handler = crashHandler
        action.sa_flags = SA_ONSTACK
        discard sigemptyset(action.sa_mask)
        discard sigaction(SIGSEGV, action, nil)
        discard sigaction(SIGBUS, action, nil)
