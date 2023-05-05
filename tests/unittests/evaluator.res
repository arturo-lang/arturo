**************************************************
*
* SIMPLE VALUES
*
**************************************************

        >--------------------------------------------------
        > Boolean
        >--------------------------------------------------

        input: [true] 
        data: [] 
        code: [21 218] (2 bytes) 

        input: [false] 
        data: [] 
        code: [22 218] (2 bytes) 

        input: [maybe] 
        data: [maybe] 
        code: [64 218] (2 bytes) 


        >--------------------------------------------------
        > Integer
        >--------------------------------------------------

        input: [1] 
        data: [] 
        code: [2 218] (2 bytes) 

        input: [10] 
        data: [] 
        code: [11 218] (2 bytes) 

        input: [123] 
        data: [123] 
        code: [32 218] (2 bytes) 

        input: [1234567890123] 
        data: [1234567890123] 
        code: [32 218] (2 bytes) 


        >--------------------------------------------------
        > Floating
        >--------------------------------------------------

        input: [0.0] 
        data: [] 
        code: [18 218] (2 bytes) 

        input: [1.0] 
        data: [] 
        code: [19 218] (2 bytes) 

        input: [10.0] 
        data: [10.0] 
        code: [32 218] (2 bytes) 

        input: [12345.1234567] 
        data: [12345.1234567] 
        code: [32 218] (2 bytes) 


        >--------------------------------------------------
        > Char
        >--------------------------------------------------

        input: ['a'] 
        data: [a] 
        code: [32 218] (2 bytes) 

        input: ['😀'] 
        data: [😀] 
        code: [32 218] (2 bytes) 


        >--------------------------------------------------
        > String
        >--------------------------------------------------

        input: [""] 
        data: [] 
        code: [24 218] (2 bytes) 

        input: ["Hello World!"] 
        data: [Hello World!] 
        code: [32 218] (2 bytes) 


        >--------------------------------------------------
        > Regex
        >--------------------------------------------------

        input: [{/hello/}] 
        data: [hello] 
        code: [32 218] (2 bytes) 

        input: [{/[A-Z]+\d/}] 
        data: [[A-Z]+\d] 
        code: [32 218] (2 bytes) 


        >--------------------------------------------------
        > Type
        >--------------------------------------------------

        input: [:integer] 
        data: [:integer] 
        code: [32 218] (2 bytes) 

        input: [:string] 
        data: [:string] 
        code: [32 218] (2 bytes) 


        >--------------------------------------------------
        > Literal
        >--------------------------------------------------

        input: ['a] 
        data: [a] 
        code: [32 218] (2 bytes) 

        input: ['a 'b 'c] 
        data: [a b c] 
        code: [32 33 34 218] (4 bytes) 


        >--------------------------------------------------
        > SymbolLiteral
        >--------------------------------------------------

        input: ['+] 
        data: [+] 
        code: [32 218] (2 bytes) 

        input: ['-->] 
        data: [-->] 
        code: [32 218] (2 bytes) 


        >--------------------------------------------------
        > Color
        >--------------------------------------------------

        input: [#FF0000] 
        data: [#FF0000] 
        code: [32 218] (2 bytes) 

        input: [#00FF66] 
        data: [#00FF66] 
        code: [32 218] (2 bytes) 


        >--------------------------------------------------
        > Quantity
        >--------------------------------------------------

        input: [1:1`€] 
        data: [1.00 €] 
        code: [32 218] (2 bytes) 

        input: [12:1`m] 
        data: [12 m] 
        code: [32 218] (2 bytes) 


        >--------------------------------------------------
        > Version
        >--------------------------------------------------

        input: [0.9.82] 
        data: [0.9.82] 
        code: [32 218] (2 bytes) 

        input: [2.0.0-rc1] 
        data: [2.0.0-rc1] 
        code: [32 218] (2 bytes) 


        >--------------------------------------------------
        > Block
        >--------------------------------------------------

        input: [[]] 
        data: [] 
        code: [25 218] (2 bytes) 

        input: [[1 "hello" 3.14 true]] 
        data: [[1 hello 3.14 true]] 
        code: [32 218] (2 bytes) 


        >--------------------------------------------------
        > Null
        >--------------------------------------------------

        input: [∅] 
        data: [] 
        code: [27 218] (2 bytes) 

        input: [null] 
        data: [null] 
        code: [64 218] (2 bytes) 


**************************************************
*
* LABELS
*
**************************************************

        >--------------------------------------------------
        > Setting and getting variables
        >--------------------------------------------------

        input: [a: 1] 
        data: [a] 
        code: [2 48 218] (3 bytes) 

        input: [b: 2 c: b] 
        data: [b c] 
        code: [3 48 64 49 218] (5 bytes) 


**************************************************
*
* FUNCTION CALLS
*
**************************************************

        >--------------------------------------------------
        > Built-in function calls
        >--------------------------------------------------

        input: [abs 10] 
        data: [abs] 
        code: [11 96 218] (3 bytes) 

        input: [empty? []] 
        data: [empty?] 
        code: [25 96 218] (3 bytes) 

        input: [couple [1 2] ["one" "two"]] 
        data: [[one two] [1 2] couple] 
        code: [32 33 98 218] (4 bytes) 


        >--------------------------------------------------
        > Opcoded built-in function calls
        >--------------------------------------------------

        input: [print 2] 
        data: [] 
        code: [3 189 218] (3 bytes) 

        input: [size [1 2]] 
        data: [[1 2]] 
        code: [32 183 218] (3 bytes) 

        input: [and 1 123] 
        data: [123] 
        code: [32 2 139 218] (4 bytes) 


        >--------------------------------------------------
        > Composite opcoded built-in function calls
        >--------------------------------------------------

        input: [to :floating 1] 
        data: [:floating] 
        code: [2 32 170 218] (4 bytes) 

        input: [to :integer "10"] 
        data: [10] 
        code: [32 172 218] (3 bytes) 

        input: [to :string 5] 
        data: [] 
        code: [6 171 218] (3 bytes) 


        >--------------------------------------------------
        > Function calls with attributes
        >--------------------------------------------------

        input: [split .words "hello world"] 
        data: [hello world words] 
        code: [32 21 113 185 218] (5 bytes) 

        input: [split .by: "X" "helloXworld"] 
        data: [helloXworld X by] 
        code: [32 33 114 185 218] (5 bytes) 

        input: [join .with: "-" ["hello" "world"]] 
        data: [[hello world] - with] 
        code: [32 33 114 186 218] (5 bytes) 


        >--------------------------------------------------
        > Function calls via symbol aliases
        >--------------------------------------------------

        input: [@ [1 2 3]] 
        data: [[1 2 3]] 
        code: [32 176 218] (3 bytes) 

        input: ["hello " ++ x] 
        data: [x hello ] 
        code: [64 33 188 218] (4 bytes) 

        input: [1 .. 25] 
        data: [25] 
        code: [32 2 179 218] (4 bytes) 


        >--------------------------------------------------
        > User function definition & calling
        >--------------------------------------------------

        input: [h: function [] [print "function called"] print "before" h print "after"] 
        data: [[print function called] h before after] 
        code: [32 25 178 49 34 189 97 35 189 218] (10 bytes) 

        input: [f: function [x] [x + 1] print "before" print f 10 print "after"] 
        data: [[x + 1] [x] f before after] 
        code: [32 33 178 50 35 189 11 98 189 36 189 218] (12 bytes) 

        input: [g: $ [z w] [2 * z * w] print "before" print g 10 20 print "after"] 
        data: [[2 * z * w] [z w] g before 20 after] 
        code: [32 33 178 50 35 189 36 11 98 189 37 189 218] (13 bytes) 


**************************************************
*
* PATHS
*
**************************************************

        >--------------------------------------------------
        > Path values
        >--------------------------------------------------

        input: [a\0] 
        data: [a] 
        code: [1 64 153 218] (4 bytes) 

        input: [user\name] 
        data: [name user] 
        code: [32 65 153 218] (4 bytes) 

        input: [user\grades\0] 
        data: [grades user] 
        code: [1 32 65 153 153 218] (6 bytes) 

        input: [user\address\country] 
        data: [country address user] 
        code: [32 33 66 153 153 218] (6 bytes) 


        >--------------------------------------------------
        > PathLabel values
        >--------------------------------------------------

        input: [a\0: 10] 
        data: [a] 
        code: [11 1 64 154 218] (5 bytes) 

        input: [user\name: "John"] 
        data: [John name user] 
        code: [32 33 66 154 218] (5 bytes) 

        input: [user\grades\0: 6] 
        data: [grades user] 
        code: [7 1 32 65 153 154 218] (7 bytes) 

        input: [user\address\country: "USA"] 
        data: [USA country address user] 
        code: [32 33 34 67 153 154 218] (7 bytes) 


**************************************************
*
* BLOCKS & SYNTACTIC SUGAR
*
**************************************************

        >--------------------------------------------------
        > Inline blocks
        >--------------------------------------------------

        input: [(print 2)] 
        data: [] 
        code: [3 189 218] (3 bytes) 

        input: [(print 2) (print 3)] 
        data: [] 
        code: [3 189 4 189 218] (5 bytes) 

        input: [(print 2 print 3)] 
        data: [] 
        code: [3 189 4 189 218] (5 bytes) 


        >--------------------------------------------------
        > doublecolon syntactic sugar (`::`)
        >--------------------------------------------------

        input: [print 2 do :: print 3] 
        data: [[print 3] do] 
        code: [3 189 32 97 218] (5 bytes) 


        >--------------------------------------------------
        > arrowright syntactic sugar (`->`)
        >--------------------------------------------------

        input: [-> "hello"] 
        data: [[hello]] 
        code: [32 218] (2 bytes) 

        input: [do -> print "hello" print "done"] 
        data: [[print hello] do done] 
        code: [32 97 34 189 218] (5 bytes) 

        input: [-> 1 -> 2] 
        data: [[1] [2]] 
        code: [32 33 218] (3 bytes) 

        input: [a: -> upper "hello" b: -> "hello " ++ world] 
        data: [[upper hello] a [hello  ++ world] b] 
        code: [32 49 34 51 218] (5 bytes) 


        >--------------------------------------------------
        > thickarrowright syntactic sugar (`=>`)
        >--------------------------------------------------

        input: [=> "hello"] 
        data: [[hello]] 
        code: [25 32 218] (3 bytes) 

        input: [f: function => print] 
        data: [[print _0] _0 f] 
        code: [32 33 178 50 218] (5 bytes) 

        input: [adder: $ => add] 
        data: [[add _0 _1] [_0 _1] adder] 
        code: [32 33 178 50 218] (5 bytes) 

        input: [subOne: function => [& - 1]] 
        data: [[_0 - 1] _0 subOne] 
        code: [32 33 178 50 218] (5 bytes) 

        input: [mulAddOne: $ => [1 + & * &]] 
        data: [[1 + _0 * _1] [_0 _1] mulAddOne] 
        code: [32 33 178 50 218] (5 bytes) 


        >--------------------------------------------------
        > pipe operator (`|`)
        >--------------------------------------------------

        input: [2 | print] 
        data: [] 
        code: [3 189 218] (3 bytes) 

        input: ["hello" | upper | print] 
        data: [hello upper] 
        code: [32 97 189 218] (4 bytes) 

        input: [x: "hello" | upper] 
        data: [hello upper x] 
        code: [32 97 50 218] (4 bytes) 

        input: [1 .. 10 | map 'x -> 2 * x] 
        data: [[2 * x] x] 
        code: [32 33 11 2 179 181 218] (7 bytes) 

        input: [1 .. 10 | map 'x -> 2 * x | sum] 
        data: [[2 * x] x sum] 
        code: [32 33 11 2 179 181 98 218] (8 bytes) 

        input: [1 .. 10 | map 'x -> 2 * x | sum | print] 
        data: [[2 * x] x sum] 
        code: [32 33 11 2 179 181 98 189 218] (9 bytes) 

        input: [1 .. 10 | map 'x -> 2 * x | sum | print] 
        data: [[2 * x] x sum] 
        code: [32 33 11 2 179 181 98 189 218] (9 bytes) 

        input: [filtered: 1 .. a | map 'x -> 3 * x | select 'x -> odd? x print filtered] 
        data: [[odd? x] x [3 * x] a filtered] 
        code: [32 33 34 33 67 2 179 181 182 84 189 218] (12 bytes) 

        input: [filtered: 1 .. a | map 'x -> 3 * x | select => odd? print filtered] 
        data: [[odd? _0] _0 [3 * x] x a filtered] 
        code: [32 33 34 35 68 2 179 181 182 85 189 218] (12 bytes) 


**************************************************
*
* OPTIMIZATIONS
*
**************************************************

        >--------------------------------------------------
        > add (`+`) / constant folding
        >--------------------------------------------------

        input: [add 2 3] 
        data: [] 
        code: [6 218] (2 bytes) 

        input: [2 + 3] 
        data: [] 
        code: [6 218] (2 bytes) 

        input: [2 + 3 + 4 + 5] 
        data: [] 
        code: [15 218] (2 bytes) 

        input: [1 + 2 + 3 + 4 + 5 + 6] 
        data: [21] 
        code: [32 218] (2 bytes) 

        input: [x: 3 + 7] 
        data: [x] 
        code: [11 48 218] (3 bytes) 


        >--------------------------------------------------
        > add (`+`) / -> inc
        >--------------------------------------------------

        input: [x + 1] 
        data: [x] 
        code: [64 136 218] (3 bytes) 

        input: [1 + y] 
        data: [y] 
        code: [64 136 218] (3 bytes) 


        >--------------------------------------------------
        > add (`+`) / distributive
        >--------------------------------------------------

        input: [X + X * Y] 
        data: [Y X] 
        code: [64 2 128 65 130 218] (6 bytes) 

        input: [(X * Y) + X] 
        data: [X Y] 
        code: [64 65 2 128 130 218] (6 bytes) 


        >--------------------------------------------------
        > sub (`-`) / constant folding
        >--------------------------------------------------

        input: [sub 2 3] 
        data: [] 
        code: [0 218] (2 bytes) 

        input: [2 - 3] 
        data: [] 
        code: [0 218] (2 bytes) 

        input: [8 - 2 - 1] 
        data: [] 
        code: [8 218] (2 bytes) 

        input: [30 - 10 - 1] 
        data: [21] 
        code: [32 218] (2 bytes) 


        >--------------------------------------------------
        > sub (`-`) / -> dec
        >--------------------------------------------------

        input: [x - 1] 
        data: [x] 
        code: [64 137 218] (3 bytes) 


        >--------------------------------------------------
        > mul (`*`) / constant folding
        >--------------------------------------------------

        input: [mul 2 3] 
        data: [] 
        code: [7 218] (2 bytes) 

        input: [2 * 3] 
        data: [] 
        code: [7 218] (2 bytes) 

        input: [2 * 2 * 3] 
        data: [] 
        code: [13 218] (2 bytes) 

        input: [2 * 3 * 4 * 5] 
        data: [120] 
        code: [32 218] (2 bytes) 


        >--------------------------------------------------
        > div (`/`) / constant folding
        >--------------------------------------------------

        input: [div 6 3] 
        data: [] 
        code: [3 218] (2 bytes) 

        input: [6 / 3] 
        data: [] 
        code: [3 218] (2 bytes) 

        input: [6 / 6 / 3] 
        data: [] 
        code: [4 218] (2 bytes) 

        input: [50 / 4 / 4 / 2] 
        data: [25] 
        code: [32 218] (2 bytes) 


        >--------------------------------------------------
        > fdiv (`//`) / constant folding
        >--------------------------------------------------

        input: [fdiv 6 3] 
        data: [] 
        code: [20 218] (2 bytes) 

        input: [6 // 3] 
        data: [] 
        code: [20 218] (2 bytes) 

        input: [4 // 8 // 2] 
        data: [] 
        code: [19 218] (2 bytes) 

        input: [55 // 4 // 4 // 2] 
        data: [27.5] 
        code: [32 218] (2 bytes) 


        >--------------------------------------------------
        > mod (`%`) / constant folding
        >--------------------------------------------------

        input: [mod 6 3] 
        data: [] 
        code: [1 218] (2 bytes) 

        input: [6 % 3] 
        data: [] 
        code: [1 218] (2 bytes) 

        input: [20 % 15 % 6] 
        data: [] 
        code: [3 218] (2 bytes) 


        >--------------------------------------------------
        > pow (`^`) / constant folding
        >--------------------------------------------------

        input: [pow 3 2] 
        data: [] 
        code: [10 218] (2 bytes) 

        input: [3 ^ 2] 
        data: [] 
        code: [10 218] (2 bytes) 

        input: [2 ^ 2 ^ 2] 
        data: [16] 
        code: [32 218] (2 bytes) 


        >--------------------------------------------------
        > if
        >--------------------------------------------------

        input: [print "before" if x [print "here" return true] print "after"] 
        data: [before x here after] 
        code: [32 189 65 199 4 34 189 21 167 35 189 218] (12 bytes) 

        input: [print "before" if not? x [print "here" return false] print "after"] 
        data: [before x here after] 
        code: [32 189 65 197 4 34 189 22 167 35 189 218] (12 bytes) 

        input: [print "before" if x = 2 [print "here" return true] print "after"] 
        data: [before x here after] 
        code: [32 189 3 65 203 4 34 189 21 167 35 189 218] (13 bytes) 

        input: [print "before" if x > 2 [print "here" return true] print "after"] 
        data: [before x here after] 
        code: [32 189 3 65 211 4 34 189 21 167 35 189 218] (13 bytes) 

        input: [print "before" if x =< 2 [print "here" return true] print "after"] 
        data: [before x here after] 
        code: [32 189 3 65 205 4 34 189 21 167 35 189 218] (13 bytes) 


        >--------------------------------------------------
        > unless
        >--------------------------------------------------

        input: [print "before" unless x [print "here" return false] print "after"] 
        data: [before x here after] 
        code: [32 189 65 197 4 34 189 22 167 35 189 218] (12 bytes) 

        input: [print "before" unless not? x [print "here" return true] print "after"] 
        data: [before x here after] 
        code: [32 189 65 199 4 34 189 21 167 35 189 218] (12 bytes) 

        input: [print "before" unless x = 2 [print "here" return false] print "after"] 
        data: [before x here after] 
        code: [32 189 3 65 201 4 34 189 22 167 35 189 218] (13 bytes) 

        input: [print "before" unless x > 2 [print "here" return false] print "after"] 
        data: [before x here after] 
        code: [32 189 3 65 205 4 34 189 22 167 35 189 218] (13 bytes) 

        input: [print "before" unless x =< 2 [print "here" return false] print "after"] 
        data: [before x here after] 
        code: [32 189 3 65 211 4 34 189 22 167 35 189 218] (13 bytes) 


        >--------------------------------------------------
        > if?-else
        >--------------------------------------------------

        input: [if? x [return true] else [return false]] 
        data: [x] 
        code: [64 199 4 21 167 213 2 22 167 218] (10 bytes) 

        input: [print "before" if? a <> 1 + 2 [print "here" return true] else [print "there" return false] print "after"] 
        data: [before a here there after] 
        code: [32 189 4 65 201 6 34 189 21 167 213 4 35 189 22 167 36 189 218] (19 bytes) 


        >--------------------------------------------------
        > switch (`?`)
        >--------------------------------------------------

        input: [print "before" switch a [1] [2] print "after"] 
        data: [before a after] 
        code: [32 189 65 199 3 2 213 1 3 34 189 218] (12 bytes) 

        input: [(x = 1) ? -> 1 -> 2] 
        data: [x] 
        code: [2 64 203 3 2 213 1 3 218] (9 bytes) 

        input: [print "before" return (x < 1) ? -> true -> false print "after"] 
        data: [before [false] [true] x after] 
        code: [32 189 33 34 2 67 151 165 167 36 189 218] (12 bytes) 

        input: [print "before" z: (x < 1) ? -> true -> false print "after"] 
        data: [before [false] [true] x z after] 
        code: [32 189 33 34 2 67 151 165 52 37 189 218] (12 bytes) 

        input: [print "before" z: 3 + (x >= 1) ? -> 1 -> 2 print "after"] 
        data: [before [2] [1] x z after] 
        code: [32 189 33 34 2 67 150 165 4 128 52 37 189 218] (14 bytes) 


        >--------------------------------------------------
        > while
        >--------------------------------------------------

        input: [while [x = 1] [print "hello"]] 
        data: [x hello] 
        code: [2 64 203 4 33 189 215 6 218] (9 bytes) 

        input: [while ∅ [print "hello"]] 
        data: [[print hello]] 
        code: [32 27 166 218] (4 bytes)