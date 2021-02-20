<img align="left" width="190" src="https://raw.githubusercontent.com/arturo-lang/arturo/master/docs/images/logo.png"/>

<h1>Arturo</h1>

### Simple, expressive and portable<br>interpreted programming language for efficient scripting<br><br>![License](https://img.shields.io/github/license/arturo-lang/arturo?style=flat-square) ![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/arturo-lang/arturo?style=flat-square) ![Total Lines](https://img.shields.io/tokei/lines/github/arturo-lang/arturo?color=purple&style=flat-square) ![Language](https://img.shields.io/badge/language-Nim-6A7FC8.svg?style=flat-square)   [![Build Status](https://img.shields.io/github/workflow/status/arturo-lang/arturo/Linux?style=flat-square)](https://github.com/arturo-lang/arturo/actions) <a href="https://discord.gg/YdVK2CB" target="_blank">![Chat on Discord](https://img.shields.io/discord/765519132186640445?color=orange&label=@Discord&style=flat-square)</a>

---

<!--ts-->
   * [The Language](#the-language)
   * [Documentation](#documentation)
   * [Trying it out](#trying-it-out)
      * [Homebrew](#homebrew)
      * [Manually](#manually)
        * [Prerequisites](#prerequisites)
        * [Build & Install Arturo](#build--install-arturo)
      * [Docker](#docker)
      * [Online](#online)
   * [Editors & IDEs](#editors--ides)
   * [Showcase](#showcase)
   * [Contributing](#contributing)
      * [Roadmap](#roadmap)
      * [Project structure](#project-structure)
      * [The Compiler](#the-compiler)
        * [General schema](#general-schema)
   * [Community](#community)
   * [License](#license)
<!--te-->

---

The Language 
------------------------------

Arturo is an independently-developed, modern programming language, vaguely related to various other ones - including but not limited to Logo, Rebol, Forth, Ruby, Haskell, D, SmallTalk, Tcl, and Lisp.

The language has been designed following some very simple and straightforward principles:

- Code is just a list of words and symbols
- Words and symbols within a block are interpreted - when needed - according to the context
- No reserved words or keywords - look for them as hard as you can; there are absolutely none

```red
factorial: function [n][
	if? n > 0 -> n * factorial n-1
	else 	  -> 1
] 

loop 1..19 [x]->
	print ["Factorial of" x "=" factorial x]
```

Simple, isn't it?

> 💡  For more - working - examples, just have a look into the /examples folder

Documentation
------------------------------

For more information about the language and access to the official Reference, please visit the [Arturo Programming Language Reference](https://github.com/arturo-lang/arturo/wiki) wiki.

|    ![Language Reference](https://github.com/arturo-lang/arturo/wiki/images/getting-started.png)   | ![Language Reference](https://github.com/arturo-lang/arturo/wiki/images/language.png)   |    ![Language Reference](https://github.com/arturo-lang/arturo/wiki/images/terminal.png)    | ![Language Reference](https://github.com/arturo-lang/arturo/wiki/images/library.png) |
|-------------------------|-------------------|-------------------|-------------------------|
|    **[Getting Started](https://github.com/arturo-lang/arturo/wiki/Getting-Started)**   | **[Language Reference](https://github.com/arturo-lang/arturo/wiki/Language)**   |    **[Command Line](https://github.com/arturo-lang/arturo/wiki/Command-Line)**   |    **[Library Reference](https://github.com/arturo-lang/arturo/wiki/Library)**    |


Trying it out
------------------------------

### Homebrew

On OSX, you can easily install it using [Homebrew](https://brew.sh/) as well:

```bash
brew install arturo
```

### Manually

> 💡  Arturo should compile practically everywhere: Windows, Linux, BSD, Mac OS - [even Android](https://github.com/arturo-lang/arturo/issues/65#issuecomment-770723447). If you encounter an issue, or your OS is not supported, drop me a line!

#### Prerequisites

* [Nim compiler](https://nim-lang.org/)<br> 
  if you don't have it installed, all it'll take is 2 simple commands:

      curl https://nim-lang.org/choosenim/init.sh -sSf | sh
      choosenim stable
* Dependencies (for Linux):
   - gtk+-3.0 *(\* needed only for non-mini builds)*
   - webkit2gtk-4.0 *(\* needed only for non-mini builds)*
   - libgmp-dev

#### Build & Install Arturo

**a) via the main build script** (*recommended)

    ./install

The binary will be automatically installed in `~/.arturo/bin`

> 💡  For *mini* builds - that is without GTK dependencies and a tiny bit less library functions - just install via `./install mini`


**b) via Nimble**

    nimble install -Y

The compiler will be built and installed automatically in your `$HOME/.nimble/bin`. (So, make sure the folder is in your `$PATH` variable!)

### Docker

Just use the existing docker image:

	docker run -it arturolang/arturo

or (to run a specific local script):

	docker run -it -v $(pwd):/home arturolang/arturo <yourscript.art>
	
### Online

► ~[arturo-lang.io](http://arturo-lang.io/)~ (Temporarily in maintenance)

<img src="https://raw.githubusercontent.com/arturo-lang/arturo/master/docs/images/demo.gif"/>
    
Editors & IDEs
------------------------------

If you prefer to use some specific editors, check which one is already supported (if your preferred editor is not yet supported, just drop me a line - or help me include it):

- **Visual Studio Code**:   
https://github.com/arturo-lang/art-vscode-package

- **SublimeText**:    
https://github.com/arturo-lang/art-sublimetext-package

- **Vim / Neovim**: (Thanks @xigoi :-))   
https://github.com/xigoi/vim-arturo

Showcase
------------------------------

<p align="center">
	<a href="https://github.com/arturo-lang/grafito"><img align="center" width="250" src="https://raw.githubusercontent.com/arturo-lang/grafito/master/logo.png"></a>    
</p>
<p align="center">
	<a href="https://github.com/arturo-lang/grafito"><b>Portable, Serverless & Lightweight<br>SQLite-based Graph Database</b></a>
</p>


Contributing
------------------------------

Please read [docs/CONTRIBUTING.md](https://github.com/arturo-lang/arturo/blob/master/docs/CONTRIBUTING.md) for more details and the process for submitting pull requests.

**In a few words:** all contributions (even if they are just ideas or suggestions) are 100% welcome!

### Roadmap

The list of things to fix and/or add could be endless. But here is one, a bit prioritized (if you think you can help, you know the way ;-):

- [X] Add support for big number handling (via GMP)
- [ ] Enrich the system library
   - [X] Add built-in support for Databases (Sqlite, etc)
   - [X] Implement HTML module
   - [ ] Add more Server-related features
   - [ ] Implement LaTeX generation module
   - [ ] Add custom grammar parser functionality
- [ ] Optimize and refine the bytecode
- [ ] Improve VM performance
- [X] Add the option of saving intermediate bytecode
- [X] Add support for a package manager
- [ ] Add UI support (via libui? via webview? both?)
- [ ] Explore different uses of Arturo's dialecting capabilities (SDLs)
- [ ] Implement a basic Arturo compiler (written in Arturo :blush:)
- [ ] Go full self-hosted (that's an ambitious one, I know...)

### Project structure

To get an initial idea of the project, here's a brief guide to where is what:

| Location | Description |
|---|---|
| `bin/` | The destination of the final binary after compilation |
| `examples/` | A list of working examples in Arturo |
| `src/` | The main source folder |
| `src/extras/` | 3rd party open-source code used by Arturo |
| `src/helpers/` | Useful helper methods grouped by category and used mostly by library functions |
| `src/library/` | The Arturo standard library functions, grouped by category |
| `src/system/` | Components of the Arturo binary, written in Arturo (the REPL, the packager, etc) |
| `src/vm/` | The Virtual Machine |
| `src/vm/bytecode.nim` | A list of all the VM bytecodes along with their description |
| `src/vm/env.nim` | VM Environment handling (paths, etc) |
| `src/vm/eval.nim` | The evaluator: where the parse tree turns into bytecode instructions |
| `src/vm/exec.nim` | The most important VM module, where the main loop is triggered |
| `src/vm/parse.nim` | The main lexer/parser: turning the initial input into a parse tree, of words, symbols and values |
| `src/vm/stack.nim` | Manipulation code for the different stacks used by the VM |
| `src/vm/value.nim` | The main Value object for our Virtual Machine along with numerous overloads, from initialization methods to printing and basic arithmetic |
| `src/arturo.nim` | The main entry; where all the magic begins |
| `tests/` | Different unit tests |
| `tools/` | Various tools, documentation generation, etc |
| `version/` | Main version & build numbers |

### The Compiler

The main compiler is implemented in Nim/C as a Bytecode interpreter / Stack-based VM and should run in most architectures.

The main goals are: expressiveness, brevity, performance and portability. (With that exact order)

#### General schema

<img src="https://raw.githubusercontent.com/arturo-lang/arturo/master/docs/images/schema.png"/>

Community
------------------------------

In case you want to ask a question, suggest an idea, or practically anything related to Arturo - feel free! Everything and everyone is welcome.

For that, the most convenient place for me would be the [GitHub Issues](https://github.com/arturo-lang/arturo/issues) page.

For questions, quick ideas, and discussing generally the language, there is also a [dedicated Discord Server](https://discord.gg/YdVK2CB) for all things Arturo and a [Gitter community](https://gitter.im/arturo-lang/community) -- which I will hopefully get familiar with at some point (lol).

[![Stargazers over time](https://starchart.cc/arturo-lang/arturo.svg)](https://starchart.cc/arturo-lang/arturo)

License
------------------------------

MIT License

Copyright (c) 2019-2021 Yanis Zafirópulos (aka Dr.Kameleon)

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
