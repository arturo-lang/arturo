<?php
$maxLimit = 5000;

function is_prime($number)
{
    // 1 is not prime
    if ( $number <= 1 ) {
        return false;
    }
    // 2 is the only even prime number
    if ( $number == 2 ) {
        return true;
    }
    // square root algorithm speeds up testing of bigger prime numbers
    $x = sqrt($number);
    $x = floor($x);
    for ( $i = 2 ; $i <= $x ; ++$i ) {
        if ( $number % $i == 0 ) {
            break;
        }
    }
 
    if( $x == $i-1 ) {
        return true;
    } else {
        return false;
    }
}

foreach (range(0,$maxLimit) as $n) {
	echo (is_prime($n)? 'true' : 'false')."\n";
}
?>