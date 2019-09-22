<img align="left" width="170" src="logo.png">

<h1>Art:uro</h1>

### Simple, modern and powerful<br/>interpreted programming language for super-fast scripting.

---

![License](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square) ![Language](https://img.shields.io/badge/Language-D-red.svg?style=flat-square)

The Language
------------------------------

Arturo is a modern programming language, vaguely inspired by various other ones - including but not limited to Ruby, Haskell, D, SDL, Tcl and Lisp.

It is built on some very simple and straightforward principles:

### Everything is a simple statement

There are no "special" language constructs (*even `if` is nothing but a simple statement*). Everything you see is a statement in the form `ID <expression> <expression> <expression> ...`

### Code is data. And data is code.

Arturo can be used both as a data-interchange format and a programming language. Basically or data structures are valid code and all code can be represented as a data structure. Think of it as SDL/Json/YAML/XML combined with the power of Lisp - but without the... sea of opening and closing parentheses.

### Each statement returns a value

Whether what you would consider a "function" or any other statement, it will return a value. If it's a block of code (see: *function*), the last statement's result will be return - unless specified otherwise.

### Functions are first-class citizens

Functions - or blocks of statements enclosed in `{}` - can be anything. Assign them to a symbol/variable, pass them around as arguments to function calls, include them as a dictionary key value, or return them from a function. And of course they can be either named or anonymous/lambda.

### Uniform syntax

As already mentioned, everything is a statement of the form `ID <expressions>`. So, how does this work?

- Is your ID predefined? Then if it's a function it'll perform a function call. If it's a different symbol, you'll redefine it.
- Is your ID not defined? Then the right-hand values will be assigned to your ID, pretty much like a regular variable assignment/initialization.
- Do you want to define a constant?  Just suffix your ID with `:` when using it for the first time
- Do you want to use the result of a function call as part of an expression? Just enclose the function call in `$(...)`	E.g.: `print $(reverse #(1 2 3))`

Simple, isn't it?

The Library
------------------------------

| Function | Description | Syntax |
| :---         | :---      | :---  |
| **acos** | get 'acos' for given number | [Number or Real] -> Real |
| **acosh** | get 'acosh' for given number | [Number or Real] -> Real |
| **all** | check if all elements of array are true or pass the condition of given function | [Array or Array/Function] -> Boolean |
| **and** | if all conditions are true, return true, otherwise return false | [Boolean/Boolean] -> Boolean |
| **any** | check if any of the array's elements is true or passes the condition of given function | [Array or Array/Function] -> Boolean |
| **asin** | get 'asin' for given number | [Number or Real] -> Real |
| **asinh** | get 'asinh' for given number | [Number or Real] -> Real |
| **atan** | get 'atan' for given number | [Number or Real] -> Real |
| **atanh** | get 'atanh' for given number | [Number or Real] -> Real |
| **avg** | get average value from array | [Array] -> Number or Real |
| **capitalize** | capitalize given string | [String] -> String |
| **ceil** | get 'ceil' for given number | [Number or Real] -> Real |
| **characters** | get string characters as an array | [String] -> Array |
| **contains** | check if collection contains given element | [String/String or Array/Any or Dictionary/Any] -> Boolean |
| **convert.markdown** | convert given markdown string to html | [String] -> String |
| **cos** | get 'cos' for given number | [Number or Real] -> Real |
| **cosh** | get 'cosh' for given number | [Number or Real] -> Real |
| **csv.parse** | get object by parsing given CSV string, optionally using headers | [String or String/Boolean] -> Array |
| **date.now** | get current date into string | [] -> String |
| **datetime.now** | get current date and time into string | [] -> String |
| **day** | get day from date string | [String] -> String |
| **delete** | delete collection element by using given value | [Array/Any or Dictionary/Any] -> Array or Dictionary |
| **delete.by** | delete collection element by using given index/key | [Array/Number or Dictionary/String] -> Array or Dictionary |
| **difference** | get difference of two given arrays | [Array/Array] -> Array |
| **ends.with** | check if string ends with given string | [String/String] -> Boolean |
| **env** | get system environment variables as a dictionary | [] -> Dictionary |
| **even** | check if given number is even | [Number] -> Boolean |
| **exec** | execute given function with optional array of arguments | [Function or Function/Array] -> Any |
| **exists** | check if given symbol exists | [String] -> Boolean |
| **exp** | get 'exp' for given number | [Number or Real] -> Real |
| **file.exists** | check if file exists at given path | [String] -> Boolean |
| **file.read** | read string from file at given path | [String] -> String |
| **file.write** | write string to file at given path | [String/String] -> Null |
| **filter** | get array after filtering each element using given function | [Array/Function] -> Array |
| **first** | get first element from array | [Array] -> Any |
| **floor** | get 'floor' for given number | [Number or Real] -> Real |
| **fold** | fold array using seed value and the given function | [Array/Any/Function] -> Any |
| **gcd** | calculate greatest common divisor of values from array | [Array] -> Number |
| **get** | get element from collection using given index/key | [Array/Number or Dictionary/String] -> Any |
| **has.key** | check if dictionary has key | [Dictionary/String] -> Boolean |
| **hash** | get hash value for given value | [Any] -> String |
| **if** | if condition is true, execute given function - else optionally execute alternative function | [Boolean/Function or Boolean/Function/Function] -> Any |
| **import** | import external source file from path | [String] -> Any |
| **input** | read line from stdin | [] -> String or Any |
| **intersection** | get intersection of two given arrays | [Array/Array] -> Array |
| **is.alpha** | check if all characters in given string are ASCII letters | [String] -> Boolean |
| **is.alphanumeric** | check if all characters in given string are ASCII letters or digits | [String] -> Boolean |
| **is.control** | check if all characters in given string are control characters | [String] -> Boolean |
| **is.digit** | check if all characters in given string are digits | [String] -> Boolean |
| **is.directory** | check if given path is a directory | [String] -> Boolean |
| **is.empty** | check if collection is empty | [String or Array or Dictionary] -> Boolean |
| **is.file** | check if given path is a file | [String] -> Boolean |
| **is.lowercase** | check if all characters in given string are lowercase | [String] -> Boolean |
| **is.match** | check if string matches given regex | [String/String] -> Boolean |
| **is.symlink** | check if given path is a symlink | [String] -> Boolean |
| **is.uppercase** | check if all characters in given string are uppercase | [String] -> Boolean |
| **is.whitespace** | check if all characters in given string are whitespace | [String] -> Boolean |
| **join** | get string by joining array elements with given delimiter | [Array/String] -> String |
| **json.generate** | get JSON string from given object | [Any] -> String |
| **json.parse** | get object by parsing given JSON string | [String] -> Any |
| **keys** | get array of dictionary keys | [Dictionary] -> Array |
| **last** | get last element from array | [Array] -> Any |
| **lazy** | get a lazy-evaluated expression | [Any] -> Function |
| **levenshtein** | get Levenshtein distance between two given strings | [String/String] -> Number |
| **lines** | get lines from string as an array | [String] -> Array |
| **ln** | get 'ln' for given number | [Number or Real] -> Real |
| **log10** | get 'log10' for given number | [Number or Real] -> Real |
| **loop** | execute given function for each element in array or dictionary, or while condition is true | [Array/Function or Dictionary/Function or Boolean/Function] -> Any |
| **lowercase** | lowercase given string | [String] -> String |
| **map** | get array after executing given function for each element | [Array/Function] -> Array |
| **matches** | get array of matches for string using given regex | [String/String] -> Array |
| **max** | get maximum value from array | [Array] -> Number or Real |
| **md5** | get MD5 hash of given string data | [String] -> String |
| **median** | get median value from array | [Array] -> Number or Real |
| **memoize** | get a memoized function | [Function] -> Function |
| **min** | get minimum value from array | [Array] -> Number or Real |
| **month** | get month from date string | [String] -> String |
| **not** | if the conditions is true, return false, otherwise return true | [Boolean] -> Boolean |
| **object** | get object for given symbol name | [String] -> Any or Null |
| **odd** | check if given number is odd | [Number] -> Boolean |
| **or** | if any one of the conditions is true, return true, otherwise return false | [Boolean/Boolean] -> Boolean |
| **pad.center** | center justify string by adding padding | [String/Number] -> String |
| **pad.left** | left justify string by adding padding | [String/Number] -> String |
| **pad.right** | right justify string by adding padding | [String/Number] -> String |
| **panic** | exit program printing given error message | [String] ->  |
| **path.contents** | get array of directory contents at given path | [ or String] -> Array |
| **path.create** | create directory at given path | [String] -> Boolean |
| **path.current** | get current directory path | [] -> String |
| **path.directory** | get directory from given path | [String] -> String |
| **path.extension** | get extension from given path | [String] -> String |
| **path.filename** | get filename from given path | [String] -> String |
| **path.normalize** | get normalized path from given path | [String] -> String |
| **permutations** | get all permutations for given array | [Array] -> Array |
| **print** | print value of given expression to screen | [Any] -> Any |
| **product** | return product of elements of given array | [Array] -> Number |
| **random** | generate random number in given range (from..to) | [Number/Number] -> Number |
| **range** | get array from given range (from..to) with optional step | [Number/Number or Number/Number/Number] -> Array |
| **replace** | get string by replacing occurences of string with another string | [String/String/String] -> String |
| **return** | return given value | [Any] -> Any |
| **reverse** | reverse given array | [Array] -> Array |
| **round** | get 'round' for given number | [Number or Real] -> Real |
| **sample** | get random sample from given array | [Array or Array/Number] -> Any or Array or Null |
| **set** | set collection element using given index/key | [Array/Number/Any or Dictionary/String/Any] -> Array or Dictionary |
| **sha256** | get SHA256 hash of given string data | [String] -> String |
| **sha512** | get SHA512 hash of given string data | [String] -> String |
| **shell** | execute given shell command | [String] -> String or Boolean |
| **shuffle** | shuffle given array | [Array] -> Array |
| **sin** | get 'sin' for given number | [Number or Real] -> Real |
| **sinh** | get 'sinh' for given number | [Number or Real] -> Real |
| **size** | get size of collection | [String or Array or Dictionary] -> Number |
| **sort** | sort given array | [Array] -> Array |
| **spawn** | spawn process using given string and get process id | [String] -> Number |
| **split** | split string by given separator or regex | [String/String] -> Array |
| **sqrt** | get 'sqrt' for given number | [Number or Real] -> Real |
| **starts.with** | check if string starts with given string | [String/String] -> Boolean |
| **strip** | strip spaces from given string | [String] -> String |
| **sum** | return sum of elements of given array | [Array] -> Number |
| **tail** | get last section of array excluding the first element | [Array] -> Array |
| **tan** | get 'tan' for given number | [Number or Real] -> Real |
| **tanh** | get 'tanh' for given number | [Number or Real] -> Real |
| **time.now** | get current time into string | [] -> String |
| **to.number** | convert given value to its corresponding number value | [Real or String or Boolean] -> Number or Real |
| **to.string** | convert given number/boolean/array/dictionary to its corresponding string value | [Number or Real or Boolean or Array or Dictionary] -> String |
| **trace** | trace executing of given expression | [Any] -> Any |
| **type** | get type for given object | [Any] -> String |
| **union** | get union of two given arrays | [Array/Array] -> Array |
| **unique** | get array by removing duplicates | [Array] -> Array |
| **uppercase** | uppercase given string | [String] -> String |
| **uuid** | generate random UUID string | [] -> String |
| **web.post** | perform POST request using given URL and data | [String/String] -> String |
| **web.read** | download string contents from webpage using given URL | [String] -> String |
| **words** | get words from string as an array | [String] -> Array |
| **xml.check** | check integrity of XML input using given string | [String] -> Boolean |
| **xor** | if only one of the conditions is true, return true, otherwise return false | [Boolean/Boolean] -> Boolean |
| **yaml.generate** | get YAML string from given object | [Any] -> String |
| **yaml.parse** | get object by parsing given YAML string | [String] -> Any |
| **zip** | return array of element pairs using given arrays | [Array/Array] -> Array |

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
