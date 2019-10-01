<?php
$maxLimit = 1000;

function factorial($x) {
	return array_product(range(1,$x));
}

foreach (range(0,$maxLimit+1) as $n) {
	echo factorial($n)."\n";
}
?>