<img align="left" width="190" src="docs/images/logo.png#gh-light-mode-only"/>
<img align="left" width="190" src="docs/images/logo-purple.png#gh-dark-mode-only"/>

<h1>Arturo</h1>

### Simple, expressive & portable<br>programming language for efficient scripting<br><br>![License](https://img.shields.io/github/license/arturo-lang/arturo?style=for-the-badge) ![Language](https://img.shields.io/badge/language-Nim-6A7FC8.svg?style=for-the-badge)   [![Build Status](https://img.shields.io/github/workflow/status/arturo-lang/arturo/Linux?style=for-the-badge)](https://github.com/arturo-lang/arturo/actions) <a href="https://discord.gg/YdVK2CB" target="_blank">![Chat on Discord](https://img.shields.io/discord/765519132186640445?color=orange&label=@Discord&style=for-the-badge)</a>
  
---
 
<!--ts-->
   * [The Language](#the-language)
   * [Documentation](#documentation)
   * [Installation](#installation)
      * [Pre-built binaries](#pre-built-binaries)
      * [The alternative way](#the-alternative-way)
      * [Manually](#manually)
      * [Other methods](#other-methods)
        * [Docker](#docker)
        * [Homebrew](#homebrew)
   * [Showcase](#showcase)
   * [Contributing](#contributing)
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

> ➤ Want to see more?    
>     
> For more - working - examples, just have a look at the [Examples](https://arturo-lang.io/documentation/examples/) in the official website.

Documentation
------------------------------

For more information about the language and access to the library reference, please visit the official [Arturo Programming Language documentation](https://arturo-lang.io/documentation/) website.

| <p align="center"><img width="50%" src="docs/images/icons/getting-started.png#gh-light-mode-only"><img width="50%" src="docs/images/icons/getting-started-white.png#gh-dark-mode-only"></p> | <p align="center"><img width="50%" src="docs/images/icons/in-a-nutshell.png#gh-light-mode-only"><img width="50%" src="docs/images/icons/in-a-nutshell-white.png#gh-dark-mode-only"></p> | <p align="center"><img width="50%" src="docs/images/icons/language.png#gh-light-mode-only"><img width="50%" src="docs/images/icons/language-white.png#gh-dark-mode-only"></p> |
|-------------------------|-------------------|-------------------|
| <p align="center">**[Getting Started](https://arturo-lang.io/documentation/getting-started/)**</p> | <p align="center">**[In A Nutshell](https://arturo-lang.io/documentation/in-a-nutshell/)**</p> | <p align="center">**[Language](https://arturo-lang.io/documentation/language/)**</p> |
| <p align="center"><img width="50%" src="docs/images/icons/command-line.png#gh-light-mode-only"><img width="50%" src="docs/images/icons/command-line-white.png#gh-dark-mode-only"></p> | <p align="center"><img width="50%" src="docs/images/icons/library.png#gh-light-mode-only"><img width="50%" src="docs/images/icons/library-white.png#gh-dark-mode-only"></p> | <p align="center"><img width="50%" src="docs/images/icons/examples.png#gh-light-mode-only"><img width="50%" src="docs/images/icons/examples-white.png#gh-dark-mode-only"></p> |
| <p align="center">**[Command Line](https://arturo-lang.io/documentation/command-line/)**</p> | <p align="center">**[Library](https://arturo-lang.io/documentation/library)**</p> | <p align="center">**[Examples](https://arturo-lang.io/documentation/examples)**</p> |


Installation
------------------------------

### Pre-built binaries

Arturo comes with its own pre-built binaries - for, practically, all OSes - so, technically, it doesn't require any "installation". All you have to do is download one of them and run it - that's it!

&nbsp;&nbsp;&nbsp;&nbsp;
### <p align="center">[⇩ Download Arturo](https://arturo-lang.io/#download)</p>
&nbsp;&nbsp;&nbsp;&nbsp;

> ➤ Wanna be as up-to-date as possible?    
>     
> Head over to the [Nightlies repo](https://github.com/arturo-lang/nightly/releases) and simply download the latest release!

### The alternative way

```bash
curl -sSL https://get.arturo-lang.io | sh
```

For Unix/Mac, you may also copy-paste the code above in your terminal and Arturo's most recent stable version will be automatically installed.
To get the most recent (nightly) build, just use: `curl -sSL https://get.arturo-lang.io/latest | sh`

### Manually

In order to build Arturo manually, you may have a look here at the [instructions here](https://github.com/arturo-lang/arturo/wiki/Building-Arturo).

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

> ➤ Trouble with the installation?    
>    
> If there is any issue with the installation, just let me know (by opening an issue) and I'll try to fix it. In any case, it would be safer to try one of the pre-built binaries.*

Showcase
------------------------------

<p align="center">
	<img align="center" width="250" src="https://raw.githubusercontent.com/arturo-lang/grafito/master/logo.png#gh-light-mode-only"><img align="center" width="250" src="https://raw.githubusercontent.com/arturo-lang/grafito/master/logo-dark.png#gh-dark-mode-only">   
</p>
<p align="center">
	<a href="https://github.com/arturo-lang/grafito"><b>Portable, Serverless & Lightweight<br>SQLite-based Graph Database</b></a>
</p>

---

<p align="center">
	<img align="center" width="250" src="https://raw.githubusercontent.com/arturo-lang/aguila/master/docs/assets/logo.png">  
</p>
<p align="center">
	<a href="https://github.com/arturo-lang/aguila"><b>Modern cross-platform webview-based desktop apps<br>without HTML/CSS/JS</b></a>
</p>

Contributing
------------------------------

Please read [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md) for more details and the process for submitting pull requests.

Community
------------------------------

In case you want to ask a question, suggest an idea, or practically anything related to Arturo - feel free! Everything and everyone is welcome.

For that, the most convenient place for me would be the [GitHub Issues](https://github.com/arturo-lang/arturo/issues) page.

For questions, quick ideas, and discussing generally the language, there is also a [dedicated Discord Server](https://discord.gg/YdVK2CB) for all things Arturo.

<img src="https://starchart.cc/arturo-lang/arturo.svg#gh-light-mode-only">

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
