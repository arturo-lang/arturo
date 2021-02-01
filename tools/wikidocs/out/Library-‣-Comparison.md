### Functions

---

<!--ts-->
   * [equal?](#equal?)
   * [greater?](#greater?)
   * [greaterOrEqual?](#greaterOrEqual?)
   * [less?](#less?)
   * [lessOrEqual?](#lessOrEqual?)
   * [notEqual?](#notEqual?)
<!--te-->

---


## equal?

**Alias:** `=`

#### Description

Check if valueA = valueB (equality)

#### Usage

<pre>
<b>equal?</b> <ins>valueA</ins> <i>:any</i>
       <ins>valueB</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
equal? 5 2            ; => false
equal? 5 6-1          ; => true

print 3=3             ; true
```

## greater?

**Alias:** `>`

#### Description

Check if valueA > valueB (greater than)

#### Usage

<pre>
<b>greater?</b> <ins>valueA</ins> <i>:any</i>
         <ins>valueB</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
greater? 5 2          ; => true
greater? 5 6-1        ; => false

print 3>2             ; true
```

## greaterOrEqual?

**Alias:** `>=`

#### Description

Check if valueA >= valueB (greater than or equal)

#### Usage

<pre>
<b>greaterOrEqual?</b> <ins>valueA</ins> <i>:any</i>
                <ins>valueB</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
greaterOrEqual? 5 2   ; => true
greaterOrEqual? 5 4-1 ; => false

print 2>=2            ; true
```

## less?

**Alias:** `<`

#### Description

Check if valueA < valueB (less than)

#### Usage

<pre>
<b>less?</b> <ins>valueA</ins> <i>:any</i>
      <ins>valueB</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
less? 5 2             ; => false
less? 5 6+1           ; => true

print 2<3             ; true
```

## lessOrEqual?

**Alias:** `=<`

#### Description

Check if valueA =< valueB (less than or equal)

#### Usage

<pre>
<b>lessOrEqual?</b> <ins>valueA</ins> <i>:any</i>
             <ins>valueB</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
lessOrEqual? 5 2      ; => false
lessOrEqual? 5 6-1    ; => true

print 2=<3            ; true
```

## notEqual?

**Alias:** `<>`

#### Description

Check if valueA <> valueB (not equal)

#### Usage

<pre>
<b>notEqual?</b> <ins>valueA</ins> <i>:any</i>
          <ins>valueB</ins> <i>:any</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
notEqual? 5 2         ; => true
notEqual? 5 6-1       ; => false

print 2<>3            ; true
```