
/**
 * C preprocessor
 * Copyright: 2013 by Digital Mars
 * License: $(LINK2 http://boost.org/LICENSE_1_0.txt, Boost License 1.0).
 * Authors: Walter Bright
 */

module external.warp.lexer;

import std.array;
import std.ascii;
import std.range;
import std.stdio;
import std.traits;

import external.warp.id;
import external.warp.loc;
import external.warp.macros;
import external.warp.omain;
import external.warp.number;
import external.warp.ranges;
import external.warp.skip;
import external.warp.stringlit;
import external.warp.textbuf;

/**
 * Only a relatively small number of tokens are of interest to the preprocessor.
 */

enum TOK
{
    reserved,

    other,     // not of interest to the preprocessor
    eol,       // end of line
    eof,       // end of file

    comma,
    question,
    colon,
    oror,
    andand,
    or,
    and,
    xor,
    plus,
    minus,
    equal,
    notequal,
    lt,
    gt,
    le,
    ge,
    shl,
    shr,
    mul,
    div,
    mod,
    not,
    tilde,
    lparen,
    rparen,
    defined,
    dotdotdot,
    assign,
    hash,

    integer,
    identifier,
    string,
    sysstring,
}

alias long ppint_t;
alias ulong ppuint_t;

struct PPnumber
{
    ppint_t value;
    bool isunsigned;    // if value is an unsigned integer
}

struct Lexer(R) if (isInputRange!R)
{
    TOK front;
    PPnumber number;

    R src;

    alias Unqual!(ElementEncodingType!R) E;
    external.warp.ranges.BitBucket!E bitbucket = void;

    //enum bool isContext = std.traits.hasMember!(R, "expanded");
    enum bool isContext = __traits(compiles, src.expanded);

    StaticArrayBuffer!(E, 1024) idbuf = void;

    E[40] tmpbuf;
    Textbuf!(E,"str") stringbuf;
    bool stringLiteral;

    uchar[128] tmpbuf3 = void;
    Textbuf!(uchar,"lrs") rescanbuffer;

    uchar[128] tmpbuf2 = void;
    Textbuf!(uchar,"lex") expbuffer;

    uchar[128] tmpargbuf = void;
    Textbuf!(uchar,"lar") argbuffer; // temporary buffer to contain the argument strings

    ustring[16] tmpargsbuf = void;
    Textbuf!(ustring,"lgs") argsbuffer;   // temporary buffer to contain the args[]

    bool noMacroExpand;
    bool noExpand;

    void needStringLiteral()
    {
        stringLiteral = true;
    }

    E[] getStringLiteral()
    {
        stringLiteral = false;
        return stringbuf[];
    }

    enum empty = false;         // return TOK.eof for going off the end

    Loc loc()
    {
        static if (isContext)
        {
            auto csf = src.currentSourceFile();
            if (csf)
                return csf.loc;
        }
        Loc loc;
        return loc;
    }

    /****************************
     * Get a token without expanding macros.
     */
    void popFrontNoExpand()
    {
        noMacroExpand = true;
        popFront();
        noMacroExpand = false;
    }

