<img align="left" width="190" src="https://raw.githubusercontent.com/arturo-lang/arturo/master/docs/images/logo.png"/>

<h1>Arturo</h1>

### Simple, expressive & portable<br>programming language for efficient scripting<br><br>![License](https://img.shields.io/github/license/arturo-lang/arturo?style=for-the-badge) ![Language](https://img.shields.io/badge/language-Nim-6A7FC8.svg?style=for-the-badge)   [![Build Status](https://img.shields.io/github/workflow/status/arturo-lang/arturo/Linux?style=for-the-badge)](https://github.com/arturo-lang/arturo/actions) <a href="https://discord.gg/YdVK2CB" target="_blank">![Chat on Discord](https://img.shields.io/discord/765519132186640445?color=orange&label=@Discord&style=for-the-badge)</a>
  
---
 
<!--ts-->
   * [The Language](#the-language)
   * [Documentation](#documentation)
   * [Installation](#installation)
      * [Pre-built binaries](#pre-built-binaries)
      * [The alternatice way](#the-alternative-way)
      * [Manually](#manually)
      * [Other methods](#other-methods)
        * [Docker](#docker)
        * [Homebrew](#homebrew)
   * [Showcase](#showcase)
   * [Contributing](#contributing)
      * [Roadmap](#roadmap)
      * [Project structure](#project-structure)
      * [The Compiler](#the-compiler)
        * [General schema](#general-schema)
   * [Community](#community)
   * [FAQ](#faq)
   * [License](#license)
<!--te-->

---

The Language 
------------------------------

Arturo is an independently-developed, modern programming language, vaguely related to various other ones - including but not limited to: Logo, Rebol, Forth, Ruby, Haskell, D, SmallTalk, Tcl, and Lisp.

The language has been designed following some very simple and straightforward principles:

- Code is just a list of words, symbols and literal values
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

For more information about the language and access to the library reference, please visit the official [Arturo Programming Language documentation](https://arturo-lang.io/documentation/) website.

|    <p align="center"><img width="60%" src="docs/images/play-circle-bold.png"></p>   | <p align="center"><img width="60%" src="docs/images/hand-pointing-bold.png"></p>   |    <p align="center"><img width="60%" src="docs/images/tree-bold.png"></p>    |
|-------------------------|-------------------|-------------------|
|    **[Getting Started](https://arturo-lang.io/documentation/getting-started/)**   | **[Language](https://arturo-lang.io/documentation/in-a-nutshell/)**   |    **[Language](https://arturo-lang.io/documentation/language/)**   |
| <p align="center"><img width="60%" src="docs/images/terminal-window-bold.png"></p> | <p align="center"><img width="60%" src="docs/images/books-bold.png"></p> | <p align="center"><img width="60%" src="docs/images/flask-bold.png"></p> |
| **[Command Line](https://arturo-lang.io/documentation/getting-started/)** | **[Library](https://arturo-lang.io/documentation/library)** | **[Examples](https://arturo-lang.io/documentation/examples)** |


Installation
------------------------------

### Pre-built binaries

Arturo comes with its own pre-built binaries (for practically, all OSes). All you have to do is download one of them and run it - that's it!

#### [⬇️ Download Arturo now](https://arturo-lang.io/#download)

*For being as up-to-date as possible, head over to the [Nightlies repo](https://github.com/arturo-lang/nightly/releases) and simply download the latest release.

### The alternative way

```bash
curl -sSL https://get.arturo-lang.io | sh
```

For Unix/Mac, you may also copy-paste the code above in your terminal and Arturo's most recent stable version will be automatically installed.
To get the most recent (nightly) build, just use: `curl -sSL https://get.arturo-lang.io/latest | sh`

*If there is any issue with the installation, just let me know and I'll try to fix it. In any case, it would be safer to try one of the pre-built binaries.*

### Manually

In order to build Arturo manually, you may have a look here:

### Other methods

#### Docker

Although it won't cut it, if what you need is the real-deal compiler for everyday use, if you just need a taste of it, the Docker image will absolutely do.

Just use the existing docker image:

	docker run -it arturolang/arturo

or (to run a specific local script):

	docker run -it -v $(pwd):/home arturolang/arturo <yourscript.art>

#### Homebrew

If you are on macOS, you can easily install Arturo using [Homebrew](https://brew.sh/) as well - although I cannot guarantee it will be the latest version:

```bash
brew install arturo
```

Showcase
------------------------------

<p align="center">
	<a href="https://github.com/arturo-lang/grafito"><img align="center" width="250" src="https://raw.githubusercontent.com/arturo-lang/grafito/master/logo.png"></a>    
</p>
<p align="center">
	<a href="https://github.com/arturo-lang/grafito"><b>Portable, Serverless & Lightweight<br>SQLite-based Graph Database</b></a>
</p>

---

<p align="center">
	<a href="https://github.com/arturo-lang/aguila"><img align="center" width="250" src="https://raw.githubusercontent.com/arturo-lang/aguila/master/docs/assets/logo.png"></a>    
</p>
<p align="center">
	<a href="https://github.com/arturo-lang/aguila"><b>Modern cross-platform webview-based desktop apps<br>without HTML/CSS/JS</b></a>
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
- [ ] Explore different uses of Arturo's dialecting capabilities (DSLs)
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

FAQ
------------------------------

**What's in a name?**

In case you're wondering why I went for a programming language with a... Spanish male name, let me shed some light: Arturo was the name of my little pet [Emperor Scorpion](https://en.wikipedia.org/wiki/Emperor_scorpion) - hence the logo -, or *Pandinus Imperator*, who passed away in early 2020. 

Despite being seemingly intimidating - as most scorpions do to those who don't know about the species - he was a very quiet, totally docile, easy-going and noble creature. 

So, the name is a subtle hommage to him; and also a hint as to what this programming language aspires to be.

License
------------------------------

MIT License

Copyright (c) 2019-2022 Yanis Zafirópulos (aka Dr.Kameleon)

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
