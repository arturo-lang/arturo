#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: library/Io.nim
#=======================================================

## The main Io module 
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import terminal

import algorithm, tables

when not defined(WEB):
    import helpers/repl
    import helpers/stores

import helpers/terminal as terminalHelper

import vm/lib
import vm/[eval, exec]
import vm/values/printable

when defined(WEB):
    var stdout: string = ""

    proc write*(buffer: var string, str: string) =
        buffer &= str
    
    proc flushFile*(buffer: var string) =
        echo buffer

#=======================================
# Methods
#=======================================

proc defineSymbols*() =

    builtin "clear",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "clear terminal",
        args        = NoArgs,
        attrs       = NoAttrs,
        returns     = {Nothing},
        example     = """
            clear             ; (clears the screen)
        """:
            #=======================================================
            clearTerminal()

    builtin "color",
        alias       = unaliased, 
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get colored version of given string",
        args        = {
            "color" : {Color},
            "string": {String}
        },
        attrs       = {
            "bold"      : ({Logical},"bold font"),
            "underline" : ({Logical},"show underlined"),
            "keep"      : ({Logical},"don't reset color at string end")
        },
        returns     = {String},
        example     = """
            print color #green "Hello!"                ; Hello! (in green)
            print color #red.bold "Some text"          ; Some text (in red/bold)
        """:
            #=======================================================
            var color = ""

            case x.l:
                of clBlack:
                    color = blackColor
                of clRed:
                    color = redColor
                of clGreen:
                    color = greenColor
                of clYellow:
                    color = yellowColor
                of clBlue:
                    color = blueColor
                of clMagenta:
                    color = magentaColor
                of clOrange:
                    color = rgb("208")
                of clCyan:
                    color = cyanColor
                of clWhite:
                    color = whiteColor
                of clGray:
                    color = grayColor
                else:
                    let rgba = RGBfromColor(x.l)
                    color = rgb((rgba.r, rgba.g, rgba.b))

            var finalColor: string

            if (hadAttr("bold")):
                finalColor = bold(color)
            elif (hadAttr("underline")):
                finalColor = underline(color)
            else:
                finalColor = fg(color)

            var res = finalColor & y.s

            if not hadAttr("keep"):
                res &= resetColor

            push(newString(res))
    
    when not defined(WEB):
        builtin "cursor",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "turn cursor visibility on/off",
            args        = {
                "visible"   : {Logical}
            },
            attrs       = NoAttrs,
            returns     = {Nothing},
            example     = """
            cursor false    ; (hides the cursor)
            cursor true     ; (shows the cursor)
            """:
                #=======================================================
                if isTrue(x):
                    stdout.showCursor()
                else:
                    stdout.hideCursor()

        builtin "goto",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "move cursor to given coordinates",
            args        = {
                "x"     : {Null,Integer},
                "y"     : {Null,Integer}
            },
            attrs       = NoAttrs,
            returns     = {Nothing},
            example     = """
            goto 10 15      ; (move cursor to column 10, line 15)
            goto 10 ø       ; (move cursor to column 10, same line)
            """:
                #=======================================================
                if xKind==Null:
                    if yKind==Null:
                        discard
                    else:
                        when defined(windows):
                            stdout.setCursorYPos(y.i)
                        else:
                            discard
                else:
                    if yKind==Null:
                        stdout.setCursorXPos(x.i)
                    else:
                        stdout.setCursorPos(x.i, y.i)

        builtin "input",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "print prompt and get user input",
            args        = {
                "prompt": {String}
            },
            attrs       = {
                "repl"      : ({Logical},"get input as if in a REPL"),
                "history"   : ({String},"set path for saving history"),
                "complete"  : ({Block},"use given array for auto-completions"),
                "hint"      : ({Dictionary},"use given dictionary for typing hints")
            },
            returns     = {String},
            example     = """
            name: input "What is your name? "
            ; (user enters his name: Bob)
            
            print ["Hello" name "!"]
            ; Hello Bob!
            ..........
            ; creating a simple REPL
            while [true][ 
                inp: input.repl 
                          .history: "myhistory.txt"
                          .complete:["Hello there", "Hello world!"] 
                          .hint:#[he: "perhaps you want to say hello?"] 
                          "## "

                print ["got:" inp] 
            ]
            ; will show a REPL-like interface, with arrow navigation enabled
            ; show previous entries with arrow-up, store entries in
            ; a recoverable file and also use autocompletions and hints
            ; based on give reference
            """:
                #=======================================================
                if (hadAttr("repl")):
                    # when defined(windows):
                    #     stdout.write(x.s)
                    #     stdout.flushFile()
                    #     push(newString(stdin.readLine()))
                    # else:
                    var historyPath: string
                    var completionsArray: ValueArray
                    var hintsTable: ValueDict = initOrderedTable[string,Value]()

                    if checkAttr("history"):
                        historyPath = aHistory.s

                    if checkAttr("complete"):
                        requireAttrValueBlock("complete", aComplete, {String,Word,Literal})
                        completionsArray = aComplete.a

                    if checkAttr("hint"):
                        hintsTable = aHint.d

                    let (str, hasToKill) = replInput(x.s, historyPath, completionsArray, hintsTable)
                    if hasToKill:
                        when not defined(WEB):
                            savePendingStores()

                        quit(0)
                    else:
                        push(newString(str))
                else:
                    stdout.write(x.s)
                    stdout.flushFile()
                    push(newString(stdin.readLine()))

    builtin "print",
        alias       = unaliased, 
        op          = opPrint,
        rule        = PrefixPrecedence,
        description = "print given value to screen with newline",
        args        = {
            "value" : {Any}
        },
        attrs       = {
            "lines" : ({Logical},"print each value in block in a new line"),
        },
        returns     = {Nothing},
        example     = """
            print "Hello world!"          ; Hello world!
        """:
            #=======================================================
            if xKind==Block:
                when defined(WEB):
                    stdout = ""

                let inLines = (hadAttr("lines"))

                let xblock = doEval(x)
                let stop = SP
                execUnscoped(xblock)

                var res: ValueArray
                while SP>stop:
                    res.add(pop())

                for r in res.reversed:
                    stdout.write($(r))
                    if not inLines: stdout.write(" ")
                    else: stdout.write("\n")

                if not inLines: stdout.write("\n")
                stdout.flushFile()
            else:
                echo $(x)

    builtin "prints",
        alias       = unaliased,
        op          = opNop, 
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
            #=======================================================
            when defined(WEB):
                stdout = ""

            if xKind==Block:
                let xblock = doEval(x)
                let stop = SP
                execUnscoped(xblock)

                var res: ValueArray
                while SP>stop:
                    res.add(pop())

                for r in res.reversed:
                    stdout.write($(r))
                    stdout.write(" ")

                stdout.flushFile()
            else:
                stdout.write($(x))
                stdout.flushFile()

    when not defined(WEB):
        builtin "terminal",
            alias       = unaliased, 
            op          = opNop,
            rule        = PrefixPrecedence,
            description = "get info about terminal",
            args        = NoArgs,
            attrs       = NoAttrs,
            returns     = {Dictionary},
            example     = """
            print terminal      ; [width:107 height:34]
            terminal\width      ; => 107
            """:
                #=======================================================
                let size = terminalSize()
                var ret = {
                    "width": newInteger(size[0]),
                    "height": newInteger(size[1])
                }.toOrderedTable()

                push(newDictionary(ret))

#=======================================
# Add Library
#=======================================

Libraries.add(defineSymbols)