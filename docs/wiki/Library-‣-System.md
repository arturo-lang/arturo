### Functions

---

<!--ts-->
   * [ensure](#ensure)
   * [execute](#execute)
   * [exit](#exit)
   * [list](#list)
   * [panic](#panic)
   * [pause](#pause)
<!--te-->

---


## ensure

#### Description

Assert given condition is true, or exit

#### Usage

<pre>
<b>ensure</b> <ins>condition</ins> <i>:block</i>
</pre>

#### Returns

- *:nothing*

#### Examples

```red
num: input "give me a positive number"

ensure [num > 0]

print "good, the number is positive indeed. let's continue..."
```

## execute

#### Description

Execute given shell command

#### Usage

<pre>
<b>execute</b> <ins>command</ins> <i>:string</i>
</pre>

#### Returns

- *:string*

#### Examples

```red
print execute "pwd"
; /Users/admin/Desktop

split.lines execute "ls"
; => ["tests" "var" "data.txt"]
```

## exit

#### Description

Exit program

#### Usage

<pre>
<b>exit</b> 
</pre>

#### Returns

- *:nothing*

#### Examples

```red
exit              ; (terminates the program)

exit.with: 3      ; (terminates the program with code 3)
```

## list

#### Description

Get files at given path

#### Usage

<pre>
<b>list</b> <ins>path</ins> <i>:string</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|select|<i>:string</i>|select files satisfying given pattern|
|relative|<i>:boolean</i>|get relative paths|

#### Returns

- *:block*

#### Examples

```red
loop list "." 'file [
   print file
]

; ./tests
; ./var
; ./data.txt

loop list.relative "tests" 'file [
   print file
]

; test1.art
; test2.art
; test3.art
```

## panic

#### Description

Exit program with error message

#### Usage

<pre>
<b>panic</b> <ins>message</ins> <i>:string</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|code|<i>:integer</i>|return given exit code|

#### Returns

- *:boolean*

#### Examples

```red
panic.code:1 "something went terribly wrong. quitting..."
```

## pause

#### Description

Pause program's execution~for the given amount of milliseconds

#### Usage

<pre>
<b>pause</b> <ins>time</ins> <i>:integer</i>
</pre>

#### Returns

- *:nothing*

#### Examples

```red
print "wait a moment"

pause 1000      ; sleeping for one second

print "done. let's continue..."
```