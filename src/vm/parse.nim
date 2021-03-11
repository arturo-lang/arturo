######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: vm/parse.nim
######################################################

#=======================================
# Libraries
#=======================================

import lexbase, os, sequtils
import streams, strutils, unicode

when defined(BENCHMARK) or defined(VERBOSE):
    import helpers/debug as debugHelper

import vm/[errors, value]

#=======================================
# Types
#=======================================

type
    Parser* = object of BaseLexer
        value*: string
        values*: ValueArray
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
    PermittedIdentifiers_In     = Letters + {'0'..'9', '?'}

    Empty                       = ""

#=======================================
# Templates
#=======================================

template AddToken*(token: untyped): untyped =
    addChild(topBlock, token)
    #topBlock.refs.add(p.lineNumber)

#=======================================
# Helpers
#=======================================

## Error reporting

proc getContext*(p: var Parser, curPos: int): string =
    var startPos = curPos-15
    var endPos = curPos+15

    if startPos < 0: startPos = 0

    result = ""

    var i = startPos
    while i<endPos and p.buf[i]!=EOF:
        result &= p.buf[i]
        i += 1

    if p.buf[i]!=EOF:
        result &= "..."

    result = join(toSeq(splitLines(result))," ")
    result &= ";" & repeat("~%",6 + curPos-startPos) & "_^_"

## Lexer/parser

template skip(p: var Parser) =
  var pos = p.bufpos
  while true:
    case p.buf[pos]
        of Semicolon:
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
        of Whitespace:
            inc(pos)
        of CR:
            pos = lexbase.handleCR(p, pos)
        of LF:
            pos = lexbase.handleLF(p, pos)
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

    while true:
        case p.buf[pos]:
            of EOF: 
                SyntaxError_UnterminatedString("", p.lineNumber, getContext(p, p.bufpos))
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
                SyntaxError_NewlineInQuotedString(p.lineNumber, getContext(p, pos))
            of LF:
                SyntaxError_NewlineInQuotedString(p.lineNumber, getContext(p, pos))
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
    while true:
        case p.buf[pos]:
            of EOF: 
                SyntaxError_UnterminatedString("curly", p.lineNumber, getContext(p, p.bufpos))
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
                        inc(pos)
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
                SyntaxError_UnterminatedString("", p.lineNumber, getContext(p, p.bufpos))
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
                        inc(pos,4)
                        break
                    else:
                        add(p.value, p.buf[pos])
                        add(p.value, p.buf[pos+1])
                        inc(pos,2)
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
            p.bufpos = pos
    else:
        p.bufpos = pos

template parseAndAddSymbol(p: var Parser, topBlock: var Value) =
    var pos = p.bufpos
    var isSymbol = true
    case p.buf[pos]:
        of '~'  : p.symbol = tilde
        of '!'  : p.symbol = exclamation
        of '?'  : 
            if p.buf[pos+1]=='?': inc(pos); p.symbol = doublequestion
            else: p.symbol = question
        of '@'  : p.symbol = at
        of '#'  : p.symbol = sharp
        of '$'  : p.symbol = dollar
        of '%'  : p.symbol = percent
        of '^'  : p.symbol = caret
        of '&'  : p.symbol = ampersand
        of '*'  : p.symbol = asterisk
        of '_'  : p.symbol = underscore
        of '|'  : 
            if p.buf[pos+1]=='|': inc(pos); p.symbol = doublepipe
            else: p.symbol = pipe
        of '/'  : 
            if p.buf[pos+1]=='/': inc(pos); p.symbol = doubleslash
            else: p.symbol = slash
        of '\\' : 
            if p.buf[pos+1]=='\\': inc(pos); p.symbol = doublebackslash
            else: p.symbol = backslash
        of '+'  : 
            if p.buf[pos+1]=='+': inc(pos); p.symbol = doubleplus
            else: p.symbol = plus
        of '-'  : 
            if p.buf[pos+1]=='>': inc(pos); p.symbol = arrowright
            elif p.buf[pos+1]==':': inc(pos); p.symbol = minuscolon
            elif p.buf[pos+1]=='-': 
                inc(pos)
                if p.buf[pos+1]=='-':
                    isSymbol = false
                    p.bufpos = pos+1
                    parseMultilineString(p)
                    AddToken newString(p.value, dedented=true)
                else:
                    p.symbol = doubleminus
            else: p.symbol = minus
        of '=': 
            if p.buf[pos+1]=='>': inc(pos); p.symbol = thickarrowright
            elif p.buf[pos+1]=='<': inc(pos); p.symbol = equalless
            else: p.symbol = equal
        of '<':
            case p.buf[pos+1]:
                of '=': inc(pos); p.symbol = thickarrowleft
                of '-': inc(pos); p.symbol = arrowleft
                of '>': inc(pos); p.symbol = lessgreater
                of '<': inc(pos); p.symbol = doublearrowleft
                of ':': inc(pos); p.symbol = lesscolon
                else: p.symbol = lessthan
        of '>':
            case p.buf[pos+1]:
                of '=': inc(pos); p.symbol = greaterequal
                of '>': inc(pos); p.symbol = doublearrowright
                else: p.symbol = greaterthan
        else: 
            discard # shouldn't reach here

    if isSymbol:
        inc(pos)
        p.bufpos = pos
        AddToken newSymbol(p.symbol)

