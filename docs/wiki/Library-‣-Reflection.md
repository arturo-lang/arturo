### Functions

---

<!--ts-->
   * [attr](#attr)
   * [attr?](#attr?)
   * [attribute?](#attribute?)
   * [attributeLabel?](#attributeLabel?)
   * [attrs](#attrs)
   * [benchmark](#benchmark)
   * [binary?](#binary?)
   * [block?](#block?)
   * [boolean?](#boolean?)
   * [char?](#char?)
   * [database?](#database?)
   * [date?](#date?)
   * [dictionary?](#dictionary?)
   * [help](#help)
   * [info](#info)
   * [inline?](#inline?)
   * [inspect](#inspect)
   * [integer?](#integer?)
   * [is?](#is?)
   * [floating?](#floating?)
   * [function?](#function?)
   * [label?](#label?)
   * [literal?](#literal?)
   * [null?](#null?)
   * [path?](#path?)
   * [pathLabel?](#pathLabel?)
   * [set?](#set?)
   * [stack](#stack)
   * [standalone?](#standalone?)
   * [string?](#string?)
   * [symbol?](#symbol?)
   * [symbols](#symbols)
   * [type](#type)
   * [type?](#type?)
   * [word?](#word?)
<!--te-->

---


## attr

#### Description

Get given attribute, if it exists

#### Usage

<pre>
<b>attr</b> <ins>name</ins> <i>:string</i> <i>:literal</i>
</pre>

#### Returns

- *:null*
- *:any*

#### Examples

```red
multiply: function [x][
    if? attr? "with" [ 
        x * attr "with"
    ] 
    else [ 
        2*x 
    ]
]

print multiply 5
; 10

print multiply.with: 6 5
; 60
```

## attr?

#### Description

Check if given attribute exists

#### Usage

<pre>
<b>attr?</b> <ins>name</ins> <i>:string</i> <i>:literal</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
# greet: function [x][
#     if? not? attr? 'later [
#         print ["Hello" x "!"]
#     ]
#     else [
#         print [x "I'm afraid I'll greet you later!"]
#     ]
# ]
#
# greet.later "John"
#
# ; John I'm afraid I'll greet you later!
```

## attribute?

#### Description

Checks if given value is of type :attribute

#### Usage

<pre>
<b>attribute?</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*


## attributeLabel?

#### Description

Checks if given value is of type :attributeLabel

#### Usage

<pre>
<b>attributeLabel?</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*


## attrs

#### Description

Get dictionary of set attributes

#### Usage

<pre>
<b>attrs</b> 
</pre>

#### Returns

- *:dictionary*

#### Examples

```red
greet: function [x][
    print ["Hello" x "!"]
    print attrs
]

greet.later "John"

; Hello John!
; [
;    later:    true
; ]
```

## benchmark

#### Description

Benchmark given code

#### Usage

<pre>
<b>benchmark</b> <ins>action</ins> <i>:block</i>
</pre>

#### Returns

- *:nothing*

#### Examples

```red
benchmark [ 
    ; some process that takes some time
    loop 1..10000 => prime? 
]

; [benchmark] time: 0.065s
```

## binary?

#### Description

Checks if given value is of type :binary

#### Usage

<pre>
<b>binary?</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*


## block?

#### Description

Checks if given value is of type :block

#### Usage

<pre>
<b>block?</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*


## boolean?

#### Description

Checks if given value is of type :boolean

#### Usage

<pre>
<b>boolean?</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*


## char?

#### Description

Checks if given value is of type :char

#### Usage

<pre>
<b>char?</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*


## database?

#### Description

Checks if given value is of type :database

#### Usage

<pre>
<b>database?</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*


## date?

#### Description

Checks if given value is of type :date

#### Usage

<pre>
<b>date?</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*


## dictionary?

#### Description

Checks if given value is of type :dictionary

#### Usage

<pre>
<b>dictionary?</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*


## help

#### Description

Print a list of all available builtin functions

#### Usage

<pre>
<b>help</b> 
</pre>

#### Returns

- *:nothing*


## info

#### Description

Print info for given symbol

#### Usage

<pre>
<b>info</b> <ins>symbol</ins> <i>:string</i> <i>:literal</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|get|<i>:boolean</i>|get information as dictionary|

#### Returns

- *:dictionary*
- *:nothing*


## inline?

#### Description

Checks if given value is of type :inline

#### Usage

<pre>
<b>inline?</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*


## inspect

#### Description

Print full dump of given value to screen

#### Usage

<pre>
<b>inspect</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:nothing*

#### Examples

```red
inspect 3                 ; 3 :integer

a: "some text"
inspect a                 ; some text :string
```

## integer?

#### Description

Checks if given value is of type :integer

#### Usage

<pre>
<b>integer?</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*


## is?

#### Description

Print full dump of given value to screen

#### Usage

<pre>
<b>is?</b> <ins>type</ins> <i>:type</i>
    <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
is? :string "hello"       ; => true
is? :block [1 2 3]        ; => true
is? :integer "boom"       ; => false
```

## floating?

#### Description

Checks if given value is of type :floating

#### Usage

<pre>
<b>floating?</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*


## function?

#### Description

Checks if given value is of type :function

#### Usage

<pre>
<b>function?</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*


## label?

#### Description

Checks if given value is of type :label

#### Usage

<pre>
<b>label?</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*


## literal?

#### Description

Checks if given value is of type :literal

#### Usage

<pre>
<b>literal?</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*


## null?

#### Description

Checks if given value is of type :null

#### Usage

<pre>
<b>null?</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*


## path?

#### Description

Checks if given value is of type :path

#### Usage

<pre>
<b>path?</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*


## pathLabel?

#### Description

Checks if given value is of type :pathLabel

#### Usage

<pre>
<b>pathLabel?</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*


## set?

#### Description

Check if given variable is defined

#### Usage

<pre>
<b>set?</b> <ins>symbol</ins> <i>:string</i> <i>:literal</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
boom: 12
print set? 'boom          ; true

print set? 'zoom          ; false
```

## stack

#### Description

Get current stack

#### Usage

<pre>
<b>stack</b> 
</pre>

#### Returns

- *:dictionary*


## standalone?

#### Description

Checks if current script runs from the command-line

#### Usage

<pre>
<b>standalone?</b> 
</pre>

#### Returns

- *:boolean*


## string?

#### Description

Checks if given value is of type :string

#### Usage

<pre>
<b>string?</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*


## symbol?

#### Description

Checks if given value is of type :symbol

#### Usage

<pre>
<b>symbol?</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*


## symbols

#### Description

Get currently defined symbols

#### Usage

<pre>
<b>symbols</b> 
</pre>

#### Returns

- *:dictionary*

#### Examples

```red
a: 2
b: "hello"

print symbols

; [
;    a: 2
;    b: "hello"
; ]
```

## type

#### Description

Get type of given value

#### Usage

<pre>
<b>type</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:type*

#### Examples

```red
print type 18966          ; :integer
print type "hello world"  ; :string
```

## type?

#### Description

Checks if given value is of type :type

#### Usage

<pre>
<b>type?</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*


## word?

#### Description

Checks if given value is of type :word

#### Usage

<pre>
<b>word?</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*
