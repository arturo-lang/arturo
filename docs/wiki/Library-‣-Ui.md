### Functions

---

<!--ts-->
   * [webview](#webview)
<!--te-->

---


## webview

#### Description

Show webview window with given url or html source

#### Usage

<pre>
<b>webview</b> <ins>content</ins> <i>:string</i> <i>:literal</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|title|<i>:string</i>|set window title|
|width|<i>:integer</i>|set window width|
|height|<i>:integer</i>|set window height|
|fixed|<i>:boolean</i>|window shouldn't be resizable|
|debug|<i>:boolean</i>|add inspector console|

#### Returns

- *:string*
- *:nothing*

#### Examples

```red
webview "Hello world!"
; (opens a webview windows with "Hello world!")

webview .width:  200 
        .height: 300
        .title:  "My webview app"
---
    <h1>This is my webpage</h1>
    <p>
        This is some content
    </p>
---
; (opens a webview with given attributes)
```