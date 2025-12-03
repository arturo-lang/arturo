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

$version = basename(dirname(__DIR__));
$template_name = "arturo_runner_" . $version;

// Generate unique ID
$exec_id = !empty($_POST['i']) ? $_POST['i'] : uniqid('art_', true);
$jail_name = "arturo_" . preg_replace('/[^a-zA-Z0-9]/', '_', $exec_id);
$jail_path = "/zroot/jails/run/" . $jail_name;

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

// Run in jail with timeout and library path
$cmd = "sudo /usr/sbin/jail -c name=$jail_name path=$jail_path exec.start=\"/bin/sh -c 'HOME=/root LD_LIBRARY_PATH=/usr/local/lib timeout --kill-after=2s 5s /usr/local/bin/arturo /tmp/main.art'\" exec.stop=\"\" 2>&1";
exec($cmd, $output, $ret);

// Cleanup (jail auto-stops, just destroy ZFS)
exec("sudo /sbin/zfs destroy zroot/jails/run/$jail_name 2>&1");

// Process output
$txt = "";
foreach ($output as $line) {
    $txt .= str_replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;", $line) . "<br>";
}

if (empty($txt)) {
    $txt = "[no output]";
}

echo json_encode([
    "text" => $txt,
    "code" => $exec_id,
    "result" => $ret
]);
?>