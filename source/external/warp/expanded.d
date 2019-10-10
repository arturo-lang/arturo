
/**
 * C preprocessor
 * Copyright: 2013 by Digital Mars
 * License: $(LINK2 http://boost.org/LICENSE_1_0.txt, Boost License 1.0).
 * Authors: Walter Bright
 */

module external.warp.expanded;

import std.stdio;

import external.warp.context;
import external.warp.macros;
import external.warp.omain;
import external.warp.textbuf;

/******************************************
 * Expanded output.
 */

struct Expanded(R)
{
    int noexpand = 0;
    int lineNumber = 1;                 // line number of expanded output

    Context!R* ctx;
    R* foutr;

    // Expanded output file
    Textbuf!(uchar,"exp") lineBuffer = void;
    uchar[1000] tmpbuf2 = void;

    void off() { ++noexpand; }
    void on()  { --noexpand; assert(noexpand >= 0); }

    void initialize(Context!R* ctx)
    {
        this.ctx = ctx;
        lineBuffer = Textbuf!(uchar,"exp")(tmpbuf2);
    }

    void start(R* foutr)
    {
        this.foutr = foutr;
        this.lineBuffer.initialize();
        this.lineBuffer.put(0);
        this.noexpand = 0;
        this.lineNumber = 1;
    }

    void finish()
    {
        put('\n');      // cause last line to be flushed to output
    }

    void put(uchar c)
    {
        //writefln("expanded.put(%02x '%s' %s)", c, cast(char)(c < ' ' ? '?' : c), noexpand);
        if (c != ESC.space && !noexpand)
        {
            if (lineBuffer.last() == '\n')
                put2();
            //writefln("lineBuffer.put('%c')", c);
            lineBuffer.put(c);


        }
    }

    private void put2()
    {
        uchar c = lineBuffer[1];
        if (c != '\n' && c != '\r')
        {
            if (auto s = ctx.currentSourceFile())
            {
                auto linnum = s.loc.lineNumber - 1;
                if (!ctx.lastloc.srcFile || ctx.lastloc.fileName !is s.loc.fileName)
                {
                    if (ctx.uselastloc)
                    {
                        ctx.lastloc.linemarker(foutr);
                    }
                    else
                    {
                        /* Since the next readLine() has already been called,
                         * s.loc.lineNumber is one ahead of the expanded line
                         * that has yet to be written out. So linemarker() subtracts
                         * one to compensage.
                         * However, if the next readLine() read a \ line spliced line,
                         * s.loc.lineNumber may be further ahead than just one.
                         * This, then, is a bug.
                         */
                        s.loc.linemarker(foutr);
                        ctx.lastloc = s.loc;
                    }
                    lineNumber = linnum;
                }
                else if (linnum != lineNumber)
                {
                    if (lineNumber + 30 > linnum)
                    {
                        foreach (i; lineNumber .. linnum)
                            foutr.put('\n');
                    }
                    else
                    {
                        s.loc.linemarker(foutr);
                    }
                    lineNumber = linnum;
                }
            }
            else if (ctx.uselastloc && ctx.lastloc.srcFile)
            {
                ctx.lastloc.linemarker(foutr);
            }
        }
        ctx.uselastloc = false;
        foutr.writePreprocessedLine(lineBuffer[1 .. lineBuffer.length]);
        lineBuffer.initialize();
        lineBuffer.put(0);              // so its length is never 0
        ++lineNumber;
    }

    void put(const(uchar)[] s)
    {
        //writefln("expanded.put('%s')", cast(string)s);
        /* This will always be an identifier string, so we can skip
         * a lot of the checking.
         */
        if (!noexpand)
        {
            if (s.length > 0)
            {
                put(s[0]);
                if (s.length > 1)
                    lineBuffer.put(s[1 .. $]);
            }
        }
    }

    /*******************
     * Remove last character emitted.
     */
    void popBack()
    {
        if (!noexpand && lineBuffer.length > 1)
            lineBuffer.pop();
    }

    /****************************
     * Erase current unemitted line.
     */
    void eraseLine()
    {
        lineBuffer.initialize();
        lineBuffer.put(0);
    }
}
