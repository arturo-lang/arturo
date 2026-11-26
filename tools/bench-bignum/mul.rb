a = 3**150; b = 7**140; y = nil
(1..1000000).each { |k| y = a * b }
puts y.to_s.size
