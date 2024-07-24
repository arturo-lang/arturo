true
false

══╡ Conversion Error ╞════════════════════════════════════════════════════════════════════════════════════ <script> ══

  Problem when converting value to given type

  Got value:
      boom :string
  
  Failed while trying to convert to:
      :logical

  ┃ File: tests/errors/runtime.ConversionFailed.art
  ┃ Line: 3
  ┃ 
  ┃    1 ║  print to :logical "true"
  ┃    2 ║  print to :logical "false"
  ┃    3 ║► print to :logical "boom"

  Hint: Make sure the passed string contains one of the supported values: `true`, `false`, or
        `maybe`.