<img align="left" width="170" src="logo.png">

<h1>Art:uro</h1>

### Simple, modern and powerful<br/>interpreted programming language for super-fast scripting.

---

![GitHub](https://img.shields.io/github/license/arturo-lang/arturo) ![Language](https://img.shields.io/badge/Language-Nim-blueviolet.svg?style=flat-square) ![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/arturo-lang/arturo)

The Language
------------------------------

Arturo is a modern programming language, vaguely inspired by various other ones - including but not limited to Ruby, Haskell, D, SDL, Tcl and Lisp.

It is built on some very simple and straightforward principles:

### Everything is a simple statement

There are no "special" language constructs (*even `if` is nothing but a simple statement*). Everything you see is a statement in the form `ID <expression> <expression> <expression> ...`

### Code is data - and data is code

Arturo can be used both as a data-interchange format and a programming language. Basically all data structures are valid code and all code can be represented as a data structure. Think of it as SDL/Json/YAML/XML combined with the power of Lisp - but without the... sea of opening and closing parentheses.

### Each statement returns a value

Whether what you would consider a "function" or any other statement, it will return a value. If it's a block of code (see: *function*), the last statement's result will be return - unless specified otherwise.

### Functions are first-class citizens

Functions - or blocks of statements enclosed in `{}` - can be anything. Assign them to a symbol/variable, pass them around as arguments to function calls, include them as a dictionary key value, or return them from a function. And of course they can be either named or anonymous/lambda.

### Uniform syntax

As already mentioned, everything is a statement of the form `ID <expressions>`. So, how does this work?

As already mentioned, everything is a statement of the form `ID <expressions>`. So, how does this work?

- Is the ID a new or non-function existing symbol? Then, the right-hand value will be assigned to it
- Is it a function? Then it will be called, with the right-hand values as arguments
- Do you want to use the result of a function call as part of an expression? Just enclose the function call in `$(...)`	E.g.: `print $(reverse #(1 2 3))`

Simple, isn't it?

Getting Started
------------------------------

> ℹ️ For more examples, you may have a look into the folder /examples/rosetta ([all also published @ Rosetta Code](https://rosettacode.org/wiki/Category:Arturo)) or try them out online [via the official Arturo website](https://www.arturo-lang.io).

### Hello World

```
"Hello World"
```

or...

```
print "Hello World"
```

### Declaring some data

```
num 	10
str 	"this is a string"

arrA 	1 2 3
arrB 	"one" "two" "three"
arrC	#(1 2 3)

dict 	#{
	name 	"john"
	surname "doe"
	age 	33
	address #{
		city	"Granada"
		country	"Spain"
	}
}
```

### Declaring a function

```
addNumbers {
	&0 + &1
}
```

or...

```
addNumbers [x,y]{
	x + y
}
```

### Fibonacci

```
maxLimit 20 $(toNumber &0)

fib $(memoize [x]{
	if x<2 { 1 }{
		$(fib x-1) + $(fib x-2)
	} 
})

loop $(range 0 maxLimit) {
	print $(fib &)
}
```

The Library
------------------------------

|  Library  | Function | Description | Syntax |
| :---      | :---     | :---        | :---   |
| array | **all** | check if all elements of array are true or pass the condition of given function | [Array or Array/Function] -> Boolean |
| array | **any** | check if any of the array's elements is true or passes the condition of given function | [Array or Array/Function] -> Boolean |
| array | **avg** | get average value from array | [Array] -> Number or Real |
| array | **count** | count how many of the array's elements is true or passes the condition of given function | [Array or Array/Function] -> Number |
| array | **difference** | get difference of two given arrays | [Array/Array] -> Array |
| array | **filter** | get array after filtering each element using given function | [Array/Function] -> Array |
| array | **first** | get first element from array | [Array] -> Any |
| array | **fold** | fold array using seed value and the given function | [Array/Any/Function] -> Any |
| array | **gcd** | calculate greatest common divisor of values from array | [Array] -> Number |
| array | **intersection** | get intersection of two given arrays | [Array/Array] -> Array |
| array | **join** | get string by joining array elements with given delimiter | [Array/String] -> String |
| array | **last** | get last element from array | [Array] -> Any |
| array | **map** | get array after executing given function for each element | [Array/Function] -> Array |
| array | **max** | get maximum value from array | [Array] -> Number or Real |
| array | **median** | get median value from array | [Array] -> Number or Real |
| array | **min** | get minimum value from array | [Array] -> Number or Real |
| array | **permutations** | get all permutations for given array | [Array] -> Array |
| array | **product** | return product of elements of given array | [Array] -> Number |
| array | **range** | get array from given range (from..to) with optional step | [Number/Number or Number/Number/Number] -> Array |
| array | **sample** | get random sample from given array | [Array or Array/Number] -> Any or Array or Null |
| array | **shuffle** | shuffle given array | [Array] -> Array |
| array | **sort** | sort given array | [Array] -> Array |
| array | **sum** | return sum of elements of given array | [Array] -> Number |
| array | **tail** | get last section of array excluding the first element | [Array] -> Array |
| array | **union** | get union of two given arrays | [Array/Array] -> Array |
| array | **unique** | get array by removing duplicates | [Array] -> Array |
| array | **zip** | return array of element pairs using given arrays | [Array/Array] -> Array |
| collection | **add** | add element to collection | [Array/Any or Dictionary/Any] -> Array or Dictionary |
| collection | **contains** | check if collection contains given element | [String/String or Array/Any or Dictionary/Any] -> Boolean |
| collection | **delete** | delete collection element by using given value | [Array/Any or Dictionary/Any] -> Array or Dictionary |
| collection | **deleteBy** | delete collection element by using given index/key | [Array/Number or Dictionary/String] -> Array or Dictionary |
| collection | **find** | return index of string/element within string/array, or -1 if not found | [String/String or Array/Any] -> Number |
| collection | **get** | get element from collection using given index/key | [Array/Number or Dictionary/String] -> Any |
| collection | **isEmpty** | check if collection is empty | [String or Array or Dictionary] -> Boolean |
| collection | **reverse** | reverse given array or string | [Array or String] -> Array or String |
| collection | **set** | set collection element using given index/key | [Array/Number/Any or Dictionary/String/Any] -> Array or Dictionary |
| collection | **size** | get size of collection | [String or Array or Dictionary] -> Number |
| collection | **slice** | get slice of array/string given a starting and/or end point | [Array/Number or Array/Number/Number or String/Number or String/Number/Number] -> Array or String |
| convert | **toBin** | convert given number to its corresponding binary string value | [Number] -> String |
| convert | **toHex** | convert given number to its corresponding hexadecimal string value | [Number] -> String |
| convert | **toNumber** | convert given value to its corresponding number value | [Real or String or Boolean] -> Number or Real |
| convert | **toOct** | convert given number to its corresponding octal string value | [Number] -> String |
| convert | **toString** | convert given number/boolean/array/dictionary to its corresponding string value | [Number or Real or Boolean or Array or Dictionary] -> String |
| core | **and** | bitwise/logical AND | [Boolean/Boolean or Number/Number] -> Boolean or Number |
| core | **exec** | execute given function with optional array of arguments | [Function or Function/Any...] -> Any |
| core | **if** | if condition is true, execute given function - else optionally execute alternative function | [Boolean/Function or Boolean/Function/Function] -> Any |
| core | **import** | import external source file from path | [String] -> Any |
| core | **inherit** | inherit existing class/dictionary | [String/Dictionary] -> Dictionary |
| core | **input** | read line from stdin | [] -> String or Any |
| core | **lazy** | get a lazy-evaluated expression | [Any] -> Function |
| core | **let** | force assign right-hand value to symbol using string name | [String/Any] ->  |
| core | **log** | print value of given expression to screen, in a readable format | [Any] -> Any |
| core | **loop** | execute given function for each element in array or dictionary, or while condition is true | [Array/Function or Dictionary/Function or Boolean/Function] -> Any |
| core | **memoize** | get a memoized function | [Function] -> Function |
| core | **new** | copy given object and return a new duplicate one | [String or String/Any...] -> Any |
| core | **not** | bitwise/logical NOT | [Boolean or Number] -> Boolean or Number |
| core | **or** | bitwise/logical OR | [Boolean/Boolean or Number/Number] -> Boolean or Number |
| core | **panic** | exit program printing given error message | [String] ->  |
| core | **print** | print value of given expression to screen, optionally suppressing newlines | [Any or Any/Boolean] -> Any |
| core | **return** | return given value | [Any] -> Any |
| core | **trace** | trace executing of given expression | [Any] -> Any |
| core | **unuse** | stop using given namespace(s) | [String or Array] ->  |
| core | **use** | use given namespace(s) | [String or Array] ->  |
| core | **xor** | bitwise/logical XOR | [Boolean/Boolean or Number/Number] -> Boolean or Number |
| crypto | **decodeBase64** | decode given object from base64 | [String] -> String |
| crypto | **encodeBase64** | encode given object to base64 | [String] -> String |
| crypto | **hash** | get hash value for given value | [Any] -> String |
| crypto | **md5** | get MD5 hash of given string data | [String] -> String |
| crypto | **sha256** | get SHA256 hash of given string data | [String] -> String |
| crypto | **sha512** | get SHA512 hash of given string data | [String] -> String |
| csv | **parse** | get object by parsing given CSV string, optionally using headers | [String or String/Boolean] -> Array |
| database | **create** | create new SQLite database using path | [String] -> Dictionary |
| database | **open** | open SQLite database using path | [String] -> Dictionary |
| date | **dateNow** | get current date into string | [] -> String |
| date | **datetimeNow** | get current date and time into string | [] -> String |
| date | **day** | get day from date string | [String] -> String |
| date | **month** | get month from date string | [String] -> String |
| date | **timeNow** | get current time into string | [] -> String |
| date | **timer** | time the execution of a given function in milliseconds | [Function] -> Number |
| dictionary | **hasKey** | check if dictionary has key | [Dictionary/String] -> Boolean |
| dictionary | **keys** | get array of dictionary keys | [Dictionary] -> Array |
| dictionary | **values** | get array of dictionary values | [Dictionary] -> Array |
| file | **exists** | check if file exists at given path | [String] -> Boolean |
| file | **filesize** | get file size of file at given path | [String] -> Number |
| file | **read** | read string from file at given path | [String] -> String |
| file | **write** | write string to file at given path | [String/String] -> Null |
| gui | **app** | create GUI app with given string ID, main window and configuration | [String/Dictionary/Dictionary] -> Number |
| gui | **button** | create GUI button with given title and configuration | [String/Dictionary] -> Dictionary |
| gui | **checkbox** | create GUI checkbox with given title and configuration | [String/Dictionary] -> Dictionary |
| gui | **frame** | create GUI frame with given title and configuration | [String/Dictionary] -> Dictionary |
| gui | **hbox** | create GUI horizontal box with given configuration | [Dictionary] -> Dictionary |
| gui | **hpane** | create GUI horizontal pane with given configuration | [Dictionary] -> Dictionary |
| gui | **label** | create GUI label with given title and configuration | [String/Dictionary] -> Dictionary |
| gui | **tabs** | create GUI tabbed view with given configuration | [Dictionary] -> Dictionary |
| gui | **textfield** | create GUI textfield with given title and configuration | [String/Dictionary] -> Dictionary |
| gui | **vbox** | create GUI vertical box with given configuration | [Dictionary] -> Dictionary |
| gui | **vpane** | create GUI vertical pane with given configuration | [Dictionary] -> Dictionary |
| gui | **window** | create GUI window for given app and configuration | [Dictionary] -> Dictionary |
| html | **markdownToHtml** | convert given markdown string to html | [String] -> String |
| json | **generate** | get JSON string from given object | [Any] -> String |
| json | **parse** | get object by parsing given JSON string | [String] -> Any |
| net | **download** | download string contents from webpage using given URL | [String] -> String |
| net | **post** | perform POST request using given URL and data | [String/String] -> String |
| number | **acos** | get 'acos' for given number | [Number or Real] -> Real |
| number | **acosh** | get 'acosh' for given number | [Number or Real] -> Real |
| number | **asin** | get 'asin' for given number | [Number or Real] -> Real |
| number | **asinh** | get 'asinh' for given number | [Number or Real] -> Real |
| number | **atan** | get 'atan' for given number | [Number or Real] -> Real |
| number | **atanh** | get 'atanh' for given number | [Number or Real] -> Real |
| number | **ceil** | get 'ceil' for given number | [Number or Real] -> Real |
| number | **cos** | get 'cos' for given number | [Number or Real] -> Real |
| number | **cosh** | get 'cosh' for given number | [Number or Real] -> Real |
| number | **even** | check if given number is even | [Number] -> Boolean |
| number | **exp** | get 'exp' for given number | [Number or Real] -> Real |
| number | **floor** | get 'floor' for given number | [Number or Real] -> Real |
| number | **isPrime** | check if given number is prime (uses the Miller-Rabin algorithm) | [Number] -> Boolean |
| number | **ln** | get 'ln' for given number | [Number or Real] -> Real |
| number | **log10** | get 'log10' for given number | [Number or Real] -> Real |
| number | **odd** | check if given number is odd | [Number] -> Boolean |
| number | **primeFactors** | get list of prime factors for given number | [Number] -> Array |
| number | **random** | generate random number in given range (from..to) | [Number/Number] -> Number |
| number | **round** | get 'round' for given number | [Number or Real] -> Real |
| number | **shl** | bitwise left shift | [Number/Number] -> Number |
| number | **shr** | bitwise right shift | [Number/Number] -> Number |
| number | **sin** | get 'sin' for given number | [Number or Real] -> Real |
| number | **sinh** | get 'sinh' for given number | [Number or Real] -> Real |
| number | **sqrt** | get 'sqrt' for given number | [Number or Real] -> Real |
| number | **tan** | get 'tan' for given number | [Number or Real] -> Real |
| number | **tanh** | get 'tanh' for given number | [Number or Real] -> Real |
| path | **createDir** | create directory at given path | [String] -> Boolean |
| path | **currentDir** | get current directory path | [] -> String |
| path | **dir** | get array of directory contents at given path | [ or String] -> Array |
| path | **getDir** | get directory from given path | [String] -> String |
| path | **getExtension** | get extension from given path | [String] -> String |
| path | **getFilename** | get filename from given path | [String] -> String |
| path | **getUrlComponents** | get URL components from given URL | [String] -> Dictionary |
| path | **isDirectory** | check if given path is a directory | [String] -> Boolean |
| path | **isFile** | check if given path is a file | [String] -> Boolean |
| path | **isSymlink** | check if given path is a symlink | [String] -> Boolean |
| path | **normalizePath** | get normalized path from given path | [String] -> String |
| reflection | **object** | get object for given symbol name | [String] -> Any or Null |
| reflection | **pointer** | get pointer location of object | [Any or String] ->  |
| reflection | **symbolExists** | check if given symbol exists | [String] -> Boolean |
| reflection | **syms** | get list of declared symbols | [ or String] ->  |
| reflection | **type** | get type for given object | [Any] -> String |
| string | **capitalize** | capitalize given string | [String] -> String |
| string | **char** | get ASCII character from given char code | [Number] -> String |
| string | **characters** | get string characters as an array | [String] -> Array |
| string | **color** | get colored string using color | [String/String] -> String |
| string | **decodeUrl** | decode the given URL into a UTF-8 string url, optionally ignoring invalid characters | [String or String/Boolean] -> String |
| string | **encodeUrl** | encode the given UTF-8 string url into a URL, optionally ignoring invalid characters | [String or String/Boolean] -> String |
| string | **endsWith** | check if string ends with given string | [String/String] -> Boolean |
| string | **isAlpha** | check if all characters in given string are ASCII letters | [String] -> Boolean |
| string | **isAlphanumeric** | check if all characters in given string are ASCII letters or digits | [String] -> Boolean |
| string | **isControl** | check if all characters in given string are control characters | [String] -> Boolean |
| string | **isDigit** | check if all characters in given string are digits | [String] -> Boolean |
| string | **isLowercase** | check if all characters in given string are lowercase | [String] -> Boolean |
| string | **isMatch** | check if string matches given regex | [String/String] -> Boolean |
| string | **isUppercase** | check if all characters in given string are uppercase | [String] -> Boolean |
| string | **isWhitespace** | check if all characters in given string are whitespace | [String] -> Boolean |
| string | **levenshtein** | get Levenshtein distance between two given strings | [String/String] -> Number |
| string | **lines** | get lines from string as an array | [String] -> Array |
| string | **lowercase** | lowercase given string | [String] -> String |
| string | **matches** | get array of matches for string using given regex | [String/String] -> Array |
| string | **padCenter** | center justify string by adding padding | [String/Number] -> String |
| string | **padLeft** | left justify string by adding padding | [String/Number] -> String |
| string | **padRight** | right justify string by adding padding | [String/Number] -> String |
| string | **replace** | get string by replacing occurences of string with another string | [String/String/String] -> String |
| string | **split** | split string by given separator or regex | [String/String] -> Array |
| string | **startsWith** | check if string starts with given string | [String/String] -> Boolean |
| string | **strip** | strip spaces from given string | [String] -> String |
| string | **uppercase** | uppercase given string | [String] -> String |
| string | **uuid** | generate random UUID string | [] -> String |
| string | **words** | get words from string as an array | [String] -> Array |
| system | **delay** | create system delay with a given duration in milliseconds | [Number] ->  |
| system | **env** | get system environment variables as a dictionary | [] -> Dictionary |
| system | **shell** | execute given shell command | [String] -> String or Boolean |
| system | **spawn** | spawn process using given string and get process id | [String] -> Number |
| system | **thread** | create a background threaded process using given function | [Function] ->  |
| web | **a** | create link with title, reference and configuration | [String/String or String/String/Dictionary] -> Dictionary |
| web | **b** | create bold caption with title and given configuration | [String or String/Dictionary] -> Dictionary |
| web | **body** | create web page body with given contents | [Dictionary] -> Dictionary |
| web | **br** | create a line break tag | [] -> Dictionary |
| web | **cell** | create table cell with contents | [String or String/Dictionary] -> Dictionary |
| web | **css** | create a link or style tag, with the given CSS source | [String] -> Dictionary |
| web | **div** | create div section with contents | [Dictionary] -> Dictionary |
| web | **h1** | create H1 header with title and given configuration | [String or String/Dictionary] -> Dictionary |
| web | **h2** | create H2 header with title and given configuration | [String or String/Dictionary] -> Dictionary |
| web | **h3** | create H3 header with title and given configuration | [String or String/Dictionary] -> Dictionary |
| web | **h4** | create H4 header with title and given configuration | [String or String/Dictionary] -> Dictionary |
| web | **h5** | create H5 header with title and given configuration | [String or String/Dictionary] -> Dictionary |
| web | **h6** | create H6 header with title and given configuration | [String or String/Dictionary] -> Dictionary |
| web | **head** | create web page head with given contents | [Dictionary] -> Dictionary |
| web | **i** | create italic caption with title and given configuration | [String or String/Dictionary] -> Dictionary |
| web | **js** | create a script tag, with the given JavaScript source | [String] -> Dictionary |
| web | **li** | create unordered list item with title and contents | [Dictionary] -> Dictionary |
| web | **meta** | create a meta tag with given name and content | [String/String] -> Dictionary |
| web | **p** | create paragraph with contents | [Dictionary] -> Dictionary |
| web | **page** | create web page with given contents | [Dictionary] -> Dictionary |
| web | **row** | create table row with contents | [Dictionary] -> Dictionary |
| web | **table** | create table with contents | [Dictionary] -> Dictionary |
| web | **ul** | create unordered list section with contents | [Dictionary] -> Dictionary |
| xml | **check** | check integrity of XML input using given string | [String] -> Boolean |
| xml | **test** | check integrity of XML input using given string | [] -> Boolean |
| yaml | **generate** | get YAML string from given object | [Any] -> String |
| yaml | **parse** | get object by parsing given YAML string | [String] -> Any |

Build Instructions
------------------------------

**Prerequisites:**

- Flex
- Bison
- D compiler (DMD, or - for production builds - preferably LDC)
- DUB package manager

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
