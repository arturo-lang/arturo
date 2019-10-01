<?php
$maxLimit = 37;

function fibo($x) {
	if ($x<2) { return 1; }
	else { return fibo($x-1) + fibo($x-2); }
}

foreach (range(0,$maxLimit+1) as $n) {
	echo fibo($n)."\n";
}
?>