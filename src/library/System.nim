#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2025 Yanis Zafirópulos
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
# Definitions
#=======================================

proc defineModule*(moduleName: string) =

    #----------------------------
    # Functions
    #----------------------------

    builtin "arg",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get command-line arguments as a list",
        args        = NoArgs,
        attrs       = NoAttrs,
        returns     = {Block},
        example     = """
            ; called with no parameters
            arg         ; => []

            ; called with: 1 two 3
            arg         ; => ["1" "two" "3"]
        """:
            push(getCmdlineArgumentArray())

    builtin "args",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get all command-line arguments parsed as a dictionary",
        args        = NoArgs,
        attrs       = NoAttrs,
        returns     = {Dictionary},
        example     = """
            ; called with: 1 two 3
            args         
            ; => #[
            ;     1 
            ;     "two"
            ;     3
            ; ]
            ..........
            ; called with switches: -c -b
            args 
            ; => #[
            ;     c : true
            ;     b : true
            ;     values: []
            ; ]

            ; called with switches: -c -b and values: 1 two 3
            args
            ; => #[
            ;     c : true
            ;     b : true
            ;     values: [1 "two" 3]
            ; ]
            ..........
            ; called with named parameters: -c:2 --name:newname myfile.txt
            args
            ; => #[
            ;     c : 2
            ;     name : "newname"
            ;     values: ["myfile.txt"]
            ; ]
        """:
            push(newDictionary(parseCmdlineArguments()))

    when not defined(WEB):

        builtin "config",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "get local or global configuration",
            args        = NoArgs,
            attrs       = NoAttrs,
            returns     = {Store},
            example     = """
                ; `config` searches for `config.art` into your current directory. 
                ; if not found, it returns from `~/.arturo/stores/config.art`

                config
                ; => []
                ; `config.art` is empty at first, but we can change this manually

                write.append path\home ++ normalize ".arturo/stores/config.art" 
                             "language: {Arturo}"
                config
                ; => []
                
                ; this stills empty, but now try to relaunch Arturo:
                exit
                ......................
                config
                ; => [language:Arturo]

            """:
                push(Config)

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
                when defined(SAFE): Error_OperationNotPermitted("env")
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
            ......................
            execute.args: ["-s"] "ls"
            ; => total 15
            ; 0 aoc
            ; 0 architectures
            ; 4 bundle
            ; 0 cave
            ; 4 cmd.c
            ; 1 expr.art
            ; 0 galilee
            ; 4 generic_klist.c
            ; 1 jquery.js
            ; 0 shell
            ; 1 test.art
            ......................
            execute.code "ls"
            ; => [output:aoc
            ; architectures
            ; bundle
            ; cave
            ; cmd.c
            ; expr.art
            ; galilee
            ; generic_klist.c
            ; jquery.js
            ; shell
            ; test.art
            ; code:0]
            ......................
            ; This prints the output directly
            ; And only returns the exit code.
            execute.code.directly "ls"
            aoc            bundle  cmd.c     galilee          jquery.js  test.art
            architectures  cave    expr.art  generic_klist.c  shell
            => 0
            """:
                #=======================================================
                when defined(SAFE): Error_OperationNotPermitted("execute")

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
            "code"      : ({Integer},"return given exit code (default: 1)"),
            "unstyled"  : ({Logical},"don't use default error template")
        },
        returns     = {Logical},
        example     = """
            panic.unstyled "oops! that was wrong"
            ; quits with the default exit code (= 1) and
            ; just outputs a simple - unformatted - message
            ..........
            panic.code:0 "something went terribly wrong. quitting..."
            ; quits without an error code but still
            ; prints a properly formatted error with the given message
        """:
            #=======================================================
            var code = 1
            if checkAttr("code"):
                code = aCode.i

            when not defined(WEB):
                savePendingStores()

            if (hadAttr("unstyled")):
                echo $(x)
                quit(code)
            else:
                ProgramError_panic(x.s.replace("\n",";"), code)

    builtin "path",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get path information",
        args        = NoArgs,
        attrs       = NoAttrs,
        returns     = {Dictionary},
        example     = """
        path
        ; => [current:C:\Users\me\my-proj home:C:\Users\me\ temp:C:\Users\me\AppData\Local\Temp\
        """:
            #=======================================================
            push(newDictionary(getPathInfo()))

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
            print "waiting for 2 seconds"

            pause 2:s       ; let's sleep for a while

            print "done!"
            """:
                #=======================================================
                if xKind == Integer:
                    sleep(x.i)
                else:
                    sleep(toInt((x.q.convertTo(parseAtoms("ms"))).original))

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
                    "free": newQuantity(toQuantity(getFreeMem(), parseAtoms("B"))),
                    "total": newQuantity(toQuantity(getTotalMem(), parseAtoms("B")))
                    #"max": newQuantity(newInteger(getMaxMem()), B)
                }.toOrderedTable)

                push newDictionary(ret)

    # TODO(System\script) verify it's working properly & potentially re-implement
    #  Right now, it picks script-comments from the entire script, but these are not accessible from an included script, nor from the includer. 
    #  So, its current usefulness is very much doubtable.
    #  labels: library, enhancement, open discussion

    # TODO(System\script) also add information about the current script being executed
    #  another location could also be Paths/path
    #  labels: library,enhancement

    builtin "script",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get embedded information about the current script",
        args        = NoArgs,
        attrs       = NoAttrs,
        returns     = {Dictionary},
        example     = """
            ;; author: {Me :P}
            ;; year: 2023
            ;; license: Some License
            ;; 
            ;; description: {
            ;;      This is an example of documentation.
            ;;
            ;;      You can get this by using ``script``.
            ;; }
            ;;
            ;; hint: {
            ;;      Notice that we use `;;` for documentation,
            ;;      while the single `;` is just a comment, 
            ;;      that will be ignored.   
            ;; }
            ;;
            ;; export: [
            ;;    'myFun
            ;;    'otherFun
            ;;    'someConst
            ;; ]
            ;;

            inspect script
            ; [ :dictionary
            ;         author       :        Me :P :string
            ;         year         :        2023 :integer
            ;         license      :        [ :block
            ;                 Some :string
            ;                 License :string
            ;         ]
            ;         description  :        This is an example of documentation.
            ;  
            ; You can get this by using ``script``. :string
            ;         hint         :        Notice that we use `;;` for documentation,
            ; while the single `;` is just a comment, 
            ; that will be ignored. :string
            ;         export       :        [ :block
            ;                 myFun :string
            ;                 otherFun :string
            ;                 someConst :string
            ;         ]
            ; ]
        """:
            push(getScriptInfo())

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
            ;        author     :        Yanis Zafirópulos :string
            ;        copyright  :        (c) 2019-2025 :string
            ;        version    :        0.9.84-alpha+3126 :version
            ;        built      :        [ :date
            ;                hour        :                16 :integer
            ;                minute      :                19 :integer
            ;                second      :                25 :integer
            ;                nanosecond  :                0 :integer
            ;                day         :                12 :integer
            ;                Day         :                Wednesday :string
            ;                days        :                163 :integer
            ;                month       :                6 :integer
            ;                Month       :                June :string
            ;                year        :                2024 :integer
            ;                utc         :                -7200 :integer
            ;        ]
            ;        deps       :        [ :dictionary
            ;                gmp     :                6.3.0 :version
            ;                mpfr    :                4.2.1 :version
            ;                sqlite  :                3.39.5 :version
            ;                pcre    :                8.45.0 :version
            ;        ]
            ;        binary     :        /Users/drkameleon/.arturo/bin/arturo :string
            ;        cpu        :        [ :dictionary
            ;                arch    :                amd64 :literal
            ;                endian  :                little :literal
            ;                cores   :                8 :integer
            ;        ]
            ;        os         :        macos :string
            ;        hostname   :        drkameleons-MBP.home :string
            ;        release    :        full :literal
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
                if (let activeProcess = ActiveProcesses.getOrDefault(pid, nil); not activeProcess.isNil()):
                    # terminate the process
                    terminate(activeProcess)

                    # close it
                    close(activeProcess)

                    # and remove it from the table
                    ActiveProcesses.del(pid)
                else:
                    # if it's an external process,
                    # proceed with its termination
                    when defined(windows):
                        discard terminateProcess(pid, errCode)
                    else:
                        sendSignal(int32(pid), errCode)

    #----------------------------
    # Predicates
    #----------------------------

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

