#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: library/Shell.nim
#=======================================================

## The main System module 
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import os, osproc, sequtils, sugar

    when defined(windows):
        import winlean
    else:
        import std/posix_utils

when not defined(WEB):
    import helpers/stores

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

    # TODO(System) Convert constants to methods
    #  None of the supposed constants here is actually a constant.
    #  All of them return something that doesn't change on one hand,
    #  but that doesn't mean they should be considered as such.
    #  labels: library, enhancement

    constant "arg",
        alias       = unaliased,
        description = "access command-line arguments as a list":
            getCmdlineArgumentArray()

    constant "args",
        alias       = unaliased,
        description = "a dictionary with all command-line arguments parsed":
            newDictionary(parseCmdlineArguments())

    when not defined(WEB):
        
        constant "config",
            alias       = unaliased,
            description = "access global configuration":
                Config

        # TODO(System\env) could it be used for Web/JS builds too?
        #  and what type of environment variables could be served or would be useful serve?
        #  labels: library,enhancement,open discussion,web
        builtin "env",
            alias       = unaliased, 
            op          = opNop,
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
                #=======================================================
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
            op          = opNop,
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
                #=======================================================
                when defined(SAFE): RuntimeError_OperationNotPermitted("execute")

                # get arguments & options
                var cmd = x.s
                var args: seq[string]
                if checkAttr("args"):
                    args = aArgs.a.map((x) => (requireAttrValue("args", x, {String}); x.s))
                let code = (hadAttr("code"))
                let directly = (hadAttr("directly"))

                # TODO(System\execute) Fix handling of `.async`
                #  It currently "works" but in a very - very - questionable way.
                #  This has to be implemented properly.
                #  Also: having a globally-available array of "processes" makes things looking even worse.
                #  labels: library, enhancement, windows, linux, macos

                if (hadAttr("async")):
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
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "exit program",
        args        = NoArgs,
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            exit              ; (terminates the program)
        """:
            #=======================================================
            var errCode = QuitSuccess

            when not defined(WEB):
                savePendingStores()

            quit(errCode)

    builtin "panic",
        alias       = unaliased, 
        op          = opNop,
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
            #=======================================================
            var code = 0
            if checkAttr("code"):
                code = aCode.i

            when not defined(WEB):
                savePendingStores()

            if (hadAttr("unstyled")):
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
            op          = opNop,
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
                #=======================================================
                if xKind == Integer:
                    sleep(x.i)
                else:
                    sleep(asInt(convertQuantityValue(x.nm, x.unit.name, MS)))

        builtin "process",
            alias       = unaliased, 
            op          = opNop,
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
                #=======================================================
                var ret = initOrderedTable[string,Value]()

                ret["id"] = newInteger(getCurrentProcessId())
                ret["memory"] = newDictionary({
                    "occupied": newQuantity(toQuantity(getOccupiedMem(), parseAtoms("B"))),
                    "free": newQuantity(toQuantity(getFreeMem(), parseAtoms("B")))
                    "total": newQuantity(toQuantity(getTotalMem(), parseAtoms("B"))),
                    #"max": newQuantity(newInteger(getMaxMem()), B)
                }.toOrderedTable)

                push newDictionary(ret)

    # TODO(System\script) verify it's working properly & potentially re-implement
    #  Right now, it picks script-comments from the entire script, but these are not accessible from an included script, nor from the includer. 
    #  So, its current usefulness is very much doubtable.
    #  labels: library, enhancement, open discussion

    # TODO(System/script) also add information about the current script being executed
    #  another location could also be Paths/path
    #  labels: library,enhancement
    constant "script",
        alias       = unaliased,
        description = "embedded information about the current script":
            getScriptInfo()

    when not defined(WEB):
        builtin "superuser?",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "check if current user has administrator/root privileges",
            args        = NoArgs,
            attrs       = NoAttrs,
            returns     = {Logical},
            example     = """
            ; when running as root
            superuser?          ; => true

            ; when running as regular user
            superuser?          ; => false
            """:
                #=======================================================
                push newLogical(isAdmin())

    # TODO(System/sys) normalize the way CPU architecture is shown
    #  in our new release builds, we annotate x86_64/amd64 builds as "x86_64"
    #  here, our sys\cpu field would return "amd64"
    #
    #  obviously, we should normalize this, but we need to decide on a single name
    #  and then, we need to make sure that all our build scripts are using the same name
    #  labels: library, enhancement, open discussion
    builtin "sys",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get current system information",
        args        = NoArgs,
        attrs       = NoAttrs,
        returns     = {Dictionary},
        example     = """
            inspect sys
            ;[ :dictionary
            ;	author     :	Yanis Zafirópulos :string
            ;	copyright  :	(c) 2019-2022 :string
            ;	version    :	0.9.80 :version
            ;	build      :	3246 :integer
            ;	buildDate  :	[ :date
            ;		hour        :		11 :integer
            ;		minute      :		27 :integer
            ;		second      :		54 :integer
            ;		nanosecond  :		389131000 :integer
            ;		day         :		7 :integer
            ;		Day         :		Wednesday :string
            ;		days        :		340 :integer
            ;		month       :		12 :integer
            ;		Month       :		December :string
            ;		year        :		2022 :integer
            ;		utc         :		-3600 :integer
            ;	]
            ;	deps       :	[ :dictionary
            ;		gmp     :		6.2.1 :version
            ;		mpfr    :		4.1.0 :version
            ;		sqlite  :		3.37.0 :version
            ;		pcre    :		8.45.0 :version
            ;	] 
            ;	binary     :	/Users/drkameleon/OpenSource/arturo-lang/arturo/bin/arturo :string
            ;	cpu        :        [ :dictionary
            ;           arch    :                amd64 :literal
            ;           endian  :                little :literal
            ;   ]
            ; 	os         :	macosx :string
            ;   hostname   :    drkameleons-Mac.home :string
            ;  	release    :	full :literal
            ;]
        """:
            #=======================================================
            push newDictionary(getSystemInfo())

    when not defined(WEB):
        builtin "terminate",
            alias       = unaliased, 
            op          = opNop,
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
                #=======================================================
                var errCode = QuitSuccess
                let pid = x.i
                if checkAttr("code"):
                    errCode = aCode.i

                # check if it's a process that has been
                # created by us
                let activePID = ActiveProcesses.getOrDefault(pid, nil)
                if not activePID.isNil():
                    # close it
                    close(activePID)

                    # and remove it from the table
                    ActiveProcesses.del(pid)
                else:
                    # if it's an external process,
                    # proceed with its termination
                    when defined(windows):
                        discard terminateProcess(pid, errCode)
                    else:
                        sendSignal(int32(pid), errCode)

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)
