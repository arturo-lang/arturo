######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: library/Shell.nim
######################################################

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import os, osproc, sequtils, sugar

import vm/[common, errors, exec, globals, stack, value]

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: System"

    builtin "ensure",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "assert given condition is true, or exit",
        args        = {
            "condition"     : {Block}
        },
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            num: input "give me a positive number"

            ensure [num > 0]

            print "good, the number is positive indeed. let's continue..."
        """:
            ##########################################################
            discard execBlock(x)
            if not stack.pop().b:
                AssertionError_AssertionFailed(x.codify())

    builtin "env",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get environment variables",
        args        = NoArgs,
        attrs       = NoAttrs,
        returns     = {Dictionary},
        # TODO(System\env) add example for documentation 
        #  labels: documentation,easy,library
        example     = """
        """:
            ##########################################################
            var res: ValueDict = initOrderedTable[string,Value]()

            for k,v in envPairs():
                res[k] = newString(v)

            stack.push(newDictionary(res)) 

    builtin "execute",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "execute given shell command",
        args        = {
            "command"   : {String}
        },
        attrs       = NoAttrs,
        returns     = {String},
        example     = """
            print execute "pwd"
            ; /Users/admin/Desktop
            
            split.lines execute "ls"
            ; => ["tests" "var" "data.txt"]
        """:
            ##########################################################
            let res = execCmdEx(x.s)
            
            stack.push(newString(res[0]))

    builtin "exit",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "exit program",
        args        = NoArgs,
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            exit              ; (terminates the program)
            
            exit.with: 3      ; (terminates the program with code 3)
        """:
            ##########################################################
            quit()

    builtin "list",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "get files with given pattern",
        args        = {
            "pattern"   : {String}
        },
        attrs       = NoAttrs,
        returns     = {Block},
        example     = """
            loop list "*" 'file [
            ___print file
            ]
            
            ; tests
            ; var
            ; data.txt
        """:
            ##########################################################
            var contents: seq[string] = toSeq(walkPattern(x.s))
            stack.push(newStringBlock(contents))

    builtin "panic",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "exit program with error message",
        args        = {
            "message"   : {String}
        },
        attrs       = {
            "code"  : ({Integer},"return given exit code")
        },
        returns     = {Boolean},
        example     = """
            panic.code:1 "something went terribly wrong. quitting..."
        """:
            ##########################################################
            vmPanic = true
            vmError = x.s

            # TODO Fix showVMErrors()

            if (let aCode = popAttr("code"); aCode != VNULL):
                quit(aCode.i)
            else:
                quit()    

    builtin "pause",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "pause program's execution~for the given amount of milliseconds",
        args        = {
            "time"  : {Integer}
        },
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            print "wait a moment"

            pause 1000      ; sleeping for one second

            print "done. let's continue..."
        """:
            ##########################################################
            sleep(x.i)

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)