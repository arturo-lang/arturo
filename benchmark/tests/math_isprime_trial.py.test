maxLimit = 10000

def isPrime(a):
    if a == 2: return True
    if a < 2 or a % 2 == 0: return False
    return not any(a % x == 0 for x in xrange(3, int(a**0.5) + 1, 2))

for n in range(maxLimit):
	print "true" if isPrime(n) else "false"