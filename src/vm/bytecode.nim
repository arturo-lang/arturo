######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: vm/bytecode.nim
######################################################

#=======================================
# Libraries
#=======================================

import hashes, marshal, streams

import vm/[globals, value]

#=======================================
# Types 
#=======================================

type
    OpCode* = enum
        # [0x0] #
        # push constants 
        opIPush0        = 0x00      # 0
        opIPush1        = 0x01      # 1
        opIPush2        = 0x02      # 2
        opIPush3        = 0x03      # 3
        opIPush4        = 0x04      # 4
        opIPush5        = 0x05      # 5
        opIPush6        = 0x06      # 6
        opIPush7        = 0x07      # 7
        opIPush8        = 0x08      # 8 
        opIPush9        = 0x09      # 9
        opIPush10       = 0x0A      # 10

        opFPush1        = 0x0B      # 1.0

        opBPushT        = 0x0C      # true
        opBPushF        = 0x0D      # false

        opNPush         = 0x0E      # Null

        opEnd           = 0x0F      

        # [0x1] #
        # push value
        opPush0         = 0x10   
        opPush1         = 0x11
        opPush2         = 0x12
        opPush3         = 0x13
        opPush4         = 0x14
        opPush5         = 0x15
        opPush6         = 0x16
        opPush7         = 0x17
        opPush8         = 0x18
        opPush9         = 0x19
        opPush10        = 0x1A
        opPush11        = 0x1B
        opPush12        = 0x1C
        opPush13        = 0x1D

        opPushX         = 0x1E
        opPushY         = 0x1F

        # [0x2] #
        # store variable (from <- stack)
        opStore0        = 0x20
        opStore1        = 0x21
        opStore2        = 0x22
        opStore3        = 0x23
        opStore4        = 0x24
        opStore5        = 0x25
        opStore6        = 0x26
        opStore7        = 0x27
        opStore8        = 0x28
        opStore9        = 0x29
        opStore10       = 0x2A
        opStore11       = 0x2B
        opStore12       = 0x2C
        opStore13       = 0x2D

        opStoreX        = 0x2E
        opStoreY        = 0x2F 

        # [0x3] #
        # load variable (to -> stack)
        opLoad0         = 0x30
        opLoad1         = 0x31
        opLoad2         = 0x32
        opLoad3         = 0x33
        opLoad4         = 0x34
        opLoad5         = 0x35
        opLoad6         = 0x36
        opLoad7         = 0x37
        opLoad8         = 0x38
        opLoad9         = 0x39
        opLoad10        = 0x3A
        opLoad11        = 0x3B
        opLoad12        = 0x3C
        opLoad13        = 0x3D

        opLoadX         = 0x3E 
        opLoadY         = 0x3F

        # [0x4] #
        # user function calls
        opCall0         = 0x40
        opCall1         = 0x41
        opCall2         = 0x42
        opCall3         = 0x43
        opCall4         = 0x44
        opCall5         = 0x45
        opCall6         = 0x46
        opCall7         = 0x47
        opCall8         = 0x48
        opCall9         = 0x49
        opCall10        = 0x4A
        opCall11        = 0x4B
        opCall12        = 0x4C
        opCall13        = 0x4D

        opCallX         = 0x4E
        opCallY         = 0x4F

        # [0x5] #
        # arithmetic & logical operations 
        opAdd           = 0x50
        opSub           = 0x51
        opMul           = 0x52
        opDiv           = 0x53
        opFDiv          = 0x54
        opMod           = 0x55
        opPow           = 0x56

        opNeg           = 0x57

        opNot           = 0x58
        opAnd           = 0x59
        opOr            = 0x5A
        opXor           = 0x5B

        opShl           = 0x5C
        opShr           = 0x5D

        opAttr          = 0x5E
        opReturn        = 0x5F

        # [0x6] #
        # stack operations
        opPop           = 0x60
        opDup           = 0x61
        opSwap          = 0x62
        opNop           = 0x63

        #flow control 
        opJmp           = 0x64
        opJmpIf         = 0x65
        
        opPush          = 0x66

        # comparison operations
        opEq            = 0x67
        opNe            = 0x68
        opGt            = 0x69
        opGe            = 0x6A
        opLt            = 0x6B
        opLe            = 0x6C

        # structures
        opArray         = 0x6D
        opDictionary    = 0x6E
        opFunction      = 0x6F

        # [0x7] #
        # system calls (144 slots)

        opPrint         = 0x70
        opInspect       = 0x71

        opIf            = 0x72
        opIsIf          = 0x73
        opElse          = 0x74

        opLoop          = 0x75

        opDo            = 0x76
        opMap           = 0x77
        opSelect        = 0x78
        opFilter        = 0x79

        opSize          = 0x7A

        opUpper         = 0x7B
        opLower         = 0x7C
        
        opGet           = 0x7D
        opSet           = 0x7E

    ParamSpec* = set[ValueKind]

    OpSpec* = object
        name*       : string
        alias*      : string
        args*       : int

        a*,b*,c*    : ParamSpec
        an*,bn*,cn* : string
        ret*        : ParamSpec

        attrs*      : string

        desc*       : string

#=======================================
# Constants
#=======================================

