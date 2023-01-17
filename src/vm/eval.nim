#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: vm/eval.nim
#=======================================================

## This module contains the evaluator for the VM.
## 
## The evaluator:
## - takes a Block of values coming from the parser
## - passes to the AST generator
## - interpretes the AST and returns a Translation object
## 
## The main entry point is ``doEval``.

#=======================================
# Libraries
#=======================================

import hashes, tables

import vm/[ast, bytecode, values/value]
import vm/values/custom/[vbinary]

#=======================================
# Variables
#=======================================

var
    StoredTranslations : Table[Hash, Translation]

#=======================================
# Helpers
#=======================================

#=======================================
# Methods
#=======================================

proc evaluateBlock*(blok: Node, isDictionary=false): Translation =
    var consts: ValueArray
    var it: VBinary

    result = Translation(constants: consts, instructions: it)

#=======================================
# Main
#=======================================

proc doEval*(root: Value, isDictionary=false, useStored: static bool = true): Translation {.inline.} = 
    ## Take a parsed Block of values and return its Translation - 
    ## that is: the constants found + the list of bytecode instructions
    
    var vhash {.used.}: Hash = -1
    
    when useStored:
        if not root.dynamic:
            vhash = hash(root)
            if (let storedTranslation = StoredTranslations.getOrDefault(vhash, nil); not storedTranslation.isNil):
                return storedTranslation

    result = evaluateBlock(generateAst(root), isDictionary=isDictionary)
    result.instructions.add(byte(opEnd))

    when useStored:
        if vhash != -1:
            StoredTranslations[vhash] = result

template evalOrGet*(item: Value): untyped =
    if item.kind==Bytecode: item.trans
    else: doEval(item)