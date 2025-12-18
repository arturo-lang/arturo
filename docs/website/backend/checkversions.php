<?php
header('Access-Control-Allow-Origin: http://188.245.97.105');
header('Content-Type: application/json');

$path = $_GET['path'] ?? '';
$path = ltrim($path, '/');

$versions_base = __DIR__ . '/../../versions';
$version_dirs = glob($versions_base . '/*', GLOB_ONLYDIR);

$available_versions = [];

foreach ($version_dirs as $version_dir) {
    $version_name = basename($version_dir);
    
    // Skip test version
    if ($version_name === 'test') {
        continue;
    }
    
    // Check if path exists
    $check_paths = [
        $version_dir . '/' . $path,
        $version_dir . '/' . $path . '.html',
        $version_dir . '/' . $path . '/index.html'
    ];
    
    foreach ($check_paths as $check_path) {
        if (file_exists($check_path)) {
            $available_versions[] = $version_name;
            break;
        }
    }
}

// Sort: stable, latest, then version numbers
usort($available_versions, function($a, $b) {
    if ($a === 'stable') return -1;
    if ($b === 'stable') return 1;
    if ($a === 'latest') return -1;
    if ($b === 'latest') return 1;
    return version_compare($b, $a);
});

echo json_encode($available_versions);
?>