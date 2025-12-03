<?php
header('Access-Control-Allow-Origin: http://188.245.97.105');
header('Content-Type: application/json');

$rest_json = file_get_contents("php://input");
$_POST = json_decode($rest_json, true);
$code = $_POST['c'];

if (empty($code)) {
    echo json_encode(["text" => "No code provided", "code" => "", "result" => -1]);
    exit;
}

// SIZE LIMIT CHECK
define('MAX_CODE_SIZE', 10000); // 10KB limit (~300 lines)
if (strlen($code) > MAX_CODE_SIZE) {
    echo json_encode([
        "text" => "Error: Code exceeds maximum size limit (" . number_format(MAX_CODE_SIZE) . " characters)",
        "code" => "",
        "result" => -1
    ]);
    exit;
}

// Automatically determine version from path
$version = basename(dirname(__DIR__));
$template_name = "arturo_runner_" . $version;

// Generate unique ID
require_once __DIR__ . '/db.php';
$db = new SnippetDB();
$exec_id = !empty($_POST['i']) ? $_POST['i'] : $db->generateUniqueId();
$jail_name = "arturo_" . preg_replace('/[^a-zA-Z0-9]/', '_', $exec_id);
$jail_path = "/zroot/jails/run/" . $jail_name;

// Save snippet to database
$db->save($exec_id, $code);

// Occasionally cleanup old snippets (1% chance)
if (rand(1, 100) === 1) {
    $db->cleanup();
}

// Clone template jail
exec("sudo /sbin/zfs clone zroot/jails/{$template_name}@clean zroot/jails/run/$jail_name 2>&1", $clone_out, $clone_ret);

if ($clone_ret !== 0) {
    $error_msg = "Failed to clone jail for version '$version' (template: $template_name): " . implode("\n", $clone_out);
    error_log($error_msg);
    echo json_encode([
        "text" => "System error: " . htmlspecialchars($error_msg), 
        "code" => $exec_id, 
        "result" => -1
    ]);
    exit;
}

// Write code file
$code_file = $jail_path . "/tmp/main.art";
file_put_contents($code_file, $code . "\n");
chmod($code_file, 0644);

// Run in jail with timeout, pipe through aha for color conversion
$cmd = "sudo /usr/sbin/jail -c name=$jail_name path=$jail_path exec.start=\"/bin/sh -c 'HOME=/root LD_LIBRARY_PATH=/usr/local/lib timeout --kill-after=3s 10s /usr/local/bin/arturo /tmp/main.art 2>&1 | /usr/local/bin/aha --no-header --black'\" exec.stop=\"\" 2>&1";
exec($cmd, $output, $ret);

// Cleanup (jail auto-stops, just destroy ZFS)
exec("sudo /sbin/zfs destroy zroot/jails/run/$jail_name 2>&1");

// Process output
$txt = "";
foreach ($output as $outp) {
    $txt .= str_replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;", $outp) . "<br>";
}

if ($txt == "") {
    $txt = "[no output]";
}

echo json_encode([
    "text" => $txt,
    "code" => $exec_id,
    "result" => $ret
]);
?>