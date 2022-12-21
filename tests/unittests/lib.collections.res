
>> append


>> append - :binary < :binary :binary

00 01 :binary 

>> append - :binary < :binary :integer

00 01 :binary 

>> append - :string < :string + :string

Arturo :string 
Arturo :string 
Language :string 
Language :string 

>> append - :string < :string + :char

Arturo :string 
Arturo :string 
Language :string 
Language :string 

>> append - :string < :char + :char

ab :string 
ab :string 
cd :string 
cd :string 

>> append - :string < :char + :string

art :string 
art :string 
lang :string 
lang :string 

>> append - [:string] < [:string] + :string

[A r t u r o] :block 
[A r t u r o] :block 
[L a n g u a g e] :block 
[L a n g u a g e] :block 
[A r t uro] :block 
[A r t uro] :block 
[L a n g uage] :block 
[L a n g uage] :block 

>> append - [:string] < [:string] + [:string]

[A r t u r o] :block 
[A r t u r o] :block 
[L a n g u a g e] :block 
[L a n g u a g e] :block 

>> append - [:integer] < [:integer] + [:integer]|:integer

[1 2 3 4 5 6] :block 
[1 2 3 4 5 6] :block 
[1 2 3 4 5 6 7] :block 
[1 2 3 4 5 6 7] :block 

>> chop

Art :string 
Art :string 
Art :string 
Art :string 
Art :string 
[1 2 3] :block 
[1 2 3] :block 
[1 2 3] :block 
[1 2 3] :block 
[1 2 3] :block 

>> combine

[[A B C]] :block 
[[[A B] [C D]]] :block 
[[A B] [A C] [B C]] :block 
[[A A A] [A A B] [A A C] [A B B] [A B C] [A C C] [B B B] [B B C] [B C C] [C C C]] :block 
[[A A] [A B] [A C] [B B] [B C] [C C]] :block 
1 :integer 
6 :integer 

>> contains?


>> contains? - with :string

true :logical 
true :logical 
true :logical 
false :logical 
true :logical 
false :logical 

>> contains? - with :block

true :logical 
false :logical 
true :logical 
false :logical 

>> contains? - with nested :block

false :logical 
true :logical 
false :logical 
false :logical 

>> contains? - with :range

true :logical 
false :logical 

>> contains? - with :dictionary

true :logical 
true :logical 
false :logical 
false :logical 
true :logical 
true :logical 
false :logical 
false :logical 

>> couple

[[one 1] [two 2] [three 3]] :block 
[[one 1] [two 2] [three 3]] :block 
[[1 one] [2 two] [3 three]] :block 

>> decouple

[[1 2 3] [one two three]] :block 

>> drop

turo :string 
turo :string 
[1 2 3 4 5] :block 
[1 2 3 4 5] :block 

>> empty

before empty
[Arturo C Python Ruby] :block 
[1 2 3 4 5 6 7 8 9 10] :block 
[north south east west] :block 
Arturo :string 
[name:John surname:Doe] :dictionary 
after empty
[] :block 
[] :block 
[] :block 
 :string 
[] :dictionary 

>> empty?

true :logical 
false :logical 
true :logical 
false :logical 
true :logical 
false :logical 

>> extend

[name:john surname:doe] :dictionary 
[name:john surname:doe age:35] :dictionary 
[name:jane surname:doe] :dictionary 
[name:jane surname:doe age:35] :dictionary 

>> first

A :char 
Art :string 
one :string 
[one two] :block 
1
5
0
1
1 2 3 4 5 6 
0
0 1 2 3 4 5 
0
0 1 2 3 4 5 

>> flatten

[1 2 3 4 5 6] :block 
[[1 2 3] [4 5 6]] :block 
[1 2 3 4 5 6] :block 
[1 2 3 4 5 6] :block 
[1 2 3 4 [5 6]] :block 
[4 5 6 1 2 3] :block 

>> get

FD E8 :binary 
E8 :binary 
null :null 
null :null 
null :null 
15 :integer 
January :string 
John :string 
John :string 
John :string 
Doe :string 
Doe :string 
Jane :string 
zero :string 
zero :string 
[first one two] :block 
J :char 
D :char 
1
5

