#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: vm/parse.nim
#=======================================================

## This module contains the parser/lexer for the VM.
## 
## In general, the parser:
## - takes a string/text
## - parses the different tokens and returns a Block of
##   valid values (that can later be used in conjuction 
##   with e.g. the evaluator)
## 
## The main entry point is `doParse`.

# TODO(VM/parser) General cleanup needed
#  There are various pieces of commented-out code that make the final result pretty much illegible. Let's clean this up.
#  labels: vm, parser, cleanup

#=======================================
# Libraries
#=======================================

import lexbase, os, streams
import strutils, tables, unicode

import vm/[errors, profiler, values/value]
import vm/values/custom/[vquantity, vsymbol]

#=======================================
# Types
#=======================================

type
    Parser = object of BaseLexer
        value: string
        values: seq[ValueArray]
        symbol: VSymbol

#=======================================
# Constants
#=======================================

const
    LBracket                    = '['
    RBracket                    = ']'
    LParen                      = '('
    RParen                      = ')'
    LCurly                      = '{'
    RCurly                      = '}'

    Quote                       = '"'
    Colon                       = ':'
    Semicolon                   = ';'
    Dot                         = '.'
    Tick                        = '\''
    BackTick                    = '`'

    Backslash                   = '\\'
    Dash                        = '-'

    CR                          = '\c'
    LF                          = '\L'
    EOF                         = '\0'
    
    Tab                         = '\t'
    Whitespace                  = {' ', Tab}

    PermittedNumbers_Start      = {'0'..'9'}
    ScientificNotation          = PermittedNumbers_Start + {'+', '-'}
    ScientificNotation_Start    = {'e', 'E'}
    Symbols                     = {'~', '!', '@', '#', '$', '%', '^', '&', '*', '-', '=', '+', '<', '>', '/', '\\', '|', '?'}
    Letters                     = {'a'..'z', 'A'..'Z'}
    PermittedIdentifiers_Start  = Letters
    PermittedColorChars         = Letters + {'0'..'9'}
    PermittedIdentifiers_In     = PermittedColorChars + {'?'}
    
    SemVerExtra                 = Letters + PermittedNumbers_Start + {'+', '-', '.'}

#=======================================
# Forward declarations
#=======================================

proc doParse*(input: string, isFile: bool = true): Value
proc parseDataBlock*(blk: Value): Value 

#=======================================
# Templates
#=======================================

template Empty(s: var string): bool =
    s.len == 0

func addAnnotatedTokenToBlock(blok: var Value, token: Value, p: var Parser) {.enforceNoRaises.} =
    token.ln = uint32(p.lineNumber)
    blok.a.add(token)

template AddToken(token: untyped): untyped =
    topBlock.addAnnotatedTokenToBlock(token, p)

template LastToken(): untyped = 
    topBlock.a[^1]

template ReplaceLastToken(with: untyped): untyped =
    topBlock.a[^1] = with

#=======================================
# Helpers
#=======================================

# Error reporting

func getContext(p: var Parser, curPos: int): string =
    var i = curPos

    while i > 0 and p.buf[i] notin {CR,LF,'\n'}:
        result.add(p.buf[i])
        dec(i)

    result = reversed(result)
    let initial = i
    i = curPos+1

    while p.buf[i]!=EOF and p.buf[i] notin {CR,LF,'\n'}:
        result.add(p.buf[i])
        inc(i)

    result &= ";" & repeat("~%",6 + curPos-initial) & "_^_"

# Lexer/parser

template skip(p: var Parser, scriptStr: var string) =
  var pos = p.bufpos
  while true:
    case p.buf[pos]
        of Semicolon:
            inc(pos)
            if p.buf[pos]==Semicolon:
                inc(pos)
                while true:
                    scriptStr &= p.buf[pos]
                    case p.buf[pos]:
                        of EOF:
                            break
                        of CR:
                            pos = lexbase.handleCR(p, pos)
                            # when not defined(NOERRORLINES):
                            #     AddToken newNewline(p.lineNumber)
                            scriptStr &= "\n"
                            break
                        of LF:
                            pos = lexbase.handleLF(p, pos)
                            # when not defined(NOERRORLINES):
                            #     AddToken newNewline(p.lineNumber)
                            scriptStr &= "\n"
                            break
                        else:
                            inc(pos)
            else:
                while true:
                    case p.buf[pos]:
                        of EOF:
                            break
                        of CR:
                            pos = lexbase.handleCR(p, pos)
                            # when not defined(NOERRORLINES):
                            #     AddToken newNewline(p.lineNumber)
                            break
                        of LF:
                            pos = lexbase.handleLF(p, pos)
                            # when not defined(NOERRORLINES):
                            #     AddToken newNewline(p.lineNumber)
                            break
                        else:
                            inc(pos)
        of Whitespace:
            inc(pos)
        of CR:
            pos = lexbase.handleCR(p, pos)
            # when not defined(NOERRORLINES):
            #     AddToken newNewline(p.lineNumber)
        of LF:
            pos = lexbase.handleLF(p, pos)
            # when not defined(NOERRORLINES):
            #     AddToken newNewline(p.lineNumber)
        of '#':
            if p.buf[pos+1]=='!':
                inc(pos)
                while true:
                    case p.buf[pos]:
                        of EOF:
                            break
                        of CR:
                            pos = lexbase.handleCR(p, pos)
                            break
                        of LF:
                            pos = lexbase.handleLF(p, pos)
                            break
                        else:
                            inc(pos)
            else:
                break
        else:
            break
    
    p.bufpos = pos

