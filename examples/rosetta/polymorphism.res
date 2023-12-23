[ :point
        init    :        (x, y) :method
        string  :        () :method
        x       :        10.0 :floating
        y       :        20.0 :floating
]
[ :circle
        init    :        (center, radius) :method
        string  :        () :method
        center  :        [ :point
                init    :                (x, y) :method
                string  :                () :method
                x       :                10.0 :floating
                y       :                20.0 :floating
        ]
        radius  :        10.0 :floating
]
point (x: 10.0, y: 20.0)
circle (center: point (x: 10.0, y: 20.0), radius: 10.0)