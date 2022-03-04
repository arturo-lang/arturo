######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/csv.nim
######################################################

#=======================================
# Libraries
#=======================================

import parsecsv, streams, tables

import vm/values/value

#=======================================
# Methods
#=======================================

proc parseCsvInput*(input: string, withHeaders: bool = false): Value =
    var x: CsvParser
    var s = newStringStream(input)

    var rows: ValueArray = @[]

    if not withHeaders:
        open(x, s, "")
        while readRow(x):
            var row: ValueArray = @[]

            for val in items(x.row):
                row.add(newString(val))

            rows.add(newBlock(row))
    else:
        open(x, s, "")
        readHeaderRow(x)
        while readRow(x):
            var row: ValueDict = initOrderedTable[string,Value]()

            for col in items(x.headers):
                row[col] = newString(x.rowEntry(col))

            rows.add(newDictionary(row))

    return newBlock(rows)
