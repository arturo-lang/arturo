maxLimit = 5000

def isPrime(x):
	if x<2:
		return False

	for n in range(2,x-1):
		if x%n==0:
			return False

	return True

for n in range(maxLimit+1):
	print isPrime(n)