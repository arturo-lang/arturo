#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/stores.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import os

import helpers/database
import helpers/io
import helpers/jsonobject

import vm/values/value
import vm/[exec, parse]

#=======================================
# Helpers
#=======================================

proc checkStorePath*(
    path: string, 
    global: bool = false, 
    kind: StoreKind = UndefinedStore
): (bool, string, StoreKind) =
    var actualPath: string = path
    var actualKind: StoreKind = kind

    if global:
        actualPath = getHomeDir().joinPath(".arturo").joinPath("stores").joinPath(actualPath)

    let existing = actualPath.fileExists()

    if actualKind == UndefinedStore:
        var (_, _, ext) = splitFile(actualPath)

        case ext:
            of ".art", ".store":
                actualKind = NativeStore
            of ".json":
                actualKind = JsonStore
            of ".db", ".sqlite", ".sqlite3":
                actualKind = SqliteStore
            else:
                actualKind = NativeStore

    return (existing, actualPath, actualKind)

#=======================================
# Methods
#=======================================

proc initStore*(
    path: string, 
    doLoad: bool,
    createIfNotExists: bool = true,
    forceCreate: bool = false,
    global: bool = false, 
    autosave: bool = false, 
    kind: StoreKind = UndefinedStore
): VStore =
    let (storeExists, storePath, storeKind) = checkStorePath(path, global, kind)

    result = VStore(
        path        : storePath,
        global      : global,
        autosave    : autosave,
        kind        : storeKind
    )

    if forceCreate or (createIfNotExists and (not storeExists)):
        case storeKind:
            of NativeStore:
                writeToFile(storePath, "")
            of JsonStore:
                writeToFile(storePath, "{}")
            of SqliteStore:
                result.db = openSqliteDb(storePath)
                discard result.db.execManySqliteDb(@[
                    "DROP TABLE IF EXISTS store;",
                    "CREATE TABLE store (id INTEGER PRIMARY KEY, key TEXT, kind TEXT, value JSON NOT NULL);",
                    "CREATE INDEX IF NOT EXISTS store_index ON store(id);",
                    "CREATE INDEX IF NOT EXISTS store_kind_index ON store(kind);"
                ])
            else:
                discard
    
    if doLoad:
        case storeKind:
            of NativeStore:
                result.data = execDictionary(doParse(storePath, isFile=false))
            of JsonStore:
                result.data = valueFromJson(readFile(storePath)).d
            of SqliteStore:
                # TODO(Helpers/stores) should add support for auto-loading SQLite stores
                #  labels: bug, values
                discard
            else:
                discard