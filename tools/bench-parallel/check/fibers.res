
>> leftovers on a (reused) stack don't leak into the next fiber
3000 4501500 
3000 9003000 

>> deep recursion inside fibers (on reused stacks)
51 50 14900 

>> many fibers suspended at once
3000 13504500 3 9000 

>> capped, suspending
1000 500500 true 

>> rounds of fan-out
1494000

>> nested
20 267750 
21000

>> errors inside fibers
500 71 
125250

>> values made inside fibers outlive them
2686700 40200 
500
111 100100100 
HÉLLO WÖRLD

>> select / every? / some? / sort / group
1666
true
true
false
true
true
true
true
true
[x:0]
10
76

>> loop.parallel & .with
0
8999900

>> tasks: cancel after done, cancel pending, wait.first
42
42
null
20
5050

>> channels
500 125250 

>> events from fibers
5050 100 5050 

>> finally, a big one
20000 200010000 
