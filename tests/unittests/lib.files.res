Created: temp/

>> copy

copy is working well!

>> copy.directory - with empty folders

copy empty directory is working well!

>> copy.directory - with filled folders

copy filled directory is working well!

>> delete

deleted

>> delete.directory - with empty folders

directories deleted!

>> delete.directory - with filled folders

directories & files deleted!

>> move

file.txt moved to dest/

>> move.directory - with empty folders

empty folders created inside input/
empty folders moved to dest/

>> move.directory - with filled folders

filled folders moved to dest/

>> permissions

[user:[read:true write:true execute:true] group:[read:true write:true execute:true] others:[read:true write:true execute:true]]
:dictionary

>> read

Hello, world
This is a multiline File.
:)
:string

>> read.lines

The Language ------------------------------  Arturo is an independently-developed, modern programming language, vaguely related to various other ones - including but not limited to: Logo, Rebol, Forth, Ruby, Haskell, D, Smalltalk, Tcl, and Lisp.  The language has been designed following some very simple and straightforward principles:  - Code is just a list of words, symbols and literal values - Words and symbols within a block are interpreted - when needed -     according to the context - No reserved words or keywords -     look for them as hard as you can; there are absolutely none 
:block

>> read.json

[name:Arturo version:0.9.83 build:b/12 platform:amd/win10]
:dictionary

>> read.csv

[language; version; platform] [Arturo; 0.9.83; win10] [Python; 3.9; gnu/linux] [Ruby; 3.2.1; macOS] 
:block

>> read.csv.withHeaders

[language; version; platform:Arturo; 0.9.83; win10] [language; version; platform:Python; 3.9; gnu/linux] [language; version; platform:Ruby; 3.2.1; macOS] 
:block

>> read.html

[attrs:[] text:

    Unordered List with Square Bullets
    
        Arturo
        Python
        Ruby
    
    
        Hello
        
        World
    

 body:[attrs:[] text:
    Unordered List with Square Bullets
    
        Arturo
        Python
        Ruby
    
    
        Hello
        
        World
    
 h2:[attrs:[] text:Unordered List with Square Bullets] ul:[attrs:[style:list-style-type:square;] text:
        Arturo
        Python
        Ruby
     li:[[attrs:[] text:Arturo] [attrs:[] text:Python] [attrs:[] text:Ruby]]] p:[attrs:[] text:
        Hello
        
        World
     br:[attrs:[] text:]]]]
:dictionary

>> read.xml

[name:Arturo Programming Language author:Yanis Zafiropulos category:Scripting and Concatenative _tag:language id:art] [name:CPython author:Guido van Rossum category:Scripting and Object Oriented _tag:language id:py] [name:Ruby author:Yukihiro Matsumoto category:Scripting and Object Oriented _tag:language id:rb] 
:block

>> read.markdown

<h1>Arturo Basics</h1>
<blockquote>
<p>Arturo is a very simple language.
Even without any prior experience,
I estimate it would take you roughly half an hour
before you are comfortable enough to write your first program.</p>
</blockquote>
<hr>
<ul>
<li><a href="https://arturo-lang.io/documentation/library">Library</a></li>
<li><a href="https://arturo-lang.io/documentation/examples">Examples</a></li>
</ul>
<h2>First Steps</h2>
<ol>
<li><a href="https://arturo-lang.io/documentation/language/#the-main-components">Main Components</a></li>
<li><a href="https://arturo-lang.io/documentation/language/#precedence-and-evaluation">Precedence &amp; Evaluation</a></li>
<li><a href="https://arturo-lang.io/documentation/language/#scope-and-rules">Scope &amp; Rules</a></li>
</ol>

:string

>> read.toml

[arturo:[package:[name:TOML Reader description:Yet another TOML Reader version:1.0.1 authors:[author A author B] license:MIT] config:[version:^0.9 pkg-manager:^0.2]]]
:dictionary

>> read.toml -- from ini file

[package:[name:TOML Reader description:Yet another TOML Reader version:1.0.1 authors:[author A author B] license:MIT] config:[version:^0.9 pkg-manager:^0.2]]
:dictionary

>> read.binary

48 65 6C 6C 6F 2C 20 57 6F 72 6C 64 21
:binary

>> read.file

temp/read-file/test.bin
:string
error raised as expected!

>> rename

file:  Hello, world! 

>> rename.directory

directory renamed [temp\rename-dir\renamed\file.txt] 

>> timestamp

all fields are filled: [created accessed modified]

>> zip & unzip - README

zipped as dest.zip
unzipped as README.md

>> zip & unzip - src/arturo.nim


>> zip & unzip - destination


>> volume

13B

>> write

Hello, world!

>> write.append

Hello, world!
Hello, world!
From Arturo's World!

>> write.directory

before: [] 
now: [temp\write-dir\directory temp\write-dir\folder] 

>> write.json

{
    "name": "Arturo",
    "version": "1.9.83",
    "build": "b/12",
    "platform": "amd/win10"
}

>> write.json.compact

{"name":"Arturo","version":"1.9.83","build":"b/12","platform":"amd/win10"}

>> write.binary

Hello, world!

>> exists?

file does not exist
file exists

>> exists?.directory

directory does not exist
directory exists

>> hidden?

false
false
false
false
false
true
Removed: temp/
