### Functions

---

<!--ts-->
   * [clear](#clear)
   * [cursor](#cursor)
   * [goto](#goto)
   * [input](#input)
   * [print](#print)
   * [prints](#prints)
   * [terminal](#terminal)
<!--te-->

---


## clear

#### Description

Clear terminal

#### Usage

<pre>
<b>clear</b> 
</pre>

#### Returns

- *:nothing*

#### Examples

```red
clear             ; (clears the screen)
```

## cursor

#### Description

Turn cursor visibility on/off

#### Usage

<pre>
<b>cursor</b> <ins>visible</ins> <i>:boolean</i>
</pre>

#### Returns

- *:nothing*

#### Examples

```red
cursor false    ; (hides the cursor)
cursor true     ; (shows the cursor)
```

## goto

#### Description

Move cursor to given coordinates

#### Usage

<pre>
<b>goto</b> <ins>x</ins> <i>:null</i> <i>:integer</i>
     <ins>y</ins> <i>:null</i> <i>:integer</i>
</pre>

#### Returns

- *:nothing*

#### Examples

```red
goto 10 15      ; (move cursor to column 10, line 15)
goto 10 ø       ; (move cursor to column 10, same line)
```

## input

#### Description

Print prompt and get user input

#### Usage

<pre>
<b>input</b> <ins>prompt</ins> <i>:string</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|repl|<i>:boolean</i>|get input as if in a REPL|
|history|<i>:string</i>|set path for saving history|
|complete|<i>:block</i>|use given array for auto-completions|
|hint|<i>:dictionary</i>|use given dictionary for typing hints|

#### Returns

- *:string*

#### Examples

```red
name: input "What is your name? "
; (user enters his name: Bob)

print ["Hello" name "!"]
; Hello Bob!
```

## print

#### Description

Print given value to screen with newline

#### Usage

<pre>
<b>print</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:nothing*

#### Examples

```red
print "Hello world!"          ; Hello world!
```

## prints

#### Description

Print given value to screen

#### Usage

<pre>
<b>prints</b> <ins>value</ins> <i>:any</i>
</pre>

#### Returns

- *:nothing*

#### Examples

```red
prints "Hello "
prints "world"
print "!"             

; Hello world!
```

## terminal

#### Description

Get info about terminal

#### Usage

<pre>
<b>terminal</b> 
</pre>

#### Returns

- *:dictionary*

#### Examples

```red
print terminal      ; [width:107 height:34]
terminal\width      ; => 107
```