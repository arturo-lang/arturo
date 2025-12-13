<?php
header('Access-Control-Allow-Origin: http://188.245.97.105');
header('Content-Type: application/json');

$rest_json = file_get_contents("php://input");
$_POST = json_decode($rest_json, true);

// Validate JSON decode
if (!is_array($_POST)) {
    $_POST = [];
}

require_once __DIR__ . '/db.php';
$db = new SnippetDB();

$snippet_id = $_POST['i'] ?? '';
$code = $db->get($snippet_id);

if ($code !== null) {
    echo json_encode(["text" => $code]);
} else {
    echo json_encode(["text" => "# Snippet not found"]);
}
?>