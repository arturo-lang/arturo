proc fibonacci { numero } {
    if {$numero < 2} {
        return 1
    } else {
        set resultado [expr [fibonacci [expr $numero - 1 ]] + [fibonacci [expr $numero - 2 ]]]
        return $resultado
    }
}
set maxLimit 28

for {set i 0} {$i <= $maxLimit} {incr i} {
    puts [fibonacci $i]
} 