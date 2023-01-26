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

        input: [`a`] 
        data: [a] 
        code: [32 218] (2 bytes) 

        input: [`😀`] 
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

        input: [1:eur] 
        data: [1EUR] 
        code: [32 218] (2 bytes) 

        input: [12:m] 
        data: [12m] 
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
        code: [6 172 218] (3 bytes) 


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
        data: [user name] 
        code: [33 65 153 218] (4 bytes) 

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


        >--------------------------------------------------
        > pipe operator (`|`)
        >--------------------------------------------------

        input: [2 | print] 
        data: [] 
        code: [3 189 218] (3 bytes) 

        input: ["hello" | upper | print] 
        data: [hello upper] 
        code: [32 97 189 218] (4 bytes) 


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
        > sub (`-`)
        >--------------------------------------------------

        input: [sub 3 2] 
        data: [] 
        code: [2 3 129 218] (4 bytes) 

        input: [3 - 2] 
        data: [] 
        code: [2 3 129 218] (4 bytes) 

        input: [sub 2 1] 
        data: [] 
        code: [2 175 218] (3 bytes) 

        input: [2 - 1] 
        data: [] 
        code: [2 175 218] (3 bytes) 


        >--------------------------------------------------
        > if
        >--------------------------------------------------

        input: [print "before" if x [print "here" return true] print "after"] 
        data: [before x [print here return true] here after] 
        code: [32 176 65 198 0 4 35 176 21 156 36 176 218] (13 bytes) 

        input: [print "before" if not? x [print "here" return false] print "after"] 
        data: [before x [print here return false] here after] 
        code: [32 176 65 197 0 4 35 176 22 156 36 176 218] (13 bytes) 

        input: [print "before" if x = 2 [print "here" return true] print "after"] 
        data: [before x [print here return true] here after] 
        code: [32 176 2 65 200 0 4 35 176 21 156 36 176 218] (14 bytes) 

        input: [print "before" if x > 2 [print "here" return true] print "after"] 
        data: [before x [print here return true] here after] 
        code: [32 176 2 65 204 0 4 35 176 21 156 36 176 218] (14 bytes) 

        input: [print "before" if x =< 2 [print "here" return true] print "after"] 
        data: [before x [print here return true] here after] 
        code: [32 176 2 65 201 0 4 35 176 21 156 36 176 218] (14 bytes) 


        >--------------------------------------------------
        > unless
        >--------------------------------------------------

        input: [print "before" unless x [print "here" return false] print "after"] 
        data: [before x [print here return false] here after] 
        code: [32 176 65 197 0 4 35 176 22 156 36 176 218] (13 bytes) 

        input: [print "before" unless not? x [print "here" return true] print "after"] 
        data: [before x [print here return true] here after] 
        code: [32 176 65 198 0 4 35 176 21 156 36 176 218] (13 bytes) 

        input: [print "before" unless x = 2 [print "here" return false] print "after"] 
        data: [before x [print here return false] here after] 
        code: [32 176 2 65 199 0 4 35 176 22 156 36 176 218] (14 bytes) 

        input: [print "before" unless x > 2 [print "here" return false] print "after"] 
        data: [before x [print here return false] here after] 
        code: [32 176 2 65 201 0 4 35 176 22 156 36 176 218] (14 bytes) 

        input: [print "before" unless x =< 2 [print "here" return false] print "after"] 
        data: [before x [print here return false] here after] 
        code: [32 176 2 65 204 0 4 35 176 22 156 36 176 218] (14 bytes) 


        >--------------------------------------------------
        > if-else
        >--------------------------------------------------

        input: [if? x [return true] else [return false]] 
        data: [x [return true] [return false]] 
        code: [64 198 0 5 21 156 208 0 2 22 156 218] (12 bytes) 

        input: [print "before" if? a <> 1 + 2 [print "here" return true] else [print "there" return false] print "after"] 
        data: [before a [print here return true] here [print there return false] there after] 
        code: [32 176 2 1 128 65 199 0 7 35 176 21 156 208 0 4 37 176 22 156 38 176 218] (23 bytes) 


        >--------------------------------------------------
        > switch (`?`)
        >--------------------------------------------------

        input: [print "before" switch a [1] [2] print "after"] 
        data: [before a [1] [2] after] 
        code: [32 176 65 198 0 4 1 208 0 1 2 36 176 218] (14 bytes) 

        input: [(x = 1) ? -> 1 -> 2] 
        data: [x [1] [2]] 
        code: [1 64 200 0 4 1 208 0 1 2 218] (11 bytes) 

        input: [print "before" return (x < 1) ? -> true -> false print "after"] 
        data: [before x [true] [false] after] 
        code: [32 176 1 65 202 0 4 21 208 0 1 22 156 36 176 218] (16 bytes) 

        input: [print "before" z: (x < 1) ? -> true -> false print "after"] 
        data: [before z x [true] [false] after] 
        code: [32 176 1 66 202 0 4 21 208 0 1 22 49 37 176 218] (16 bytes) 

        input: [print "before" z: 3 + (x >= 1) ? -> 1 -> 2 print "after"] 
        data: [before z x [1] [2] after] 
        code: [32 176 1 66 203 0 4 1 208 0 1 2 3 128 49 37 176 218] (18 bytes) 


        >--------------------------------------------------
        > while
        >--------------------------------------------------

        input: [while [x = 1] [print "hello"]] 
        data: [[x = 1] [print hello] x hello] 
        code: [1 66 200 0 5 35 176 209 0 10 218] (11 bytes)