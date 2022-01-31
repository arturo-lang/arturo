######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
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

when not defined(WEB):
    import os, osproc
    
import sequtils

import vm/lib
import vm/[env, errors]

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: System"

    constant "arg",
        alias       = unaliased,
        description = "access command-line arguments as a list":
            getCmdlineArgumentArray()

    constant "args",
        alias       = unaliased,
        description = "a dictionary with all command-line arguments parsed":
            newDictionary(parseCmdlineArguments())

    when not defined(WEB):
        # TODO(System\env) could it be used for Web/JS builds too?
        #  and what type of environment variables could be served or would be useful serve?
        #  labels: library,enhancement,open discussion,web
        builtin "env",
            alias       = unaliased, 
            rule        = PrefixPrecedence,
            description = "get environment variables",
            args        = NoArgs,
            attrs       = NoAttrs,
            returns     = {Dictionary},
            example     = """
            print env\SHELL
            ; /bin/zsh

            print env\HOME
            ; /Users/drkameleon

            print env\PATH
            ; /Users/drkameleon/.arturo/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            """:
                ##########################################################
                when defined(SAFE): RuntimeError_OperationNotPermitted("env")
                var res: ValueDict = initOrderedTable[string,Value]()

                for k,v in envPairs():
                    res[k] = newString(v)

                push(newDictionary(res)) 

    when not defined(WEB):
        # TODO(System\execute) make function work for Web/JS builds
        #  in that case, it could be an easy way of directly executing JavaScript code
        #  labels: library,enhancement,web
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
                when defined(SAFE): RuntimeError_OperationNotPermitted("execute")
                let res = execCmdEx(x.s)
                
                push(newString(res[0]))

    builtin "exit",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "exit program",
        args        = NoArgs,
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            exit              ; (terminates the program)
            ;;;;
            exit.with: 3      ; (terminates the program with code 3)
        """:
            ##########################################################
            quit()

    builtin "panic",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "exit program with error message",
        args        = {
            "message"   : {String}
        },
        attrs       = {
            "code"      : ({Integer},"return given exit code"),
            "unstyled"  : ({Logical},"don't use default error template")
        },
        returns     = {Logical},
        example     = """
            panic.code:1 "something went terribly wrong. quitting..."
            ; quits with the given code and 
            ; prints a properly format error with the given message
            ;;;;
            panic.unstyled "oops! that was wrong"
            ; quits with the default exit code (= 0) and
            ; just outputs a simple - unformatted - message
        """:
            ##########################################################
            var code = 0
            if (let aCode = popAttr("code"); aCode != VNULL):
                code = aCode.i

            if (popAttr("unstyled")!=VNULL):
                echo $(x)
                quit(code)
            else:
                ProgramError_panic(x.s.replace("\n",";"), code)

    when not defined(WEB):
        # TODO(System\pause) implement for Web/JS builds
        #  it could easily correspond to some type of javascript timeout
        #  labels: library,enhancement,web
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

        builtin "process",
            alias       = unaliased, 
            rule        = PrefixPrecedence,
            description = "get information on current process/program",
            args        = NoArgs,
            attrs       = NoAttrs,
            returns     = {Dictionary},
            # TODO(System\process) add library documentation
            #  labels: library,documentation,easy
            example     = """
            """:
                ##########################################################
                var ret = initOrderedTable[string,Value]()

                ret["id"] = newInteger(getCurrentProcessId())
                ret["memory"] = newDictionary({
                    "occupied": newInteger(getOccupiedMem()),
                    "free": newInteger(getFreeMem()),
                    "total": newInteger(getTotalMem()),
                    "max": newInteger(getMaxMem())
                }.toOrderedTable)

                push newDictionary(ret)

    constant "script",
        alias       = unaliased,
        description = "embedded information about the current script":
            getScriptInfo()

    constant "sys",
        alias       = unaliased,
        description = "information about the current system":
            newDictionary(getSystemInfo())

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)