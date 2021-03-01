### Functions

---

<!--ts-->
   * [and](#and)
   * [nand](#nand)
   * [nor](#nor)
   * [not](#not)
   * [or](#or)
   * [shl](#shl)
   * [shr](#shr)
   * [xnor](#xnor)
   * [xor](#xor)
<!--te-->

---


## and

#### Description

Calculate the binary AND for the given values

#### Usage

<pre>
<b>and</b> <ins>valueA</ins> <i>:integer</i> <i>:literal</i>
    <ins>valueB</ins> <i>:integer</i>
</pre>

#### Returns

- *:integer*
- *:nothing*

#### Examples

```red
print and 2 3      ; 2

a: 2
and 'a 3           ; a: 2
```

## nand

#### Description

Calculate the binary NAND for the given values

#### Usage

<pre>
<b>nand</b> <ins>valueA</ins> <i>:integer</i> <i>:literal</i>
     <ins>valueB</ins> <i>:integer</i>
</pre>

#### Returns

- *:integer*
- *:nothing*

#### Examples

```red
print nand 2 3     ; -3

a: 2
nand 'a 3          ; a: -3
```

## nor

#### Description

Calculate the binary NOR for the given values

#### Usage

<pre>
<b>nor</b> <ins>valueA</ins> <i>:integer</i> <i>:literal</i>
    <ins>valueB</ins> <i>:integer</i>
</pre>

#### Returns

- *:integer*
- *:nothing*

#### Examples

```red
print nor 2 3      ; -4

a: 2
nor 'a 3           ; a: -4
```

## not

#### Description

Calculate the binary complement the given value

#### Usage

<pre>
<b>not</b> <ins>value</ins> <i>:integer</i> <i>:literal</i>
</pre>

#### Returns

- *:integer*
- *:nothing*

#### Examples

```red
print not 123      ; -124

a: 123
not 'a             ; a: -124
```

## or

#### Description

Calculate the binary OR for the given values

#### Usage

<pre>
<b>or</b> <ins>valueA</ins> <i>:integer</i> <i>:literal</i>
   <ins>valueB</ins> <i>:integer</i>
</pre>

#### Returns

- *:integer*
- *:nothing*

#### Examples

```red
print or 2 3       ; 3

a: 2
or 'a 3            ; a: 3
```

## shl

#### Description

Shift-left first value bits by second value

#### Usage

<pre>
<b>shl</b> <ins>value</ins> <i>:integer</i> <i>:literal</i>
    <ins>bits</ins> <i>:integer</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|safe|<i>:boolean</i>|check for overflows|

#### Returns

- *:integer*
- *:nothing*

#### Examples

```red
print shl 2 3      ; 16

a: 2
shl 'a 3           ; a: 16
```

## shr

#### Description

Shift-right first value bits by second value

#### Usage

<pre>
<b>shr</b> <ins>value</ins> <i>:integer</i> <i>:literal</i>
    <ins>bits</ins> <i>:integer</i>
</pre>

#### Returns

- *:integer*
- *:nothing*

#### Examples

```red
print shr 16 3     ; 2

a: 16
shr 'a 3           ; a: 2
```

## xnor

#### Description

Calculate the binary XNOR for the given values

#### Usage

<pre>
<b>xnor</b> <ins>valueA</ins> <i>:integer</i> <i>:literal</i>
     <ins>valueB</ins> <i>:integer</i>
</pre>

#### Returns

- *:integer*
- *:nothing*

#### Examples

```red
print xnor 2 3     ; -2

a: 2
xnor 'a 3          ; a: -2
```

## xor

#### Description

Calculate the binary XOR for the given values

#### Usage

<pre>
<b>xor</b> <ins>valueA</ins> <i>:integer</i> <i>:literal</i>
    <ins>valueB</ins> <i>:integer</i>
</pre>

#### Returns

- *:integer*
- *:nothing*

#### Examples

```red
print xor 2 3      ; 1

a: 2
xor 'a 3           ; a: 1
```