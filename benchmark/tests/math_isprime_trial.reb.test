REBOL [
    Title:  "Whatever"
    Date:   2-Feb-2000
    File:   %whatever.reb
    Author: "Whatever"
    Version: 1.2.3
]

prime?: func [n] [
    case [
        n = 2 [ true  ]
        n <= 1 or (n // 2 = 0) [ false ]
        true [
            for i 3 round square-root n 2 [
                if n // i = 0 [ return false ]
            ]
            true
        ]
    ]
]

maxLimit: 10000

for i 0 maxLimit - 1 1 [
    print prime? i
]