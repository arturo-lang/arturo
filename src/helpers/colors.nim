######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: helpers/colors.nim
######################################################

#=======================================
# Constants
#=======================================

const
    resetColor*     = "\e[0m"

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

template fg*(color: string=""):string =
    "\e[0" & color & "m"

template bold*(color: string=""):string =
    "\e[1" & color & "m"

template underline*(color: string=""):string = 
    "\e[4" & color & "m"

template rgb*(color: string=""):string =
    ";38;5;" & color
