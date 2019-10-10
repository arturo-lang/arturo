
/**
 * C preprocessor
 * Copyright: 2013 by Digital Mars
 * License: $(LINK2 http://boost.org/LICENSE_1_0.txt, Boost License 1.0).
 * Authors: Walter Bright
 */

module external.warp.macros;

import core.stdc.stdlib;
import core.stdc.string;

import std.algorithm;
import std.array;
import std.ascii;
import std.range;
import std.stdio;
import std.traits;

import external.warp.context;
import external.warp.id;
import external.warp.omain;
import external.warp.number;
import external.warp.ranges;
import external.warp.skip;
import external.warp.textbuf;

bool logging;

/******************************************
 * Characters that make up the start of an identifier.
 */

immutable bool[256] tabIdentifierStart;
shared static this()
{
    for (uint u = 0; u < 0x100; ++u)
    {
        tabIdentifierStart[u] = (isAlpha(u) || u == '_' || u == '$');
    }
}

bool isIdentifierStart(uchar c) pure
{
    return tabIdentifierStart[c];
}

unittest
{
    /* Exhaustively test every char
     */
    for (uint u = 0; u < 0x100; ++u)
    {
        assert(isIdentifierStart(cast(uchar)u) == (isAlpha(u) || u == '_' || u == '$'));
    }
}


/*******************************************
 * Characters that make up the tail of an identifier.
 */

immutable bool[256] tabIdentifierChar;
shared static this()
{
    for (uint u = 0; u < 0x100; ++u)
    {
        tabIdentifierChar[u] = (isAlphaNum(u) || u == '_' || u == '$');
    }
}

bool isIdentifierChar(uchar c) pure
{
    return tabIdentifierChar[c];
}

unittest
{
    /* Exhaustively test every char
     */
    for (uint u = 0; u < 0x100; ++u)
    {
        assert(isIdentifierChar(cast(uchar)u) == (isAlphaNum(u) || u == '_' || u == '$'));
    }
}


// Embedded escape sequence commands
enum ESC : ubyte
{
    start     = '\x00',  // 0 can never appear in legit input, so this is the start
    arg1      = '\x01',
    concat    = '\xFF',
    stringize = '\xFE',
    space     = '\xFD',
    brk       = '\xFC',  // separate adjacent tokens
    expand    = '\xFB',
}

/************************************
 * Transform the macro definition 'text' into a replacement list.
 * Embed escape sequence commands for argument substitution, argument stringizing,
 * and token concatenation.
 * Input:
 *      objectLike      true if object-like macro, false if function-like
 *      parameters      macro parameters
 *      text            Original text; must end with \n
 * Returns:
 *      replacement list with embedded commands for inserting arguments and stringizing
 */

ustring macroReplacementList(R)(ref R text, bool objectLike, ustring[] parameters)
{
    alias Unqual!(ElementEncodingType!R) E;

    if (text.empty)
        return cast(ustring)"";

    E[1000] tmpbuf = void;
    auto outbuf = Textbuf!(uchar, "mrl")(tmpbuf);
    outbuf.put(0);

    while (1)
    {   E c = cast(E)text.front;
        text.popFront();
        switch (c)
        {
            case '\t':
                c = ' ';
                goto case;
            case ' ':
                if (outbuf.length == 1 ||       // no leading whitespace
                    outbuf.last() == ' ')       // collapse adjacent whitespace into one ' '
                    continue;
                break;

            case '\n':                          // reached the end of the input
                if (outbuf.last() == ' ')
                    outbuf.pop();               // no trailing whitespace
                if (outbuf.last() == ESC.concat && outbuf[outbuf.length - 2] == ESC.start)
                    err_fatal("## cannot appear at end of macro text");
                //textPrint(outbuf[1 .. outbuf.length]);
                return outbuf[1 .. outbuf.length].idup;

            case '\r':
                continue;

            case '"':
                /* Skip over character literals and string literals without
                 * examining their insides
                 */
                outbuf.put(c);
                text = text.skipStringLiteral(outbuf);
                continue;

            case 'R':
                if (cast(E)text.front == '"')
                {
                    text.popFront();
                    outbuf.put('R');
                    outbuf.put('"');
                    text = text.skipRawStringLiteral(outbuf);
                    continue;
                }
                goto default;

            case '\'':
                outbuf.put(c);
                text = text.skipCharacterLiteral(outbuf);
                continue;

            case '/':
                if (outbuf.last() == '/')
                {   // C++ style comments end the input
                    text = text.skipCppComment();
                    outbuf.pop();
                    goto case '\n';
                }
                break;

            case '*':
                if (outbuf.last() == '/')
                {   // C style comments are treated as a single ' '
                    text = text.skipCComment();
                    outbuf.pop();
                    goto case '\t';
                }
                break;


            case '#':
                if (text.front == '#')
                {
                    text.popFront();
                    /* The ## token concatenation operator.
                     * Remove leading and trailing spaces, replace with ESC.start ESC.concat
                     */
                    if (outbuf.last() == ' ')
                        outbuf.pop();
                    if (outbuf.length == 1)
                        err_fatal("## cannot appear at beginning of macro text");
                    outbuf.put(ESC.start);
                    outbuf.put(ESC.concat);
                    text = text.skipWhitespace();
                    continue;
                }
                else if (!objectLike)
                {
                    /* The # stringize operator, parameter must immediately follow
                     */
                    text = text.skipWhitespace();
                    StaticArrayBuffer!(uchar, 1024) id = void;
                    id.initialize();
                    text = text.inIdentifier(id);
                    auto argi = countUntil(parameters, id[]);
                    if (argi == -1)
                        err_fatal("# must be followed by parameter");
                    else
                    {
                        outbuf.put(ESC.start);
                        outbuf.put(ESC.stringize);
                        outbuf.put(cast(uchar)(argi + 1));
                    }
                    continue;
                }
                break;

            default:
                if (isIdentifierStart(c))
                {
                    if (parameters.length)
                    {
                        StaticArrayBuffer!(uchar, 1024) id = void;
                        id.initialize();
                        id.put(c);
                        text = text.inIdentifier(id);
                        auto argi = countUntil(parameters, id[]);
                        if (argi == -1)
                        {
                            outbuf.put(id[]);
                        }
                        else
                        {
                            outbuf.put(ESC.start);
                            outbuf.put(cast(uchar)(argi + 1));
                        }
                    }
                    else
                    {
                        outbuf.put(c);
                        while (1)
                        {
                            E c2 = cast(E)text.front;
                            if (isAlphaNum(c2) || c2 == '_' || c2 == '$')
                            {
                                text.popFront();
                                outbuf.put(c2);
                            }
                            else
                                break;
                        }
                    }
                    continue;
                }
                break;
        }
        outbuf.put(c);
    }
    assert(0);
}

