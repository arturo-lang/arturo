### Functions

---

<!--ts-->
   * [abs](#abs)
   * [acos](#acos)
   * [acosh](#acosh)
   * [asin](#asin)
   * [asinh](#asinh)
   * [atan](#atan)
   * [atanh](#atanh)
   * [average](#average)
   * [cos](#cos)
   * [cosh](#cosh)
   * [csec](#csec)
   * [csech](#csech)
   * [ctan](#ctan)
   * [ctanh](#ctanh)
   * [even?](#even?)
   * [factors](#factors)
   * [gcd](#gcd)
   * [median](#median)
   * [negative?](#negative?)
   * [odd?](#odd?)
   * [positive?](#positive?)
   * [prime?](#prime?)
   * [product](#product)
   * [random](#random)
   * [range](#range)
   * [sec](#sec)
   * [sech](#sech)
   * [sin](#sin)
   * [sinh](#sinh)
   * [sqrt](#sqrt)
   * [sum](#sum)
   * [tan](#tan)
   * [tanh](#tanh)
   * [zero?](#zero?)
<!--te-->

---


## abs

#### Description

Get the absolute value for given integer

#### Usage

<pre>
<b>abs</b> <ins>value</ins> <i>:integer</i>
</pre>

#### Returns

- *:integer*

#### Examples

```red
print abs 6       ; 6
print abs 6-7     ; 1
```

## acos

#### Description

Calculate the inverse cosine of given angle

#### Usage

<pre>
<b>acos</b> <ins>angle</ins> <i>:floating</i>
</pre>

#### Returns

- *:floating*


## acosh

#### Description

Calculate the inverse hyperbolic cosine of given angle

#### Usage

<pre>
<b>acosh</b> <ins>angle</ins> <i>:floating</i>
</pre>

#### Returns

- *:floating*


## asin

#### Description

Calculate the inverse sine of given angle

#### Usage

<pre>
<b>asin</b> <ins>angle</ins> <i>:floating</i>
</pre>

#### Returns

- *:floating*


## asinh

#### Description

Calculate the inverse hyperbolic sine of given angle

#### Usage

<pre>
<b>asinh</b> <ins>angle</ins> <i>:floating</i>
</pre>

#### Returns

- *:floating*


## atan

#### Description

Calculate the inverse tangent of given angle

#### Usage

<pre>
<b>atan</b> <ins>angle</ins> <i>:floating</i>
</pre>

#### Returns

- *:floating*


## atanh

#### Description

Calculate the inverse hyperbolic tangent of given angle

#### Usage

<pre>
<b>atanh</b> <ins>angle</ins> <i>:floating</i>
</pre>

#### Returns

- *:floating*


## average

#### Description

Get average from given collection of numbers

#### Usage

<pre>
<b>average</b> <ins>collection</ins> <i>:block</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print average [2 4 5 6 7 2 3]
; 4.142857142857143
```

## cos

#### Description

Calculate the cosine of given angle

#### Usage

<pre>
<b>cos</b> <ins>angle</ins> <i>:floating</i>
</pre>

#### Returns

- *:floating*


## cosh

#### Description

Calculate the hyperbolic cosine of given angle

#### Usage

<pre>
<b>cosh</b> <ins>angle</ins> <i>:floating</i>
</pre>

#### Returns

- *:floating*


## csec

#### Description

Calculate the cosecant of given angle

#### Usage

<pre>
<b>csec</b> <ins>angle</ins> <i>:floating</i>
</pre>

#### Returns

- *:floating*


## csech

#### Description

Calculate the hyperbolic cosecant of given angle

#### Usage

<pre>
<b>csech</b> <ins>angle</ins> <i>:floating</i>
</pre>

#### Returns

- *:floating*


## ctan

#### Description

Calculate the cotangent of given angle

#### Usage

<pre>
<b>ctan</b> <ins>angle</ins> <i>:floating</i>
</pre>

#### Returns

- *:floating*


## ctanh

#### Description

Calculate the hyperbolic cotangent of given angle

#### Usage

<pre>
<b>ctanh</b> <ins>angle</ins> <i>:floating</i>
</pre>

#### Returns

- *:floating*


## even?

#### Description

Check if given number is even

#### Usage

<pre>
<b>even?</b> <ins>number</ins> <i>:integer</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
even? 4           ; => true
even? 3           ; => false

print select 1..10 => even?       ; 2 4 6 8 10
```

## factors

#### Description

Get list of factors for given integer

#### Usage

<pre>
<b>factors</b> <ins>number</ins> <i>:integer</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|prime|<i>:boolean</i>|get only prime factors|

#### Returns

- *:block*

#### Examples

```red
factors 16          ; => [1 2 4 8 16]
factors.prime 16    ; => [2]
```

## gcd

#### Description

Calculate greatest common divisor for given collection of integers

#### Usage

<pre>
<b>gcd</b> <ins>numbers</ins> <i>:block</i>
</pre>

#### Returns

- *:integer*

#### Examples

```red
print gcd [48 60 120]         ; 12
```

## median

#### Description

Get median from given collection of numbers

#### Usage

<pre>
<b>median</b> <ins>collection</ins> <i>:block</i>
</pre>

#### Returns

- *:null*
- *:integer*
- *:floating*

#### Examples

```red
print median [2 4 5 6 7 2 3]
; 6

print median [1 5 2 3 4 7 9 8]
; 3.5
```

## negative?

#### Description

Check if given number is negative

#### Usage

<pre>
<b>negative?</b> <ins>number</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
negative? 5       ; => false
negative? 6-7     ; => true
```

## odd?

#### Description

Check if given number is odd

#### Usage

<pre>
<b>odd?</b> <ins>number</ins> <i>:integer</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
odd? 4            ; => false
odd? 3            ; => true

print select 1..10 => odd?       ; 1 3 5 7 9
```

## positive?

#### Description

Check if given number is positive

#### Usage

<pre>
<b>positive?</b> <ins>number</ins> <i>:integer</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
positive? 5       ; => true
positive? 6-7     ; => false
```

## prime?

#### Description

Check if given integer is prime

#### Usage

<pre>
<b>prime?</b> <ins>number</ins> <i>:integer</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
prime? 2          ; => true
prime? 6          ; => false
prime? 11         ; => true

; let's check the 14th Mersenne:
; 53113799281676709868958820655246862732959311772703192319944413
; 82004035598608522427391625022652292856688893294862465010153465
; 79337652707239409519978766587351943831270835393219031728127

prime? (2^607)-1  ; => true
```

## product

#### Description

Calculate the product of all values in given list

#### Usage

<pre>
<b>product</b> <ins>collection</ins> <i>:block</i>
</pre>

#### Returns

- *:integer*
- *:floating*

#### Examples

```red
print product [3 4]       ; 12
print product [1 2 4 6]   ; 48

print product 1..10       ; 3628800
```

## random

#### Description

Get a random integer between given limits

#### Usage

<pre>
<b>random</b> <ins>lowerLimit</ins> <i>:integer</i>
       <ins>upperLimit</ins> <i>:integer</i>
</pre>

#### Returns

- *:integer*

#### Examples

```red
rnd: random 0 60          ; rnd: (a random number between 0 and 60)
```

## range

#### Description

Get list of numbers in given range (inclusive)

#### Usage

<pre>
<b>range</b> <ins>from</ins> <i>:integer</i>
      <ins>to</ins> <i>:integer</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|step|<i>:integer</i>|use step between range values|

#### Returns

- *:block*

#### Examples

```red
print range 1 4       ; 1 2 3 4
1..10                 ; [1 2 3 4 5 6 7 8 9 10]
```

## sec

#### Description

Calculate the secant of given angle

#### Usage

<pre>
<b>sec</b> <ins>angle</ins> <i>:floating</i>
</pre>

#### Returns

- *:floating*


## sech

#### Description

Calculate the hyperbolic secant of given angle

#### Usage

<pre>
<b>sech</b> <ins>angle</ins> <i>:floating</i>
</pre>

#### Returns

- *:floating*


## sin

#### Description

Calculate the sine of given angle

#### Usage

<pre>
<b>sin</b> <ins>angle</ins> <i>:floating</i>
</pre>

#### Returns

- *:floating*


## sinh

#### Description

Calculate the hyperbolic sine of given angle

#### Usage

<pre>
<b>sinh</b> <ins>angle</ins> <i>:floating</i>
</pre>

#### Returns

- *:floating*


## sqrt

#### Description

Get square root of given value

#### Usage

<pre>
<b>sqrt</b> <ins>value</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*


## sum

#### Description

Calculate the sum of all values in given list

#### Usage

<pre>
<b>sum</b> <ins>collection</ins> <i>:block</i>
</pre>

#### Returns

- *:integer*
- *:floating*

#### Examples

```red
print sum [3 4]           ; 7
print sum [1 2 4 6]       ; 13

print sum 1..10           ; 55
```

## tan

#### Description

Calculate the tangent of given angle

#### Usage

<pre>
<b>tan</b> <ins>angle</ins> <i>:floating</i>
</pre>

#### Returns

- *:floating*


## tanh

#### Description

Calculate the hyperbolic tangent of given angle

#### Usage

<pre>
<b>tanh</b> <ins>angle</ins> <i>:floating</i>
</pre>

#### Returns

- *:floating*


## zero?

#### Description

Check if given number is zero

#### Usage

<pre>
<b>zero?</b> <ins>number</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
zero? 5-5         ; => true
zero? 4           ; => false
```