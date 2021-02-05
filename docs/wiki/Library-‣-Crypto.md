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

Base-64 encode given value

#### Usage

<pre>
<b>decode</b> <ins>value</ins> <i>:string</i> <i>:literal</i>
</pre>

#### Returns

- *:string*
- *:nothing*

#### Examples

```red
print decode "TnVtcXVhbSBmdWdpZW5zIHJlc3BleGVyaXM="
; Numquam fugiens respexeris
```

## encode

#### Description

Base-64 decode given value

#### Usage

<pre>
<b>encode</b> <ins>value</ins> <i>:string</i> <i>:literal</i>
</pre>

#### Returns

- *:string*
- *:nothing*

#### Examples

```red
print encode "Numquam fugiens respexeris"
; TnVtcXVhbSBmdWdpZW5zIHJlc3BleGVyaXM=
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