unittest
{
    ustring s;
    auto r = cast(ustring)"\n";
    s = r.macroReplacementList(true, null);
    assert(s == "");

    r = cast(ustring)" \t/*hello*/ //\n";
    s = r.macroReplacementList(true, null);
    assert(s == "");

    r = cast(ustring)"# \n";
    s = r.macroReplacementList(true, null);
    assert(s == "#");

    r = cast(ustring)"a ## /**/z\n";
    s = r.macroReplacementList(true, null);
    assert(s == "a" ~ ESC.start ~ ESC.concat ~ "z");

    r = cast(ustring)"x#/**/abc y\n";
    s = r.macroReplacementList(false, cast(ustring[])(["abc"]));
//writefln("'%s', %s", s, s.length);
    assert(s == "x" ~ ESC.start ~ ESC.stringize ~ ESC.arg1 ~ " y");

    r = cast(ustring)"x  abc/**/y\n";
    s = r.macroReplacementList(false, cast(ustring[])(["abc"]));
    assert(s == "x " ~ ESC.start ~ ESC.arg1 ~ " y");

    r = cast(ustring)"x \"abc\" R\"a(abc)a\" 'a' \ry\n";
    s = r.macroReplacementList(false, cast(ustring[])(["abc","a"]));
    assert(s == "x \"abc\" R\"a(abc)a\" 'a' y");
}

/***********************************************
 * Remove leading and trailing whitespace (' ' and ESC.brk).
 * Leave ESC.space intact.
 * Returns:
 *      modified input
 */

uchar[] trimWhiteSpace(uchar[] text)
{
    // Remove leading
    size_t fronti;
    size_t frontn;
    while (fronti < text.length)
    {
        switch (text[fronti])
        {
            case ' ':
            case ESC.brk:
                ++fronti;
                continue;

            case ESC.space:
                ++frontn;
                ++fronti;
                continue;

            default:
                break;
        }
        break;
    }

    // Remove trailing
    size_t backi = text.length;
    size_t backn;
    while (backi > fronti + 1)
    {
        switch (text[backi - 1])
        {
            case ' ':
            case ESC.brk:
                --backi;
                continue;

            case ESC.space:
                ++backn;
                --backi;
                continue;

            default:
                break;
        }
        break;
    }

    if (frontn)
        text[fronti - frontn .. fronti] = ESC.space;
    if (backn)
        text[backi .. backi + backn] = ESC.space;

    //writefln("frontn %d fronti %d backi %d backn %d", frontn, fronti, backn, backi);
    return text[fronti - frontn .. backi + backn];
}

unittest
{
    uchar[0] a;
    auto s = trimWhiteSpace(a);
    assert(s == "");

    char[1] b = " ";
    s = trimWhiteSpace(cast(ubyte[])b);
    assert(s == "");

    ubyte[6] c = cast(ubyte[])("" ~ ESC.brk ~ " a " ~ ESC.brk ~ " ");
    s = trimWhiteSpace(cast(uchar[])c);
    assert(s == "a");

    ubyte[6] d = cast(ubyte[])("" ~ ESC.space ~ " a " ~ ESC.space ~ " ");
    s = trimWhiteSpace(cast(uchar[])d);
    assert(s == std.conv.hexString!"FD 61 FD");

    ubyte[1] e = cast(ubyte[])("" ~ ESC.space ~ "");
    s = trimWhiteSpace(cast(uchar[])e);
    assert(s == std.conv.hexString!"FD");

    ubyte[8] f = cast(ubyte[])("" ~ ESC.space ~ " ab " ~ ESC.space ~ "" ~ ESC.space ~ " ");
    s = trimWhiteSpace(cast(uchar[])f);
//writefln("'%s', %s", s, s.length);
    assert(s == std.conv.hexString!"FD 61 62 FD FD");

}

/******************************************
 * Remove all ESC.space and ESC.brk markers.
 * Remove all leading and trailing spaces.
 * All done in-place.
 */

private uchar[] trimEscWhiteSpace(uchar[] text)
{
    auto p = text.ptr;
    bool leading = true;

    foreach (uchar c; text)
    {
        switch (c)
        {
            case ESC.space:
            case ESC.brk:
                continue;

            case ' ':
                if (leading)
                    continue;
                break;

            default:
                leading = false;
                break;
        }
        *p++ = c;
    }

    while (p > text.ptr && p[-1] == ' ')
    {
        --p;
    }

    return text[0 .. p - text.ptr];
}

