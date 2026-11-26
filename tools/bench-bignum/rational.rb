a = Rational(2**100, 3**70); b = Rational(7**40, 5**60); y = nil
(1..200000).each { |k| y = a + b }
puts y.to_s.size
