<h1>Art:uro</h1>

### Simple, modern and portable<br>interpreted programming language for efficient scripting.

---

![Total Lines](https://img.shields.io/tokei/lines/github/arturo-lang/arturo?color=purple&style=flat-square) ![Language](https://img.shields.io/badge/Language-Nim-yellow.svg?style=flat-square) ![GitHub](https://img.shields.io/github/license/arturo-lang/arturo?style=flat-square) ![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/arturo-lang/arturo?style=flat-square) [![Build Status](https://img.shields.io/travis/com/arturo-lang/arturo/master?style=flat-square)](https://travis-ci.com/arturo-lang/arturo)

The Language
------------------------------

Arturo is a modern programming language, vaguely inspired by various other ones - including but not limited to Rebol, Forth, Ruby, Haskell, D, SDL, Tcl and Lisp.

The language has been designed following some very simple and straightforward principles:

- Code is just a list of words and symbols
- Words and symbols within a block are interpreted - when needed - according to the context
- No reserved words or keyword - look for them as hard as you can; there are absolutely none

```
print "Hello world!"

loop 1..10 'x [
    if? even? x -> print [x "is even"]
    else        -> print [x "is odd"]
]
```

Simple, isn't it?

The Compiler
------------------------------

The main compiler is implemented in Nim/C as a Bytecode interpreter / Stack-based VM and should run in most architectures.

The main goals are: performance, energy-efficiency and portability. (With that exact order)

How to Build & Install
------------------------------

### Manually

**Prerequisites:**

- Nim compiler
- A modern C compiler

**Build:**

    ./build.sh install

The compiler will be built and installed automatically in your `/usr/local/bin`. (So, make sure the folder is in your `$PATH` variable!)

That's it!

**Run script:**

    arturo <script>

**REPL/Interactive Console:**

    arturo

Editors & IDEs
------------------------------

If you prefer to use some specific editors, we already support the most popular ones:

- **SublimeText**: https://github.com/arturo-lang/art-sublimetext-package
- **Atom**: https://github.com/arturo-lang/art-atom-package
- **Ace Editor**: https://github.com/arturo-lang/art-ace-editor

---

License
------------------------------

MIT License

Copyright (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
