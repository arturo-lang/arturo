`warp`: Facebook's C and C++ Preprocessor
-----------------------------------------

`warp` is an open-source preprocessor for the C and C++ programming
languages. We use it at Facebook as a faster replacement of `cpp`,
GNU's preprocessor.

The companion program `warpdrive` drives `warp` in conjunction with
the predefined macros of a few of today's crop of compilers (gcc
4.7.1, gcc 4.8.1, clang 3.2, and clang 3.4).

Currently `warp`'s build has only been tested on CentOS 6. More
officially supported OSs to follow.

Dependencies
------------

You need a D compiler installation, which can be downloaded from
[here](http://dlang.org/download.html). For maximum speed we recommend
using the gdc compiler.

Building and using warp
-----------------------

`warp` by itself is agnostic of the C or C++ dialect implemented by a
particular compiler. It is common for compilers to implicitly define a
number of macros that affect the precompilation process. To help with
that, warp is accompanied by `warpdrive`, a simple driver program that
invokes `warp` with the appropriate `#define`s for a few popular
compilers.

To build warp, use the simple Makefile that's part of the distribution:

    make -j

This will produce `warp` (the core program) and also the drivers
`warpdrive_gcc4_7_1`, `warpdrive_gcc4_8_1`, `warpdrive_clang3_2`,
`warpdrive_clang3_4`, and `warpdrive_clangdev`, each packaged for the
respective compiler and version.

To invoke warp, simply use

    warpdrive <flags> filename

In all likelihood you'll need to use `-I` for adding paths to included
library files (warpdrive doesn't bake those in.)
