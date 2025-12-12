<?php
// =============================================================================
// VISIT TRACKING ENDPOINT
// =============================================================================
// Records when a snippet is viewed (not executed)

header('Access-Control-Allow-Origin: http://188.245.97.105');
header('Content-Type: application/json');

$rest_json = file_get_contents("php://input");
$_POST = json_decode($rest_json, true);

require_once __DIR__ . '/db.php';
$db = new SnippetDB();

$snippet_id = $_POST['i'] ?? '';

if (empty($snippet_id)) {
    echo json_encode(["success" => false]);
    exit;
}

$result = $db->recordVisit($snippet_id);

echo json_encode(["success" => $result]);
?>