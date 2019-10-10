
/**
 * C preprocessor
 * Copyright: 2013 by Digital Mars
 * License: $(LINK2 http://boost.org/LICENSE_1_0.txt, Boost License 1.0).
 * Authors: Walter Bright
 */

module external.warp.stringlit;

import std.array;
import std.range;
import std.stdio;
import std.traits;
import std.utf;

import external.warp.lexer;
import external.warp.omain;
import external.warp.macros;
import external.warp.ranges;

// Kind of string literal
enum STR
{
    s,  // default
    f,  // #include string, i.e. no special meaning for \ character
    L,  // wchar_t
    u8, // UTF-8
    u,  // wchar
    U   // dchar
}

/*****************************************
 * Read in a string literal.
 * Input:
 *      tc      string terminating character, which is one of ', " or >
 * Output:
 *      bytes written to s
 */

R lexStringLiteral(R, S)(R r, ref S s, char tc, STR str)
{
    alias Unqual!(ElementEncodingType!R) E;

    /* Read \0, \x, \u and \U digit sequences
     */
    dchar readRadix(int radix, int ndigits)
    {
        int n = 0;
        dchar d = 0;
        do
        {
            if (r.empty)
                break;
            E c = cast(E)r.front;
            uint i = 32;
            if (c >= '0' && c <= '9')
                i = c - '0';
            else if (c >= 'A' && c <= 'F')
                i = c + 10 - 'A';
            else if (c >= 'a' && c <= 'f')
                i = c + 10 - 'a';
            if (i >= radix)
            {
                if (n == 0 || ndigits >= 4)
                    err_fatal("radix %s digit expected, saw '%c'", radix, c);
                break;
            }
            d = d * radix + i;
            r.popFront();
        } while (++n < ndigits);

        /* Don't worry about disallowed Universal characters, as they
         * vary from Standard to Standard, and we want this to work with
         * all of them.
         */
        return d;
    }

    bool slash;
    while (!r.empty)
    {
        E c = cast(E)r.front;
        dchar d = c;
        switch (c)
        {
            case '"':
            case '\'':
            case '>':
                if (c == tc && !slash)
                {
                    r.popFront();
                    return r;
                }
                goto default;

            case ESC.space:
            case ESC.brk:               // token separator
                r.popFront();
                break;

            case '\\':
                if (str == STR.f)       // ignore escapes in #include strings
                    goto default;
            Lslash:
                /* Escape sequences
                 */
                r.popFront();
                if (r.empty)
                    goto Lerror;
                c = cast(E)r.front;
                switch (c)
                {
                    case '\r':
                        goto Lslash;

                    case '\n':
                        r.popFront();
                        continue;

                    case '"':
                    case '\'':
                    case '\\':
                    case '?':   d = c;    break;
                    case 'a':   d = '\a'; break;
                    case 'b':   d = '\b'; break;
                    case 'f':   d = '\f'; break;
                    case 'n':   d = '\n'; break;
                    case 'r':   d = '\r'; break;
                    case 't':   d = '\t'; break;
                    case 'v':   d = '\v'; break;

                    case '0': .. case '7':      // \nnn octal
                        d = readRadix(8, 3);
                        if (d >= 0x100)
                            err_fatal("octal escape exceeds 0xFF");
                        goto Lput;

                    case 'x':                   // \xnn hex
                        r.popFront();
                        d = readRadix(16, 2);
                        goto Lput;

                    case 'u':                   // \unnnn hex
                        r.popFront();
                        d = readRadix(16, 4);
                        goto Lput;

                    case 'U':                   // \Unnnnnnnn hex
                        r.popFront();
                        d = readRadix(16, 8);
                        goto Lput;

                    default:
                        err_fatal("invalid escape sequence");
                        break;
                }
                goto default;

            default:
                r.popFront();
            Lput:
                /* Stuff d into the output buffer, how it is done
                 * depends on the kind of string literal being built.
                 */
                final switch (str)
                {
                    case STR.s:
                    case STR.f:
                        s.put(cast(E)d);
                        break;

                    case STR.u8:
                    {
                        char[4] buf = void;
                        size_t len = std.utf.encode(buf, d);
                        foreach (chr; buf[0 .. len])
                            s.put(chr);
                        break;
                    }

                    case STR.L:
                        s.put(cast(E)d);
                        s.put(cast(E)(d >> 8));
                        version (Windows)
                        {
                        }
                        else
                        {
                            s.put(cast(E)(d >> 16));
                            s.put(cast(E)(d >> 24));
                        }
                        break;

                    case STR.u:
                    {
                        wchar[2] buf = void;
                        size_t len = std.utf.encode(buf, d);
                        foreach (chr; (cast(E*)buf.ptr)[0 .. len * wchar.sizeof])
                            s.put(chr);
                        break;
                    }

                    case STR.U:
                        s.put(cast(E)d);
                        s.put(cast(E)(d >> 8));
                        s.put(cast(E)(d >> 16));
                        s.put(cast(E)(d >> 24));
                        break;
                }
                slash = false;
                break;
        }
    }
Lerror:
    err_fatal("string literal is not closed with %s", tc);
    return r;
}

