<?php

function bubbleSort(array &$array) {
  $c = count($array) - 1;
  do {
    $swapped = false;
    for ($i = 0; $i < $c; ++$i) {
      if ($array[$i] > $array[$i + 1]) {
        list($array[$i + 1], $array[$i]) =
                array($array[$i], $array[$i + 1]);
        $swapped = true;
      }
    }
  } while ($swapped);
  return $array;
}
 
$arr = range(1, 2000);
shuffle($arr);
$arr = bubbleSort($arr);

foreach ($arr as $a) {
	echo $a."\n";
}

?>