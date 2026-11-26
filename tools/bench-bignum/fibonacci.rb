a = 0; b = 1
(1..400000).each { |k| t = a + b; a = b; b = t }
puts a.to_s.size
