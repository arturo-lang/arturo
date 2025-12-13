<?php
// =============================================================================
// VISIT TRACKING ENDPOINT
// =============================================================================
// Records when a snippet is viewed and checks IP ownership

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
$visitor_ip = $_SERVER['REMOTE_ADDR'] ?? 'unknown';

if (empty($snippet_id)) {
    echo json_encode(["success" => false]);
    exit;
}

$result = $db->recordVisit($snippet_id);
$creator_ip = $db->getCreatorIp($snippet_id);

$ip_match = ($creator_ip !== null && $creator_ip === $visitor_ip);

echo json_encode([
    "success" => $result,
    "ip_match" => $ip_match
]);
?>