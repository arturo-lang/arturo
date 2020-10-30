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
        echo "opening new db (sqlite): " & x.s
        let dbObj = openSqliteDb(x.s)
        echo "successfully opened: " & x.s

        var injectable = {
            "boom": newString("allakhu akbhar")
        }.toOrderedTable

        discard execBlock(y, willInject=true, inject=addr injectable)

        echo "closing db (sqlite): " & x.s
        closeSqliteDb(dbObj)
        echo "successfully closed: " & x.s


