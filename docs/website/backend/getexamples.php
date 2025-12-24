<?php
header('Access-Control-Allow-Origin: http://188.245.97.105');
header('Content-Type: application/json');

$examples_dir = __DIR__ . '/../examples';
$files = glob($examples_dir . '/*.art');

$examples = array_map(function($file) {
    return basename($file, '.art');
}, $files);

sort($examples);

echo json_encode($examples);
?>