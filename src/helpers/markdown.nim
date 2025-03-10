#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2025 Yanis Zafirópulos
#
# @file: helpers/markdown.nim
#=======================================================

#=======================================
# Libraries
#=======================================

# TODO(Helpers/markdown) verify & benchmark Markdown parsing
#  Which of the libraries are we using in the end? What are the pros and cons of each one? Let's benchmark it!
#  labels: helpers, 3rd-party, benchmark, unit-test

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
            discard toMarkdown( cstring(input), cint(len(input)), addr ret,0,0)
            var str = newString(ret.size)
            copyMem(addr(str[0]), ret.data, ret.size)
            freeMarkdownBuffer(addr ret)
            return newString(str)