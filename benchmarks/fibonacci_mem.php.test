<?php
$maxLimit = 5000;

$memoize = function($func)
{
    return function() use ($func)
    {
        static $cache = [];

        $args = func_get_args();
        $key = md5(serialize($args));

        if ( ! isset($cache[$key])) {
            $cache[$key] = call_user_func_array($func, $args);
        }

        return $cache[$key];
    };
};

$fibo = $memoize(function($n) use (&$fibo)
{
    return ($n < 2) ? $n : $fibo($n - 1) + $fibo($n - 2);
});

foreach (range(0,$maxLimit+1) as $n) {
	echo $fibo($n)."\n";
}
?>