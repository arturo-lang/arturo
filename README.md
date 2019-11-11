<h1>Art:uro</h1>

### Simple, modern and powerful<br/>interpreted programming language for super-fast scripting.

---

![GitHub](https://img.shields.io/github/license/arturo-lang/arturo) ![Language](https://img.shields.io/badge/Language-Nim-blueviolet.svg?style=flat-square) ![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/arturo-lang/arturo)

The Language
------------------------------

Arturo is a modern programming language, vaguely inspired by various other ones - including but not limited to Ruby, Haskell, D, SDL, Tcl and Lisp.

It is built on some very simple and straightforward principles:

### Everything is a simple statement

There are no "special" language constructs (*even `if` is nothing but a simple statement*). Everything you see is a statement in the form `ID <expression> <expression> <expression> ...`. An assignment is nothing but a labeled statement. `LABEL: <statement>`

### Code is data - and data is code

Arturo can be used both as a data-interchange format and a programming language. Basically all data structures are valid code and all code can be represented as a data structure. Think of it as SDL/Json/YAML/XML combined with the power of Lisp - but without the... sea of opening and closing parentheses.

### Each statement returns a value

Whether what you would consider a "function" or any other statement, it will return a value. If it's a block of code (see: *function*), the last statement's result will be return - unless specified otherwise.

### Functions are first-class citizens

Functions - or blocks of statements enclosed in `{}` - can be anything. Assign them to a symbol/variable, pass them around as arguments to function calls, include them as a dictionary key value, or return them from a function. And of course they can be either named or anonymous/lambda.

### Uniform syntax

There are 3 types of statements. 
- Simple statements, that work as a function call in the form of `ID <expressions>`
- Expressions (Yes, `1+2` is also a valid statement)
- Labeled statements (see: assignments)  like `a: 2`

Pro tip: Do you want to use the result of a statement as part of an expression? Just enclose the function call in square brackets `[...]`	E.g.: `print [reverse #(1 2 3)]`

Simple, isn't it?

Getting Started
------------------------------

> ℹ️ For more examples, you may have a look into the folder /examples/rosetta ([all also published @ Rosetta Code](https://rosettacode.org/wiki/Category:Arturo)) or try them out online [via the official Arturo website](https://www.arturo-lang.io).

### Hello World

```
print "Hello World"
```

### Declaring some data

```
num: 	10
str: 	"this is a string"

arr: 	#("one" "two" "three")
arrB:	#(1 2 3)

dict: 	#{
	name: 		"john"
	surname: 	"doe"
	age: 		33
	address: #{
		city:		"Granada"
		country:	"Spain"
	}
}
```

### Declaring a function

```
addNumbers: {
	&0 + &1
}
```

or...

```
addNumbers: @(x y){
	x + y
}
```

### Fibonacci

```
maxLimit: 10

fib: @(x){
	if x<2 { 1 }{
		[fib x-1] + [fib x-2]
	} 
}

loop 0..maxLimit {
	print [fib &]
}
```

The Library
------------------------------

|  Library  | Function | Description | Syntax |
| :---      | :---     | :---        | :---   |
| math | **abs** | get absolute value from given value | (int) -> [int]|
| path | **absolutePath** | get absolute path from given path | (str) -> [str]|
| path | **absolutePath!** | get absolute path from given path (in-place) | (str) -> [str]|
| math | **acos** | get the inverse cosine of given value | (real) -> [real]|
| math | **acosh** | get the inverse hyperbolic cosine of given value | (real) -> [real]|
| array | **all** | check if all elements of array are true or pass the condition of given function | (array) / (array,func) -> [bool]|
| logical | **and** | bitwise/logical AND | (bool,bool) / (int,int) -> [bool,int]|
| array | **any** | check if any elements of array are true or pass the condition of given function | (array) / (array,func) -> [bool]|
| generic | **append** | append element to given array/string | (array,any) / (str,str) -> [array,str]|
| generic | **append!** | append element to given array/string (in-place) | (array,any) / (str,str) -> [array,str]|
| math | **asin** | get the inverse sine of given value | (real) -> [real]|
| math | **asinh** | get the inverse hyperbolic sine of given value | (real) -> [real]|
| math | **atan** | get the inverse tangent of given value | (real) -> [real]|
| math | **atanh** | get the inverse hyperbolic tangent of given value | (real) -> [real]|
| math | **avg** | get average value from given array | (array) -> [real]|
| string | **capitalize** | capitalize given string | (str) -> [str]|
| string | **capitalize!** | capitalize given string (in-place) | (str) -> [str]|
| math | **ceil** | get the smallest number greater than or equal to given value | (real) -> [real]|
| string | **char** | get ASCII character from given char code | (int) -> [str]|
| string | **chars** | get string characters as an array | (str) -> [array]|
| terminal | **clear** | clear screen and move cursor to home | (null) -> [null]|
| generic | **contains** | check if collection contains given element | (array,any) / (dict,any) / (str,str) -> [bool]|
| path | **copyDir** | copy directory at path to given destination | (str,str) -> [bool]|
| path | **copyFile** | copy file at path to given destination | (str,str) -> [bool]|
| math | **cos** | get the cosine of given value | (real) -> [real]|
| math | **cosh** | get the hyperbolic cosine of given value | (real) -> [real]|
| array | **count** | get number of elements from array that pass given condition | (array,func) -> [int]|
| path | **createDir** | create directory at given path | (str) -> [bool]|
| math | **csec** | get the cosecant of given value | (real) -> [real]|
| math | **csech** | get the hyperbolic cosecant of given value | (real) -> [real]|
| math | **ctan** | get the cotangent of given value | (real) -> [real]|
| math | **ctanh** | get the hyperbolic cotangent of given value | (real) -> [real]|
| path | **currentDir** | get current directory or set it to given path | (null) / (str) -> [str]|
| crypto | **decodeBase64** | Base64-decode given string | (str) -> [str]|
| crypto | **decodeBase64!** | Base64-decode given string (in-place) | (str) -> [str]|
| generic | **delete** | delete value from given array, dictionary or string | (array,any) / (dict,any) / (str,str) -> [array,str,dict]|
| generic | **delete!** | delete value from given array, dictionary or string (in-place) | (array,any) / (dict,any) / (str,str) -> [array,str,dict]|
| generic | **deleteBy** | delete index from given array, dictionary or string | (array,int) / (dict,str) / (str,int) -> [array,str,dict]|
| generic | **deleteBy!** | delete index from given array, dictionary or string (in-place) | (array,int) / (dict,str) / (str,int) -> [array,str,dict]|
| path | **deleteDir** | delete directory at given path | (str) -> [bool]|
| path | **deleteFile** | delete file at given path | (str) -> [bool]|
| string | **deletePrefix** | get string by deleting given prefix | (str,str) -> [str]|
| string | **deletePrefix!** | get string by deleting given prefix (in-place) | (str,str) -> [str]|
| string | **deleteSuffix** | get string by deleting given suffix | (str,str) -> [str]|
| string | **deleteSuffix!** | get string by deleting given suffix (in-place) | (str,str) -> [str]|
| path | **dirContent** | get directory contents from given path; optionally filtering the results | (str) / (str,str) -> [array]|
| path | **dirContents** | get directory contents from given path, recursively; optionally filtering the results | (str) / (str,str) -> [array]|
| path | **dirExists** | check if directory exists at given path | (str) -> [bool]|
| string | **distance** | get Levenshtein distance between given strings | (str,str) -> [int]|
| crypto | **encodeBase64** | Base64-encode given string | (str) -> [str]|
| crypto | **encodeBase64!** | Base64-encode given string (in-place) | (str) -> [str]|
| string | **endsWith** | check if string ends with given string/regex | (str,str) -> [bool]|
| core | **exec** | execute function using given array of values | (func,array) -> [any]|
| math | **exp** | get the exponential the given value | (real) -> [real]|
| path | **fileCreationTime** | get creation time of file at given path | (str) -> [str]|
| path | **fileExists** | check if file exists at given path | (str) -> [bool]|
| path | **fileLastAccess** | get last access time of file at given path | (str) -> [str]|
| path | **fileLastModification** | get last modification time of file at given path | (str) -> [str]|
| path | **fileSize** | get size of file at given path in bytes | (str) -> [int]|
| array | **filter** | get array after filtering each element using given function | (array,func) -> [array]|
| array | **filter!** | get array after filtering each element using given function (in-place) | (array,func) -> [array]|
| array | **first** | get first element of given array | (array) -> [any]|
| math | **floor** | get the largest number greater than or equal to given value | (real) -> [real]|
| math | **gcd** | get the greatest common divisor of the values in given array | (array) -> [int]|
| generic | **get** | get element from array, dictionary or string using given index/key | (array,int) / (dict,str) / (str,int) -> [any]|
| dictionary | **hasKey** | check if dictionary contains key | (dict,str) -> [bool]|
| core | **if** | if condition is true, execute given function; else execute optional alternative function | (bool,func) / (bool,func,func) -> [any]|
| math | **inc** | increase given value by 1 | (int) / (bigInt) -> [int,bigInt]|
| math | **inc!** | increase given value by 1 (in-place) | (int) / (bigInt) -> [int,bigInt]|
| terminal | **input** | read line from stdin | (null) -> [str]|
| terminal | **inputChar** | read character from terminal, without being printed | (null) -> [str]|
| reflection | **inspect** | print given value to screen in a readable format | (any) -> [str]|
| string | **isAlpha** | check if all characters in given string are ASCII letters | (str) -> [bool]|
| string | **isAlphaNumeric** | check if all characters in given string are ASCII letters or digits | (str) -> [bool]|
| generic | **isEmpty** | check if given array, dictionary or string is empty | (array) / (str) / (dict) -> [bool]|
| math | **isEven** | check if given number is even | (int) / (bigInt) -> [bool]|
| string | **isLowercase** | check if all characters in given string are lowercase | (str) -> [bool]|
| string | **isNumber** | check if given string is a number | (str) -> [bool]|
| math | **isOdd** | check if given number is odd | (int) / (bigInt) -> [bool]|
| math | **isPrime** | check if given number is prime | (int) / (bigInt) -> [bool]|
| string | **isUppercase** | check if all characters in given string are uppercase | (str) -> [bool]|
| string | **isWhitespace** | check if all characters in given string are whitespace | (str) -> [bool]|
| string | **join** | join strings in given array, optionally using separator | (array) / (array,str) -> [str]|
| dictionary | **keys** | get array of dictionary keys | (dict) -> [array]|
| array | **last** | get last element of given array | (array) -> [any]|
| math | **lcm** | get the least common multiple of the values in given array | (array) -> [int]|
| string | **lines** | get lines from string as an array | (str) -> [array]|
| math | **ln** | get the natural logarithm of given value | (real) -> [real]|
| math | **log** | get the logarithm of value using given base | (real,real) -> [real]|
| math | **log10** | get the common (base-10) logarithm of given value | (real) -> [real]|
| math | **log2** | get the binary (base-2) logarithm of given value | (real) -> [real]|
| core | **loop** | execute given function for each element in collection, or while condition is true | (array,func) / (dict,func) / (bool,func) / (int,func) -> [any]|
| string | **lowercase** | lowercase given string | (str) -> [str]|
| string | **lowercase!** | lowercase given string (in-place) | (str) -> [str]|
| array | **map** | get array after executing given function for each element | (array,func) -> [array]|
| array | **map!** | get array after executing given function for each element (in-place) | (array,func) -> [array]|
| string | **matches** | get array of matches from string using given string/regex | (str,str) -> [array]|
| math | **max** | get maximum of the values in given array | (array) -> [int]|
| crypto | **md5** | MD5-encrypt given string | (str) -> [str]|
| crypto | **md5!** | MD5-encrypt given string (in-place) | (str) -> [str]|
| math | **min** | get minimum of the values in given array | (array) -> [int]|
| path | **moveDir** | move directory at path to given destination | (str,str) -> [bool]|
| path | **moveFile** | move file at path to given destination | (str,str) -> [bool]|
| logical | **nand** | bitwise/logical NAND | (bool,bool) / (int,int) -> [bool,int]|
| core | **new** | get new copy of given object | (dict) / (array) / (str) -> [any]|
| logical | **nor** | bitwise/logical NOR | (bool,bool) / (int,int) -> [bool,int]|
| path | **normalizePath** | normalize given path | (str) -> [str]|
| path | **normalizePath!** | normalize given path (in-place) | (str) -> [str]|
| logical | **not** | bitwise/logical NOT | (bool) / (int) -> [bool,int]|
| logical | **or** | bitwise/logical OR | (bool,bool) / (int,int) -> [bool,int]|
| string | **padCenter** | center-justify string by adding given padding | (str,int) -> [str]|
| string | **padCenter!** | center-justify string by adding given padding (in-place) | (str,int) -> [str]|
| string | **padLeft** | left-justify string by adding given padding | (str,int) -> [str]|
| string | **padLeft!** | left-justify string by adding given padding (in-place) | (str,int) -> [str]|
| string | **padRight** | right-justify string by adding given padding | (str,int) -> [str]|
| string | **padRight!** | right-justify string by adding given padding (in-place) | (str,int) -> [str]|
| core | **panic** | exit program printing given error message | (str) -> [str]|
| path | **pathDir** | retrieve directory component from given path | (str) -> [str]|
| path | **pathExtension** | retrieve extension component from given path | (str) -> [str]|
| path | **pathFilename** | retrieve filename component from given path | (str) -> [str]|
| array | **pop** | get last element of given array (same as 'last') | (array) -> [any]|
| array | **pop!** | get last element of given array and delete it (in-place) | (array) -> [any]|
| terminal | **print** | print given value to screen | (any) -> [str]|
| math | **product** | return product of elements of given array | (array) -> [int,bigInt]|
| math | **random** | generate random number in given range | (int,int) -> [int]|
| array | **range** | get array from given range (from..to) with optional step | (int,int) -> [array]|
| io | **read** | read string from file at given path | (str) -> [str]|
| string | **replace** | get string by replacing occurences of string/regex with given replacement | (str,str,str) -> [str]|
| string | **replace!** | get string by replacing occurences of string/regex with given replacement (in-place) | (str,str,str) -> [str]|
| core | **return** | break execution and return given value | (any) -> [any]|
| generic | **reverse** | reverse given array or string | (array) / (str) -> [array,str]|
| generic | **reverse!** | reverse given array or string (in-place) | (array) / (str) -> [array,str]|
| array | **rotate** | rotate given array, optionally by using step; negative values for left rotation | (array) / (array,int) -> [array]|
| array | **rotate!** | rotate given array, optionally by using step; negative values for left rotation (in-place) | (array) / (array,int) -> [array]|
| math | **round** | get given value rounded to the nearest value | (real) -> [real]|
| array | **sample** | get random sample from given array | (array) -> [any]|
| math | **sec** | get the secant of given value | (real) -> [real]|
| math | **sech** | get the hyperbolic secant of given value | (real) -> [real]|
| generic | **set** | set element of array, dictionary or string to given value using index/key | (array,int,any) / (dict,str,any) / (str,int,str) -> [any]|
| generic | **set!** | set element of array, dictionary or string to given value using index/key (in-place) | (array,int,any) / (dict,str,any) / (str,int,str) -> [any]|
| crypto | **sha1** | SHA1-encrypt given string | (str) -> [str]|
| crypto | **sha1!** | SHA1-encrypt given string (in-place) | (str) -> [str]|
| math | **shl** | shift-left number by given amount of bits | (int,int) / (bigInt,int) -> [int,bigInt]|
| math | **shl!** | shift-left number by given amount of bits (in-place) | (int,int) / (bigInt,int) -> [int,bigInt]|
| math | **shr** | shift-right number by given amount of bits | (int,int) / (bigInt,int) -> [int,bigInt]|
| math | **shr!** | shift-right number by given amount of bits (in-place) | (int,int) / (bigInt,int) -> [int,bigInt]|
| array | **shuffle** | shuffle given array | (array) -> [array]|
| array | **shuffle!** | shuffle given array (in-place) | (array) -> [array]|
| math | **sin** | get the sine of given value | (real) -> [real]|
| math | **sinh** | get the hyperbolic sine of given value | (real) -> [real]|
| generic | **size** | get size of given collection or string | (array) / (str) / (dict) -> [int]|
| generic | **slice** | get slice of array/string given a starting and/or end point | (array,int) / (array,int,int) / (str,int) / (str,int,int) -> [array,str]|
| array | **sort** | sort given array | (array) -> [array]|
| array | **sort!** | sort given array (in-place) | (array) -> [array]|
| string | **split** | split string to array by given string/regex separator | (str,str) -> [array]|
| math | **sqrt** | calculate the square root of given value | (real) -> [real]|
| string | **startsWith** | check if string starts with given string/regex | (str,str) -> [bool]|
| string | **strip** | remove leading and trailing whitespace from given string | (str) -> [str]|
| string | **strip!** | remove leading and trailing whitespace from given string (in-place) | (str) -> [str]|
| math | **sum** | return sum of elements of given array | (array) -> [int,bigInt]|
| array | **swap** | swap array elements at given indices | (array,int,int) -> [array]|
| array | **swap!** | swap array elements at given indices (in-place) | (array,int,int) -> [array]|
| path | **symlinkExists** | check if symlink exists at given path | (str) -> [bool]|
| core | **syms** | break execution and return given value | (null) -> [any]|
| math | **tan** | get the tangent of given value | (real) -> [real]|
| math | **tanh** | get the hyperbolic tangent of given value | (real) -> [real]|
| convert | **toBin** | convert given number to its binary string representation | (int) -> [str]|
| convert | **toHex** | convert given number to its hexadecimal string representation | (int) -> [str]|
| convert | **toNumber** | convert given string, real or boolean to an integer number | (str) / (real) / (bool) -> [int]|
| convert | **toOct** | convert given number to its octal string representation | (int) -> [str]|
| convert | **toReal** | convert given integer number to real | (int) -> [str]|
| convert | **toString** | convert given value to string | (any) -> [str]|
| reflection | **type** | get type of given object as a string | (any) -> [str]|
| array | **unique** | remove duplicates from given array | (array) -> [array]|
| array | **unique!** | remove duplicates from given array (in-place) | (array) -> [array]|
| string | **uppercase** | uppercase given string | (str) -> [str]|
| string | **uppercase!** | uppercase given string (in-place) | (str) -> [str]|
| dictionary | **values** | get array of dictionary values | (dict) -> [array]|
| io | **write** | write string to file at given path | (str) -> [str]|
| logical | **xnor** | bitwise/logical XNOR | (bool,bool) / (int,int) -> [bool,int]|
| logical | **xor** | bitwise/logical XOR | (bool,bool) / (int,int) -> [bool,int]|
| array | **zip** | get array of element pairs using given arrays | (array,array) -> [array]|

---

How to install
------------------------------

### Manually

**Prerequisites:**

- Flex & Bison
- GMP library
- Nim/Nimble

**Build:**

	nimble release

**Run script:**

	./arturo <script>

**REPL:**

	./arturo

### HomeBrew (for macOS)

There is an Arturo formula here: https://github.com/arturo-lang/art-homebrew

Just 2 commands and you'll have Arturo up'n'running.

### or... Check it out online!

http://arturo-lang.io

---

Editors & IDEs
------------------------------

If you prefer to use some specific editors, we already support the most popular ones:

- **SublimeText**: https://github.com/arturo-lang/art-sublimetext-package
- **Atom**: https://github.com/arturo-lang/art-atom-package
- **Ace Editor**: https://github.com/arturo-lang/art-ace-editor

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
