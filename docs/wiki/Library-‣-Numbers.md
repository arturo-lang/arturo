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
   * [ceil](#ceil)
   * [cos](#cos)
   * [cosh](#cosh)
   * [csec](#csec)
   * [csech](#csech)
   * [ctan](#ctan)
   * [ctanh](#ctanh)
   * [even?](#even?)
   * [exp](#exp)
   * [factors](#factors)
   * [floor](#floor)
   * [gamma](#gamma)
   * [gcd](#gcd)
   * [ln](#ln)
   * [log](#log)
   * [median](#median)
   * [negative?](#negative?)
   * [odd?](#odd?)
   * [positive?](#positive?)
   * [prime?](#prime?)
   * [product](#product)
   * [random](#random)
   * [range](#range)
   * [round](#round)
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
<b>abs</b> <ins>value</ins> <i>:integer</i> <i>:floating</i>
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
<b>acos</b> <ins>angle</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print acos 0            ; 1.570796326794897
print acos 0.3          ; 1.266103672779499
print acos 1.0          ; 0.0
```

## acosh

#### Description

Calculate the inverse hyperbolic cosine of given angle

#### Usage

<pre>
<b>acosh</b> <ins>angle</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print acosh 1.0         ; 0.0
print acosh 2           ; 1.316957896924817
print acosh 5.0         ; 2.292431669561178
```

## asin

#### Description

Calculate the inverse sine of given angle

#### Usage

<pre>
<b>asin</b> <ins>angle</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print asin 0            ; 0.0
print asin 0.3          ; 0.3046926540153975
print asin 1.0          ; 1.570796326794897
```

## asinh

#### Description

Calculate the inverse hyperbolic sine of given angle

#### Usage

<pre>
<b>asinh</b> <ins>angle</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print asinh 0           ; 0.0
print asinh 0.3         ; 0.2956730475634224
print asinh 1.0         ; 0.881373587019543
```

## atan

#### Description

Calculate the inverse tangent of given angle

#### Usage

<pre>
<b>atan</b> <ins>angle</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print atan 0            ; 0.0
print atan 0.3          ; 0.2914567944778671
print atan 1.0          ; 0.7853981633974483
```

## atanh

#### Description

Calculate the inverse hyperbolic tangent of given angle

#### Usage

<pre>
<b>atanh</b> <ins>angle</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print atanh 0           ; 0.0
print atanh 0.3         ; 0.3095196042031118
print atanh 1.0         ; inf
```

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

## ceil

#### Description

Calculate the smallest integer not smaller than given value

#### Usage

<pre>
<b>ceil</b> <ins>value</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:integer*

#### Examples

```red
print ceil 2.1          ; 3
print ceil 2.9          ; 3
print ceil neg 3.5      ; -3
print ceil 4            ; 4
```

## cos

#### Description

Calculate the cosine of given angle

#### Usage

<pre>
<b>cos</b> <ins>angle</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print cos 0             ; 1.0
print cos 0.3           ; 0.955336489125606
print cos 1.0           ; 0.5403023058681398
```

## cosh

#### Description

Calculate the hyperbolic cosine of given angle

#### Usage

<pre>
<b>cosh</b> <ins>angle</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print cosh 0            ; 1.0
print cosh 0.3          ; 1.04533851412886
print cosh 1.0          ; 1.543080634815244
```

## csec

#### Description

Calculate the cosecant of given angle

#### Usage

<pre>
<b>csec</b> <ins>angle</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print csec 0            ; inf
print csec 0.3          ; 3.383863361824123
print csec 1.0          ; 1.188395105778121
```

## csech

#### Description

Calculate the hyperbolic cosecant of given angle

#### Usage

<pre>
<b>csech</b> <ins>angle</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print csech 0           ; inf
print csech 0.3         ; 3.283853396698424
print csech 1.0         ; 0.8509181282393216
```

## ctan

#### Description

Calculate the cotangent of given angle

#### Usage

<pre>
<b>ctan</b> <ins>angle</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print ctan 0            ; inf
print ctan 0.3          ; 3.232728143765828
print ctan 1.0          ; 0.6420926159343308
```

## ctanh

#### Description

Calculate the hyperbolic cotangent of given angle

#### Usage

<pre>
<b>ctanh</b> <ins>angle</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print ctanh 0           ; inf
print ctanh 0.3         ; 3.432738430321741
print ctanh 1.0         ; 1.313035285499331
```

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

## exp

#### Description

Calculate the exponential function for given value

#### Usage

<pre>
<b>exp</b> <ins>value</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print exp 1.0       ; 2.718281828459045
print exp 0         ; 1.0
print exp neg 1.0   ; 0.3678794411714423
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

## floor

#### Description

Calculate the largest integer not greater than given value

#### Usage

<pre>
<b>floor</b> <ins>value</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:integer*

#### Examples

```red
print floor 2.1         ; 2
print floor 2.9         ; 2
print floor neg 3.5     ; -4
print floor 4           ; 4
```

## gamma

#### Description

Calculate the gamma function for given value

#### Usage

<pre>
<b>gamma</b> <ins>value</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print gamma 3.0         ; 2.0
print gamma 10.0        ; 362880.0
print gamma 15          ; 87178291199.99985
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

## ln

#### Description

Calculate the natural logarithm of given value

#### Usage

<pre>
<b>ln</b> <ins>value</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print ln 1.0            ; 0.0
print ln 0              ; -inf
print ln neg 7.0        ; nan
```

## log

#### Description

Calculate the logarithm of value using given base

#### Usage

<pre>
<b>log</b> <ins>value</ins> <i>:integer</i> <i>:floating</i>
    <ins>base</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print log 9 3           ; 2.0
print log 32.0 2.0      ; 5.0
print log 0.0 2         ; -inf
print log 100.0 10.0    ; 2.0
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

**Alias:** `..`

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

## round

#### Description

Round given value

#### Usage

<pre>
<b>round</b> <ins>value</ins> <i>:integer</i> <i>:floating</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|to|<i>:integer</i>|round to given decimal places|

#### Returns

- *:floating*

#### Examples

```red
print round 2.1         ; 2.0
print round 2.9         ; 3.0
print round 6           ; 6.0

print round pi          ; 3.0
print round.to:5 pi     ; 3.14159
print round.to:2 pi     ; 3.14
```

## sec

#### Description

Calculate the secant of given angle

#### Usage

<pre>
<b>sec</b> <ins>angle</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print sec 0             ; 1.0
print sec 0.3           ; 1.046751601538086
print sec 1.0           ; 1.850815717680925
```

## sech

#### Description

Calculate the hyperbolic secant of given angle

#### Usage

<pre>
<b>sech</b> <ins>angle</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print sech 0            ; 1.0
print sech 0.3          ; 0.9566279119002483
print sech 1.0          ; 0.6480542736638855
```

## sin

#### Description

Calculate the sine of given angle

#### Usage

<pre>
<b>sin</b> <ins>angle</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print sin 0             ; 0.0
print sin 0.3           ; 0.2955202066613395
print sin 1.0           ; 0.8414709848078965
```

## sinh

#### Description

Calculate the hyperbolic sine of given angle

#### Usage

<pre>
<b>sinh</b> <ins>angle</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print sinh 0            ; 0.0
print sinh 0.3          ; 0.3045202934471426
print sinh 1.0          ; 1.175201193643801
```

## sqrt

#### Description

Get square root of given value

#### Usage

<pre>
<b>sqrt</b> <ins>value</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print sqrt 4            ; 2.0
print sqrt 16.0         ; 4.0
print sqrt 1.45         ; 1.20415945787923
```

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
<b>tan</b> <ins>angle</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print tan 0             ; 0.0
print tan 0.3           ; 0.3093362496096232
print tan 1.0           ; 1.557407724654902
```

## tanh

#### Description

Calculate the hyperbolic tangent of given angle

#### Usage

<pre>
<b>tanh</b> <ins>angle</ins> <i>:integer</i> <i>:floating</i>
</pre>

#### Returns

- *:floating*

#### Examples

```red
print tanh 0            ; 0.0
print tanh 0.3          ; 0.2913126124515909
print tanh 1.0          ; 0.7615941559557649
```

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