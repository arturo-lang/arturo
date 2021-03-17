maxLimit = 28

def fibo(x):
	if (x<2):
		return 1
	else:
		return fibo(x-1) + fibo(x-2)

for n in range(maxLimit+1):
	print fibo(n)
