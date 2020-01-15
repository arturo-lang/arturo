<h1>Art:uro</h1>

### Simple, modern and powerful<br/>interpreted programming language for super-fast scripting.

---

![GitHub](https://img.shields.io/github/license/arturo-lang/arturo) ![Language](https://img.shields.io/badge/Language-C-blue.svg?style=flat-square) ![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/arturo-lang/arturo)

The Language
------------------------------

Arturo is a modern programming language, vaguely inspired by various other ones - including but not limited to Ruby, Haskell, D, SDL, Tcl and Lisp.

The language has been designed following some very simple and straightforward principles:

### Everything is a simple statement

There are no "special" language constructs. Everything you see is a statement in the form `ID <expression> <expression> <expression> ...`. An assignment is nothing but a labeled statement. `LABEL: <statement>`

### Code is data - and data is code

Arturo can be used both as a data-interchange format and a programming language. Basically all data structures are valid code and all code can be represented as a data structure. Think of it as SDL/Json/YAML/XML combined with the power of Lisp - but without the... sea of opening and closing parentheses.

### Each statement returns a value

Whether what you would consider a "function" or any other statement, it will return a value. If it's a block of code (see: *function*), the last statement's result will be return - unless specified otherwise.

### Uniform syntax

There are 3 types of statements. 
- Simple statements, that work as a function call in the form of `ID <expressions>`
- Expressions (Yes, `1+2` is also a valid statement)
- Labeled statements (see: assignments)  like `a: 2`

**Pro tip:** Do you want to use the result of a statement as part of an expression? Just enclose the function call in square brackets `[...]`	E.g.: `print [reverse @[1,2,3]]`. But don't be fooled: square brackets are nothing but a way to mark an expression's precedence, pretty much like what you'd do with a pair of parentheses.

Simple, isn't it?

The Compiler
------------------------------

The main compiler is implemented in ANSI C (99) as a Bytecode interpreter / Stack-based VM and should run in most architectures.

The main goals are: performance, energy-efficiency and portability. (With that exact order)

How to Build & Install
------------------------------

### Manually

**Prerequisites:**

- Flex & Bison
- GMP library
- A modern C compiler

**Build:**

	sudo ./build.sh

The compiler will be built and installed automatically in your `/usr/local/bin`. (So, make sure the folder is in your `$PATH` variable!)

That's it!

**Run script:**

	arturo <script>

**Compile script:**

	arturo -c <script>

**Execute precompiled object file:**

	arturo -x <object file>

**REPL:**

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

Copyright (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)

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
