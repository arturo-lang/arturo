<?php
$maxLimit = 5000;

function isPrime($x) {
	if ($x<2) { return false; }
	foreach (range(2,$x-1) as $y) {
		if ($x%$y==0) { return false; }
	}
	return true;
}

foreach (range(0,$maxLimit+1) as $n) {
	echo (isPrime($n)? 'true' : 'false')."\n";
}
?>