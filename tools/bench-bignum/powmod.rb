m = 2**127 - 1; y = nil
(1..200000).each { |k| y = 3.pow(k, m) }
puts y
