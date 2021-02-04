### Functions

---

<!--ts-->
   * [close](#close)
   * [query](#query)
   * [open](#open)
<!--te-->

---


## close

#### Description

Close given database

#### Usage

<pre>
<b>close</b> <ins>database</ins> <i>:database</i>
</pre>

#### Returns

- *:nothing*


## query

#### Description

Execute command or block of commands in given database and get returned rows

#### Usage

<pre>
<b>query</b> <ins>database</ins> <i>:database</i>
      <ins>commands</ins> <i>:string</i> <i>:block</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|id|<i>:boolean</i>|return last INSERT id|

#### Returns

- *:null*
- *:integer*
- *:block*


## open

#### Description

Opens a new database connection and returns database

#### Usage

<pre>
<b>open</b> <ins>name</ins> <i>:string</i>
</pre>
#### Attributes

|Attribute|Type|Description|
|---|---|---|
|sqlite|<i>:boolean</i>|support for SQLite databases|
|mysql|<i>:boolean</i>|support for MySQL databases|

#### Returns

- *:integer*

#### Examples

```red
db: open "my.db"    ; opens an SQLite database named 'my.db'
```