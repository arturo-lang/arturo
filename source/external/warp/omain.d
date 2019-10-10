
/**
 * C preprocessor
 * Copyright: 2013 by Digital Mars
 * License: $(LINK2 http://boost.org/LICENSE_1_0.txt, Boost License 1.0).
 * Authors: Walter Bright
 */

module external.warp.omain;

static import std.file;

import std.array;
import std.conv;
import std.format;
import std.stdio;
import core.stdc.stdlib;
import core.memory;

import external.warp.cmdline;
import external.warp.context;
import external.warp.loc;
import external.warp.sources;
import external.warp.textbuf;

// Data type for C source code characters
alias ubyte uchar;
alias immutable(uchar)[] ustring;

extern (C) int isatty(int);

Context!(Textbuf!char) context; // VERY IMPORTANT!

alias typeof(File.lockingTextWriter()) R;

string start(string[] args)
{ 
    // No need to collect
    const params = parseCommandLine(args);
    auto context = Context!(Textbuf!char)(params);

    try
    {
        // Preprocess each file
        foreach (i; 0 .. params.sourceFilenames.length)
        {
            if (i)
                context.reset();

            auto srcFilename = params.sourceFilenames[i];

            auto outFilename = params.stdout ? "-" : params.outFilenames[i];

            //if (context.params.verbose)
            //    writefln("from %s to %s", srcFilename, outFilename);

            auto sf = SrcFile.lookup(srcFilename);
            if (!sf.read())
                err_fatal("cannot read file %s", srcFilename);

            if (context.doDeps)
                context.deps ~= srcFilename;

            scope(failure) if (!params.stdout) std.file.remove(outFilename);
            //auto fout = params.stdout ? stdout : File(outFilename, "wb");
            //if (!isatty(fout.fileno))
            //    fout.setvbuf(0x100000);
            //auto foutr = fout.lockingTextWriter();      // has destructor

            char[1000] tmpbuf = void;
            auto outbuf = Textbuf!char(tmpbuf);

            context.localStart(sf, &outbuf);
            context.preprocess();
            context.localFinish();

            /* 
             * The one source file we don't need to cache the contents
             * of is the .c file.
             **/

            sf.freeContents();

            return to!string(outbuf[]);
        }
    }
    catch (Exception e)
    {
        //writeln("ERROR!");
        //writeln(e.msg);
        //context.loc().write(&stderr);
        //stderr.writeln(e.msg);
        //exit(EXIT_FAILURE);
    }

    //context.globalFinish();

    exit(EXIT_SUCCESS);     // this prevents the collector from running on exit
                            // (it also prevents -profile from working)
    return "";
}



void err_fatal(T...)(T args)
{
    auto app = appender!string();
    app.formattedWrite(args);
    throw new Exception(app.data);
}

void err_warning(T...)(Loc loc, T args)
{
    //loc.write(&stderr);
    stderr.write("warning: ");
    stderr.writefln(args);
}
