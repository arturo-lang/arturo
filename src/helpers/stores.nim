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

import os, strutils, tables

import helpers/database
import helpers/io
import helpers/jsonobject

import vm/values/[printable, value]
import vm/[exec, globals, parse]

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

#=======================================
# Methods
#=======================================

proc saveStore*(store: VStore) =
    case store.kind:
        of NativeStore:
            var nativeData = codify(newDictionary(store.data),pretty = true)
            nativeData.delete(0..0)
            writeToFile(store.path, nativeData)
        of JsonStore:
            writeToFile(store.path, jsonFromValueDict(store.data, pretty=true))
        of SqliteStore:
            # TODO(Helpers/stores) should add support for auto-saving SQLite stores
            #  labels: bug, values
            discard
        else:
            discard

proc getStoreKey*(store: VStore, key: string): Value =
    GetKey(store.data, key)

proc setStoreKey*(store: VStore, key: string, value: Value) =
    store.data[key] = value
    
    if store.autosave:
        saveStore(store)

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
                result.data = execDictionary(doParse(storePath, isFile=true))
            of JsonStore:
                result.data = valueFromJson(readFile(storePath)).d
            of SqliteStore:
                # TODO(Helpers/stores) should add support for auto-loading SQLite stores
                #  labels: bug, values
                discard
            else:
                discard