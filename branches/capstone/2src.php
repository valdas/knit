<?php
$space=' ';
$tab="\t";
$inVar = "srcFile";
$lineNum = count(file($inVar));
$inCont=fopen($inVar, 'r');
$outVar = "rmv";
$outCont=fopen($outVar, 'w');

for($c=1; $c<=$lineNum; $c++)
{
	$Line=fgets($inCont);
	if ($Line[0]==$space || substr($Line,0,1)==$tab)
		fwrite($outCont,$Line);
}
fclose($inCont);
fclose($outCont);
?>
