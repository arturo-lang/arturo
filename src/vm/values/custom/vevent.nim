#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: vm/values/custom/vevent.nim
#=======================================================

## Internal representation for the `:event` value.
##
## An event carries a name; the name *is* the identity. Two `event 'foo`
## constructions yield equal events (the runtime keys subscribers by name,
## so this is the sense the user observes).
##
## Built-in events (e.g. `CtrlC`, `BeforeExit`) are pre-bound `:event`
## values constructed at startup — they're not a separate kind, just
## conventionally-named instances of this same type.

#=======================================
# Libraries
#=======================================

import hashes

#=======================================
# Types
#=======================================

type
    VEvent* = ref object
        name*: string

#=======================================
# Overloads
#=======================================

proc hash*(e: VEvent): Hash {.inline.} =
    hash(e.name)

func `$`*(e: VEvent): string =
    "<event:" & e.name & ">"