template parseString(p: var Parser, stopper: char = Quote) =
    var pos = p.bufpos + 1
    var inCode = false
    let initialLine = p.lineNumber
    let initialPoint = p.bufpos
    while true:
        case p.buf[pos]:
            of EOF: 
                SyntaxError_UnterminatedString("", initialLine, getContext(p, initialPoint))
            of stopper:
                inc(pos)
                break
            of '|':
                add(p.value, '|')
                inc(pos)
                inCode = not inCode
            of '\\':
                if not inCode:
                    case p.buf[pos+1]
                        of '\\', '"', '\'', '/':
                            add(p.value, p.buf[pos+1])
                            inc(pos, 2)
                        of 'a':
                            add(p.value, '\a')
                            inc(pos, 2)
                        of 'b':
                            add(p.value, '\b')
                            inc(pos, 2)
                        of 'e':
                            add(p.value, '\e')
                            inc(pos, 2)
                        of 'f':
                            add(p.value, '\f')
                            inc(pos, 2)
                        of 'n', 'l':
                            add(p.value, '\L')
                            inc(pos, 2)
                        of 'r', 'c':
                            add(p.value, '\C')
                            inc(pos, 2)
                        of 't':
                            add(p.value, '\t')
                            inc(pos, 2)
                        of 'v':
                            add(p.value, '\v')
                            inc(pos, 2)
                        of 'x':
                            inc(pos, 2)
                            var xi = 0
                            let endpos = pos + 1
                            while pos <= endpos:
                                case p.buf[pos]
                                    of '0'..'9':
                                        xi = `shl`(xi, 4) or (ord(p.buf[pos]) - ord('0'))
                                        inc(pos)
                                    of 'a'..'f':
                                        xi = `shl`(xi, 4) or (ord(p.buf[pos]) - ord('a') + 10)
                                        inc(pos)
                                    of 'A'..'F':
                                        xi = `shl`(xi, 4) or (ord(p.buf[pos]) - ord('A') + 10)
                                        inc(pos)
                                    else:
                                        break
                            add(p.value, chr(xi))
                        else:
                            add(p.value, "\\")
                            add(p.value, p.buf[pos+1])
                            inc(pos, 2)
                else:
                    add(p.value, p.buf[pos])
                    inc(pos)
            of CR:
                var prepos = pos-1
                pos = lexbase.handleCR(p, pos)
                SyntaxError_NewlineInQuotedString(p.lineNumber-1, getContext(p, prepos))
            of LF:
                var prepos = pos-1
                pos = lexbase.handleLF(p, pos)
                SyntaxError_NewlineInQuotedString(p.lineNumber-1, getContext(p, prepos))
            else:
                add(p.value, p.buf[pos])
                inc(pos)

    p.bufpos = pos

template parseMultilineString(p: var Parser) =
    var pos = p.bufpos + 1
    while p.buf[pos]==Dash:
        inc(pos)
    
    while true:
        case p.buf[pos]:
            of CR:
                pos = lexbase.handleCR(p, pos)
                when not defined(windows):
                    add(p.value, LF)
                else:    
                    add(p.value, CR)
                    add(p.value, LF)
            of LF:
                pos = lexbase.handleLF(p, pos)
                when defined(windows):
                    add(p.value, CR)
                    add(p.value, LF)
                else:
                    add(p.value, LF)
            of EOF:
                break
            else:
                add(p.value, p.buf[pos])
                inc(pos)

    p.bufpos = pos

