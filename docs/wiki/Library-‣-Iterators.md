### Functions

---

<!--ts-->
   * [every?](#every?)
   * [filter](#filter)
   * [fold](#fold)
   * [loop](#loop)
   * [map](#map)
   * [select](#select)
   * [some?](#some?)
<!--te-->

---


## every?

#### Description

Check if every single item in collection satisfy given condition

#### Usage

<pre>
<b>every?</b> <ins>collection</ins> <i>:block</i>
       <ins>params</ins> <i>:literal</i> <i>:block</i>
       <ins>condition</ins> <i>:block</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
if every? [2 4 6 8] 'x [even? x] 
    -> print "every number is an even integer"
; every number is an even integer

print every? 1..10 'x -> x < 11
; true

print every? [2 3 5 7 11 14] 'x [prime? x]
; false
```

## filter

#### Description

Get collection's items by filtering those that do not fulfil given condition

#### Usage

<pre>
<b>filter</b> <ins>collection</ins> <i>:literal</i> <i>:block</i>
       <ins>params</ins> <i>:literal</i> <i>:block</i>
       <ins>condition</ins> <i>:block</i>
</pre>

#### Returns

- *:block*
- *:nothing*

#### Examples

```red
print filter 1..10 [x][
    even? x
]
; 1 3 5 7 9

arr: 1..10
filter 'arr 'x -> even? x
print arr
; 1 3 5 7 9
```

## fold

#### Description

Flatten given collection by eliminating nested blocks

#### Usage

<pre>
<b>fold</b> <ins>collection</ins> <i>:literal</i> <i>:block</i>
     <ins>params</ins> <i>:literal</i> <i>:block</i>
     <ins>action</ins> <i>:block</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|seed|<i>:any</i>|use specific seed value|
|right|<i>:boolean</i>|perform right folding|

#### Returns

- *:block*
- *:nothing*

#### Examples

```red
fold 1..10 [x,y]-> x + y
; => 55 (1+2+3+4..) 

fold 1..10 .seed:1 [x,y][ x * y ]
; => 3628800 (10!) 

fold 1..3 [x y]-> x - y
; => -6

fold.right 1..3 [x y]-> x - y
; => 2
```

## loop

#### Description

Loop through collection, using given iterator and block

#### Usage

<pre>
<b>loop</b> <ins>collection</ins> <i>:integer</i> <i>:dictionary</i> <i>:inline</i> <i>:block</i>
     <ins>params</ins> <i>:literal</i> <i>:block</i>
     <ins>action</ins> <i>:block</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|with|<i>:literal</i>|use given index|
|forever|<i>:boolean</i>|cycle through collection infinitely|

#### Returns

- *:nothing*

#### Examples

```red
loop [1 2 3] 'x [
    print x
]
; 1
; 2
; 3

loop 1..3 [x][
    print ["x =>" x]
]
; x => 1
; x => 2
; x => 3

loop [A a B b C c] [x y][
    print [x "=>" y]
]
; A => a
; B => b
; C => c

user: #[
    name: "John"
    surname: "Doe"
]

loop user [k v][
    print [k "=>" v]
]
; name => John
; surname => Doe

loop.with:'i ["zero" "one" "two"] 'x [
    print ["item at:" i "=>" x]
]
; 0 => zero
; 1 => one
; 2 => two

loop.forever [1 2 3] => print 
; 1 2 3 1 2 3 1 2 3 ...
```

## map

#### Description

Map collection's items by applying given action

#### Usage

<pre>
<b>map</b> <ins>collection</ins> <i>:literal</i> <i>:block</i>
    <ins>params</ins> <i>:literal</i> <i>:block</i>
    <ins>action</ins> <i>:block</i>
</pre>

#### Returns

- *:block*
- *:nothing*

#### Examples

```red
print map 1..5 [x][
    2*x
]
; 2 4 6 8 10

arr: 1..5
map 'arr 'x -> 2*x
print arr
; 2 4 6 8 10
```

## select

#### Description

Get collection's items that fulfil given condition

#### Usage

<pre>
<b>select</b> <ins>collection</ins> <i>:literal</i> <i>:block</i>
       <ins>params</ins> <i>:literal</i> <i>:block</i>
       <ins>action</ins> <i>:block</i>
</pre>

#### Returns

- *:block*
- *:nothing*

#### Examples

```red
print select 1..10 [x][
    even? x
]
; 2 4 6 8 10

arr: 1..10
select 'arr 'x -> even? x
print arr
; 2 4 6 8 10
```

## some?

#### Description

Check if any of collection's items satisfy given condition

#### Usage

<pre>
<b>some?</b> <ins>collection</ins> <i>:block</i>
      <ins>params</ins> <i>:literal</i> <i>:block</i>
      <ins>condition</ins> <i>:block</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
if some? [1 3 5 6 7] 'x [even? x] 
    -> print "at least one number is an even integer"
; at least one number is an even integer

print some? 1..10 'x -> x > 9
; true

print some? [4 6 8 10] 'x [prime? x]
; false
```