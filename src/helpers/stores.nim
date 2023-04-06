#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: helpers/stores.nim
#=======================================================

# TODO(Helpers/stores) Add support for RocksDB or LMDB - or both?
#  this could also work for normal Database values
#  labels: new feature, values, open discussion

#=======================================
# Libraries
#=======================================

import os, strutils, tables

when not defined(NOSQLITE):
    import extras/db_connector/db_sqlite as sqlite
    import helpers/database

import helpers/io
import helpers/jsonobject

import vm/values/[printable, value]
import vm/[exec, errors, globals, parse]

#=======================================
# Helpers
#=======================================

proc checkStorePath*(
    path: string, 
    forceExtension: bool = false,
    global: bool = false, 
    kind: StoreKind = UndefinedStore
): (bool, string, StoreKind) =
    var actualPath: string = path
    var actualKind: StoreKind = kind

    if global:
        actualPath = getHomeDir().joinPath(".arturo").joinPath("stores").joinPath(actualPath)

    var (_, _, ext) = splitFile(actualPath)

    if actualKind == UndefinedStore:
        case ext:
            of ".art", ".store":
                actualKind = NativeStore
            of ".json":
                actualKind = JsonStore
            of ".db", ".sqlite", ".sqlite3":
                actualKind = SqliteStore
            else:
                actualKind = NativeStore
    else:
        if forceExtension:
            case actualKind:
                of NativeStore:
                    if ext notin [".art", ".store"]:
                        actualPath = actualPath.changeFileExt(".art")
                of JsonStore:
                    if ext != ".json":
                        actualPath = actualPath.changeFileExt(".json")
                of SqliteStore:
                    if ext notin [".db", ".sqlite", ".sqlite3"]:
                        actualPath = actualPath.changeFileExt(".db")
                else:
                    discard

    let existing = actualPath.fileExists()

    return (existing, actualPath, actualKind)

func canStoreKey*(storeKind: StoreKind, valueKind: ValueKind): bool {.inline,enforceNoRaises.} =
    if storeKind == NativeStore: return true

    return valueKind in {Integer, Floating, String, Logical, Block, Dictionary, Null}

#=======================================
# Templates
#=======================================

template savePendingStores*(): untyped =
    if Stores.len > 0:
        for store in Stores:
            if store.pending:
                store.saveStore()

                if store.kind == SqliteStore:
                    when not defined(NOSQLITE):
                        closeSqliteDb(store.db)
                    else:
                        RuntimeError_SqliteDisabled()

template ensureLoaded*(store: VStore): untyped =
    if not store.loaded:
        store.loadStore()
        store.loaded = true

#=======================================
# Methods
#=======================================

proc saveStore*(store: VStore, one = false, key: string = "") =
    case store.kind:
        of NativeStore:
            writeToFile(
                store.path, 
                codify(newDictionary(store.data),pretty=true, unwrapped=true).strip()
            )
        of JsonStore:
            writeToFile(store.path, jsonFromValueDict(store.data, pretty=true))
        of SqliteStore:
            when not defined(NOSQLITE):
                if one:
                    let value = store.data[key]
                    let kind = $(value.kind)
                    let json = jsonFromValue(value)
                    let sql = "INSERT OR REPLACE INTO store (key, kind, value) VALUES (?, ?, ?);"
                    discard store.db.execSqliteDb(sql, @[key, kind, json])
                else:
                    # TODO(Helpers/stores) should add support for auto-saving entire SQLite stores
                    #  labels: bug, values
                    discard
                discard
            else:
                RuntimeError_SqliteDisabled()
        else:
            discard

proc loadStore*(store: VStore, justCreated=false) = 
    if justCreated:
        store.data = newOrderedTable[string, Value]()
    else:
        case store.kind:
            of NativeStore:
                store.data = execDictionary(doParse(store.path, isFile=true))
            of JsonStore:
                store.data = valueFromJson(readFile(store.path)).d
            of SqliteStore:
                when not defined(NOSQLITE):
                    store.data = newOrderedTable[string, Value]()
                    for row in store.db.rows(sql("SELECT * FROM store;"), @[]):
                        store.data[row[0]] = valueFromJson(row[2])
                else:
                    RuntimeError_SqliteDisabled()
            else:
                discard

proc createEmptyStoreOnDisk*(store: VStore) =
    case store.kind:
        of NativeStore:
            # create path's directory if not exists
            let dir = splitFile(store.path).dir
            if not dir.dirExists():
                createDir(dir)
            writeToFile(store.path, "")
        of JsonStore:
            let dir = splitFile(store.path).dir
            if not dir.dirExists():
                createDir(dir)
            writeToFile(store.path, "{}")
        of SqliteStore:
            when not defined(NOSQLITE):
                discard store.db.execManySqliteDb(@[
                    "DROP TABLE IF EXISTS store;",
                    "CREATE TABLE store (key TEXT, kind TEXT, value JSON NOT NULL);",
                    "CREATE UNIQUE INDEX IF NOT EXISTS store_index ON store(key);",
                    "CREATE INDEX IF NOT EXISTS store_kind_index ON store(kind);"
                ])
            else:
                RuntimeError_SqliteDisabled()
        else:
            discard

proc getStoreKey*(store: VStore, key: string, unsafe: static bool=false): Value =
    ensureStoreIsLoaded(store)
    
    when unsafe:
        # don't throw an error in case the key doesn't exist
        # return nil instead
        store.data.getOrDefault(key, nil)
    else:
        GetKey(store.data, key)

proc setStoreKey*(store: VStore, key: string, value: Value) =
    if unlikely(not canStoreKey(store.kind, value.kind)):
        RuntimeError_CannotStoreKey(key, ":" & ($(value.kind)).toLowerAscii(), ($(store.kind)).replace("Store",""))

    ensureStoreIsLoaded(store)
    
    store.data[key] = value
    
    if store.autosave:
        saveStore(store, one=true, key=key)
    else:
        store.pending = true

#=======================================
# Initialization
#=======================================

proc initStore*(
    path: string, 
    doLoad: bool,
    forceExtension: bool = false,
    createIfNotExists: bool = true,
    forceCreate: bool = false,
    global: bool = false, 
    autosave: bool = false, 
    kind: StoreKind = UndefinedStore
): VStore =
    let (storeExists, storePath, storeKind) = checkStorePath(path, forceExtension, global, kind)

    result = VStore(
        path        : storePath,
        global      : global,
        loaded      : doLoad,
        autosave    : autosave,
        pending     : false,
        kind        : storeKind,
        forceLoad   : proc(store:VStore) =
            if not store.loaded:
                store.loadStore()
                store.loaded = true
    )

    if storeKind == SqliteStore:
        when not defined(NOSQLITE):
            result.db = openSqliteDb(storePath)
        else:
            RuntimeError_SqliteDisabled()

    if forceCreate or (createIfNotExists and (not storeExists)):
        result.createEmptyStoreOnDisk()
    
    if doLoad:
        result.loadStore(justCreated=not storeExists)

    if not autosave:
        Stores.add(result)