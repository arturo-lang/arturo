
>> append


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
[1 2 3] :block 
[1 2 3] :block 
[1 2 3] :block 
[1 2 3] :block 
Art :string 
[1 2 3] :block 

>> couple

[[one 1] [two 2] [three 3]] :block 
[[one 1] [two 2] [three 3]] :block 
[[1 one] [2 two] [3 three]] :block 

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
after empty
[] :block 
[] :block 
[] :block 

>> extend

[name:john surname:doe] :dictionary 
[name:john surname:doe age:35] :dictionary 

>> first

A :char 
Art :string 
one :string 
[one two] :block 

>> flatten

[1 2 3 4 5 6] :block 
[[1 2 3] [4 5 6]] :block 
[1 2 3 4 5 6] :block 
[1 2 3 4 5 6] :block 
[1 2 3 4 [5 6]] :block 

>> get

John :string 
John :string 
John :string 
Doe :string 
Doe :string 
Jane :string 
zero :string 
zero :string 
[first one two] :block 
15 :integer 
January :string 
J :char 
D :char 

>> index

1 :integer 
2 :integer 
null :null 
name :string 
surname :string 

>> insert

[zero 1 2 3 4] :block 
hello :string 
[name:Joe, Again] :dictionary 
[1 2 [3 4 5] 6 7 8 9 10] :block 

>> keys

[name surname] :block 

>> last

o :char 
uro :string 
three :string 
[two three] :block 

>> max

9 :integer 
Manchester :string 

>> min

1 :integer 
Boston :string 

>> permutate

[[A B C] [A C B] [B A C] [B C A] [C A B] [C B A]] :block 
[[[1 2 3] [4 5 6]] [[4 5 6] [1 2 3]]] :block 

>> remove


>> remove - default

Art :string 
Art :string 
Lang :string 
Lang :string 
[1 2 3] :block 
[1 3] :block 
[1 2 3] :block 
[1 3] :block 
[1 2 3 4] :block 
[1 6 3 4 6] :block 
[1 [6 2] 5 3 [6 2] 4 5] :block 
heo :string 

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

helo :string 
[1 2 3 4 5] :block 
helo :string 
[1 2 3 4 5] :block 
[1 6 3 4 5 6] :block 
[1 [6 2] 5 3 4 5] :block 
[[1 2] 3 4 1 2 [1 2] 3 4] :block 
hello :string 

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

>> reverse

[5 4 3 2 1] :block 
[[7 8 9] [4 5 6] [1 2 3]] :block 
retsehcnaM :string 
orutrA :string 

>> sample

:string
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

3
2
13
11
6

>> slice

Art :string 
[C C++ Nim] :block 

>> sort


>> sort - default

[1 2 3 4 5] :block 
[Arturo Python Ruby] :block 
[1 2 3 4 5] :block 
[Arturo Python Ruby] :block 

>> sort - .values

[id:012568 surname:Doe name:John city:Manchester age:45] :dictionary 

>> sort - .as

[ábaco aberración abismo dos Dos pero pértiga perversión tres Tres uno Uno] :block 

>> sort - .sensitive

[Arturo Python Ruby arturo python ruby] :block 
[Arturo Python Ruby arturo python ruby] :block 

>> sort - .descending

[5 4 3 2 1] :block 
[Ruby Python Arturo] :block 
[5 4 3 2 1] :block 
[Ruby Python Arturo] :block 

>> sort - .by

[[name:John surname:Doe] [name:Jane surname:Doe] [name:Arnold surname:Schwarzenegger] [name:John surname:Wick]] :block 
[[name:Arnold surname:Schwarzenegger] [name:Jane surname:Doe] [name:John surname:Doe] [name:John surname:Wick]] :block 

>> split

[A r t u r o] :block 
[[1 2 3] [4 5 6] [7 8]] :block 
[directory wofilerld] :block 
[ usr bin] :block 
[directory wofilerld] :block 
[ usr bin] :block 
[directory wofilerld] :block 
[ usr bin] :block 
[ usr bin] :block 
[Hello World!] :block 
[Hi my name is...] :block 
[directory file.ext] :block 
[Hello , World] :block 
[[Arnold Andreas Paul Ricard] [Linus Yanis Helena Eva Blanca]] :block 
[spl it  col lec tio n t o c omp one nts] :block 
[[Arnold Andreas Paul] [Ricard Linus Yanis] [Helena Eva Blanca]] :block 
[[Arnold Andreas Paul Ricard Linus] [Linus Yanis Helena Eva Blanca]] :block 

>> squeeze

[1 2 3 4 2 3 4 5 6 7] :block 
[1 [4 2 3] 1 2 3 [4 2 3] 4 5 [6 7]] :block 
helo world :string 
[4 2 1 3 6] :block 

>> take

some te :string 
[Arnold Andreas] :block 
[1 2 3] :block 

>> unique

[1 2 4 3] :block 
[1 2 4 3 5 6 7] :block 
true

>> values

[John Doe 012568 Manchester 45] :block 
