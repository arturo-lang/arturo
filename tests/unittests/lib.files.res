Created: temp/

>> copy

Hello, world!


>> copy.directory - with empty folders

temp/dest/folderA:
A
B
C

temp/dest/folderB:
A
B
C

temp/dest/folderC:
A
B
C


>> copy.directory - with mixed folders

temp/dest/file.txt

temp/dest/folderA:
A
B
C
file.txt

temp/dest/folderA/A:
file.txt

temp/dest/folderA/B:

temp/dest/folderA/C:

temp/dest/folderB:
A
B
C

temp/dest/folderB/A:

temp/dest/folderB/B:
file.txt

temp/dest/folderB/C:

temp/dest/folderC:
A
B
C

temp/dest/folderC/A:

temp/dest/folderC/B:

temp/dest/folderC/C:
file.txt


>> delete

Hello, world!

deleting...
cat: temp/file.txt: No such file or directory


>> delete.directory - with empty folders

temp/folderA:
A
B
C

temp/folderB:
A
B
C

temp/folderC:
A
B
C

Deleting...
now:  

>> delete.directory - with mixed folders

temp/file.txt

temp/folderA:
A
B
C
file.txt

temp/folderB:
A
B
C

temp/folderC:
A
B
C

Deleting...
temp/file.txt


>> move

Hello, world!

cat: temp/toMove/moved.txt: No such file or directory


>> move.directory - with empty folders

temp/dest/folderA:
A
B
C

temp/dest/folderB:
A
B
C

temp/dest/folderC:
A
B
C

ls: cannot access 'temp/toMove/**': No such file or directory


>> move.directory - with mixed folders

temp/dest/file.txt

temp/dest/folderA:
A
B
C
file.txt

temp/dest/folderA/A:
file.txt

temp/dest/folderA/B:

temp/dest/folderA/C:

temp/dest/folderB:
A
B
C

temp/dest/folderB/A:

temp/dest/folderB/B:
file.txt

temp/dest/folderB/C:

temp/dest/folderC:
A
B
C

temp/dest/folderC/A:

temp/dest/folderC/B:

temp/dest/folderC/C:
file.txt


>> permissions

