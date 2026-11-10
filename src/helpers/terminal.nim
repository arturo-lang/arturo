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

import strutils

when defined(windows):
    import os
elif not defined(WEB):
    import os, posix

#=======================================
# Types
#=======================================

type
    ColorDepth* = enum
        BasicColors     = 16            ## the 16 standard ones
        ExtendedColors  = 256           ## the standard ones + 240 more
        TrueColors      = 16_777_216    ## any RGB color

#=======================================
# Constants
#=======================================

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

when defined(windows):
    const
        STD_OUTPUT_HANDLE = -11'i32
        STD_ERROR_HANDLE = -12'i32
        ENABLE_VIRTUAL_TERMINAL_PROCESSING = 0x0004'u32
        FileNameInfo = 2'i32

#=======================================
# Global Variables
#=======================================

var
    NoColors* = false
    NoErrorColors* = false          ## same, but for errors (that go to stderr)
    TerminalColors*: ColorDepth     ## how many colors the terminal can show

#=======================================
# Helpers
#=======================================

when defined(windows):
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

proc closestBasic(r, g, b: int): int =
    ## the closest of the 16 standard colors
    ## (as a foreground color code: 30-37 or 90-97)
    let brightness = (max(r, max(g, b)) * 2 + 127) div 255
    if brightness == 0:
        return 30

    result = 30 + ((((b + 127) div 255) shl 2) or
                   (((g + 127) div 255) shl 1) or
                    ((r + 127) div 255))

    if brightness == 2:
        result += 60

proc closestExtended(r, g, b: int): int =
    ## the closest of the 256 colors
    if r == g and g == b:
        # one of the grays
        if r < 8: 16
        elif r > 248: 231
        else: 232 + ((r - 8) * 48 + 247) div 494
    else:
        # one of the 6x6x6 color cube
        # (its levels being: 0, 95, 135, 175, 215, 255)
        proc level(v: int): int =
            if v < 48: 0
            elif v < 115: 1
            else: (v - 35) div 40

        16 + 36 * level(r) + 6 * level(g) + level(b)

proc extendedColor(color: string, depth: ColorDepth): string =
    ## the given color (one of the 256),
    ## or the closest one the terminal can show
    if depth != BasicColors:
        return ";38;5;" & color

    let c = parseInt(color)
    let code =
        if c < 8: 30 + c
        elif c < 16: 90 + c - 8
        elif c < 232:
            # one of the 6x6x6 color cube
            const levels = [0, 95, 135, 175, 215, 255]
            let i = c - 16
            closestBasic(levels[i div 36], levels[(i div 6) mod 6], levels[i mod 6])
        else:
            # one of the grays
            let v = 8 + (c - 232) * 10
            closestBasic(v, v, v)

    ";" & $code

proc rgbColor(r, g, b: int, depth: ColorDepth): string =
    ## the given RGB color, or the closest one the terminal can show
    case depth:
        of TrueColors:      ";38;2;" & $r & ";" & $g & ";" & $b
        of ExtendedColors:  ";38;5;" & $closestExtended(r, g, b)
        of BasicColors:     ";" & $closestBasic(r, g, b)

proc backgroundColor(color: string): string =
    ## the background version of the given color
    ## (e.g. ";31" -> "41", ";90" -> "100", ";38;5;208" -> "48;5;208")
    if color.startsWith(";38;"): "48;" & color[4..^1]
    elif color.startsWith(";9"): "10" & color[2..^1]
    else: "4" & color[2..^1]

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

template dim*(color: string=""):string =
    if NoColors: ""
    else: "\e[2" & color & "m"

template italic*(color: string=""):string =
    if NoColors: ""
    else: "\e[3" & color & "m"

template strikethrough*(color: string=""):string =
    if NoColors: ""
    else: "\e[9" & color & "m"

template bg*(color: string):string =
    if NoColors: ""
    else: "\e[" & backgroundColor(color) & "m"

template rgb*(color: string):string =
    if NoColors: ""
    else: extendedColor(color, TerminalColors)

template rgb*(color: tuple[r, g, b: int]):string =
    if NoColors: ""
    else: rgbColor(color[0], color[1], color[2], TerminalColors)

#=======================================
# Methods
#=======================================

proc isTerminal*(toStderr = false): bool =
    ## is the output (or stderr) a terminal?
    ## (and not, e.g. a file or a pipe)
    when defined(WEB):
        true
    elif defined(windows):
        let h = getStdHandle(if toStderr: STD_ERROR_HANDLE else: STD_OUTPUT_HANDLE)
        var mode: uint32
        getConsoleMode(h, mode) != 0 or isCygwinPty(h)
    else:
        isatty(if toStderr: STDERR_FILENO else: STDOUT_FILENO) == 1

proc isColorFriendlyTerminal*(toStderr = false): bool =
    when defined(WEB):
        true
    else:
        let canShowColors =
            when defined(windows):
                let h = getStdHandle(if toStderr: STD_ERROR_HANDLE else: STD_OUTPUT_HANDLE)
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
                isTerminal(toStderr)

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

proc isUnicodeFriendlyTerminal*(): bool =
    ## Can the terminal show non-ASCII symbols (e.g. `❯`)?
    when defined(WEB):
        true
    elif defined(windows):
        # Windows Terminal, MSYS2 (e.g. mintty) or some other
        # modern terminal - the classic console's fonts lack them
        existsEnv("WT_SESSION") or
        existsEnv("MSYSTEM") or
        existsEnv("TERM_PROGRAM")
    else:
        # the Linux console's fonts lack them too
        if getEnv("TERM") in ["dumb", "linux"]:
            return false

        # otherwise, it's all about the locale
        for v in ["LC_ALL", "LC_CTYPE", "LANG"]:
            let locale = getEnv(v).toLowerAscii()
            if locale != "":
                return "utf-8" in locale or "utf8" in locale

        # no locale set (e.g. on macOS), but a known terminal
        existsEnv("TERM_PROGRAM")

proc clearTerminal*() =
    when defined(WEB):
        console.clear()
    else:
        # there's nothing to clear, if it's not a terminal
        if isTerminal():
            when defined(windows) and not defined(nimscript):
                # mintty & co. aren't consoles,
                # but they do understand escape codes
                var mode: uint32
                if getConsoleMode(getStdHandle(STD_OUTPUT_HANDLE), mode) == 0:
                    stdout.write("\e[H\e[2J")
                    stdout.flushFile()
                    return
            clearScreen()

#=======================================
# Initialization
#=======================================

TerminalColors = detectColorDepth()
