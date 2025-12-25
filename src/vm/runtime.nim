#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: vm/runtime.nim
#=======================================================

## VM runtime

#=======================================
# Libraries
#=======================================

import os

#=======================================
# Types
#=======================================

type
    Frame* = ref object
        folder*: string
        path*: string

#=======================================
# Constants
#=======================================

const FrameStackSize* = 100000   ## The initial stack size

#=======================================
# Globals
#=======================================

var
    # the path stack
    FrameStack*     {.global.}  : seq[Frame]       ## The main frame stack
    FSP*            {.global.}  : int

#---------------------
# Methods
#---------------------

template createFrameStack*() =
    ## initialize the main stack
    newSeq(FrameStack, FrameStackSize)
    FSP = 0

template emptyFrameStack*(): bool =
    FSP == 1

template entryFrame*(): Frame =
    ## get initial script path
    FrameStack[0]

template currentFrame*(): Frame =
    ## get current frame
    FrameStack[FSP-1]

template postCurrentFrame*(): Frame =
    ## get frame at error point
    ## Warning: Don't use that, unless we *know*
    ## there is an extra frame (and that's normally 
    ## only when an error was thrown)
    FrameStack[FSP]

template pushFrame*(newPath: string, fromFile: static bool = false) =
    ## add given frame to the stack
    when fromFile:
        var (dir, _, _) = splitFile(newPath)
        FrameStack[FSP] = Frame(folder: dir, path: newPath)
    else:
        FrameStack[FSP] = Frame(folder: newPath, path: "")
    FSP += 1

template pushFrame*(newFrame: Frame) =
    ## add given frame to the stack
    FrameStack[FSP] = newFrame
    FSP += 1

proc popFrame*(): Frame =
    ## pop last frame from the stack
    FSP -= 1
    return FrameStack[FSP]

template discardFrame*() =
    ## pop last frame from the stack
    ## without returning it
    FSP -= 1