######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: helpers/database.nim
######################################################

#=======================================
# Libraries
#=======================================

import sequtils, sqlite3

import db_mysql as mysql
import db_sqlite as sqlite

import vm/value

#=======================================
# Methods
#=======================================

#-----------------------
# MySQL
#-----------------------

proc openMysqlDb*(name: string, 
                  server: string = "localhost", 
                  username: string = "", 
                  password: string = ""): mysql.DbConn =
    mysql.open(server, username, password, name)

proc execMysqlDb*(db: mysql.DbConn, command: string) =
    db.exec(sql(command))

proc closeMysqlDb*(dbObj: mysql.DbConn) =
    mysql.close(dbObj)

#-----------------------
# SQLite
#-----------------------

proc openSqliteDb*(name: string): sqlite.DbConn =
    sqlite.open(name, "", "", "")

proc execSqliteDb*(db: sqlite.DbConn, command: string): ValueArray =
    result = @[]

    for row in db.rows(sql(command)):
        result.add(newStringBlock(row))

proc execManySqliteDb*(db: sqlite.DbConn, commands: seq[string]): ValueArray =
    result = @[]

    db.exec(sql"BEGIN")

    for command in commands:
        result = concat(result, execSqliteDb(db, command))

    db.exec(sql"COMMIT")

proc getLastIdSqliteDb*(db: sqlite.DbConn): int64 = 
    last_insert_rowid(db)

proc closeSqliteDb*(db: sqlite.DbConn) =
    sqlite.close(db)
