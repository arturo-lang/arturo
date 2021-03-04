### Functions

---

<!--ts-->
   * [exists?](#exists?)
   * [read](#read)
   * [unzip](#unzip)
   * [write](#write)
   * [zip](#zip)
<!--te-->

---


## exists?

#### Description

Check if given file exists

#### Usage

<pre>
<b>exists?</b> <ins>file</ins> <i>:string</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|dir|<i>:boolean</i>|check for directory|

#### Returns

- *:boolean*

#### Examples

```red
if exists? "somefile.txt" [ 
    print "file exists!" 
]
```

## read

**Alias:** `<<`

#### Description

Read file from given path

#### Usage

<pre>
<b>read</b> <ins>file</ins> <i>:string</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|lines|<i>:boolean</i>|read file lines into block|
|json|<i>:boolean</i>|read Json into value|
|csv|<i>:boolean</i>|read CSV file into a block of rows|
|withHeaders|<i>:boolean</i>|read CSV headers|
|html|<i>:boolean</i>|read HTML file into node dictionary|
|markdown|<i>:boolean</i>|read Markdown and convert to HTML|
|toml|<i>:boolean</i>|read TOML into value|
|binary|<i>:boolean</i>|read as binary|

#### Returns

- *:string*
- *:binary*
- *:block*

#### Examples

```red
; reading a simple local file
str: read "somefile.txt"

; also works with remote urls
page: read "http://www.somewebsite.com/page.html"

; we can also "read" JSON data as an object
data: read.json "mydata.json"

; or even convert Markdown to HTML on-the-fly
html: read.markdown "## Hello"     ; "<h2>Hello</h2>"
```

## unzip

#### Description

Unzip given archive to destination

#### Usage

<pre>
<b>unzip</b> <ins>destination</ins> <i>:string</i>
      <ins>original</ins> <i>:string</i>
</pre>

#### Returns

- *:nothing*

#### Examples

```red
unzip "folder" "archive.zip"
```

## write

**Alias:** `>>`

#### Description

Write content to file at given path

#### Usage

<pre>
<b>write</b> <ins>file</ins> <i>:null</i> <i>:string</i>
      <ins>content</ins> <i>:any</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|directory|<i>:boolean</i>|create directory at path|
|json|<i>:boolean</i>|write value as Json|
|binary|<i>:boolean</i>|write as binary|

#### Returns

- *:nothing*

#### Examples

```red
; write some string data to given file path
write "somefile.txt" "Hello world!"

; we can also write any type of data as JSON
write.json "data.json" myData
```

## zip

#### Description

Zip given files to file at destination

#### Usage

<pre>
<b>zip</b> <ins>destination</ins> <i>:string</i>
    <ins>files</ins> <i>:block</i>
</pre>

#### Returns

- *:nothing*

#### Examples

```red
zip "dest.zip" ["file1.txt" "img.png"]
```