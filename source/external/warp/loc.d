
/**
 * C preprocessor
 * Copyright: 2013 by Digital Mars
 * License: $(LINK2 http://boost.org/LICENSE_1_0.txt, Boost License 1.0).
 * Authors: Walter Bright
 */

module external.warp.loc;

import std.format;
import std.stdio;

import external.warp.sources;

/*************************************
 * Current location.
 */

struct Loc
{
    SrcFile* srcFile;
    string fileName;    // because #line may change the filename
    uint lineNumber;    // line number of current position
    bool isSystem;      // true if system file

    /********************************************
     * Write out linemarker for current location to range r.
     */
    void linemarker(R)(R r)
    {
        /*
        r.formattedWrite("# %d \"%s\"", lineNumber - 1, fileName);
        if (isSystem)
        {
            r.put(' ');

            r.put('3');
        }
        r.put('\n');*/
    }

    /**********************************************
     * Write out current location to File*
     */
    void write(File* f)
    {
        //writefln("%s(%s) %s", fileName, lineNumber, isSystem);
        //if (srcFile)
        //    f.writef("%s(%d) : ", fileName, lineNumber);
    }
}
