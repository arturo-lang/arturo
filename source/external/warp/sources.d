
/**
 * C preprocessor
 * Copyright: 2013 by Digital Mars
 * License: $(LINK2 http://boost.org/LICENSE_1_0.txt, Boost License 1.0).
 * Authors: Walter Bright
 */

// Deals with source file I/O

module external.warp.sources;

import core.memory;
import core.stdc.stdlib;
import std.file;
import external.warp.file;
import std.path;
import std.stdio;
import std.string;

import external.warp.omain;
import external.warp.textbuf;

/*********************************
 * Things to know about source files.
 */

struct SrcFile
{
    string filename;            // fully qualified file name
    ustring contents;           // contents of the file
    ustring includeGuard;       // macro #define used for #include guard
    bool once;                  // set if #pragma once set
    bool doesNotExist;          // file does not exist
    bool cachedRead;            // read a cached version

    __gshared SrcFile[string] table;

    /**************************************
     * Look up filename in table[].
     * If it isn't there, insert it.
     * Input:
     *  filename        the file name
     *  tmp             if filename needs to be dup'd
     * Returns:
     *  SrcFile* (never null)
     */
    static SrcFile* lookup(const(char)[] filename, bool tmp = false)
    {
        auto p = cast(string)filename in table;
        if (!p)
        {
            SrcFile sf;
            sf.filename = tmp ? filename.idup : cast(string)filename;
            table[sf.filename] = sf;
            p = filename in table;
        }
        return p;
    }

    /*******************************
     * Reset in between processing source files
     */
    static void reset()
    {
        foreach (ref sf; table)
        {
            /* Just need to reset 'once', otherwise the files
             * will be skipped instead of read.
             */
            sf.once = false;
            sf.cachedRead = false;
        }
    }

    /*******************************
     * Release the contents of this source file.
     * It'll get re-read if needed.
     */
    void freeContents()
    {
        myReadFree(cast(void[]) contents);
        contents = null;
    }

    /*******************************
     * Read a file and set its contents.
     */
    bool read()
    {
        if (doesNotExist)
            return false;

        if (contents)
        {   cachedRead = true;
            return true;                // already read
        }

        bool result = true;
        contents = cast(ustring)external.warp.file.myRead(filename);
        if (contents.ptr == null)
        {
            result = false;
            doesNotExist = true;
        }
        return result;
    }
}

/*********************************
 * Search for file along paths[].
 * Cache results.
 * Input:
 *      filename        file to look for (in a tmp buffer)
 *      paths[]         search paths
 *      starti          start searching at paths[starti]
 *      currentPath     if !null, then the path to the enclosing file
 * Output:
 *      foundi          paths[index] is where the file was found,
 *                      paths.length if not in paths[]
 * Returns:
 *      fully qualified filename if found, null if not
 */

SrcFile* fileSearch(const(char)[] filename, const string[] paths, int starti, out int foundi,
        string currentPath)
{
    //writefln("fileSearch(filename='%s', starti=%s, currentPath='%s')", filename, starti, currentPath);
    //foreach (i,path; paths) writefln("  [%s] '%s'", i, path);

    foundi = cast(int)paths.length;

    filename = strip(filename);
    SrcFile* sf;

    char[120] tmpbuf = void;
    auto buf = Textbuf!char(tmpbuf);

    if (isRooted(filename))
    {
        sf = SrcFile.lookup(filename, true);
        if (!sf.read())
            return null;
    }
    else
    {
        if (currentPath)
        {
            buf.initialize();
            buf.myBuildPath(currentPath, filename);
            sf = SrcFile.lookup(buf[], true);
            if (sf.read())
            {
                goto L1;
            }
        }
        if (starti < paths.length)
        {
            foreach (key, path; paths[starti .. $])
            {
                buf.initialize();
                buf.myBuildPath(path, filename);
                //writefln("path = '%s', filename = '%s', buf[] = '%s'", path, filename, buf[]);
                sf = SrcFile.lookup(buf[], true);
                if (sf.read())
                {   foundi = cast(int)(starti + key);
                    goto L1;
                }
            }
        }
        buf.free();
        return null;
    }
 L1:
    auto normfilename = buildNormalizedPath(sf.filename);
    if (filenameCmp(normfilename, sf.filename))
    {   // Cache the normalized file name as a clone of the original unnormalized one
        auto sf2 = SrcFile.lookup(normfilename);
        if (!sf2.contents)
            sf2.contents = sf.contents;
        if (!sf2.includeGuard)
            sf2.includeGuard = sf.includeGuard;
        sf2.once |= sf.once;
        sf2.doesNotExist |= sf.doesNotExist;
        sf = sf2;
    }
    buf.free();
    return sf;
}

/*******************************************
 * Create our own version of std.path.buildPath() that writes to an output range
 * instead of allocating memory.
 */

void myBuildPath(R)(ref R buf, const(char)[] seg1, const(char)[] seg2)
{
    char sep;
    foreach (char c; seg1)
    {   sep = c;
        buf.put(c);
    }
    if (!isDirSeparator(sep))
        buf.put(dirSeparator[0]);
    foreach (char c; seg2)
    {
        buf.put(c);
    }
}
