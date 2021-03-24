### Functions

---

<!--ts-->
   * [arg](#arg)
   * [args](#args)
   * [env](#env)
   * [execute](#execute)
   * [exit](#exit)
   * [panic](#panic)
   * [pause](#pause)
   * [sys](#sys)
<!--te-->

---


## arg

#### Description

Access command-line arguments as a list

#### Returns

- *:block*

## args

#### Description

A dictionary with all command-line arguments parsed

#### Returns

- *:dictionary*

## env

#### Description

Get environment variables

#### Usage

<pre>
<b>env</b> 
</pre>

#### Returns

- *:dictionary*

#### Examples

```red
print env\SHELL
; /bin/zsh

print env\HOME
; /Users/drkameleon

print env\PATH
; /Users/drkameleon/.arturo/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
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

## sys

#### Description

Information about the current system

#### Returns

- *:dictionary*