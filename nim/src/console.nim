#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: console.nim
  *****************************************************************]#

import rdstdin
import strformat
import strutils
import terminal

import panic
import version

const
    CONSOLE_PROMPT_HEAD =  "$ :" #"\x1B[38;5;208m\x1B[1m$ :"
    CONSOLE_PROMPT_TAIL =  "> " #"\x1B[0m\x1B[38;5;208m\x1B[1m>\x1B[0m "

    CONSOLE_INSTRUCTION = "\x1B[38;5;208m# Launching interactive console; Rock on.\n" &
                          "# Type '?help' for help on console commands\x1B[0m\n"

    CONSOLE_EXIT_MSG    = "# Exiting interactive console\n"

    CONSOLE_HELP_TXT    = readFile("src/rsrc/console_help.txt").replace("\\e","\e")

#[========================================
   Helper functions
  ========================================]#

proc getPrompt(line: int):string =
    return CONSOLE_PROMPT_HEAD & fmt"{line:03}" & CONSOLE_PROMPT_TAIL

proc showInfo(symbol: string) =
    echo "showInfo: " & symbol

proc showSymbols() = 
    echo "showSymbols"

proc showFunctions() =
    echo "showFunctions"

proc showHelp() =
    echo CONSOLE_HELP_TXT

proc doRead(filePath: string) =
    echo "doRead: " & filePath

proc doWrite(filePath: string) = 
    echo "doWrite: " & filePath

proc doClear() =
    eraseScreen()
    setCursorPos(0,0)
    flushFile(stdout)

proc doExit() = 
    echo CONSOLE_EXIT_MSG
    quit()

proc doCompile(script: string): string = 
    return "=> " & script


#[========================================
   Methods
  ========================================]#

proc startRepl*() = 
    showVersion()
    echo CONSOLE_INSTRUCTION

    var currentLine = 1
    var currentExpression = ""

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
                    of "?write": doWrite(parts[1])
                    of "?clear": doClear()
                    of "?help": showHelp()
                    of "?exit": doExit()
                    else: consoleError("command '" & parts[0] & "' not found")
            
            else: 
                echo doCompile(currentExpression)
                inc(currentLine)

        except IOError:
            continue
    
