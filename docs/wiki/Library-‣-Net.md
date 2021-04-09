### Functions

---

<!--ts-->
   * [download](#download)
   * [mail](#mail)
   * [request](#request)
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

## request

#### Description

Perform HTTP request to url with given data and get response

#### Usage

<pre>
<b>request</b> <ins>url</ins> <i>:string</i>
        <ins>data</ins> <i>:null</i> <i>:dictionary</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|get|<i>:boolean</i>|perform a GET request (default)|
|post|<i>:boolean</i>|perform a POST request|
|patch|<i>:boolean</i>|perform a PATCH request|
|put|<i>:boolean</i>|perform a PUT request|
|delete|<i>:boolean</i>|perform a DELETE request|
|json|<i>:boolean</i>|send data as Json|
|headers|<i>:dictionary</i>|send custom HTTP headers|
|agent|<i>:string</i>|use given user agent|
|timeout|<i>:integer</i>|set a timeout|
|proxy|<i>:string</i>|use given proxy url|
|raw|<i>:boolean</i>|return raw response with processing|

#### Returns

- *:dictionary*


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