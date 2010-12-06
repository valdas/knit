
<?php
function w2File($new, $line, $outCont, $old, $hCount, $q)
{
	if ($new!=$old)
	{
		if ($old==1)
			fwrite($outCont,"</p>\n");
		if ($old==2)
			fwrite($outCont,"</pre>\n");
		if ($old==4)
			fwrite($outCont,"\n");
		if ($new==1)
			fwrite($outCont, "<p>\n");
		if ($new==2)
			fwrite($outCont,"<pre>\n");
		if ($new==3)
			fwrite($outCont,"<a name=".$q.(string)$hCount.$q."></a><h2>");
		if ($new==4)
			{
			fwrite($outCont,"<li>");
			$line=substr($line,1);
			}
	}
	else//if ($new==$old)
	{
		if ($new==4)
		{
			fwrite($outCont,"<li>");
			$line=substr($line,1);
		}
	}
	fwrite($outCont,$line);
	if ($new==3)
	{
		fwrite($outCont,"</h2>");
		$new=0;
	}
	fwrite($outCont,"\n");
	$old=$new;
	return $old;
}

$q='"';
$header='=';
$space=' ';
$tab="\t";
$list='+';
$inVar = "convFile";
$lineNum = count(file($inVar));
$inCont=fopen($inVar, 'r');

$outVar = "del";
$outCont=fopen($outVar, 'w');

fwrite($outCont,"<html>\n<head>\n<title>Demo</title>\n<body>\n");

$hCount=1;
fwrite($outCont, "<ul>\n");
for($c=1; $c<=$lineNum; $c++)
{
	if ($c>1)
		$lLine=substr($tLine,0,-1);
	$tLine=fgets($inCont);
	if ($tLine[0]==$header)
	{
		$write2="<li><a href=".$q."#".(string)$hCount.$q.'>'.$lLine."</a>\n";
		fwrite($outCont, $write2);
		$hCount++;
	}
}
fwrite($outCont, "</ul>\n\n");

fclose($inCont);
$inCont=fopen($inVar, 'r');

$hCount=0;

$tLine=fgets($inCont);//get line
$tLine=substr($tLine,0,-1);//remove new line
$mode=0;
$old=0;
for($c=2; $c<=$lineNum; $c++)
{
	$lLine=$tLine;
	$tLine=fgets($inCont);//get line
	$tLine=substr($tLine,0,-1);//remove new line
	if ($tLine[0]==$header)
	{
		$mode=3;
		$hCount++;
	}
        else if ($lLine[0]==$list)
                $mode=4;
	else if ($lLine[0]==$space || substr($lLine,0,1)==$tab)
		$mode=2;
	else if (strlen($lLine)>0)
		$mode=1;
	if ($lLine[0]!=$header)
		$old=w2file($mode, $lLine, $outCont,$old, $hCount, $q);
}
	if ($old==1)
		fwrite($outCont,$tLine."</p>\n");
	if ($old==2)
		fwrite($outCont,$tLine."</pre>\n");
	if ($old==0)
		if($tLine[0]==$space || substr($tLine,0,1)==$tab)
			fwrite($outCont,"<pre>".$tLine."</pre>");
		else
			fwrite($outCont,"<p>".$tLine."</p>");

fwrite($outCont, "</body>\n</html>");

fclose($inCont);
fclose($outCont);

?>
