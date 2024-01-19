
import "../../src/helpers/terminal.nim"
import std/strformat
import std/strutils

## Internal configuration
## ----------------------

NoColors = hostOS == "windows"

## Internal Functions
## ------------------

proc getShellRc(): string =
    ## will only be called on non-Windows systems -
    let (output, _) = gorgeEx("echo $SHELL")
    case output:
        of "/bin/zsh":
            result = "~/.zshrc"
        of "/bin/bash":
            result = "~/.bashrc or ~/.profile"
        of "/bin/sh":
            result = "~/.profile"
        else:
            result = "~/.profile"

func sep(ch: char = '='): string =
    return "".align(80, ch)

## Public Constants
## ----------------

let
    colors*: tuple = (
        gray: grayColor.fg,
        green: greenColor.bold,
        magenta: magentaColor.fg,
        red: redColor.fg
    )

    styles*: tuple = (
        clear: resetColor(),
        bold: bold()
    )

## Public Functions
## ----------------

proc log*(msg: string) =
    for line in msg.splitlines:
        echo colors.gray, "  ", line.dedent, styles.clear

proc warn*(msg: string) =
    echo colors.red, "  ", msg.dedent, styles.clear

proc panic*(msg: string = "", exitCode: int = QuitFailure) =
    warn msg
    quit exitCode

proc getLogo*(): seq[string] =
    return @[
        sep(),
        colors.green,
        r"                               _                                     ",
        r"                              | |                                    ",
        r"                     __ _ _ __| |_ _   _ _ __ ___                    ",
        r"                    / _` | '__| __| | | | '__/ _ \                   ",
        r"                   | (_| | |  | |_| |_| | | | (_) |                  ",
        r"                    \__,_|_|   \__|\__,_|_|  \___/                   ",
        r"{styles.clear}{styles.bold}                                          ".fmt,
        r"                     Arturo Programming Language{styles.clear}       ".fmt,
        r"                      (c)2024 Yanis Zafirópulos                      ",
        r"                                                                     ",
    ]

proc showHeader*(title: string) =
    echo sep()
    echo fmt" ► {title.toUpperAscii()}"
    echo sep()

proc section*(title: string) =
    echo fmt"{styles.clear}"
    echo sep('-')
    echo fmt" {colors.magenta}●{styles.clear} {title}"
    echo sep('-')

proc showFooter*() =
    echo fmt"{styles.clear}"
    echo sep()
    echo fmt" {colors.magenta}●{styles.clear}{colors.green} Awesome!{styles.clear}"
    echo sep()
    echo "   Arturo has been successfully built & installed!"
    if hostOS != "windows":
        echo ""
        echo "   To be able to run it,"
        echo "   first make sure its in your $PATH:"
        echo ""
        echo "          export PATH=$HOME/.arturo/bin:$PATH"
        echo ""
        echo fmt"   and add it to your {getShellRc()},"
        echo "   so that it's set automatically every time."
    echo ""
    echo "   Rock on! :)"
    echo sep()
    echo fmt"{styles.clear}"

proc showEnvironment*() =
    section "Checking environment..."

    log fmt"os: {hostOS}"
    log fmt"compiler: Nim v{NimVersion}"