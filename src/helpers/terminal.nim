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

when not defined(WEB):
    import os, strutils

#=======================================
# Global Variables
#=======================================

var
    NoColors* = false

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

proc isColorFriendlyTerminal*(): bool =
    when defined(windows):
        existsEnv("MSYSTEM") or 
        existsEnv("TERM") or 
        ((not existsEnv("COMSPEC")) and (not existsEnv("PSModulePath")))
    else:
        true

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
        clearScreen()