template parseCurlyString(p: var Parser) =
    var pos = p.bufpos + 1
    var curliesExpected = 1
    var verbatimString = false
    var regexString = false
    var regexFlags = ""
    if p.buf[pos]=='!':
        inc(pos)
        while p.buf[pos] in Letters:
            inc(pos)

    if p.buf[pos]==':':
        inc(pos)
        verbatimString = true
    elif p.buf[pos]=='/':
        inc(pos)
        regexString = true

    let initialLine = p.lineNumber
    let initialPoint = p.bufpos
    while true:
        case p.buf[pos]:
            of EOF: 
                SyntaxError_UnterminatedString("curly", initialLine, getContext(p, initialPoint))
            of LCurly:
                curliesExpected += 1
                add(p.value, p.buf[pos])
                inc(pos)
            of RCurly:
                if not verbatimString:
                    if curliesExpected==1:
                        inc(pos)
                        break
                    else:
                        curliesExpected -= 1
                        add(p.value, p.buf[pos])
                else:
                    add(p.value, p.buf[pos])
                inc(pos)
            of CR:
                pos = lexbase.handleCR(p, pos)
                when not defined(windows):
                    add(p.value, LF)
                else:    
                    add(p.value, CR)
                    add(p.value, LF)
            of LF:
                pos = lexbase.handleLF(p, pos)
                when defined(windows):
                    add(p.value, CR)
                    add(p.value, LF)
                else:
                    add(p.value, LF)
            of ':':
                if verbatimString:
                    if p.buf[pos+1]==RCurly:
                        inc(pos, 2)
                        break
                    else:
                        add(p.value, p.buf[pos])
                        inc(pos)
                else:
                    add(p.value, p.buf[pos])
                    inc(pos)
            of '\\':
                if regexString:
                    if p.buf[pos+1]=='/':
                        add(p.value, '/')
                        inc(pos, 2)
                    else:
                        add(p.value, '\\')
                        inc(pos)
                else:
                    add(p.value, p.buf[pos])
                    inc(pos)
            of '/':
                if regexString:
                    if p.buf[pos+1]==RCurly:
                        inc(pos,2)
                        break
                    elif p.buf[pos+1] in {'i','m','s'}:
                        add(regexFlags, p.buf[pos+1])
                        inc(pos,2)
                        while p.buf[pos] in {'i','m','s'}:
                            add(regexFlags, p.buf[pos])
                            inc(pos)
                        if p.buf[pos] != RCurly:
                            SyntaxError_UnterminatedString("regex", initialLine, getContext(p, initialPoint))
                        else:
                            inc(pos)
                            break
                    else:
                        add(p.value, p.buf[pos])
                        inc(pos)
                else:
                    add(p.value, p.buf[pos])
                    inc(pos)
            else:
                add(p.value, p.buf[pos])
                inc(pos)
    p.bufpos = pos

    if unlikely(p.buf[p.bufpos] == Colon):
        inc(p.bufpos)
        AddToken newLabel(p.value)
    else:
        if verbatimString:
            AddToken newString(p.value)
        elif regexString:
            AddToken newRegex(p.value, regexFlags)
        else:
            AddToken newString(p.value, dedented=true)

template parseFullLineString(p: var Parser) =
    var pos = p.bufpos + 2
    while true:
        case p.buf[pos]:
            of EOF: 
                break
            of CR:
                pos = lexbase.handleCR(p, pos)
                break
            of LF:
                pos = lexbase.handleLF(p, pos)
                break
            else:
                add(p.value, p.buf[pos])
                inc(pos)

    p.bufpos = pos

template parseSafeString(p: var Parser) =
    var pos = p.bufpos + 4
    while true:
        case p.buf[pos]:
            of EOF: 
                SyntaxError_UnterminatedString("", p.lineNumber, getContext(p, p.bufpos-2))
                break
            of CR:
                pos = lexbase.handleCR(p, pos)
                when not defined(windows):
                    add(p.value, LF)
                else:    
                    add(p.value, CR)
                    add(p.value, LF)
            of LF:
                pos = lexbase.handleLF(p, pos)
                when defined(windows):
                    add(p.value, CR)
                    add(p.value, LF)
                else:
                    add(p.value, LF)
            of '\194':
                if p.buf[pos+1]=='\187': # got »
                    if p.buf[pos+2]=='\194' and p.buf[pos+3]=='\187':
                        inc(pos, 4)
                        break
                    else:
                        add(p.value, p.buf[pos])
                        add(p.value, p.buf[pos+1])
                        inc(pos, 2)
                else:
                    add(p.value, p.buf[pos])
                    inc(pos)
            else:
                add(p.value, p.buf[pos])
                inc(pos)

    p.bufpos = pos

