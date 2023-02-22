#import std/logging
# var logger = newConsoleLogger()

proc distribute[T](container: seq[T], size: int): seq[seq[T]] =
    ## Distributes elements in subSequences of maximum `size`
    var
        count: int = 0
        current: seq[T] = @[]

    for element in container:
        if count != 0 and count mod size == 0:
            result.add current
            current = @[]
            count.inc()
        else:
            current.add element
            count.inc()


proc medianOfMedians*[T](container: seq[T], middle: int): T =
    ## medianOfMedians returns the smallest nth number of a container

    #[
        Steps:
            1. Divide the container into sublists of a maximum of length x,
            let's say... 5
            2. Sort each sublist and determine the median
            3. Use the same function recursively to determine the median of the set
            4. Use this median as pivot element
            5. Partition the elements into right, left
            6. Do this comparation:
                - if i = k -> x
                - if i < k -> recuse using A[1, ..., k-1, i]
                - if i > k -> recurse using A[k+1, ...,i], i-k]

        » Read more on: https://brilliant.org/wiki/median-finding-algorithm/
    ]#

    const tiny = 5

    if container.len <= tiny:
        return container.sorted()[middle]

    var
        subLists: seq[seq[T]] = container.distribute(tiny)
        medians: seq[T]

    for list in subLists:
        medians.add list.medianOfMedians(list.len div 2)

    var pivot: T
    if medians.len <= tiny:
        pivot = medians.sorted()[medians.len div 2]
    else:
        pivot = medians.medianOfMedians(medians.len div 2)

    var
        left, right: seq[T]

    for element in container:
        if element > pivot: right.add element
        elif element < pivot: left.add element

    if middle < left.len:
        return left.medianOfMedians(middle)
    elif middle > left.len:
        return right.medianOfMedians(middle - left.len - 1)
    else:
        return pivot
