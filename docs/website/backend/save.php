<?php
// =============================================================================
// SAVE SNIPPET ENDPOINT
// =============================================================================
// Handles creating new snippets or updating owned snippets

header('Access-Control-Allow-Origin: http://188.245.97.105');
header('Content-Type: application/json');

$rest_json = file_get_contents("php://input");
$_POST = json_decode($rest_json, true);

require_once __DIR__ . '/db.php';
$db = new SnippetDB();

$code = $_POST['c'] ?? '';
$snippet_id = $_POST['i'] ?? '';

if (empty($code)) {
    echo json_encode([
        "success" => false,
        "error" => "No code provided"
    ]);
    exit;
}

// SIZE LIMIT CHECK
define('MAX_CODE_SIZE', 10000);
if (strlen($code) > MAX_CODE_SIZE) {
    echo json_encode([
        "success" => false,
        "error" => "Code exceeds maximum size limit (" . number_format(MAX_CODE_SIZE) . " characters)"
    ]);
    exit;
}

// If ID provided, update existing snippet
// If no ID, generate new one
if (!empty($snippet_id)) {
    $id = $snippet_id;
} else {
    $id = $db->generateUniqueId();
}

$result = $db->save($id, $code);

if ($result) {
    echo json_encode([
        "success" => true,
        "id" => $id
    ]);
} else {
    echo json_encode([
        "success" => false,
        "error" => "Failed to save snippet"
    ]);
}

// Occasionally cleanup old snippets (1% chance)
if (rand(1, 100) === 1) {
    $db->cleanup();
}
?>