#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: helpers/terminal.nim
#=======================================================

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import extras/linenoise

when defined(WEB):
    import jsconsole

when defined(windows):
    import os, strutils
elif not defined(WEB):
    import os, posix, strutils

#=======================================
# Windows API
#=======================================

when defined(windows):
    const
        STD_OUTPUT_HANDLE = -11'i32
        ENABLE_VIRTUAL_TERMINAL_PROCESSING = 0x0004'u32
        FileNameInfo = 2'i32

    proc getStdHandle(nStdHandle: int32): int {.stdcall, dynlib: "kernel32", importc: "GetStdHandle".}
    proc getConsoleMode(h: int, mode: var uint32): int32 {.stdcall, dynlib: "kernel32", importc: "GetConsoleMode".}
    proc setConsoleMode(h: int, mode: uint32): int32 {.stdcall, dynlib: "kernel32", importc: "SetConsoleMode".}
    proc getFileInformationByHandleEx(h: int, cls: int32, info: pointer, size: uint32): int32 {.stdcall, dynlib: "kernel32", importc: "GetFileInformationByHandleEx".}

    proc isCygwinPty(h: int): bool =
        ## is it a Cygwin/MSYS2 pty (e.g. mintty)?
        ## (it's just a pipe, but with a telling name)
        var info: array[1024, uint16] # name length (in bytes) + UTF-16 name
        if getFileInformationByHandleEx(h, FileNameInfo, addr info[0], uint32(sizeof(info) - 2)) == 0:
            return false

        var name = ""
        let len = int(cast[ptr uint32](addr info[0])[]) div 2
        for i in 0..<min(len, info.len - 2):
            name.add char(info[2+i] and 0x7F)

        ("msys-" in name or "cygwin-" in name) and "-pty" in name

#=======================================
# Types
#=======================================

type
    ColorDepth* = enum
        BasicColors     = 16            ## the 16 standard ones
        ExtendedColors  = 256           ## the standard ones + 240 more
        TrueColors      = 16_777_216    ## any RGB color

#=======================================
# Helpers
#=======================================

proc detectColorDepth(): ColorDepth =
    ## how many colors can the terminal show?
    when defined(WEB):
        TrueColors
    else:
        # Windows 10+ consoles, Windows Terminal & mintty
        # can all show any color
        result = when defined(windows): TrueColors else: BasicColors

        when not defined(windows):
            let term = getEnv("TERM")
            let program = getEnv("TERM_PROGRAM")

            if getEnv("COLORTERM").toLowerAscii() in ["truecolor", "24bit"] or
               term.endsWith("-direct") or
               program in ["iTerm.app", "WezTerm", "ghostty", "vscode"]:
                result = TrueColors
            elif "256color" in term or program == "Apple_Terminal":
                result = ExtendedColors

        # unless the user explicitly asked for more
        # (see: https://force-color.org)
        case getEnv("FORCE_COLOR"):
            of "2": result = max(result, ExtendedColors)
            of "3": result = max(result, TrueColors)
            else: discard

#=======================================
# Global Variables
#=======================================

var
    NoColors* = false
    TerminalColors* = detectColorDepth()   ## how many colors the terminal can show

#=======================================
# Constants
#=======================================

# TODO(Helpers/terminal) Verify terminal color codes
#  Preferrably, across different terminals
#  labels: helpers, command line, unit-test

const
    noColor*     = "\e[0m"

    blackColor*     = ";30"
    redColor*       = ";31"
    greenColor*     = ";32"
    yellowColor*    = ";33"
    blueColor*      = ";34"
    magentaColor*   = ";35"
    cyanColor*      = ";36"
    whiteColor*     = ";37"
    grayColor*      = ";90"

#=======================================
# Templates
#=======================================

template resetColor*():string =
    if NoColors: ""
    else: noColor

template fg*(color: string=""):string =
    if NoColors: ""
    else: "\e[0" & color & "m"

template bold*(color: string=""):string =
    if NoColors: ""
    else: "\e[1" & color & "m"

template underline*(color: string=""):string = 
    if NoColors: ""
    else: "\e[4" & color & "m"

template rgb*(color: string=""):string =
    if NoColors: ""
    else: ";38;5;" & color

template rgb*(color: tuple[r, g, b: int]):string =
    if NoColors: ""
    else: ";38;2;" & $(color[0]) & ";" & $(color[1]) & ";" & $(color[2])

proc isTerminal*(): bool =
    ## is the output a terminal? (and not, e.g. a file or a pipe)
    when defined(WEB):
        true
    elif defined(windows):
        let h = getStdHandle(STD_OUTPUT_HANDLE)
        var mode: uint32
        getConsoleMode(h, mode) != 0 or isCygwinPty(h)
    else:
        isatty(STDOUT_FILENO) == 1

proc isColorFriendlyTerminal*(): bool =
    when defined(WEB):
        true
    else:
        let canShowColors =
            when defined(windows):
                let h = getStdHandle(STD_OUTPUT_HANDLE)
                var mode: uint32
                if getConsoleMode(h, mode) != 0:
                    # a console: it understands colors (and the rest
                    # of the escape codes), only if we can turn them on
                    (mode and ENABLE_VIRTUAL_TERMINAL_PROCESSING) != 0 or
                    setConsoleMode(h, mode or ENABLE_VIRTUAL_TERMINAL_PROCESSING) != 0
                else:
                    # not a console, but it could still be mintty & co.
                    isCygwinPty(h)
            else:
                # no colors, if it's not a terminal (e.g. `> file` or `| grep`)
                isTerminal()

        # whatever the user explicitly asked for, goes
        # (see: https://no-color.org & https://force-color.org)
        if getEnv("NO_COLOR") != "":
            false
        elif getEnv("FORCE_COLOR") notin ["", "0", "false"] or
             getEnv("CLICOLOR_FORCE") notin ["", "0"]:
            true
        elif getEnv("TERM") == "dumb":
            false
        else:
            canShowColors

proc clearTerminal*() =
    when defined(WEB):
        console.clear()
    else:
        # there's nothing to clear, if it's not a terminal
        if isTerminal():
            when defined(windows):
                # mintty & co. aren't consoles,
                # but they do understand escape codes
                var mode: uint32
                if getConsoleMode(getStdHandle(STD_OUTPUT_HANDLE), mode) == 0:
                    stdout.write("\e[H\e[2J")
                    stdout.flushFile()
                    return
            clearScreen()