# Dispatch macro — branch notes

Scratch doc for picking this branch back up in a new session. Delete before merge.

## Goal

Stdlib builtin bodies (e.g. `Strings/upper`, `Collections/split`) are walls of
`if xKind == ... elif xKind == ...` cascades, duplicated for value-mode (push)
and in-place mode (`Literal`/`PathLiteral` → `ensureInPlaceAny()` then mutate).
We're collapsing that with two macros — `dispatch` (no in-place) and
`dispatchWithLiteral` (handles in-place) — that:

1. **Read better** — one clause per kind/kind-pair, no manual mode duplication.
2. **Same-or-better C output** — emits `case xKind` (jump table) where today's
   chained-if compiles to compares-and-gotos. Verify in `.cache/*.c` between
   `////implementation: lib/<name>` and `////end: lib/<name>` markers.
3. **No perf regression** — in-place arms still do field mutation
   (`InPlaced.s = ...`), not `SetInPlaceAny` (which calls `SetSym`).

Both macros live in [`src/vm/lib.nim`](src/vm/lib.nim) (search `macro dispatch*`
and `macro dispatchWithLiteral*`).

## When to use which

- **`dispatch`** — function args don't include `Literal`/`PathLiteral`. No
  in-place branch emitted, no auto-wrap, body is verbatim full statements. For
  predicates, similarity functions, anything where result kind ≠ x-kind.
- **`dispatchWithLiteral`** — function args include `Literal`/`PathLiteral`
  (the in-place case). Auto-wraps unified bodies. Result kind usually matches
  x-kind.

(The names changed at commit `cb7bd3ed1`: `dispatch` used to be the
in-place-aware one. Default name now goes to the simpler macro; the longer
name flags the specialization.)

## DSL — the forms

### `dispatch` (value only)

```nim
# 1-axis or 2-axis, body is verbatim full statements. No auto-wrap.
# No in-place branch emitted.
dispatch:
    Char(c): push(newLogical(c.isUpper()))
    String(s):
        var broken = false
        for ch in runes(s):
            if not ch.isUpper():
                push(VFALSE); broken = true; break
        if not broken: push(VTRUE)

dispatch:
    (String(s), Regex(r)):  push(newLogical(s.startsWith(r)))
    (String(s), String(t)): push(newLogical(s.startsWith(t)))
    (String(s), Char(ch)):  push(newLogical(s.len > 0 and s.runeAtPos(0) == ch))
```

### `dispatchWithLiteral` (value + in-place)

```nim
# 1-axis, unified body. Body is the *payload* (string for String,
# Rune for Char, ValueArray for Block, ...). Macro auto-wraps:
#   value mode    -> push(newKind(<body>))
#   inplace mode  -> InPlaced.<field> = <body>
dispatchWithLiteral:
    String(s): s.toUpper()
    Char(c):   c.toUpper()

# 1-axis on x, body references y / attr-derived vars as free variables.
# Same auto-wrap rules.
dispatchWithLiteral:
    Block(a): toSeq(union(toOrderedSet(a), toOrderedSet(y.a)))

# 2-axis on (x, y), per-mode bodies — fully verbatim, no auto-wrap.
# User writes their own push(...) / SetInPlaceAny(...) / mutation.
dispatchWithLiteral:
    (Char(a), String(t)):
        value:   push(newString($(a) & t))
        inplace: SetInPlaceAny(newString($(a) & t))
    (String(s), String(t)):
        value:   push(newString(s & t))
        inplace: s &= t
```

### Bindings

- `dispatchWithLiteral` value mode + unified body / `value:`: `let s = x.<field>` (immutable).
- `dispatchWithLiteral` in-place mode + unified body: `let s = InPlaced.<field>`, then assignment.
- `dispatchWithLiteral` in-place mode + `inplace:` block: `template s: untyped = InPlaced.<field>`
  (lvalue alias, so `s &= t`, `s.insert(...)` work).
- `dispatch`: always `let` for both x and y bindings.
- `y` binding (2-axis, both macros): always `let` — y is never the in-place target.

### Kind table

Both macros share the same set:

