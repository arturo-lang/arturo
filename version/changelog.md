v0.9.84
========

### Documentation

- Added numerous new Rosetta Code examples

### Language

- Added flag support for Regex values (`/i`, `/m` & `/s`)
- Identifiers (Word, Literal, etc) can now support underscores (`_`) as well 
- Added literal syntax sypport for Rationals, e.g. `1:2`
- Modified existing `:quantity` type with new syntax
- New `:unit` type

### Library

**New**

- Collections: added new `pop` method
- Core: added new `throws?` method
- Numbers: added new `tau` constant
- Quantities: new module with various new Quantity-related built-in methods (`conforms?`, `convert`, `in`, `property`, `scalar`, `specify`, `units`) along with property-testing predicates (e.g. `length?`, `currency?`, etc) and many built-in physics-related constants (e.g. `avogadroContant`, `bohrRadius`, etc)

**Enhancements, Changes & Fixes**

- Arithmetic: all operations have been sanitized and throw an error in case it's between a non-supported pair of value types, instead of just returning *null*
- Arithmetic\add: fixed for operations between Color values
- Arithmetic\sub: fixed for operations between Color values
- Collections\contains?: added `.deep` option
- Collections\drop: fixed SIGSEGV errors
- Collections\first: made to return ranges for Range values + ability to handle infinite ranges correctly
- Collections\get: fixed to work with String-Range parameters
- Collections\in?: added `.deep` option
- Collections\last: made to return ranges for Range values + ability to handle infinite ranges correctly
- Collections\sort: fixed `.ascii` when working with Literal values
- Collections\split: fixed `.every:` and `.at:` when working with Literal values
- Collections\take: fixed SIGSEGV errors
- Comparison\between?: added support for order-insensitive limits
- Converters\as: fixed `.code` to properly convert Rational or Complex values with negative fields
- Converters\range: disallow zero `.step:` for new ranges
- Converters\to: fixed support for Block/Dictionary/Object/Store to String conversions
- Core\ensure: added `.that:` option (to show user-defined message on failure)
- Core\pop: renamed to `unstack` (`pop` is added as a proper popping function in Collections)
- Files\read: added `.delimiter:` support for CSV's
- Numbers: added Rational value support to most (mainly trigonometric) functions
- Numbers\clamp: made to work with Range values instead of lower/upper limits + better type support
- Statistics\median: fixed bug + better and more efficient implementation
- Strings\match: added support for Char values as needle
- System\arg: converted to built-in method
- System\args: converted to built-in method
- System\config: converted to built-in method
- System\script: converted to built-in method
- System\sys: added info about CPU endianess, current hostname and re-organized returned information

### Misc

- Introduced error messages for extra/stray closing brackets (square, curly or parentheses)
- Added type-checking for built-in function attributes
- Fixed issue with GMP-based BigNum handling on Windows
- Fixed issues with Date values and comparison operators
- Added `auto/complete:` and `auto/hints:` magic variables, to enable setting (or unsetting) autocompletion and hints, respectively, in the REPL console
- Improved error handling for incompatible values within Block parameters
- Better support for parsing "hanging" attributes in pipe'd constructs
- Rationals: added implicit GMP-powered BigNum support and more efficient handling
- Fixed arm64/M1 compilation for macOS
- Better `--update` support

v0.9.82
========

### Documentation

- Added numerous new Rosetta Code examples
- Minor fixes in existing examples and/or function signatures

### Language

- Added new `:rational` type (along with all relevant operations)
- Added new `:quantity` type (measurements + unit support, along with all relevant operations)
- Added new `:range` types (with all relevant `..` operations returning a new Range value)
- Added new `:store` type (persistent dictionary-like storage on disk)
- Added new `:socket` type
- Added scientific notation support for number literals
- Changed scoping rules (most blocks will now be completely scope-less, with the exception of iterators & functions)

### Library

**New**

- Arithmetic: added new `divmod` method
- Collections: added new `combine`, `decouple`, `one?`, `prepend`, `rotate` & `tally` methods
- Comparison: added new `between?` & `compare` methods
- Converters: added new `in` & `store` methods
- Core: added new `coalesce` method
- Dates: added new `sunday?`, `monday?`, `tuesday?`, `wednesday?`, `thursday?`, `friday?` & `saturday` methods
- Files: added new `hidden?`, `move` & `timestamp` methods
- Iterators: added new `arrange`, `chunk`, `cluster`, `collect`, `enumerate`, `gather`, `maximum` & `minimum` methods
- Net: added new `browse` method
- Numbers: added new `clamp`, `denominator`, `factorial`, `infinite?`, `lcm` & `numerator` methods
- Paths: added new `absolute?` method
- Reflection: added new `bytecode?`, `color?`, `complex?`, `object?`, `quantity?`, `rational?`, `range?` & `version?` predicates
- Sets: added new `disjoint?` method
- Sockets: added `accept`, `connect`, `listen`, `receive`, `send`, `send?` & `unplug` methods
- Strings: added new `alphabet`, `match?` & `translate` methods
- System: added new `superuser?` predicate

**Enhancements, Changes & Fixes**

- Arithmetic\dec: added support for Complex numbers
- Arithmetic\inc: added support for Complex numbers
- Arithmetic\mod: added support for floating number modulo operations
- Arithmetic\pow: added support for Rational numbers
- Collections\chop: added `.times:` option & fixed to also work with empty blocks
- Collections\combine: renamed to `couple`
- Collections\contains?: added `.at:` option & `:char` support for string searches
- Collections\drop: fixed to also work with empty blocks
- Collections\first: fixed to also work with empty blocks
- Collections\flatten: added support for Literal values
- Collections\in?: added `.at:` option & `:char` support for string searches
- Collections\last: fixed to also work with empty blocks
- Collections\max: added `.index` option
- Collections\min: added `.index` option
- Collections\permutate: re-implemented and now works with a `.by` and `.repeated` option
- Collections\remove: fixed `.once` & added new `.instance` option
- Collections\reverse: added `.exact` option
- Collections\sample: fixed to also work with empty blocks
- Collections\sort: added `.ascii` option & fixed to also work with empty blocks
- Collections\take: fixed to also work with empty blocks
- Converters\to: added support for `:complex` to `:block` conversion
- Core\case: made function work with null sets (ø)
- Iterators: all iterator methods re-implemented and now work with a `.with` option and also with a `null` param block
- Iterators\filter: added `.first` and `.last` options
- Iterators\select: added `.first`, `.last` and `.n` options
- Numbers: made all trigonometric function work with `:quantity` values
- Numbers\e: renamed back to `epsilon`
- Numbers\infinity: renamed to `infinite`
- Numbers\negative?: added support for Floating, Complex & Rational values
- Numbers\positive?: added support for Floating, Complex & Rational values
- Numbers\product: added `.cartesian` option
- Numbers\range: make function work even with .step =< 0 + moved to Converters
- Reflection\info: show origin module for built-in functions/constants
- Strings\capitalize: added support for `:char` parameters
- Strings\match: better implementation with more options (`once`, `capture`, `named`, `bounds`, `in`, `full`)

### Misc

- Fixed multi-line string handling in REPL
- Fixed thick-arrow-right (`=>`) syntac sugar handling in label + function assignments
- Fixed handling of arithmetic operations between `:floating` values and *big* `:integer` values
- Fixed handling of Unicode, locale-dependent sorting (including non-ASCII languages & sorting using digraphs/trigraphs, e.g. Hungarian)
- Functions in dictionaries are now directly callable (e.g. `dict\f 10`)
- Better support for Bytecode handling (+ built-in compression)
- Various performance-related enhancements (> ~500% performance boost)

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