template parseIdentifier(p: var Parser, alsoAddCurrent: bool) =
    var pos = p.bufpos
    when alsoAddCurrent:
        add(p.value, p.buf[pos])
    inc(pos)
    while p.buf[pos] in PermittedIdentifiers_In:
        add(p.value, p.buf[pos])
        inc(pos)
    p.bufpos = pos

template parseNumber(p: var Parser) =
    var pos = p.bufpos
    while p.buf[pos] in Digits:
        add(p.value, p.buf[pos])
        inc(pos)

    var hasDot{.inject.} = false

    if p.buf[pos] == Dot:
        if p.buf[pos+1] != Dot:
            hasDot = true

            add(p.value, Dot)
            inc(pos)
    
            while p.buf[pos] in Digits:
                add(p.value, p.buf[pos])
                inc(pos)

            if p.buf[pos] == Dot:
                if p.buf[pos+1] in Digits:
                    add(p.value, Dot)
                    inc(pos)
                    while p.buf[pos] in Digits:
                        add(p.value, p.buf[pos])
                        inc(pos)
                    
                    if p.buf[pos] in {'+','-'}:
                        while p.buf[pos] in SemVerExtra:
                            add(p.value, p.buf[pos])
                            inc(pos)

    p.bufpos = pos

template parseAndAddSymbol(p: var Parser, topBlock: var Value) =
    var pos = p.bufpos
    var isSymbol = true
    case p.buf[pos]:
        of '~'  : 
            if p.buf[pos+1]=='>':
                inc(pos)
                p.symbol = tilderight
            else:
                p.symbol = tilde
        of '!'  : 
            if p.buf[pos+1]=='!':
                inc(pos)
                p.symbol = doubleexclamation
            else:
                p.symbol = exclamation
        of '?'  : 
            if p.buf[pos+1]=='?': inc(pos); p.symbol = doublequestion
            else: p.symbol = question
        of '@'  : p.symbol = at
        of '#'  : 
            # TODO(VM/parse) Properly recognize color values 
            #  we could also integrate transparencies, but if it's a HEX color it should normally be limited to 6 characters
            # labels: bug,parser,language
            if p.buf[pos+1] in PermittedColorChars:
                inc pos
                var colorCode: string
                while p.buf[pos] in PermittedColorChars:
                    colorCode &= p.buf[pos]
                    inc pos

                isSymbol = false
                AddToken newColor(colorCode)
                p.bufpos = pos
            else: 
                if p.buf[pos+1] == '#':
                    inc pos
                    if p.buf[pos+1] == '#':
                        inc pos
                        if p.buf[pos+1] == '#':
                            inc pos 
                            if p.buf[pos+1] == '#':
                                inc pos
                                if p.buf[pos+1] == '#':
                                    inc pos
                                    p.symbol = sextuplesharp
                                else:
                                    p.symbol = quintuplesharp
                            else:
                                p.symbol = quadruplesharp
                        else:
                            p.symbol = triplesharp
                    else:
                        p.symbol = doublesharp
                else:
                    p.symbol = sharp
        of '$'  : p.symbol = dollar
        of '%'  : p.symbol = percent
        of '^'  : p.symbol = caret
        of '&'  : p.symbol = ampersand
        of '*'  : p.symbol = asterisk
        of '|'  : 
            if p.buf[pos+1]=='|': 
                inc(pos)
                p.symbol = doublepipe
            elif p.buf[pos+1]=='-':
                inc(pos)
                p.symbol = turnstile
            elif p.buf[pos+1]=='=':
                inc(pos)
                p.symbol = doubleturnstile
            elif p.buf[pos+1]=='>':
                inc(pos)
                p.symbol = triangleright
            else: 
                p.symbol = pipe
        of '/'  : 
            if p.buf[pos+1]=='/': 
                inc(pos)
                p.symbol = doubleslash
            elif p.buf[pos+1]=='%':
                inc(pos)
                p.symbol = slashpercent
            elif p.buf[pos+1]==Backslash:
                inc(pos)
                p.symbol = logicaland
            else: 
                p.symbol = slash
        of '\\' : 
            if p.buf[pos+1]=='\\': 
                inc(pos)
                p.symbol = doublebackslash
            elif p.buf[pos+1] == '/':
                inc(pos)
                p.symbol = logicalor
            else: 
                p.symbol = backslash
        of '+'  : 
            if p.buf[pos+1]=='+': inc(pos); p.symbol = doubleplus
            else: p.symbol = plus
        of '-'  : 
            if p.buf[pos+1]=='>': 
                inc(pos)
                if p.buf[pos+1]=='>':
                    inc(pos)
                    p.symbol = arrowdoubleright
                else:
                    p.symbol = arrowright
            elif p.buf[pos+1]=='<':
                inc(pos)
                if p.buf[pos+1]=='<':
                    inc(pos)
                    p.symbol = reversearrowdoubleleft
                else:
                    p.symbol = reversearrowleft
            elif p.buf[pos+1]==':': inc(pos); p.symbol = minuscolon
            elif p.buf[pos+1]=='-': 
                inc(pos)
                if p.buf[pos+1]=='-':
                    isSymbol = false
                    p.bufpos = pos+1
                    parseMultilineString(p)
                    AddToken newString(p.value, dedented=true)
                elif p.buf[pos+1]=='>':
                    inc(pos)
                    p.symbol = longarrowright
                else:
                    p.symbol = doubleminus
            else: p.symbol = minus
        of '=': 
            if p.buf[pos+1]=='~':
                inc(pos)
                p.symbol = approxequal
            elif p.buf[pos+1]=='>': 
                inc(pos)
                if p.buf[pos+1]=='>':
                    inc(pos)
                    p.symbol = thickarrowdoubleright
                else:
                    p.symbol = thickarrowright
            elif p.buf[pos+1]=='<': inc(pos); p.symbol = equalless
            elif p.buf[pos+1]=='=':
                inc(pos)
                if p.buf[pos+1]=='>':
                    inc(pos)
                    p.symbol = longthickarrowright
                else:
                    p.symbol = doubleequal
            else:
                p.symbol = equal
        of '<':
            case p.buf[pos+1]:
                of '=': 
                    inc(pos)
                    if p.buf[pos+1]=='=':
                        inc(pos)
                        if p.buf[pos+1]=='>':
                            inc(pos)
                            p.symbol = longthickarrowboth
                        else:
                            p.symbol = longthickarrowleft
                    elif p.buf[pos+1]=='>':
                        inc(pos)
                        p.symbol = thickarrowboth
                    else:
                        p.symbol = thickarrowleft
                of '-': 
                    inc(pos)
                    if p.buf[pos+1]=='-':
                        inc(pos)
                        if p.buf[pos+1]=='>':
                            inc(pos)
                            p.symbol = longarrowboth
                        else:
                            p.symbol = longarrowleft
                    elif p.buf[pos+1]=='>':
                        inc(pos)
                        p.symbol = arrowboth
                    else:
                        p.symbol = arrowleft
                of '~':
                    inc(pos)
                    if p.buf[pos+1]=='>':
                        inc(pos)
                        p.symbol = tildeboth
                    else:
                        p.symbol = tildeleft
                of '>': inc(pos); p.symbol = lessgreater
                of '<': 
                    inc(pos)
                    if p.buf[pos+1]=='<':
                        inc(pos)
                        p.symbol = triplearrowleft
                    elif p.buf[pos+1]=='-':
                        inc(pos)
                        if p.buf[pos+1]=='>' and p.buf[pos+2]=='>':
                            inc(pos,2)
                            p.symbol = arrowdoubleboth
                        else:
                            p.symbol = arrowdoubleleft
                    elif p.buf[pos+1]=='=':
                        inc(pos)
                        if p.buf[pos+1]=='>' and p.buf[pos+2]=='>':
                            inc(pos,2)
                            p.symbol = thickarrowdoubleboth
                        else:
                            p.symbol = thickarrowdoubleleft
                    else:
                        p.symbol = doublearrowleft
                of '|':
                    inc (pos)
                    if p.buf[pos+1]=='>':
                        inc(pos)
                        p.symbol = triangleboth
                    else:
                        p.symbol = triangleleft
                of ':': inc(pos); p.symbol = lesscolon
                else: p.symbol = lessthan
        of '>':
            case p.buf[pos+1]:
                of '=': inc(pos); p.symbol = greaterequal
                of '-':
                    inc(pos)
                    if p.buf[pos+1]=='<':
                        inc(pos)
                        p.symbol = reversearrowboth
                    else:
                        p.symbol = reversearrowright
                of '>': 
                    inc(pos)
                    if p.buf[pos+1]=='>':
                        inc(pos)
                        p.symbol = triplearrowright
                    elif p.buf[pos+1]=='-':
                        inc(pos)
                        if p.buf[pos+1]=='<' and p.buf[pos+2]=='<':
                            inc(pos,2)
                            p.symbol = reversearrowdoubleboth
                        else:
                            p.symbol = reversearrowdoubleright
                    else:
                        p.symbol = doublearrowright
                of ':': inc(pos); p.symbol = greatercolon
                else: p.symbol = greaterthan
        else: 
            discard # shouldn't reach here

    if isSymbol:
        inc(pos)
        p.bufpos = pos
        AddToken newSymbol(p.symbol)

