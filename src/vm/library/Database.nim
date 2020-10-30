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

template DbClose*():untyped =
    require(opDbClose)

    if x.dbKind == SqliteDatabase:
        closeSqliteDb(x.sqlitedb)
    elif x.dbKind == MysqlDatabase:
        closeMysqlDb(x.mysqldb)

template DbExec*():untyped =
    require(opDbExec)

    if x.dbKind == SqliteDatabase:
        execSqliteDb(x.sqlitedb, y.s)
    elif x.dbKind == MysqlDatabase:
        execMysqlDb(x.mysqldb, y.s)

template DbOpen*():untyped =
    require(opDbOpen)

    var dbKind = SqliteDatabase

    if (popAttr("mysql") != VNULL):
        dbKind = MysqlDatabase

    let dbName = x.s

    if dbKind == SqliteDatabase:
        stack.push(newDatabase(openSqliteDb(dbName)))
    elif dbKind == MysqlDatabase:
        stack.push(newDatabase(openMysqlDb(dbName)))

# template Db*():untyped =
#     require(opDb)

#     if (popAttr("sqlite") != VNULL):
#         MainDb = openSqliteDb(x.s)

#         var internal = execInternal("db")

#         discard execBlock(y, willInject=true, inject=addr internal)

#         closeSqliteDb(MainDb)
