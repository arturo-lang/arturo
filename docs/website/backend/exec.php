<?php
header('Access-Control-Allow-Origin: http://188.245.97.105');

$rest_json = file_get_contents("php://input");
$_POST = json_decode($rest_json, true);
$stream = isset($_POST['stream']) ? $_POST['stream'] : false;

if ($stream) {
    header('Content-Type: text/event-stream');
    header('Cache-Control: no-cache');
    header('Connection: keep-alive');
    header('X-Accel-Buffering: no');
} else {
    header('Content-Type: application/json');
}

$code = $_POST['c'];
$columns = isset($_POST['cols']) ? intval($_POST['cols']) : 80;
$args = isset($_POST['args']) ? trim($_POST['args']) : ''; // Get command-line arguments

// Clamp columns to reasonable values
$columns = max(40, min(200, $columns));

if (empty($code)) {
    echo json_encode(["text" => "No code provided", "code" => "", "result" => -1]);
    exit;
}

// SIZE LIMIT CHECK
define('MAX_CODE_SIZE', 10000);
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

// Check if we should skip saving (for unchanged examples)
$snippet_id_input = !empty($_POST['i']) ? $_POST['i'] : '';
$skip_save = ($snippet_id_input === 'SKIP_SAVE');

// Generate unique ID only if we're actually saving
$exec_id = "";
if (!$skip_save) {
    require_once __DIR__ . '/db.php';
    $db = new SnippetDB();
    $exec_id = !empty($snippet_id_input) ? $snippet_id_input : $db->generateUniqueId();
    
    // Save snippet to database
    $db->save($exec_id, $code);
    
    // Occasionally cleanup old snippets (1% chance)
    if (rand(1, 100) === 1) {
        $db->cleanup();
    }
}

$jail_name = "arturo_" . preg_replace('/[^a-zA-Z0-9]/', '_', $skip_save ? 'example_' . uniqid() : $exec_id);
$jail_path = "/zroot/jails/run/" . $jail_name;

// Clone template jail
exec("sudo /sbin/zfs clone zroot/jails/{$template_name}@clean zroot/jails/run/$jail_name 2>&1", $clone_out, $clone_ret);

if ($clone_ret !== 0) {
    $error_msg = "Failed to clone jail for version '$version' (template: $template_name): " . implode("\n", $clone_out);
    error_log($error_msg);
    echo json_encode([
        "text" => "System error: " . htmlspecialchars($error_msg), 
        "code" => $skip_save ? "" : $exec_id, 
        "result" => -1
    ]);
    exit;
}

// Check if this is an unmodified example
$example_name = isset($_POST['example']) ? $_POST['example'] : '';
$is_example = ($skip_save && !empty($example_name));

if ($is_example) {
    // For unmodified examples, execute from /examples directory
    $escaped_example = escapeshellarg(basename($example_name) . ".art");
    $arturo_cmd = "/usr/local/bin/arturo " . $escaped_example . "";
} else {
    // Write code file for regular snippets or modified examples
    $code_file = $jail_path . "/tmp/main.art";
    file_put_contents($code_file, $code . "\n");
    chmod($code_file, 0644);
    $arturo_cmd = "/usr/local/bin/arturo /tmp/main.art";
}

// Build command with arguments, if provided
if (!empty($args)) {
    // Escape arguments for shell
    $escaped_args = escapeshellcmd($args);
    $arturo_cmd .= " " . $escaped_args;
}

if ($stream) {
    // For streaming, run without aha first to avoid buffering, then colorize each line
    $cmd = "sudo /usr/sbin/jail -c name=$jail_name path=$jail_path exec.start=\"/bin/sh -c 'HOME=/root LD_LIBRARY_PATH=/usr/local/lib COLUMNS=$columns LINES=24 timeout --kill-after=3s 10s $arturo_cmd 2>&1'\" exec.stop=\"\" 2>&1";
    
    // Disable PHP buffering for streaming
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
                // Colorize each line individually
                $colorized = shell_exec("echo " . escapeshellarg($line) . " | /usr/local/bin/aha --no-header --black");
                $formatted = str_replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;", rtrim($colorized));
                echo "data: " . json_encode(["line" => $formatted . "<br>"]) . "\n\n";
                flush();
            }
        }
        usleep(10000);
    }
    
    // Send any remaining buffered content
    if ($buffer !== '') {
        $colorized = shell_exec("echo " . escapeshellarg($buffer) . " | /usr/local/bin/aha --no-header --black");
        $formatted = str_replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;", rtrim($colorized));
        echo "data: " . json_encode(["line" => $formatted . "<br>"]) . "\n\n";
        flush();
    }
    
    $ret = pclose($handle);
    
    // Send completion event
    echo "data: " . json_encode([
        "done" => true,
        "code" => $skip_save ? "" : $exec_id,
        "result" => $ret
    ]) . "\n\n";
    flush();
    
} else {
    // Run in jail with timeout, pipe through aha for color conversion
    // Use the terminal width from the browser
    $cmd = "sudo /usr/sbin/jail -c name=$jail_name path=$jail_path exec.start=\"/bin/sh -c 'HOME=/root LD_LIBRARY_PATH=/usr/local/lib COLUMNS=$columns LINES=24 timeout --kill-after=3s 10s $arturo_cmd 2>&1 | /usr/local/bin/aha --no-header --black'\" exec.stop=\"\" 2>&1";
    
    // Original batch execution
    exec($cmd, $output, $ret);
    
    // Process output
    $txt = "";
    foreach ($output as $outp) {
        $txt .= str_replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;", $outp) . "<br>";
    }
    
    if ($txt == "") {
        $txt = "[no output]";
    }
    
    // Return empty code if we skipped saving
    echo json_encode([
        "text" => $txt,
        "code" => $skip_save ? "" : $exec_id,
        "result" => $ret
    ]);
}

// Cleanup (jail auto-stops, just destroy ZFS)
exec("sudo /sbin/zfs destroy zroot/jails/run/$jail_name 2>&1");
?>