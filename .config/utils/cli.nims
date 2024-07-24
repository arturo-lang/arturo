
import std/macros
import std/os
import std/sugar
import std/strformat
import std/strutils


type CLI* = object
    header*: seq[string]
    defaultCommand*: string
    availableCommands: seq[string]
    printed: bool

func args*(cli: CLI): seq[string] =
    return commandLineParams()

func command(cli: CLI): string =
    let args = cli.args
    result = if args.len <= 1:
        cli.defaultCommand
    elif args[1].startsWith("-"):
        cli.defaultCommand
    else:
        args[1]

var cliInstance* = CLI( 
    defaultCommand: "help",
    availableCommands: @["help", "--help"],
    header: @[""],
    printed: false
)

proc printHeader(cli: var CLI) =
    if cli.printed:
        return

    try:
        exec "clear"
    except:
        discard gorgeEx "cls"

    for line in cli.header:
        echo line
    cli.printed = true


template `==?`(a, b: string): bool =
    ## checks if ``a`` is similar to ``b``.
    0 == strutils.cmpIgnoreStyle(a.replace("-"), b.replace("-"))

proc `>>?`(element: string, container: openarray[string]): bool =
    ## Checks if an ``element`` is similar to some into a ``container``.
    result = false
    for el in container:
        if element ==? el:
            return true

proc getPositionalArg*(args: seq[string], pos: int): string =
    ## Gets an argument given some ``pos``.
    ## Quits, if the arg is a flag.
    let msg = "Missing possitional argument."
    if args.len < pos.succ:
        quit msg, QuitFailure
    elif args[pos].startsWith("-"):
        quit msg, QuitFailure
    else:
        return args[pos]

proc getOptionValue*(args: seq[string], cmd: string, default: string,
                     short: string = "", into: seq[string] = @[]): string =
    ## Gets an optional argument's value
    ## example, for ``--who rick``, the returned value will be ``rick``,
    ## otherwhise, if the flag is not found, it'll return the ``default``
    ##
    ## This procedure has side effects and ends the application if the user
    ## write something wrong.
    result = default

    template isFlag(arg: string): bool =
        arg.startsWith("-")

    template flagFound(arg: string): bool =
        arg in [fmt"-{short}", fmt"--{cmd}"]

    func hasMissingValue(args: seq[string], currIdx: int): bool =
        result = false
        if currIdx >= args.high:
            return true
        if args[currIdx.succ].isFlag():
            return true

    let allowGenericArgument: bool = into.len == 0

    for idx, arg in args:
        if not arg.isFlag() or not arg.flagFound():
            continue

        if args.hasMissingValue(idx):
            quit fmt"Missing value for --{cmd}.", QuitFailure

        let next = args[idx.succ]
        if allowGenericArgument or next >>? into:
            return next

        quit fmt"{next} isn't into {into} for --{cmd}.", QuitFailure


func hasFlag*(args: seq[string], cmd: string,
              short: string = ""): bool =
    ## Returns true if some flag was found
    result = false
    for arg in args:
        if not arg.startsWith("-"):
            continue
        if arg >>? [fmt"-{short}", fmt"--{cmd}"]:
            return true

proc hasCommand*(args: seq[string], cmd: string): bool =
    ## Returns true if some flag was found
    result = false
    for arg in args:
        if arg.startsWith("-"):
            continue
        if arg ==? cmd:
            return true
        
template match*(sample: string, body: untyped) =
    ## Usage
    ## -----
    ## ..code::
    ##      match input:
    ##        >> "amd-64", "amd", "x64", "x86-64":
    ##          --cpu:amd64
    ##        >> "arm", "arm-32":
    ##          --cpu:arm32
    ##          --define:bit32
    block matchBlock:

        template `>>`(elements: openarray[string], ibody: untyped) =
            if sample >>? elements:
                ibody
                break matchBlock

        body

macro implementationToStr(id: typed): string =
    id.getImpl.toStrLit

iterator getDocs(impl: string): string =
    ## Return the documentation of any implementation
    ##
    ## This iterates until the end of the documentation block.
    var found = false
    for line in impl.splitLines():
        var cleanline = line.strip()
        if cleanline.startsWith("##"):
            cleanline.removeprefix "##"
            cleanline.removeprefix " "
            yield cleanline 
            found = true
        # Don't iterate until the end of the implementation,
        # Just until the end of the impl's documentation
        elif found:
            break

template help(ident: typed, status: int) =
    ## Prints the documentation from a identifier.
    ##
    ## Params
    ## ------
    ## ident: typed
    ##      the identifier, can be any declared implementation.
    ##
    ## Usage
    ## -----
    ## ..code-block:: nim
    ##      help getOptionValue
    for line in ident.implementationToStr.getDocs():
        echo line
    quit status

proc writeTask(name, desc: string) =
    ## This is the original ``writeTask`` by (c) Copyright 2015 Andreas Rumpf
    ## Original source: https://github.com/nim-lang/Nim/blob/4793fc0fc137326c8441e33af514028bab7b82bc/lib/system/nimscript.nim#L357
    if desc.len > 0:
        var spaces = " "
        for i in 0 ..< 20 - name.len: spaces.add ' '
        echo name, spaces, desc

template cmd*(name: untyped; description: string; body: untyped): untyped =
    ## This is a modification of the original ``task`` by (c) Copyright 2015 Andreas Rumpf
    ## original source: https://github.com/nim-lang/Nim/blob/805b4e2dc2afddf7be27e32fe0543e4227b31f74/lib/system/nimscript.nim#L390
    ##
    ## Reason: ``task``s were not working with optional arguments,
    ## so I removed the ``getCommand``, and replaced it by paramStr(2)
    ## defined by ``command``
    proc `name Task`*() =
        body

    if cliInstance.command >>? ["--help"]:
        cliInstance.printHeader()
        writeTask(astToStr(name), description)
    elif cliInstance.command ==? astToStr(name):
        cliInstance.printHeader()
        if cliInstance.args.hasFlag("help", short="h"):
            help `name Task`, QuitSuccess
        else:
            cliInstance.availableCommands.add astToStr(name)
            `name Task`()


proc helpForMissingCommand*() =
    ## Checks if the typed command don't exists into the available ones.
    ## If they don't, call the `help` function.
    if cliInstance.command in cliInstance.availableCommands:
        return

    exec "nim ./build.nims help"