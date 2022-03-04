######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/markdown.nim
######################################################

#=======================================
# Libraries
#=======================================

when not defined(NOPARSERS):
    when defined(USE_NIM_MARKDOWN):
        import extras/markdown
    else:
        import extras/md4c

import vm/values/value

#=======================================
# Methods
#=======================================

when not defined(NOPARSERS):

    when defined(USE_NIM_MARKDOWN):
        proc parseMarkdownInput*(input: string): Value =
            return newString(markdown(input))
    else:
        func parseMarkdownInput*(input: string): Value =
            var ret: memBuffer = memBuffer(size: 0, asize: 0, data: "")
            discard toMarkdown( cstring(input), cint(len(input)),ret,0,0)
            var str = newString(ret.size)
            copyMem(addr(str[0]), ret.data, ret.size)
            freeMarkdownBuffer(ret)
            return newString(str)