
/**
 * C preprocessor
 * Copyright: 2013 by Digital Mars
 * License: $(LINK2 http://boost.org/LICENSE_1_0.txt, Boost License 1.0).
 * Authors: Walter Bright
 */

module external.warp.number;

import std.array;
import std.ascii;
import std.conv;
import std.range;
import std.stdio;
import std.traits;

import external.warp.lexer : ppint_t, ppuint_t;
import external.warp.omain : err_fatal;
import external.warp.ranges : BitBucket;

/******************************
 * Lex a number.
 * Input:
 *      r       source range on first digit of number
 * Output:
 *      result      number
 *      isunsigned  true if number is unsigned
 *      isinteger   true if it is a number (otherwise it's a floating point literal)
 * Returns:
 *      range pointing past end of number
 */

R lexNumber(R)(R r, out ppint_t result, out bool isunsigned, out bool isinteger)
if (isInputRange!R)
{
    alias Unqual!(ElementEncodingType!R) E;

    BitBucket!E bitbucket = void;

    bool overflow = false;
    isinteger = true;
    int radix = 10;
    ppuint_t n = 0;

    if (r.empty)
        return r;

    E c = cast(E)r.front;
    if (c == '0')
    {
        r.popFront();
        if (r.empty)
            return r;

        c = cast(E)r.front;
        switch (c)
        {
            case '0': .. case '9':
                r.popFront();
                radix = 8;
                n = c - '0';
                break;

            case 'x':
            case 'X':
                r.popFront();
                radix = 16;
                break;

            case 'b':
            case 'B':
                r.popFront();
                radix = 2;
                break;

            case '.':
                r = r.skipFloat(bitbucket, false, false, false);
                isinteger = false;
                return r;

            case 'e':
            case 'E':
                r = r.skipFloat(bitbucket, false, false, true);
                isinteger = false;
                return r;

            case 'A': case 'C': .. case 'D': case 'F':
            case 'a': case 'c': .. case 'd': case 'f':
                err_fatal("octal digit expected");
                r.popFront();
                break;

            default:
                break;
        }
    }

    while (!r.empty)
    {
        c = cast(E)r.front;
        ppint_t d;
        switch (c)
        {
            case '2': .. case '9':
                if (radix == 2)
                {
                    err_fatal("0 or 1 expected");
                }
                goto case;

            case '0': case '1':
                r.popFront();
                d = c - '0';
                break;

            case 'a': .. case 'f':
            case 'A': .. case 'F':
                if (radix != 16)
                {
                    if (c == 'e' || c == 'E')
                        goto Lsawexponent;
                    if (c == 'f' || c == 'F')
                    {
                        r.popFront();
                        isinteger = false;
                        return r;
                    }
                    err_fatal("%s digit expected not '%s'", radix == 8 ? "octal" : "decimal", cast(char)c);
                }
                r.popFront();
                if (c >= 'a')
                    d = c + 10 - 'a';
                else
                    d = c + 10 - 'A';
                break;

            case 'p':
            case 'P':
            Lsawexponent:
                r = r.skipFloat(bitbucket, radix == 16, false, true);
                isinteger = false;
                return r;

            case '.':
                r = r.skipFloat(bitbucket, radix == 16, false, false);
                isinteger = false;
                return r;

            default:
                goto Ldone;
        }

        auto n2 = n * radix;
        if (n2 / radix != n || n2 + d < n)
        {
            overflow = true;
        }

        n = n2 + d;
    }

Ldone:
    // Parse trailing 'u', 'U', 'l' or 'L' in any combination
    enum FLAGS { none, U = 1, L = 2, LL = 4 }
    FLAGS flags = FLAGS.none;
    while (!r.empty)
    {
        switch (r.front)
        {
            case 'U':
            case 'u':
                if (flags & FLAGS.U)
                    err_fatal("redundant U suffix");
                flags |= FLAGS.U;
                r.popFront();
                continue;

            case 'L':
            case 'l':
                if (flags & FLAGS.LL)
                    err_fatal("redundant L suffix");
                flags |= (flags & FLAGS.L) ? FLAGS.LL : FLAGS.L;
                r.popFront();
                continue;

            default:
                break;
        }
        break;
    }

    if (flags & FLAGS.U || n >= 0x8000_0000_0000_0000LU)
        isunsigned = true;
    result = n;
    if (overflow && isinteger)
        err_fatal("integer overflow");
    return r;
}

