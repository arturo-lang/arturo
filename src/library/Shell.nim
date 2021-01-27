######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Shell.nim
######################################################

#=======================================
# Methods
#=======================================

builtin "execute",
    alias       = unaliased, 
    precedence  = PrefixPrecedence,
    description = "execute given shell command",
    args        = {
        "command"   : {String}
    },
    attrs       = NoAttrs,
    returns     = {String},
    example     = """
        print execute "pwd"
        ; /Users/admin/Desktop
        
        split.lines execute "ls"
        ; => ["tests" "var" "data.txt"]
    """:
        ##########################################################
        let res = execCmdEx(x.s)
        
        stack.push(newString(res[0]))

builtin "list",
    alias       = unaliased, 
    precedence  = PrefixPrecedence,
    description = "get files at given path",
    args        = {
        "path"  : {String}
    },
    attrs       = {
        "select"    : ({String},"select files satisfying given pattern"),
        "relative"  : ({Boolean},"get relative paths")
    },
    returns     = {Block},
    example     = """
        loop list "." 'file [
        ___print file
        ]
        
        ; ./tests
        ; ./var
        ; ./data.txt
        
        loop list.relative "tests" 'file [
        ___print file
        ]
        
        ; test1.art
        ; test2.art
        ; test3.art
    """:
        ##########################################################
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
