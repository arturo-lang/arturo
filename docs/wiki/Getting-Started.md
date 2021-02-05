There are different ways to get started with Arturo.  
Pick the one that suits you best and you are ready to go :)

---

- [Homebrew](#homebrew)
- [Manually](#manually)
   * [Prerequisites](#prerequisites)
   * [Build & Install Arturo](#build--install-arturo)
- [Docker](#docker)
- [Online](#online)

---

### Homebrew

On OSX, you can easily install it using [Homebrew](https://brew.sh/) as well:

```bash
brew install arturo
```

### Manually

> 💡  Arturo should compile practically everywhere: Windows, Linux, Mac OS. If you encounter an issue, or your OS is not supported, drop me a line!

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

<img src="https://raw.githubusercontent.com/arturo-lang/arturo/master/docs/demo.gif"/>