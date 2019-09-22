<img align="left" width="170" src="logo.png">

<h1>Art:uro</h1>

### Simple, modern and powerful<br/>interpreted programming language for super-fast scripting.

---

![License](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square) ![Language](https://img.shields.io/badge/Language-D-red.svg?style=flat-square)

The Language
------------------------------

Arturo is a modern programming language, vaguely inspired by various other ones - including but not limited to Ruby, Haskell, D, SDL, Tcl and Lisp.

It is built on some very simple and straightforward principles:

### - Everything is a simple statement

There are no "special" language constructs (*even `if` is nothing but a simple statement*). Everything you see is a statement in the form `ID <expression> <expression> <expression> ...`

### - Each statement returns a value

Whether what you would consider a "function" or any other statement, it will return a value. If it's a block of code (see: *function*), the last statement's result will be return - unless specified otherwise.

### - Functions are first-class citizens

Functions - or blocks of statements enclosed in `{}` - can be anything. Assign them to a symbol/variable, pass them around as arguments to function calls, include them as a dictionary key value, or return them from a function. And of course they can be either named or anonymous/lambda.

### - Uniform syntax

As already mentioned, everything is a statement of the form `ID <expressions>`. So, how does this work?

- Is your ID predefined? Then if it's a function it'll perform a function call. If it's a different symbol, you'll redefine it.
- Is your ID not defined? Then the right-hand values will be assigned to your ID, pretty much like a regular variable assignment/initialization.
- Do you want to define a constant?  Just suffix your ID with `:` when using it for the first time
- Do you want to use the result of a function call as part of an expression? Just enclose the function call in `$(...)`	E.g.: `print $(reverse #(1 2 3))`


Simple, isn't it?

The Library
------------------------------

- **acos**                 [Number or Real] -> Real
- **acosh**                [Number or Real] -> Real
- **all**                  [Array or Array/Function] -> Boolean
- **and**                  [Boolean/Boolean] -> Boolean
- **any**                  [Array or Array/Function] -> Boolean
- **asin**                 [Number or Real] -> Real
- **asinh**                [Number or Real] -> Real
- **atan**                 [Number or Real] -> Real
- **atanh**                [Number or Real] -> Real
- **avg**                  [Array] -> Number or Real
- **capitalize**           [String] -> String
- **ceil**                 [Number or Real] -> Real
- **characters**           [String] -> Array
- **contains**             [String/String or Array/Any or Dictionary/Any] -> Boolean
- **convert.markdown**     [String] -> String
- **cos**                  [Number or Real] -> Real
- **cosh**                 [Number or Real] -> Real
- **csv.parse**            [String or String/Boolean] -> Array
- **date.now**             [] -> String
- **datetime.now**         [] -> String
- **day**                  [String] -> String
- **delete**               [Array/Any or Dictionary/Any] -> Array or Dictionary
- **delete.by**            [Array/Number or Dictionary/String] -> Array or Dictionary
- **difference**           [Array/Array] -> Array
- **each**                 [Array/Function or Dictionary/Function] -> Any
- **ends.with**            [String/String] -> Boolean
- **env**                  [] -> Dictionary
- **even**                 [Number] -> Boolean
- **exec**                 [Function or Function/Array] -> Any
- **exp**                  [Number or Real] -> Real
- **file.exists**          [String] -> Boolean
- **file.read**            [String] -> String
- **file.write**           [String/String] -> Null
- **filter**               [Array/Function] -> Array
- **first**                [Array] -> Any
- **floor**                [Number or Real] -> Real
- **fold**                 [Array/Any/Function] -> Any
- **gcd**                  [Array] -> Number
- **get**                  [Array/Number or Dictionary/String] -> Any
- **has.key**              [Dictionary/String] -> Boolean
- **hash**                 [Any] -> String
- **if**                   [Boolean/Function or Boolean/Function/Function] -> Any
- **import**               [String] -> Any
- **input**                [] -> String or Any
- **intersection**         [Array/Array] -> Array
- **is.alpha**             [String] -> Boolean
- **is.alphanumeric**      [String] -> Boolean
- **is.control**           [String] -> Boolean
- **is.digit**             [String] -> Boolean
- **is.directory**         [String] -> Boolean
- **is.empty**             [String or Array or Dictionary] -> Boolean
- **is.file**              [String] -> Boolean
- **is.lowercase**         [String] -> Boolean
- **is.match**             [String/String] -> Boolean
- **is.symlink**           [String] -> Boolean
- **is.uppercase**         [String] -> Boolean
- **is.whitespace**        [String] -> Boolean
- **join**                 [Array/String] -> String
- **json.generate**        [Any] -> String
- **json.parse**           [String] -> Any
- **keys**                 [Dictionary] -> Array
- **last**                 [Array] -> Any
- **lazy**                 [Any] -> Function
- **levenshtein**          [String/String] -> Number
- **lines**                [String] -> Array
- **ln**                   [Number or Real] -> Real
- **log10**                	 [Number or Real] -> Real
- **loop**                 [Boolean/Function] -> Any
- **lowercase**            [String] -> String
- **map**                  [Array/Function] -> Array
- **matches**              [String/String] -> Array
- **max**                  [Array] -> Number or Real
- **md5**                      [String] -> String
- **median**               [Array] -> Number or Real
- **memoize**              [Function] -> Function
- **min**                  [Array] -> Number or Real
- **month**                [String] -> String
- **not**                  [Boolean] -> Boolean
- **object**               [String] -> Any
- **odd**                  [Number] -> Boolean
- **or**                   [Boolean/Boolean] -> Boolean
- **pad.center**           [String/Number] -> String
- **pad.left**             [String/Number] -> String
- **pad.right**            [String/Number] -> String
- **path.contents**        [ or String] -> Array
- **path.create**          [String] -> Boolean
- **path.current**         [] -> String
- **path.directory**       [String] -> String
- **path.extension**       [String] -> String
- **path.filename**        [String] -> String
- **path.normalize**       [String] -> String
- **permutations**         [Array] -> Array
- **print**                [Any] -> Any
- **product**              [Array] -> Number
- **random**               [Number/Number] -> Number
- **range**                [Number/Number or Number/Number/Number] -> Array
- **replace**              [String/String/String] -> String
- **return**               [Any] -> Any
- **reverse**              [Array] -> Array
- **round**                [Number or Real] -> Real
- **sample**               [Array or Array/Number] -> Any or Array or Null
- **set**                  [Array/Number/Any or Dictionary/String/Any] -> Array or Dictionary
- **sha256**                   [String] -> String
- **sha512**                   [String] -> String
- **shell**                [String] -> String or Boolean
- **shuffle**              [Array] -> Array
- **sin**                  [Number or Real] -> Real
- **sinh**                 [Number or Real] -> Real
- **size**                 [String or Array or Dictionary] -> Number
- **sort**                 [Array] -> Array
- **spawn**                [String] -> Number
- **split**                [String/String] -> Array
- **sqrt**                 [Number or Real] -> Real
- **starts.with**          [String/String] -> Boolean
- **strip**                [String] -> String
- **sum**                  [Array] -> Number
- **tail**                 [Array] -> Array
- **tan**                  [Number or Real] -> Real
- **tanh**                 [Number or Real] -> Real
- **time.now**             [] -> String
- **to.number**            [String or Boolean] -> Number or Real
- **to.string**            [Number or Real or Boolean or Array or Dictionary] -> String
- **trace**                [Any] -> Any
- **type**                 [Any] -> String
- **union**                [Array/Array] -> Array
- **unique**               [Array] -> Array
- **uppercase**            [String] -> String
- **uuid**                 [] -> String
- **web.post**             [String/String] -> String
- **web.read**             [String] -> String
- **words**                [String] -> Array
- **xml.check**            [String] -> Boolean
- **xor**                  [Boolean/Boolean] -> Boolean
- **yaml.generate**        [Any] -> String
- **yaml.parse**           [String] -> Any
- **zip**                  [Array/Array] -> Array

Build Instructions
------------------------------

**Prerequisites:**

- Flex
- Bison
- D compiler (preferably DMD) + DUB

**Build:**

	dub build --build=release

**Run script:**

	./arturo <script>

**REPL:**

	./arturo -c

Or... Check it out online!
------------------------------

http://arturo-lang.io

---

License
------------------------------

MIT License

Copyright (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)

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
