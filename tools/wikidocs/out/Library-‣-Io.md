### Functions

---

<!--ts-->
   * [clear](#clear)
   * [input](#input)
   * [print](#print)
   * [prints](#prints)
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

## input

#### Description

Print prompt and get user input

#### Usage

<pre>
<b>input</b> <ins>prompt</ins> <i>:string</i>
</pre>

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