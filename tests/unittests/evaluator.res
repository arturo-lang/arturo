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
        code: [1 32 157 218] (4 bytes) 

        input: [to :integer "10"] 
        data: [10] 
        code: [32 159 218] (3 bytes) 

        input: [to :string 5] 
        data: [] 
        code: [5 158 218] (3 bytes) 


        >--------------------------------------------------
        > Function calls with attributes
        >--------------------------------------------------

        input: [split .words "hello world"] 
        data: [words hello world] 
        code: [33 21 112 171 218] (5 bytes) 

        input: [split .by: "X" "helloXworld"] 
        data: [by X helloXworld] 
        code: [34 33 112 171 218] (5 bytes) 

        input: [join .with: "-" ["hello" "world"]] 
        data: [with - [hello world]] 
        code: [34 33 112 172 218] (5 bytes) 


        >--------------------------------------------------
        > Function calls via symbol aliases
        >--------------------------------------------------

        input: [@ [1 2 3]] 
        data: [[1 2 3]] 
        code: [32 162 218] (3 bytes) 

        input: ["hello " ++ "world"] 
        data: [append hello  world] 
        code: [34 33 96 218] (4 bytes) 

        input: [1 .. 25] 
        data: [25] 
        code: [32 1 165 218] (4 bytes) 


        >--------------------------------------------------
        > User function definition & calling
        >--------------------------------------------------

        input: [h: function [] [print "function called"] print "before" h print "after"] 
        data: [h [print function called] before after] 
        code: [33 25 164 48 34 176 96 35 176 218] (10 bytes) 

        input: [f: function [x] [x + 1] print "before" print f 10 print "after"] 
        data: [f [x] [x + 1] before after] 
        code: [34 33 164 48 35 176 10 96 176 36 176 218] (12 bytes) 

        input: [g: $ [z w] [2 * z * w] print "before" print g 10 20 print "after"] 
        data: [g [z w] [2 * z * w] before 20 after] 
        code: [34 33 164 48 35 176 36 10 96 176 37 176 218] (13 bytes) 


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
        code: [0 64 160 218] (4 bytes) 

        input: [user\name] 
        data: [user name] 
        code: [33 64 160 218] (4 bytes) 

        input: [user\grades\0] 
        data: [user grades] 
        code: [0 33 64 160 160 218] (6 bytes) 

        input: [user\address\country] 
        data: [user address country] 
        code: [34 33 64 160 160 218] (6 bytes) 


        >--------------------------------------------------
        > PathLabel values
        >--------------------------------------------------

        input: [a\0: 10] 
        data: [a] 
        code: [10 0 64 161 218] (5 bytes) 

        input: [user\name: "John"] 
        data: [user name John] 
        code: [34 33 64 161 218] (5 bytes) 

        input: [user\grades\0: 6] 
        data: [user grades] 
        code: [6 0 33 64 160 161 218] (7 bytes) 

        input: [user\address\country: "USA"] 
        data: [user address country USA] 
        code: [35 34 33 64 160 161 218] (7 bytes) 


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
        code: [2 176 218] (3 bytes) 

        input: [(print 2) (print 3)] 
        data: [] 
        code: [2 176 3 176 218] (5 bytes) 


        >--------------------------------------------------
        > doublecolon syntactic sugar (`::`)
        >--------------------------------------------------

        input: [print 2 do :: print 3] 
        data: [do [print 3]] 
        code: [2 176 33 96 218] (5 bytes) 


        >--------------------------------------------------
        > arrowright syntactic sugar (`->`)
        >--------------------------------------------------

        input: [-> "hello"] 
        data: [[hello]] 
        code: [32 218] (2 bytes) 

        input: [do -> print "hello" print "done"] 
        data: [do [print hello] done] 
        code: [33 96 34 176 218] (5 bytes) 

        input: [a: -> upper "hello" b: -> "hello " ++ world] 
        data: [a [upper hello] b [hello  ++ world]] 
        code: [33 48 35 50 218] (5 bytes) 


        >--------------------------------------------------
        > thickarrowright syntactic sugar (`=>`)
        >--------------------------------------------------

        input: [=> "hello"] 
        data: [[] [hello]] 
        code: [32 33 218] (3 bytes) 

        input: [f: function => print] 
        data: [f function [_0] [print _0]] 
        code: [35 34 97 48 218] (5 bytes) 

        input: [adder: $ => add] 
        data: [adder function [_0 _1] [add _0 _1]] 
        code: [35 34 97 48 218] (5 bytes) 


        >--------------------------------------------------
        > pipe operator (`|`)
        >--------------------------------------------------

        input: [2 | print] 
        data: [print] 
        code: [2 96 218] (3 bytes) 


**************************************************
*
* OPTIMIZATIONS
*
**************************************************

        >--------------------------------------------------
        > add (`+`)
        >--------------------------------------------------

        input: [add 2 3] 
        data: [] 
        code: [3 2 128 218] (4 bytes) 

        input: [2 + 3] 
        data: [] 
        code: [3 2 128 218] (4 bytes) 

        input: [add 1 2] 
        data: [] 
        code: [2 174 218] (3 bytes) 

        input: [1 + 2] 
        data: [] 
        code: [2 174 218] (3 bytes) 

        input: [add 2 1] 
        data: [] 
        code: [2 174 218] (3 bytes) 

        input: [2 + 1] 
        data: [] 
        code: [2 174 218] (3 bytes) 


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