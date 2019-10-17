import random

def qsort(list):
    if not list:
        return []
    else:
        pivot = list[0]
        less = [x for x in list     if x <  pivot]
        more = [x for x in list[1:] if x >= pivot]
        return qsort(less) + [pivot] + qsort(more)


list = range(1,50000+1)
random.shuffle(list)

list = qsort(list)

for i in list:
	print i

