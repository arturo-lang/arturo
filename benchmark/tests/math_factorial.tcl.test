proc fac {n} {
    if { $n == 0 } {
        return 1
    } else {
        return [expr {$n*[fac [expr {$n-1}]]}]
    }
}

set maxLimit 1000

for {set i 0} {$i <= $maxLimit} {incr i} {
    puts [fac $i]
} 