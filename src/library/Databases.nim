#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: library/Databases.nim
#=======================================================

## The main Databases module 
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

# TODO(Databases) include SQLite support by default in MINI builds?
#  this should be possible, provided that we can static-link SQLite
#  labels: library,enhancement,open discussion
when not defined(NOSQLITE):
    import sequtils, sugar
    
    import helpers/database

when not defined(WEB):
    import helpers/stores

import vm/lib

#=======================================
# Definitions
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

proc defineLibrary*() =

    #----------------------------
    # Functions
    #----------------------------

    when not defined(NOSQLITE):

        builtin "close",
            alias       = unaliased, 
            op          = opNop,
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
                #=======================================================
                if x.dbKind == SqliteDatabase:
                    closeSqliteDb(x.sqlitedb)
                # elif x.dbKind == MysqlDatabase:
                #     closeMysqlDb(x.mysqldb)

        builtin "open",
            alias       = unaliased, 
            op          = opNop,
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
                #=======================================================
                var dbKind = SqliteDatabase

                if (hadAttr("mysql")):
                    dbKind = MysqlDatabase

                let dbName = x.s

                if dbKind == SqliteDatabase:
                    push(newDatabase(openSqliteDb(dbName)))
                # elif dbKind == MysqlDatabase:
                #     push(newDatabase(openMysqlDb(dbName)))

        builtin "query",
            alias       = unaliased, 
            op          = opNop,
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
                #=======================================================
                var with: seq[string]
                if checkAttr("with"):
                    with = aWith.a.map((x) => $(x))

                if x.dbKind == SqliteDatabase:
                    if yKind == String:
                        if (let got = execSqliteDb(x.sqlitedb, y.s, with); got[0]==ValidQueryResult):
                            push(newBlock(got[1]))
                    else:
                        if (let got = execManySqliteDb(x.sqlitedb, y.a.map(proc (v:Value):string = (requireValue(v,{String},2); v.s)), with); got[0]==ValidQueryResult):
                            push(newBlock(got[1]))
                    
                    if (hadAttr("id")):
                        push(newInteger(getLastIdSqliteDb(x.sqlitedb)))

                # elif x.dbKind == MysqlDatabase:
                #     execMysqlDb(x.mysqldb, y.s)

    when not defined(WEB):

        builtin "store",
            alias       = unaliased,
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "create or load a persistent store on disk",
            args        = {
                "path"  : {Literal,String}
            },
            attrs       = {
                "deferred"  : ({Logical},"save to disk only on program termination"),
                "global"    : ({Logical},"save as global store"),
                "native"    : ({Logical},"force native/Arturo format"),
                "json"      : ({Logical},"force Json format"),
                "db"        : ({Logical},"force database/SQlite format")
            },
            returns     = {Range},
            example     = """
            ; create a new store with the name `mystore`
            ; it will be automatically live-stored in a file in the same folder
            ; using the native Arturo format
            data: store "mystore"

            ; store some data
            data\name: "John"
            data\surname: "Doe"
            data\age: 36

            ; and let's retrieve our data
            data
            ; => [name:"John" surname:"Doe" age:36]
            ..........
            ; create a new "global" configuration store
            ; that will be saved automatically in ~/.arturo/stores
            globalStore: store.global "configuration"

            ; we are now ready to add or retrieve some persistent data!
            ..........
            ; create a new JSON store with the name `mystore`
            ; it will be automatically live-stored in a file in the same folder
            ; with the name `mystore.json`
            data: store.json "mystore"

            ; store some data
            da\people: []

            ; data can be as complicated as in any normal dictionary
            da\people: da\people ++ #[name: "John" surname: "Doe"]

            ; check some specific store value
            da\people\0\name
            ; => "John"
            ..........
            ; create a new deferred store with the name `mystore`
            ; it will be automatically saved in a file in the same folder
            ; using the native Arturo format
            defStore: store.deferred "mystore"

            ; let's save some data
            defStore\name: "John"
            defStore\surname: "Doe"

            ; and print it
            print defStore
            ; [name:John surname:Doe]

            ; in this case, all data is available at any given moment
            ; but will not be saved to disk for each and every operation;
            ; instead, it will be saved in its totality just before
            ; the program terminates!
            """:
                #=======================================================
                let isGlobal = hadAttr("global")
                let isAutosave = not hadAttr("deferred")

                var storeKind = UndefinedStore

                let isNative = hadAttr("native")
                let isJson = hadAttr("json")
                let isSqlite = hadAttr("db")

                if isNative:
                    storeKind = NativeStore
                elif isJson:
                    storeKind = JsonStore
                elif isSqlite:
                    storeKind = SqliteStore

                let store = initStore(
                    x.s,
                    doLoad = true,
                    forceExtension = true,
                    global = isGlobal,
                    autosave = isAutosave,
                    kind = storeKind
                )

                push newStore(store)

#=======================================
# Add Library
#=======================================

Libraries.add(defineLibrary)