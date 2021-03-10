### Functions

---

<!--ts-->
   * [break](#break)
   * [call](#call)
   * [case](#case)
   * [continue](#continue)
   * [do](#do)
   * [dup](#dup)
   * [else](#else)
   * [if](#if)
   * [if?](#if?)
   * [let](#let)
   * [new](#new)
   * [pop](#pop)
   * [return](#return)
   * [try](#try)
   * [try?](#try?)
   * [unless](#unless)
   * [unless?](#unless?)
   * [until](#until)
   * [var](#var)
   * [when?](#when?)
   * [while](#while)
<!--te-->

---


## break

#### Description

Break out of current block or loop

#### Usage

<pre>
<b>break</b> 
</pre>

#### Returns

- *:block*

#### Examples

```red
loop 1..5 'x [
    print ["x:" x]
    if x=3 -> break
    print "after check"
]
print "after loop"

; x: 1
; after check
; x: 2
; after check
; x: 3
; after loop
```

## call

#### Description

Call function with given list of parameters

#### Usage

<pre>
<b>call</b> <ins>function</ins> <i>:string</i> <i>:literal</i> <i>:function</i>
     <ins>params</ins> <i>:block</i>
</pre>

#### Returns

- *:any*

#### Examples

```red
multiply: function [x y][
    x * y
]

call 'multiply [3 5]          ; => 15

call $[x][x+2] [5]            ; 7
```

## case

#### Description

Initiate a case block to check for different cases

#### Usage

<pre>
<b>case</b> <ins>predicate</ins> <i>:block</i>
</pre>

#### Returns

- *:nothing*

#### Examples

```red
a: 2
case [a]
    when? [<2] -> print "a is less than 2"
    when? [=2] -> print "a is 2"
    else       -> print "a is greater than 2"
```

## continue

#### Description

Immediately continue with next iteration

#### Usage

<pre>
<b>continue</b> 
</pre>

#### Returns

- *:block*

#### Examples

```red
loop 1..5 'x [
    print ["x:" x]
    if x=3 -> continue
    print "after check"
]
print "after loop"

; x: 1 
; after check
; x: 2 
; after check
; x: 3 
; x: 4 
; after check
; x: 5 
; after check
; after loop
```

## do

#### Description

Evaluate and execute given code

#### Usage

<pre>
<b>do</b> <ins>code</ins> <i>:string</i> <i>:block</i> <i>:bytecode</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|import|<i>:boolean</i>|execute at root level|

#### Returns

- *:nothing*
- *:any*

#### Examples

```red
do "print 123"                ; 123

do [
    x: 3
    print ["x =>" x]          ; x => 3
]

do.import [
    x: 3
]
print ["x =>" x]              ; x => 3

print do "https://raw.githubusercontent.com/arturo-lang/arturo/master/examples/projecteuler/euler1.art"
; 233168
```

## dup

**Alias:** `<=`

#### Description

Duplicate the top of the stack and convert non-returning call to a do-return call

#### Usage

<pre>
<b>dup</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:nothing*

#### Examples

```red
; a label normally consumes its inputs
; and returns nothing

; using dup before a call, the non-returning function
; becomes a returning one

a: b: <= 3

print a         ; 3
print b         ; 3
```

## else

#### Description

Perform action, if last condition was not true

#### Usage

<pre>
<b>else</b> <ins>otherwise</ins> <i>:block</i>
</pre>

#### Returns

- *:nothing*

#### Examples

```red
x: 2
z: 3

if? x>z [
    print "x was greater than z"
]
else [
    print "nope, x was not greater than z"
]
```

## if

#### Description

Perform action, if given condition is not false or null

#### Usage

<pre>
<b>if</b> <ins>condition</ins> <i>:any</i>
   <ins>action</ins> <i>:block</i>
</pre>

#### Returns

- *:nothing*

#### Examples

```red
x: 2

if x=2 -> print "yes, that's right!"
; yes, that's right!
```

## if?

#### Description

Perform action, if given condition is not false or null and return condition result

#### Usage

<pre>
<b>if?</b> <ins>condition</ins> <i>:any</i>
    <ins>action</ins> <i>:block</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
x: 2

result: if? x=2 -> print "yes, that's right!"
; yes, that's right!

print result
; true

z: 3

if? x>z [
    print "x was greater than z"
]
else [
    print "nope, x was not greater than z"
]
```

## let

**Alias:** `:`

#### Description

Set symbol to given value

#### Usage

<pre>
<b>let</b> <ins>symbol</ins> <i>:string</i> <i>:literal</i>
    <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:nothing*

#### Examples

```red
let 'x 10         ; x: 10
print x           ; 10
```

## new

#### Description

Create new value by cloning given one

#### Usage

<pre>
<b>new</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:any*

#### Examples

```red
c: "Hello"
d: new c        ; make a copy of the older string

; changing one string in-place
; will change only the string in question

'd ++ "World"
print d                 ; HelloWorld
print c                 ; Hello
```

## pop

#### Description

Pop top <number> values from stack

#### Usage

<pre>
<b>pop</b> <ins>number</ins> <i>:integer</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|discard|<i>:boolean</i>|do not return anything|

#### Returns

- *:any*

#### Examples

```red
1 2 3
a: pop 1        ; a: 3

1 2 3
b: pop 2        ; b: [3 2]

1 2 3
pop.discard 1   ; popped 3 from the stack
```

## return

#### Description

Return given value from current function

#### Usage

<pre>
<b>return</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:nothing*

#### Examples

```red
f: function [x][ 
    loop 1..x 'y [ 
        if y=5 [ return y*2 ] 
    ] 
    return x*2
]

print f 3         ; 6
print f 6         ; 10
```

## try

#### Description

Perform action and catch possible errors

#### Usage

<pre>
<b>try</b> <ins>action</ins> <i>:block</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|import|<i>:boolean</i>|execute at root level|
|verbose|<i>:boolean</i>|print all error messages as usual|

#### Returns

- *:nothing*

#### Examples

```red
try [
    ; let's try something dangerous
    print 10 / 0
]

; we catch the exception but do nothing with it
```

## try?

#### Description

Perform action, catch possible errors and return status

#### Usage

<pre>
<b>try?</b> <ins>action</ins> <i>:block</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|import|<i>:boolean</i>|execute at root level|
|verbose|<i>:boolean</i>|print all error messages as usual|

#### Returns

- *:boolean*

#### Examples

```red
try? [
    ; let's try something dangerous
    print 10 / 0
]
else [
    print "something went terribly wrong..."
]

; something went terribly wrong...
```

## unless

#### Description

Perform action, if given condition is false or null

#### Usage

<pre>
<b>unless</b> <ins>condition</ins> <i>:any</i>
       <ins>action</ins> <i>:block</i>
</pre>

#### Returns

- *:nothing*

#### Examples

```red
x: 2

unless x=1 -> print "yep, x is not 1!"
; yep, x is not 1!
```

## unless?

#### Description

Perform action, if given condition is false or null and return condition result

#### Usage

<pre>
<b>unless?</b> <ins>condition</ins> <i>:any</i>
        <ins>action</ins> <i>:block</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
x: 2

result: unless? x=1 -> print "yep, x is not 1!"
; yep, x is not 1!

print result
; true

z: 1

unless? x>z [
    print "yep, x was not greater than z"
]
else [
    print "x was greater than z"
]
; x was greater than z
```

## until

#### Description

Execute action until the given condition is not false or null

#### Usage

<pre>
<b>until</b> <ins>action</ins> <i>:block</i>
      <ins>condition</ins> <i>:block</i>
</pre>

#### Returns

- *:nothing*

#### Examples

```red
i: 0 
until [
    print ["i =>" i] 
    i: i + 1
][i = 10]

; i => 0 
; i => 1 
; i => 2 
; i => 3 
; i => 4 
; i => 5 
; i => 6 
; i => 7 
; i => 8 
; i => 9
```

## var

#### Description

Get symbol value by given name

#### Usage

<pre>
<b>var</b> <ins>symbol</ins> <i>:string</i> <i>:literal</i>
</pre>

#### Returns

- *:any*

#### Examples

```red
a: 2
print var 'a            ; a

f: function [x][x+2]
print f 10              ; 12

g: var 'f               
print g 10              ; 12
```

## when?

#### Description

Check if a specific condition is fulfilled and, if so, execute given action

#### Usage

<pre>
<b>when?</b> <ins>condition</ins> <i>:block</i>
      <ins>action</ins> <i>:block</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
a: 2
case [a]
    when? [<2] -> print "a is less than 2"
    when? [=2] -> print "a is 2"
    else       -> print "a is greater than 2"
```

## while

#### Description

Execute action while the given condition is is not false or null

#### Usage

<pre>
<b>while</b> <ins>condition</ins> <i>:null</i> <i>:block</i>
      <ins>action</ins> <i>:block</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|import|<i>:boolean</i>|execute at root level|

#### Returns

- *:nothing*

#### Examples

```red
i: 0 
while [i<10][
    print ["i =>" i] 
    i: i + 1
]

; i => 0 
; i => 1 
; i => 2 
; i => 3 
; i => 4 
; i => 5 
; i => 6 
; i => 7 
; i => 8 
; i => 9 

while ø [
    print "something"   ; infinitely
]
```