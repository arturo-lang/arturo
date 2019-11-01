#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: console.nim
  *****************************************************************]#

import algorithm, rdstdin, sequtils, strformat, strutils, sugar, terminal
import compiler, panic, version

const
    CONSOLE_PROMPT_HEAD =  "$ :" #"\x1B[38;5;208m\x1B[1m$ :"
    CONSOLE_PROMPT_TAIL =  "> " #"\x1B[0m\x1B[38;5;208m\x1B[1m>\x1B[0m "

    CONSOLE_INSTRUCTION = "\x1B[38;5;208m# Launching interactive console; Rock on.\n" &
                          "# Type '?help' for help on console commands\x1B[0m\n"

    CONSOLE_EXIT_MSG    = "# Exiting interactive console\n"

    CONSOLE_HELP_TXT    = readFile("src/rsrc/console_help.txt").replace("\\e","\e")

#[######################################################
    Helper functions
  ======================================================]#

proc getPrompt(line: int):string =
    return CONSOLE_PROMPT_HEAD & fmt"{line:03}" & CONSOLE_PROMPT_TAIL

proc showInfo(symbol: string) =
    let sysFunc = getSystemFunction(symbol)
    if sysFunc!=(-1):
        echo SystemFunctions[sysFunc].getFullDescription()
    elif Stack[0].hasKey(symbol):
        let k = $((Stack[0].getValueForKey(symbol)).kind)
        echo "Symbol : \e[1m" & symbol & "\e[0m"
        echo "       = \e[34m(" & k.replace("Value","") & ")\e[39m " & (Stack[0].getValueForKey(symbol)).stringify() 
    else:
        consoleError("symbol '" & symbol & "' not found")

proc showSymbols() = 
    for n in sorted(Stack[0].keys):
        let k = $((Stack[0].getValueForKey(n)).kind)
        echo alignLeft("\e[1m" & n & "\e[0m",20) & align("\e[34m" & k.replace("Value","") & "\e[39m",20) & " = " & (Stack[0].getValueForKey(n)).stringify()

proc showFunctions() =
    let names = SystemFunctions.map((x) => x.name)
    for n in names:
        echo SystemFunctions[getSystemFunction(n)].getOneLineDescription()

proc showHelp() =
    echo CONSOLE_HELP_TXT

proc doRead(filePath: string) =
    let input = readFile(filePath)
    echo "\e[2m= " & runString(input) & "\e[22m"

proc doWrite(filePath: string, fileSrc: string) = 
    writeFile(filePath, fileSrc)

proc doClear() =
    eraseScreen()
    setCursorPos(0,0)
    flushFile(stdout)

proc doExit() = 
    echo CONSOLE_EXIT_MSG
    quit()


#[######################################################
    Methods
  ======================================================]#

proc startRepl*() = 
    showVersion()

    compiler.setup()

    echo CONSOLE_INSTRUCTION

    var currentLine = 1
    var currentExpression = ""

    var source = ""

    while true:
        try:
            currentExpression = readLineFromStdin(getPrompt(currentLine)).strip

            if currentExpression.startsWith("?"):
                let parts = currentExpression.split(" ")
                case parts[0]
                    of "?info": showInfo(parts[1])
                    of "?symbols": showSymbols()
                    of "?functions": showFunctions()
                    of "?read": doRead(parts[1])
                    of "?write": doWrite(parts[1],source)
                    of "?clear": doClear()
                    of "?help": showHelp()
                    of "?exit": doExit()
                    else: consoleError("command '" & parts[0] & "' not found")
            
            else: 
                echo "\e[2m= " & runString(currentExpression) & "\e[22m"
                source &= currentExpression & "\n"
                inc(currentLine)

        except IOError:
            continue
    