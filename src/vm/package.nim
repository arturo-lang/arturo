######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: vm/package.nim
######################################################

#=======================================
# Libraries
#=======================================

import os, sequtils, sugar, tables

import helpers/jsonobject

import vm/[
    parse,
    values/value
]

#=======================================
# Methods
#=======================================

proc showPackageInfo*(filepath: string) =
    let mainCode = doParse(filepath, isFile=true)
    var scriptData = mainCode.data.d
    var package = initOrderedTable[string,Value]()
    let mainPath = parentDir(joinPath(getCurrentDir(), filepath))
    if scriptData.hasKey("embed"):
        if scriptData["embed"].a[0].kind == Block:
            let paths = scriptData["embed"].a[0].a
            let permitted = scriptData["embed"].a[1].a.map((x)=>x.s)
            for path in paths:
                let searchPath = joinPath(mainPath, path.s)
                for subpath in walkDirRec(searchPath):
                    var (_, _, ext) = splitFile(subpath)
                    if ext in permitted:
                        package[relativePath(subpath, mainPath)] = newString(readFile(subpath))
        else:
            let paths = scriptData["embed"].a
            for path in paths:
                package[path.s] = newString(readFile(path.s))

    scriptData["embed"] = newDictionary(package)

    echo jsonFromValue(newDictionary(scriptData))
    