>> in?


>> in? - with :string

true :logical 
true :logical 
true :logical 
false :logical 
true :logical 
false :logical 

>> in? - with :block

true :logical 
false :logical 
true :logical 
false :logical 

>> in? - with nested :block

false :logical 
true :logical 
false :logical 
false :logical 

>> in? - with :dictionary

true :logical 
true :logical 
false :logical 
false :logical 
true :logical 
true :logical 
false :logical 
false :logical 
true
false
true
false
true
false
true
false

>> index

1 :integer 
2 :integer 
null :null 
name :string 
surname :string 
0
1
4
5

>> insert

[name:John age:32] :dictionary 
[name:Joe, Again] :dictionary 
[zero 1 2 3 4] :block 
[1 2 [3 4 5] 6 7 8 9 10] :block 
[0 1 2 3 4] :block 
hello :string 
Arturo :string 

>> key?

true :logical 
true :logical 
false :logical 
false :logical 

>> keys

[name surname] :block 

>> last

o :char 
uro :string 
three :string 
[two three] :block 
10
0
40
10
5 6 7 8 9 10 
10
5 6 7 8 9 10 
10
5 6 7 8 9 10 

>> max

9 :integer 
5 :integer 
Manchester :string 
1 :integer 

>> min

1 :integer 
4 :integer 
Boston :string 
2 :integer 

>> one?


>> one? - with :integer

true :logical 
false :logical 

>> one? - with :floating

true :logical 
false :logical 

>> one? - with :string

true :logical 
false :logical 

>> one? - with :block

true :logical 
false :logical 

>> one? - with :dictionary

true :logical 
false :logical 

>> one? - with :null

false :logical 

>> one? - with :range

true
false

>> permutate

[[A B C] [A C B] [B A C] [B C A] [C A B] [C B A]] :block 
[[[1 2 3] [4 5 6]] [[4 5 6] [1 2 3]]] :block 
[[A B] [A C] [B A] [B C] [C A] [C B]] :block 
[[A A A] [A A B] [A A C] [A B A] [A B B] [A B C] [A C A] [A C B] [A C C] [B A A] [B A B] [B A C] [B B A] [B B B] [B B C] [B C A] [B C B] [B C C] [C A A] [C A B] [C A C] [C B A] [C B B] [C B C] [C C A] [C C B] [C C C]] :block 
[[A A] [A B] [A C] [B A] [B B] [B C] [C A] [C B] [C C]] :block 
6 :integer 
9 :integer 

>> prepend


>> prepend - :binary < :binary :binary

01 00 :binary 

>> prepend - :binary < :binary :integer

01 00 :binary 

>> prepend - :string < :string + :string

Arturo :string 
Arturo :string 

>> prepend - :string < :string + :char

Arturo :string 
Arturo :string 

>> prepend - :string < :char + :char

ab :string 
ab :string 

>> prepend - :string < :char + :string

art :string 
art :string 

>> prepend - [:string] < [:string] + :string

[A r t u r o] :block 
[A r t u r o] :block 
[Art u r o] :block 
[Art u r o] :block 

>> prepend - [:string] < [:string] + [:string]

[A r t u r o] :block 
[A r t u r o] :block 

>> prepend - [:integer] < [:integer] + [:integer]|:integer

[1 2 3 4 5 6] :block 
[0 1 2 3 4 5 6] :block 
[0 1 2 3] :block 

>> remove


>> remove - default

Art :string 
Art :string 
Lang :string 
Lang :string 
heo :string 
heo :string 
heo :string 
heo :string 
[1 2 3] :block 
[1 3] :block 
[1 2 3] :block 
[1 3] :block 
[1 2 3 4] :block 
[1 6 3 4 6] :block 
[1 [6 2] 5 3 [6 2] 4 5] :block 
[1 6 3 4 6] :block 
[1 [6 2] 5 3 [6 2] 4 5] :block 
[surname:Doe] :dictionary 
[surname:Doe] :dictionary 
[surname:Wick] :dictionary 

>> remove - .index


>> remove - .prefix

function.art :string 
function.art :string 

>> remove - .suffix

test_function :string 
test_function :string 

>> remove - .key