[1;35m[[0;90m :dictionary[0m
        user    :        [1;35m[[0;90m :dictionary[0m
                read     :                [1;32mtrue[0;90m :logical[0m
                write    :                [1;32mtrue[0;90m :logical[0m
                execute  :                [1;32mtrue[0;90m :logical[0m
        [1;35m][0m
        group   :        [1;35m[[0;90m :dictionary[0m
                read     :                [1;32mtrue[0;90m :logical[0m
                write    :                [1;32mtrue[0;90m :logical[0m
                execute  :                [1;32mtrue[0;90m :logical[0m
        [1;35m][0m
        others  :        [1;35m[[0;90m :dictionary[0m
                read     :                [1;32mtrue[0;90m :logical[0m
                write    :                [1;32mtrue[0;90m :logical[0m
                execute  :                [1;32mtrue[0;90m :logical[0m
        [1;35m][0m
[1;35m][0m

>> read

[1;32mHello, world
This is a multiline File.
:)[0;90m :string[0m
Hello, world
This is a multiline File.
:)

>> read.lines

[1;35m[[0;90m :block[0m
        [1;32mThe Language[0;90m :string[0m
        [1;32m------------------------------[0;90m :string[0m
        [1;32m[0;90m :string[0m
        [1;32mArturo is an independently-developed, modern programming language,[0;90m :string[0m
        [1;32mvaguely related to various other ones - including but not limited to:[0;90m :string[0m
        [1;32mLogo, Rebol, Forth, Ruby, Haskell, D, Smalltalk, Tcl, and Lisp.[0;90m :string[0m
        [1;32m[0;90m :string[0m
        [1;32mThe language has been designed[0;90m :string[0m
        [1;32mfollowing some very simple and straightforward principles:[0;90m :string[0m
        [1;32m[0;90m :string[0m
        [1;32m- Code is just a list of words, symbols and literal values[0;90m :string[0m
        [1;32m- Words and symbols within a block are interpreted - when needed -[0;90m :string[0m
        [1;32m    according to the context[0;90m :string[0m
        [1;32m- No reserved words or keywords -[0;90m :string[0m
        [1;32m    look for them as hard as you can; there are absolutely none[0;90m :string[0m
[1;35m][0m

>> read.json

[1;35m[[0;90m :dictionary[0m
        name      :        [1;32mArturo[0;90m :string[0m
        version   :        [1;32m0.9.83[0;90m :string[0m
        build     :        [1;32mb/12[0;90m :string[0m
        platform  :        [1;32mamd/win10[0;90m :string[0m
[1;35m][0m

>> read.csv

[1;35m[[0;90m :block[0m
        [1;35m[[0;90m :block[0m
                [1;32mlanguage; version; platform[0;90m :string[0m
        [1;35m][0m
        [1;35m[[0;90m :block[0m
                [1;32mArturo; 0.9.83; win10[0;90m :string[0m
        [1;35m][0m
        [1;35m[[0;90m :block[0m
                [1;32mPython; 3.9; gnu/linux[0;90m :string[0m
        [1;35m][0m
        [1;35m[[0;90m :block[0m
                [1;32mRuby; 3.2.1; macOS[0;90m :string[0m
        [1;35m][0m
[1;35m][0m

>> read.csv.withHeaders

[1;35m[[0;90m :block[0m
        [1;35m[[0;90m :dictionary[0m
                language; version; platform  :                [1;32mArturo; 0.9.83; win10[0;90m :string[0m
        [1;35m][0m
        [1;35m[[0;90m :dictionary[0m
                language; version; platform  :                [1;32mPython; 3.9; gnu/linux[0;90m :string[0m
        [1;35m][0m
        [1;35m[[0;90m :dictionary[0m
                language; version; platform  :                [1;32mRuby; 3.2.1; macOS[0;90m :string[0m
        [1;35m][0m
[1;35m][0m

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

>> read.xml

[1;35m[[0;90m :block[0m
        [1;35m[[0;90m :dictionary[0m
                name      :                [1;32mArturo Programming Language[0;90m :string[0m
                author    :                [1;32mYanis Zafiropulos[0;90m :string[0m
                category  :                [1;32mScripting and Concatenative[0;90m :string[0m
                _tag      :                [1;32mlanguage[0;90m :string[0m
                id        :                [1;32mart[0;90m :string[0m
        [1;35m][0m
        [1;35m[[0;90m :dictionary[0m
                name      :                [1;32mCPython[0;90m :string[0m
                author    :                [1;32mGuido van Rossum[0;90m :string[0m
                category  :                [1;32mScripting and Object Oriented[0;90m :string[0m
                _tag      :                [1;32mlanguage[0;90m :string[0m
                id        :                [1;32mpy[0;90m :string[0m
        [1;35m][0m
        [1;35m[[0;90m :dictionary[0m
                name      :                [1;32mRuby[0;90m :string[0m
                author    :                [1;32mYukihiro Matsumoto[0;90m :string[0m
                category  :                [1;32mScripting and Object Oriented[0;90m :string[0m
                _tag      :                [1;32mlanguage[0;90m :string[0m
                id        :                [1;32mrb[0;90m :string[0m
        [1;35m][0m
[1;35m][0m

>> read.markdown

[1;32m<h1>Arturo Basics</h1>
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
[0;90m :string[0m

>> read.toml

[1;35m[[0;90m :dictionary[0m
        arturo  :        [1;35m[[0;90m :dictionary[0m
                package  :                [1;35m[[0;90m :dictionary[0m
                        name         :                        [1;32mTOML Reader[0;90m :string[0m
                        description  :                        [1;32mYet another TOML Reader[0;90m :string[0m
                        version      :                        [1;32m1.0.1[0;90m :string[0m
                        authors      :                        [1;35m[[0;90m :block[0m
                                [1;32mauthor A[0;90m :string[0m
                                [1;32mauthor B[0;90m :string[0m
                        [1;35m][0m
                        license      :                        [1;32mMIT[0;90m :string[0m
                [1;35m][0m
                config   :                [1;35m[[0;90m :dictionary[0m
                        version      :                        [1;32m^0.9[0;90m :string[0m
                        pkg-manager  :                        [1;32m^0.2[0;90m :string[0m
                [1;35m][0m
        [1;35m][0m
[1;35m][0m

>> read.toml -- from ini file

[1;35m[[0;90m :dictionary[0m
        package  :        [1;35m[[0;90m :dictionary[0m
                name         :                [1;32mTOML Reader[0;90m :string[0m
                description  :                [1;32mYet another TOML Reader[0;90m :string[0m
                version      :                [1;32m1.0.1[0;90m :string[0m
                authors      :                [1;35m[[0;90m :block[0m
                        [1;32mauthor A[0;90m :string[0m
                        [1;32mauthor B[0;90m :string[0m
                [1;35m][0m
                license      :                [1;32mMIT[0;90m :string[0m
        [1;35m][0m
        config   :        [1;35m[[0;90m :dictionary[0m
                version      :                [1;32m^0.9[0;90m :string[0m
                pkg-manager  :                [1;32m^0.2[0;90m :string[0m
        [1;35m][0m
[1;35m][0m

>> read.binary

[1;35m[[0;90m :binary[0m
        [0m[0;90m48 [0m[0m[0;90m65 [0m[0m[0;90m6C [0m[0m[0;90m6C [0m[0m[0;90m6F [0m[0m[0;90m2C [0m[0m[0;90m20 [0m[0m[0;90m57 [0m[0m[0;90m6F [0m[0m[0;90m72 [0m[0m[0;90m6C [0m[0m[0;90m64 [0m[0m[0;90m21 [0m
[1;35m][0m

>> read.file

[1;32mtemp/test.bin[0;90m :string[0m
error raised!

>> rename

Hello, world!


>> rename.directory

folder

directory


>> timestamp

assertions passed

>> zip & unzip


---
temp/dest.zip

---
temp/dest.zip

temp/README.md:
README.md


>> volume

13B

>> write

Hello, world!


>> write.append

Hello, world!
From Arturo's World!


>> write.directory

directory
folder


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