template parsePath(p: var Parser, root: Value, curLevel: int) =
    p.values.add(@[root])

    while p.buf[p.bufpos]==Backslash:
        inc(p.bufpos)
        case p.buf[p.bufpos]:
            of PermittedIdentifiers_Start:
                setLen(p.value, 0)
                parseIdentifier(p, alsoAddCurrent=true)
                p.values[^1].add(newLiteral(p.value))
            of PermittedNumbers_Start:
                setLen(p.value, 0)
                parseNumber(p)
                if hasDot: p.values[^1].add(newFloating(p.value))
                else: p.values[^1].add(newInteger(p.value))
            of LBracket:
                inc(p.bufpos)
                setLen(p.value,0)
                var subblock = parseBlock(p,curLevel+1,isSubBlock=true)
                p.values[^1].add(subblock)
            else:
                break

template parseQuantity(p: var Parser) =
    setLen(p.value, 0)
    var pos = p.bufpos
    inc(pos)
    while p.buf[pos] in PermittedColorChars:
        add(p.value, p.buf[pos])
        inc(pos)
    p.bufpos = pos

template parseExponent(p: var Parser) =
    setLen(p.value, 0)
    var pos = p.bufpos
    inc(pos)
    if p.buf[pos] in {'+', '-'}:
        add(p.value, p.buf[pos])
        inc(pos)

    while p.buf[pos] in Digits:
        add(p.value, p.buf[pos])
        inc(pos)

    p.bufpos = pos

