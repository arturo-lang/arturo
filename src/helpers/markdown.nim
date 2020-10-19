######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: helpers/markdown.nim
######################################################

#=======================================
# Libraries
#=======================================

when not defined(MINI):
    import extras/markdown

import vm/stack, vm/value

#=======================================
# Methods
#=======================================

when not defined(MINI):
    proc parseMarkdownInput*(input: string): Value =
        return newString(markdown(input))

else:
    proc parseMarkdownInput*(input: string): Value =
        echo "- feature not supported in MINI builds"
        return VNULL
