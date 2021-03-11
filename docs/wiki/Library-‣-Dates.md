### Functions

---

<!--ts-->
   * [after](#after)
   * [before](#before)
   * [leap?](#leap?)
   * [now](#now)
<!--te-->

---


## after

#### Description

Get date after given one using interval

#### Usage

<pre>
<b>after</b> <ins>date</ins> <i>:literal</i> <i>:date</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|nanoseconds|<i>:integer</i>|add given number of nanoseconds|
|milliseconds|<i>:integer</i>|add given number of milliseconds|
|seconds|<i>:integer</i>|add given number of seconds|
|minutes|<i>:integer</i>|add given number of minutes|
|hours|<i>:integer</i>|add given number of hours|
|days|<i>:integer</i>|add given number of days|
|weeks|<i>:integer</i>|add given number of weeks|
|months|<i>:integer</i>|add given number of months|
|years|<i>:integer</i>|add given number of years|

#### Returns

- *:date*


## before

#### Description

Get date before given one using interval

#### Usage

<pre>
<b>before</b> <ins>date</ins> <i>:date</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|nanoseconds|<i>:integer</i>|subtract given number of nanoseconds|
|milliseconds|<i>:integer</i>|subtract given number of milliseconds|
|seconds|<i>:integer</i>|subtract given number of seconds|
|minutes|<i>:integer</i>|subtract given number of minutes|
|hours|<i>:integer</i>|subtract given number of hours|
|days|<i>:integer</i>|subtract given number of days|
|weeks|<i>:integer</i>|subtract given number of weeks|
|months|<i>:integer</i>|subtract given number of months|
|years|<i>:integer</i>|subtract given number of years|

#### Returns

- *:date*


## leap?

#### Description

Check if given year is a leap year

#### Usage

<pre>
<b>leap?</b> <ins>year</ins> <i>:integer</i> <i>:date</i>
</pre>

#### Returns

- *:boolean*

#### Examples

```red
print leap? now     ; false

print map 2019..2021 => leap? 
; false true false
```

## now

#### Description

Get date/time now

#### Usage

<pre>
<b>now</b> 
</pre>

#### Returns

- *:date*

#### Examples

```red
print now           ; 2020-10-23T14:16:13+02:00

time: now
inspect time

; [ :date
;       hour        : 14 :integer
;       minute      : 16 :integer
;       second      : 55 :integer
;       nanosecond  : 82373000 :integer
;       day         : 23 :integer
;       Day         : Friday :string
;       month       : 10 :integer
;       Month       : October :string
;       year        : 2020 :integer
;       utc         : -7200 :integer
; ]

print now\year      ; 2020
```