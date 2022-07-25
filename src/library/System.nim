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
    import os, osproc, sugar

    when defined(windows):
        import winlean
    else:
        import std/posix_utils
    
import sequtils

import helpers/quantities as QuantitiesHelper

import vm/lib
import vm/[env, errors]

#=======================================
# Variables
#=======================================

when not defined(WEB):

    var
        ActiveProcesses = initOrderedTable[int, Process]()

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
            attrs       = {
                "args"      : ({Block},"use given command arguments"),
                "async"     : ({Logical},"execute asynchronously as a process and return id"),
                "code"      : ({Logical},"return process exit code"),
                "directly"  : ({Logical},"execute command directly, as a shell command")  
            },
            returns     = {String, Dictionary},
            example     = """
            print execute "pwd"
            ; /Users/admin/Desktop
            
            split.lines execute "ls"
            ; => ["tests" "var" "data.txt"]
            """:
                ##########################################################
                when defined(SAFE): RuntimeError_OperationNotPermitted("execute")

                # get arguments & options
                var cmd = x.s
                var args: seq[string] = @[]
                if (let aArgs = popAttr("args"); aArgs != VNULL):
                    args = aArgs.a.map((x) => x.s)
                let code = (popAttr("code") != VNULL)
                let directly = (popAttr("directly") != VNULL)

                if (popAttr("async") != VNULL):
                    let newProcess = startProcess(command = cmd, args = args)
                    let pid = processID(newProcess)
                    
                    ActiveProcesses[pid] = newProcess
                    push newInteger(pid)
                else:
                    # add arguments, if any
                    for i in 0..high(args):
                        cmd.add(' ')
                        cmd.add(quoteShell(args[i]))

                    if directly:
                        let pcode = execCmd(cmd)

                        if code:
                            push(newInteger(pcode))
                        else:
                            discard
                    else:
                        # actually execute the command
                        let (output, pcode) = execCmdEx(cmd)

                        # return result, accordingly
                        if code:
                            push(newDictionary({
                                "output": newString(output),
                                "code": newInteger(pcode)
                            }.toOrderedTable))
                        else:
                            push(newString(output))

    builtin "exit",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "exit program",
        args        = NoArgs,
        attrs       = {
            "args"      : ({Integer},"use given error code"),
        },
        returns     = {Nothing},
        example     = """
            exit              ; (terminates the program)
            ..........
            exit.with: 3      ; (terminates the program with code 3)
        """:
            ##########################################################
            var errCode = QuitSuccess
            if (let aWith = popAttr("with"); aWith != VNULL):
                errCode = aWith.i

            quit(errCode)

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
            ..........
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
            description = "pause program's execution~for the given amount of time",
            args        = {
                "time"  : {Integer, Quantity}
            },
            attrs       = NoAttrs,
            returns     = {Nothing},
            example     = """
            print "wait a moment"

            pause 1000      ; sleeping for 1000ms = one second

            print "done. let's continue..."
            ..........
            print "waiting for 2 seconds

            pause 2:s       ; let's sleep for a while

            print "done!"
            """:
                ##########################################################
                if x.kind == Integer:
                    sleep(x.i)
                else:
                    sleep(asInt(convertQuantityValue(x.nm, x.unit.name, MS)))

        builtin "process",
            alias       = unaliased, 
            rule        = PrefixPrecedence,
            description = "get information on current process/program",
            args        = NoArgs,
            attrs       = NoAttrs,
            returns     = {Dictionary},
            example     = """
                print process\id
                ; 78046

                inspect process
                ; [ :dictionary
                ;       id      :	78046 :integer
                ;       memory  :	[ :dictionary
                ;           occupied  :		1783104 :integer
                ;           free      :		360448 :integer
                ;           total     :		2379776 :integer
                ;           max       :		2379776 :integer
                ;       ]
                ; ]
            """:
                ##########################################################
                var ret = initOrderedTable[string,Value]()

                ret["id"] = newInteger(getCurrentProcessId())
                ret["memory"] = newDictionary({
                    "occupied": newQuantity(newInteger(getOccupiedMem()), B),
                    "free": newQuantity(newInteger(getFreeMem()), B),
                    "total": newQuantity(newInteger(getTotalMem()), B),
                    "max": newQuantity(newInteger(getMaxMem()), B)
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

    when not defined(WEB):
        builtin "terminate",
            alias       = unaliased, 
            rule        = PrefixPrecedence,
            description = "kill process with given id",
            args        = {
                "id"    : {Integer}
            },
            attrs       = {
                "code"  : ({Integer},"use given error code"),
            },
            returns     = {Nothing},
            example     = """
                ; start process
                pid: execute.async "someProcessThatDoesSomethingInTheBackground"

                ; wait for 5 seconds
                pause 5000 

                ; terminate background process
                terminate pid
            """:
                ##########################################################
                var errCode = QuitSuccess
                let pid = x.i
                if (let aCode = popAttr("code"); aCode != VNULL):
                    errCode = aCode.i

                # check if it's a process that has been
                # created by us
                if ActiveProcesses.hasKey(pid):
                    # close it
                    close(ActiveProcesses[pid])

                    # and remove it from the table
                    ActiveProcesses.del(pid)
                else:
                    # if it's an external process,
                    # proceed with its termination
                    when defined(windows):
                        discard terminateProcess(pid, errCode)
                    else:
                        sendSignal((int32)pid, errCode)

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)