import strutils
import utils

benchmark "doSth":
    for i in 1..100_000_000:
        var a = i*10000
