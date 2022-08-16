######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/bytecode.nim
######################################################

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import marshal, streams

when defined(VERBOSE):
    import strformat, strutils
    import helpers/terminal as terminalHelper

import opcodes
export opcodes

import vm/values/value

#=======================================
# Methods
#=======================================

# TODO(Bytecode) Re-visit bytecode reading & writing
#  Right now, we're using Nim's "marshalling". This looks a bit unnecessary.
#  labels: enhancement, cleanup, vm

proc writeBytecode*(trans: Translation, target: string): bool =
    when not defined(WEB):
        let marshaled = $$(trans[0])
        echo marshaled
        let bcode = trans[1]

        var f = newFileStream(target, fmWrite)
        if not f.isNil:
            f.write(len(marshaled))
            f.write(marshaled)
            f.write(len(bcode))
            for b in bcode:
                f.write(b)
            f.flush

            return true
        else:
            return false
    else:
        discard

proc readBytecode*(origin: string): Translation =
    when not defined(WEB):
        var f = newFileStream(origin, fmRead)
        if not f.isNil:
            var s: int
            f.read(s)           # read constants size
            var t: string
            f.readStr(s,t)      # read the marshaled constants

            f.read(s)           # read bytecode size

            var bcode: ByteArray = newSeq[byte](s)
            var indx = 0
            while not f.atEnd():
                bcode[indx] = f.readUint8()         # read bytes one-by-one
                indx += 1

            return (t.to[:ValueArray], bcode)       # return the Translation
    else:
        discard

#=======================================
# Inspection
#=======================================

when defined(VERBOSE):
    # TODO(Eval/dump) Needs some serious cleanup
    #  The whole implementation currenly looks like a patchwork of ideas.
    #  labels: vm, evaluator, cleanup
    proc dump*(evaled: Translation) =
        echo $(newBytecode(evaled))
        # var lines: seq[string] = @[] 
        # # for l in showDebugHeader("Constants"):
        # #     lines.add(l)

        # # var i = 0

        # # let consts = evaled[0]
        # let it = evaled[1]

        # # while i < consts.len:
        # #     var cnst = consts[i]
        # #     lines.add(fmt("{i}: "))
        # #     # stdout.write fmt("{i}: ")
        # #     # cnst.dump(0, false)

        # #     i += 1
        
        # # for l in showDebugHeader("Instruction Table"):
        # #     lines.add(l)

        # var i = 0

        # while i < it.len:
        #     #stdout.write fmt("{i}: ")
        #     var instr = (OpCode)(it[i])

        #     #stdout.write ($instr).replace("op").toLowerAscii()

        #     case instr:
        #         of opPush, opStore, opLoad, opCall, opAttr:
        #             i += 1
        #             let indx = it[i]
        #             lines.add(($instr).replace("op").toUpperAscii() & fmt("\t#{indx}"))
        #         # of opExtra:
        #         #     i += 1
        #         #     let extra = ($((OpCode)((int)(it[i])+(int)(opExtra)))).replace("op").toLowerAscii()
        #         #     stdout.write fmt("\t%{extra}\n")
        #         else:
        #             lines.add(($instr).replace("op").toUpperAscii())

        #     i += 1
 
        # echo ""
        # echo bold(grayColor) & ">>      VM | " & fg(grayColor) & 
        #      lines.join(bold(grayColor) & "\n           | " & fg(grayColor)) & resetColor
