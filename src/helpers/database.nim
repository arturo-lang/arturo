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

proc execSqliteDb*(db: sqlite.DbConn, command: string) =
    echo "execSqliteDb"
    echo repr db
    echo "command: " & command
    db.exec(sql(command))

proc closeSqliteDb*(db: sqlite.DbConn) =
    sqlite.close(db)
