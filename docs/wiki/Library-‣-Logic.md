### Functions

---

<!--ts-->
   * [all?](#all?)
   * [and?](#and?)
   * [any?](#any?)
   * [false?](#false?)
   * [nand?](#nand?)
   * [nor?](#nor?)
   * [not?](#not?)
   * [or?](#or?)
   * [true?](#true?)
   * [xnor?](#xnor?)
   * [xor?](#xor?)
<!--te-->

---


## all?

#### Description

Check if all values in given block are true

#### Usage

<pre>
<b>all?</b> <ins>conditions</ins> <i>:block</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
if all? @[2>1 "DONE"=upper "done" true] 
    -> print "yes, all are true"
; yes, all are true

print all? @[true false true true]
; false
```

## and?

#### Description

Return the logical AND for the given values

#### Usage

<pre>
<b>and?</b> <ins>valueA</ins> <i>:boolean</i> <i>:block</i>
     <ins>valueB</ins> <i>:boolean</i> <i>:block</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
x: 2
y: 5

if and? x=2 y>5 [
    print "yep, that's correct!"]
]

; yep, that's correct!
```

## any?

#### Description

Check if any of the values in given block is true

#### Usage

<pre>
<b>any?</b> <ins>conditions</ins> <i>:block</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
if any? @[false 3=4 2>1] 
    -> print "yes, one (or more) of the values is true"
; yes, one (or more) of the values is true

print any? @[false false false]
; false
```

## false?

#### Description

Returns true if given value is false; otherwise, it returns false

#### Usage

<pre>
<b>false?</b> <ins>value</ins> <i>:boolean</i>
</pre>

#### Returns

- *:boolean*


## nand?

#### Description

Return the logical NAND for the given values

#### Usage

<pre>
<b>nand?</b> <ins>valueA</ins> <i>:boolean</i>
      <ins>valueB</ins> <i>:boolean</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
x: 2
y: 3

if? nand? x=2 y=3 [
    print "yep, that's correct!"]
]
else [
    print "nope, that's not correct"
]

; nope, that's not correct
```

## nor?

#### Description

Return the logical NAND for the given values

#### Usage

<pre>
<b>nor?</b> <ins>valueA</ins> <i>:boolean</i>
     <ins>valueB</ins> <i>:boolean</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
x: 2
y: 3

if? nor? x>2 y=3 [
    print "yep, that's correct!"]
]
else [
    print "nope, that's not correct"
]

; nope, that's not correct
```

## not?

#### Description

Return the logical complement of the given value

#### Usage

<pre>
<b>not?</b> <ins>value</ins> <i>:boolean</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
ready: false
if not? ready [
    print "we're still not ready!"
]

; we're still not ready!
```

## or?

#### Description

Return the logical OR for the given values

#### Usage

<pre>
<b>or?</b> <ins>valueA</ins> <i>:boolean</i> <i>:block</i>
    <ins>valueB</ins> <i>:boolean</i> <i>:block</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
x: 2
y: 4

if or? x=2 y>5 [
    print "yep, that's correct!"]
]

; yep, that's correct!
```

## true?

#### Description

Returns true if given value is true; otherwise, it returns false

#### Usage

<pre>
<b>true?</b> <ins>value</ins> <i>:boolean</i>
</pre>

#### Returns

- *:boolean*


## xnor?

#### Description

Return the logical XNOR for the given values

#### Usage

<pre>
<b>xnor?</b> <ins>valueA</ins> <i>:boolean</i>
      <ins>valueB</ins> <i>:boolean</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
x: 2
y: 3

if? xnor? x=2 y=3 [
    print "yep, that's correct!"]
]
else [
    print "nope, that's not correct"
]

; yep, that's not correct
```

## xor?

#### Description

Return the logical XOR for the given values

#### Usage

<pre>
<b>xor?</b> <ins>valueA</ins> <i>:boolean</i>
     <ins>valueB</ins> <i>:boolean</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
x: 2
y: 3

if? xor? x=2 y=3 [
    print "yep, that's correct!"]
]
else [
    print "nope, that's not correct"
]

; nope, that's not correct
```