<?php
header('Access-Control-Allow-Origin: http://188.245.97.105');
header('Content-Type: application/json');

$rest_json = file_get_contents("php://input");
$_POST = json_decode($rest_json, true);

// Validate JSON decode
if (!is_array($_POST)) {
    $_POST = [];
}

$example_name = $_POST['i'] ?? '';

// Decode it first
$example_name = urldecode($example_name);

// SECURITY: Prevent path traversal attacks
if (preg_match('/[^a-zA-Z0-9_\-\' +^]/', $example_name)) {
    echo json_encode(["text" => "# Invalid example name"]);
    exit;
}

// Use basename as additional safety layer
$example_name = basename($example_name);

// Construct the file path
$example_file = __DIR__ . '/../examples/' . $example_name . '.art';

$txt = "";
if (file_exists($example_file)) {
    $txt = file_get_contents($example_file);
} else {
    $txt = "# Example not found: " . htmlspecialchars($example_name);
}

echo json_encode(["text" => $txt]);
?>