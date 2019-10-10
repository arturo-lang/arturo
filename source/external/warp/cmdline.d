
/**
 * C preprocessor
 * Copyright: 2013 by Digital Mars
 * License: $(LINK2 http://boost.org/LICENSE_1_0.txt, Boost License 1.0).
 * Authors: Walter Bright
 */

module external.warp.cmdline;

import external.warp.omain;

import std.stdio;
import std.range;
import std.path;
import std.array;
import std.algorithm;

import core.stdc.stdlib;

/*********************
 * Initialized with the command line arguments.
 */
struct Params
{
    string[] sourceFilenames;
    string[] outFilenames;
    string depFilename;
    string[] defines;
    string[] includes;
    string[] sysincludes;
    bool verbose;
    bool stdout;
}


/******************************************
 * Parse the command line.
 * Input:
 *      args arguments from command line
 * Returns:
 *      Params filled in
 */

Params parseCommandLine(string[] args)
{
    import std.getopt;

    if (args.length == 1)
    {
        writeln(
"C Preprocessor
Copyright (c) 2013 by Digital Mars
http://boost.org/LICENSE_1_0.txt
Options:
  filename...       source file name(s)
  -D macro[=value]  define macro
  --dep filename    generate dependencies to output file
  -I path           path to #include files
  --isystem path    path to system #include files
  -o filename       preprocessed output file
  --stdout          output to stdout
  -v                verbose
");
        exit(EXIT_SUCCESS);
    }

    Params p;

    p.includes ~= ".";

    getopt(args,
        std.getopt.config.passThrough,
        std.getopt.config.caseSensitive,
        "include|I",    &p.includes,
        "define|D",     &p.defines,
        "isystem",      &p.sysincludes,
        "dep",          &p.depFilename,
        "output|o",     &p.outFilenames,
        "stdout",       &p.stdout,
        "v",            &p.verbose);

    // Fix up -Dname=value stuff. This will be superseded by
    // D-Programming-Language/phobos#1779, but won't hurt even then.
    for (size_t i = 1; i < args.length; )
    {
      if (!args[i].startsWith("-D"))
      {
        ++i;
        continue;
      }
      p.defines ~= args[i][2 .. $];
      args = args.remove(i);
    }

    assert(args.length >= 1);
    p.sourceFilenames = args[1 .. $];

    if (p.outFilenames.length == 0)
    {
        /* Output file names are not supplied, so build them by
         * stripping any .c or .cpp extension and appending .i
         */
        foreach (filename; p.sourceFilenames)
        {
            string outname, ext = ".ii";
            if (extension(filename) == ".c")
            {
                outname = baseName(filename, ".c");
                ext = ".i";
            }
            else if ([".cpp", "cxx", ".hpp"].canFind(extension(filename)))
                outname = baseName(filename, ".cpp");
            else
                outname = baseName(filename);
            p.outFilenames ~= outname ~ ext;
        }
    }

    /* Check for errors
     */
    if (p.sourceFilenames.length == p.outFilenames.length)
    {
        // Look for duplicate file names
        auto s = chain(p.sourceFilenames, p.outFilenames, (&p.depFilename)[0..1]).
                 array.
                 sort!((a,b) => filenameCmp(a,b) < 0).
                 findAdjacent!((a,b) => filenameCmp(a,b) == 0);
        if (!s.empty)
        {
            err_fatal("duplicate file names %s", s.front);
        }
    }
    else
    {
        err_fatal("%s source files, but %s output files", p.sourceFilenames.length, p.outFilenames.length);
    }
    return p;
}

unittest
{
    auto p = parseCommandLine([
        "dmpp",
        "foo.c",
        "-D", "macro=value",
        "--dep", "out.dep",
        "-I", "path1",
        "-I", "path2",
        "--isystem", "sys1",
        "--isystem", "sys2",
        "-o", "out.i"]);

        assert(p.sourceFilenames == ["foo.c"]);
        assert(p.defines == ["macro=value"]);
        assert(p.depFilename == "out.dep");
        assert(p.includes == [".", "path1", "path2"]);
        assert(p.sysincludes == ["sys1", "sys2"]);
        assert(p.outFilenames == ["out.i"]);
}

/***********************************
 * Construct the total search path from the regular include paths and the
 * system include paths.
 * Input:
 *      includePaths    regular include paths
 *      sysIncludePaths system include paths
 * Output:
 *      paths           combined result
 *      sysIndex        paths[sysIndex] is where the system paths start
 */

void combineSearchPaths(const string[] includePaths, const string[] sysIncludePaths,
        out string[] paths, out size_t sysIndex)
{
    /* Each element of the paths may contain multiple paths separated by
     * pathSeparator, so straighten that out
     */
    auto incpaths = includePaths.map!(a => splitter(a, pathSeparator)).join;
    auto syspaths = sysIncludePaths.map!(a => splitter(a, pathSeparator)).join;

    /* Concatenate incpaths[] and syspaths[] into paths[]
     * but remove from incpaths[] any that are also in syspaths[]
     */
    paths = incpaths.filter!((a) => !syspaths.canFind(a)).array;
    sysIndex = paths.length;
    paths ~= syspaths;

}

unittest
{
    string[] paths;
    size_t sysIndex;

    combineSearchPaths(["a" ~ pathSeparator ~ "b","c","d"], ["e","c","f"], paths, sysIndex);
    assert(sysIndex == 3);
    assert(paths == ["a","b","d","e","c","f"]);
}
