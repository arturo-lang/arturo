zero
one

══╡ Index Error ╞═════════════════════════════════════════════════════════════════════════════════════════ <script> ══

  Cannot resolve requested index

  Index out of bounds: 
      5
  
  For value:
      [ :block
              zero :string
              one :string
              two :string
              three :string
      ...

  ┃ File: tests/errors/runtime.OutOfBounds.art
  ┃ Line: 5
  ┃ 
  ┃    3 ║  print arr\0
  ┃    4 ║  print arr\1
  ┃    5 ║► print arr\5
  ┃    6 ║  print arr\2
  ┃    7 ║  print arr\3

  Hint: Given Block contains 4 items; so, a valid index should fall within 0..3