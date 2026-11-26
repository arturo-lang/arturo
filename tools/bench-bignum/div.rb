a = 3**300; b = 7**100; y = nil
(1..1000000).each { |k| y = a / b }
puts y
