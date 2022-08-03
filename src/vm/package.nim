######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/package.nim
######################################################

# TODO(VM/package) Needs thorough revision & testing
#  This looks - and is - very draft-ish. First, we have to see whether it's working at all. Then, probably re-write the whole thing from scratch...
#  labels: vm, package manager, unit-test

#=======================================
# Libraries
#=======================================

import algorithm, os, sequtils
import sets, sugar, tables

import helpers/jsonobject
import helpers/helper

import vm/[
    globals,
    parse,
    values/value,
    vm
]

#=======================================
# Helpers
#=======================================

func getWordsInBlock*(bl: Value): seq[string] =
    result = @[]
    for item in bl.a:
        case item.kind:
            of Block:
                result = concat(result, getWordsInBlock(item))
            of Word:
                result.add(item.s)
            else:
                discard

proc getUsedLibraryFunctions(code: Value): seq[string] =
    # make a test run
    # so that the Syms table is initialized
    var cd = ""
    discard run(cd, @[""], isFile=false)
    let declaredSyms = toSeq(keys(Syms))

    # recursively get all the words
    # in given code
    let uniqueWords = deduplicate(getWordsInBlock(code))

    # get only the common ones
    # that is: the words that *are* library functions/constants
    result = toSeq(intersection(toHashSet(declaredSyms), toHashSet(uniqueWords)).items)

    # and sort them
    result.sort()

func getUsedLibraryModules(funcs: seq[string]): seq[string] =
    result = deduplicate(funcs.map((f) => getInfo(f, Syms[f], Aliases)["module"].s))

    result.sort()

#=======================================
# Methods
#=======================================

proc showPackageInfo*(filepath: string) =
    let mainCode = doParse(filepath, isFile=true)
    var scriptData = mainCode.data.d

    var usedFunctions = getUsedLibraryFunctions(mainCode)
    if scriptData.hasKey("uses") and scriptData["uses"].kind==Block:
        for item in scriptData["uses"].a:
            usedFunctions.add(item.s)
        usedFunctions = usedFunctions.deduplicate().sorted()

    let usedModules = getUsedLibraryModules(usedFunctions)

    var package = initOrderedTable[string,Value]()
    if scriptData.hasKey("embed"):
        let mainPath = parentDir(joinPath(getCurrentDir(), filepath))
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
    scriptData["uses"] = newDictionary({
        "functions": newStringBlock(usedFunctions),
        "modules": newStringBlock(usedModules)
    }.toOrderedTable)

    if not scriptData.hasKey("compact"):
        scriptData["compact"] = newString("false")

    echo jsonFromValue(newDictionary(scriptData))
    