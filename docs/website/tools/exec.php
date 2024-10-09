<?php
header('Access-Control-Allow-Origin: https://arturo-lang.io');

$rest_json = file_get_contents("php://input");
$_POST = json_decode($rest_json, true);
$code = $_POST['c'];
if (trim($_POST['i'])!="") {
	$temp_file = "/tmp/art_".$_POST['i'];
}
else {
	$temp_file = tempnam(sys_get_temp_dir(), 'art_');
}
file_put_contents($temp_file, $code."\n");

$i = exec ("timeout -v --signal=9 10s /var/www/arturo-lang.io/arturo $temp_file 2>&1 | aha --no-header --black",$output, $ret);

$txt = "";
foreach ($output as $outp)
{
	$txt .= str_replace("\t","&nbsp;&nbsp;&nbsp;&nbsp;",$outp). "<br>";
}

// if ($txt==""){
// 	// $i2 = exec ("timeout -v --signal=9 10s /var/www/arturo-lang.io/arturo $temp_file",$output2, $ret2);
// 	// if ($ret2==139) {
// 		exec("cp /root/arturo/bin/arturo /var/www/arturo-lang.io");

// 		$i = exec ("timeout -v --signal=9 10s /var/www/arturo-lang.io/arturo $temp_file 2>&1 | aha --no-header --black",$output, $ret);
// 		$txt = "";
// 		foreach ($output as $outp)
// 		{
// 			$txt .= str_replace("\t","&nbsp;&nbsp;&nbsp;&nbsp;",$outp). "<br>";
// 		}
// 	// }
// }

if ($txt==""){ $txt = "[no output]"; }

// preg_match('/<\/span><span style="filter: contrast(70%) brightness(190%);color:dimgray;">art<\/span><span style="font-weight:bold;filter: contrast(70%) brightness(190%);color:dimgray;">([^<]+)<br>/', $txt, $matcch);

$final = array(
	"text" => $txt,
	"code" => str_replace("art_","",str_replace("/tmp/", "", $temp_file)),
	"result" => $ret,
	"i" => $i,
	"output" => $output, 
	"output2" => $output2,
	"ret" => $ret,
	"ret2" => $ret2
);

echo json_encode($final);

?>