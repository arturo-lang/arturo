<img align="left" width="190" src="https://raw.githubusercontent.com/arturo-lang/arturo/master/logo.png"/>

<h1>Arturo</h1>

### Simple, modern and portable<br>interpreted programming language for efficient scripting<br><br>![License](https://img.shields.io/github/license/arturo-lang/arturo?style=flat-square) ![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/arturo-lang/arturo?style=flat-square) ![Total Lines](https://img.shields.io/tokei/lines/github/arturo-lang/arturo?color=purple&style=flat-square) ![Language](https://img.shields.io/badge/language-Nim-orange.svg?style=flat-square)   [![Build Status](https://img.shields.io/travis/com/arturo-lang/arturo/master?style=flat-square)](https://travis-ci.com/arturo-lang/arturo) <a target="_blank" href="https://gitter.im/arturo-lang/community">![Chat](https://img.shields.io/gitter/room/arturo-lang/arturo?color=%238F0000&style=flat-square)</a>

---

<!--ts-->
   * [The Language](#the-language)
   * [Documentation](#documentation)
      * [At a glance](#at-a-glance)
   * [Trying it out](#trying-it-out)
      * [Manually](#manually)
        * [Prerequisites](#prerequisites)
        * [Build & Install Arturo](#build--install-arturo)
      * [Docker](#docker)
      * [Online](#online)
   * [Using the command line](#using-the-command-line)
      * [Run a script](#run-a-script)
      * [Interactive console (REPL)](#interactive-console--repl)
   * [Editors & IDEs](#editors--ides)
   * [Roadmap](#roadmap)
   * [Contributing](#contributing)
      * [Project structure](#project-structure)
      * [The Compiler](#the-compiler)
        * [General schema](#general-schema)
   * [Community](#community)
   * [License](#license)
<!--te-->

---

The Language 
------------------------------

Arturo is a modern programming language, vaguely inspired by various other ones - including but not limited to Rebol, Forth, Ruby, Haskell, D, SmallTalk, Tcl and Lisp.

The language has been designed following some very simple and straightforward principles:

- Code is just a list of words and symbols
- Words and symbols within a block are interpreted - when needed - according to the context
- No reserved words or keywords - look for them as hard as you can; there are absolutely none

```
print "Hello world!"

loop 1..10 'x [
    if? even? x -> print [x "is even"]
    else        -> print [x "is odd"]
]
```

Simple, isn't it?

> 💡  For more - working - examples, just have a look into the /examples folder

Documentation
------------------------------

For more information about the language and for access to the official Reference, please visit the [Arturo Programming Language Reference](https://github.com/arturo-lang/arturo/wiki) wiki.

### At a glance

|    ![Language Reference](https://github.com/arturo-lang/arturo/wiki/images/getting-started.png)   | ![Language Reference](https://github.com/arturo-lang/arturo/wiki/images/language.png)   |    ![Language Reference](https://github.com/arturo-lang/arturo/wiki/images/terminal.png)    | ![Language Reference](https://github.com/arturo-lang/arturo/wiki/images/library.png) |
|-------------------------|-------------------|-------------------|-------------------------|
|    **[Getting Started](https://github.com/arturo-lang/arturo/wiki/Getting-Started)**   | **[Language Reference](https://github.com/arturo-lang/arturo/wiki/Language)**   |    **[Command Line](https://github.com/arturo-lang/arturo/wiki/Command-Line)**   |    **[Library Reference](https://github.com/arturo-lang/arturo/wiki/Library)**    |


Trying it out
------------------------------

### Manually

> 💡  Arturo should compile practically everywhere: Windows, Linux, Mac OS. If you encounter any issue, or your OS is not supported, drop me a line!

#### Prerequisites

* [Nim compiler](https://nim-lang.org/)<br> 
  if you don't have it installed, all it'll take is 2 simple commands:

      curl https://nim-lang.org/choosenim/init.sh -sSf | sh
      choosenim stable

#### Build & Install Arturo
	
    ./build.sh install

The compiler will be built and installed automatically in your `/usr/local/bin`. (So, make sure the folder is in your `$PATH` variable!)

That's it!

### Docker

Just use the existing docker image:

	docker run -it fingidor/arturo-repl
	
### Online

► [arturo-lang.io](http://arturo-lang.io/)

<img src="https://raw.githubusercontent.com/arturo-lang/arturo/master/demo.gif"/>

Using the command line
------------------------------

### Run a script

    arturo <script>

### Interactive console / REPL

    arturo
    
Editors & IDEs
------------------------------

If you prefer to use some specific editors, check which one are already supported (if your preferred editor is not yet supported, just drop me a line - or help me include it):

- **SublimeText**: 
https://github.com/arturo-lang/art-sublimetext-package

Roadmap
------------------------------

The list of things to fix and/or add could be endless. But here is one, a bit prioritized (if you think you can help, you know the way ;-):

- [X] Add support for big number handling (via GMP)
- [ ] Enrich the system library
   - [ ] Add built-in support for Databases (Sqlite, etc)
   - [ ] Implement HTML module
   - [ ] Add more Server-related features
   - [ ] Implement LaTeX generation module
   - [ ] Add custom grammar parser functionality
- [ ] Optimize and refine the bytecode
- [ ] Improve VM performance
- [ ] Add the option of saving intermediate bytecode
- [ ] Add support for package manager
- [ ] Add UI support (via libui? via webview? both?)
- [ ] Explore different uses of Arturo's dialecting capabilities (SDLs)
- [ ] Implement a basic Arturo compiler (written in Arturo :blush:)
- [ ] Go full self-hosted (that's an ambitious one, I know...)

Contributing
------------------------------

Please read [CONTRIBUTING.md](https://github.com/arturo-lang/arturo/blob/master/CONTRIBUTING.md) for more details and the process for submitting pull requests.

**In a few words:** all contributions (even if they are just ideas or suggestions) are 100% welcome!

### Project structure

To get an initial idea of the project, here's a brief guide to where is what:

| Location | Description |
|---|---|
| `bin/` | The destination of the final binary after compilation |
| `examples/` | A list of working examples in Arturo |
| `src/` | The main source folder |
| `src/extras/` | 3rd party open-source code used by Arturo |
| `src/helpers/` | Useful helper methods grouped by category and used mostly by library functions |
| `src/system/` | Components of the Arturo binary, written in Arturo (the REPL, the packager, etc) |
| `src/translator/` | The 2 main translators: parse.nim (to perform the initial lexing and parsing to a block of words and values) and eval.nim (to convert a block of words to bytecode for our VM) |
| `src/vm/` | The Virtual Machine |
| `src/vm/library/` | The Arturo standard library functions, grouped by category |
| `src/vm/bytecode.nim` | A list of all the VM bytecodes along with their description |
| `src/vm/env.nim` | VM Environment handling (paths, etc) |
| `src/vm/exec.nim` | The most important VM module, where the main loop is triggered |
| `src/vm/stack.nim` | Manipulation code for the different stacks used by the VM |
| `src/vm/value.nim` | The main Value object for our Virtual Machine along with numerous overloads, from initialization methods to printing and basic arithmetic |
| `src/arturo.nim` | The main entry; where all the magic begins |
| `tests/` | Different unit tests |
| `tools/` | Various tools, documentation generation, etc |
| `version/` | Main version & build numbers |

### The Compiler

The main compiler is implemented in Nim/C as a Bytecode interpreter / Stack-based VM and should run in most architectures.

The main goals are: performance, energy-efficiency and portability. (With that exact order)

#### General schema
<pre>

                                INPUT

                                  ●
                                  ║  
                                  ║  
                    ┏━━━━━━━━━━━━━╬━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓  
                    ┃   ┌─────────╩─────────┐               ┌────────────────┐   ┃  
                    ┃   │Translator         │               │                │   ┃  
                    ┃   │                   │               │                │   ┃  
                    ┃   │                   │               │    Library     │   ┃  
                    ┃   │                   │               │                │   ┃  
                    ┃   │                   │               │                │   ┃  
                    ┃   │   .─────────.     │               └──────▲──┼──────┘   ┃  
                    ┃   │  (   Parse   )    │                      │  │          ┃  
                    ┃   │   `────┼────'     │                      │  │          ┃  
                    ┃   │        │          │               ┌──────┼──▼──────┐   ┃  
                    ┃   │        │          │               │VM              │   ┃  
                    ┃   │   .────▼────.     │   Bytecode    │   .─────────.  │   ┃  
                    ┃   │  (   Eval    )────┼───────────────┼─▶(   Exec    ) │   ┃  
                    ┃   │   `─────────'     │               │   `─────────'  │   ┃  
                    ┃   │                   │               │                │   ┃  
                    ┃   └───────────────────┘               └────────╦───────┘   ┃  
                    ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╬━━━━━━━━━━━┛  
                                                                     ║  
                                                                     ●  
                      
                                                                   OUTPUT 
</pre>

Community
------------------------------

In case you want to ask a question, suggest an idea, or practically anything related to Arturo - feel free! Everything and everyone is welcome.

For that, the most convenient place for me would be the [GitHub Issues](https://github.com/arturo-lang/arturo/issues) page.

For questions, quick ideas and discussing generally about the language, there is also a [dedicated Discord Server](https://discord.gg/YdVK2CB) for all things Arturo and a [Gitter community](https://gitter.im/arturo-lang/community) -- which I will hopefully get familiar with at some point (lol).

[![Stargazers over time](https://starchart.cc/arturo-lang/arturo.svg)](https://starchart.cc/arturo-lang/arturo)

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
