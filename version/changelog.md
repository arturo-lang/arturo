v0.9.8.1
========

### Language

- Added new `:rational` type (along with all relevant operations)

### Library

**New**

- Collections: added new `combine`, `decouple` & `rotate` methods
- Iterators: added new `chunk` & `cluster` methods
- Numbers: added new `factorial` method

**Enhancements & Fixes**

- Arithmetic\mod: added support for floating number modulo operations
- Collections\contains?: added `:char` support for string searches
- Collections\in?: added `:char` support for string searches
- Collections\chop: fixed to also work with empty blocks
- Collections\combine: renamed to `couple`
- Collections\drop: fixed to also work with empty blocks
- Collections\first: fixed to also work with empty blocks
- Collections\last: fixed to also work with empty blocks
- Collections\max: added `.index` option
- Collections\min: added `.index` option
- Collections\permutate: re-implemented and now works with a `.by` and `.repeated` option
- Collections\sample: fixed to also work with empty blocks
- Collections\sort: fixed to also work with empty blocks
- Collections\take: fixed to also work with empty blocks
- Converters\to: added support for `:complex` to `:block` conversion
- Core\case: made function with null sets (ø)
- Iterators: all iterator function re-implemented and now work with a `.with` option and also with a `null` param block
- Numbers\product: added `.cartesian` option
- Numbers\range: make function work even with .step =< 0

### Documentation

- Added numerous new Rosetta Code examples
- Minor fixes in existing examples and/or function signatures

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
- Fixed packager script
- Codebase cleanup
- Numerous minor fixes & additions

**Library**

- Collections: added `squeeze`
- Converters: added `with`
- Core: added `unless`, `unless?`
- Io: added `cursor`, `goto`, `terminal`
- Sets (new): `intersect`, `union`, `difference`, `subset?`, `superset?`
- System: added `env`
- Added `.code` option for `as`
- Added `.muted` option for `inspect`
- Added `.import` option for `function`
- Added unicode support for `split`
- Added string support for `loop`
- Numerous other additions
