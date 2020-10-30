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

import db_mysql as mysql
import db_sqlite as sqlite

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

proc closeSqliteDb*(dbObj: sqlite.DbConn) =
    sqlite.close(dbObj)
