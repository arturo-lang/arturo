### Functions

---

<!--ts-->
   * [decode](#decode)
   * [encode](#encode)
   * [digest](#digest)
   * [hash](#hash)
<!--te-->

---


## decode

#### Description

Encode given value (default: base-64)

#### Usage

<pre>
<b>decode</b> <ins>value</ins> <i>:string</i> <i>:literal</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|url|<i>:boolean</i>|decode URL based on RFC3986|

#### Returns

- *:string*
- *:nothing*

#### Examples

```red
print decode "TnVtcXVhbSBmdWdpZW5zIHJlc3BleGVyaXM="
; Numquam fugiens respexeris

print decode.url "http%3A%2F%2Ffoo+bar%2F"
; http://foo bar/
```

## encode

#### Description

Decode given value (default: base-64)

#### Usage

<pre>
<b>encode</b> <ins>value</ins> <i>:string</i> <i>:literal</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|url|<i>:boolean</i>|encode URL based on RFC3986|
|from|<i>:string</i>|source character encoding (default: CP1252)|
|to|<i>:string</i>|target character encoding (default: UTF-8)|

#### Returns

- *:string*
- *:nothing*

#### Examples

```red
print encode "Numquam fugiens respexeris"
; TnVtcXVhbSBmdWdpZW5zIHJlc3BleGVyaXM=

print encode.url "http://foo bar/"
; http%3A%2F%2Ffoo+bar%2F
```

## digest

#### Description

Get digest for given value (default: MD5)

#### Usage

<pre>
<b>digest</b> <ins>value</ins> <i>:string</i> <i>:literal</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|sha|<i>:boolean</i>|use SHA1|

#### Returns

- *:string*
- *:nothing*

#### Examples

```red
print digest "Hello world"
; 3e25960a79dbc69b674cd4ec67a72c62

print digest.sha "Hello world"
; 7b502c3a1f48c8609ae212cdfb639dee39673f5e
```

## hash

#### Description

Get hash for given value

#### Usage

<pre>
<b>hash</b> <ins>value</ins> <i>:any</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|string|<i>:boolean</i>|get as a string|

#### Returns

- *:integer*
- *:string*

#### Examples

```red
print hash "hello"      ; 613153351
print hash [1 2 3]      ; 645676735036410
print hash 123          ; 123

a: [1 2 3]
b: [1 2 3]
print (hash a)=(hash b) ; true
```