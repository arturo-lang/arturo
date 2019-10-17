import random

def bubblesort(seq):

    changed = True
    while changed:
        changed = False
        for i in xrange(len(seq) - 1):
            if seq[i] > seq[i+1]:
                seq[i], seq[i+1] = seq[i+1], seq[i]
                changed = True
    return seq


list = range(1,2000+1)
random.shuffle(list)

bubblesort(list)

for i in list:
	print i