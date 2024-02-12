#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: library/Converters.nim
#=======================================================

## The main Converters module
## (part of the standard library)

#=======================================
# Pragmas
#=======================================

{.used.}

#=======================================
# Libraries
#=======================================

import sequtils, strformat

import helpers/datasource

when not defined(NOASCIIDECODE):
    import helpers/strings

import vm/lib
import vm/[bytecode, errors, opcodes, parse]

import vm/values/printable

#=======================================
# Definitions
#=======================================

# TODO(Converters) resolving `from`/`to`/`as` clutter?
#  Right now, we have 4 different built-in function performing different-but-similar actions.
#  Is there any way to remove all ambiguity - by either reducing them, merging them, extending them or explaining their functionality more thoroughly?
#  labels: library, enhancement, open discussion, documentation

proc defineLibrary*() =

    #----------------------------
    # Functions
    #----------------------------

    # TODO(Converters\as) is `.unwrapped` working as expected?
    #  labels: library, bug

    # TODO(Converters\as) do we really need this?
    #  judging from the options, we have 3 that are number related:
    #  `.binary`, `.hex`, `.octal` (and they are identical as the
    #  option for `from`; only doing the reverse operation), we have
    #  one that converts a string to ascii (!) - this could go as a 
    #  separate function into the Strings module? - and the rest of
    #  the options are pretty much code-related: `.code`, `.pretty`,
    #  & `.unwrapped` are for converting a value to Arturo code 
    #  (could also become one separate function) and `.data` works
    #  like a Collections/dictionary option (it does return a dictionary,
    #  doesn't it - not sure!). Sure thing is, we should either eliminate
    #  this module altogether, or rename it, and/or split the existing functions
    #  into different sub-functions, and/or distribute these sub-functions
    #  to different existing modules. (What am I writing here?! Who knows...)
    #  labels: library, cleanup, open discussion
    builtin "as",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "format given value as implied type",
        args        = {
            "value" : {Any}
        },
        attrs       = {
            "binary"    : ({Logical},"format integer as binary"),
            "hex"       : ({Logical},"format integer as hexadecimal"),
            "octal"     : ({Logical},"format integer as octal"),
            "agnostic"  : ({Logical},"convert words in block to literals, if not in context"),
            "data"      : ({Logical},"parse input as Arturo data block"),
            "code"      : ({Logical},"convert value to valid Arturo code"),
            "pretty"    : ({Logical},"prettify generated code"),
            "unwrapped" : ({Logical},"omit external block notation")
        },
        returns     = {Any},
        example     = """
            print as.binary 123           ; 1111011
            print as.octal 123            ; 173
            print as.hex 123              ; 7b
        """:
            #=======================================================
            if (hadAttr("binary")):
                push(newString(fmt"{x.i:b}"))
            elif (hadAttr("hex")):
                push(newString(fmt"{x.i:x}"))
            elif (hadAttr("octal")):
                push(newString(fmt"{x.i:o}"))
            elif (hadAttr("agnostic")):
                let res = x.a.map(proc(v:Value):Value =
                    if v.kind == Word and not SymExists(v.s): newLiteral(v.s)
                    else: v
                )
                push(newBlock(res))
            elif (hadAttr("data")):
                if xKind==Block:
                    push(parseDataBlock(x))
                elif xKind==String:
                    let (src, _) = getSource(x.s)
                    push(parseDataBlock(doParse(src, isFile=false)))
            elif (hadAttr("code")):
                push(newString(codify(x,pretty = (hadAttr("pretty")), unwrapped = (hadAttr("unwrapped")), safeStrings = (hadAttr("safe")))))
            else:
                push(x)

    # TODO(Converters\from) Do we really need this?
    #  We can definitely support hex/binary literals, but how would we support string to number conversion? Perhaps, with `.to` and option?
    #  With a different function altogether?
    #  It's basically rather confusing...
    #  labels: library, cleanup, enhancement, open discussion

    # TODO(Converters\from) revise use of `.opcode`
    #  labels: library, enhancement, open discussion
    builtin "from",
        alias       = unaliased,
        op          = opNop,
        rule        = PrefixPrecedence,
        description = "get value from string, using given representation",
        args        = {
            "value" : {String,Literal}
        },
        attrs       = {
            "binary"    : ({Logical},"get integer from binary representation"),
            "hex"       : ({Logical},"get integer from hexadecimal representation"),
            "octal"     : ({Logical},"get integer from octal representation"),
            "opcode"    : ({Logical},"get opcode by from opcode literal")
        },
        returns     = {Any},
        example     = """
            print from.binary "1011"        ; 11
            print from.octal "1011"         ; 521
            print from.hex "0xDEADBEEF"     ; 3735928559
            ..........
            from.opcode 'push1
            => 33
        """:
            #=======================================================
            if (hadAttr("binary")):
                try:
                    push(newInteger(parseBinInt(x.s)))
                except ValueError:
                    push(VNULL)
            elif (hadAttr("hex")):
                try:
                    push(newInteger(parseHexInt(x.s)))
                except ValueError:
                    push(VNULL)
            elif (hadAttr("octal")):
                try:
                    push(newInteger(parseOctInt(x.s)))
                except ValueError:
                    push(VNULL)
            elif (hadAttr("opcode")):
                push(newInteger(int(parseOpcode(x.s))))
            else:
                push(x)

#=======================================
# Add Library
#=======================================

Libraries.add(defineLibrary)
