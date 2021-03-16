######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: helpers/markdown.nim
######################################################

#=======================================
# Libraries
#=======================================

when not defined(MINI):
    when defined(USE_NIM_MARKDOWN):
        import extras/markdown
    else:
        import extras/md4c

import vm/value

#=======================================
# Methods
#=======================================

when not defined(MINI):
    proc parseMarkdownInput*(input: string): Value =
        when defined(USE_NIM_MARKDOWN):
            return newString(markdown(input))
        else:
            var ret: memBuffer = memBuffer(size: 0, asize: 0, data: "")
            discard toMarkdown( cstring(input), cint(len(input)),ret,0,0)
            var str = newString(ret.size)
            copyMem(addr(str[0]), ret.data, ret.size)
            freeMarkdownBuffer(ret)
            return newString(str)

else:
    proc parseMarkdownInput*(input: string): Value =
        echo "- feature not supported in MINI builds"
        return VNULL
