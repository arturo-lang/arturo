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

import vm/stack, vm/value

#=======================================
# Methods
#=======================================

template Execute*():untyped =
    # EXAMPLE:
    # print execute "pwd"
    # ; /Users/admin/Desktop
    #
    # split.lines execute "ls"
    # ; => ["tests" "var" "data.txt"]

    require(opExecute)

    let res = execCmdEx(x.s)
    
    stack.push(newString(res[0]))

template List*():untyped =
    # EXAMPLE:
    # loop list "." 'file [
    # ___print file
    # ]
    # 
    # ; ./tests
    # ; ./var
    # ; ./data.txt
    #
    # loop list.relative "tests" 'file [
    # ___print file
    # ]
    # 
    # ; test1.art
    # ; test2.art
    # ; test3.art

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