| Kind        | Field   | Constructor      |
|-------------|---------|------------------|
| String      | `s`     | `newString`      |
| Char        | `c`     | `newChar`        |
| Block       | `a`     | `newBlock`       |
| Integer     | `i`     | `newInteger`     |
| Floating    | `f`     | `newFloating`    |
| Logical     | `b`     | `newLogical`     |
| Dictionary  | `d`     | `newDictionary`  |
| Binary      | `n`     | `newBinary`      |
| Range       | `rng`   | `newRange`       |
| Regex       | `rx`    | `newRegex`       |
| Color       | `l`     | `newColor`       |
| Quantity    | `q`     | `newQuantity`    |
| Complex     | `z`     | `newComplex`     |
| Rational    | `rat`   | `newRational`    |
| Object      | `o`     | `newObject`      |
| Date        | `eobj`  | `newDate`        |
| Unit        | `u`     | `newUnit`        |
| Bytecode    | `trans` | `newBytecode`    |
| SymbolLiteral | `m`   | `newSymbolLiteral` |

Note: `Object`'s `newObject` takes a Prototype, not just a `ValueDict`.
Auto-wrap via the unified body won't compile correctly. `Object(o):` clauses
must use per-mode bodies (`value:`/`inplace:`) and write their own
`newObject(...)` or mutate `InPlaced.o` directly. Add more kinds when needed.

## What's converted (so far)

