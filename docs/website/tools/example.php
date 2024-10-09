<?php
header('Access-Control-Allow-Origin: https://arturo-lang.io');

$rest_json = file_get_contents("php://input");
$_POST = json_decode($rest_json, true);
$code = $_POST['i'];
$code_file = "examples/rosetta/".$_POST['i'].".art";

$txt = "";
if (file_exists($code_file)) {
    $txt = file_get_contents($code_file);
}

$final = array(
    "text" => $txt
);

echo json_encode($final);

?>