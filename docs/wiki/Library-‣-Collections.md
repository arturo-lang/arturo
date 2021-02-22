### Functions

---

<!--ts-->
   * [append](#append)
   * [chop](#chop)
   * [combine](#combine)
   * [contains?](#contains?)
   * [drop](#drop)
   * [empty](#empty)
   * [empty?](#empty?)
   * [extend](#extend)
   * [first](#first)
   * [flatten](#flatten)
   * [get](#get)
   * [in?](#in?)
   * [index](#index)
   * [insert](#insert)
   * [key?](#key?)
   * [keys](#keys)
   * [last](#last)
   * [max](#max)
   * [min](#min)
   * [permutate](#permutate)
   * [remove](#remove)
   * [repeat](#repeat)
   * [reverse](#reverse)
   * [sample](#sample)
   * [set](#set)
   * [shuffle](#shuffle)
   * [size](#size)
   * [slice](#slice)
   * [sort](#sort)
   * [split](#split)
   * [squeeze](#squeeze)
   * [take](#take)
   * [unique](#unique)
   * [values](#values)
<!--te-->

---


## append

**Alias:** `++`

#### Description

Append value to given collection

#### Usage

<pre>
<b>append</b> <ins>collection</ins> <i>:char</i> <i>:string</i> <i>:literal</i> <i>:block</i>
       <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:string*
- *:block*
- *:nothing*

#### Examples

```red
append "hell" "o"         ; => "hello"
append [1 2 3] 4          ; => [1 2 3 4]
append [1 2 3] [4 5]      ; => [1 2 3 4 5]

print "hell" ++ "o!"      ; hello!             
print [1 2 3] ++ 4 ++ 5   ; [1 2 3 4 5]

a: "hell"
append 'a "o"
print a                   ; hello

b: [1 2 3]
'b ++ 4
print b                   ; [1 2 3 4]
```

## chop

#### Description

Remove last item from given collection

#### Usage

<pre>
<b>chop</b> <ins>collection</ins> <i>:string</i> <i>:literal</i> <i>:block</i>
</pre>

#### Returns

- *:string*
- *:block*
- *:nothing*

#### Examples

```red
print chop "books"          ; book
print chop chop "books"     ; boo

str: "books"
chop 'str                   ; str: "book"

chop [1 2 3 4]              ; => [1 2 3]
```

## combine

#### Description

Get combination of elements in given collections

#### Usage

<pre>
<b>combine</b> <ins>collectionA</ins> <i>:block</i>
        <ins>collectionB</ins> <i>:block</i>
</pre>

#### Returns

- *:block*

#### Examples

```red
combine ["one" "two" "three"] [1 2 3]
; => [[1 "one"] [2 "two"] [3 "three"]]
```

## contains?

#### Description

Check if collection contains given value

#### Usage

<pre>
<b>contains?</b> <ins>collection</ins> <i>:string</i> <i>:dictionary</i> <i>:block</i>
          <ins>value</ins> <i>:any</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|regex|<i>:boolean</i>|match against a regular expression|

#### Returns

- *:string*
- *:dictionary*
- *:block*
- *:nothing*

#### Examples

```red
arr: [1 2 3 4]

contains? arr 5             ; => false
contains? arr 2             ; => true

user: #[
    name: "John"
    surname: "Doe"
]

contains? dict "John"       ; => true
contains? dict "Paul"       ; => false

contains? keys dict "name"  ; => true

contains? "hello" "x"       ; => false
```

## drop

#### Description

Drop first <number> of elements from given collection and return the remaining ones

#### Usage

<pre>
<b>drop</b> <ins>collection</ins> <i>:string</i> <i>:literal</i> <i>:block</i>
     <ins>number</ins> <i>:integer</i>
</pre>

#### Returns

- *:string*
- *:block*
- *:nothing*

#### Examples

```red
str: drop "some text" 5
print str                     ; text

arr: 1..10
drop 'arr 3                   ; arr: [4 5 6 7 8 9 10]
```

## empty

#### Description

Empty given collection

#### Usage

<pre>
<b>empty</b> <ins>collection</ins> <i>:literal</i>
</pre>

#### Returns

- *:nothing*

#### Examples

```red
a: [1 2 3]
empty 'a              ; a: []

str: "some text"
empty 'str            ; str: ""
```

## empty?

#### Description

Check if given collection is empty

#### Usage

<pre>
<b>empty?</b> <ins>collection</ins> <i>:null</i> <i>:string</i> <i>:dictionary</i> <i>:block</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
empty? ""             ; => true
empty? []             ; => true
empty? #[]            ; => true

empty [1 "two" 3]     ; => false
```

## extend

#### Description

Get new dictionary by merging given ones

#### Usage

<pre>
<b>extend</b> <ins>parent</ins> <i>:dictionary</i>
       <ins>additional</ins> <i>:dictionary</i>
</pre>

#### Returns

- *:dictionary*

#### Examples

```red
person: #[ name: "john" surname: "doe" ]

print extend person #[ age: 35 ]
; [name:john surname:doe age:35]
```

## first

#### Description

Return the first item of the given collection

#### Usage

<pre>
<b>first</b> <ins>collection</ins> <i>:string</i> <i>:block</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|n|<i>:integer</i>|get first <n> items|

#### Returns

- *:any*

#### Examples

```red
print first "this is some text"       ; t
print first ["one" "two" "three"]     ; one

print first.n:2 ["one" "two" "three"] ; one two
```

## flatten

#### Description

Flatten given collection by eliminating nested blocks

#### Usage

<pre>
<b>flatten</b> <ins>collection</ins> <i>:block</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|once|<i>:boolean</i>|do not perform recursive flattening|

#### Returns

- *:block*

#### Examples

```red
arr: [[1 2 3] [4 5 6]]
print flatten arr
; 1 2 3 4 5 6

arr: [[1 2 3] [4 5 6]]
flatten 'arr
; arr: [1 2 3 4 5 6]

flatten [1 [2 3] [4 [5 6]]]
; => [1 2 3 4 5 6]

flatten.once [1 [2 3] [4 [5 6]]]
; => [1 2 3 4 [5 6]]
```

## get

**Alias:** `\`

#### Description

Get collection's item by given index

#### Usage

<pre>
<b>get</b> <ins>collection</ins> <i>:string</i> <i>:date</i> <i>:dictionary</i> <i>:block</i>
    <ins>index</ins> <i>:any</i>
</pre>

#### Returns

- *:any*

#### Examples

```red
user: #[
    name: "John"
    surname: "Doe"
]

print user\name               ; John

print get user 'surname       ; Doe
print user \ 'username        ; Doe

arr: ["zero" "one" "two"]

print arr\1                   ; one

print get arr 2               ; two
print arr \ 2                 ; two

str: "Hello world!"

print str\0                   ; H

print get str 1               ; e
print str \ 1                 ; e
```

## in?

#### Description

Check if value exists in given collection

#### Usage

<pre>
<b>in?</b> <ins>value</ins> <i>:any</i>
    <ins>collection</ins> <i>:string</i> <i>:dictionary</i> <i>:block</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|regex|<i>:boolean</i>|match against a regular expression|

#### Returns

- *:string*
- *:dictionary*
- *:block*
- *:nothing*

#### Examples

```red
arr: [1 2 3 4]

in? 5 arr             ; => false
in? 2 arr             ; => true

user: #[
    name: "John"
    surname: "Doe"
]

in? "John" dict       ; => true
in? "Paul" dict       ; => false

in? "name" keys dict  ; => true

in? "x" "hello"       ; => false
```

## index

#### Description

Return first index of value in given collection

#### Usage

<pre>
<b>index</b> <ins>collection</ins> <i>:string</i> <i>:dictionary</i> <i>:block</i>
      <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:null*
- *:integer*
- *:string*

#### Examples

```red
ind: index "hello" "e"
print ind                 ; 1

print index [1 2 3] 3     ; 2

type index "hello" "x"
; :null
```

## insert

#### Description

Insert value in collection at given index

#### Usage

<pre>
<b>insert</b> <ins>collection</ins> <i>:string</i> <i>:literal</i> <i>:dictionary</i> <i>:block</i>
       <ins>index</ins> <i>:integer</i> <i>:string</i>
       <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:string*
- *:dictionary*
- *:block*
- *:nothing*

#### Examples

```red
insert [1 2 3 4] 0 "zero"
; => ["zero" 1 2 3 4]

print insert "heo" 2 "ll"
; hello

dict: #[
    name: John
]

insert 'dict 'name "Jane"
; dict: [name: "Jane"]
```

## key?

#### Description

Check if dictionary contains given key

#### Usage

<pre>
<b>key?</b> <ins>collection</ins> <i>:dictionary</i>
     <ins>key</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
user: #[
    name: "John"
    surname: "Doe"
]

key? user 'age            ; => false
if key? user 'name [
    print ["Hello" user\name]
]
; Hello John
```

## keys

#### Description

Get list of keys for given dictionary

#### Usage

<pre>
<b>keys</b> <ins>dictionary</ins> <i>:dictionary</i>
</pre>

#### Returns

- *:block*

#### Examples

```red
user: #[
    name: "John"
    surname: "Doe"
]

keys user
=> ["name" "surname"]
```

## last

#### Description

Return the last item of the given collection

#### Usage

<pre>
<b>last</b> <ins>collection</ins> <i>:string</i> <i>:block</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|n|<i>:integer</i>|get last <n> items|

#### Returns

- *:any*

#### Examples

```red
print last "this is some text"       ; t
print last ["one" "two" "three"]     ; three

print last.n:2 ["one" "two" "three"] ; two three
```

## max

#### Description

Get maximum element in given collection

#### Usage

<pre>
<b>max</b> <ins>collection</ins> <i>:block</i>
</pre>

#### Returns

- *:null*
- *:any*

#### Examples

```red
print max [4 2 8 5 1 9]       ; 9
```

## min

#### Description

Get minimum element in given collection

#### Usage

<pre>
<b>min</b> <ins>collection</ins> <i>:block</i>
</pre>

#### Returns

- *:null*
- *:any*

#### Examples

```red
print min [4 2 8 5 1 9]       ; 1
```

## permutate

#### Description

Get all possible permutations of the elements in given collection

#### Usage

<pre>
<b>permutate</b> <ins>collection</ins> <i>:block</i>
</pre>

#### Returns

- *:block*

#### Examples

```red
permutate [A B C]
; => [[A B C] [A C B] [C A B] [B A C] [B C A] [C B A]]
```

## remove

**Alias:** `--`

#### Description

Remove value from given collection

#### Usage

<pre>
<b>remove</b> <ins>collection</ins> <i>:string</i> <i>:literal</i> <i>:dictionary</i> <i>:block</i>
       <ins>value</ins> <i>:any</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|key|<i>:boolean</i>|remove dictionary key|
|once|<i>:boolean</i>|remove only first occurence|
|index|<i>:integer</i>|remove specific index|

#### Returns

- *:string*
- *:dictionary*
- *:block*
- *:nothing*

#### Examples

```red
remove "hello" "l"        ; => "heo"
print "hello" -- "l"      ; heo

str: "mystring"
remove 'str "str"         
print str                 ; mying

print remove.once "hello" "l"
; helo

remove [1 2 3 4] 4        ; => [1 2 3]
```

## repeat

#### Description

Repeat value the given number of times and return new one

#### Usage

<pre>
<b>repeat</b> <ins>value</ins> <i>:literal</i> <i>:any</i>
       <ins>times</ins> <i>:integer</i>
</pre>

#### Returns

- *:string*
- *:block*

#### Examples

```red
print repeat "hello" 3
; hellohellohello

repeat [1 2 3] 3
; => [1 2 3 1 2 3 1 2 3]

repeat 5 3
; => [5 5 5]

repeat [[1 2 3]] 3
; => [[1 2 3] [1 2 3] [1 2 3]]
```

## reverse

#### Description

Reverse given collection

#### Usage

<pre>
<b>reverse</b> <ins>collection</ins> <i>:string</i> <i>:literal</i> <i>:block</i>
</pre>

#### Returns

- *:string*
- *:block*
- *:nothing*

#### Examples

```red
print reverse [1 2 3 4]           ; 4 3 2 1
print reverse "Hello World"       ; dlroW olleH

str: "my string"
reverse 'str
print str                         ; gnirts ym
```

## sample

#### Description

Get a random element from given collection

#### Usage

<pre>
<b>sample</b> <ins>collection</ins> <i>:block</i>
</pre>

#### Returns

- *:any*

#### Examples

```red
sample [1 2 3]        ; (return a random number from 1 to 3)
print sample ["apple" "appricot" "banana"]
; apple
```

## set

#### Description

Set collection's item at index to given value

#### Usage

<pre>
<b>set</b> <ins>collection</ins> <i>:string</i> <i>:dictionary</i> <i>:block</i>
    <ins>index</ins> <i>:any</i>
    <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:nothing*

#### Examples

```red
myDict: #[ 
    name: "John"
    age: 34
]

set myDict 'name "Michael"        ; => [name: "Michael", age: 34]

arr: [1 2 3 4]
set arr 0 "one"                   ; => ["one" 2 3 4]
```

## shuffle

#### Description

Get given collection shuffled

#### Usage

<pre>
<b>shuffle</b> <ins>collection</ins> <i>:literal</i> <i>:block</i>
</pre>

#### Returns

- *:block*
- *:nothing*

#### Examples

```red
shuffle [1 2 3 4 5 6]         ; => [1 5 6 2 3 4 ]

arr: [2 5 9]
shuffle 'arr
print arr                     ; 5 9 2
```

## size

#### Description

Get size/length of given collection

#### Usage

<pre>
<b>size</b> <ins>collection</ins> <i>:string</i> <i>:dictionary</i> <i>:block</i>
</pre>

#### Returns

- *:integer*

#### Examples

```red
str: "some text"      
print size str                ; 9

print size "你好!"              ; 3
```

## slice

#### Description

Get a slice of collection between given indices

#### Usage

<pre>
<b>slice</b> <ins>collection</ins> <i>:string</i> <i>:block</i>
      <ins>from</ins> <i>:integer</i>
      <ins>to</ins> <i>:integer</i>
</pre>

#### Returns

- *:string*
- *:block*

#### Examples

```red
slice "Hello" 0 3             ; => "Hell"
print slice 1..10 3 4         ; 4 5
```

## sort

#### Description

Sort given block in ascending order

#### Usage

<pre>
<b>sort</b> <ins>collection</ins> <i>:literal</i> <i>:block</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|as|<i>:literal</i>|localized by ISO 639-1 language code|
|sensitive|<i>:boolean</i>|case-sensitive sorting|
|descending|<i>:boolean</i>|sort in ascending order|

#### Returns

- *:block*
- *:nothing*

#### Examples

```red
a: [3 1 6]
print sort a                  ; 1 3 6

print sort.descending a       ; 6 3 1

b: ["one" "two" "three"]
sort 'b
print b                       ; one three two
```

## split

#### Description

Split collection to components

#### Usage

<pre>
<b>split</b> <ins>collection</ins> <i>:string</i> <i>:literal</i> <i>:block</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|words|<i>:boolean</i>|split string by whitespace|
|lines|<i>:boolean</i>|split string by lines|
|by|<i>:string</i>|split using given separator|
|regex|<i>:boolean</i>|match against a regular expression|
|at|<i>:integer</i>|split collection at given position|
|every|<i>:integer</i>|split collection every <n> elements|

#### Returns

- *:block*
- *:nothing*

#### Examples

```red
split "hello"                 ; => [`h` `e` `l` `l` `o`]
split.words "hello world"     ; => ["hello" "world"]

split.every: 2 "helloworld"
; => ["he" "ll" "ow" "or" "ld"]

split.at: 4 "helloworld"
; => ["hell" "oworld"]

arr: 1..9
split.at:3 'arr
; => [ [1 2 3 4] [5 6 7 8 9] ]
```

## squeeze

#### Description

Reduce adjacent elements in given collection

#### Usage

<pre>
<b>squeeze</b> <ins>collection</ins> <i>:string</i> <i>:literal</i> <i>:block</i>
</pre>

#### Returns

- *:string*
- *:block*
- *:nothing*


## take

#### Description

Keep first <number> of elements from given collection and return the remaining ones

#### Usage

<pre>
<b>take</b> <ins>collection</ins> <i>:string</i> <i>:literal</i> <i>:block</i>
     <ins>number</ins> <i>:integer</i>
</pre>

#### Returns

- *:string*
- *:block*
- *:nothing*

#### Examples

```red
str: take "some text" 5
print str                     ; some

arr: 1..10
take 'arr 3                   ; arr: [1 2 3]
```

## unique

#### Description

Get given block without duplicates

#### Usage

<pre>
<b>unique</b> <ins>collection</ins> <i>:literal</i> <i>:block</i>
</pre>

#### Returns

- *:block*
- *:nothing*

#### Examples

```red
arr: [1 2 4 1 3 2]
print unique arr              ; 1 2 4 3

arr: [1 2 4 1 3 2]
unique 'arr
print arr                     ; 1 2 4 3
```

## values

#### Description

Get list of values for given dictionary

#### Usage

<pre>
<b>values</b> <ins>dictionary</ins> <i>:dictionary</i>
</pre>

#### Returns

- *:block*

#### Examples

```red
user: #[
    name: "John"
    surname: "Doe"
]

values user
=> ["John" "Doe"]
```