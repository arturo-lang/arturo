s = Rational(1, 2**64 + 1)
(1..25000).each { |k| s += Rational(1, k) }
puts s.denominator.to_s.size
