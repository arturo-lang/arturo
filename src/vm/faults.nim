#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: vm/faults.nim
#=======================================================

## Reporting of fatal faults (invalid memory access, stack overflow).
## 
## We can't recover from these: with goto-based exceptions, raising
## from a signal handler (as `std/segfaults` does) just re-runs the 
## faulting instruction forever. So, we say where it happened & exit.

#=======================================
# Libraries
#=======================================

when defined(windows):
    import winlean
else:
    import posix

import vm/errors
import vm/runtime

#=======================================
# Variables
#=======================================

when not defined(windows):
    var
        signalStack: array[65536, byte]     ## needed for reporting stack overflows

var
    StackBottom: uint   ## the lowest address of the main stack
    StackLimit: uint    ## going below this means we're about to run out of stack

#=======================================
# Helpers
#=======================================

when defined(windows):
    const
        AccessViolation = 0xC0000005'u32
        StackOverflow = 0xC00000FD'u32
        ContinueSearch = 0.clong
        ReservedStack = 65536.culong

    proc c_write(fd: cint, buf: cstring, count: cuint): cint {.importc: "_write", header: "<io.h>".}
    proc c_exit(code: cint) {.importc: "_exit", header: "<stdlib.h>", noreturn.}

    proc SetUnhandledExceptionFilter(filter: pointer): pointer {.stdcall, dynlib: "kernel32", importc.}
    proc SetThreadStackGuarantee(size: ptr culong): WINBOOL {.stdcall, dynlib: "kernel32", importc.}
    proc GetCurrentThreadStackLimits(low, high: ptr uint) {.stdcall, dynlib: "kernel32", importc.}

# Only async-signal-safe stuff here: no allocations whatsoever

proc say(s: cstring) =
    when defined(windows):
        discard c_write(2, s, cuint(s.len))
    else:
        discard posix.write(2, s, s.len)

proc sayNumber(num: int) =
    var buffer: array[21, char]
    var i = buffer.high
    var n = num
    while true:
        dec(i)
        buffer[i] = char(ord('0') + n mod 10)
        n = n div 10
        if n == 0: break
    say(cast[cstring](addr buffer[i]))

proc reportFault() =
    say("\n══╡ Internal Error ╞══\n\n  Invalid memory access or stack overflow\n")
    if FSP > 0 and markerFile(CurrentLine).len > 0:
        say("\n  ┃ File: ")
        say(cstring(markerFile(CurrentLine)))
        say("\n  ┃ Line: ")
        sayNumber(markerLine(CurrentLine))
        say("\n")
    say("\n")

when defined(windows):
    proc faultFilter(pointers: pointer): clong {.stdcall.} =
        let code = cast[ptr ptr uint32](pointers)[][]
        if code != AccessViolation and code != StackOverflow:
            return ContinueSearch
        reportFault()
        c_exit(139)
else:
    proc faultHandler(sig: cint) {.noconv.} =
        reportFault()
        exitnow(128 + sig)

#=======================================
# Methods
#=======================================

proc setupFaultHandler*() =
    ## Make sure faults are reported,
    ## replacing any previous handler
    when defined(windows):
        var reserved = ReservedStack
        discard SetThreadStackGuarantee(addr reserved)
        discard SetUnhandledExceptionFilter(cast[pointer](faultFilter))
    else:
        var stk: Stack
        var old: Stack
        stk.ss_sp = addr signalStack
        stk.ss_size = signalStack.len
        stk.ss_flags = 0
        discard sigaltstack(stk, old)

        var action: Sigaction
        action.sa_handler = faultHandler
        action.sa_flags = SA_ONSTACK
        discard sigemptyset(action.sa_mask)
        discard sigaction(SIGSEGV, action, nil)
        discard sigaction(SIGBUS, action, nil)

    # keep track of how much stack there's left
    # (so that we can stop a runaway recursion
    # before it's too late)
    if StackBottom != 0: return

    var top, size: uint
    when defined(windows):
        var low, high: uint
        GetCurrentThreadStackLimits(addr low, addr high)
        top = high
        size = high - low
    else:
        var here: int
        var limit: RLimit
        top = cast[uint](addr here)
        size = 8 * 1024 * 1024
        # (if it's "unlimited", just stick to the default)
        if getrlimit(RLIMIT_STACK, limit) == 0 and limit.rlim_cur > 0 and limit.rlim_cur < (1 shl 32):
            size = min(uint(limit.rlim_cur), top)
    StackBottom = top - size
    StackLimit = StackBottom + max(size div 16, 128 * 1024)

template stackExhausted*(): bool =
    ## Are we (on the main stack and) about to run out of it?
    var marker {.noinit.}: int
    let sp = cast[uint](addr marker)
    sp < StackLimit and sp > StackBottom
