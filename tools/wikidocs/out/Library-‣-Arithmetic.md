### Functions

---

<!--ts-->
   * [add](#add)
   * [dec](#dec)
   * [div](#div)
   * [fdiv](#fdiv)
   * [inc](#inc)
   * [mod](#mod)
   * [mul](#mul)
   * [neg](#neg)
   * [pow](#pow)
   * [sub](#sub)
<!--te-->

---


## add

**Alias:** `+`

#### Description

Add given values and return result

#### Usage

<pre>
<b>add</b> <ins>valueA</ins> <i>:integer</i> <i>:floating</i> <i>:literal</i>
    <ins>valueB</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:integer*
- *:floating*
- *:nothing*

#### Examples

```red
print add 1 2      ; 3
print 1 + 3        ; 4

a: 4
add 'a 1           ; a: 5
```

## dec

#### Description

Decrease given value by 1

#### Usage

<pre>
<b>dec</b> <ins>value</ins> <i>:integer</i> <i>:floating</i> <i>:literal</i>
</pre>

#### Returns

- *:integer*
- *:floating*
- *:nothing*

#### Examples

```red
print dec 5        ; 4

a: 4
dec 'a             ; a: 3
```

## div

**Alias:** `/`

#### Description

Perform integer division between given values and return result

#### Usage

<pre>
<b>div</b> <ins>valueA</ins> <i>:integer</i> <i>:floating</i> <i>:literal</i>
    <ins>valueB</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:integer*
- *:nothing*

#### Examples

```red
print div 5 2      ; 2
print 9 / 3        ; 3

a: 6
div 'a 3           ; a: 2
```

## fdiv

**Alias:** `//`

#### Description

Divide given values and return result

#### Usage

<pre>
<b>fdiv</b> <ins>valueA</ins> <i>:integer</i> <i>:floating</i> <i>:literal</i>
     <ins>valueB</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*
- *:nothing*

#### Examples

```red
print fdiv 5 2     ; 2.5

a: 6
fdiv 'a 3          ; a: 2.0
```

## inc

#### Description

Increase given value by 1

#### Usage

<pre>
<b>inc</b> <ins>value</ins> <i>:integer</i> <i>:floating</i> <i>:literal</i>
</pre>

#### Returns

- *:integer*
- *:floating*
- *:nothing*

#### Examples

```red
print inc 5        ; 6

a: 4
inc 'a             ; a: 5
```

## mod

**Alias:** `%`

#### Description

Calculate the modulo given values and return result

#### Usage

<pre>
<b>mod</b> <ins>valueA</ins> <i>:integer</i> <i>:literal</i>
    <ins>valueB</ins> <i>:integer</i>
</pre>

#### Returns

- *:integer*
- *:nothing*

#### Examples

```red
print mod 5 2      ; 1
print 9 % 3        ; 0

a: 8
mod 'a 3           ; a: 2
```

## mul

**Alias:** `*`

#### Description

Calculate the modulo given values and return result

#### Usage

<pre>
<b>mul</b> <ins>valueA</ins> <i>:integer</i> <i>:floating</i> <i>:literal</i>
    <ins>valueB</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:integer*
- *:floating*
- *:nothing*

#### Examples

```red
print mul 1 2      ; 2
print 2 * 3        ; 6

a: 5
mul 'a 2           ; a: 10
```

## neg

#### Description

Reverse sign of given value and return it

#### Usage

<pre>
<b>neg</b> <ins>value</ins> <i>:integer</i> <i>:floating</i> <i>:literal</i>
</pre>

#### Returns

- *:integer*
- *:floating*
- *:nothing*

#### Examples

```red
print neg 1        ; -1

a: 5
neg 'a             ; a: -5
```

## pow

**Alias:** `^`

#### Description

Calculate the power of given values and return result

#### Usage

<pre>
<b>pow</b> <ins>valueA</ins> <i>:integer</i> <i>:floating</i> <i>:literal</i>
    <ins>valueB</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:integer*
- *:floating*
- *:nothing*

#### Examples

```red
print pow 2 3      ; 8
print 3 ^ 2        ; 9

a: 5
pow 'a 2           ; a: 25
```

## sub

**Alias:** `-`

#### Description

Subtract given values and return result

#### Usage

<pre>
<b>sub</b> <ins>valueA</ins> <i>:integer</i> <i>:floating</i> <i>:literal</i>
    <ins>valueB</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:integer*
- *:floating*
- *:nothing*

#### Examples

```red
print sub 2 1      ; 1
print 5 - 3        ; 2

a: 7
sub 'a 2           ; a: 5
```