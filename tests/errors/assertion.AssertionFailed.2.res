doing sth: 12 

══╡ Assertion Error ╞══════════════════════════════════════════════════════════════════════════════════════ <script> ══

  Runtime check failed

  Tried:
      [integer? x]

  ┃ File: tests/errors/assertion.AssertionFailed.2.art
  ┃ Line: 2
  ┃ 
  ┃    1 ║  doSth: function [x][
  ┃    2 ║►     ensure -> integer? x
  ┃    3 ║      return x+10
  ┃    4 ║  ]