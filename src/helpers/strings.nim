######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: helpers/string.nim
######################################################

#=======================================
# Libraries
#=======================================

when not defined(MINI):
    import unidecode

import vm/value

#=======================================
# Methods
#=======================================

when not defined(MINI):
    proc convertToAscii*(input: string): Value =
        return newString(unidecode(input))

else:
    proc convertToAscii*(input: string): Value =
        echo "- feature not supported in MINI builds"
        return VNULL