proc parseBlock(p: var Parser, level: int, isSubBlock: bool = false, isSubInline: bool = false): Value {.inline.} =
    #var topBlock: Value
    var scriptStr: string
    var topBlock =
        if isSubInline:
            newInline()
        else:
            newBlock()
    # if isSubBlock: topBlock = newBlock()
    # else: topBlock = newInline()
    let initial = p.bufpos - 1
    let initialLine = p.lineNumber
    while true:
        setLen(p.value, 0)
        skip(p, scriptStr)

        case p.buf[p.bufpos]
            of EOF:
                if unlikely(level!=0): 
                    if isSubBlock:
                        SyntaxError_MissingClosingSquareBracket(initialLine, getContext(p, initial))
                    else:
                        SyntaxError_MissingClosingParenthesis(initialLine, getContext(p, initial))
                break
            of Quote:
                parseString(p)
                if unlikely(p.buf[p.bufpos] == Colon):
                    inc(p.bufpos)
                    AddToken newLabel(p.value)
                else:
                    AddToken newString(p.value)
            of BackTick:
                parseString(p, stopper=BackTick)
                AddToken newChar(p.value)
            of Colon:
                parseIdentifier(p, alsoAddCurrent=false)
                if Empty(p.value):
                    if p.buf[p.bufpos]==Colon:
                        inc(p.bufpos)
                        AddToken newSymbol(doublecolon)
                    else:
                        AddToken newSymbol(colon)
                else:
                    AddToken newType(p.value)
            of PermittedNumbers_Start:
                parseNumber(p)
                if hasDot: 
                    if p.value.count(Dot)>1:
                        AddToken newVersion(p.value)
                    else:
                        if p.buf[p.bufpos]==Colon:
                            let pv = newFloating(p.value)
                            parseQuantity(p)
                            AddToken newQuantity(pv, parseQuantitySpec(p.value))
                        elif p.buf[p.bufpos] in ScientificNotation_Start and p.buf[p.bufpos+1] in ScientificNotation:
                            let pv = p.value
                            parseExponent(p)
                            AddToken newFloating(pv & "e" & p.value)
                        else:
                            AddToken newFloating(p.value)
                else:
                    if p.buf[p.bufpos]==Colon:
                        let pv = newInteger(p.value, p.lineNumber)
                        parseQuantity(p)
                        AddToken newQuantity(pv, parseQuantitySpec(p.value))
                    elif p.buf[p.bufpos]=='e' and p.buf[p.bufpos+1] in ScientificNotation:
                        let pv = p.value
                        parseExponent(p)
                        AddToken newFloating(pv & "e" & p.value)
                    else:
                        AddToken newInteger(p.value, p.lineNumber)
            of Symbols:
                parseAndAddSymbol(p,topBlock)
            of PermittedIdentifiers_Start:
                parseIdentifier(p, alsoAddCurrent=true)
                if p.buf[p.bufpos] == Colon:
                    inc(p.bufpos)
                    AddToken newLabel(p.value)
                elif p.buf[p.bufpos] == Backslash:
                    if (p.buf[p.bufpos+1] in PermittedIdentifiers_Start) or 
                       (p.buf[p.bufpos+1] in PermittedNumbers_Start) or
                       p.buf[p.bufpos+1]==LBracket:
                        parsePath(p, newWord(p.value), level)
                        if p.buf[p.bufpos]==Colon:
                            inc(p.bufpos)
                            AddToken newPathLabel(p.values[^1])
                        else:
                            AddToken newPath(p.values[^1])
                        discard p.values.pop()
                    else:
                        inc(p.bufpos)
                        AddToken newSymbol(backslash)
                else:
                    AddToken newWord(p.value)
            of Tick:
                # first try parsing it as a normal :literal
                parseIdentifier(p, alsoAddCurrent=false)
                if Empty(p.value): 
                    # if it's empty, then try parsing it as :symbolLiteral
                    if likely(p.buf[p.bufpos] in Symbols):
                        parseAndAddSymbol(p,topBlock)
                        ReplaceLastToken(newSymbolLiteral(LastToken.m))
                    else:
                        SyntaxError_EmptyLiteral(p.lineNumber, getContext(p, p.bufpos-1))
                else:
                    AddToken newLiteral(p.value)
            of Dot:
                if p.buf[p.bufpos+1] == Dot:
                    inc(p.bufpos, 2)
                    if p.buf[p.bufpos] == Dot:
                        inc(p.bufpos)
                        AddToken newSymbol(longellipsis)
                    else:
                        AddToken newSymbol(ellipsis)
                elif p.buf[p.bufpos+1] == '/':
                    inc(p.bufpos, 2)
                    AddToken newSymbol(dotslash)
                else:
                    parseIdentifier(p, alsoAddCurrent=false)
                    if p.buf[p.bufpos] == Colon:
                        inc(p.bufpos)
                        AddToken newAttributeLabel(p.value)
                    else:
                        AddToken newAttribute(p.value)
            of LBracket:
                inc(p.bufpos)
                var subblock = parseBlock(p,level+1, isSubBlock=true)
                AddToken subblock
            of RBracket:
                if isSubBlock:
                    inc(p.bufpos)
                    break
                else:
                    if isSubInline:
                        SyntaxError_MissingClosingParenthesis(initialLine, getContext(p, initial))
                    else:
                        SyntaxError_StrayClosingSquareBracket(p.lineNumber, getContext(p, p.bufpos))
            of LParen:
                inc(p.bufpos)
                var subblock = parseBlock(p, level+1, isSubInline=true)
                AddToken subblock
            of RParen:
                if isSubInline:
                    inc(p.bufpos)
                    break
                else:
                    if isSubBlock:
                        SyntaxError_MissingClosingSquareBracket(initialLine, getContext(p, initial))
                    else:
                        SyntaxError_StrayClosingParenthesis(p.lineNumber, getContext(p, p.bufpos))
            of LCurly:
                parseCurlyString(p)
            of RCurly:
                SyntaxError_StrayClosingCurlyBracket(p.lineNumber, getContext(p, p.bufpos))
            of '\194':
                if p.buf[p.bufpos+1]=='\171': # got «
                    if p.buf[p.bufpos+2]=='\194' and p.buf[p.bufpos+3]=='\171':
                        parseSafeString(p)
                        AddToken newString(p.value)
                    else:
                        parseFullLineString(p)
                        AddToken newString(unicode.strip(p.value))
                elif p.buf[p.bufpos+1]=='\172': # ¬
                    AddToken newSymbol(logicalnot)
                    inc(p.bufpos, 2)
                else:
                    inc(p.bufpos)
            of '\195':
                if p.buf[p.bufpos+1]=='\184': # ø
                    AddToken newSymbol(slashedzero)
                    inc(p.bufpos, 2)
                else:
                    inc(p.bufpos)
            of '\226':
                if p.buf[p.bufpos+1]=='\136': 
                    case p.buf[p.bufpos+2]:
                        of '\133': # ø
                            AddToken newSymbol(slashedzero)
                            inc(p.bufpos, 3)
                        of '\136': # ∈
                            AddToken newSymbol(element)
                            inc(p.bufpos, 3)
                        of '\137': # ∉
                            AddToken newSymbol(notelement)
                            inc(p.bufpos, 3)
                        of '\143': # ∏
                            AddToken newSymbol(product)
                            inc(p.bufpos, 3)
                        of '\145': # ∑
                            AddToken newSymbol(summation)
                            inc(p.bufpos, 3)
                        of '\158': # ∞
                            AddToken newSymbol(infinite)
                            inc(p.bufpos, 3)
                        of '\167': # ∧
                            AddToken newSymbol(logicaland)
                            inc(p.bufpos, 3)
                        of '\168': # ∨
                            AddToken newSymbol(logicalor)
                            inc(p.bufpos, 3)
                        of '\169': # ∩
                            AddToken newSymbol(intersection)
                            inc(p.bufpos, 3)
                        of '\170': # ∪
                            AddToken newSymbol(union)
                            inc(p.bufpos, 3)
                        else:
                            inc(p.bufpos, 2)
                elif p.buf[p.bufpos+1]=='\138':
                    case p.buf[p.bufpos+2]:
                        of '\130': # ⊂
                            AddToken newSymbol(subset)
                            inc(p.bufpos, 3)
                        of '\131': # ⊃
                            AddToken newSymbol(superset)
                            inc(p.bufpos, 3)
                        of '\134': # ⊆
                            AddToken newSymbol(subsetorequal)
                            inc(p.bufpos, 3)
                        of '\135': # ⊇
                            AddToken newSymbol(supersetorequal)
                            inc(p.bufpos, 3)
                        of '\187': # ⊻
                            AddToken newSymbol(logicalxor)
                            inc(p.bufpos, 3)
                        of '\188': # ⊼
                            AddToken newSymbol(logicalnand)
                            inc(p.bufpos, 3)    
                        else:
                            inc(p.bufpos, 2)
                else:
                    inc(p.bufpos)
            else:
                inc(p.bufpos)

    if scriptStr!="":
        topBlock.data = parseDataBlock(doParse(scriptStr,false))
    return topBlock

