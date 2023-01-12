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
        code: [21 211] (2 bytes) 

        input: [false] 
        data: [] 
        code: [22 211] (2 bytes) 

        input: [maybe] 
        data: [maybe] 
        code: [64 211] (2 bytes) 


        >--------------------------------------------------
        > Integer
        >--------------------------------------------------

        input: [1] 
        data: [] 
        code: [1 211] (2 bytes) 

        input: [10] 
        data: [] 
        code: [10 211] (2 bytes) 

        input: [123] 
        data: [123] 
        code: [32 211] (2 bytes) 

        input: [1234567890123] 
        data: [1234567890123] 
        code: [32 211] (2 bytes) 


        >--------------------------------------------------
        > Floating
        >--------------------------------------------------

        input: [0.0] 
        data: [] 
        code: [17 211] (2 bytes) 

        input: [1.0] 
        data: [] 
        code: [18 211] (2 bytes) 

        input: [10.0] 
        data: [10.0] 
        code: [32 211] (2 bytes) 

        input: [12345.1234567] 
        data: [12345.1234567] 
        code: [32 211] (2 bytes) 


        >--------------------------------------------------
        > Char
        >--------------------------------------------------

        input: [`a`] 
        data: [a] 
        code: [32 211] (2 bytes) 

        input: [`😀`] 
        data: [😀] 
        code: [32 211] (2 bytes) 


        >--------------------------------------------------
        > String
        >--------------------------------------------------

        input: [""] 
        data: [] 
        code: [24 211] (2 bytes) 

        input: ["Hello World!"] 
        data: [Hello World!] 
        code: [32 211] (2 bytes) 


        >--------------------------------------------------
        > Regex
        >--------------------------------------------------

        input: [{/hello/}] 
        data: [hello] 
        code: [32 211] (2 bytes) 

        input: [{/[A-Z]+\d/}] 
        data: [[A-Z]+\d] 
        code: [32 211] (2 bytes) 


        >--------------------------------------------------
        > Type
        >--------------------------------------------------

        input: [:integer] 
        data: [:integer] 
        code: [32 211] (2 bytes) 

        input: [:string] 
        data: [:string] 
        code: [32 211] (2 bytes) 


        >--------------------------------------------------
        > Literal
        >--------------------------------------------------

        input: ['a] 
        data: [a] 
        code: [32 211] (2 bytes) 

        input: ['a 'b 'c] 
        data: [a b c] 
        code: [32 33 34 211] (4 bytes) 


        >--------------------------------------------------
        > SymbolLiteral
        >--------------------------------------------------

        input: ['+] 
        data: [+] 
        code: [32 211] (2 bytes) 

        input: ['-->] 
        data: [-->] 
        code: [32 211] (2 bytes) 


        >--------------------------------------------------
        > Color
        >--------------------------------------------------

        input: [#FF0000] 
        data: [#FF0000] 
        code: [32 211] (2 bytes) 

        input: [#00FF66] 
        data: [#00FF66] 
        code: [32 211] (2 bytes) 


        >--------------------------------------------------
        > Quantity
        >--------------------------------------------------

        input: [1:eur] 
        data: [1EUR] 
        code: [32 211] (2 bytes) 

        input: [12:m] 
        data: [12m] 
        code: [32 211] (2 bytes) 


        >--------------------------------------------------
        > Block
        >--------------------------------------------------

        input: [[]] 
        data: [] 
        code: [25 211] (2 bytes) 

        input: [[1 "hello" 3.14 true]] 
        data: [[1 hello 3.14 true]] 
        code: [32 211] (2 bytes) 


        >--------------------------------------------------
        > Null
        >--------------------------------------------------

        input: [∅] 
        data: [] 
        code: [27 211] (2 bytes) 

        input: [null] 
        data: [null] 
        code: [64 211] (2 bytes) 


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
        code: [1 48 211] (3 bytes) 

        input: [b: 2 c: b] 
        data: [b c] 
        code: [2 48 64 49 211] (5 bytes) 


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
        code: [10 96 211] (3 bytes) 

        input: [empty? []] 
        data: [empty?] 
        code: [25 96 211] (3 bytes) 

        input: [couple [1 2] ["one" "two"]] 
        data: [couple [1 2] [one two]] 
        code: [34 33 96 211] (4 bytes) 


        >--------------------------------------------------
        > Opcoded built-in function calls
        >--------------------------------------------------

        input: [print 2] 
        data: [] 
        code: [2 176 211] (3 bytes) 

        input: [size [1 2]] 
        data: [[1 2]] 
        code: [32 169 211] (3 bytes) 

        input: [and 1 123] 
        data: [123] 
        code: [32 1 137 211] (4 bytes) 


        >--------------------------------------------------
        > Function calls with attributes
        >--------------------------------------------------

        input: [split .words "hello world"] 
        data: [words hello world] 
        code: [33 21 112 171 211] (5 bytes) 

        input: [split .by: "X" "helloXworld"] 
        data: [by X helloXworld] 
        code: [34 33 112 171 211] (5 bytes) 

        input: [join .with: "-" ["hello" "world"]] 
        data: [with - [hello world]] 
        code: [34 33 112 172 211] (5 bytes) 


        >--------------------------------------------------
        > Function calls via symbol aliases
        >--------------------------------------------------

        input: [@ [1 2 3]] 
        data: [[1 2 3]] 
        code: [32 162 211] (3 bytes) 

        input: ["hello " ++ "world"] 
        data: [append hello  world] 
        code: [34 33 96 211] (4 bytes) 

        input: [1 .. 25] 
        data: [25] 
        code: [32 1 165 211] (4 bytes) 


        >--------------------------------------------------
        > User function definition & calling
        >--------------------------------------------------

        input: [h: function [] [print "function called"] print "before" h print "after"] 
        data: [h [print function called] before after] 
        code: [33 25 164 48 34 176 96 35 176 211] (10 bytes) 

        input: [f: function [x] [x + 1] print "before" print f 10 print "after"] 
        data: [f [x] [x + 1] before after] 
        code: [34 33 164 48 35 176 10 96 176 36 176 211] (12 bytes) 

        input: [g: $ [z w] [2 * z * w] print "before" print g 10 20 print "after"] 
        data: [g [z w] [2 * z * w] before 20 after] 
        code: [34 33 164 48 35 176 36 10 96 176 37 176 211] (13 bytes) 


**************************************************
*
* PATHS
*
**************************************************

        >--------------------------------------------------
        > Path values
        >--------------------------------------------------

        input: [] 
        data: [a 0] 
        code: [33 64 160 211] (4 bytes) 

        input: [] 
        data: [user name] 
        code: [33 64 160 211] (4 bytes) 

        input: [] 
        data: [user grades 0] 
        code: [34 33 64 160 160 211] (6 bytes) 

        input: [] 
        data: [user address country] 
        code: [34 33 64 160 160 211] (6 bytes) 


        >--------------------------------------------------
        > PathLabel values
        >--------------------------------------------------

        input: [ 10] 
        data: [a 0] 
        code: [10 33 64 161 211] (5 bytes) 

        input: [ "John"] 
        data: [user name John] 
        code: [34 33 64 161 211] (5 bytes) 

        input: [ 6] 
        data: [user grades 0] 
        code: [6 34 33 64 160 161 211] (7 bytes) 

        input: [ "USA"] 
        data: [user address country USA] 
        code: [35 34 33 64 160 161 211] (7 bytes) 