### Functions

---

<!--ts-->
   * [leap?](#leap?)
   * [now](#now)
<!--te-->

---


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