proc parseAsDictionary(blk: Value, start: int): Value =
    result = newDictionary()
    var i = start
    while i < blk.a.len:
        case blk.a[i].kind:
            of Label: 
                let lbl = blk.a[i].s
                i += 1
                var values: ValueArray
                while i < blk.a.len and blk.a[i].kind!=Label:
                    case blk.a[i].kind:
                        of Block:
                            values.add(parseDataBlock(blk.a[i]))
                        of String, Literal, Word:
                            values.add(newString(blk.a[i].s))
                        else:
                            values.add(blk.a[i])
                    i += 1
                if values.len > 1:
                    result.d[lbl] = newBlock(values)
                elif values.len == 1:
                    result.d[lbl] = values[0]
                else:
                    result.d[lbl] = VNULL
            else:
                discard

        if i < blk.a.len and blk.a[i].kind!=Label:
            i += 1

proc parseAsBlock(blk: Value, start: int): Value =
    result = newBlock()
    var i = start
    var values: ValueArray
    while i < blk.a.len:
        case blk.a[i].kind:
            of Block:
                values.add(parseDataBlock(blk.a[i]))
            of String, Literal, Word, Label:
                values.add(newString(blk.a[i].s))
            # of Newline:
            #     if values.len > 1:
            #         result.a.add(newBlock(values))
            #         values.setLen(0)
            #     elif values.len == 1:
            #         result.a.add(values[0])
            #         values.setLen(0)
            #     else:
            #         discard
            else:
                values.add(blk.a[i])
        
        i += 1
    
    if values.len > 0:
        if result.a.len == 0 or values.len == 1:
            result.a.add(values)
        else:
            result.a.add(newBlock(values))

#=======================================
# Methods
#=======================================

proc parseDataBlock*(blk: Value): Value =
    ## Parse given value as a data block
    ## and return the parsed result
    if blk.kind != Block or blk.a.len == 0:
        return VNULL

    var i = 0
    # while i < blk.a.len and blk.a[i].kind==Newline:
    #     i += 1

    if i==blk.a.len:
        return VNULL

    if blk.a[i].kind==Label:
        result = parseAsDictionary(blk, i)
    else:
        result = parseAsBlock(blk, i)

proc doParse*(input: string, isFile: bool = true): Value =
    ## Parse a string or file path
    ## and return the result as a Block of values
    hookProcProfiler("parse/doParse"):
        var p: Parser

        # open stream
        if isFile:
            var filePath = input
            when not defined(WEB):
                if unlikely(not fileExists(filePath)):
                    CompilerError_ScriptNotExists(input)

            var stream = newFileStream(filePath)
            lexbase.open(p, stream)
        else:
            var stream = newStringStream(input)

            lexbase.open(p, stream)

        # do parse    
        let rootBlock = parseBlock(p, 0)

        # close lexer
        lexbase.close(p)

    # if everything went fine, return result     
    return rootBlock