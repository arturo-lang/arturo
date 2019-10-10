

/**
 * C preprocessor
 * Copyright: 2013 by Digital Mars
 * License: $(LINK2 http://boost.org/LICENSE_1_0.txt, Boost License 1.0).
 * Authors: Walter Bright
 */

module external.warp.id;

import core.stdc.stdio;
import core.stdc.stdlib;
import core.stdc.time;
import std.stdio;

import external.warp.omain;

/******************************
 * All identifiers become a pointer to an instance
 * of this.
 */

struct Id
{
    enum buckets_length = 24_593UL;
    __gshared Id*[] buckets;

    __gshared uint count;

    ustring name;
    size_t hash;
    Id* next;

    private this(ustring name, size_t hash)
    {
        this.name = name;
        this.hash = hash;
    }

    /******************************
     * Reset in between files processed.
     */
    static void reset()
    {
        /* Expect that the same headers will be processed again, with the
         * same macros. So leave the table in place - just #undef all the
         * entries.
         */
        foreach (m; buckets)
        {
            for (; m; m = m.next)
            {
                m.flags = 0;
                m.text = null;
                m.parameters = null;
            }
        }
    }

    /*********************
     * See if this is a known identifier.
     * Returns:
     *  Id*  if it is, null if not
     */
    static Id* search(const(uchar)[] name)
    {
        if (buckets.length)
        {
            auto hash = getHash(name);
            auto bucket = buckets[hash % buckets_length];
            while (bucket)
            {
                if (bucket.hash == hash && bucket.name == name)
                    return bucket;
                bucket = bucket.next;
            }
        }
        return null;
    }


    /*************************
     * Look up name in Id table.
     * If it's there, return it.
     * If not, create an Id and return it.
     */
    static Id* pool(ustring name)
    {
        if (!buckets.length)
        {
            buckets = (cast(Id**)calloc((Id*).sizeof, buckets_length))[0 .. buckets_length];
            assert(buckets.ptr);
        }

        auto hash = getHash(name);
        auto pbucket = &buckets[hash % buckets_length];
//int depth;
        while (*pbucket)
        {
//++depth;
            if ((*pbucket).hash == hash && (*pbucket).name == name)
                return *pbucket;
            pbucket = &(*pbucket).next;
        }
        auto id = new Id(name, hash);
        *pbucket = id;
//++count;
//writefln("%s %s %s", count, depth, cast(string)name);
        return id;
    }

    /****************************
     * Define a macro.
     * Returns:
     *  null if a redefinition error
     */
    static Id* defineMacro(ustring name, ustring[] parameters, ustring text, uint flags)
    {
        //writefln("defineMacro(%s, %s, %s, %s)", cast(string)name, cast(string[])parameters, cast(string)text, flags);
        auto m = pool(name);
        if (m.flags & IDmacro)
        {
            if ((m.flags ^ flags) & (IDdotdotdot | IDfunctionLike) ||
                m.parameters != parameters ||
                m.text != text)
            {
                return null;
            }
            if (((m.flags ^ flags) & IDpredefined) &&
                m.text != text)
            {
                return null;
            }
        }
        m.flags |= IDmacro | flags;
        m.parameters = parameters;
        m.text = text;
        return m;
    }

    uint flags;         // flags are below
    enum
    {
        // Macros
        IDmacro        = 1,     // it's a macro in good standing
        IDdotdotdot    = 2,     // the macro has a ...
        IDfunctionLike = 4,     // the macro has ( ), i.e. is function-like
        IDpredefined   = 8,     // the macro is predefined and cannot be #undef'd
        IDinuse        = 0x10,  // macro is currently being expanded

        // Predefined
        IDlinnum       = 0x20,
        IDfile         = 0x40,
        IDcounter      = 0x80,
    }

    ustring text;         // replacement text of the macro
    ustring[] parameters; // macro parameters

    /* Initialize the predefined macros
     */
    static void initPredefined()
    {
        defineMacro(cast(ustring)"__FILE__", null, null, IDpredefined | IDfile);
        defineMacro(cast(ustring)"__LINE__", null, null, IDpredefined | IDlinnum);
        defineMacro(cast(ustring)"__COUNTER__", null, null, IDpredefined | IDcounter);

        uchar[1+26+1] date;
        time_t t;

        time(&t);
        auto p = cast(ubyte*)ctime(&t);
        assert(p);

        auto len = sprintf(cast(char*)date.ptr,"\"%.24s\"",p);
        defineMacro(cast(ustring)"__TIMESTAMP__", null, date[0..len].idup, IDpredefined);

        len = sprintf(cast(char*)date.ptr,"\"%.6s %.4s\"",p+4,p+20);
        defineMacro(cast(ustring)"__DATE__", null, date[0..len].idup, IDpredefined);

        len = sprintf(cast(char*)date.ptr,"\"%.8s\"",p+11);
        defineMacro(cast(ustring)"__TIME__", null, date[0..len].idup, IDpredefined);
    }

    static size_t getHash(const(uchar)[] name)
    {
        size_t hash = 0;
        while (name.length >= size_t.sizeof)
        {
            hash = hash * 37 + *cast(size_t*)name.ptr;
            name = name[size_t.sizeof .. $];
        }
        foreach (c; name)
            hash = hash * 37 + c;
        return hash;
    }
}
