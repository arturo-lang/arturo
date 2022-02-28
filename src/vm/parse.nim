######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/parse.nim
######################################################

#=======================================
# Libraries
#=======================================

import lexbase, os, streams
import strutils, tables, unicode

import vm/[errors, values/value]

#=======================================
# Types
#=======================================

type
    Parser* = object of BaseLexer
        value*: string
        values*: seq[ValueArray]
        symbol*: SymbolKind

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
    Symbols                     = {'~', '!', '@', '#', '$', '%', '^', '&', '*', '-', '_', '=', '+', '<', '>', '/', '\\', '|', '?'}
    Letters                     = {'a'..'z', 'A'..'Z'}
    PermittedIdentifiers_Start  = Letters
    PermittedColorChars         = Letters + {'0'..'9'}
    PermittedIdentifiers_In     = PermittedColorChars + {'?'}
    
    SemVerExtra                 = Letters + PermittedNumbers_Start + {'+', '-', '.'}

    Empty                       = ""

#=======================================
# Forward declarations
#=======================================

proc doParse*(input: string, isFile: bool = true): Value
proc parseDataBlock*(blk: Value): Value 

#=======================================
# Templates
#=======================================

template AddToken*(token: untyped): untyped =
    addChild(topBlock, token)
    #topBlock.refs.add(p.lineNumber)

template stripTrailingNewlines*(): untyped =
    if topBlock.a[^1].kind == Newline:
        let lastN = topBlock.a.len-1
        var firstN = lastN
        while firstN-1 >= 0 and topBlock.a[firstN-1].kind == Newline:
            firstN -= 1
        removeChildren(topBlock, firstN..lastN)

#=======================================
# Helpers
#=======================================

## Error reporting

func getContext*(p: var Parser, curPos: int): string =
    result = ""

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

## Lexer/parser

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
                            when not defined(NOERRORLINES):
                                AddToken newNewline(p.lineNumber)
                            scriptStr &= "\n"
                            break
                        of LF:
                            pos = lexbase.handleLF(p, pos)
                            when not defined(NOERRORLINES):
                                AddToken newNewline(p.lineNumber)
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
                            when not defined(NOERRORLINES):
                                AddToken newNewline(p.lineNumber)
                            break
                        of LF:
                            pos = lexbase.handleLF(p, pos)
                            when not defined(NOERRORLINES):
                                AddToken newNewline(p.lineNumber)
                            break
                        else:
                            inc(pos)
        of Whitespace:
            inc(pos)
        of CR:
            pos = lexbase.handleCR(p, pos)
            when not defined(NOERRORLINES):
                AddToken newNewline(p.lineNumber)
        of LF:
            pos = lexbase.handleLF(p, pos)
            when not defined(NOERRORLINES):
                AddToken newNewline(p.lineNumber)
            # if p.buf[pos] == Tab:
            #     echo "next one is tab!"
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
                        of 'n':
                            add(p.value, '\L')
                            inc(pos, 2)
                        of 'r':
                            add(p.value, '\C')
                            inc(pos, 2)
                        of 't':
                            add(p.value, '\t')
                            inc(pos, 2)
                        of 'v':
                            add(p.value, '\v')
                            inc(pos, 2)
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
                # when defined(windows):
                #     prepos += 1
                SyntaxError_NewlineInQuotedString(p.lineNumber-1, getContext(p, prepos))
            of LF:
                var prepos = pos-1
                pos = lexbase.handleLF(p, pos)
                # when defined(windows):
                #     prepos += 1
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
    if p.buf[pos]=='!':
        inc(pos)
        while p.buf[pos] in Letters:
            inc(pos)

    if p.buf[pos]==':':
        inc(pos)
        verbatimString = true
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
            else:
                add(p.value, p.buf[pos])
                inc(pos)
    p.bufpos = pos

    if verbatimString:
        AddToken newString(p.value)
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
            of chr(194):
                if p.buf[pos+1]==chr(187): # got »
                    if p.buf[pos+2]==chr(194) and p.buf[pos+3]==chr(187):
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

template parseIdentifier(p: var Parser) =
    var pos = p.bufpos
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

    if p.buf[pos] == Dot:
        if p.buf[pos+1] == Dot:
            p.bufpos = pos
        else:
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
    else:
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
                var colorCode = ""
                while p.buf[pos] in PermittedColorChars:
                    colorCode &= p.buf[pos]
                    inc pos

                isSymbol = false
                AddToken newColor(colorCode)
                p.bufpos = pos
                # var color: Value
                # try:
                #     color = newColor(colorCode)
                #     isSymbol = false
                #     AddToken color
                #     p.bufpos = pos
                # except:
                #     try:
                #         color = newColor("#" & colorCode)
                #         isSymbol = false
                #         AddToken color
                #         p.bufpos = pos
                #     except:
                #         p.symbol = sharp
                #         pos = oldPos
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
        of '_'  : p.symbol = underscore
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
                stripTrailingNewlines()
                p.symbol = pipe
        of '/'  : 
            if p.buf[pos+1]=='/': 
                inc(pos)
                p.symbol = doubleslash
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
                parseIdentifier(p)
                p.values[^1].add(newLiteral(p.value))
            of PermittedNumbers_Start:
                setLen(p.value, 0)
                parseNumber(p)
                if Dot in p.value: p.values[^1].add(newFloating(p.value))
                else: p.values[^1].add(newInteger(p.value))
            of LBracket:
                inc(p.bufpos)
                setLen(p.value,0)
                var subblock = parseBlock(p,curLevel+1)
                p.values[^1].add(subblock)
            else:
                break

template parseLiteral(p: var Parser) =
    var pos = p.bufpos
    inc(pos)
    while p.buf[pos] in PermittedIdentifiers_In:
        add(p.value, p.buf[pos])
        inc(pos)
    p.bufpos = pos

