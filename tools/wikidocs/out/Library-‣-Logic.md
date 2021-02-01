### Functions

---

<!--ts-->
   * [and?](#and?)
   * [false?](#false?)
   * [nand?](#nand?)
   * [nor?](#nor?)
   * [not?](#not?)
   * [or?](#or?)
   * [true?](#true?)
   * [xnor?](#xnor?)
<!--te-->

---


## and?

#### Description

Return the logical AND for the given values

#### Usage

<pre>
<b>and?</b> <ins>valueA</ins> <i>:boolean</i>
     <ins>valueB</ins> <i>:boolean</i>
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
<b>or?</b> <ins>valueA</ins> <i>:boolean</i>
    <ins>valueB</ins> <i>:boolean</i>
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

if? xor? x=2 y=3 [
    print "yep, that's correct!"]
]
else [
    print "nope, that's not correct"
]

; nope, that's not correct
```