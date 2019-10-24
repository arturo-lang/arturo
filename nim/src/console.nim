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

import version

const
    CONSOLE_PROMPT_HEAD =  "$ :" #"\x1B[38;5;208m\x1B[1m$ :"
    CONSOLE_PROMPT_TAIL =  "> " #"\x1B[0m\x1B[38;5;208m\x1B[1m>\x1B[0m "

    CONSOLE_INSTRUCTION = "\x1B[38;5;208m# Launching interactive console; Rock on.\n" &
                          "# Type '?help' for help on console commands\x1B[0m\n"

#[========================================
   Helper functions
  ========================================]#

proc getPrompt(line: int):string =
    return CONSOLE_PROMPT_HEAD & fmt"{line:03}" & CONSOLE_PROMPT_TAIL

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

            case currentExpression
                of "?exit": quit()
                else: echo "got: " & currentExpression
    
            inc(currentLine)
        except IOError:
            continue
    
