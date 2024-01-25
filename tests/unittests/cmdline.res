----------------------------------------------------------------------
 test: input1 
----------------------------------------------------------------------
[ :block

]
[ :dictionary
        values  :        [ :block

        ]
]

----------------------------------------------------------------------
 test: input2 
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