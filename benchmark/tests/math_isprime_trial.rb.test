def prime(a)
  if a == 2
    true
  elsif a <= 1 || a % 2 == 0
    false
  else
    divisors = (3..Math.sqrt(a)).step(2)
    divisors.none? { |d| a % d == 0 }
  end
end

maxLimit = 10000

(0..maxLimit-1).each{|n|
	puts prime(n)
}