[name:John] :dictionary 

>> remove - .once


>> remove - .once :string

helo :string 
helo :string 

>> remove - .once :block

[1 2 3 4 5] :block 
[1 2 3 4 5] :block 
[1 5 3 4 5 6] :block 
[1 [6 2] 5 3 4 5] :block 
[[1 2] 3 4 1 2 [1 2] 3 4] :block 
[1 5 3 4 5 6] :block 
[1 [6 2] 5 3 [6 2] 4 5] :block 
[[1 2] 3 4 1 2 [1 2] 3 4] :block 

>> remove - .once :dictionary

[surname:Doe father:John] :dictionary 
[surname:Doe father:John] :dictionary 

>> remove - .instance

[1 2 1 2 3] :block 
[1 2 1 2 3] :block 

>> remove - .instance.once

[1 2 1 2 3 [1 2]] :block 
[1 2 1 2 3 [1 2]] :block 

>> repeat

hellohellohello :string 
ArturoArturoArturo :string 
[1 2 3 1 2 3 1 2 3] :block 
[[1 2 3] [1 2 3] [1 2 3]] :block 
[4 5 6 4 5 6 4 5 6] :block 

>> reverse

[5 4 3 2 1] :block 
[[7 8 9] [4 5 6] [1 2 3]] :block 
retsehcnaM :string 
[[7 8 9] [4 5 6] [1 2 3]] :block 
orutrA :string 

>> reverse - .exact

[5 4 3 2 1] :block 
[[7 8 9] [4 5 6] [1 2 3]] :block 
retsehcnaM :string 
[[7 8 9] [4 5 6] [1 2 3]] :block 
orutrA :string 

>> reverse - with :range

10..1 :range 
0..10 :range 

>> reverse - .exact with :range

10..1 :range 
0..10 :range 

>> rotate

[1 2 3 4 5] :block 
[1 2 3 4 5] :block 
Arturo :string 
[1 2 3 4 5] :block 
[1 2 3 4 5] :block 
Arturo :string 

>> sample

:string
true
:char
true

>> set

[name:Michael age:34] :dictionary 
[name:Jane age:34] :dictionary 
[name:Christian age:34] :dictionary 
[one 2 3 4] :block 

>> shuffle

6
true
4
true

>> size

Good morning! 13 
Konnichiwa! 11 
こんいちわ！ 6 
[one two three] 3 
[name:John surname:Doe] 2 
null 0 
11
11
21

>> slice

Art :string 
[C C++ Nim] :block 
[C C++ Nim] :block 
Art :string 

>> sort


>> sort - default

[1 2 3 4 5] :block 
[Arturo Python Ruby] :block 
[art:Arturo c:C coffee:CoffeeScript nim:Nim] :dictionary 
[1 2 3 4 5] :block 
[Arturo Python Ruby] :block 
[art:Arturo c:C coffee:CoffeeScript nim:Nim] :dictionary 

>> sort - .values

[id:012568 surname:Doe name:John city:Manchester age:45] :dictionary 
[id:012568 surname:Doe name:John city:Manchester age:45] :dictionary 

>> sort - .sensitive .as with :block and :dictionary

aberración abismo dos perversión tres uno Uno ábaco 
aberración abismo dos perversión tres uno Uno ábaco 
ábaco aberración abismo dos perversión tres uno Uno 
ábaco aberración abismo dos perversión tres uno Uno 
Uno aberración abismo dos perversión tres uno ábaco 
Uno aberración abismo dos perversión tres uno ábaco 
Uno ábaco aberración abismo dos perversión tres uno 
Uno ábaco aberración abismo dos perversión tres uno 
0 1 2 3 4 5 6 7 8 9 10 
0 1 2 3 4 5 6 7 8 9 10 
[k:0 j:1 i:2 h:3 g:4 f:5 e:6 d:7 c:8 b:9 a:10]
[k:0 j:1 i:2 h:3 g:4 f:5 e:6 d:7 c:8 b:9 a:10]

>> sort - .descending .sensitive .as with :block and :dictionary