unittest
{
    StaticArrayBuffer!(char, 100) buf = void;

    buf.initialize();
    auto r = `abc"`.lexStringLiteral(buf, '"', STR.s);
    assert(r.empty && buf[] == "abc");

    buf.initialize();
    r = `\\\"\'\?\a\b\f\n\r\t\v"`.lexStringLiteral(buf, '"', STR.s);
    assert(r.empty && buf[] == "\\\"\'\?\a\b\f\n\r\t\v");

    buf.initialize();
    r = `\0x\1773"`.lexStringLiteral(buf, '"', STR.s);
    assert(r.empty && buf[] == "\0x\1773");

    buf.initialize();
    r = `\xa\xAFc"`.lexStringLiteral(buf, '"', STR.s);
//writefln("|%s|", buf[]);
    assert(r.empty && buf[] == "\x0a\xafc");

    buf.initialize();
    r = `\uabcdc"`.lexStringLiteral(buf, '"', STR.u);
    assert(r.empty && buf.length == 4 && buf[][0] == 0xCD &&
                                         buf[][1] == 0xAB &&
                                         buf[][2] == 'c'  &&
                                         buf[][3] == 0x00);

    buf.initialize();
    r = `\U000DEF01c"`.lexStringLiteral(buf, '"', STR.U);
//writef("%d:", buf.length);
//foreach (c; 0..buf.length) writef(" %02x", buf[][c]);
//writeln();
    assert(r.empty && buf.length == 8 && buf[][0] == 0x01 &&
                                         buf[][1] == 0xEF &&
                                         buf[][2] == 0x0D &&
                                         buf[][3] == 0x00 &&
                                         buf[][4] == 'c'  &&
                                         buf[][5] == 0x00 &&
                                         buf[][6] == 0x00 &&
                                         buf[][7] == 0x00);
}

/*******************************************
 * Lex a character literal, and convert it to an integer i.
 */

R lexCharacterLiteral(R)(R r, ref ppint_t i, STR str)
{
    alias Unqual!(ElementEncodingType!R) E;

    StaticArrayBuffer!(E, 100) buf;
    buf.initialize();

    r = r.lexStringLiteral(buf, '\'', str);

    E[] a = buf[];

    size_t n;
    final switch (str)
    {
        case STR.s:
        case STR.u8:
            n = a.length;
            if (n == 1)         // most common case
            {
                i = a[0];
                return r;
            }
            if (n > ppint_t.sizeof)
                err_fatal("too many characters in literal");
            else
            {
                E* p = cast(E*)(&i) + n;
                foreach (c; a[0 .. n])
                    *--p = c;
            }
            break;

        case STR.L:
            version (Windows)
            {
                i = *cast(ushort*)a.ptr;
            }
            else
            {
                i = *cast(uint*)a.ptr;
            }
            break;

        case STR.u:
            i = *cast(ushort*)a.ptr;
            break;

        case STR.U:
            i = *cast(uint*)a.ptr;
            break;

        case STR.f:
            assert(0);
    }

    return r;
}

unittest
{
    ppint_t n;
  {
    auto r = `a'`.lexCharacterLiteral(n, STR.s);
    assert(r.empty && n == 'a');
  }
  {
    auto r = `ab'`.lexCharacterLiteral(n, STR.s);
    assert(r.empty && n == 0x6162);
  }
}
