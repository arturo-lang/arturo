══╡ Type Error ╞══════════════════════════════════════════════════════════════════════════════════════════ <script> ══

  Erroneous type found

  Cannot call function:
      map collection params condition ◄
  
  Wrong argument (at position 2): 
      3 :integer
  
  Expected: 
      :null, :literal, :block

  ┃ File: tests/errors/runtime.WrongArgumentType.1.art
  ┃ Line: 3
  ┃ 
  ┃    1 ║  print
  ┃    2 ║      map
  ┃    3 ║►         1..2
  ┃    4 ║              3 
  ┃    5 ║                  4