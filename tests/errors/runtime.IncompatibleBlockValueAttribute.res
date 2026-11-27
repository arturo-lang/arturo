[name:a p:1] [name:b p:2] 

══╡ Type Error ╞════════════════════════════════════════════════════ <script> ══

  Erroneous type found

  Cannot perform: 
      sort .by
  
  Incompatible value inside block:
      [:string...]
  
  Expected: 
      :dictionary :object

  ┃ File: tests/errors/runtime.IncompatibleBlockValueAttribute.art
  ┃ Line: 4
  ┃ 
  ┃    2 ║  print sort.by:'p tasks
  ┃    3 ║  
  ┃    4 ║► print sort.by:'size ["aa" "b"]
  ┃    5 ║  

