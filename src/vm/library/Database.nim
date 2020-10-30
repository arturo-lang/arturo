######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Database.nim
######################################################

#=======================================
# Libraries
#=======================================

import vm/stack, vm/value

#=======================================
# Methods
#=======================================

template Db*():untyped =
    require(opDb)

    if (popAttr("sqlite") != VNULL):
        MainDb = openSqliteDb(x.s)

        var internal = execInternal("db")

        discard execBlock(y, willInject=true, inject=addr internal)

        closeSqliteDb(MainDb)
