import sympy 

maxLimit = 5000

def isPrime(x):
	if x<2:
		return False
	if x==2:
		return True

	for n in range(3,x-1):
		if x%n==0:
			return False

	return True

for n in range(maxLimit+1):
	print "true" if sympy.isprime(n) else "false"