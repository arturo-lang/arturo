<?php
// =============================================================================
// SAVE SNIPPET ENDPOINT
// =============================================================================
// Handles creating new snippets or updating owned snippets

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

$code = $_POST['c'] ?? '';
$snippet_id = $_POST['i'] ?? '';
$ip = $_SERVER['REMOTE_ADDR'] ?? 'unknown';

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

// Determine the ID to use with security checks
$was_forked = false;
if (!empty($snippet_id)) {
    // User wants to update existing snippet - verify ownership
    if ($db->exists($snippet_id)) {
        $creator_ip = $db->getCreatorIp($snippet_id);
        
        // Only allow update if IP matches creator
        if ($creator_ip === $ip) {
            $id = $snippet_id;
        } else {
            // IP doesn't match - force fork (new snippet)
            $id = $db->generateUniqueId();
            $was_forked = true;
        }
    } else {
        // Snippet doesn't exist - create new one with requested ID
        $id = $snippet_id;
    }
} else {
    // No ID provided - generate new one
    $id = $db->generateUniqueId();
}

$result = $db->save($id, $code, $ip);

if ($result) {
    echo json_encode([
        "success" => true,
        "id" => $id,
        "forked" => $was_forked
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