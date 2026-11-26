a = 3**500; y = nil
(1..300000).each { |k| y = a.to_s }
puts y.size
