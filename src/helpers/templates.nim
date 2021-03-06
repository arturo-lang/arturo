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

import sequtils, strutils, tables
import nre except toSeq

import vm/[exec, parse, stack, value]

#=======================================
# Constants
#=======================================

var
    Interpolated    = nre.re"\|([^\|]+)\|"
    Embeddable      = nre.re"(\<\|.*?\|\>)"

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

proc renderTemplate(s: string, recursive: bool, useReference: bool, reference: ValueDict): string =
    result = s

    var keepGoing = true
    if recursive: 
        keepGoing = result.find(Embeddable).isSome

    while keepGoing:
        # split input by tags
        var splitted = result.split(Embeddable)

        var blk: ValueArray = @[]

        # go through the token one-by-one
        for i,spl in splitted:

            if spl.match(Embeddable).isNone:
                # if it's not an embedded tag,
                # added as a string
                blk.add(newString(spl))
            else:
                # otherwise, clean it up
                var parseable = spl.strip(chars = {'<', '>', '|'})
                var output = false
                if parseable[0] == ':': 
                    output = true
                    parseable = parseable.strip(chars = {':'})

                # if it's a <|: something |> tag, stringify it
                if output:
                    blk.add(newWord("to"))
                    blk.add(newType("string"))

                # finally, parse it as a code block
                # and insert its sub-tokens one-by-one
                for item in doParse(parseable, isFile=false).a:
                    blk.add(item)

        # execute/reduce ('array') the resulting block
        let stop = SP
        discard execBlock(newBlock(blk))
        let arr: ValueArray = sTopsFrom(stop)
        SP = stop

        # and join the different strings
        result = arr.map(proc (v:Value):string = v.s).join()

        # if recursive, check if there's still more embedded tags
        # otherwise, break out of the loop
        if recursive: keepGoing = result.find(Embeddable).isSome
        else: keepGoing = false

#=======================================
# Methods
#=======================================

proc renderString*(s: string, useEngine: bool = false, recursive: bool = false, reference: ValueDict = initOrderedTable[string,Value]()): string =
    if useEngine:
        renderTemplate(s, recursive, (len(reference)>0), reference)
    else:
        renderInterpolated(s, recursive, (len(reference)>0), reference)

