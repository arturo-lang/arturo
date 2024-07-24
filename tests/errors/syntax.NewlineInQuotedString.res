══╡ Syntax Error ╞════════════════════════════════════════════════════════════════════════════════════════ <script> ══

  Unable to parse input code

  Issue found when trying to parse:
      String
  
  Quoted string contains:
      newline (`\n`)

  ┃ File: tests/errors/syntax.NewlineInQuotedString.art
  ┃ Line: 4
  ┃ 
  ┃    2 ║      done
  ┃    3 ║  }
  ┃    4 ║► this "something else
  ┃    5 ║  
  ┃    6 ║  "

  Hint: For multiline strings, you could use either: curly blocks `{..}` or triple `-`
        templates