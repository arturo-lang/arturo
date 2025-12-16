<?php
// =============================================================================
// CODE EXECUTION ENDPOINT
// =============================================================================
// Executes Arturo code in isolated jail, enforces rate limits

header('Access-Control-Allow-Origin: http://188.245.97.105');

$rest_json = file_get_contents("php://input");
$_POST = json_decode($rest_json, true);

// Validate JSON decode
if (!is_array($_POST)) {
    $_POST = [];
}

$stream = isset($_POST['stream']) ? $_POST['stream'] : false;

if ($stream) {
    header('Content-Type: text/event-stream');
    header('Cache-Control: no-cache');
    header('Connection: keep-alive');
    header('X-Accel-Buffering: no');
} else {
    header('Content-Type: application/json');
}

require_once __DIR__ . '/db.php';
$db = new SnippetDB();

// =========================================================================
// RATE LIMITING CHECK
// =========================================================================

$ip = $_SERVER['REMOTE_ADDR'] ?? 'unknown';

if (!$db->checkRateLimit($ip, 60)) {
    $error = json_encode([
        "text" => "Rate limit exceeded. Maximum 60 executions per hour.",
        "code" => "",
        "result" => -1
    ]);
    
    if ($stream) {
        echo "data: " . json_encode([
            "done" => true,
            "error" => "Rate limit exceeded",
            "code" => "",
            "result" => -1
        ]) . "\n\n";
    } else {
        echo $error;
    }
    exit;
}

$db->recordExecution($ip);

// Occasionally cleanup old rate limit entries (1% chance)
if (rand(1, 100) === 1) {
    $db->cleanupRateLimits();
}

// =========================================================================
// PARAMETER VALIDATION
// =========================================================================

$code = $_POST['c'];
$columns = isset($_POST['cols']) ? intval($_POST['cols']) : 80;
$args = isset($_POST['args']) ? trim($_POST['args']) : '';

$columns = max(40, min(200, $columns));

if (empty($code)) {
    echo json_encode(["text" => "No code provided", "code" => "", "result" => -1]);
    exit;
}

define('MAX_CODE_SIZE', 10000);
if (strlen($code) > MAX_CODE_SIZE) {
    echo json_encode([
        "text" => "Error: Code exceeds maximum size limit (" . number_format(MAX_CODE_SIZE) . " characters)",
        "code" => "",
        "result" => -1
    ]);
    exit;
}

// =========================================================================
// JAIL SETUP
// =========================================================================

$version = basename(dirname(__DIR__));
$template_name = "arturo_runner_" . $version;

$example_name = isset($_POST['example']) ? $_POST['example'] : '';
$is_example = !empty($example_name);

$jail_name = "arturo_" . preg_replace('/[^a-zA-Z0-9]/', '_', ($is_example ? 'example_' : 'exec_') . uniqid());
$jail_path = "/zroot/jails/run/" . $jail_name;

exec("sudo /sbin/zfs clone zroot/jails/{$template_name}@clean zroot/jails/run/$jail_name 2>&1", $clone_out, $clone_ret);

if ($clone_ret !== 0) {
    $error_msg = "Failed to clone jail for version '$version' (template: $template_name): " . implode("\n", $clone_out);
    error_log($error_msg);
    echo json_encode([
        "text" => "System error: " . htmlspecialchars($error_msg), 
        "code" => "", 
        "result" => -1
    ]);
    exit;
}

// =========================================================================
// PREPARE EXECUTION SCRIPT
// =========================================================================

if ($is_example) {
    // SECURITY: Sanitize example name to prevent path traversal
    // Only allow alphanumeric, dash, underscore, and spaces
    if (preg_match('/[^a-zA-Z0-9_\-\' ]/', $example_name)) {
        echo json_encode([
            "text" => "Error: Invalid example name",
            "code" => "",
            "result" => -1
        ]);
        exec("sudo /sbin/zfs destroy zroot/jails/run/$jail_name 2>&1");
        exit;
    }
    
    $example_file = basename($example_name) . ".art";
    $arturo_target = "examples/" . $example_file;
} else {
    $code_file = $jail_path . "/tmp/main.art";
    file_put_contents($code_file, $code . "\n");
    chmod($code_file, 0644);
    $arturo_target = "/tmp/main.art";
}