unittest
{
    ubyte[11] a = cast(ubyte[])("" ~ ESC.space ~ " a" ~ ESC.brk ~ " " ~ ESC.space ~ "b " ~ ESC.space ~ "" ~ ESC.space ~ " ");
    auto s = trimEscWhiteSpace(cast(uchar[])a);
//writefln("'%s', %s", s, s.length);
    assert(s == "a b");
}


/*************************************
 * Stringize the argument of the # operator per C99 6.10.3.2.2
 * Output:
 *      writes to OutputRange r
 */

private void stringize(R)(ref R outbuf, const(uchar)[] text)
{
    // Remove leading spaces
    size_t i;
    for (; i < text.length; ++i)
    {
        auto c = text[i];
        if (!(c == ' ' || c == ESC.space || c == ESC.brk))
            break;
    }
    text = text[i .. $];

    // Remove trailing spaces
    for (i = text.length; i; --i)
    {
        auto c = text[i - 1];
        if (!(c == ' ' || c == ESC.space || c == ESC.brk))
            break;
    }
    text = text[0 .. i];

    outbuf.put('"');

    // Adapter OutputRange to escape certain characters
    struct EscString
    {
        void put(uchar c)
        {
            switch (c)
            {
                case '"':
                case '?':
                case '\\':
                    outbuf.put('\\');
                    goto default;
                default:
                    outbuf.put(c);
                    break;

                case ESC.expand:
                case ESC.brk:
                    break;               // ignore
            }
        }
    }
    EscString es;

    while (!text.empty)
    {
        auto c = cast(uchar)text.front;
        text.popFront();
        switch (c)
        {
            case 'R':
                if (!text.empty && text.front == '"')
                {
                    outbuf.put('R');
                    es.put('"');
                    text.popFront();
                    text = text.skipRawStringLiteral(es);
                }
                else
                    goto default;
                break;

            case '"':
                es.put(c);
                text = text.skipStringLiteral(es);
                break;

            case '\'':
                outbuf.put(c);
                text = text.skipCharacterLiteral(es);
                break;

            case '?':
                outbuf.put('\\');
                goto default;
            default:
                outbuf.put(c);
                break;

            case ESC.expand:
            case ESC.brk:
                break;               // ignore
        }
    }

    outbuf.put('"');
}

