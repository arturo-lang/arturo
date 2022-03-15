# Contributing to Arturo
This project is a lovechild of mine. So, if you want to contribute, I would be extremely greatful. :)

*Contributing* could mean a few different things:

- Reporting a bug
- Discussing the current state of the code
- Submitting a fix
- Adding to the official documentation
- Fixing my - possibly tons of - typos or grammar errors
- Proposing new features
- Becoming a maintainer

**In a few words:** all contributions (even if they are just ideas or suggestions) are 100% welcome!

## An overview of the project

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

## Pull Requests
Pull requests are the best way to propose changes to the codebase and we actively encourage them:

1. Fork the repo and create your branch from `master`.
2. If you've added code that should be tested, add tests.
3. If you've changed APIs, update the documentation.
4. Ensure the test suite passes.
5. Make sure your code lints.
6. Issue that pull request!

## Any contributions you make will be under the MIT Software License
In short, when you submit code changes, your submissions are understood to be under the same [MIT License](http://choosealicense.com/licenses/mit/) that covers the project. Feel free to contact the maintainers if that's a concern.

## Report bugs using Github's issues
We use GitHub issues to track public bugs. Report a bug by [opening a new issue](https://github.com/arturo-lang/arturo/issues); it's that easy!

## Write detailed bug reports

**Great Bug Reports** tend to have:

- A quick summary and/or background
- Steps to reproduce
  - Be specific!
  - Give sample code if you can.
- What you expected would happen
- What actually happens
- Notes (possibly including why you think this might be happening, or stuff you tried that didn't work)

People *love* thorough bug reports. I'm not even kidding.

## License
By contributing, you agree that your contributions will be licensed under its MIT License.
