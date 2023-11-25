
import std/sugar
import std/macros

var flags*: seq[string] = newSeqOfCap[string](64)
    ## flags represent the flags that will be passed to the compiler.
    ##
    ## Initialize a sequence of initial 64 slots,
    ## what help us to append elements without lose performance.

## `filter`_, `stripStr`_, `--`_ and `---`_ are inspired by the
## original ones from Nim's STD lib, by 2015 Andreas Rumpf.

proc filter(content: string, condition: (char) -> bool): string =
    result = newStringOfCap content.len
    for c in content:
        if c.condition:
            result.add c

proc stripStr(content: string): string =
    result = content.filter: (x: char) =>
        x notin {' ', '\c', '\n'}

    if result[0] == '"' and result[^1] == '"':
        result = result[1..^2]

template `--`*(key: untyped) {.dirty.} =
    ## Overrides the original ``--`` to append values into ``flags``,
    ## instead of pass direclty to the compiler.
    ## Since this isn't the config.nims file.
    flags.add("--" & stripStr(astToStr(key)))

template `--`*(key, val: untyped) {.dirty.} =
    ## Overrides the original ``--`` to append values into ``flags``,
    ## instead of pass direclty to the compiler.
    ## Since this isn't the config.nims file.
    flags.add("--" & stripStr(astToStr(key)) & ":" & stripStr(astToStr(val)))

template `---`*(key: untyped, val: string): untyped =
    ## A simple modification of `--` for string values.
    flags.add("--" & stripStr(astToStr(key)) & ":" & val)