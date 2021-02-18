### Functions

---

<!--ts-->
   * [array](#array)
   * [as](#as)
   * [define](#define)
   * [dictionary](#dictionary)
   * [from](#from)
   * [function](#function)
   * [to](#to)
<!--te-->

---


## array

**Alias:** `@`

#### Description

Create array from given block, by reducing/calculating all internal values

#### Usage

<pre>
<b>array</b> <ins>source</ins> <i>:string</i> <i>:block</i>
</pre>

#### Returns

- *:block*

#### Examples

```red
none: @[]               ; none: []
a: @[1 2 3]             ; a: [1 2 3]

b: 5
c: @[b b+1 b+2]         ; c: [5 6 7]

d: @[
    3+1
    print "we are in the block"
    123
    print "yep"
]
; we are in the block
; yep
; => [4 123]
```

## as

#### Description

Format given value as implied type

#### Usage

<pre>
<b>as</b> <ins>value</ins> <i>:any</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|binary|<i>:boolean</i>|format integer as binary|
|hex|<i>:boolean</i>|format integer as hexadecimal|
|octal|<i>:boolean</i>|format integer as octal|
|ascii|<i>:boolean</i>|transliterate string to ASCII|
|agnostic|<i>:boolean</i>|convert words in block to literals, if not in context|
|code|<i>:boolean</i>|convert value to valid Arturo code|

#### Returns

- *:any*

#### Examples

```red
print as.binary 123           ; 1111011
print as.octal 123            ; 173
print as.hex 123              ; 7b

print as.ascii "thís ìß ñot à tést"
; this iss not a test
```

## define

#### Description

Define new type with given characteristics

#### Usage

<pre>
<b>define</b> <ins>type</ins> <i>:type</i>
       <ins>prototype</ins> <i>:block</i>
       <ins>methods</ins> <i>:block</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|inherit|<i>:type</i>|inherit properties of given type|

#### Returns

- *:nothing*


## dictionary

**Alias:** `#`

#### Description

Create dictionary from given block or file, by getting all internal symbols

#### Usage

<pre>
<b>dictionary</b> <ins>source</ins> <i>:string</i> <i>:block</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|with|<i>:block</i>|embed given symbols|
|raw|<i>:boolean</i>|create dictionary from raw block|

#### Returns

- *:dictionary*

#### Examples

```red
none: #[]               ; none: []
a: #[
    name: "John"
    age: 34
]             
; a: [name: "John", age: 34]

d: #[
    name: "John"
    print "we are in the block"
    age: 34
    print "yep"
]
; we are in the block
; yep
; => [name: "John", age: 34]
```

## from

#### Description

Get value from string, using given representation

#### Usage

<pre>
<b>from</b> <ins>value</ins> <i>:string</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|binary|<i>:boolean</i>|get integer from binary representation|
|hex|<i>:boolean</i>|get integer from hexadecimal representation|
|octal|<i>:boolean</i>|get integer from octal representation|

#### Returns

- *:any*

#### Examples

```red
print from.binary "1011"        ; 11
print from.octal "1011"         ; 521
print from.hex "0xDEADBEEF"     ; 3735928559
```

## function

**Alias:** `$`

#### Description

Create function with given arguments and body

#### Usage

<pre>
<b>function</b> <ins>arguments</ins> <i>:block</i>
         <ins>body</ins> <i>:block</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|import|<i>:block</i>|import/embed given list of symbols from current environment|
|export|<i>:block</i>|export given symbols to parent|

#### Returns

- *:function*

#### Examples

```red
f: function [x][ x + 2 ]
print f 10                ; 12

f: $[x][x+2]
print f 10                ; 12

multiply: function [x,y][
    x * y
]
print multiply 3 5        ; 15

publicF: function .export['x] [z][
    print ["z =>" z]
    x: 5
]

publicF 10
; z => 10

print x
; 5
```

## to

#### Description

Convert value to given type

#### Usage

<pre>
<b>to</b> <ins>type</ins> <i>:type</i>
   <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:any*

#### Examples

```red
to :string 2020               ; "2020"
to :integer "2020"            ; 2020

to :integer `A`               ; 65
to :char 65                   ; `A`

to :integer 4.3               ; 4
to :floating 4                ; 4.0

to :boolean 0                 ; false
to :boolean 1                 ; true
to :boolean "true"            ; true

to :literal "symbol"          ; 'symbol
to :string 'symbol            ; "symbol"
to :string :word              ; "word"

to :block "one two three"     ; [one two three]
```