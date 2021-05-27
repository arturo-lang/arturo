>> Runtime | File: trace-vm.art
     error | Line: 2
           | 
           | uncaught system exception:
           | division by zero

>>   Trace | 2> print x/0
           | 6> print ["fun" z "->" fun z]
           | 6> print ["fun" z "->" fun z]
           | 5> loop [10 9 8 7 6 5 4] 'z [

>>      VM | EOL
           | CONSTI0
           | CONSTI2
           | CONSTI0
           | LOAD2
           | CALL1
           | CALL0
           | EOL
           | CONSTI0
           | CONSTI3
           | END