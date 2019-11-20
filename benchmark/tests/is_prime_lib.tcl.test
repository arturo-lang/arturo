proc isprime n {
    set max [expr wide(sqrt($n))]
    if {$n<2} {return false}
    if {$n==2} {return true}
    if {$n%2==0} {return false}
    for {set i 3} {$i<=$max} {incr i 2} {
        if {$n%$i==0} {return false}
    }
    return true
}

set maxLimit 5000

for {set i 0} {$i <= $maxLimit} {incr i} {
    puts [isprime $i]
} 