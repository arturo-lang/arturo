package require struct::list

proc bubblesort {A} {
    set len [llength $A]
    set swapped true
    while {$swapped} {
        set swapped false
        for {set i 0} {$i < $len - 1} {incr i} {
            set j [expr {$i + 1}]
            if {[lindex $A $i] > [lindex $A $j]} {
                struct::list swap A $i $j
                set swapped true
            }
        }
        incr len -1
    }
    return $A
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

set lst [shuffle [iota 2000]]
set lst [bubblesort $lst]
for {set i 0} {$i < 2000} {incr i} {
    puts [lindex $lst $i]
} 