unittest
{
    uchar[10] tmpbuf = void;
    auto outbuf = Textbuf!uchar(tmpbuf);

    outbuf.initialize();
    stringize(outbuf, cast(ustring)"  ");
    assert(outbuf[] == `""`);

    outbuf.initialize();
    stringize(outbuf, cast(ustring)(" " ~ ESC.space ~ "" ~ ESC.brk ~ "a" ~ ESC.expand ~ "" ~ ESC.brk ~ "bc" ~ ESC.space ~ "" ~ ESC.brk ~ " "));
    assert(outbuf[] == `"abc"`);

    outbuf.initialize();
    stringize(outbuf, cast(ustring)(`ab?\\x'y'"z"`));
    assert(outbuf[] == `"ab\?\\x'y'\"z\""`);

    outbuf.initialize();
    stringize(outbuf, cast(ustring)(`'\'a\\'b\`));//`
    assert(outbuf[] == `"'\\'a\\\\'b\"`);

    outbuf.initialize();
    stringize(outbuf, cast(ustring)(`"R"x(aa)x""`));
    assert(outbuf[] == `"\"R\"x(aa)x\"\""`);

    outbuf.initialize();
    ubyte[] u = cast(ubyte[])"R\"x(a?\\a)x\"";
    stringize(outbuf, cast(ustring)u);
//writefln("'%s', %s", s, s.length);
    assert(outbuf[] == `"R\"x(a\?\\a)x\""`);

    outbuf.free();
}


/********************************************
 * Get Ith arg from args.
 */

private ustring null_arg = cast(ustring)"";

ustring getIthArg(ustring[] args, size_t argi)
{
    if (args.length < argi)
        return null;
    ustring a = args[argi - 1];
    if (a is null)
        a = null_arg; // so we can distinguish a missing arg (null_arg) from an empty arg ("")
    return a;
}

/*******************************************
 * Build macro expanded text, writing it to buffer.
 */

//debug=macroExpandedText;

void macroExpandedText(Context, R)(Id* m, ustring[] args, ref R buffer)
{
    debug (macroExpandedText)
    {
        writefln("macroExpandedText(m = '%s')", cast(string)m.name);
        //write("\ttext = "); textPrint(m.text);
        writefln("\ttext = '%s'", cast(string)m.text);
        for (size_t i = 1; i <= args.length; ++i)
        {
            auto a = getIthArg(args, i);
            writefln("\t[%d] = '%s'", i, cast(string)a);
        }
        auto bufferlen = buffer.length;
    }

    /* Determine if we should elide commas ( ,##__VA_ARGS__ extension)
     */
    size_t va_args = 0;
    if (m.flags & Id.IDdotdotdot)
    {   const margs = m.parameters.length;
        /* Only elide commas if there are more arguments than ...
         * This is unlike GCC, which also elides comments if there is only a ...
         * parameter, unless Standard compliant switches are thrown.
         */
        if (margs >= 2)
        {
            // Only elide commas if __VA_ARGS__ was missing (not blank)
            if (getIthArg(args, margs) is null_arg)
                va_args = margs;
        }
    }

    /* The expanded version of each element in args[] is stored in expbuf[],
     * one after the other.
     * This is so that args[] are never expanded more than once, subsequent
     * references will use the previously expanded version.
     * Slices of previously expanded versions are kept in cache[].
     */
    uchar[512] tmpbuf = void;
    auto expbuf = Textbuf!(uchar,"met")(tmpbuf);
    assert(expbuf.length == 0);


    // cache[arg-index] contains the offsets in expbuf where the macro
    // argument at the given index was previously expanded.
    size_t[2][20] cachetmp = void;
    size_t[2][] cache = cachetmp;
    if (args.length + 1 > cachetmp.length)
    {
        auto p = malloc(size_t[2].sizeof * (args.length + 1));
        assert(p);
        cache = (cast(size_t[2]*)p)[0 .. args.length + 1];
    }
    for (size_t i = 0; i < args.length + 1; ++i)
    {
        cache[i][1] = 0;        // the check for initialization is only done on the [1] element
    }

    scope (exit)
    {

        if (args.length + 1 > cachetmp.length)
        {
            free(cache.ptr);
        }

        expbuf.free();

        //foreach (arg; args)
        //if (arg.ptr) free(cast(void*)arg.ptr);
        debug (macroExpandedText)
        {
            writefln("-macroExpandedText(m = '%s')", cast(string)m.name);
            writefln("\t'%s'", cast(string)buffer[bufferlen .. buffer.length]);
        }
    }

    /* ESC.start, ESC.stringize and ESC.concat only appear in text[]
     */

    for (size_t q = 0; q < m.text.length; ++q)
    {
        if (m.text[q] == ESC.start)
        {
            bool expand = true;
            bool trimleft = false;
            bool trimright = false;

        Lagain2:
            auto argi = m.text[++q];
            switch (argi)
            {
                case ESC.start:           // ESC.start was 'quoted'
                    buffer.put(ESC.start);
                    continue;

                case ESC.stringize:           // stringize argument
                {
                    const argi2 = m.text[++q];
                    const arg = getIthArg(args, argi2);
                    stringize(buffer, arg);
                    continue;
                }

                case ESC.concat:
                    if (q + 1 < m.text.length && m.text[q + 1] == ESC.start)
                    {
                        /* Look for special case of:
                         * ',' ESC.start ESC.concat ESC.start __VA_ARGS__
                         */
                        if (q >= 2 && q + 2 < m.text.length &&
                            m.text[q + 2] == va_args && m.text[q - 2] == ',')
                        {
                            /* Elide the comma that was already in buffer,
                             * replace it with ESC.brk
                             */
                             buffer.pop();
                             buffer.put(ESC.brk);
                        }
                        expand = false;
                        trimleft = true;
                        ++q;
                        goto Lagain2;
                    }
                    continue;           // ignore

                default:
                    // If followed by ESC.concat, don't expand
                    if (q + 2 < m.text.length &&
                        m.text[q + 1] == ESC.start && m.text[q + 2] == ESC.concat)
                    {   expand = false;
                        trimright = true;

                        /* Special case of ESC.start i ESC.start ESC.concat ESC.start j
                         * Paul Mensonides writes:
                         * In summary, blue paint (PRE_EXP) on either operand of
                         * ## should be discarded unless the concatenation doesn't
                         * produce a new identifier--which can only happen (in
                         * well-defined code) via the concatenation of a
                         * placemarker.  (Concatenation that doesn't produce a
                         * single preprocessing token produces undefined
                         * behavior.)
                         */
                        size_t argj;
                        if (q + 4 < m.text.length &&
                            m.text[q + 3] == ESC.start &&
                            (argj = m.text[q + 4]) != ESC.start &&
                            argj != ESC.stringize &&
                            argj != ESC.concat)
                        {
                            //writeln("\tspecial CAT case");
                            auto a = getIthArg(args, argi);

                            while (a.length && (a[a.length - 1] == ' ' || a[a.length - 1] == ESC.space))
                                a = a[0 .. $ - 1];

                            auto b = getIthArg(args, argj);
                            auto bstart = b;

                            while (b.length && (b[0] == ' ' || b[0] == ESC.space || b[0] == ESC.expand))
                                b = b[1 .. $];

                            if (!(b.length && isIdentifierChar(b[0])))
                                break;
                            if (!a.length && b.length < bstart.length && b.ptr[-1] == ESC.expand)
                             {  // Keep the ESC.expand
                                buffer.put(ESC.expand);
                                buffer.put(b);
                                q += 4;
                                continue;
                             }

                            size_t pe = a.length;
                            while (1)
                            {
                                if (!pe)
                                    goto L1;
                                --pe;
                                if (a[pe] == ESC.expand)
                                    break;
                            }
                            if (!isIdentifierStart(a[pe + 1]))
                                break;

                            for (size_t k = pe + 1; k < a.length; ++k)
                            {
                                if (!isIdentifierChar(a[k]))
                                    goto L1;
                            }

                            //writefln("CAT pe = %s, a.length = %s, b.length = %s", pe, a.length, b.length);
                            buffer.put(a[0 .. pe]);
                            buffer.put(a[pe + 1 .. a.length]);
                            buffer.put(b);
                            q += 4;
                            continue;
                        }
                    }
                    break;
            }
        L1:
            auto a = getIthArg(args, argi);
            //writefln("\t\targ[%d] = '%s'", argi, cast(string)a);
            if (expand)
            {
                //writefln("\t\tbefore '%s'", cast(string)a);

                if (cache[argi][1])     // if already expanded
                {
                    // Reuse cached version
                    auto t = expbuf[cache[argi][0] .. cache[argi][1]];
                    if (t.length && isMultiTok(t[0]))
                        buffer.put(ESC.brk);
                    buffer.put(t);
                    if (t.length && isMultiTok(t[t.length - 1]))
                        buffer.put(ESC.brk);
                }
                else
                {
                    auto start = expbuf.length;
                    macroExpand!Context(a, expbuf);

                    //writefln("\t\tafter  '%s'", cast(string)expbuf[]);
                    auto s = expbuf[start .. expbuf.length];
                    auto t = trimEscWhiteSpace(s);
                    //writefln("\t\ttrim   '%s'", cast(string)t);
                    if (t.length && isMultiTok(t[0]))
                        buffer.put(ESC.brk);
                    buffer.put(t);
                    if (t.length && isMultiTok(t[t.length - 1]))
                        buffer.put(ESC.brk);

                    auto b = expbuf[];
                    cache[argi][0] = t.ptr - b.ptr;
                    cache[argi][1] = t.ptr - b.ptr + t.length;
                    assert(t.length <= b.length);
                }
            }
            else
            {
                if (trimleft)
                {
                    while (a.length && (a[0] == ' ' || a[0] == ESC.space || a[0] == ESC.expand))
                        a = a[1 .. $];
                }
                if (trimright)
                {
                    while (a.length && (a[a.length - 1] == ' ' || a[a.length - 1] == ESC.space))
                        a = a[0 .. $ - 1];
                }
                buffer.put(a);
            }
        }
        else
            buffer.put(m.text[q]);
    }
}


/*****************************************
 * Take string text, fully macro expand it, and write the result to outbuf.
 */

//debug=MacroExpand;

void macroExpand(Context, R)(const(uchar)[] text, ref R outbuf)
{
    debug (MacroExpand)
        writefln("+macroExpand(text = '%s')", cast(string)text);

    alias uchar E;

    auto ctx = Context.getContext();
    ctx.expanded.off();

    auto r = ctx.pushContext();

    r.push(text);
    r.popFront();

  Louter:
    while (1) //(!r.empty) // r.front returns 0 for end of input
    {
        auto c = r.front;
        switch (c)
        {
            case '"':
                /* Skip over character literals and string literals without
                 * examining their insides
                 */
                r.popFront();
                if (outbuf.length && outbuf.last() == 'R')
                {
                    outbuf.put(c);
                    r = r.skipRawStringLiteral(outbuf);
                }
                else
                {
                    outbuf.put(c);
                    r = r.skipStringLiteral(outbuf);
                }
                continue;

            case '\'':
                r.popFront();
                outbuf.put(c);
                r = r.skipCharacterLiteral(outbuf);
                continue;

            case ESC.expand:
                r.popFront();
                outbuf.put(c);
                c = r.front;
                if (isIdentifierStart(c))
                {
                    r = r.inIdentifier(outbuf);
                    continue;
                }
                r.popFront();
                break;

            case 0:
                goto Ldone;

            case '.':
                r.popFront();
                outbuf.put(c);
                if (!r.empty)
                {
                    c = r.front;
                    switch (c)
                    {
                        case '0': .. case '9':
                            r = r.skipFloat(outbuf, false, true, false);
                            break;

                        case '*':
                            r.popFront();
                            outbuf.put(c);
                            break;

                        case '.':
                            r.popFront();
                            outbuf.put(c);
                            if (!r.empty && r.front == '.')
                            {
                                outbuf.put(c);
                                r.popFront();
                                continue;
                            }
                            break;

                        default:
                            break;
                    }
                }
                continue;

            case '0': .. case '9':
                r = r.skipFloat(outbuf, false, false, false);
                continue;

            default:
                if (isIdentifierStart(c))
                {
                    auto expanded = r.isExpanded();
                    size_t len = outbuf.length;
                    r = r.inIdentifier(outbuf);
                    debug (MacroExpand)
                        writefln("\tident[] = '%s'", cast(string)outbuf[len .. outbuf.length]);
                    if (expanded && !r.empty && r.isExpanded())
                    {
                        continue;
                    }
                    auto id = outbuf[len .. outbuf.length];


                    /* If it is actually a string literal prefix
                     */
                    if (!r.empty)
                    {
                        E q = cast(E)r.front;
                        if (q == '"' || q == '\'')
                        {
                            switch (cast(string)id)
                            {
                                case "LR":
                                case "R":
                                case "u8R":
                                case "uR":
                                case "UR":
                                    if (q == '"')
                                    {
                                        r.popFront();
                                        outbuf.put(q);
                                        r = r.skipRawStringLiteral(outbuf);
                                        continue;
                                    }
                                    break;

                                case "L":
                                case "u":
                                case "u8":
                                case "U":
                                    if (q == '"')
                                    {
                                        r.popFront();
                                        outbuf.put(q);
                                        r = r.skipStringLiteral(outbuf);
                                        continue;
                                    }
                                    if (q == '\'')
                                    {
                                        r.popFront();
                                        outbuf.put(q);
                                        r = r.skipCharacterLiteral(outbuf);
                                        continue;
                                    }
                                    break;

                                default:
                                    break;
                            }
                        }
                    }

                    // Determine if tok_ident[] is a macro
                    auto m = Id.search(id);
                    if (m && m.flags & Id.IDmacro)
                    {
                        if (m.flags & Id.IDinuse)
                        {
                            // Mark this identifier as being disabled
                            outbuf.setLength(len);      // remove id from outbuf
                            outbuf.put(ESC.expand);
                            outbuf.put(m.name);
                            continue;
                        }
                        if (m.flags & (Id.IDlinnum | Id.IDfile | Id.IDcounter))
                        {   // Predefined macro
                            outbuf.setLength(len);      // remove id from outbuf
                            r.unget();
                            r.pushPredefined(m);
                            r.popFront();
                            continue;
                        }

                        /* A temporary buffer to contain the argument strings
                         */
                        uchar[100] tmpargbuf = void;
                        auto argbuffer = Textbuf!(uchar,"arg")(tmpargbuf);

                        /* A temporary buffer to contain the args[]
                         */
                        ustring[64] tmpargsbuf = void;
                        auto argsbuffer = Textbuf!(ustring,"rgs")(tmpargsbuf);

                        if (m.flags & Id.IDfunctionLike)
                        {
                            /* Scan up to opening '(' of actual argument list
                             */
                            E space = 0;
                            while (1)
                            {
                                if (r.empty)
                                    continue Louter;
                                c = cast(E)r.front;
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
                                        r.popFront();
                                        continue;

                                    case '/':
                                        r.popFront();
                                        if (r.empty)
                                            break;
                                        c = r.front;
                                        if (c == '*')
                                        {
                                            r.popFront();
                                            r = r.skipCComment();
                                            space = ' ';
                                            continue;
                                        }
                                        if (c == '/')
                                        {
                                            r.popFront();
                                            r = r.skipCppComment();
                                            space = ' ';
                                            continue;
                                        }
                                        if (space)
                                            outbuf.put(space);
                                        outbuf.put('/');
                                        outbuf.put(c);
                                        continue Louter;

                                    case '(':               // found start of argument list
                                        r.popFront();
                                        break;

                                    default:
                                        if (space)
                                            outbuf.put(space);
                                        continue Louter;
                                }
                                break;
                            }

                            //writefln("macroScanArguments('%s')", cast(string)m.name);
                            r = r.macroScanArguments(cast(string)m.name,
                                    m.parameters.length,
                                    !!(m.flags & Id.IDdotdotdot),
                                     argsbuffer, argbuffer);
                        }

                        outbuf.setLength(len);
                        auto xcnext = r.front;

                        if (!r.empty)
                            r.unget();

                        uchar[278] tmpbuf2 = void;
                        auto expbuffer = Textbuf!(uchar,"exp")(tmpbuf2);

                        uchar[132] tmpbuf3 = void;
                        auto rescanbuffer = Textbuf!(uchar,"rsc")(tmpbuf3);

                        macroExpandedText!Context(m, argsbuffer[], expbuffer);

                        m.flags |= Id.IDinuse;
                        macroExpand!Context(expbuffer[], rescanbuffer);
                        m.flags &= ~Id.IDinuse;

                        auto rs = rescanbuffer[];
                        rs = rs.trimWhiteSpace();

                        /*
                         * Insert break if necessary to prevent
                         * token concatenation.
                         */
                        if (!isWhite(xcnext))
                        {
                            r.push(ESC.brk);
                        }

                        if (rs.empty)
                            r.push(ESC.space);
                        else
                            r.push(rs);
                        r.setExpanded();
                        r.push(ESC.brk);
                        r.popFront();

                        rescanbuffer.free();
                        expbuffer.free();
                        argsbuffer.free();
                        argbuffer.free();
                    }
                    continue;
                }
                else
                    r.popFront();
                break;
        }
//        debug (MacroExpand)
//            writefln("\t\t\toutbuf.put('%s' '%c', x%02x)", cast(string)outbuf[], cast(char)c, c);
        outbuf.put(c);
    }

Ldone:
    r.localFinish();

    // Restore previous context
    r.popContext();

    ctx.expanded.on();

    debug (MacroExpand)
        writefln("-macroExpand() = '%s'", cast(string)outbuf[0 .. outbuf.length]);
}


/********************************************
 * Read in actual arguments for function-like macro instantiation.
 * Input:
 *      r               input range, sitting just past opening (
 *      nparameters     number of parameters expected
 *      variadic        last parameter is variadic
 * Output:
 *      args            array of actual arguments
 *      argsbuffer      args points into this
 * Returns:
 *      r past closing )
 */

R macroScanArguments(R, S, T)(R r, string name, size_t nparameters,
    bool variadic, ref S args, ref T argsbuffer)
{
    /* Temporary buffer to store indices into argsbuffer[] rather than pointers,
     * since argsbuffer[] may get reallocated
     */
    uint[16] tmpargs = void;
    auto argsindexbuffer = Textbuf!(uint,"scn")(tmpargs);

    bool va_args = variadic && (1 == nparameters);

    while (1)
    {
        auto len = argsbuffer.length;   // we'll be appending after len
        r = r.macroScanArgument(va_args, argsbuffer);

        if (nparameters || argsbuffer.length > len + 1)
        {
            argsindexbuffer.put(cast(uint)(len + 1));
            argsindexbuffer.put(cast(uint)(argsbuffer.length));
        }

        va_args = variadic && (argsindexbuffer.length/2 + 1 == nparameters);

        if (r.empty)
        {
            if (va_args)
            {
                argsindexbuffer.put(0);
                argsindexbuffer.put(0);
            }
            goto Lret;
        }

        auto c = r.front;
        if (c == ',')
        {
            r.popFront();
        }
        else
        {
            assert(c == ')');           // end of argument list

            if (va_args)
            {
                argsindexbuffer.put(0);
                argsindexbuffer.put(0);
            }

            if ((argsindexbuffer.length/2) != nparameters)
            {
                err_fatal("expected %d macro arguments for %s, had %d",
                    nparameters, name, argsindexbuffer.length/2);
            }
            r.popFront();
            goto Lret;
        }
    }
    err_fatal("argument list for %s doesn't end with ')'", name);

Lret:
    // Build args[], as argsbuffer[] is no longer going to be reallocated
    size_t nargs = argsindexbuffer.length / 2;
    //args.length = nargs;
    foreach (i; 0 .. nargs)
    {
        if (argsindexbuffer[i * 2] == 0)
            args.put(cast(ustring)null);
        else
        {
            args.put(cast(ustring)argsbuffer[argsindexbuffer[i * 2] .. argsindexbuffer[i * 2 + 1]]);
        }
    }

//    if (logging)
//    { writeln("args[]"); foreach (i,v; args) writefln("\t[%d] = '%s'", i, cast(string)v); }

    argsindexbuffer.free();
    return r;
}

unittest
{
    ustring s;
    s = cast(ustring)"ab,cd )a";

    ustring[16] tmpargsbuf = void;
    auto args = Textbuf!(ustring)(tmpargsbuf);

    uchar[68] tmpargbuf = void;
    auto argbuffer = Textbuf!uchar(tmpargbuf);

    args.initialize();
    argbuffer.initialize();
    auto r = s.macroScanArguments("macroname", 2, false, args, argbuffer);
//writefln("'%s', %s", args, args.length);
    assert(!r.empty && r.front == 'a');
    assert(args[] == ["ab","cd"]);

    s = cast(ustring)"ab )a";
    args.initialize();
    argbuffer.initialize();
    r = s.macroScanArguments("macroname", 2, true, args, argbuffer);
//writefln("'%s', %s", args, args.length);
    assert(!r.empty && r.front == 'a');
    assert(args[] == ["ab",""]);

    argbuffer.free();
    args.free();
}

/*****************************************
 * Read in macro actual argument.
 * Input:
 *      r1      input range at start of arg
 *      va_args if scanning argument for __VA_ARGS__
 * Output:
 *      the scanned argument is written to outbuf
 * Returns:
 *      r1 set past end of argument
 */

private R macroScanArgument(R, T)(R r1, bool va_args, ref T routbuf)
{
    alias Unqual!(ElementEncodingType!R) E;

    static if (isContext!R)
    {
        auto loc = r1.loc();
    }
    alias r1 r;

    auto outbuf = routbuf;

    outbuf.put(0);

    int parens;
  Loop:
    while (1)
    {
        static if (isContext!R)
        {
            auto c = r.front;
            if (c >= '0')
            {
                outbuf.put(cast(uchar)c);
                if (r.expanded.noexpand)
                {
                    auto a = r.lookAhead();
                    size_t n;
                    while (n < a.length)
                    {
                        if (a[n] >= '0')
                            ++n;
                        else
                            break;
                    }
                    if (n)
                    {
                        outbuf.put(a[0 .. n]);
                        r.popFrontN(n);
                    }
                }
                r.popFront();
                continue;
            }
        }
        else
        {
            if (r.empty)
                break;
            auto c = r.front;
            //writefln("%s c = '%c', x%02x", isContext!R, cast(char)((c < ' ') ? '?' : c), c);
            if (c >= '0')
            {
                outbuf.put(cast(uchar)c);
                r.popFront();
                continue;
            }
        }
        switch (c)
        {
            case '(':
                parens++;
                break;

            case ')':
                if (outbuf.last() == ' ')
                    outbuf.pop();
                if (!parens)
                    goto LendOfArg;
                --parens;
                break;

            case ',':
                if (!parens && !va_args)
                    goto LendOfArg;
                break;

            case ' ':
            case '\t':
            case '\r':
            case '\n':
            case '\v':
            case '\f':
                // Collapse all whitespace into a single ' '
                if (outbuf.last() != ' ')
                    outbuf.put(' ');
                r.popFront();
                continue;

            case '"':
                r.popFront();
                if (outbuf.last() == 'R')
                {
                    outbuf.put(cast(uchar)c);
                    r = r.skipRawStringLiteral(outbuf);
                }
                else
                {
                    outbuf.put(cast(uchar)c);
                    r = r.skipStringLiteral(outbuf);
                }
                continue;

            case '\'':
                outbuf.put(cast(uchar)c);
                r.popFront();
                r = r.skipCharacterLiteral(outbuf);
                continue;

            case '/':
            case '*':
                if (outbuf.last() == '/')
                {
                    if (c == '/')
                        r = r.skipCppComment();
                    else
                        r = r.skipCComment();
                    outbuf.pop();               // elide comment from preprocessed output
                    if (outbuf.last() != ' ')
                        outbuf.put(' ');
                    continue;
                }
                break;

            case 0:
                break Loop;

            default:
                break;
        }
        outbuf.put(cast(uchar)c);
        r.popFront();
    }
    static if (isContext!R)
        err_fatal("premature end of macro argument from %s(%s)",
                loc.srcFile ? loc.srcFile.filename : "", loc.lineNumber);
    else
        err_fatal("premature end of macro argument");

  LendOfArg:
    routbuf = outbuf;
    //writefln("'%s'", cast(string)outbuf[]);
    return r1;
}

unittest
{
    uchar[100] tmpbuf = void;
    auto arg = Textbuf!uchar(tmpbuf);

    ustring s = cast(ustring)" \t\r\n\v\f /**/ //
 )a";
    arg.initialize();
    auto r = s.macroScanArgument(false, arg);
    assert(!r.empty && r.front == ')');
    assert(arg[1 .. arg.length] == "");

    s = cast(ustring)" ((,)) )a";
    arg.initialize();
    r = s.macroScanArgument(false, arg);
    assert(!r.empty && r.front == ')');
    assert(arg[1 .. arg.length] == " ((,))");

    s = cast(ustring)"ab,cd )a";
    arg.initialize();
    r = s.macroScanArgument(false, arg);
    assert(!r.empty && r.front == ',');
    assert(arg[1 .. arg.length] == "ab");

    s = cast(ustring)"ab,cd )a";
    arg.initialize();
    r = s.macroScanArgument(true, arg);
    assert(!r.empty && r.front == ')');
    assert(arg[1 .. arg.length] == "ab,cd");

    s = cast(ustring)"a'b',cd )a";
    arg.initialize();
    r = s.macroScanArgument(false, arg);
    assert(!r.empty && r.front == ',');
    assert(arg[1 .. arg.length] == "a'b'");

    s = cast(ustring)`a"b",cd )a`;
    arg.initialize();
    r = s.macroScanArgument(false, arg);
    assert(!r.empty && r.front == ',');
    assert(arg[1 .. arg.length] == `a"b"`);

    s = cast(ustring)`aR"x(b")x",cd )a`;
    arg.initialize();
    r = s.macroScanArgument(false, arg);
//writefln("|%s|, %s", arg, arg.length);
    assert(!r.empty && r.front == ',');
    assert(arg[1 .. arg.length] == `aR"x(b")x"`);
}

