proc quicksort {m} {
    if {[llength $m] <= 1} {
        return $m
    }
    set pivot [lindex $m 0]
    set less [set equal [set greater [list]]]
    foreach x $m {
        lappend [expr {$x < $pivot ? "less" : $x > $pivot ? "greater" : "equal"}] $x
    }
    return [concat [quicksort $less] $equal [quicksort $greater]]
}

proc iota { n } {
	for { set i 1 } { $i <= $n } { incr i } {
	  lappend retval $i
	}
	return $retval
}

proc shuffle { list } {
	set n [llength $list]
	for { set i 0 } { $i < $n } { incr i } {
		set j [expr {int(rand()*$n)}]
		set temp [lindex $list $j]
		set list [lreplace $list $j $j [lindex $list $i]]
		set list [lreplace $list $i $i $temp]
	}
	return $list
}

set lst [shuffle [iota 50000]]
set lst [quicksort $lst]
for {set i 0} {$i < 50000} {incr i} {
    puts [lindex $lst $i]
} 