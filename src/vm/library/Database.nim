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

template Close*():untyped =
    require(opClose)

    if x.dbKind == SqliteDatabase:
        closeSqliteDb(x.sqlitedb)
    elif x.dbKind == MysqlDatabase:
        closeMysqlDb(x.mysqldb)

template Query*():untyped =
    require(opQuery)

    if x.dbKind == SqliteDatabase:
        if y.kind == String:
            if (let got = execSqliteDb(x.sqlitedb, y.s); got.len != 0):
                stack.push(newBlock(got))
        else:
            if (let got = execManySqliteDb(x.sqlitedb, y.a.map(proc (v:Value):string = v.s)); got.len != 0):
                stack.push(newBlock(got))
            
        if (popAttr("id") != VNULL):
            stack.push(newInteger(getLastIdSqliteDb(x.sqlitedb)))

    elif x.dbKind == MysqlDatabase:
        execMysqlDb(x.mysqldb, y.s)

template Open*():untyped =
    require(opOpen)

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
