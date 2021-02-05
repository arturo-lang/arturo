### Functions

---

<!--ts-->
   * [capitalize](#capitalize)
   * [color](#color)
   * [join](#join)
   * [levenshtein](#levenshtein)
   * [lower](#lower)
   * [lower?](#lower?)
   * [match](#match)
   * [numeric?](#numeric?)
   * [pad](#pad)
   * [prefix](#prefix)
   * [prefix?](#prefix?)
   * [render](#render)
   * [replace](#replace)
   * [strip](#strip)
   * [suffix](#suffix)
   * [suffix?](#suffix?)
   * [upper](#upper)
   * [upper?](#upper?)
   * [whitespace?](#whitespace?)
<!--te-->

---


## capitalize

#### Description

Convert given string to capitalized

#### Usage

<pre>
<b>capitalize</b> <ins>string</ins> <i>:string</i> <i>:literal</i>
</pre>

#### Returns

- *:string*
- *:nothing*

#### Examples

```red
print capitalize "hello World"      ; "Hello World"

str: "hello World"
capitalize 'str                     ; str: "Hello World"
```

## color

#### Description

Get colored version of given string

#### Usage

<pre>
<b>color</b> <ins>string</ins> <i>:string</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|rgb|<i>:integer</i>|use specific RGB color|
|bold|<i>:boolean</i>|bold font|
|black|<i>:boolean</i>|black foreground color|
|red|<i>:boolean</i>|red foreground color|
|green|<i>:boolean</i>|green foreground color|
|yellow|<i>:boolean</i>|yellow foreground color|
|blue|<i>:boolean</i>|blue foreground color|
|magenta|<i>:boolean</i>|magenta foreground color|
|cyan|<i>:boolean</i>|cyan foreground color|
|white|<i>:boolean</i>|white foreground color|
|gray|<i>:boolean</i>|gray foreground color|

#### Returns

- *:string*

#### Examples

```red
print color.green "Hello!"                ; Hello! (in green)
print color.red.bold "Some text"          ; Some text (in red/bold)
```

## join

#### Description

Join collection of strings into string

#### Usage

<pre>
<b>join</b> <ins>collection</ins> <i>:literal</i> <i>:block</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|with|<i>:string</i>|use given separator|
|path|<i>:boolean</i>|join as path components|

#### Returns

- *:string*
- *:nothing*

#### Examples

```red
arr: ["one" "two" "three"]
print join arr
; onetwothree

print join.with:"," arr
; one,two,three

join 'arr
; arr: "onetwothree"
```

## levenshtein

#### Description

Calculate Levenshtein distance between given strings

#### Usage

<pre>
<b>levenshtein</b> <ins>stringA</ins> <i>:string</i>
            <ins>stringB</ins> <i>:string</i>
</pre>

#### Returns

- *:integer*

#### Examples

```red
print levenshtein "for" "fur"         ; 1
print levenshtein "one" "one"         ; 0
```

## lower

#### Description

Convert given string to lowercase

#### Usage

<pre>
<b>lower</b> <ins>string</ins> <i>:string</i> <i>:literal</i>
</pre>

#### Returns

- *:string*
- *:nothing*

#### Examples

```red
print lower "hello World, 你好!"      ; "hello world, 你好!"

str: "hello World, 你好!"
lower 'str                           ; str: "hello world, 你好!"
```

## lower?

#### Description

Check if given string is lowercase

#### Usage

<pre>
<b>lower?</b> <ins>string</ins> <i>:string</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
lower? "ñ"               ; => true
lower? "X"               ; => false
lower? "Hello World"     ; => false
lower? "hello"           ; => true
```

## match

#### Description

Get matches within string, using given regular expression

#### Usage

<pre>
<b>match</b> <ins>string</ins> <i>:string</i>
      <ins>regex</ins> <i>:string</i>
</pre>

#### Returns

- *:block*

#### Examples

```red
print match "hello" "hello"             ; => ["hello"]
match "x: 123, y: 456" "[0-9]+"         ; => [123 456]
match "this is a string" "[0-9]+"       ; => []
```

## numeric?

#### Description

Check if given string is numeric

#### Usage

<pre>
<b>numeric?</b> <ins>string</ins> <i>:string</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
numeric? "hello"           ; => false
numeric? "3.14"            ; => true
numeric? "18966"           ; => true
numeric? "123xxy"          ; => false
```

## pad

#### Description

Check if given string consists only of whitespace

#### Usage

<pre>
<b>pad</b> <ins>string</ins> <i>:string</i> <i>:literal</i>
    <ins>padding</ins> <i>:integer</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|center|<i>:boolean</i>|add padding to both sides|
|right|<i>:boolean</i>|add right padding|

#### Returns

- *:string*

#### Examples

```red
pad "good" 10                 ; => "      good"
pad.right "good" 10           ; => "good      "
pad.center "good" 10          ; => "   good   "

a: "hello"
pad 'a 10            ; a: "     hello"
```

## prefix

#### Description

Add given prefix to string

#### Usage

<pre>
<b>prefix</b> <ins>string</ins> <i>:string</i> <i>:literal</i>
       <ins>prefix</ins> <i>:string</i>
</pre>

#### Returns

- *:string*
- *:nothing*

#### Examples

```red
prefix "ello" "h"                  ; => "hello"

str: "ello"
prefix 'str                        ; str: "hello"
```

## prefix?

#### Description

Check if string starts with given prefix

#### Usage

<pre>
<b>prefix?</b> <ins>string</ins> <i>:string</i>
        <ins>prefix</ins> <i>:string</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|regex|<i>:boolean</i>|match against a regular expression|

#### Returns

- *:boolean*

#### Examples

```red
prefix? "hello" "he"          ; => true
prefix? "boom" "he"           ; => false
```

## render

**Alias:** `~`

#### Description

Render template with |string| interpolation

#### Usage

<pre>
<b>render</b> <ins>template</ins> <i>:string</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|single|<i>:boolean</i>|don't render recursively|
|with|<i>:dictionary</i>|use given dictionary for reference|
|template|<i>:boolean</i>|render as a template|

#### Returns

- *:string*
- *:nothing*

#### Examples

```red
x: 2
greeting: "hello"
print ~"|greeting|, your number is |x|"       ; hello, your number is 2

data: #[
    name: "John"
    age: 34
]

print render.with: data 
    "Hello, your name is |name| and you are |age| years old"

; Hello, your name is John and you are 34 years old
```

## replace

#### Description

Add given suffix to string

#### Usage

<pre>
<b>replace</b> <ins>string</ins> <i>:string</i> <i>:literal</i>
        <ins>match</ins> <i>:string</i>
        <ins>replacement</ins> <i>:string</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|regex|<i>:boolean</i>|match against a regular expression|

#### Returns

- *:string*
- *:nothing*

#### Examples

```red
replace "hello" "l" "x"           ; => "hexxo"

str: "hello"
replace 'str "l" "x"              ; str: "hexxo"
```

## strip

#### Description

Strip whitespace from given string

#### Usage

<pre>
<b>strip</b> <ins>string</ins> <i>:string</i> <i>:literal</i>
</pre>

#### Returns

- *:string*
- *:nothing*

#### Examples

```red
strip "  this is a string "        ; => "this is a string"

str: "  some string  "
strip 'str                         ; str: "some string"
```

## suffix

#### Description

Add given suffix to string

#### Usage

<pre>
<b>suffix</b> <ins>string</ins> <i>:string</i> <i>:literal</i>
       <ins>suffix</ins> <i>:string</i>
</pre>

#### Returns

- *:string*
- *:nothing*

#### Examples

```red
suffix "hell" "o"                  ; => "hello"

str: "hell"
suffix 'str                        ; str: "hello"
```

## suffix?

#### Description

Check if string ends with given suffix

#### Usage

<pre>
<b>suffix?</b> <ins>string</ins> <i>:string</i>
        <ins>suffix</ins> <i>:string</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|regex|<i>:boolean</i>|match against a regular expression|

#### Returns

- *:boolean*

#### Examples

```red
suffix? "hello" "lo"          ; => true
suffix? "boom" "lo"           ; => false
```

## upper

#### Description

Convert given string to uppercase

#### Usage

<pre>
<b>upper</b> <ins>string</ins> <i>:string</i> <i>:literal</i>
</pre>

#### Returns

- *:string*
- *:nothing*

#### Examples

```red
print upper "hello World, 你好!"       ; "HELLO WORLD, 你好!"

str: "hello World, 你好!"
upper 'str                           ; str: "HELLO WORLD, 你好!"
```

## upper?

#### Description

Check if given string is uppercase

#### Usage

<pre>
<b>upper?</b> <ins>string</ins> <i>:string</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
upper? "Ñ"               ; => true
upper? "x"               ; => false
upper? "Hello World"     ; => false
upper? "HELLO"           ; => true
```

## whitespace?

#### Description

Check if given string consists only of whitespace

#### Usage

<pre>
<b>whitespace?</b> <ins>string</ins> <i>:string</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
whitespace? "hello"           ; => false
whitespace? " "               ; => true
whitespace? "\n \n"           ; => true
```