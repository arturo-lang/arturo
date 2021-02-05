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

#### Examples

```red
path: "/this/is/some/path.txt"

print extract.directory path        ; /this/is/some
print extract.basename path         ; path.txt
print extract.filename path         ; path
print extract.extension path        ; .txt

print extract path 
; [directory:/this/is/some basename:path.txt filename:path extension:.txt]

url: "http://subdomain.website.com:8080/path/to/file.php?q=something#there"

print extract.scheme url            ; http
print extract.host url              ; subdomain.website.com
print extract.port url              ; 8080
print extract.user url              ; 
print extract.password url          ;
print extract.path url              ; /path/to/file.php
print extract.query url             ; q=something
print extract.anchor url            ; there

print extract url
; [scheme:http host:subdomain.website.com port:8080 user: password: path:/path/to/file.php query:q=something anchor:there]
```

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