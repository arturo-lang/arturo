[ :point
        init      :        (x, y) :method
        toString  :        () :method
        x         :        10.0 :floating
        y         :        20.0 :floating
]
[ :circle
        init      :        (center, radius) :method
        toString  :        () :method
        center    :        [ :point
                init      :                (x, y) :method
                toString  :                () :method
                x         :                10.0 :floating
                y         :                20.0 :floating
        ]
        radius    :        10.0 :floating
]
point (x: 10.0, y: 20.0)
circle (center: point (x: 10.0, y: 20.0), radius: 10.0)