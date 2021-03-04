v0.9.7.2+
========

- Fixed packager script

v0.9.7.2
========

- Better handling of function arity and function calls
- Added non-string support for `:dictionary` keys
- Added support for custom user-defined types
- Added numerous Rosetta Code examples (and corresponding unit tests)
- Added support for *doublecolon* (`::`) symbols as block-generator syntactic sugar
- Vast improvement of error reporting, avoiding crashes and with much more helpful error messages
- Greatly enhanced REPL - with saveable/restorable history, tab-completions and as-you-type hints
- Updated workflows: added support for Windows & FreeBSD pre-built binaries in Releases & Nightly builds (mini versions)
- Codebase cleanup
- Numerous minor fixes & additions

**Library**

- Collections: added `squeeze`
- Converters: added `with`
- Io: added `cursor`, `goto`, `terminal`
- Sets (new): `intersect`, `union`, `difference`, `subset?`, `superset?`
- System: added `env`
- Added `.code` option for `as`
- Added `.muted` option for `inspect`
- Added `.import` option for `function`
- Added unicode support for `split`
- Added string support for `loop`
- Numerous other additions