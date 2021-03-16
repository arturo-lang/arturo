######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: helpers/templates.nim
######################################################

#=======================================
# Libraries
#=======================================

import re, sequtils, strutils, tables
import nre except toSeq

import vm/[exec, parse, stack, value]

#=======================================
# Constants
#=======================================

var
    Interpolated    = nre.re"\|([^\|]+)\|"
    Embeddable      = re.re"(?s)(\<\|\|.*?\|\|\>)"

#=======================================
# Helpers
#=======================================

proc renderInterpolated(s: string, recursive: bool, useReference: bool, reference: ValueDict): string =
    result = s

    var keepGoing = true
    if recursive: 
        keepGoing = result.find(Interpolated).isSome

    while keepGoing:
        result = result.replace(Interpolated, proc (match: RegexMatch): string =
                        discard execBlock(doParse(match.captures[0], isFile=false))
                        $(stack.pop())
                    )

        # if recursive, check if there's still more embedded tags
        # otherwise, break out of the loop
        if recursive: keepGoing = result.find(Interpolated).isSome
        else: keepGoing = false

# TODO renderTemplate does not respect newlines in multi-line input
#  check `templates.art` for the inconsistency
proc renderTemplate(s: string, recursive: bool, useReference: bool, reference: ValueDict): string =
    result = s

    var keepGoing = true
    if recursive: 
        keepGoing = result.contains(Embeddable)

    while keepGoing:

        # # split input by tags
        # var splitted = result.split(Embeddable)

        # var blk: seq[string] = @[]

        # # go through the token one-by-one
        # for i,spl in splitted:

        #     if spl.match(Embeddable).isNone:
        #         # if it's not an embedded tag,
        #         # added as a string - split by lines
        #         blk.add(codify(newString(spl), safeStrings=true))
        #         # let stripped = spl.strip()
        #         # if stripped != "" and (stripped[^1] in {'\r','\n'}):
        #         #         blk.add("\"\\n\"")
        #     else:
        #         # otherwise, clean it up
        #         var parseable = spl.strip(chars = {'<', '>', '|'})
        #         var output = false
        #         if parseable[0] == '=': 
        #             output = true
        #             parseable = parseable.strip(chars = {'='})

        #         # if it's a <|: something |> tag, stringify it
        #         if output:
        #             blk.add("to")
        #             blk.add(":string")

        #         blk.add(parseable)

        # let subscript = blk.join(" ")
        # let parsed = doParse(subscript, isFile=false)
        result = "««" & result.replace("<||=","<|| to :string ")
                              .replace("||>","««")
                              .replace("<||","»»") & "»»"

        # result = re.replace(re.replace(result, re.re"<\|=","<|to :string"),
        #                                        re.re"\|>(.*?)<\|","««$1»»")

        #echo result
        let parsed = doParse(result, isFile=false)

        # execute/reduce ('array') the resulting block
        let stop = SP
        discard execBlock(parsed)
        let arr: ValueArray = sTopsFrom(stop)
        SP = stop

        # and join the different strings
        result = arr.map(proc (v:Value):string = v.s).join()

        # if recursive, check if there's still more embedded tags
        # otherwise, break out of the loop
        if recursive: keepGoing = result.contains(Embeddable)
        else: keepGoing = false

#=======================================
# Methods
#=======================================

proc renderString*(s: string, useEngine: bool = false, recursive: bool = false, reference: ValueDict = initOrderedTable[string,Value]()): string =
    if useEngine:
        renderTemplate(s, recursive, (len(reference)>0), reference)
    else:
        renderInterpolated(s, recursive, (len(reference)>0), reference)

