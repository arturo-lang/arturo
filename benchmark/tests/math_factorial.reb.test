REBOL [
    Title:  "Whatever"
    Date:   2-Feb-2000
    File:   %whatever.reb
    Author: "Whatever"
    Version: 1.2.3
]
maxLimit: 1000

factorial: func [n][
	either n > 1 [n * factorial n - 1] [1]
]

for i 0 maxLimit 1 [
	print factorial i
]