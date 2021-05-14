### Functions

---

<!--ts-->
   * [difference](#difference)
   * [intersection](#intersection)
   * [subset?](#subset?)
   * [superset?](#superset?)
   * [union](#union)
<!--te-->

---


## difference

#### Description

Return the difference of given sets

#### Usage

<pre>
<b>difference</b> <ins>setA</ins> <i>:literal</i> <i>:block</i>
           <ins>setB</ins> <i>:block</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|symmetric|<i>:boolean</i>|get the symmetric difference|

#### Returns

- *:block*
- *:nothing*

#### Examples

```red
print difference [1 2 3 4] [3 4 5 6]
; 1 2

a: [1 2 3 4]
b: [3 4 5 6]
difference 'a b
; a: [1 2]

print difference.symmetric [1 2 3 4] [3 4 5 6]
; 1 2 5 6
```

## intersection

#### Description

Return the intersection of given sets

#### Usage

<pre>
<b>intersection</b> <ins>setA</ins> <i>:literal</i> <i>:block</i>
             <ins>setB</ins> <i>:block</i>
</pre>

#### Returns

- *:block*
- *:nothing*

#### Examples

```red
print intersection [1 2 3 4] [3 4 5 6]
; 3 4

a: [1 2 3 4]
b: [3 4 5 6]
intersection 'a b
; a: [3 4]
```

## subset?

#### Description

Check if given set is a subset of second set

#### Usage

<pre>
<b>subset?</b> <ins>setA</ins> <i>:block</i>
        <ins>setB</ins> <i>:block</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|proper|<i>:boolean</i>|check if proper subset|

#### Returns

- *:boolean*

#### Examples

```red
subset? [1 3] [1 2 3 4]
; => true

subset?.proper [1 3] [1 2 3 4]
; => true

subset? [1 3] [3 5 6]
; => false

subset? [1 3] [1 3]
; => true

subset?.proper [1 3] [1 3]
; => false
```

## superset?

#### Description

Check if given set is a superset of second set

#### Usage

<pre>
<b>superset?</b> <ins>setA</ins> <i>:block</i>
          <ins>setB</ins> <i>:block</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|proper|<i>:boolean</i>|check if proper superset|

#### Returns

- *:boolean*

#### Examples

```red
superset? [1 2 3 4] [1 3]
; => true

superset?.proper [1 2 3 4] [1 3]
; => true

superset? [3 5 6] [1 3]
; => false

superset? [1 3] [1 3]
; => true

superset?.proper [1 3] [1 3]
; => false
```

## union

#### Description

Return the union of given sets

#### Usage

<pre>
<b>union</b> <ins>setA</ins> <i>:literal</i> <i>:block</i>
      <ins>setB</ins> <i>:block</i>
</pre>

#### Returns

- *:block*
- *:nothing*

#### Examples

```red
print union [1 2 3 4] [3 4 5 6]
; 1 2 3 4 5 6

a: [1 2 3 4]
b: [3 4 5 6]
union 'a b
; a: [1 2 3 4 5 6]
```