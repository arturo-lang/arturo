maxLimit = 1000

def product(array)
  	final = 1
  	array.each { |i| final *= i }
  	final
end

def factorial(x)
	return product((1..x))
end

(0..maxLimit).each{|n|
	puts factorial(n)
}