    void popFront()
    {
        //writefln("isContext %s, %s", isContext, __traits(compiles, src.expanded));

        bool expanded = void;

        while (1)
        {
            static if (!isContext)
            {
                if (src.empty)
                {
                    front = TOK.eof;
                    return;
                }
            }

            E c = cast(E)src.front;
            switch (c)
            {
                case 0:
                    front = TOK.eof;
                    return;

                case ' ':
                case '\t':
                case '\r':
                case '\v':
                case '\f':
                case ESC.space:
                case ESC.brk:
                    src.popFront();
                    continue;

                case '\n':
                    src.popFront();
                    front = TOK.eol;
                    return;

                case '0': .. case '9':
                {
                    bool isinteger;
                    src = src.lexNumber(number.value, number.isunsigned, isinteger);
                    front = isinteger ? TOK.integer : TOK.other;
                    return;
                }

                case '.':
                    src.popFront();
                    if (!src.empty)
                    {
                        switch (src.front)
                        {
                            case '0': .. case '9':
                                src = src.skipFloat(bitbucket, false, true, false);
                                break;

                            case '*':
                                src.popFront();
                                break;

                            case '.':
                                src.popFront();
                                if (!src.empty && src.front == '.')
                                {
                                    src.popFront();
                                    front = TOK.dotdotdot;
                                    return;
                                }
                                break;

                            default:
                                break;
                        }
                    }
                    goto Lother;

                case '!':
                    src.popFront();
                    if (!src.empty && src.front == '=')
                    {
                        src.popFront();
                        front = TOK.notequal;
                        return;
                    }
                    front = TOK.not;
                    return;

                case '=':
                    src.popFront();
                    if (!src.empty && src.front == '=')
                    {
                        src.popFront();
                        front = TOK.equal;
                        return;
                    }
                    front = TOK.assign;
                    return;

                case '<':
                    src.popFront();
                    static if (isContext)
                    {
                        if (stringLiteral)
                        {
                            stringbuf.initialize();
                            src = src.lexStringLiteral(stringbuf, '>', STR.f);
                            front = TOK.sysstring;
                            return;
                        }
                    }
                    if (!src.empty && src.front == '=')
                    {
                        src.popFront();
                        front = TOK.le;
                        return;
                    }
                    if (!src.empty && src.front == '<')
                    {
                        src.popFront();
                        front = TOK.shl;
                        return;
                    }
                    front = TOK.lt;
                    return;

                case '>':
                    src.popFront();
                    if (!src.empty && src.front == '=')
                    {
                        src.popFront();
                        front = TOK.ge;
                        return;
                    }
                    if (!src.empty && src.front == '>')
                    {
                        src.popFront();
                        front = TOK.shr;
                        return;
                    }
                    front = TOK.gt;
                    return;

                case '%':
                    src.popFront();
                    if (!src.empty && src.front == '=')
                    {
                        src.popFront();
                        goto Lother;
                    }
                    front = TOK.mod;
                    return;

                case '*':
                    src.popFront();
                    if (!src.empty && src.front == '=')
                    {
                        src.popFront();
                        goto Lother;
                    }
                    front = TOK.mul;
                    return;

                case '^':
                    src.popFront();
                    if (!src.empty && src.front == '=')
                    {
                        src.popFront();
                        goto Lother;
                    }
                    front = TOK.xor;
                    return;

                case '+':
                    src.popFront();
                    if (!src.empty && src.front == '=')
                    {
                        src.popFront();
                        goto Lother;
                    }
                    if (!src.empty && src.front == '+')
                    {
                        src.popFront();
                        goto Lother;
                    }
                    front = TOK.plus;
                    return;

                case '-':
                    src.popFront();
                    if (!src.empty)
                    {
                        switch (src.front)
                        {
                            case '=':
                            case '-':
                                src.popFront();
                                goto Lother;

                            case '>':
                                src.popFront();
                                if (!src.empty && src.front == '*')
                                    src.popFront();
                                goto Lother;

                            default:
                                break;
                        }
                    }
                    front = TOK.minus;
                    return;

                case '&':
                    src.popFront();
                    if (!src.empty)
                    {
                        switch (src.front)
                        {
                            case '=':
                                src.popFront();
                                goto Lother;

                            case '&':
                                src.popFront();
                                front = TOK.andand;
                                return;

                            default:
                                break;
                        }
                    }
                    front = TOK.and;
                    return;

                case '|':
                    src.popFront();
                    if (!src.empty)
                    {
                        switch (src.front)
                        {
                            case '=':
                                src.popFront();
                                goto Lother;

                            case '|':
                                src.popFront();
                                front = TOK.oror;
                                return;

                            default:
                                break;
                        }
                    }
                    front = TOK.or;
                    return;

                case '(':    src.popFront(); front = TOK.lparen;    return;
                case ')':    src.popFront(); front = TOK.rparen;    return;
                case ',':    src.popFront(); front = TOK.comma;     return;
                case '?':    src.popFront(); front = TOK.question;  return;
                case ':':    src.popFront(); front = TOK.colon;     return;
                case '~':    src.popFront(); front = TOK.tilde;     return;
                case '#':    src.popFront(); front = TOK.hash;      return;

                case '{':
                case '}':
                case '[':
                case ']':
                case ';':
                case '@':  // why does @ appear in boost/type_traits/detail/is_function_ptr_helper.hpp
                    src.popFront();
                    goto Lother;

                case '/':
                    src.popFront();
                    if (!src.empty)
                    {
                        switch (src.front)
                        {
                            case '=':
                                src.popFront();
                                goto Lother;

                            case '/':
                                static if (isContext)
                                {
                                    src.expanded.popBack();
                                    src.expanded.popBack();     // remove '//'
                                    src.expanded.off();
                                    src.popFront();
                                    src = src.skipCppComment();
                                    src.expanded.on();
                                    src.expanded.put('\n');
                                    src.expanded.put(cast(E)src.front);
                                    front = TOK.eol;
                                    return;
                                }
                                else
                                {
                                    src.popFront();
                                    src = src.skipCppComment();
                                    continue;
                                }

                            case '*':
                                static if (isContext)
                                {
                                    src.expanded.popBack();
                                    src.expanded.popBack();     // remove '/*'
                                    src.expanded.off();
                                    src.popFront();
                                    src = src.skipCComment();
                                    src.expanded.on();
                                    src.expanded.put(' ');
                                    src.expanded.put(cast(E)src.front);
                                }
                                else
                                {
                                    src.popFront();
                                    src = src.skipCComment();
                                }
                                continue;

                            default:
                                break;
                        }
                    }
                    front = TOK.div;
                    return;

                case '"':
                    src.popFront();
                    static if (isContext)
                    {
                        if (stringLiteral)
                        {
                            stringbuf.initialize();
                            src = src.lexStringLiteral(stringbuf, '"', STR.f);
                            front = TOK.string;
                            return;
                        }
                        else
                            src = src.skipStringLiteral(bitbucket);
                    }
                    else
                    {
                        src = src.skipStringLiteral(bitbucket);
                    }
                    goto Lother;

                case '\'':
                    src.popFront();
                    src = src.lexCharacterLiteral(number.value, STR.s);
                    number.isunsigned = false;
                    front = TOK.integer;
                    return;

                case '$':
                case '_':
                case 'a': .. case 't':
                case 'v': .. case 'z':
                case 'A': .. case 'K':
                case 'M': .. case 'Q':
                case 'S': .. case 'T':
                case 'V': .. case 'Z':
                    static if (isContext)
                    {
                        if (!noMacroExpand)
                        {
                            expanded = src.isExpanded();
                            src.expanded.popBack();
                            src.expanded.off();
                        }
                    }
                    idbuf.initialize();
                    src = src.inIdentifier(idbuf);
                Lident:
                    if (noMacroExpand)
                    {
                        front = TOK.identifier;
                        return;
                    }
                    static if (!isContext)
                    {
                        front = TOK.identifier;
                        return;
                    }
                    else
                    {
                        Id* m = void;
                        if (expanded && !src.empty && src.isExpanded())
                            goto Lisident;
                        m = Id.search(idbuf[]);
                        if (m && m.flags & Id.IDmacro && !noExpand)
                        {
                            assert(!(m.flags & Id.IDinuse));

                            if (m.flags & (Id.IDlinnum | Id.IDfile | Id.IDcounter))
                            {   // Predefined macro
                                src.unget();
                                src.pushPredefined(m);
                                src.expanded.on();
                                src.popFront();
                                continue;
                            }

                            argbuffer.initialize();
                            argsbuffer.initialize();

                            if (m.flags & Id.IDfunctionLike)
                            {
                                /* Scan up to opening '(' of actual argument list
                                 */
                                E space = 0;
                                while (1)
                                {
                                    if (src.empty)
                                    {
                                        if (space)
                                        {
                                            src.expanded.on();
                                            src.expanded.put(idbuf[]);
                                            src.expanded.put(' ');
                                            front = TOK.identifier;
                                            return;
                                        }
                                        goto Lisident;
                                    }
                                    c = cast(E)src.front;
                                    switch (c)
                                    {
                                        case ' ':
                                        case '\t':
                                        case '\r':
                                        case '\n':
                                        case '\v':
                                        case '\f':
                                        case ESC.space:
                                        case ESC.brk:
                                            space = c;
                                            src.popFront();
                                            continue;

                                        case '/':
                                            src.popFront();
                                            if (src.empty)
                                            {   c = 0;
                                                goto default;
                                            }
                                            c = src.front;
                                            if (c == '*')
                                            {
                                                src.popFront();
                                                src = src.skipCComment();
                                                space = ' ';
                                                continue;
                                            }
                                            if (c == '/')
                                            {
                                                src.popFront();
                                                src = src.skipCppComment();
                                                space = ' ';
                                                continue;
                                            }
                                            src.push('/');
                                            goto default;

                                        case '(':           // found start of argument list
                                            src.popFront();
                                            break;

                                        default:
                                            src.expanded.on();
                                            src.expanded.put(idbuf[]);
                                            if (space)
                                                src.expanded.put(space);
                                            if (c)
                                                src.expanded.put(c);
                                            front = TOK.identifier;
                                            return;
                                    }
                                    break;
                                }

//writefln("lexer macroScanArguments('%s')", cast(string)m.name);
                                src = src.macroScanArguments(cast(string)m.name,
                                        m.parameters.length,
                                        !!(m.flags & Id.IDdotdotdot),
                                         argsbuffer, argbuffer);
                            }
                            auto xcnext = src.front;

                            if (!src.empty)
                                src.unget();

                            expbuffer.initialize();
                            macroExpandedText!(typeof(*src))(m, argsbuffer[], expbuffer);
                            //writefln("l expanded: '%s'", cast(string)expbuffer[]);

                            rescanbuffer.initialize();

                            m.flags |= Id.IDinuse;
                            macroExpand!(typeof(*src))(expbuffer[], rescanbuffer);
                            m.flags &= ~Id.IDinuse;

                            auto rs = rescanbuffer[];
                            rs = rs.trimWhiteSpace();

                            //writefln("l rescanned: '%s'", cast(string)rescanbuffer[]);

                            /*
                             * Insert break if necessary to prevent
                             * token concatenation.
                             */
                            if (!isWhite(xcnext))
                            {
                                src.push(ESC.brk);
                            }

                            if (rs.empty)
                                src.push(ESC.space);
                            else
                                src.push(rs);
                            //src.push(rescanbuffer[]);
                            src.setExpanded();
                            src.expanded.on();
                            src.expanded.put(ESC.brk);
                            src.popFront();

                            continue;
                        }

                    Lisident:
                        src.expanded.on();
                        src.expanded.put(idbuf[]);
                        src.expanded.put(src.front);
                        front = TOK.identifier;
                        return;
                    }

                case 'L':
                case 'u':
                case 'U':
                case 'R':
                    // string prefixes: L LR u u8 uR u8R U UR R
                    static if (isContext)
                    {
                        if (!noMacroExpand)
                        {
                            expanded = src.isExpanded();
                            src.expanded.popBack();
                            src.expanded.off();
                        }
                    }
                    idbuf.initialize();
                    src = src.inIdentifier(idbuf);
                    if (!src.empty)
                    {
                        if (src.front == '"')
                        {
                            switch (cast(string)idbuf[])
                            {
                                case "LR":
                                case "R":
                                case "u8R":
                                case "uR":
                                case "UR":
                                    static if (isContext)
                                    {
                                        if (!noMacroExpand)
                                        {
                                            src.expanded.on();
                                            src.expanded.put(idbuf[]);
                                            src.expanded.put(src.front);
                                        }
                                    }
                                    src.popFront();
                                    src = src.skipRawStringLiteral(bitbucket);
                                    goto Lother;

                                case "L":
                                case "u":
                                case "u8":
                                case "U":
                                    static if (isContext)
                                    {
                                        if (!noMacroExpand)
                                        {
                                            src.expanded.on();
                                            src.expanded.put(idbuf[]);
                                            src.expanded.put(src.front);
                                        }
                                        src.popFront();
                                        if (stringLiteral)
                                        {
                                            stringbuf.initialize();
                                            src = src.lexStringLiteral(stringbuf, '"', STR.f);
                                            front = TOK.string;
                                            return;
                                        }
                                        else
                                            src = src.skipStringLiteral(bitbucket);
                                    }
                                    else
                                    {
                                        src.popFront();
                                        src = src.skipStringLiteral(bitbucket);
                                    }
                                    goto Lother;

                                default:
                                    break;
                            }
                        }
                        else if (src.front == '\'')
                        {
                            auto s = STR.s;
                            switch (cast(string)idbuf[])
                            {
                                case "L":       s = STR.L;  goto Lchar;
                                case "u":       s = STR.u;  goto Lchar;
                                case "u8":      s = STR.u8; goto Lchar;
                                case "U":       s = STR.U;  goto Lchar;
                                Lchar:
                                    static if (isContext)
                                    {
                                        if (!noMacroExpand)
                                        {
                                            src.expanded.on();
                                            src.expanded.put(idbuf[]);
                                            src.expanded.put(src.front);
                                        }
                                    }
                                    src.popFront();
                                    src = src.lexCharacterLiteral(number.value, s);
                                    number.isunsigned = false;
                                    front = TOK.integer;
                                    return;

                                default:
                                    break;
                            }
                        }
                    }
                    goto Lident;

                Lother:
                    front = TOK.other;
                    return;

                case '\\':
                     // \u or \U could be start of identifier
                    src.popFront();
                    err_fatal("unrecognized preprocessor token x%02x", c);
                    assert(0);   // not handled yet

                case ESC.expand:
                    static if (isContext)
                    {
                        src.expanded.popBack();
                        src.popFront();
                        noExpand = true;
                        popFront();
                        noExpand = false;
                        return;
                    }
                    else
                    {
                        goto default;
                    }

                default:
                    err_fatal("unrecognized preprocessor token x%02x", c);
                    src.popFront();
                    break;
            }
        }
    }
}