// Build command arguments array
$arturo_args = [$arturo_target];
if (!empty($args)) {
    $arturo_args[] = $args;
}

// Write execution script to jail
$exec_script = $jail_path . "/tmp/run.sh";
$script_content  = "#!/bin/sh\n";
$script_content .= "HOME=/root\n";
$script_content .= "LD_LIBRARY_PATH=/usr/local/lib\n";
$script_content .= "COLUMNS=$columns\n";
$script_content .= "LINES=24\n";
$script_content .= "export HOME LD_LIBRARY_PATH COLUMNS LINES\n";
$script_content .= "timeout --kill-after=3s 10s /usr/local/bin/arturo";

// Add arguments with proper quoting
foreach ($arturo_args as $arg) {
    // Use single quotes and escape any single quotes in the argument
    $escaped_arg = str_replace("'", "'\\''", $arg);
    $script_content .= " '" . $escaped_arg . "'";
}

$script_content .= " 2>&1\n";

file_put_contents($exec_script, $script_content);
chmod($exec_script, 0755);

// =========================================================================
// EXECUTION
// =========================================================================

if ($stream) {
    // Simple command - just run the script
    $cmd = "sudo /usr/sbin/jail -c name=$jail_name path=$jail_path exec.start='/tmp/run.sh' exec.stop='' 2>&1";
    
    ini_set('output_buffering', 'off');
    ini_set('zlib.output_compression', false);
    if (ob_get_level()) ob_end_clean();
    
    $handle = popen($cmd, 'r');
    stream_set_blocking($handle, false);
    
    $buffer = '';
    while (!feof($handle)) {
        $chunk = fread($handle, 1024);
        if ($chunk !== false && $chunk !== '') {
            $buffer .= $chunk;
            $lines = explode("\n", $buffer);
            $buffer = array_pop($lines);
            
            foreach ($lines as $line) {
                $colorized = shell_exec("echo " . escapeshellarg($line) . " | /usr/local/bin/aha --no-header --black");
                $formatted = str_replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;", rtrim($colorized));
                echo "data: " . json_encode(["line" => $formatted . "<br>"]) . "\n\n";
                flush();
            }
        }
        usleep(10000);
    }
    
    if ($buffer !== '') {
        $colorized = shell_exec("echo " . escapeshellarg($buffer) . " | /usr/local/bin/aha --no-header --black");
        $formatted = str_replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;", rtrim($colorized));
        echo "data: " . json_encode(["line" => $formatted . "<br>"]) . "\n\n";
        flush();
    }
    
    $ret = pclose($handle);
    
    echo "data: " . json_encode([
        "done" => true,
        "code" => "",
        "result" => $ret
    ]) . "\n\n";
    flush();
    
} else {
    // Non-streaming: pipe through aha
    $exec_script_aha = $jail_path . "/tmp/run_aha.sh";
    file_put_contents($exec_script_aha, "#!/bin/sh\n/tmp/run.sh | /usr/local/bin/aha --no-header --black\n");
    chmod($exec_script_aha, 0755);
    
    $cmd = "sudo /usr/sbin/jail -c name=$jail_name path=$jail_path exec.start='/tmp/run_aha.sh' exec.stop='' 2>&1";
    
    exec($cmd, $output, $ret);
    
    $txt = "";
    foreach ($output as $outp) {
        $txt .= str_replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;", $outp) . "<br>";
    }
    
    if ($txt == "") {
        $txt = "[no output]";
    }
    
    echo json_encode([
        "text" => $txt,
        "code" => "",
        "result" => $ret
    ]);
}

// =========================================================================
// CLEANUP
// =========================================================================

exec("sudo /sbin/zfs destroy zroot/jails/run/$jail_name 2>&1");
?>