| File                          | Builtin                                    | Macro / Form                                        |
|-------------------------------|--------------------------------------------|-----------------------------------------------------|
| `src/library/Strings.nim`     | `upper`, `lower`, `capitalize`             | `dispatchWithLiteral`, 1-axis unified               |
| `src/library/Strings.nim`     | `escape`, `indent`, `strip`, `translate`, `wordwrap` | `dispatchWithLiteral`, 1-axis unified (attrs as prelude) |
| `src/library/Strings.nim`     | `pad`, `truncate`                          | `bindAttrs` + `dispatchWithLiteral` with `on attr:` |
| `src/library/Strings.nim`     | `replace`                                  | `dispatchWithLiteral`, 3-axis × per-mode            |
| `src/library/Strings.nim`     | `ascii?`, `lower?`, `upper?`, `numeric?`, `whitespace?` | `dispatch`, 1-axis                       |
| `src/library/Strings.nim`     | `prefix?`, `suffix?`                       | `dispatch`, 2-axis with `Regex`                     |
| `src/library/Strings.nim`     | `jaro`, `levenshtein`                      | `dispatch`, 2-axis (single-kind both args)          |
| `src/library/Collections.nim` | `squeeze`                                  | `dispatchWithLiteral`, 1-axis unified, multi-stmt body |
| `src/library/Collections.nim` | `chop`, `drop`                             | `dispatchWithLiteral`, 1-axis unified, references attr-derived `times` |
| `src/library/Collections.nim` | `append`                                   | `dispatchWithLiteral`, 2-axis × per-mode (Object & Block as prelude) |
| `src/library/Collections.nim` | `prepend`                                  | `dispatchWithLiteral`, 2-axis × per-mode + (Block, _) y-wildcard |
| `src/library/Collections.nim` | `insert`                                   | `dispatchWithLiteral`, 3-axis × per-mode + z-wildcards |
| `src/library/Collections.nim` | `keys`, `values`                           | `dispatch`, 1-axis (multi-clause)                   |
| `src/library/Collections.nim` | `flatten`                                  | `bindAttrs` + `dispatchWithLiteral`, per-mode (calls on Value) |
| `src/library/Collections.nim` | `combine`, `permutate`                     | `bindAttrs` + `dispatch` with `on count:` ladder    |
| `src/library/Collections.nim` | `tally`                                    | `dispatch`, 1-axis (String / Block, multi-stmt)     |
| `src/library/Collections.nim` | `first`, `last`                            | `dispatch` with `on n(num: Integer):` arms per kind |
| `src/library/Collections.nim` | `index`                                    | `dispatch`, 1-axis (4 kinds, multi-stmt)            |
| `src/library/Collections.nim` | `rotate`                                   | `bindAttrs` + `dispatchWithLiteral` (String unified, Block per-mode for `rotated`/`rotate` asymmetry) |
| `src/library/Collections.nim` | `pop`, `empty`                             | `(bindAttrs +) dispatchWithLiteral`, inplace-only (x is Literal-only) |
| `src/library/Collections.nim` | `extend`                                   | `dispatchWithLiteral`, 2-axis × per-mode (Dictionary, Dictionary) |
| `src/library/Collections.nim` | `reverse`                                  | `bindAttrs` + `dispatchWithLiteral`, per-mode (alloc/mutate asymmetry) |
| `src/library/Collections.nim` | `unique`                                   | `dispatchWithLiteral` (`.id` short-circuit kept as a prelude — result kind is unrelated to x) |
| `src/library/Collections.nim` | `decouple`, `shuffle`                      | `dispatchWithLiteral`, 1-axis × per-mode (Block) |
| `src/library/Collections.nim` | `slice`                                    | `dispatchWithLiteral`, 1-axis × per-mode (String / Block) |
| `src/library/Collections.nim` | `sample`, `size`                           | `dispatch`, multi-clause                            |
| `src/library/Collections.nim` | `max`, `min`                               | `bindAttrs` + `dispatch` (`index` flag aliased to `withIndex`) |
| `src/library/Collections.nim` | `empty?`, `one?`, `zero?`                  | `dispatch` with `_:` Null fallback                  |
| `src/library/Collections.nim` | `sorted?`                                  | `bindAttrs` + `dispatch`, single Block clause       |
| `src/library/Sets.nim`        | `intersection`, `union`                    | `dispatchWithLiteral`, 1-axis on x, references `y.a` |
| `src/library/Sets.nim`        | `difference`                               | `dispatchWithLiteral` with `on symmetric:` ladder   |
| `src/library/Sets.nim`        | `powerset`                                 | `dispatchWithLiteral`, 1-axis unified               |
| `src/library/Sets.nim`        | `disjoint?`, `intersect?`                  | `dispatch`, 2-axis (Block, Block)                   |
| `src/library/Sets.nim`        | `subset?`, `superset?`                     | `bindAttrs` + `dispatch`, 2-axis (Block, Block) — `proper` flag toggles equal-case |
| `src/library/Collections.nim` | `couple`                                   | `dispatch`, 2-axis (Block, Block)                   |
| `src/library/Statistics.nim`  | `average`                                  | `dispatch`, 2-axis (Block / Range)                  |
| `src/library/Statistics.nim`  | `deviation`, `kurtosis`, `skewness`, `variance` | `dispatch` with `on sample:` toggle           |
| `src/library/Statistics.nim`  | `median`                                   | `dispatch`, 1-axis (Block, multi-stmt)              |
| `src/library/Logic.nim`       | `false?`, `true?`                          | `dispatch` with Logical clause + `_:` fallback      |
| `src/library/Numbers.nim`     | `abs`                                      | `dispatch` over Integer/Floating/Complex/Rational   |
| `src/library/Numbers.nim`     | `angle`, `conj`                            | `dispatch`, single Complex clause                   |
| `src/library/Colors.nim`      | `blend`                                    | `bindAttrs` + `dispatchWithLiteral`, 2-axis × per-mode (RGB return) |
| `src/library/Colors.nim`      | `darken`, `lighten`, `spin`                | `dispatchWithLiteral`, 1-axis unified (VColor return) |
| `src/library/Colors.nim`      | `desaturate`, `grayscale`, `invert`, `saturate` | `dispatchWithLiteral`, 1-axis × per-mode (RGB return — auto-wrap can't assign RGB to `InPlaced.l: VColor`) |
| `src/library/Colors.nim`      | `palette`                                  | `bindAttrs` + `dispatch` with `on attr:` ladder     |
| `src/library/Numbers.nim`     | `reciprocal`, `sign`, `negative?`, `positive?`, `infinite?` | `dispatch`, single-clause + `_:` fallback |
| `src/library/Numbers.nim`     | `sum`, `exp`, `ln`, `sqrt`                 | `dispatch` over numeric kinds                       |
| `src/library/Numbers.nim`     | `denominator`, `numerator`                 | `dispatch`, single Rational clause                  |
| `src/library/Crypto.nim`      | `crc`                                      | `dispatchWithLiteral`, 1-axis unified (String)      |
| `src/library/Crypto.nim`      | `decode`                                   | `dispatchWithLiteral` with `on attr:` (url/from/to) |
| `src/library/System.nim`      | `pause`                                    | `dispatch`, Integer/Quantity                        |
| `src/library/Quantities.nim`  | `property`                                 | `dispatch`, Quantity/Unit                           |
| `src/library/Quantities.nim`  | `conforms?`                                | `dispatch`, 2-axis (Quantity/Unit × Quantity/Unit)  |
| `src/library/Dates.nim`       | `leap?`                                    | `dispatch`, Integer/Date                            |
| `src/library/Dates.nim`       | `after`, `before`                          | `dispatchWithLiteral`, single Date clause × per-mode (helper returns `DateTime`, `InPlaced.eobj` is `ref DateTime`) |
| `src/library/Io.nim`          | `goto`                                     | `dispatch`, Integer + `_:` fallback                 |
| `src/library/Io.nim`          | `input` (non-repl path)                    | `dispatch`, String + `_:` fallback for Null         |
| `src/library/Io.nim`          | `print`, `prints`                          | `dispatch`, Block + `_:` fallback                   |
| `src/library/Logic.nim`       | `and?`, `nand?`, `nor?`, `or?`             | `dispatch`, 2-axis (Logical/Block × Logical/Block)  |
| `src/library/Logic.nim`       | `not?`                                     | `dispatch`, Logical + `_:` fallback                 |
| `src/library/Logic.nim`       | `xnor?`, `xor?`                            | template `asBool` helper (no kind dispatch needed)  |
| `src/library/Strings.nim`     | `render`                                   | `dispatchWithLiteral`, 1-axis unified, `block:` expression |
| `src/library/Strings.nim`     | `join`                                     | `dispatchWithLiteral`, 1-axis × per-mode, attrs as prelude |
| `src/library/Collections.nim` | `array` (non-attr branch)                  | `dispatch`, multi-clause + `_:` fallback            |
| `src/library/Collections.nim` | `dictionary` (source dispatch)             | `dispatch`, Block / String                          |
| `src/library/Bitwise.nim`     | `nand`, `nor`, `xnor`                      | `dispatchWithLiteral` with `_:` fallback (also fixes latent `PathLiteral` bug) |
| `src/library/Files.nim`       | `write` (Bytecode branch)                  | `dispatch`, Bytecode + `_:` fallback                |
| `src/library/Dates.nim`       | `friday?`, `monday?`, `saturday?`, `sunday?`, `thursday?`, `tuesday?`, `wednesday?` | `dispatch`, single Date clause |
| `src/library/Dates.nim`       | `future?`, `past?`, `today?`               | `dispatch`, single Date clause                      |
| `src/library/Core.nim`        | `parse`                                    | `dispatch`, String + `_:` fallback                  |
| `src/library/Core.nim`        | `alias` (symbol-extraction)                | `dispatch`, String / Block + `_:` fallback          |
| `src/library/Core.nim`        | `module` (definitions cascade)             | `dispatch`, Block / Dictionary                      |
| `src/library/Bitwise.nim`     | `shl`                                      | `dispatchWithLiteral` with `_:` fallback            |
| `src/library/Reflection.nim`  | `info`                                     | `dispatch`, SymbolLiteral + `_:` fallback (PathLiteral via xKind check inside fallback) |
| `src/library/Quantities.nim`  | `units`, `scalar`                          | `dispatch`, 2-kind on x with `on base:` ladder (units); single Quantity clause (scalar) |
| `src/library/Collections.nim` | `take`                                     | `dispatchWithLiteral`, 1-axis × per-mode (Range asymmetry: SetInPlaceAny vs field assign) |
| `src/library/Numbers.nim`     | `factorial`, `prime?`, `factors`, `gcd`, `lcm` | `dispatch`, single Integer/Block clause (factors uses `on prime:` ladder) |
| `src/library/Logic.nim`       | `all?`, `any?`                             | `dispatch`, single Block clause                     |
| `src/library/Types.nim`       | `type`                                     | `dispatch`, Object + `_:` fallback (UserType vs builtin) |
| `src/library/Types.nim`       | All trivial type predicates (`string?`, `block?`, `binary?`, `char?`, `color?`, `complex?`, `date?`, `dictionary?`, `floating?`, `logical?`, `object?`, `range?`, `regex?`, `bytecode?`, `unit?`, `symbolLiteral?`, `attribute?`, `attributeLabel?`, `error?`, `errorKind?`, `inline?`, `label?`, `literal?`, `method?`, `path?`, `pathLabel?`, `pathLiteral?`, `socket?`, `store?`, `symbol?`, `version?`, `word?`, `null?`, `type?`, `database?`) | `dispatch`, `KIND(_): push(VTRUE)` + `_: push(VFALSE)` |
| `src/library/Types.nim`       | `integer?`, `quantity?`, `rational?`, `function?` | `dispatch` with kind-specific arm checking the `.big`/`.builtin` flag |

## Plan: features still to add

### 1. ~~`else:` / wildcard clauses~~ — DONE

Syntax: `_:` for top-level x-axis fallback, `_` inside an n-tuple for an
axis-level wildcard. `else:` itself is a Nim keyword and won't parse
standalone in an untyped block, so we use `_` (parses as `nnkIdent "_"`).

```nim
dispatchWithLiteral:
    (Block(a), Block(t)):
        value:   push newBlock(a & t)
        inplace: a.add(t)
    (Block(a), _):
        value:   push newBlock(a & y)
        inplace: a.add(y)
    _:                       # x-axis fallback — body uses x/y directly
        value:   push x
        inplace: discard
```

Top-level `_:` body has no kind-driven bindings or auto-wrap; references
`x`/`y`/`z` directly. Use `value:`/`inplace:` blocks to write mode-specific
fallbacks.

### 2. ~~3-positional args (z binding)~~ — DONE

Tuple-of-3 clauses: `(KIND(b1), KIND(b2), KIND(b3)):`. Either of the y or z
positions may be `_`. The example landed for `insert` (Collections); see
the source.

```nim
dispatchWithLiteral:
    (String(s), Integer(idx), String(val)):
        value:   var copied = s; copied.insert(val, idx); push(newString(copied))
        inplace: s.insert(val, idx)
    (String(s), Integer(idx), Char(ch)): ...
    (Block(a),  Integer(idx), _):     ...   # z-wildcard, body uses `z`
    (Dictionary(d), String(k), _):    ...
```

Generated C: outer `switch (xKind)`, inner `switch (yKind)`, and a final
`switch (zKind)` only when needed (≥2 distinct z-kinds for the same x/y).

### 3. ~~Attributes~~ — DONE

Two complementary forms landed:

#### 3a. `on attr:` clauses nested inside a kind branch

For **mutually-exclusive** attrs. `_:` is the in-ladder fallback (kept
consistent with the dispatch macro's wildcard syntax — `else:` is a Nim
keyword and won't parse standalone in untyped blocks).

```nim
dispatchWithLiteral:
    String(s):
        on words:                splitWhitespace(s)
        on lines:                s.splitLines()
        on path:                 pathSplit(s)
        on by(b: String):        s.split(b)         # value attr with kind binding
        on by(b: Char):          s.split(b)
        on by(b: Regex):         s.split(b)
        on at(i: Integer):       @[s[0..i-1], s[i..^1]]
        _:                       runesOf(s)
```

Semantics:
- `on <attr>:` matches when `hadAttr("<attr>")` is true (boolean).
- `on <attr>(b: KIND):` matches when `checkAttr("<attr>")` is true *and*
  the attr's kind is `KIND`. Inside the body, `b` aliases the attr payload.
- Multiple `on <attr>(b: KIND):` arms with the same attr name are coalesced
  into one `case aAttr.kind:` so the attr is popped only once.
- `_:` is the fallback when no `on` arm matches (distinct from the
  kind-axis `_:` in feature 1).
- Each arm body is auto-wrapped just like a unified body
  (`push(newKind(...))` / `InPlaced.field = ...`).

The whole ladder lives in a labelled `block` with `break` exits, so
matched arms don't fall through to the `_:` body.

#### 3b. `bindAttrs:` prelude block

For **composable** flags. Named `bindAttrs` rather than `attrs` because
`attrs` is shadowed inside a builtin body by `makeBuiltin`'s own `attrs`
parameter.

```nim
bindAttrs:
    padding(with): Char = ' '.Rune       # rename: local `padding` ← attr `with`
    n:             Integer = 4           # local name == attr name
    center:        Logical               # boolean flag → `let center = hadAttr(...)`
    right:         Logical
```

Forms:
- `name: Logical` → `let name = hadAttr("name")`.
- `name: KIND = default` → `var name = default; if checkAttr("name"): name = aName.<field>`.
- `name(attrName): KIND = default` → same, but the attr name and local
  name are distinct (essential when the attr name clashes with a Nim
  keyword like `with`).

**Trap to avoid — local-name = attr-name for booleans:**
`name: Logical` pops the attribute called `"name"`. When adapting code
that prefixes the local (`let doRepeat = hadAttr("repeated")`), drop the
prefix in the converted form — write `repeated: Logical` and reference
`repeated` in the body, *not* `doRepeat: Logical` (which would pop a
non-existent `"doRepeat"` attribute and silently always be false).
Use the renaming form `local(attr): Logical` only when the attr name is
a Nim keyword (`with`, `else`, `case`, …) or genuinely needs to differ.

The same applies to typed attrs: `n: Integer = 4` pops `"n"`, not
`"n_anything"`. When in doubt, the attr name is the bareword in the
left-hand position (or in parens, when the renaming form is used).

#### When to reach for which

- **`on attr:` (3a)** — single attr, when chosen, picks the *whole*
  transformation. (`split`, `escape`, `replace`, `match`.)
- **`bindAttrs:` (3b)** — attrs *modify* a transformation orthogonally,
  combining freely. (`pad`, `truncate`, `levenshtein`, `indent`, `strip`.)
- **Both coexist** — see `pad` (Strings) for the canonical example:
  `bindAttrs` for the composable `with`, `on right:` / `on center:` /
  `_:` for the mutually-exclusive selection.

### 4. Pre-dispatch `InPlaced` access

Niche — only `outdent` hit this so far. The body computes
`indentation(InPlaced.s)` *before* the dispatch case. `dispatchWithLiteral`'s
`ensureInPlaceAny` is called *inside* the case branch, so a manual
pre-`InPlaced` read collides.

**Possible fixes:** (a) expose a helper `srcString()` that returns
`if xKind in {Literal, PathLiteral}: InPlaced.s else: x.s` and is mode-aware;
(b) optionally let `dispatchWithLiteral` do an "early ensure" via a leading
`prelude:` block that runs after `ensureInPlaceAny` but before the per-kind
branches. Postpone until we hit a second example.

## Commit log on this branch (since base `33c649ae8`)

```
7f0bba593  [vm] add dispatch macro for kind+mode builtin bodies
d81ad4082  [Strings] use dispatch macro for `upper`/`lower`
19efa515c  [vm] copy AST nodes when reusing dispatch body across branches
0a2e9b5c7  [Strings] use dispatch macro for `capitalize`
06833e29f  [Collections] use dispatch macro for `squeeze`
a72632e1b  [Collections] use dispatch macro for `chop`/`drop`
c62fb3314  [Sets] use dispatch macro for `intersection`/`union`
9e8839a06  [vm] extend dispatch macro with 2-axis pairs and per-mode bodies
19aabc63e  [vm] make per-mode dispatch bodies fully verbatim (no auto-wrap)
4634b4279  [Collections] use 2-axis dispatch macro for `append`'s String/Char/Binary cases
2642aa753  [Strings] convert `escape` to use dispatch macro
19a0099ad  [Strings] convert `indent` to use dispatch macro
9af7d5162  [Strings] convert `strip` to use dispatch macro
73f70562f  [Strings] convert `translate` to use dispatch macro
11eb48f23  [Strings] convert `wordwrap` to use dispatch macro
98ef68e74  [vm] add Regex to dispatch macro's kind table
afb90c321  [vm] add dispatchValue macro for value-mode-only kind dispatch
944ffdae1  [Strings] convert `jaro` to use dispatchValue macro
c9adb8371  [Strings] convert `levenshtein` to use dispatchValue macro
272f8edb9  [Strings] convert `ascii?` to use dispatchValue macro
d8c96a9b3  [Strings] convert `lower?` to use dispatchValue macro
e57cbd3bd  [Strings] convert `numeric?` to use dispatchValue macro
f7281849a  [Strings] convert `prefix?` to use dispatchValue macro
4b2b7383a  [Strings] convert `suffix?` to use dispatchValue macro
726fc5763  [Strings] convert `upper?` to use dispatchValue macro
6e5778981  [Strings] convert `whitespace?` to use dispatchValue macro
cb7bd3ed1  [vm] rename dispatch -> dispatchWithLiteral, dispatchValue -> dispatch
f48679ad1  [vm] add Color to dispatch macros' kind table
1b9da8dac  [vm] add Quantity to dispatch macros' kind table
c568cdf04  [vm] add Complex to dispatch macros' kind table
cc16eb192  [vm] add Rational to dispatch macros' kind table
7efa7125c  [vm] add Object to dispatch macros' kind table
```

(Memory: bite-sized commits, lowercase, single-segment `[Scope]` tags only.
`[library/Strings]` is wrong — it's `[Strings]`. Backtick function names like
`` `upper` `` but not macro names like `dispatch`/`dispatchWithLiteral` unless
used as a code identifier in the message. Pre-rename commits still say
`dispatchValue macro` — historically accurate, left untouched.)

## Conversion targets after attrs land

Once `else:`, 3-args, and attr support are in:

- **Strings**: ~~`pad`~~, ~~`truncate`~~, `match` (attrs — heavy, marginal benefit),
  ~~`replace`~~ (3-args), `outdent` (pre-dispatch InPlaced — feature 4),
  `join` (path/with/words/lines all produce string from Block — marginal benefit).
- **Collections**: ~~`prepend`~~, `take` (Range + asymmetry — see below),
  `split` (the marquee target — heavy attrs), ~~`first`~~, ~~`last`~~, ~~`pop`~~,
  `sort` (clean rewrite needed per its own TODO), `range` (2-axis numeric
  extraction — marginal benefit), ~~`rotate`~~, `remove` (Object magic),
  ~~`flatten`~~, ~~`combine`~~, ~~`permutate`~~, ~~`tally`~~, ~~`index`~~,
  ~~`keys`~~, ~~`values`~~, ~~`insert`~~, ~~`empty`~~, ~~`extend`~~,
  ~~`reverse`~~, ~~`unique`~~, ~~`decouple`~~, ~~`shuffle`~~, ~~`size`~~,
  ~~`slice`~~, ~~`sample`~~, ~~`max`~~, ~~`min`~~, ~~`empty?`~~, ~~`one?`~~,
  ~~`zero?`~~, ~~`sorted?`~~, `contains?` / `in?` / `key?` (Object magic).
- **Sets**: ~~`difference`~~, ~~`powerset`~~, ~~`disjoint?`~~,
  ~~`intersect?`~~, ~~`subset?`~~, ~~`superset?`~~ (in addition to the
  earlier ~~`intersection`~~ and ~~`union`~~).
- **Colors**: all done — but note that single-kind 1-positional Color funcs
  are *not* always drop-in: ~~`darken`~~, ~~`lighten`~~, ~~`spin`~~ are
  unified-body (their helpers return `VColor`); ~~`saturate`~~,
  ~~`desaturate`~~, ~~`grayscale`~~, ~~`invert`~~ need per-mode bodies
  because their helpers return `RGB` (see below).
- **Bitwise**: `nand`/`nor` are 2-axis but use the existing
  `generateOperationB` macro family; reconciling them with `dispatch` is a
  bigger refactor. Skip until everything else is done.

## Roadmap ahead (post-G1)

G1 (System/Quantities/Dates/Io) is done. Next, in order:

### Phase G2 — Crypto finishers
- `encode` (multi-attr ladder: url/from/to + default base64) — convert with
  `on attr:` ladder over String, mirroring the pattern used by `decode`.
- `digest` (`sha` toggle over String) — `on sha:` ladder.
- `hash` — single Any clause with `string` flag; `bindAttrs` + tiny dispatch.

### Phase G3 — Paths
- `extract` — multi-kind (Color/Date/Quantity/Version/...). Big `on attr:`
  ladder + per-kind clauses.
- `normalize` — String, in-place + value mode. `dispatchWithLiteral`.

### Phase A — Numbers (one commit per builtin)

The big mechanical batch. All single-Floating-or-Complex/Rational shape,
near-trivial:

1. `cos`, `sin`, `tan` — three commits.
2. `cosh`, `sinh`, `tanh` — three commits.
3. `sec`, `csec`, `ctan` + `sech`, `csech`, `ctanh` — six commits.
4. `acos`, `asin`, `atan`, `atanh`, `atan2` (2-axis) — five commits.
5. Arc-secant family: `asec`, `acsec`, `actan` + `asech`, `acsech`, `actanh`
   — six commits.
6. `ceil`, `floor`, `round` — three commits.
7. `log`, `hypot`, `gamma` — three commits (log/hypot are 2-axis).
8. `factorial`, `factors`, `digits` — three commits.
9. `gcd`, `lcm`, `powmod` — three commits (multi-axis).
10. `product`, `clamp`, `random` — three commits.
11. Predicates: `even?`, `odd?`, `prime?` — three commits.

### Deferred / blocked targets

- **`Reflection/info`** — needs `SymbolLiteral` (and ideally `PathLiteral`)
  added to the kind table. `PathLiteral` clashes with the in-place splice
  in `dispatchWithLiteral`; either gate the splice on the absence of an
  explicit `PathLiteral(p):` clause, or add a `dispatch`-only kind table
  extension. Single dedicated commit, post-Phase A.
- **`Strings/match`**, **`Strings/join`** — Phase B (heavy attrs, ad hoc
  body shapes).
- **`Strings/outdent`** — Phase C, blocked on feature 4 (pre-dispatch
  `InPlaced` access).
- **`Collections/take`, `split`, `sort`, `range`** — Phase D.
- **`Collections/remove`, `contains?`, `in?`, `key?`** — Phase E (Object
  magic dispatch).
- **`Logic/and|or|xor|not|nand|nor`**, **`Bitwise/nand|nor`** — separate
  refactor; uses `generateOperationB` family.
- **`Core/alias|call|do|export|function`** — control-flow shaped, not
  value-kind dispatch. Skip.
- **`Types/to`** — kind × Type grid; needs design discussion.

### Functions to *not* naively convert

- ~~**`reverse`**: value uses `reversed(s)` (alloc), inplace uses
  `s.reverse()` (mutate).~~ Done — per-mode bodies handle this cleanly,
  including the Range arm now that Range is in the kind table.
- **`repeat`**: value uses `safeCycle` (deep copy), inplace uses `cycle`
  (refs). Asymmetric on purpose — converting naively would either make
  inplace allocate-copy or value-mode share refs. Discuss before touching.

### Literal-only builtins (no value-mode)

Some builtins (e.g. `pop`) restrict `args.collection` to
`{Literal, PathLiteral}` only — there is no value-mode path at runtime.
`dispatchWithLiteral` still emits both an outer kind switch and the
in-place splice; the outer's String/Block/etc. branches simply never
match. Provide only `inplace:` bodies — the macro fills in `discard`
for the unreachable value-mode arms automatically.

### Auto-wrap requires the body's return type to match the kind's payload

The unified-body auto-wrap emits `push(newKind(<body>))` for value mode and
`InPlaced.<field> = <body>` for in-place mode. The second form will type-
mismatch when the body's expression type differs from the field's type —
even if `newKind(...)` accepts both. This bit us in `Colors`:

- `alterColorValue` returns `VColor` → unified body works for both modes.
- `saturateColor` returns `RGB` → `push(newColor(RGB))` compiles, but
  `InPlaced.l = RGB` doesn't (`InPlaced.l: VColor`). Use per-mode bodies
  with `SetInPlaceAny(newColor(...))` (which wraps and replaces the whole
  Value), preserving the original semantics.

When in doubt, check the helper's signature before using the unified
short form.

## Build / verify

```bash
# Build a side-by-side test binary (memory: build_arturo.md):
./build.nims --dev --as arturo-dispatch

# Run regression tests against the previous build:
diff <(bin/arturo-dispatch test.art) <(bin/arturo-upper-base test.art)

# Inspect generated C for a builtin:
grep -n "implementation: lib/<name>\|end: lib/<name>" \
    .cache/@mlibrary@s<File>.nim.c
sed -n '<start>,<end>p' .cache/@mlibrary@s<File>.nim.c
# Look for `switch (xKind_1) { case ... }` — that's the win vs. baseline's
# chained `if (xKind == X) goto LA15_;` style.
```

Test scripts I've been using live in `/tmp/`:
`upper-test.art`, `dispatch-test.art`, `chop-test.art`, `sets-test.art`,
`append-test.art`, `strings-test.art`, `predicates-test.art`. Re-create as
needed.

## Design notes / pitfalls

- **`copyNimTree` matters**: the macro emits each clause's body in *two*
  branches (value-mode case + in-place sub-case). Without `copyNimTree`,
  Nim's macro expansion misbehaves when the same AST node has two parents.
  See commit `19efa515c`.

- **Per-mode bodies must be verbatim**: the auto-wrap (`push(newKind(...))`)
  works only when the result kind matches the x-kind. For cases like
  `Char + String → String`, auto-wrap would emit `push(newChar(...))` on a
  string payload — silent corruption. Fixed in `19aabc63e`. Lesson: only the
  `dispatchWithLiteral` unified-body short form auto-wraps; once you opt into
  `value:`/`inplace:` (or use `dispatch`), you write the full statement.

- **`dispatch` for non-mutating, non-Literal functions**: emitting the full
  Literal/PathLiteral branch when args don't include them is dead code —
  wasteful in the .c output even if harmless. Always reach for `dispatch`
  first when args are read-only.

- **The C output check is the truth**: a clean-looking macro can still emit
  bad code. Always confirm `switch (xKind_1) { case ... }` (jump table) and
  that the inner work matches the baseline (same `toUpper`/`&`/etc. calls).

- **Object magic dispatch (`magic.fetch(AppendM)`)** doesn't fit the
  kind/kind grid — it needs `pushAttr("inplace", VTRUE)` and a runtime
  procvar call. Keep it as a prelude before `dispatchWithLiteral` (see how
  `append` handles it).

- **Attr-driven body shape changes**: when an attr selects which transformation
  to apply (e.g., `escape.json` vs `escape.regex`), factor the choice into a
  function-pointer prelude (`let escaper: proc(s: string): string = ...`)
  and dispatch on the result. See `escape` for the pattern. (This is the
  *current* workaround; once attr support lands per feature 3, the `on attr:`
  form will be the idiomatic replacement.)