/*****************************************
 * 'Break' characters unambiguously separate tokens
 */

bool isBreak(uchar c) pure nothrow
{
    return c == ' ' ||
           c == '\t' ||
           c == '\n' ||
           c == '\v' ||
           c == '\f' ||
           c == '\r' ||
           c == '(' ||
           c == ')' ||
           c == ',' ||
           c == ';' ||
           c == '?' ||
           c == '[' ||
           c == ']' ||
           c == '{' ||
           c == '}' ||
           c == '~';
}


/*************************************
 * 'MultiTok' characters can be part of multiple character tokens
 */

bool isMultiTok(uchar c) pure nothrow
{
    return c == '*' ||
           c == '+' ||
           c == '-' ||
           c == '.' ||
           c == '/' ||
           c == ':' ||
           c == '<' ||
           c == '=' ||
           c == '>' ||
           c == '^' ||
           c == '|';
}

/*********************************************************
 * Write preprocessed line of output to range.
 */

void writePreprocessedLine(R)(ref R r, const(uchar)[] line) if (isOutputRange!(R, uchar))
{
    auto start = line.ptr;
    auto p = start;
  Loop:
    while (1)
    {
        auto c = *p;
        if (cast(byte)c >= ' ')
        {
            ++p;
            static if (is(typeof(r.handle)))
                FPUTC(c, r.handle);   // slightly faster than r.put(c)
            else
                r.put(c);
            continue;
        }
        else
        {
            switch (c)
            {
                case '\n':
                    r.put('\n');
                    return;

                case '\r':
                    break;      // ignore

                default:
                    r.put(c);
                    break;

                case ESC.brk:
                    // Separate tokens by inserting a space (but only if needed)
                    if (p == start)
                    {
                        ++start;                // ignore if at start
                        break;
                    }
                    auto cprev = p[-1];
                    uchar cnext = void;
                    while (1)
                    {
                        cnext = p[1];
                        if (cnext == '\n')       // ignore if at end
                            goto case '\n';
                        ++p;
                        if (cnext != ESC.brk)   // treat multiple ESC.brk's as one
                            break;
                    }
                    if (cnext < 0x80 &&
                        !isBreak(cprev) && !isBreak(cnext) &&
                        (isIdentifierStart(cprev) && isIdentifierStart(cnext) ||
                         isMultiTok(cprev) && isMultiTok(cnext)))
                    {
                        r.put(' ');
                    }
                    r.put(cnext);
                    break;
            }
        }
        ++p;
    }
}

