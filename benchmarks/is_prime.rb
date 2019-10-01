maxLimit = 5000

def isPrime(x)
	if x<2
		return false
	end
	(2..x-1).each{|n|
		if x%n==0
			return false
		end
	}
	return true
end

(0..maxLimit).each{|n|
	puts isPrime(n)
}