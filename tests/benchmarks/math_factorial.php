<?php
$maxLimit = 1000;

function factorial($x) {
	if ($x>0) { return $x * factorial($x-1); }
	else { return 1; }
}

foreach (range(0,$maxLimit+1) as $n) {
	echo factorial($n)."\n";
}
?>