auto createLexer(R)(R r)
{
    Lexer!R lexer;
    lexer.src = r;

    // Temp buffers
    lexer.stringbuf    = Textbuf!(lexer.E,"str")(lexer.tmpbuf);
    lexer.rescanbuffer = Textbuf!(uchar,"lrs")(lexer.tmpbuf3);
    lexer.expbuffer    = Textbuf!(uchar,"lex")(lexer.tmpbuf2);
    lexer.argbuffer    = Textbuf!(uchar,"lar")(lexer.tmpargbuf);
    lexer.argsbuffer   = Textbuf!(ustring,"lgs")(lexer.tmpargsbuf);

    lexer.popFront();   // 'prime' the pump
    return lexer;
}

unittest
{
  {
    auto s = cast(immutable(ubyte)[])(" \t\v\f\r" ~ ESC.space ~ ESC.brk);
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    assert(lexer.front == TOK.eof);
  }
  {
    auto s = cast(immutable(ubyte)[])(" + ++ += ");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    assert(lexer.front == TOK.plus);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.eof);
  }
  {
    auto s = cast(immutable(ubyte)[])(" - -- -= -> ->* ");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    assert(lexer.front == TOK.minus);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.eof);
  }
  {
    auto s = cast(immutable(ubyte)[])(" & && &= ");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    assert(lexer.front == TOK.and);
    lexer.popFront();
    assert(lexer.front == TOK.andand);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.eof);
  }
  {
    auto s = cast(immutable(ubyte)[])(" | || |= ");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    assert(lexer.front == TOK.or);
    lexer.popFront();
    assert(lexer.front == TOK.oror);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.eof);
  }
  {
    auto s = cast(immutable(ubyte)[])("(),?~{}[];:");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    assert(lexer.front == TOK.lparen);
    lexer.popFront();
    assert(lexer.front == TOK.rparen);
    lexer.popFront();
    assert(lexer.front == TOK.comma);
    lexer.popFront();
    assert(lexer.front == TOK.question);
    lexer.popFront();
    assert(lexer.front == TOK.tilde);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.colon);
    lexer.popFront();
    assert(lexer.front == TOK.eof);
  }
  {
    auto s = cast(immutable(ubyte)[])("^^=**=%%=");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    assert(lexer.front == TOK.xor);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.mul);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.mod);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.eof);
  }
  {
    auto s = cast(immutable(ubyte)[])("> >= >>< <= << = == !!= . .. ... .*");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    assert(lexer.front == TOK.gt);
    lexer.popFront();
    assert(lexer.front == TOK.ge);
    lexer.popFront();
    assert(lexer.front == TOK.shr);
    lexer.popFront();
    assert(lexer.front == TOK.lt);
    lexer.popFront();
    assert(lexer.front == TOK.le);
    lexer.popFront();
    assert(lexer.front == TOK.shl);
    lexer.popFront();
    assert(lexer.front == TOK.assign);
    lexer.popFront();
    assert(lexer.front == TOK.equal);
    lexer.popFront();
    assert(lexer.front == TOK.not);
    lexer.popFront();
    assert(lexer.front == TOK.notequal);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.dotdotdot);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.eof);
  }
  {
    auto s = cast(immutable(ubyte)[])(" + // \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    assert(lexer.front == TOK.plus);
    lexer.popFront();
    assert(lexer.front == TOK.eof);
  }
  {
    auto s = cast(immutable(ubyte)[])(" / /* */ /=");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    assert(lexer.front == TOK.div);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.eof);
  }
  {
    auto s = cast(immutable(ubyte)[])(" 100u \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    assert(lexer.front == TOK.integer);
    assert(lexer.number.value == 100);
    assert(lexer.number.isunsigned);
    lexer.popFront();
    assert(lexer.front == TOK.eol);
    lexer.popFront();
    assert(lexer.front == TOK.eof);
  }
  {
    auto s = cast(immutable(ubyte)[])(" \"123\" \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.eol);
    lexer.popFront();
    assert(lexer.front == TOK.eof);
  }
  {
    auto s = cast(immutable(ubyte)[])(" abc $def _ehi \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    assert(lexer.front == TOK.identifier && lexer.idbuf[] == "abc");
    lexer.popFront();
    assert(lexer.front == TOK.identifier && lexer.idbuf[] == "$def");
    lexer.popFront();
    assert(lexer.front == TOK.identifier && lexer.idbuf[] == "_ehi");
    lexer.popFront();
    assert(lexer.front == TOK.eol);
    lexer.popFront();
    assert(lexer.front == TOK.eof);
  }
  {
    auto s = cast(immutable(ubyte)[])(" LR\"x(\")x\" R\"x(\")x\" u8R\"x(\")x\" uR\"x(\")x\" UR\"x(\")x\" \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.eol);
    lexer.popFront();
    assert(lexer.front == TOK.eof);
  }
  {
    auto s = cast(immutable(ubyte)[])(" L\"a\" u\"a\" u8\"a\" U\"a\" LX\"a\" \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.identifier && lexer.idbuf[] == "LX");
    lexer.popFront();
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.eol);
    lexer.popFront();
    assert(lexer.front == TOK.eof);
  }
  {
    auto s = cast(immutable(ubyte)[])(" 'a' L'a' u'a' u8'a' U'a' LX'a' \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    assert(lexer.front == TOK.integer && lexer.number.value == 'a');
    lexer.popFront();
    assert(lexer.front == TOK.integer && lexer.number.value == 'a');
    lexer.popFront();
    assert(lexer.front == TOK.integer && lexer.number.value == 'a');
    lexer.popFront();
    assert(lexer.front == TOK.integer && lexer.number.value == 'a');
    lexer.popFront();
    assert(lexer.front == TOK.integer && lexer.number.value == 'a');
    lexer.popFront();
    assert(lexer.front == TOK.identifier && lexer.idbuf[] == "LX");
    lexer.popFront();
    assert(lexer.front == TOK.integer && lexer.number.value == 'a');
    lexer.popFront();
    assert(lexer.front == TOK.eol);
    lexer.popFront();
    assert(lexer.front == TOK.eof);
  }
  {
    auto s = cast(immutable(ubyte)[])(" .088 \n");
    auto lexer = createLexer(s);
    assert(!lexer.empty);
    assert(lexer.front == TOK.other);
    lexer.popFront();
    assert(lexer.front == TOK.eol);
    lexer.popFront();
    assert(lexer.front == TOK.eof);
  }
}
