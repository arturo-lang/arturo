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

import sequtils, strformat, strutils
import sugar, tables

import db_mysql as mysql
import db_sqlite as sqlite

import vm/globals, vm/value

# #=======================================
# # Types
# #=======================================

# type
#     DataSourceKind* = enum
#         WebData,
#         FileData,
#         TextData

#     DataSource* = (string, DataSourceKind)

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

proc closeSqliteDb*(dbObj: mysql.DbConn) =
    mysql.close(dbObj)

#-----------------------
# SQLite
#-----------------------

proc openSqliteDb*(name: string): sqlite.DbConn =
    sqlite.open(name, "", "", "")

proc createSqliteTable*(name: Value, details: Value) =
    var fields = ""
    let size = len(details.d)
    var indx = 0
    for k,v in pairs(details.d):
        fields &= k & " " & v.s
        indx += 1
        if indx!=size:
            fields &= ", "

    MainDb.exec(sql(fmt("CREATE TABLE {name.s} ({fields})")))

proc insertIntoSqliteTable*(name: Value, details: Value) =
    let keys = toSeq(details.d.keys).join(", ")
    let values = toSeq(details.d.values).map((x)=> "\"" & x.s & "\"").join(", ")

    MainDb.exec(sql"BEGIN")

    MainDb.exec(sql(fmt("INSERT INTO {name.s} ({keys}) VALUES ({values})")))

proc closeSqliteDb*(dbObj: sqlite.DbConn) =
    sqlite.close(dbObj)
