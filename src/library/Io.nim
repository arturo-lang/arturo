######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: library/Io.nim
######################################################

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import algorithm, rdstdin

when not defined(windows):
    import linenoise

import vm/[common, eval, exec, globals, stack, value]

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    when defined(VERBOSE):
        echo "- Importing: Io"

    when not defined(windows):
        builtin "clear",
            alias       = unaliased, 
            rule        = PrefixPrecedence,
            description = "clear terminal",
            args        = NoArgs,
            attrs       = NoAttrs,
            returns     = {Nothing},
            example     = """
                clear             ; (clears the screen)
            """:
                ##########################################################
                when not defined(windows):
                    clearScreen()
                else:
                    discard

    builtin "input",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "print prompt and get user input",
        args        = {
            "prompt": {String}
        },
        attrs       = NoAttrs,
        returns     = {String},
        example     = """
            name: input "What is your name? "
            ; (user enters his name: Bob)
            
            print ["Hello" name "!"]
            ; Hello Bob!
        """:
            ##########################################################
            stack.push(newString(readLineFromStdin(x.s)))


    builtin "print",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "print given value to screen with newline",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            print "Hello world!"          ; Hello world!
        """:
            ##########################################################
            if x.kind==Block:
                let xblock = doEval(x)
                let stop = SP
                discard doExec(xblock)#, depth+1)

                var res: ValueArray = @[]
                while SP>stop:
                    res.add(stack.pop())

                for r in res.reversed:
                    stdout.write($(r))
                    stdout.write(" ")

                stdout.write("\n")
                stdout.flushFile()
            else:
                echo $(x)

    builtin "prints",
        alias       = unaliased, 
        rule        = PrefixPrecedence,
        description = "print given value to screen",
        args        = {
            "value" : {Any}
        },
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            prints "Hello "
            prints "world"
            print "!"             
            
            ; Hello world!
        """:
            ##########################################################
            if x.kind==Block:
                let xblock = doEval(x)
                let stop = SP
                discard doExec(xblock)#, depth+1)

                var res: ValueArray = @[]
                while SP>stop:
                    res.add(stack.pop())

                for r in res.reversed:
                    stdout.write($(r))
                    stdout.write(" ")

                stdout.flushFile()
            else:
                stdout.write($(x))
                stdout.flushFile()

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)