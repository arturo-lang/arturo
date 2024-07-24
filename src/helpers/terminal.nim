#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
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
    import os

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

proc clearTerminal*() = 
    when defined(WEB):
        console.clear()
    else:
        clearScreen()