unittest
{
    StaticArrayBuffer!(uchar, 1024) buf = void;

    buf.initialize();
    auto s = cast(ustring)"\n";
    buf.writePreprocessedLine(s);
    assert(buf[] == "\n");

    buf.initialize();
    s = cast(ustring)"\r\na b\x07";
    buf.writePreprocessedLine(s);
//writefln("|%s| %s", buf[], buf[].length);
    assert(buf[] == "\n");

    buf.initialize();
    s = cast(ustring)("" ~ ESC.brk ~ "\n");
    buf.writePreprocessedLine(s);
//writefln("|%s| %s", buf[], buf[].length);
    assert(buf[] == "\n");

    buf.initialize();
    s = cast(ustring)("" ~ ESC.brk ~ ESC.brk ~ ESC.brk ~ "\n");
    buf.writePreprocessedLine(s);
//writefln("|%s| %s", buf[], buf[].length);
    assert(buf[] == "\n");

    buf.initialize();
    s = cast(ustring)("a" ~ ESC.brk ~ ESC.brk ~ ESC.brk ~ "\n");
    buf.writePreprocessedLine(s);
//writefln("|%s| %s", buf[], buf[].length);
    assert(buf[] == "a\n");

    buf.initialize();
    s = cast(ustring)("a" ~ ESC.brk ~ ESC.brk ~ "b" ~ ESC.brk ~ "+\n");
    buf.writePreprocessedLine(s);
//writefln("|%s| %s", buf[], buf[].length);
    assert(buf[] == "a b+\n");

    buf.initialize();
    s = cast(ustring)("+" ~ ESC.brk ~ "+" ~ ESC.brk ~ "(\n");
    buf.writePreprocessedLine(s);
//writefln("|%s| %s", buf[], buf[].length);
    assert(buf[] == "+ +(\n");
}


/***************************************************
 */

void textPrint(const(uchar)[] s)
{
    write('[');
    foreach (i, char c; s)
    {
        switch (c)
        {
            case ESC.start:
            case ESC.stringize:
            case ESC.concat:
            case ESC.space:
            case ESC.brk:
            case ESC.expand:
                write("ESC.");
                write(cast(ESC)c);
                break;

            default:
                if (isPrintable(c))
                    writef("'%s'", c);
                else if (c < 10)
                    writef("%d", c);
                else
                    writef("x%02x", c);
                break;
        }
        if (i != s.length - 1)
            write(',');
    }
    writeln(']');
}
