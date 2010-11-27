<?php

$myFile = "form.txt";

if ($_GET) {
	$fh = fopen($myFile, 'w+') or die("can't open file");
	$stringData = $_GET['name']."\n";
	fwrite($fh, $stringData);
	fclose($fh);
} else {
	$fh = fopen($myFile, 'r');
	$theData = fread($fh, filesize($myFile));
	fclose($fh);
}

?>


<p>Hello<?php echo ' '.$theData; ?></p>

<p><small>This is not keeping a list anymore because of all the dill-holes who posted inappropriate in here, go abuse your own stuff ;)</small></p>