unittest
{
    ppint_t number;
    bool isunsigned;
    bool isinteger;
    string s;

    s = "";
    s = s.lexNumber(number, isunsigned, isinteger);
    assert(number == 0);
    assert(!isunsigned);
    assert(s.empty);

    s = "0";
    s = s.lexNumber(number, isunsigned, isinteger);
    assert(number == 0);
    assert(!isunsigned);
    assert(s.empty);

    s = "123456789x";
    s = s.lexNumber(number, isunsigned, isinteger);
    assert(number == 123456789);
    assert(!isunsigned);
    assert(!s.empty && s.front == 'x');

    s = "0x123abcdefx";
    s = s.lexNumber(number, isunsigned, isinteger);
    assert(number == 0x123abcdef);
    assert(!isunsigned);
    assert(!s.empty && s.front == 'x');

    s = "0x456789ABCDEFx";
    s = s.lexNumber(number, isunsigned, isinteger);
    assert(number == 0x456789ABCDEF);
    assert(!isunsigned);
    assert(!s.empty && s.front == 'x');

    s = "01234567x";
    s = s.lexNumber(number, isunsigned, isinteger);
    assert(number == octal!1234567);
    assert(!isunsigned);
    assert(!s.empty && s.front == 'x');

    s = "0L";
    s = s.lexNumber(number, isunsigned, isinteger);
    assert(number == 0);
    assert(!isunsigned);
    assert(s.empty);

    s = "0l";
    s = s.lexNumber(number, isunsigned, isinteger);
    assert(number == 0);
    assert(!isunsigned);
    assert(s.empty);

    s = "0U";
    s = s.lexNumber(number, isunsigned, isinteger);
    assert(number == 0);
    assert(isunsigned);
    assert(s.empty);

    s = "0u";
    s = s.lexNumber(number, isunsigned, isinteger);
    assert(number == 0);
    assert(isunsigned);
    assert(s.empty);

    s = "8lu";
    s = s.lexNumber(number, isunsigned, isinteger);
    assert(number == 8);
    assert(isunsigned);
    assert(s.empty);

    s = "8ull";
    s = s.lexNumber(number, isunsigned, isinteger);
    assert(number == 8);
    assert(isunsigned);
    assert(s.empty);

    s = "0x8000000000000000";
    s = s.lexNumber(number, isunsigned, isinteger);
    assert(number == 0x8000_0000_0000_0000);
    assert(isunsigned);
    assert(s.empty);

    s = "1ff";
    s = s.lexNumber(number, isunsigned, isinteger);
    assert(!isinteger);
    assert(s == "f");

    s = "0b1101";
    s = s.lexNumber(number, isunsigned, isinteger);
    assert(isinteger);
    assert(number == 13);
    assert(s.empty);

    s = "0B10";
    s = s.lexNumber(number, isunsigned, isinteger);
    assert(isinteger);
    assert(number == 2);
    assert(s.empty);

    string[] floats = ["1f", "5e+08", "1.4", "89.", "0xep+1", "1E9",
            "083.", "0023.2" ];
    foreach (f; floats)
    {
        f = f.lexNumber(number, isunsigned, isinteger);
        assert(!isinteger);
        assert(f.empty);
    }
}

/***********************************
 * Skip over floating point number.
 */

R skipFloat(R, S)(R r, ref S s, bool hex, bool sawdot, bool isexponent)
        if (isInputRange!R && isOutputRange!(S, ElementEncodingType!R))
{
    alias Unqual!(ElementEncodingType!R) E;

    if (!r.empty)
    {
        E get() { E c = cast(E)r.front; return c; }

        E c = get();

        bool isfloat = sawdot | isexponent;

        if (isexponent)
            goto Lisexponent;

        if (sawdot)
            goto Lsawdot;

        // Leading '0x'
        if (c == '0')
        {
            s.put(c);
            r.popFront();
            if (r.empty)
                goto Lreturn;
            c = get();
            if (c == 'x' || c == 'X')
            {
                s.put(c);
                r.popFront();
                hex = true;
                if (r.empty)
                {
                    err_fatal("hex digit(s) expected");
                    goto Lreturn;
                }
                c = get();
            }
        }

        // Digits to left of '.'
        while (1)
        {
            if (c == '.')
            {
                isfloat = true;
                s.put(c);
                r.popFront();
                if (r.empty)
                    goto Lreturn;
                c = get();
                break;
            }
            if (isDigit(c) || (hex && isHexDigit(c)))
            {
                s.put(c);
                r.popFront();
                if (r.empty)
                    goto Lreturn;
                c = get();
                continue;
            }
            break;
        }

    Lsawdot:

        // Digits to right of '.'
        while (1)
        {
            if (isDigit(c) || (hex && isHexDigit(c)))
            {
                s.put(c);
                r.popFront();
                if (r.empty)
                    goto Lreturn;
                c = get();
                continue;
            }
            break;
        }

    Lisexponent:
        if (c == 'e' || c == 'E' || (hex && (c == 'p' || c == 'P')))
        {
            s.put(c);
            r.popFront();
            if (r.empty)
            {
                err_fatal("exponent digits missing");
                goto Lreturn;
            }
            c = get();
            if (c == '-' || c == '+')
            {
                s.put(c);
                r.popFront();
                if (r.empty)
                {
                    err_fatal("exponent digits missing");
                    goto Lreturn;
                }
                c = get();
            }
            bool anyexp;
            while (1)
            {
                if (isDigit(c) || (hex && isHexDigit(c)))
                {
                    r.popFront();
                    s.put(c);
                    anyexp = true;
                    if (r.empty)
                        goto Lreturn;
                    c = get();
                    continue;
                }
                if (!anyexp)
                    err_fatal("missing exponent");
                break;
            }
        }
        else if (hex && isfloat)
            err_fatal("exponent required for hex float");

        if (c == 'f' || c == 'F' || c == 'l' || c == 'L')
        {
            s.put(c);
            r.popFront();
            if (r.empty)
                goto Lreturn;
            c = get();
        }

    Lreturn:
        ;
    }
    return r;
}

unittest
{
    BitBucket!char bitbucket = void;

    string[] cases = ["", "0", "1", "55.", "2.3", "0.0E+2", "0.0e-150", "0E03",
        "2.7l", "3.2L", "5.6e1f", "125.1234F",
        "0x12abcdefABCDEFp+20", "0x9.aP-10"
        ];

    foreach (s; cases)
    {
        //writefln("before: |%s|", s);
        s = s.skipFloat(bitbucket, false, false, false);
        //writefln("after: |%s|", s);
        assert(s.empty);
    }

    string s;

    s = "123";
    s = s.skipFloat(bitbucket, false, true, false);
    assert(s.empty);

    s = "e123";
    s = s.skipFloat(bitbucket, false, false, true);
    assert(s.empty);

    s = "e+08";
    s = s.skipFloat(bitbucket, false, false, true);
    assert(s.empty);
}
