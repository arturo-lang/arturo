######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Core.nim
######################################################

#=======================================
# Libraries
#=======================================

import ../stack, ../value

#=======================================
# Methods
#=======================================

template Execute*():untyped =
    require(opExecute)

    #let (outp, errC) = execCmdEx(x.s)
    let res = execCmdEx(x.s)
    
    stack.push(newString(res[0]))

template List*():untyped =
    require(opList)
    
    if (let aSelect = popAttr("select"); aSelect != VNULL):
        if (popAttr("relative") != VNULL):
            stack.push(newStringBlock((toSeq(walkDir(x.s, relative=true)).map((x)=>x[1])).filter((x) => x.contains aSelect.s)))
        else:
            stack.push(newStringBlock((toSeq(walkDir(x.s)).map((x)=>x[1])).filter((x) => x.contains aSelect.s)))
    else:
        if (popAttr("relative") != VNULL):
            stack.push(newStringBlock(toSeq(walkDir(x.s, relative=true)).map((x)=>x[1])))
        else:
            stack.push(newStringBlock(toSeq(walkDir(x.s)).map((x)=>x[1])))