ábaco uno Uno tres perversión dos abismo aberración 
ábaco uno Uno tres perversión dos abismo aberración 
uno Uno tres perversión dos abismo aberración ábaco 
uno Uno tres perversión dos abismo aberración ábaco 
ábaco uno tres perversión dos abismo aberración Uno 
ábaco uno tres perversión dos abismo aberración Uno 
uno tres perversión dos abismo aberración ábaco Uno 
uno tres perversión dos abismo aberración ábaco Uno 
10 9 8 7 6 5 4 3 2 1 0 
10 9 8 7 6 5 4 3 2 1 0 
[k:10 j:9 i:8 h:7 g:6 f:5 e:4 d:3 c:2 b:1 a:0]
[k:10 j:9 i:8 h:7 g:6 f:5 e:4 d:3 c:2 b:1 a:0]

>> sort - .by

[[name:John surname:Doe] [name:Jane surname:Doe] [name:Arnold surname:Schwarzenegger] [name:John surname:Wick]] :block 
[[name:Arnold surname:Schwarzenegger] [name:Jane surname:Doe] [name:John surname:Doe] [name:John surname:Wick]] :block 

>> sorted?

true
false
false
true
false
false
true
false
false
true
false
false

>> split

[A r t u r o] :block 
[[1 2 3] [4 5 6] [7 8]] :block 
[[1 2 3] [4 5 6] [7 8]] :block 
[1 2 3 4 5 6] :block 
[1 2 3 4 5 6] :block 

>> split - .path

[directory wofilerld] :block 
[usr bin] :block 
[directory wofilerld] :block 
[usr bin] :block 
[directory wofilerld] :block 
[usr bin] :block 
[usr bin] :block 
[usr bin] :block 
[usr bin] :block 

>> split - .words & .lines

[Hello World!] :block 
[Hello World!] :block 
[Hi my name is...] :block 
[Hi my name is...] :block 

>> split - .by

[directory file.ext] :block 
[id nickname name age] :block 

>> split - .at

[Hello , World] :block 
[Hello , World] :block 
[[Arnold Andreas Paul Ricard] [Linus Yanis Helena Eva Blanca]] :block 
[[Arnold Andreas Paul Ricard Linus] [Linus Yanis Helena Eva Blanca]] :block 

>> split - .every

[spl it  col lec tio n t o c omp one nts] :block 
[[Arnold Andreas Paul] [Ricard Linus Yanis] [Helena Eva Blanca]] :block 
[[Arnold Andreas Paul] [Ricard Linus Yanis] [Helena Eva Blanca]] :block 
[Man che ste r] 3 3 3 1 
[Artu ro] 4 2 
[Man che ste r] 3 3 3 1 
[Artu ro] 4 2 

>> squeeze

[1 2 3 4 2 3 4 5 6 7] :block 
[1 [4 2 3] 1 2 3 [4 2 3] 4 5 [6 7]] :block 
[1 [4 2 3] 1 2 3 [4 2 3] 4 5 [6 7]] :block 
helo world :string 
[4 2 1 3 6] :block 

>> take

some te :string 
some te :string 
[Arnold Andreas] :block 
[Arnold Andreas] :block 
[1 2 3] :block 
[1 2 3] :block 

>> tally

[h:1 e:1 l:3 o:2 W:1 r:1 d:1] :dictionary 
[1:5 2:5 4:3 3:2 5:3 6:3 7:1] :dictionary 

>> unique

[1 2 4 3] :block 
[1 2 4 3] :block 
true
true

>> values

[Arturo Ruby Python Nim] :block 
[John Doe 012568 Manchester 45] :block 
[1 2 3 4 5 6 7 8 9 10] :block 
[1 2 3 4 5 6 7 8 9 10] :block 
[1 2 3 4 5 6 7 8 9 10] :block 
[1 2 3 4 5 6 7 8 9 10] :block 

>> zero?


>> zero? - with :integer

true :logical 
false :logical 

>> zero? - with :floating

true :logical 
false :logical 

>> zero? - with :string

true :logical 
false :logical 

>> zero? - with :block

true :logical 
false :logical 

>> zero? - with :range


>> zero? - with :dictionary

true :logical 
false :logical 

>> zero? - with :null

true :logical 
false :logical 
false :logical 
false :logical 
false :logical 
true :logical 
