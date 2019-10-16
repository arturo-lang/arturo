function isPrime(n)
	if (n<2) then
		return false
	end

    for i = 2, n^(1/2) do
        if (n % i) == 0 then
            return false
        end
    end
    return true
end

maxLimit=5000

for var=0,maxLimit do
	print(isPrime(var))
end