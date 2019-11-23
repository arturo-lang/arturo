REBOL [
    Title:  "Whatever"
    Date:   2-Feb-2000
    File:   %whatever.reb
    Author: "Whatever"
    Version: 1.2.3
]
maxLimit: 28

fib: func [x][
	either x < 1 [1][(fib x - 1) + (fib x - 2)]
]

for i 0 maxLimit - 1 1 [
	print fib i
]