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

import db_sqlite

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

proc openSqliteDb(name: string): DbConn =
    open(name, "", "", "")

proc closeSqliteDb(dbObj: DbConn) =
    dbObj.close()
