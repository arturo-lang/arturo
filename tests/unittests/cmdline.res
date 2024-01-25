----------------------------------------------------------------------
 test: input1 
 args: tests/unittests/cmdline/inspectArgs.art 
----------------------------------------------------------------------
[ :block

]
[ :dictionary
        values  :        [ :block

        ]
]
----------------------------------------------------------------------
 test: input2 
 args: tests/unittests/cmdline/inspectArgs.art 1 2 3 
----------------------------------------------------------------------
[ :block
        1 :string
        2 :string
        3 :string
]
[ :dictionary
        values  :        [ :block
                1 :integer
                2 :integer
                3 :integer
        ]
]
----------------------------------------------------------------------
 test: input3 
 args: tests/unittests/cmdline/inspectArgs.art one two three 
----------------------------------------------------------------------
[ :block
        one :string
        two :string
        three :string
]
[ :dictionary
        values  :        [ :block
                one :string
                two :string
                three :string
        ]
]
----------------------------------------------------------------------
 test: input4 
 args: tests/unittests/cmdline/inspectArgs.art one 2 three 4.0 
----------------------------------------------------------------------
[ :block
        one :string
        2 :string
        three :string
        4.0 :string
]
[ :dictionary
        values  :        [ :block
                one :string
                2 :integer
                three :string
                4.0 :floating
        ]
]
----------------------------------------------------------------------
 test: input5 
 args: tests/unittests/cmdline/inspectArgs.art -a main 
----------------------------------------------------------------------
[ :block
        -a :string
        main :string
]
[ :dictionary
        a       :        true :logical
        values  :        [ :block
                main :string
        ]
]
----------------------------------------------------------------------
 test: input6 
 args: tests/unittests/cmdline/inspectArgs.art -c -b --name:Rick 
----------------------------------------------------------------------
[ :block
        -c :string
        -b :string
        --name:Rick :string
]
[ :dictionary
        c       :        true :logical
        b       :        true :logical
        name    :        Rick :string
        values  :        [ :block

        ]
]