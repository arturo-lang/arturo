######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/clipboard.nim
######################################################

#=======================================
# Libraries
#=======================================

import extras/libclipboard

#=======================================
# Methods
#=======================================

proc setClipboard*(content: string) =
    var clipboard = clipboard_new(nil)
    clipboard.clipboard_clear(LCB_CLIPBOARD)
    clipboard.clipboard_set_text(content.cstring)
    clipboard.clipboard_free()

proc getClipboard*():string =
    var clipboard = clipboard_new(nil)
    let cresult = clipboard.clipboard_text()
    return $(cresult)