const 
    OpSpecs* = [
        # [0x5] #
        # arithmetic & logical operations

        opAdd       : OpSpec(   name    : "add",     
                                alias   : "+",     
                                args    : 2,   

                                an      : "valueA",      
                                a       : {Integer,Floating,Literal},        
                                bn      : "valueB",      
                                b       : {Integer,Floating},
                                ret     : {Integer,Floating,Null},               
                                desc    : "add given values" ),

        opSub       : OpSpec(   name    : "sub",   
                                alias   : "-",       
                                args    : 2,   

                                an      : "valueA",      
                                a       : {Integer,Floating,Literal},        
                                bn      : "valueB",      
                                b       : {Integer,Floating},      
                                ret     : {Integer,Floating,Null},      
                                desc    : "substract given values" ),

        opMul       : OpSpec(   name    : "mul", 
                                alias   : "*",         
                                args    : 2,   

                                an      : "valueA",      
                                a       : {Integer,Floating,Literal},        
                                bn      : "valueB",      
                                b       : {Integer,Floating},      
                                ret     : {Integer,Floating,Null},      
                                desc    : "multiply given values" ),

        opDiv       : OpSpec(   name    : "div", 
                                alias   : "/",         
                                args    : 2,   

                                an      : "valueA",      
                                a       : {Integer,Floating,Literal},        
                                bn      : "valueB",      
                                b       : {Integer,Floating},      
                                ret     : {Integer,Null},                        
                                desc    : "perform Integer division between given values" ),

        opFDiv      : OpSpec(   name    : "fdiv",         
                                args    : 2,   

                                an      : "valueA",      
                                a       : {Integer,Floating,Literal},        
                                bn      : "valueB",      
                                b       : {Integer,Floating},      
                                ret     : {Floating,Null},                       
                                desc    : "divide given values" ),

        opMod       : OpSpec(   name    : "mod",  
                                alias   : "%",        
                                args    : 2,   

                                an      : "valueA",      
                                a       : {Integer,Literal},                  
                                bn      : "valueB",      
                                b       : {Integer},
                                ret     : {Integer,Null},                        
                                desc    : "calculate the modulo between given values" ),

        opPow       : OpSpec(   name    : "pow",   
                                alias   : "^",      
                                args    : 2,   

                                an      : "valueA",      
                                a       : {Integer,Floating,Literal},        
                                bn      : "valueB",      
                                b       : {Integer,Floating},      
                                ret     : {Integer,Floating,Null},      
                                desc    : "calculate the power with given values" ),

        
        opNeg       : OpSpec(   name    : "neg",          
                                args    : 1,   

                                an      : "value",       
                                a       : {Integer,Floating,Literal},
                                ret     : {Integer,Floating,Null},      
                                desc    : "return negative using given value" ),

        opNot       : OpSpec(   name    : "not?",         
                                args    : 1,   

                                an      : "value",       
                                a       : {Boolean},
                                ret     : {Boolean},                        
                                desc    : "return the logical complement of the given value" ),

        opAnd       : OpSpec(   name    : "and?",         
                                args    : 2,   

                                an      : "valueA",      
                                a       : {Boolean},                  
                                bn      : "valueB",      
                                b       : {Boolean},
                                ret     : {Boolean},                        
                                desc    : "return the logical AND for the given values" ),

        opOr        : OpSpec(   name    : "or?",          
                                args    : 2,   

                                an      : "valueA",      
                                a       : {Boolean},                  
                                bn      : "valueB",      
                                b       : {Boolean},
                                ret     : {Boolean},                        
                                desc    : "return the logical OR for the given values" ),

        opXor       : OpSpec(   name    : "xor?",         
                                args    : 2,   

                                an      : "valueA",      
                                a       : {Boolean},                  
                                bn      : "valueB",      
                                b       : {Boolean},
                                ret     : {Boolean},                        
                                desc    : "return the logical XOR for the given values" ),

        opShl       : OpSpec(   name    : "shl",          
                                args    : 2,   

                                an      : "value",            
                                a       : {Integer,Literal},                  
                                bn      : "bits",            
                                b       : {Integer},
                                ret     : {Integer,Null},                        
                                desc    : "shift-left first value bits by second value" ),

        opShr       : OpSpec(   name    : "shr",          
                                args    : 2,   

                                an      : "value",            
                                a       : {Integer,Literal},                  
                                bn      : "bits",            
                                b       : {Integer},
                                ret     : {Integer,Null},                        
                                desc    : "shift-right first value bits by second value" ),

        opAttr      : OpSpec(),
        opReturn    : OpSpec(   name    : "return",          
                                args    : 1,   

                                an      : "value",
                                a       : {Any},
                                ret     : {Null},      
                                desc    : "return given value from current function" ),

        # [0x6] #
        # stack operations

        opPop       : OpSpec(   name    : "pop",          
                                args    : 1,   

                                an      : "n",
                                a       : {Integer},
                                ret     : {Any},    
                                attrs   :   ".discard -> do not return anything",   
                                desc    : "pop top <n> values from stack" ),

        opDup       : OpSpec(   name    : "dup",          
                                args    : 0,   

                                ret     : {Null},      
                                desc    : "duplicate the top stack value" ),

        opSwap      : OpSpec(   name    : "swap",         
                                args    : 0,   

                                ret     : {Null},      
                                desc    : "swap the top two stack values" ),

        opNop       : OpSpec(   name    : "nop",          
                                args    : 0,   

                                ret     : {Null},      
                                desc    : "do nothing" ),


        #flow control

        opJmp       : OpSpec(),

        opJmpIf     : OpSpec(),

        
        opPush      : OpSpec(   name    : "push",          
                                args    : 1,   

                                an      : "value",
                                a       : {Any},
                                ret     : {Null},    
                                desc    : "push given value to stack twice" ),


        # comparison operations

        opEq        : OpSpec(   name    : "equal?",   
                                alias   : "=",
                                args    : 2,   

                                an      : "valueA",      
                                a       : {Any},                      
                                bn      : "valueB",      
                                b       : {Any},
                                ret     : {Boolean},      
                                desc    : "check if valueA = valueB (equality)" ),

        opNe        : OpSpec(   name    : "notEqual?",   
                                alias   : "<>",       
                                args    : 2,   

                                an      : "valueA",      
                                a       : {Any},                      
                                bn      : "valueB",      
                                b       : {Any},
                                ret     : {Boolean},      
                                desc    : "check if valueA <> valueB (inequality)" ),

        opGt        : OpSpec(   name    : "greater?", 
                                alias   : ">",         
                                args    : 2,   

                                an      : "valueA",      
                                a       : {Any},                      
                                bn      : "valueB",      
                                b       : {Any},
                                ret     : {Boolean},      
                                desc    : "check if valueA > valueB (greater than)" ),

        opGe        : OpSpec(   name    : "greaterOrEqual?", 
                                alias   : ">=",         
                                args    : 2,   

                                an      : "valueA",      
                                a       : {Any},                      
                                bn      : "valueB",      
                                b       : {Any},
                                ret     : {Boolean},      
                                desc    : "check if valueA >= valueB (greater than or equal)" ),

        opLt        : OpSpec(   name    : "less?",
                                alias   : "<",          
                                args    : 2,   

                                an      : "valueA",      
                                a       : {Any},                      
                                bn      : "valueB",      
                                b       : {Any},
                                ret     : {Boolean},      
                                desc    : "check if valueA < valueB (less than)" ),

        opLe        : OpSpec(   name    : "lessOrEqual?", 
                                alias   : "=<",         
                                args    : 2,   

                                an      : "valueA",      
                                a       : {Any},      
                                bn      : "valueB",      
                                b       : {Any},      
                                ret     : {Boolean},      
                                desc    : "check if valueA =< valueB (less than or equal)" ),

        # structures

        opArray     : OpSpec(   name    : "array", 
                                alias   : "@",       
                                args    : 1,   

                                an      : "source",       
                                a       : {Block,String},      
                                ret     : {Block},      
                                desc    : "create array from given block~by calculating all internal values" ),

        opDictionary: OpSpec(   name    : "dictionary",
                                alias   : "#",      
                                args    : 1,   

                                an      : "source",      
                                a       : {Block,String},      
                                ret     : {Dictionary},      
                                desc    : "create dictionary from given block or file~by getting all internal symbols" ),

        opFunction  : OpSpec(   name    : "function",
                                alias   : "$",      
                                args    : 2,   

                                an      : "arguments",   
                                a       : {Block},      
                                bn      : "body",        
                                b       : {Block},
                                ret     : {Function},  
                                attrs   :   ".export :block -> export given symbols to parent~" &
                                            ".pure -> denotes pure function with no access to parent",     
                                desc    : "create function with given arguments and body" ),

        # [0x7] #
        # system calls (144 slots)

        opPrint     : OpSpec(   name    : "print",        
                                args    : 1,   

                                an      : "value",      
                                a       : {Any},      
                                ret     : {Null},      
                                desc    : "print given value to screen with newline" ),

        opInspect   : OpSpec(   name    : "inspect",      
                                args    : 1,   

                                an      : "value",      
                                a       : {Any},      
                                ret     : {Null},      
                                desc    : "print full dump of given value to screen" ),

        opIf        : OpSpec(   name    : "if",      
                                args    : 2,   

                                an      : "condition",      
                                a       : {Boolean},      
                                bn      : "action",      
                                b       : {Block},      
                                ret     : {Null},      
                                desc    : "perform action, if given condition is true" ),

        opIsIf      : OpSpec(   name    : "if?",          
                                args    : 2,   

                                an      : "condition",      
                                a       : {Boolean},      
                                bn      : "action",      
                                b       : {Block},      
                                ret     : {Boolean},      
                                desc    : "perform action, if given condition is true and return condition" ),

        opElse      : OpSpec(   name    : "else",      
                                args    : 1,   

                                an      : "alternative", 
                                a       : {Block},      
                                ret     : {Null},      
                                desc    : "perform action, if last condition was not true" ),

        opLoop      : OpSpec(   name    : "loop",      
                                args    : 3,   

                                an      : "collection",      
                                a       : {Block,Dictionary,Integer},      
                                bn      : "params",      
                                b       : {Literal,Block},            
                                cn      : "action",          
                                c       : {Block},            
                                ret     : {Null},      
                                attrs   :   ".with :literal -> use given index",   
                                desc    : "loop through collection~using given iterator and block" ),

        opDo        : OpSpec(   name    : "do",      
                                args    : 1,   

                                an      : "code",      
                                a       : {String,Block},      
                                ret     : {Any,Null},
                                attrs   :   ".import -> execute at root level",   
                                desc    : "evaluate and execute given code" ),

        opMap       : OpSpec(   name    : "map",          
                                args    : 3,   

                                an      : "collection",  
                                a       : {Block,Literal},              
                                bn      : "params",      
                                b       : {Literal,Block},            
                                cn      : "action",          
                                c       : {Block},            
                                ret     : {Block,Null},      
                                desc    : "map collection's items by applying given action" ),

        opSelect    : OpSpec(   name    : "select",       
                                args    : 3,   

                                an      : "collection",  
                                a       : {Block,Literal},              
                                bn      : "params",      
                                b       : {Literal,Block},            
                                cn      : "condition",       
                                c       : {Block},            
                                ret     : {Block,Null},      
                                desc    : "get collection's items that fulfil given condition" ),

        opFilter    : OpSpec(   name    : "filter",       
                                args    : 3,   

                                an      : "collection",  
                                a       : {Block,Literal},              
                                bn      : "params",      
                                b       : {Literal,Block},            
                                cn      : "condition",       
                                c       : {Block},            
                                ret     : {Block,Null},      
                                desc    : "get collection's items by filtering those~that do not fulfil given condition" ),

        opSize      : OpSpec(   name    : "size",      
                                args    : 1,   

                                an      : "collection",  
                                a       : {String,Block,Dictionary},
                                ret     : {Integer},      
                                desc    : "get size/length of given collection" ),

        opUpper     : OpSpec(   name    : "upper",        
                                args    : 1,   

                                an      : "string",      
                                a       : {String,Literal},
                                ret     : {String,Null},      
                                desc    : "convert given string to uppercase" ),

        opLower     : OpSpec(   name    : "lower",        
                                args    : 1,   

                                an      : "string",      
                                a       : {String,Literal},
                                ret     : {String,Null},      
                                desc    : "convert given string to lowercase" ),

        opGet       : OpSpec(   name    : "get",          
                                args    : 2,   

                                an      : "collection",  
                                a       : {Block,Dictionary,String,Date},  
                                bn      : "index",       
                                b       : {Integer,String,Literal},     
                                ret     : {Any},                
                                desc    : "get collection's item by given index" ),

        opSet       : OpSpec(   name    : "set",          
                                args    : 3,   

                                an      : "collection",  
                                a       : {Block,Dictionary,String},  
                                bn      : "index",       
                                b       : {Integer,String,Literal}, 
                                cn      : "value",
                                c       : {Any},    
                                ret     : {Null},                
                                desc    : "set collection's item at index to given value" ),


        # opTo        : OpSpec(   name    : "to",      
        #                         args    : 2,   

        #                         an      : "type",        
        #                         a       : {Type},      
        #                         bn      : "value",       
        #                         b       : {Any},      
        #                         ret     : {Any},      
        #                         desc    : "convert value to given type" ),

        # opEven      : OpSpec(   name    : "even?",        
        #                         args    : 1,   

        #                         an      : "number",      
        #                         a       : {Integer},      
        #                         ret     : {Boolean},      
        #                         desc    : "check if given number is even" ),

        # opOdd       : OpSpec(   name    : "odd?",      
        #                         args    : 1,   

        #                         an      : "number",      
        #                         a       : {Integer},      
        #                         ret     : {Boolean},      
        #                         desc    : "check if given number is odd" ),

        # opRange     : OpSpec(   name    : "range", 
        #                         alias   : "..",       
        #                         args    : 2,   

        #                         an      : "from",        
        #                         a       : {Integer},      
        #                         bn      : "to",          
        #                         b       : {Integer},
        #                         ret     : {Block},     
        #                         attrs   :   ".step :integer -> use step between range values", 
        #                         desc    : "get list of numbers in given range (inclusive)" ),

        # opSum       : OpSpec(   name    : "sum",          
        #                         args    : 1,   

        #                         an      : "numbers",      
        #                         a       : {Block},      
        #                         ret     : {Integer,Floating},   
        #                         desc    : "calculate the sum of all values in given list" ),

        # opProduct   : OpSpec(   name    : "product",      
        #                         args    : 1,   

        #                         an      : "numbers",      
        #                         a       : {Block},      
        #                         ret     : {Integer,Floating},   
        #                         desc    : "calculate the product of all values in given list" ),

        # opExit      : OpSpec(   name    : "exit",      
        #                         args    : 0,   
      
        #                         ret     : {Null},    
        #                         desc    : "exit program" ),

        # opInfo      : OpSpec(   name    : "info",      
        #                         args    : 1,   

        #                         an      : "symbol",      
        #                         a       : {String,Literal},      
        #                         ret     : {Dictionary,Null},      
        #                         desc    : "print info for given symbol" ),

        # opType      : OpSpec(   name    : "type",      
        #                         args    : 1,   

        #                         an      : "value",      
        #                         a       : {Any},      
        #                         ret     : {Type},      
        #                         desc    : "get datatype of given value"),

        # opIs        : OpSpec(   name    : "is?",          
        #                         args    : 2,   

        #                         an      : "type",      
        #                         a       : {Type},      
        #                         bn      : "value",      
        #                         b       : {Any},      
        #                         ret     : {Boolean},      
        #                         desc    : "check if given parameter is of a specific datatype"),

        # opBNot      : OpSpec(   name    : "not",          
        #                         args    : 1,   

        #                         an      : "value",      
        #                         a       : {Integer,Literal},      
        #                         ret     : {Integer,Null},      
        #                         desc    : "calculate the binary complement of the given value" ),

        # opBAnd      : OpSpec(   name    : "and",          
        #                         args    : 2,   

        #                         an      : "valueA",      
        #                         a       : {Integer,Literal},      
        #                         bn      : "valueB",      
        #                         b       : {Integer},
        #                         ret     : {Integer,Null},      
        #                         desc    : "calculate the binary AND for the given values" ),

        # opBOr       : OpSpec(   name    : "or",      
        #                         args    : 2,   

        #                         an      : "valueA",      
        #                         a       : {Integer,Literal},      
        #                         bn      : "valueB",      
        #                         b       : {Integer},
        #                         ret     : {Integer,Null},      
        #                         desc    : "calculate the binary OR for the given values" ),

        # opBXor      : OpSpec(   name    : "xor",          
        #                         args    : 2,   

        #                         an      : "valueA",      
        #                         a       : {Integer,Literal},      
        #                         bn      : "valueB",      
        #                         b       : {Integer},
        #                         ret     : {Integer,Null},      
        #                         desc    : "calculate the binary XOR for the given values" ),

        # opFirst     : OpSpec(   name    : "first",        
        #                         args    : 1,   

        #                         an      : "collection",      
        #                         a       : {String,Block},
        #                         ret     : {Any},      
        #                         attrs   :   ".n :integer -> get first <n> items",           
        #                         desc    : "return the first item of the given collection"),

        # opLast      : OpSpec(   name    : "last",      
        #                         args    : 1,   

        #                         an      : "collection",      
        #                         a       : {String,Block},
        #                         ret     : {Any},   
        #                         attrs   :   ".n :integer -> get last <n> items",               
        #                         desc    : "return the last item of the given collection"),

        # opUnique    : OpSpec(   name    : "unique",       
        #                         args    : 1,   

        #                         an      : "collection",      
        #                         a       : {Block,Literal},                 
        #                         ret     : {Block,Null},         
        #                         desc    : "get given block without duplicates"),

        # opSort      : OpSpec(   name    : "sort",      
        #                         args    : 1,   

        #                         an      : "collection",      
        #                         a       : {Block,Literal},                  
        #                         ret     : {Block,Null}, 
        #                         attrs   :   ".as :literal -> localized by ISO 639-1 language code~" &                       
        #                                     ".sensitive -> case-sensitive sort~" &
        #                                     ".descending -> sort descending",
        #                         desc    : "sort given block in ascending order"),

        # opInc       : OpSpec(   name    : "inc",          
        #                         args    : 1,   

        #                         an      : "value",      
        #                         a       : {Integer,Floating,Literal},
        #                         ret     : {Integer,Floating,Null},      
        #                         desc    : "increase first argument by 1"),

        # opDec       : OpSpec(   name    : "dec",          
        #                         args    : 1,   

        #                         an      : "value",      
        #                         a       : {Integer,Floating,Literal},
        #                         ret     : {Integer,Floating,Null},      
        #                         desc    : "decrease first argument by 1"),

        # opIsSet     : OpSpec(   name    : "set?",      
        #                         args    : 1,   

        #                         an      : "symbol",      
        #                         a       : {Literal},      
        #                         ret     : {Boolean},      
        #                         desc    : "check if given variable is defined"),

        # opSymbols   : OpSpec(   name    : "symbols",      
        #                         args    : 0,   
      
        #                         ret     : {Dictionary},         
        #                         desc    : "get currently defined symbols"),

        # opStack     : OpSpec(   name    : "stack",         
        #                         args    : 0,   
      
        #                         ret     : {Dictionary},         
        #                         desc    : "get current stack"),

        # opCase      : OpSpec(   name    : "case",      
        #                         args    : 1,   

        #                         an      : "predicate",      
        #                         a       : {Block},      
        #                         ret     : {Null},         
        #                         desc    : "initiate a case block to check for different cases"),

        # opWhen      : OpSpec(   name    : "when?",        
        #                         args    : 2,   

        #                         an      : "condition",      
        #                         a       : {Block},      
        #                         bn      : "action",      
        #                         b       : {Block},      
        #                         ret     : {Boolean},         
        #                         desc    : "check if a specific condition is fulfilled~and if so, execute given action"),

        # opCapitalize: OpSpec(   name    : "capitalize",   
        #                         args    : 1,   

        #                         an      : "string",      
        #                         a       : {String,Literal},
        #                         ret     : {String,Null},        
        #                         desc    : "convert given string to capitalized"),

        # opRepeat    : OpSpec(   name    : "repeat",       
        #                         args    : 2,   

        #                         an      : "value",      
        #                         a       : {Literal,Any},      
        #                         bn      : "times",      
        #                         b       : {Integer},      
        #                         ret     : {String,Block},      
        #                         desc    : "repeat value the given number of times~and return new one"),

        # opWhile     : OpSpec(   name    : "while",        
        #                         args    : 2,   

        #                         an      : "condition",      
        #                         a       : {Block},      
        #                         bn      : "action",      
        #                         b       : {Block},      
        #                         ret     : {Null},      
        #                         desc    : "execute action while the given condition is true"),

        # opRandom    : OpSpec(   name    : "random",       
        #                         args    : 2,   

        #                         an      : "lowerLimit",  
        #                         a       : {Integer},      
        #                         bn      : "upperLimit",  
        #                         b       : {Integer},
        #                         ret     : {Integer},      
        #                         desc    : "get a random integer between given limits"),

        # opSample    : OpSpec(   name    : "sample",       
        #                         args    : 1,   

        #                         an      : "collection",  
        #                         a       : {Block},      
        #                         ret     : {Any},                
        #                         desc    : "get a random element from given collection"),

        # opShuffle   : OpSpec(   name    : "shuffle",      
        #                         args    : 1,   

        #                         an      : "collection",  
        #                         a       : {Block,Literal},      
        #                         ret     : {Block,Null},   
        #                         desc    : "get given collection shuffled"),

        # opSlice     : OpSpec(   name    : "slice",        
        #                         args    : 3,   

        #                         an      : "collection",  
        #                         a       : {String,Block},       
        #                         bn      : "from",        
        #                         b       : {Integer},                  
        #                         cn      : "to",              
        #                         c       : {Integer},          
        #                         ret     : {String,Block}, 
        #                         desc    : "get a slice of collection between given indices"),

        # opClear     : OpSpec(   name    : "clear",        
        #                         args    : 0,   
      
        #                         ret     : {Null},      
        #                         desc    : "clear terminal"),

        # opAll       : OpSpec(   name    : "all?",      
        #                         args    : 3,   

        #                         an      : "collection",  
        #                         a       : {Block},              
        #                         bn      : "params",      
        #                         b       : {Literal,Block},            
        #                         cn      : "condition",       
        #                         c       : {Block},            
        #                         ret     : {Boolean},      
        #                         desc    : "check if all of collection's item satisfy given condition"),

        # opAny       : OpSpec(   name    : "any?",      
        #                         args    : 3,   

        #                         an      : "collection",  
        #                         a       : {Block},              
        #                         bn      : "params",      
        #                         b       : {Literal,Block},            
        #                         cn      : "condition",       
        #                         c       : {Block},            
        #                         ret     : {Boolean},      
        #                         desc    : "check if any of collection's item satisfy given condition"),

        # opRead      : OpSpec(   name    : "read",    
        #                         alias   : "<<",  
        #                         args    : 1,   

        #                         an      : "file",        
        #                         a       : {String},                      
        #                         ret     : {String,Block,Binary},                
        #                         attrs   :   ".lines -> read file lines into block~" &
        #                                     ".json -> read json file into a valid value~" &
        #                                     ".csv -> read CSV file into a block of rows~" &
        #                                     ".withHeaders -> read CSV headers~"&
        #                                     ".html* -> read html file into node dictionary~" &
        #                                     ".markdown* -> read markdown and convert to html~" &
        #                                     ".binary -> read as binary", 
        #                         desc    : "read file from given path", ),

        # opWrite     : OpSpec(   name    : "write",  
        #                         alias   : ">>",      
        #                         args    : 2,   

        #                         an      : "file",        
        #                         a       : {String,Null},                   
        #                         bn      : "content",     
        #                         b       : {Any},      
        #                         ret     : {Null},      
        #                         attrs   :   ".directory -> create directory at path~" &
        #                                     ".json -> write value as json~" &
        #                                     ".binary -> write as binary",
        #                         desc    : "write content to file at given path"),

        # opAbs       : OpSpec(   name    : "abs",        
        #                         args    : 1,   

        #                         an      : "value",        
        #                         a       : {Integer},                        
        #                         ret     : {Integer},      
        #                         desc    : "get the absolute value for given integer"),

        # opAcos      : OpSpec(   name    : "acos",        
        #                         args    : 1,   

        #                         an      : "angle",        
        #                         a       : {Floating},                        
        #                         ret     : {Floating},      
        #                         desc    : "calculate the inverse cosine of given angle"),

        # opAcosh     : OpSpec(   name    : "acosh",        
        #                         args    : 1,   

        #                         an      : "angle",        
        #                         a       : {Floating},                        
        #                         ret     : {Floating},      
        #                         desc    : "calculate the inverse hyperbolic cosine of given angle"),

        # opAsin      : OpSpec(   name    : "asin",        
        #                         args    : 1,   

        #                         an      : "angle",        
        #                         a       : {Floating},                        
        #                         ret     : {Floating},      
        #                         desc    : "calculate the inverse sine of given angle"),

        # opAsinh     : OpSpec(   name    : "asinh",        
        #                         args    : 1,   

        #                         an      : "angle",        
        #                         a       : {Floating},                        
        #                         ret     : {Floating},      
        #                         desc    : "calculate the inverse hyperbolic sine of given angle"),

        # opAtan      : OpSpec(   name    : "atan",        
        #                         args    : 1,   

        #                         an      : "angle",        
        #                         a       : {Floating},                        
        #                         ret     : {Floating},      
        #                         desc    : "calculate the inverse tangent of given angle"),

        # opAtanh     : OpSpec(   name    : "atanh",        
        #                         args    : 1,   

        #                         an      : "angle",        
        #                         a       : {Floating},                        
        #                         ret     : {Floating},      
        #                         desc    : "calculate the inverse hyperbolic tangent of given angle"),

        # opCos       : OpSpec(   name    : "cos",        
        #                         args    : 1,   

        #                         an      : "angle",        
        #                         a       : {Floating},                        
        #                         ret     : {Floating},      
        #                         desc    : "calculate the cosine of given angle"),

        # opCosh      : OpSpec(   name    : "cosh",        
        #                         args    : 1,   

        #                         an      : "angle",        
        #                         a       : {Floating},                        
        #                         ret     : {Floating},      
        #                         desc    : "calculate the hyperbolic cosine of given angle"),

        # opCsec      : OpSpec(   name    : "csec",        
        #                         args    : 1,   

        #                         an      : "angle",        
        #                         a       : {Floating},                        
        #                         ret     : {Floating},      
        #                         desc    : "calculate the cosecant of given angle"),

        # opCsech     : OpSpec(   name    : "csech",        
        #                         args    : 1,   

        #                         an      : "angle",        
        #                         a       : {Floating},                        
        #                         ret     : {Floating},      
        #                         desc    : "calculate the hyperbolic cosecant of given angle"),

        # opCtan      : OpSpec(   name    : "ctan",        
        #                         args    : 1,   

        #                         an      : "angle",        
        #                         a       : {Floating},                        
        #                         ret     : {Floating},      
        #                         desc    : "calculate the cotangent of given angle"),

        # opCtanh     : OpSpec(   name    : "ctanh",        
        #                         args    : 1,   

        #                         an      : "angle",        
        #                         a       : {Floating},                        
        #                         ret     : {Floating},      
        #                         desc    : "calculate the hyperbolic cotangent of given angle"),

        # opSec       : OpSpec(   name    : "sec",        
        #                         args    : 1,   

        #                         an      : "angle",        
        #                         a       : {Floating},                        
        #                         ret     : {Floating},      
        #                         desc    : "calculate the secant of given angle"),

        # opSech      : OpSpec(   name    : "sech",        
        #                         args    : 1,   

        #                         an      : "angle",        
        #                         a       : {Floating},                        
        #                         ret     : {Floating},      
        #                         desc    : "calculate the hyperbolic secant of given angle"),

        # opSin       : OpSpec(   name    : "sin",        
        #                         args    : 1,   

        #                         an      : "angle",        
        #                         a       : {Floating},                        
        #                         ret     : {Floating},      
        #                         desc    : "calculate the sine of given angle"),

        # opSinh      : OpSpec(   name    : "sinh",        
        #                         args    : 1,   

        #                         an      : "angle",        
        #                         a       : {Floating},                        
        #                         ret     : {Floating},      
        #                         desc    : "calculate the hyperbolic sine of given angle"),

        # opTan       : OpSpec(   name    : "tan",        
        #                         args    : 1,   

        #                         an      : "angle",        
        #                         a       : {Floating},                        
        #                         ret     : {Floating},      
        #                         desc    : "calculate the tangent of given angle"),

        # opTanh      : OpSpec(   name    : "tanh",        
        #                         args    : 1,   

        #                         an      : "angle",        
        #                         a       : {Floating},                        
        #                         ret     : {Floating},      
        #                         desc    : "calculate the hyperbolic tangent of given angle"),

        # opInput     : OpSpec(   name    : "input",        
        #                         args    : 1,   

        #                         an      : "prompt",        
        #                         a       : {String},                        
        #                         ret     : {String},      
        #                         desc    : "print prompt and get user input"),

        # opPad       : OpSpec(   name    : "pad",        
        #                         args    : 2,   

        #                         an      : "string",        
        #                         a       : {String,Literal},
        #                         bn      : "padding",
        #                         b       : {Integer},
        #                         ret     : {String},  
        #                         attrs   :   ".center -> add padding to both sides~" &
        #                                     ".right -> add right padding",
        #                         desc    : "align string by adding given padding (spaces)"),

        # opReplace   : OpSpec(   name    : "replace",
        #                         args    : 3,

        #                         an      : "string",
        #                         a       : {String,Literal},
        #                         bn      : "match",
        #                         b       : {String},
        #                         cn      : "replacement",
        #                         c       : {String},
        #                         ret     : {String,Null}, #SHOULD add .once
        #                         attrs   :   ".regex -> match against a regular expression",
        #                         desc    : "look for substring in given string~and replace them given replacement"),

        # opStrip     : OpSpec(   name    : "strip",
        #                         args    : 1,

        #                         an      : "string",
        #                         a       : {String,Literal},
        #                         ret     : {String,Null},
        #                         desc    : "strip whitespace from given string"),

        # opSplit     : OpSpec(   name    : "split",
        #                         args    : 1,

        #                         an      : "collection",
        #                         a       : {Block,String,Literal},
        #                         ret     : {Block,Null},
        #                         attrs   :   ".words -> split string by whitespace~" &
        #                                     ".lines -> split string by lines~" &
        #                                     ".by :string -> split using given separator~" &
        #                                     ".regex :string -> match against a regular expression~" &
        #                                     ".at :integer -> split collection at given position~" &
        #                                     ".every :integer -> split collection every number of elements",
        #                         desc    : "split collection to components"),

        # opPrefix    : OpSpec(   name    : "prefix",
        #                         args    : 2,

        #                         an      : "string",
        #                         a       : {String,Literal},
        #                         bn      : "start",
        #                         b       : {String},
        #                         ret     : {String,Null},
        #                         desc    : "add given prefix to string"),

        # opHasPrefix : OpSpec(   name    : "prefix?",
        #                         args    : 2,

        #                         an      : "string",
        #                         a       : {String},
        #                         bn      : "start",
        #                         b       : {String},
        #                         ret     : {Boolean},
        #                         attrs   :   ".regex -> match against a regular expression", 
        #                         desc    : "check if string starts with given prefix"),

        # opSuffix    : OpSpec(   name    : "suffix",
        #                         args    : 2,

        #                         an      : "string",
        #                         a       : {String,Literal},
        #                         bn      : "ending",
        #                         b       : {String},
        #                         ret     : {String,Null},
        #                         desc    : "add given suffix to string"),

        # opHasSuffix : OpSpec(   name    : "suffix?",
        #                         args    : 2,

        #                         an      : "string",
        #                         a       : {String},
        #                         bn      : "ending",
        #                         b       : {String},
        #                         ret     : {Boolean},
        #                         attrs   :   ".regex -> match against a regular expression", 
        #                         desc    : "check if string ends with given suffix"),

        # opExists    : OpSpec(   name    : "exists?",
        #                         args    : 1,

        #                         an      : "file",
        #                         a       : {String},
        #                         ret     : {Boolean},
        #                         attrs   :   ".dir -> check for directory",
        #                         desc    : "check if given file exists"),

        # opTry       : OpSpec(   name    : "try",      
        #                         args    : 1,   
     
        #                         an      : "action",      
        #                         a       : {Block},      
        #                         ret     : {Null},      
        #                         desc    : "perform action and catch possible errors" ),

        # opTryE      : OpSpec(   name    : "try?",          
        #                         args    : 1,   
    
        #                         an      : "action",      
        #                         a       : {Block},      
        #                         ret     : {Boolean},      
        #                         desc    : "perform action, catch possible errors and return status" ),

        # opIsUpper   : OpSpec(   name    : "upper?",        
        #                         args    : 1,   

        #                         an      : "string",      
        #                         a       : {String},
        #                         ret     : {Boolean},      
        #                         desc    : "check if given string is uppercase" ),

        # opIsLower   : OpSpec(   name    : "lower?",        
        #                         args    : 1,   

        #                         an      : "string",      
        #                         a       : {String},
        #                         ret     : {Boolean},      
        #                         desc    : "check if given string is lowercase" ),

        # opHelp      : OpSpec(   name    : "help",        
        #                         args    : 1,   

        #                         an      : "function",
        #                         a       : {Literal,Block},
        #                         ret     : {Null},      
        #                         desc    : "print help for given function or ~a complete list of built-in functions" ),

        # opEmpty     : OpSpec(   name    : "empty",        
        #                         args    : 1,   

        #                         an      : "collection",
        #                         a       : {Literal},
        #                         ret     : {Null},      
        #                         desc    : "empty given collection" ),

        # opIsEmpty   : OpSpec(   name    : "empty?",        
        #                         args    : 1,   

        #                         an      : "collection",
        #                         a       : {String,Block,Dictionary,Null},
        #                         ret     : {Boolean},      
        #                         desc    : "check if given collection is empty" ),

        # opInsert    : OpSpec(   name    : "insert",        
        #                         args    : 3,   

        #                         an      : "collection",
        #                         a       : {String,Block,Dictionary,Literal},
        #                         bn      : "index",
        #                         b       : {Integer,String},
        #                         cn      : "value",
        #                         c       : {Any},
        #                         ret     : {String,Block,Dictionary},      
        #                         desc    : "insert value in collection at given index" ),

        # opIsIn      : OpSpec(   name    : "in?",        
        #                         args    : 2,   

        #                         an      : "value",
        #                         a       : {Any},
        #                         bn      : "collection",
        #                         b       : {String,Block,Dictionary},
        #                         ret     : {Boolean},    
        #                         attrs   :   ".regex -> match against a regular expression", 
        #                         desc    : "check if value exists in given collection" ),

        # opIndex     : OpSpec(   name    : "index",        
        #                         args    : 2,   

        #                         an      : "collection",
        #                         a       : {String,Block,Dictionary},
        #                         bn      : "value",
        #                         b       : {Any},
        #                         ret     : {Integer,String,Null},      
        #                         desc    : "return first index of value in given collection" ),

        # opHasKey    : OpSpec(   name    : "key?",        
        #                         args    : 2,   

        #                         an      : "collection",
        #                         a       : {Dictionary},
        #                         bn      : "key",
        #                         b       : {String,Literal},
        #                         ret     : {Boolean},      
        #                         desc    : "check if dictionary contains given key" ),

        # opReverse   : OpSpec(   name    : "reverse",        
        #                         args    : 1,   

        #                         an      : "collection",
        #                         a       : {Block,String,Literal},
        #                         ret     : {Block,String,Null},      
        #                         desc    : "reverse given collection" ),

        # opExecute   : OpSpec(   name    : "execute",        
        #                         args    : 1,   

        #                         an      : "command",
        #                         a       : {String},
        #                         ret     : {String},      
        #                         desc    : "execute given shell command" ),

        # opPrints    : OpSpec(   name    : "prints",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Null},
        #                         desc    : "print given value to screen"),

        # opBenchmark : OpSpec(   name    : "benchmark",
        #                         args    : 1,

        #                         an      : "action",
        #                         a       : {Block},
        #                         ret     : {Null},
        #                         desc    : "benchmark given code"),

        # opJoin      : OpSpec(   name    : "join",
        #                         args    : 1,

        #                         an      : "collection",
        #                         a       : {Block,Literal},
        #                         ret     : {Block,Null},
        #                         attrs   :   ".with :string -> use given separator~" &
        #                                     ".path -> join as path components",
        #                         desc    : "join collection of strings into string"),

        # opMax       : OpSpec(   name    : "max",
        #                         args    : 1,

        #                         an      : "collection",
        #                         a       : {Block},
        #                         ret     : {Any,Null},
        #                         desc    : "get maximum element in given collection"),

        # opMin       : OpSpec(   name    : "min",
        #                         args    : 1,

        #                         an      : "collection",
        #                         a       : {Block},
        #                         ret     : {Any,Null},
        #                         desc    : "get minimum element in given collection"),

        # opKeys      : OpSpec(   name    : "keys",
        #                         args    : 1,

        #                         an      : "dictionary",
        #                         a       : {Dictionary},
        #                         ret     : {Block},
        #                         desc    : "get list of keys for given dictionary"),

        # opValues    : OpSpec(   name    : "values",
        #                         args    : 1,

        #                         an      : "dictionary",
        #                         a       : {Dictionary},
        #                         ret     : {Block},
        #                         desc    : "get list of values for given dictionary"),

        # opDigest    : OpSpec(   name    : "digest",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {String,Literal},
        #                         ret     : {String},
        #                         attrs   :   ".sha -> use SHA1",
        #                         desc    : "get digest for given value (default: MD5)"),

        # opAlias     : OpSpec(),

        # opMail      : OpSpec(   name    : "mail",
        #                         args    : 3,

        #                         an      : "recipient",
        #                         a       : {String},
        #                         bn      : "message",
        #                         b       : {Dictionary},
        #                         cn      : "config",
        #                         c       : {Dictionary},
        #                         ret     : {Null},
        #                         desc    : "send mail using given message and configuration"),

        # opDownload  : OpSpec(   name    : "download",
        #                         args    : 1,

        #                         an      : "url",
        #                         a       : {String},
        #                         ret     : {Null},
        #                         attrs   :   ".as :string -> set target file",
        #                         desc    : "download file from url to disk"),

        # opGetAttr   : OpSpec(   name    : "attribute",
        #                         args    : 1,

        #                         an      : "key",
        #                         a       : {String},
        #                         ret     : {Any,Null},
        #                         desc    : "get given attribute, if it exists"),

        # opHasAttr   : OpSpec(   name    : "hasAttribute?",
        #                         args    : 1,

        #                         an      : "key",
        #                         a       : {String},
        #                         ret     : {Boolean},
        #                         desc    : "check if given attribute exists"),

        # opRender    : OpSpec(   name    : "render",
        #                         alias   : "~",
        #                         args    : 1,

        #                         an      : "template",
        #                         a       : {String},
        #                         ret     : {String},
        #                         attrs   :   ".with :dictionary -> use given dictionary",
        #                         desc    : "render template with |string| interpolation"),

        # opEncode    : OpSpec(   name    : "encode",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {String,Literal},
        #                         ret     : {String},
        #                         desc    : "base-64 encode given value"),

        # opDecode    : OpSpec(   name    : "decode",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {String,Literal},
        #                         ret     : {String},
        #                         desc    : "base-64 decode given value"),

        # opColor     : OpSpec(   name    : "color",
        #                         args    : 1,

        #                         an      : "string",
        #                         a       : {String},
        #                         ret     : {String},
        #                         attrs   :   ".rgb :integer -> use specific RGB color~" &
        #                                     ".bold -> bold color~" &
        #                                     ".black -> black foreground~" &
        #                                     ".red -> red foreground~" &
        #                                     ".green -> green foreground~" &
        #                                     ".yellow -> yellow foreground~" &
        #                                     ".blue -> blue foreground~" &
        #                                     ".magenta -> magenta foreground~" &
        #                                     ".cyan -> cyan foreground~" &
        #                                     ".white -> white foreground~" &
        #                                     ".gray -> gray foreground",
        #                         desc    : "get colored version of given string"),

        # opTake      : OpSpec(   name    : "take",
        #                         args    : 2,

        #                         an      : "collection",
        #                         a       : {Block,String,Literal},
        #                         bn      : "number",
        #                         b       : {Integer},
        #                         ret     : {Block,String,Null},
        #                         desc    : "return first <number> of elements from given collection"),

        # opDrop      : OpSpec(   name    : "drop",
        #                         args    : 2,

        #                         an      : "collection",
        #                         a       : {Block,String,Literal},
        #                         bn      : "number",
        #                         b       : {Integer},
        #                         ret     : {Block,String,Null},
        #                         desc    : "drop first <number> of elements from given collection~and return the remaining ones"),

        # opAppend    : OpSpec(   name    : "append",  
        #                         alias   : "++",        
        #                         args    : 2,   

        #                         an      : "collection",      
        #                         a       : {String,Char,Block,Literal},        
        #                         bn      : "value",      
        #                         b       : {Any},
        #                         ret     : {String,Block,Null},               
        #                         desc    : "append value to given collection" ),

        # opRemove    : OpSpec(   name    : "remove",
        #                         alias   : "--",          
        #                         args    : 2,   

        #                         an      : "collection",      
        #                         a       : {String,Block,Dictionary,Literal},        
        #                         bn      : "value",      
        #                         b       : {Any},
        #                         ret     : {String,Block,Dictionary,Null},   
        #                         attrs   :   ".key -> remove dictionary key~" &
        #                                     ".once -> remove only first occurrence~" &
        #                                     ".index :integer -> remove specific index",            
        #                         desc    : "remove value from given collection" ),

        # opCombine   : OpSpec(   name    : "combine",          
        #                         args    : 2,   

        #                         an      : "collection",      
        #                         a       : {Block},  
        #                         bn      : "collection",      
        #                         b       : {Block},        
        #                         ret     : {Block},               
        #                         desc    : "get combination of elements in given collections" ),

        # opList      : OpSpec(   name    : "list",          
        #                         args    : 1,   

        #                         an      : "path",      
        #                         a       : {String},        
        #                         ret     : {Block},  
        #                         attrs   :   ".select :string -> select files satisfying given pattern~" &
        #                                     ".relative -> get relative paths",
        #                         desc    : "get files at given path" ),

        # opFold      : OpSpec(   name    : "fold",          
        #                         args    : 3,   

        #                         an      : "collection",  
        #                         a       : {Block,Literal},              
        #                         bn      : "params",      
        #                         b       : {Literal,Block},            
        #                         cn      : "action",          
        #                         c       : {Block},            
        #                         ret     : {Block,Null},   
        #                         attrs   :   ".seed :any -> use specific seed value~" &
        #                                     ".right -> perform right folding",   
        #                         desc    : "fold collection's items by applying given action~and an initial seed value" ),

        # opSqrt      : OpSpec(   name    : "sqrt",          
        #                         args    : 1,   

        #                         an      : "value",      
        #                         a       : {Integer,Floating},        
        #                         ret     : {Floating},  
        #                         desc    : "get square root of given value" ),

        # opServe     : OpSpec(   name    : "serve",          
        #                         args    : 1,   

        #                         an      : "routes",      
        #                         a       : {Dictionary},        
        #                         ret     : {Null},  
        #                         attrs   :   ".port :integer -> use given port~" &
        #                                     ".verbose -> print info log~" &
        #                                     ".chrome -> open in Chrome window as an app",
        #                         desc    : "start web server using given routes" ),

        # opLet       : OpSpec(   name    : "let",          
        #                         args    : 2,   

        #                         an      : "symbol",      
        #                         a       : {String,Literal},     
        #                         bn      : "value",
        #                         b       : {Any},   
        #                         ret     : {Null},  
        #                         desc    : "set symbol to given value" ),

        # opVar       : OpSpec(   name    : "var",          
        #                         args    : 1,   

        #                         an      : "symbol",      
        #                         a       : {String,Literal},      
        #                         ret     : {Any},  
        #                         desc    : "get symbol value by given name" ),

        # opNow       : OpSpec(   name    : "now",
        #                         args    : 0,

        #                         ret     : {Date},
        #                         desc    : "get date/time now"),

        # opPause     : OpSpec(   name    : "pause",          
        #                         args    : 1,   

        #                         an      : "time",  
        #                         a       : {Integer},                          
        #                         ret     : {Null},      
        #                         desc    : "pause program's execution~for the given amount of milliseconds" ),

        # opCall      : OpSpec(   name    : "call",          
        #                         args    : 2,   

        #                         an      : "function",  
        #                         a       : {String,Literal,Function}, 
        #                         bn      : "params",
        #                         b       : {Block},                        
        #                         ret     : {Any},      
        #                         desc    : "call function with given list of parameters" ),

        # opNew       : OpSpec(   name    : "new",          
        #                         args    : 1,   

        #                         an      : "value",  
        #                         a       : {Any},                        
        #                         ret     : {Any},      
        #                         desc    : "create new value by cloning given one" ),

        # opGetAttrs  : OpSpec(   name    : "attrs",
        #                         args    : 0,

        #                         ret     : {Dictionary},
        #                         desc    : "get dictionary of set attributes"),

        # opUntil     : OpSpec(   name    : "until",        
        #                         args    : 2,   
    
        #                         an      : "action",      
        #                         a       : {Block},      
        #                         bn      : "condition",      
        #                         b       : {Block},  
        #                         ret     : {Null},      
        #                         desc    : "execute action until the given condition is true"),


        # opGlobalize : OpSpec(   name    : "globalize",        
        #                         args    : 0,   
    
        #                         ret     : {Null},      
        #                         desc    : "make all symbols within current context global"),


        # opRelative  : OpSpec(   name    : "relative",   
        #                         alias   : "./",     
        #                         args    : 1,   
    
        #                         an      : "path",
        #                         a       : {String},
        #                         ret     : {String},      
        #                         desc    : "get relative path for given path~based on current script's location"),

        # opAverage   : OpSpec(   name    : "average",        
        #                         args    : 1,   
    
        #                         an      : "collection",
        #                         a       : {Block},
        #                         ret     : {Floating},      
        #                         desc    : "get average from given collection of numbers"),

        # opMedian    : OpSpec(   name    : "median",        
        #                         args    : 1,   
    
        #                         an      : "collection",
        #                         a       : {Block},
        #                         ret     : {Integer,Floating,Null},      
        #                         desc    : "get median from given collection of numbers"),

        # opAs        : OpSpec(   name    : "as",        
        #                         args    : 1,   
    
        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Any},      
        #                         attrs   :   ".binary -> format integer as binary~" &
        #                                     ".hex -> format integer as hexadecimal~" &
        #                                     ".octal -> format integer as octal~" & 
        #                                     ".ascii* -> transliterate string to ASCII~" &
        #                                     ".agnostic -> convert words in block to literals if not in context",
        #                         desc    : "format given value as given type (attribute)"),

        # opGcd       : OpSpec(   name    : "gcd",      
        #                         args    : 1,   

        #                         an      : "numbers",        
        #                         a       : {Block},          
        #                         ret     : {Integer},      
        #                         desc    : "calculate greatest common divisor~for given collection of integers" ),

        # opPrime     : OpSpec(   name    : "prime?",      
        #                         args    : 1,   

        #                         an      : "number",        
        #                         a       : {Integer},          
        #                         ret     : {Boolean},      
        #                         desc    : "check if given integer is prime" ),

        # opPermutate : OpSpec(   name    : "permutate",      
        #                         args    : 1,   

        #                         an      : "collection",        
        #                         a       : {Block},          
        #                         ret     : {Block},      
        #                         desc    : "get all possible permutations~of the elements in given collection" ),

        # opIsWhitespace : OpSpec(   name    : "whitespace?",      
        #                         args    : 1,   

        #                         an      : "string",        
        #                         a       : {String},          
        #                         ret     : {Boolean},      
        #                         desc    : "check if given string consists only of whitespace" ),

        # opIsNumeric : OpSpec(   name    : "numeric?",      
        #                         args    : 1,   

        #                         an      : "string",        
        #                         a       : {String},          
        #                         ret     : {Boolean},      
        #                         desc    : "check if given string contains a valid number" ),

        # opFactors  : OpSpec(   name    : "factors",      
        #                         args    : 1,   

        #                         an      : "number",        
        #                         a       : {Integer},          
        #                         ret     : {Block},      
        #                         attrs   :   ".prime -> get only prime factors",
        #                         desc    : "get list of factors for given integer" ),

        # opMatch     : OpSpec(   name    : "match",      
        #                         args    : 2,   

        #                         an      : "string",        
        #                         a       : {String}, 
        #                         bn      : "regex",        
        #                         b       : {String},          
        #                         ret     : {Block},      
        #                         desc    : "get matches within string~using given regular expression" ),

        # opModule    : OpSpec(   name    : "module",      
        #                         args    : 1,   

        #                         an      : "name",        
        #                         a       : {String,Literal},           
        #                         ret     : {String,Null},      
        #                         desc    : "get module path for given name" ),

        # opWebview   : OpSpec(   name    : "webview*",      
        #                         args    : 2,   

        #                         an      : "content",        
        #                         a       : {String,Literal}, 
        #                         bn      : "callbacks",
        #                         b       : {Dictionary},          
        #                         ret     : {String,Null},  
        #                         attrs   :   ".title :string -> set window title~" &
        #                                     ".width :integer -> set window width~" &
        #                                     ".height :integer -> set window height",   
        #                         desc    : "show webview window with given url or html~and dictionary of callback functions" ),

        # opFlatten   : OpSpec(   name    : "flatten",      
        #                         args    : 1,   

        #                         an      : "collection",  
        #                         a       : {Block},      
        #                         ret     : {Block},   
        #                         desc    : "flatten given collection~by eliminating nested blocks"),

        # opExtra     : OpSpec(),

        # opLevenshtein: OpSpec(  name    : "levenshtein",
        #                         args    : 2,

        #                         an      : "stringA",
        #                         a       : {String},
        #                         bn      : "stringB",
        #                         b       : {String},
        #                         ret     : {Integer},
        #                         desc    : "get the Levenshtein edit distance~between given strings"),

        # opNand      : OpSpec(   name    : "nand?",         
        #                         args    : 2,   

        #                         an      : "valueA",      
        #                         a       : {Boolean},                  
        #                         bn      : "valueB",      
        #                         b       : {Boolean},
        #                         ret     : {Boolean},                        
        #                         desc    : "return the logical NAND for the given values" ),

        # opNor       : OpSpec(   name    : "nor?",         
        #                         args    : 2,   

        #                         an      : "valueA",      
        #                         a       : {Boolean},                  
        #                         bn      : "valueB",      
        #                         b       : {Boolean},
        #                         ret     : {Boolean},                        
        #                         desc    : "return the logical NOR for the given values" ),

        # opXnor      : OpSpec(   name    : "xnor?",         
        #                         args    : 2,   

        #                         an      : "valueA",      
        #                         a       : {Boolean},                  
        #                         bn      : "valueB",      
        #                         b       : {Boolean},
        #                         ret     : {Boolean},                        
        #                         desc    : "return the logical XNOR for the given values" ),

        # opBNand     : OpSpec(   name    : "nand",          
        #                         args    : 2,   

        #                         an      : "valueA",      
        #                         a       : {Integer,Literal},      
        #                         bn      : "valueB",      
        #                         b       : {Integer},
        #                         ret     : {Integer,Null},      
        #                         desc    : "calculate the binary NAND for the given values" ),

        # opBNor      : OpSpec(   name    : "nor",          
        #                         args    : 2,   

        #                         an      : "valueA",      
        #                         a       : {Integer,Literal},      
        #                         bn      : "valueB",      
        #                         b       : {Integer},
        #                         ret     : {Integer,Null},      
        #                         desc    : "calculate the binary NOR for the given values" ),

        # opBXnor     : OpSpec(   name    : "xnor",          
        #                         args    : 2,   

        #                         an      : "valueA",      
        #                         a       : {Integer,Literal},      
        #                         bn      : "valueB",      
        #                         b       : {Integer},
        #                         ret     : {Integer,Null},      
        #                         desc    : "calculate the binary XNOR for the given values" ),

        # opNegative  : OpSpec(   name    : "negative?",        
        #                         args    : 1,   

        #                         an      : "number",      
        #                         a       : {Integer,Floating},      
        #                         ret     : {Boolean},      
        #                         desc    : "check if given number is negative" ),

        # opPositive  : OpSpec(   name    : "positive?",        
        #                         args    : 1,   

        #                         an      : "number",      
        #                         a       : {Integer,Floating},      
        #                         ret     : {Boolean},      
        #                         desc    : "check if given number is positive" ),

        # opZero      : OpSpec(   name    : "zero?",        
        #                         args    : 1,   

        #                         an      : "number",      
        #                         a       : {Integer,Floating},      
        #                         ret     : {Boolean},      
        #                         desc    : "check if given number is zero" ),

        # opPanic     : OpSpec(   name    : "panic",      
        #                         args    : 1,   
      
        #                         an      : "message",
        #                         a       : {String},
        #                         ret     : {Null},    
        #                         attrs   :   ".code :integer -> return given exit code",  
        #                         desc    : "exit program with error message" ),

        # opOpen      : OpSpec(   name    : "open",      
        #                         args    : 1,   
      
        #                         an      : "name",
        #                         a       : {String},
        #                         ret     : {Database},    
        #                         attrs   :   ".sqlite -> support for SQLite databases~" &
        #                                     ".mysql -> support for MySQL databases",  
        #                         desc    : "opens a new database connection and returns database" ),

        # opQuery     : OpSpec(   name    : "query",      
        #                         args    : 2,   
      
        #                         an      : "database",
        #                         a       : {Database},
        #                         bn      : "commands",
        #                         b       : {String,Block},
        #                         ret     : {Null,Block},    
        #                         attrs   :   ".id -> return last insert ID",
        #                         desc    : "execute command or block of commands~in given database and get returned rows" ),

        # opClose     : OpSpec(   name    : "close",      
        #                         args    : 1,   
      
        #                         an      : "database",
        #                         a       : {Database},
        #                         ret     : {Null},    
        #                         desc    : "close given database" ),

        # opNative    : OpSpec(   name    : "native",      
        #                         args    : 2,   
      
        #                         an      : "name",
        #                         a       : {String,Literal},
        #                         bn      : "arguments",
        #                         b       : {Block},
        #                         ret     : {Null},     
        #                         desc    : "execute native function with given arguments" ),

        # opExtract   : OpSpec(   name    : "extract",      
        #                         args    : 1,   
      
        #                         an      : "path",
        #                         a       : {String},
        #                         ret     : {String,Dictionary},
        #                         attrs   :   ".directory -> get path directory~" &
        #                                     ".basename -> get path basename (filename+ext)~" &
        #                                     ".filename -> get path filename~" &
        #                                     ".extension -> get path extension~" &
        #                                     ".scheme -> get scheme field from URL~" &
        #                                     ".host -> get host field from URL~" &
        #                                     ".port -> get port field from URL~" &
        #                                     ".user -> get user field from URL~" &
        #                                     ".password -> get password field from URL~" &
        #                                     ".path -> get path field from URL~" &
        #                                     ".query -> get query field from URL~" &
        #                                     ".anchor -> get anchor field from URL",
        #                         desc    : "extract components from path" ),

        # opZip       : OpSpec(   name    : "zip",      
        #                         args    : 2,   
      
        #                         an      : "destination",
        #                         a       : {String},
        #                         bn      : "files",
        #                         b       : {Block},
        #                         ret     : {Null},
        #                         desc    : "zip given files to file at destination" ),

        # opUnzip     : OpSpec(   name    : "unzip",      
        #                         args    : 2,   
      
        #                         an      : "destination",
        #                         a       : {String},
        #                         bn      : "original",
        #                         b       : {String},
        #                         ret     : {Null},
        #                         desc    : "unzip given archive to destination" ),

        # opGetHash   : OpSpec(   name    : "hash",      
        #                         args    : 1,   
      
        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Integer},
        #                         attrs   :   ".string -> get as a string",
        #                         desc    : "get hash for given value" ),

        # opExtend    : OpSpec(   name    : "extend",      
        #                         args    : 2,   
      
        #                         an      : "parent",
        #                         a       : {Dictionary},
        #                         bn      : "additional",
        #                         b       : {Dictionary},
        #                         ret     : {Dictionary},
        #                         desc    : "get new dictionary by merging given ones" ),
        
        # opIsTrue    : OpSpec(   name    : "true?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Boolean},
        #                         ret     : {Boolean},
        #                         desc    : "returns true if given value is true~otherwise, it returns false"),

        # opIsFalse   : OpSpec(   name    : "false?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Boolean},
        #                         ret     : {Boolean},
        #                         desc    : "returns true if given value is false~otherwise, it returns false"),

        # opIsNull    : OpSpec(   name    : "null?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Boolean},
        #                         desc    : "checks if given value is of type :null"),

        # opIsBoolean : OpSpec(   name    : "boolean?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Boolean},
        #                         desc    : "checks if given value is of type :boolean"),

        # opIsInteger : OpSpec(   name    : "integer?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Boolean},
        #                         desc    : "checks if given value is of type :integer"),

        # opIsFloating: OpSpec(   name    : "floating?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Boolean},
        #                         desc    : "checks if given value is of type :floating"),

        # opIsType    : OpSpec(   name    : "type?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Boolean},
        #                         desc    : "checks if given value is of type :type"),

        # opIsChar    : OpSpec(   name    : "char?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Boolean},
        #                         desc    : "checks if given value is of type :char"),

        # opIsString  : OpSpec(   name    : "string?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Boolean},
        #                         desc    : "checks if given value is of type :string"),

        # opIsWord    : OpSpec(   name    : "word?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Boolean},
        #                         desc    : "checks if given value is of type :word"),

        # opIsLiteral : OpSpec(   name    : "literal?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Boolean},
        #                         desc    : "checks if given value is of type :literal"),

        # opIsLabel   : OpSpec(   name    : "label?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Boolean},
        #                         desc    : "checks if given value is of type :label"),

        # opIsAttribute: OpSpec(  name    : "attribute?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Boolean},
        #                         desc    : "checks if given value is of type :attr"),

        # opIsAttributeLabel: OpSpec(  name    : "attributeLabel?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Boolean},
        #                         desc    : "checks if given value is of type :attrlabel"),

        # opIsPath    : OpSpec(   name    : "path?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Boolean},
        #                         desc    : "checks if given value is of type :path"),

        # opIsPathLabel: OpSpec(  name    : "pathLabel?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Boolean},
        #                         desc    : "checks if given value is of type :pathlabel"),

        # opIsSymbol  : OpSpec(   name    : "symbol?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Boolean},
        #                         desc    : "checks if given value is of type :symbol"),

        # opIsDate    : OpSpec(   name    : "date?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Boolean},
        #                         desc    : "checks if given value is of type :date"),

        # opIsBinary  : OpSpec(   name    : "binary?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Boolean},
        #                         desc    : "checks if given value is of type :binary"),

        # opIsDictionary: OpSpec( name    : "dictionary?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Boolean},
        #                         desc    : "checks if given value is of type :dictionary"),

        # opIsFunction: OpSpec(   name    : "function?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Boolean},
        #                         desc    : "checks if given value is of type :function"),

        # opIsInline  : OpSpec(   name    : "inline?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Boolean},
        #                         desc    : "checks if given value is of type :inline"),

        # opIsBlock   : OpSpec(   name    : "block?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Boolean},
        #                         desc    : "checks if given value is of type :block"),

        # opIsDatabase: OpSpec(   name    : "database?",
        #                         args    : 1,

        #                         an      : "value",
        #                         a       : {Any},
        #                         ret     : {Boolean},
        #                         desc    : "checks if given value is of type :database"),

        # opBreak     : OpSpec(   name    : "break",
        #                         args    : 0,

        #                         ret     : {Null},
        #                         desc    : "break out of current block or loop"),

        # opContinue  : OpSpec(   name    : "continue",
        #                         args    : 0,

        #                         ret     : {Null},
        #                         desc    : "immediately continue with next iteration"),

        # opIsStandalone  : OpSpec(   name    : "standalone?",
        #                         args    : 0,

        #                         ret     : {Boolean},
        #                         desc    : "check if current script runs from command-line"),

        # opPi        : OpSpec(   name    : "pi",      
        #                         args    : 0,   
   
        #                         ret     : {Floating},      
        #                         desc    : "get the Pi (π) constant"),

        # opIsContains: OpSpec(   name    : "contains?",        
        #                         args    : 2,   

        #                         an      : "collection",
        #                         a       : {String,Block,Dictionary},
        #                         bn      : "value",
        #                         b       : {Any},
        #                         ret     : {Boolean},    
        #                         attrs   :   ".regex -> match against a regular expression", 
        #                         desc    : "check if collection contains given value" ),

    ]

    NoTranslation*  = (@[],@[])

#=======================================
# Methods
#=======================================

proc writeBytecode*(trans: Translation, target: string): bool =
    let marshaled = $$(trans[0])
    let bcode = trans[1]

    var f = newFileStream(target, fmWrite)
    if not f.isNil:
        f.write(len(marshaled))
        f.write(marshaled)
        f.write(len(bcode))
        for b in bcode:
            f.write(b)
        f.flush

        return true
    else:
        return false

proc readBytecode*(origin: string): Translation =
    var f = newFileStream(origin, fmRead)
    if not f.isNil:
        var s: int
        f.read(s)           # read constants size
        var t: string
        f.readStr(s,t)      # read the marshaled constants

        f.read(s)           # read bytecode size

        var bcode: ByteArray = newSeq[byte](s)
        var indx = 0
        while not f.atEnd():
            bcode[indx] = f.readUint8()         # read bytes one-by-one
            indx += 1

        return (t.to[:ValueArray], bcode)       # return the Translation

proc hash*(x: OpCode): Hash {.inline.}=
    cast[Hash](ord(x))
