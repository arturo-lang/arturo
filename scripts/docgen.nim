#[****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: docs/docgen.nim
  *****************************************************************]#

import algorithm, bitops, hashes, json, lists, math, os, osproc, parseutils, re, sequtils
import strformat, strutils, sugar, tables, threadpool
import utils
import compiler
import bignum

var output:Table[string,seq[Table[string,string]]]
var exampleOutput:Table[string,string]

output = initTable[string,seq[Table[string,string]]]()
exampleOutput = initTable[string,string]()

#[######################################################
    Get functions & libraries
  ======================================================]#
echo "- Retrieving system functions..."

let names = SystemFunctions.map((x) => x.name)
var libs: seq[string]

for n in sorted(names):
    let libname = SystemFunctions[getSystemFunction(n)].lib
    if not libs.contains(libname):
        libs.add(libname)

echo "- Creating function pages..."

for l in sorted(libs):
    let libFuncs = SystemFunctions.filter((x) => x.lib == l)
    var funcs: seq[Table[string,string]]
    for lfunc in libFuncs:
        var example = ""
        let src = readFile("src/lib/system/" & l & ".nim").split("\n")
        var readExample = false
        for dline in src:
            if readExample:
                if not dline.contains("*******"):
                    example &= dline.replace("# ","") & "\n"
                else: 
                    break

            if dline.contains("# @example: " & lfunc.name):
                readExample = true

        funcs.add({
            "name":lfunc.name,
            "desc":lfunc.desc,
            "req":lfunc.req.map((x) => "(" & x.map((y) => ($y).valueKindToPrintable()).join(",") & ")").join(" / "),
            "ret":lfunc.ret.join(",").valueKindToPrintable(),
            "ex":example
        }.toTable)

    let src = readFile("src/lib/system/" & l & ".nim").split("\n")
    var desc = ""
    for dline in src:
        if dline.contains("* @description:"):
            desc = "Collection of functions for " & dline.replace("* @description:","").strip

    output[l & " | " & desc] = funcs

writeFile("docgen/library.json",$(%*output))

#######

let (examples,err) = execCmdEx("ls examples/rosetta/*.art")

var ind = 0
for ex in sorted(examples.split("\n")):
    let name = ex.replace(".art","").replace("examples/rosetta/").strip
    if not name.startsWith("_") and name.strip!="":
        ind = ind + 1

        let title = name.replacef(re("([A-Z])")," $1").strip.
                         replace(" A "," a ").
                         replace(" An ", " an ").
                         replace(" With ", " with ").
                         replace(" Your ", " your ").
                         replace(" And ", " and ").
                         replace(" The ", " the ").
                         replace(" Of ", " of ").
                         replace(" To ", " to ").
                         replace(".", " / ").
                         replace("  "," ")

        exampleOutput[name] = readFile(ex)

writeFile("docgen/examples.json",$(%*exampleOutput))
