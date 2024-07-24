#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: helpers/io.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import vm/values/custom/[vbinary]

#=======================================
# Methods
#=======================================

proc writeToFile*(path: string, contents: string, append = false) {.tags: [WriteIOEffect].} =
    var fm : FileMode = fmWrite
    if append: fm = fmAppend

    var f: File = nil
    if open(f, path, fm):
        try:
            f.write(contents)
        finally:
            close(f)
    else: 
        raise newException(IOError, "cannot open: " & path)

proc writeToFile*(path: string, contents: VBinary, append = false) {.tags: [WriteIOEffect].} =
    var fm : FileMode = fmWrite
    if append: fm = fmAppend

    var f: File = nil
    if open(f, path, fm):
        try:
            f.writeBuffer(unsafeAddr contents[0], contents.len)
        finally:
            close(f)
    else:
        raise newException(IOError, "cannot open: " & path)
