#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: helpers/database.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import sequtils, strutils

#import db_mysql as mysql
import extras/db_connector/sqlite3
import extras/db_connector/db_sqlite as sqlite

import vm/values/value

#=======================================
# Types
#=======================================

type
    QueryResultKind* = enum
        EmptyQueryResult,
        ValidQueryResult

    QueryResult* = (QueryResultKind, ValueArray)

#=======================================
# Methods
#=======================================

# TODO(Helpers/database) Re-add MySQL-related helper functions
#  Apparently, we already have MySQL support for the core helper function - as with Sqlite. Why are they not in? Was it because of the extra dependencies?
#  This has to be resolved at some point.
#  labels: helpers, 3rd-party, enhancement, cleanup

#-----------------------
# MySQL
#-----------------------

# func openMysqlDb*(name: string, 
#                   server: string = "localhost", 
#                   username: string = "", 
#                   password: string = ""): mysql.DbConn =
#     mysql.open(server, username, password, name)

# func execMysqlDb*(db: mysql.DbConn, command: string) =
#     db.exec(sql(command))

# func closeMysqlDb*(dbObj: mysql.DbConn) =
#     mysql.close(dbObj)

#-----------------------
# SQLite
#-----------------------

func openSqliteDb*(name: string): sqlite.DbConn =
    sqlite.open(name, "", "", "")

proc execSqliteDb*(db: sqlite.DbConn, command: string, with: seq[string] = @[]): QueryResult =
    var ret: ValueArray

    for row in db.rows(sql(command), with):
        ret.add(newStringBlock(row))

    if ret.len>0 or command.toLowerAscii.contains("select"):
        result = (ValidQueryResult, ret)
    else:
        result = (EmptyQueryResult, ret)

proc execManySqliteDb*(db: sqlite.DbConn, commands: seq[string], with: seq[string] = @[]): QueryResult =
    var ret: ValueArray

    db.exec(sql"BEGIN")

    for command in commands:
        ret = concat(ret, execSqliteDb(db, command, with)[1])

    db.exec(sql"COMMIT")

    result = (EmptyQueryResult, ret)

func getLastIdSqliteDb*(db: sqlite.DbConn): int64 = 
    last_insert_rowid(db)

func closeSqliteDb*(db: sqlite.DbConn) =
    sqlite.close(db)
