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
        # make necessary substitutions
        result = "««" & result.replace("<||=","<|| to :string ")
                              .replace("||>","««")
                              .replace("<||","»»") & "»»"

        # parse string template
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

