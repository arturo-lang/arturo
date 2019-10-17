<?php

function quicksort($arr){
	$lte = $gt = array();
	if(count($arr) < 2){
		return $arr;
	}
	$pivot_key = key($arr);
	$pivot = array_shift($arr);
	foreach($arr as $val){
		if($val <= $pivot){
			$lte[] = $val;
		} else {
			$gt[] = $val;
		}
	}
	return array_merge(quicksort($lte),array($pivot_key=>$pivot),quicksort($gt));
}
 
$arr = range(1, 50000);
shuffle($arr);
$arr = quicksort($arr);

foreach ($arr as $a) {
	echo $a."\n";
}

?>