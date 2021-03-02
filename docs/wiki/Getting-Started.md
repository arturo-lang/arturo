There are different ways to get started with Arturo.  
Pick the one that suits you best and you are ready to go :)

---

- [Manually](#manually)
   * [What you'll need first](#what-youll-need-first)
   * [Build & Install Arturo](#build--install-arturo)
- [Pre-built binaries](#pre-built-binaries)
- [Alternative ways](#alternative-ways)
   * [Docker](#docker)
   * [Homebrew](#homebrew)

---

### Manually

> 💡  Arturo should compile practically everywhere: Windows, Linux, BSD, Mac OS - [even Android](https://github.com/arturo-lang/arturo/issues/65#issuecomment-770723447). If you encounter an issue, or your OS is not supported, drop me a line!

If you want to have the latest cutting-edge version of Arturo, the easiest and most bulletproof way is to build it yourself.

#### What you'll need first

* [Nim compiler](https://nim-lang.org/)<br> 
  if you don't have it installed, all it'll take is 2 simple commands:

      curl https://nim-lang.org/choosenim/init.sh -sSf | sh
      choosenim stable
* Dependencies (*only* for Linux):
   - gtk+-3.0 *(\* needed only for non-mini builds)*
   - webkit2gtk-4.0 *(\* needed only for non-mini builds)*
   - libgmp-dev

#### Build & Install Arturo

What you need to do in order to build Arturo and install it is clone this repo and run the installation script.

All the process in a nutshell:

```bash
git clone https://github.com/arturo-lang/arturo.git
cd arturo
./install
```

After this, Arturo will be installed in `~/.arturo/bin`. Just make sure the aforementioned path is in your `$PATH` as per the installation script instructions.

> 💡  For *mini* builds - that is without GTK dependencies and a tiny bit less library functions - just install via `./install mini`

### Pre-built binaries

Arturo also comes with its own pre-built binaries (for now, for Linux and macOS). All you have to do is download one of them and run it - that's it!

For stable versions, you may check out one of the ["official" releases](https://github.com/arturo-lang/arturo/releases/tag/v0.9.7).

For being as up-to-date as possible, head over to the [Nightlies repo](https://github.com/arturo-lang/nightly/releases/tag/tag-2021-03-02) and simply download the latest release.

### Alternative ways

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