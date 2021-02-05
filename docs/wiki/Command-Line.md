The command line is where the whole journey starts: whether you want to try out something fast in the REPL, or run a script. Or even install extern packages directly.

---

- [Using the command line](#using-the-command-line)
   * [Run a script](#run-a-script)
   * [Start the interactive console](#start-the-interactive-console)
   * [Working with bytecode](#working-with-bytecode)
- [Package manager](#package-manager)
   * [List available modules](#list-available-modules)
   * [List remote modules](#list-remote-modules)
   * [Get module info](#get-module-info)
   * [Install a new module](#install-a-new-module)
   * [Uninstall a module](#uninistall-an-existing-module)
   * [Update existing modules](#update-existing-modules)

---

### Using the command line

#### Run a script

To run an Arturo script, all you have to do is pass the main script's path to Arturo:

    arturo <script>

#### Start the interactive console

To start the interactive console (see: *REPL*), just open up your terminal and type:

    arturo

This is is what Arturo's interactive console looks like:

![REPL](https://github.com/arturo-lang/arturo/wiki/images/repl.png)

Here you may easily try things out and see things first hand. :)

#### Working with bytecode

Since Arturo is, internally, a bytecode-based VM, it also allows you to save and read bytecode directly. 

> 💡 Bytecode, also termed portable code or p-code, is a form of instruction set designed for efficient execution by a software interpreter. Unlike human-readable source code, bytecodes are compact numeric codes, constants, and references (normally numeric addresses) that encode the result of compiler parsing and performing semantic analysis of things like type, scope, and nesting depths of program objects.

This way, you will be able to share your code, without sharing your source, or accelerate your script's execution (since when reading a bytecode file in, the initial parsing & evaluation phase has already been completed).

##### To write a bytecode file from a script:

```bash
arturo -o path/to/your/script.art
```

This will output a `path/to/your/script.art.bcode` file.

##### To read and execute a bytecode file:

```bash
arturo -i path/to/your/script.art.bcode
```

### Package manager

Although Arturo's philosophy is batteries-included - so you'll most likely need nothing that is not already included - Arturo also comes with a ready-to-use package manager, to make your life even easier.

#### List available modules

To list all available modules, just type:

    arturo -m list

This will show you all the modules you have installed locally.

It looks like this:

![Module listing](https://github.com/arturo-lang/arturo/wiki/images/module_list.png)

#### List remote modules

If you want to fetch a list of *all* modules available to download from the [official repository](https://github.com/arturo-lang/art-modules), just type:

    arturo -m remote

#### Get module info

Have you spotted a module you like and want to know more about it? That's easy:

    arturo -m info html

#### Install a new module

When you have finally decided you want to install a module, it's also easy:

    arturo -m install html

#### Uninstall a module

In order to uninstall a module you have previously, you just have to type:

    arturo -m uninstall html

#### Update existing modules

If you want to update all of your local modules, there's no reason to uninstall/re-install anything. Just type:

    arturo -m update

And *all* of your modules will be automatically up-to-date.


