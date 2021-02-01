### Functions

---

<!--ts-->
   * [extract](#extract)
   * [module](#module)
   * [relative](#relative)
<!--te-->

---


## extract

#### Description

Extract components from path

#### Usage

<pre>
<b>extract</b> <ins>path</ins> <i>:string</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|directory|<i>:boolean</i>|get path directory|
|basename|<i>:boolean</i>|get path basename (filename+extension)|
|filename|<i>:boolean</i>|get path filename|
|extension|<i>:boolean</i>|get path extension|
|scheme|<i>:boolean</i>|get scheme field from URL|
|host|<i>:boolean</i>|get host field from URL|
|port|<i>:boolean</i>|get port field from URL|
|user|<i>:boolean</i>|get user field from URL|
|password|<i>:boolean</i>|get password field from URL|
|path|<i>:boolean</i>|get path field from URL|
|query|<i>:boolean</i>|get query field from URL|
|anchor|<i>:boolean</i>|get anchor field from URL|

#### Returns

- *:string*
- *:dictionary*


## module

#### Description

Get path for given module name

#### Usage

<pre>
<b>module</b> <ins>name</ins> <i>:string</i> <i>:literal</i>
</pre>

#### Returns

- *:null*
- *:string*

#### Examples

```red
print module 'html        ; /usr/local/lib/arturo/html.art

do.import module 'html    ; (imports given module)
```

## relative

**Alias:** `./`

#### Description

Get relative path for given path, based on current script's location

#### Usage

<pre>
<b>relative</b> <ins>path</ins> <i>:string</i>
</pre>

#### Returns

- *:string*

#### Examples

```red
; we are in folder: /Users/admin/Desktop

print relative "test.txt"
; /Users/admin/Desktop/test.txt
```