proc parseBlock*(p: var Parser, level: int, isDeferred: bool = true): Value {.inline.} =
    var topBlock: Value
    var scriptStr: string = ""
    if isDeferred: topBlock = newBlock()
    else: topBlock = newInline()
    let initial = p.bufpos
    let initialLine = p.lineNumber
    while true:
        setLen(p.value, 0)
        skip(p, scriptStr)

        case p.buf[p.bufpos]
            of EOF:
                if level!=0: SyntaxError_MissingClosingBracket(initialLine, getContext(p, initial-1))
                break
            of Quote:
                parseString(p)
                AddToken newString(p.value)
            of BackTick:
                parseString(p, stopper=BackTick)
                AddToken newChar(p.value)
            of Colon:
                parseLiteral(p)
                if p.value == Empty: 
                    if p.buf[p.bufpos]==Colon:
                        inc(p.bufpos)
                        AddToken newSymbol(doublecolon)
                    else:
                        AddToken newSymbol(colon)
                else:
                    AddToken newType(p.value)
            of PermittedNumbers_Start:
                parseNumber(p)
                if Dot in p.value: 
                    if p.value.count(Dot)>1:
                        AddToken newVersion(p.value)
                    else:
                        AddToken newFloating(p.value)
                else: AddToken newInteger(p.value, p.lineNumber)
            of Symbols:
                parseAndAddSymbol(p,topBlock)
            of PermittedIdentifiers_Start:
                parseIdentifier(p)
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
                parseLiteral(p)
                if p.value == Empty: 
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
                    parseLiteral(p)
                    if p.buf[p.bufpos] == Colon:
                        inc(p.bufpos)
                        AddToken newAttributeLabel(p.value)
                    else:
                        AddToken newAttribute(p.value)
            of LBracket:
                inc(p.bufpos)
                var subblock = parseBlock(p,level+1)
                AddToken subblock
            of RBracket:
                inc(p.bufpos)
                break
            of LParen:
                inc(p.bufpos)
                var subblock = parseBlock(p, level+1, isDeferred=false)
                AddToken subblock
            of RParen:
                inc(p.bufpos)
                break
            of LCurly:
                parseCurlyString(p)
            of RCurly:
                inc(p.bufpos)
            of chr(194):
                if p.buf[p.bufpos+1]==chr(171): # got «
                    if p.buf[p.bufpos+2]==chr(194) and p.buf[p.bufpos+3]==chr(171):
                        parseSafeString(p)
                        AddToken newString(p.value)
                    else:
                        parseFullLineString(p)
                        AddToken newString(unicode.strip(p.value))
                else:
                    inc(p.bufpos)

            of chr(195):
                if p.buf[p.bufpos+1]==chr(184): # ø
                    AddToken newSymbol(slashedzero)
                    inc(p.bufpos, 2)
                else:
                    inc(p.bufpos)
            of chr(226):
                if p.buf[p.bufpos+1]==chr(136): # ∞
                    AddToken newSymbol(infinite)
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
                var values: ValueArray = @[]
                while i < blk.a.len and blk.a[i].kind!=Newline and blk.a[i].kind!=Label:
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
    var values: ValueArray = @[]
    while i < blk.a.len:
        case blk.a[i].kind:
            of Block:
                values.add(parseDataBlock(blk.a[i]))
            of String, Literal, Word, Label:
                values.add(newString(blk.a[i].s))
            of Newline:
                if values.len > 1:
                    result.a.add(newBlock(values))
                    values = @[]
                elif values.len == 1:
                    result.a.add(values[0])
                    values = @[]
                else:
                    discard
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
    if blk.kind != Block or blk.a.len == 0:
        return VNULL

    var i = 0
    while i < blk.a.len and blk.a[i].kind==Newline:
        i += 1

    if i==blk.a.len:
        return VNULL

    if blk.a[i].kind==Label:
        result = parseAsDictionary(blk, i)
    else:
        result = parseAsBlock(blk, i)

when defined(PYTHONIC):
    proc doProcessPythonic(s: string): string =
        var level = 0
        var lines = s.split("\n")
        var i = 0
        while i<lines.len:
            var line = lines[i]
            #echo "processing line: |" & line & "|"
            if line.startsWith("    "):
                #echo "-- it's indented"
                let thisLevel = (line.len-strutils.strip(line, leading=true).len) div 4
                #echo "-- this level: " & $(thisLevel)
                if thisLevel>level:
                    #echo "-- adding start block to previous"
                    lines[i-1] &= "["
                    level = thisLevel
                elif level>thisLevel:
                    #echo "-- adding end block to this"
                    lines[i] = "]" & lines[i]
                    level = thisLevel
            else:
                while level>0:
                    lines[i-1] &= "]"
                    level -= 1

            i += 1

        var last = ""
        while level>0:
            last &= "]"
            level -= 1

        lines.add(last)

        #echo "======"
        #echo lines.join("\n")
        #echo "======"
        
        lines.join("\n")

proc doParse*(input: string, isFile: bool = true): Value =
    var p: Parser

    # open stream
    if isFile:
        when not defined(WEB):
            if not fileExists(input):
                CompilerError_ScriptNotExists(input)

        var stream = newFileStream(input)
        lexbase.open(p, stream)
    else:
        when defined(PYTHONIC):
            var stream = newStringStream(doProcessPythonic(input))
        else:
            var stream = newStringStream(input)

        lexbase.open(p, stream)

    # initialize
    p.value = ""
    p.values = @[]

    # do parse    
    let rootBlock = parseBlock(p, 0)

    # if everything went fine, return result
    when defined(VERBOSE):
        rootBlock.dump(0,false)

    lexbase.close(p)
            
    return rootBlock