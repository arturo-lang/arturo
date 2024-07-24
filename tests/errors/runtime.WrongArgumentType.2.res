3

══╡ Type Error ╞══════════════════════════════════════════════════════════════════════════════════════════ <script> ══

  Erroneous type found

  Cannot call function:
      add valueA valueB ◄
  
  Wrong argument (at position 2): 
      done :string
  
  Expected: 
      :integer, :floating, :complex, :rational, :quantity, :color, :object

  ┃ File: tests/errors/runtime.WrongArgumentType.2.art
  ┃ Line: 5
  ┃ 
  ┃    3 ║  
  ┃    4 ║  ; adding something else
  ┃    5 ║► print add 1 "done"