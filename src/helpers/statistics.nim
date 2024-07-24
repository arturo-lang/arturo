#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos &
#               Arturo contributors
#
# @file: helpers/statistics.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import std/random

#=======================================
# Methods
#=======================================

proc quickSelect*[T](container: seq[T], index: int): T =
    ## return the smallest `index`th number of a container

    #[
        Steps:
            1. check the container's length to use a faster algorithm
                to its size
            2. get a pivot using a random algorithm
            3. partion elements into lower, higher or same value as pivot
            4. Divide to conquer using these partitions and recursion
        Inspired from: https://rcoh.me/posts/linear-time-median-finding/
        by Russell Cohen <https://github.com/rcoh>
    ]#

    if container.len == 1:
        assert index == 0
        return container[0]
    elif container.len < 6:
        return container.sorted()[index]

    var
        pivot: T = container.sample()
        left, right, same: seq[T]

    for element in container:
        if element > pivot: right.add element
        elif element == pivot: same.add element
        else: left.add element

    if index < left.len:
        return left.quickSelect(index)
    elif index < left.len + same.len:
        return same[0]
    else:
        return right.quickSelect(index - left.len - same.len)
        
