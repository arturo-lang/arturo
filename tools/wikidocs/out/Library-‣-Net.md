### Functions

---

<!--ts-->
   * [download](#download)
   * [mail](#mail)
   * [serve](#serve)
<!--te-->

---


## download

#### Description

Download file from url to disk

#### Usage

<pre>
<b>download</b> <ins>url</ins> <i>:string</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|as|<i>:string</i>|set target file|

#### Returns

- *:nothing*

#### Examples

```red
download "https://github.com/arturo-lang/arturo/raw/master/logo.png"
; (downloads file as "logo.png")

download.as:"arturoLogo.png"
            "https://github.com/arturo-lang/arturo/raw/master/logo.png"

; (downloads file with a different name)
```

## mail

#### Description

Send mail using given message and configuration

#### Usage

<pre>
<b>mail</b> <ins>recipient</ins> <i>:string</i>
     <ins>message</ins> <i>:dictionary</i>
     <ins>config</ins> <i>:dictionary</i>
</pre>

#### Returns

- *:nothing*

#### Examples

```red
mail "recipient@somemail.com"
      #[
           title: "Hello from Arturo"
           content: "Arturo rocks!"
       ]
      #[
           server: "mymailserver.com"
           username: "myusername"
           password: "mypass123"
       ]
```

## serve

#### Description

Start web server using given routes

#### Usage

<pre>
<b>serve</b> <ins>routes</ins> <i>:dictionary</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|port|<i>:integer</i>|use given port|
|verbose|<i>:boolean</i>|print info log|
|chrome|<i>:boolean</i>|open in Chrome windows as an app|

#### Returns

- *:nothing*

#### Examples

```red
serve .port:18966 [
    "/":                          [ "This is the homepage" ]
    "/post/(?<title>[a-z]+)":     [ render "We are in post: |title|" ]
]

; (run the app and go to localhost:18966 - that was it!)
```