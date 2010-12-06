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
	if ($lLine[0]==$space || substr($lLine,0,1)==$tab)
		fwrite($outCont,$tLine);
}
fclose($inCont);
fclose($outCont);
?>
