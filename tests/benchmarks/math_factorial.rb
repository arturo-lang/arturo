maxLimit = 1000

def factorial(x)
	if x>0
		return x * factorial(x-1)
	else
		return 1
	end
end

(0..maxLimit).each{|n|
	puts factorial(n)
}
