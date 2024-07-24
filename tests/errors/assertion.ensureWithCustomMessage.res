══╡ Assertion Error ╞═════════════════════════════════════════════════════════════════════════════════════ <script> ══

  Runtime check failed

  Unable to ensure:
      Wrong calc
  
  Tried: 
      [0 = 1 + 1]

  ┃ File: tests/errors/assertion.ensureWithCustomMessage.art
  ┃ Line: 2
  ┃ 
  ┃    1 ║  ensure.that: "Wrong calc" -> 0 = 1 - 1
  ┃    2 ║► ensure.that: "Wrong calc" -> 0 = 1 + 1
  ┃    3 ║