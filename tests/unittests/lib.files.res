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


>> read

Hello, world
This is a multiline File.
:) :string

>> read.lines

[ :block
        The Language :string
        ------------------------------ :string
         :string
        Arturo is an independently-developed, modern programming language, :string
        vaguely related to various other ones - including but not limited to: :string
        Logo, Rebol, Forth, Ruby, Haskell, D, Smalltalk, Tcl, and Lisp. :string
         :string
        The language has been designed :string
        following some very simple and straightforward principles: :string
         :string
        - Code is just a list of words, symbols and literal values :string
        - Words and symbols within a block are interpreted - when needed - :string
            according to the context :string
        - No reserved words or keywords - :string
            look for them as hard as you can; there are absolutely none :string
]

>> read.json

[ :dictionary
        name      :        Arturo :string
        version   :        0.9.83 :string
        build     :        b/12 :string
        platform  :        amd/win10 :string
]

>> read.csv

[ :block
        [ :block
                language :string
                 version :string
                 platform :string
        ]
        [ :block
                Arturo :string
                 0.9.83 :string
                 win10 :string
        ]
        [ :block
                Python :string
                 3.9 :string
                 gnu/linux :string
        ]
        [ :block
                Ruby :string
                 3.2.1 :string
                 macOS :string
        ]
]

>> read.csv.withHeaders

[ :block
        [ :dictionary
                language   :                Arturo :string
                 version   :                 0.9.83 :string
                 platform  :                 win10 :string
        ]
        [ :dictionary
                language   :                Python :string
                 version   :                 3.9 :string
                 platform  :                 gnu/linux :string
        ]
        [ :dictionary
                language   :                Ruby :string
                 version   :                 3.2.1 :string
                 platform  :                 macOS :string
        ]
]

>> read.html


>> read.xml


>> read.markdown


>> read.toml


>> read.toml -- from ini file


>> read.binary

[ :binary
        48 65 6C 6C 6F 2C 20 57 6F 72 6C 64 21 
]

>> read.file

temp/read-file/test.bin :string
error raised as expected!

>> rename

file:  Hello, world! 

>> rename.directory

directory renamed

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

passed!

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

passed!
Removed: temp/