function fibo(n)
    if (n<2) then
        return 1
    else
        return fibo(n-1) + fibo(n-2)
    end
end

maxLimit=28

for var=0,maxLimit do
	print(fibo(var))
end