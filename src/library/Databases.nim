######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: library/Databases.nim
######################################################

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

when not defined(NOSQLITE):
    import sequtils, sugar
    
    import helpers/database

import vm/lib

#=======================================
# Methods
#=======================================

# TODO(Databases) Add support for IndexedDB
#  Currently, the only supported database is Sqlite. Obviously, this would be only for Web/JS builds.
#  labels: library,enhancement,web

# TODO(Databases) Add support for MySQL
#  Currently, the only supported database is Sqlite
#  labels: library,enhancement

# TODO(Databases) Add support for MongoDB
#  Currently, the only supported database is Sqlite
#  labels: library,enhancement

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Databases"

    when not defined(NOSQLITE):

        builtin "close",
            alias       = unaliased, 
            rule        = PrefixPrecedence,
            description = "close given database",
            args        = {
                "database"  : {Database}
            },
            attrs       = NoAttrs,
            returns     = {Nothing},
            example     = """
            db: open "my.db"    ; opens an SQLite database named 'my.db'
            
            print query db "SELECT * FROM users"

            close db            ; and close it
            """:
                ##########################################################
                if x.dbKind == SqliteDatabase:
                    closeSqliteDb(x.sqlitedb)
                # elif x.dbKind == MysqlDatabase:
                #     closeMysqlDb(x.mysqldb)

        builtin "query",
            alias       = unaliased, 
            rule        = PrefixPrecedence,
            description = "execute command or block of commands in given database and get returned rows",
            args        = {
                "database"  : {Database},
                "commands"  : {String,Block}
            },
            attrs       = {
                "id"    : ({Logical},"return last INSERT id"),
                "with"  : ({Block},"use arguments for parametrized statement")
            },
            returns     = {Integer,Block,Null},
            example     = """
            db: open "my.db"    ; opens an SQLite database named 'my.db'
            
            ; perform a simple query
            print query db "SELECT * FROM users"

            ; perform an INSERT query and get back the record's ID
            username: "johndoe"
            lastInsertId: query.id db ~{!sql INSERT INTO users (name) VALUES ('|username|')}

            ; perform a safe query with given parameters
            print query db .with: ["johndoe"] {!sql SELECT * FROM users WHERE name = ?}
            """:
                ##########################################################
                var with: seq[string] = @[]
                if (let aWith = popAttr("with"); aWith != VNULL):
                    with = aWith.a.map((x) => $(x))

                if x.dbKind == SqliteDatabase:
                    if y.kind == String:
                        if (let got = execSqliteDb(x.sqlitedb, y.s, with); got[0]==ValidQueryResult):
                            push(newBlock(got[1]))
                    else:
                        if (let got = execManySqliteDb(x.sqlitedb, cleanBlock(y.a).map(proc (v:Value):string = v.s), with); got[0]==ValidQueryResult):
                            push(newBlock(got[1]))
                    
                    if (popAttr("id") != VNULL):
                        push(newInteger(getLastIdSqliteDb(x.sqlitedb)))

                # elif x.dbKind == MysqlDatabase:
                #     execMysqlDb(x.mysqldb, y.s)

        builtin "open",
            alias       = unaliased, 
            rule        = PrefixPrecedence,
            description = "opens a new database connection and returns database",
            args        = {
                "name"  : {String}
            },
            attrs       = {
                "sqlite": ({Logical},"support for SQLite databases"),
                "mysql" : ({Logical},"support for MySQL databases")
            },
            returns     = {Database},
            example     = """
            db: open "my.db"    ; opens an SQLite database named 'my.db'
            """:
                ##########################################################
                var dbKind = SqliteDatabase

                if (popAttr("mysql") != VNULL):
                    dbKind = MysqlDatabase

                let dbName = x.s

                if dbKind == SqliteDatabase:
                    push(newDatabase(openSqliteDb(dbName)))
                # elif dbKind == MysqlDatabase:
                #     push(newDatabase(openMysqlDb(dbName)))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)