template parsePath(p: var Parser, root: Value) =
    p.values = @[root]

    while p.buf[p.bufpos]==Backslash:
        inc(p.bufpos)
        case p.buf[p.bufpos]:
            of PermittedIdentifiers_Start:
                setLen(p.value, 0)
                parseIdentifier(p)
                p.values.add(newLiteral(p.value))
            of PermittedNumbers_Start:
                setLen(p.value, 0)
                parseNumber(p)
                if Dot in p.value: p.values.add(newFloating(p.value))
                else: p.values.add(newInteger(p.value))
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
    if isDeferred: topBlock = newBlock()
    else: topBlock = newInline()
    let initial = p.bufpos-1

    while true:
        setLen(p.value, 0)
        skip(p)

        case p.buf[p.bufpos]
            of EOF:
                if level!=0: SyntaxError_MissingClosingBracket(p.lineNumber, getContext(p, initial))
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
                if Dot in p.value: AddToken newFloating(p.value)
                else: AddToken newInteger(p.value)
            of Symbols:
                parseAndAddSymbol(p,topBlock)
            of PermittedIdentifiers_Start:
                parseIdentifier(p)
                if p.buf[p.bufpos] == Colon:
                    inc(p.bufpos)
                    AddToken newLabel(p.value)
                elif p.buf[p.bufpos] == Backslash:
                    if (p.buf[p.bufpos+1] in PermittedIdentifiers_Start) or 
                       (p.buf[p.bufpos+1] in PermittedNumbers_Start):
                        parsePath(p, newWord(p.value))
                        if p.buf[p.bufpos]==Colon:
                            inc(p.bufpos)
                            AddToken newPathLabel(p.values)
                        else:
                            AddToken newPath(p.values)
                    else:
                        inc(p.bufpos)
                        AddToken newSymbol(backslash)
                else:
                    AddToken newWord(p.value)
            of Tick:
                parseLiteral(p)
                if p.value == Empty: 
                    SyntaxError_EmptyLiteral(p.lineNumber, getContext(p, p.bufpos))
                else:
                    AddToken newLiteral(p.value)
            of Dot:
                if p.buf[p.bufpos+1] == Dot:
                    inc(p.bufpos)
                    inc(p.bufpos)
                    AddToken newSymbol(ellipsis)
                elif p.buf[p.bufpos+1] == '/':
                    inc(p.bufpos)
                    inc(p.bufpos)
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
                if p.buf[p.bufpos+1]==chr(184):
                    AddToken newSymbol(slashedzero)
                    inc(p.bufpos)
                    inc(p.bufpos)
                else:
                    inc(p.bufpos)
            else:
                inc(p.bufpos)

    return topBlock

#=======================================
# Methods
#=======================================

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

    # do parse
    
    let rootBlock = parseBlock(p, 0)

    # if everything went fine, return result
    when defined(VERBOSE):
        rootBlock.dump(0,false)
            
    return rootBlock
