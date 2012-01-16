<?php
 function newBoard()
 {
		$board=array(
		array(0,0,0,0,0,0,0,0,),
		array(0,0,0,0,0,0,0,0,),
		array(0,0,0,0,0,0,0,0,),
		array(0,0,0,0,0,0,0,0,),
		array(0,0,0,0,0,0,0,0,),
		array(0,0,0,0,0,0,0,0,),
		array(0,0,0,0,0,0,0,0,),
		array(0,0,0,0,0,0,0,0,)
		);
 return $board;
}

function printBoard($board)
{
		$j=0;
		while ($j<8)
		{
				$i=0;
				while ($i<8).

				{
						if ($board[$j][$i]<10)
						{
								echo "0";
						}
						echo $board[$j][$i]." ";

						$i++;
				}
				echo "<br>";
				$j++;
		}
echo "<br>";
}

 function solve($board, $y, $x, $step)
{
		$yaxis=2;
		$numMoves=8;
		$nextx=0;
		$nexty=0;
if ($step>64)
{
		printBoard($board);
		return $board;
}
else
{
		while (-2 <= $yaxis)
		{
				if ($yaxis!=0)
				{
						$xaxis=2;
						if ($yaxis>1 || $yaxis<-1)
						{
								$xaxis=1;
						}

						while($xaxis>=-2)
						{
								if ($xaxis!=0)
								{
										$num=9;
										$num=numOfMoves($board, $y+$yaxis, $x+$xaxis);
										if ($numMoves>$num)
										{
												$numMoves=$num;
												$nexty=$y+$yaxis;
												$nextx=$x+$xaxis;
										}
								}
								$xaxis-=2;
						}
				}
				$yaxis-=1;
		}
}

$board[$nexty][$nextx] = $step;
$board=solve($board, $nexty, $nextx, $step+1);
}

function numOfMoves($board, $y, $x)
{
		$yaxis=2;
		$count=0;

		if ($board[$y][$x]!="0")
		{
				$count=9;
		 }
		 else
		{
				while (-2 <= $yaxis)
				{
						if ($yaxis!=0)
						{
								$xaxis=2;
								if ($yaxis>1 || $yaxis<-1)
								{
										$xaxis=1;
								}
								while($xaxis>=-2)
								{
										if ($xaxis!=0)
										{
												if ($board[$y+$yaxis][$x+$xaxis]=="0")
														$count++;
										}
										$xaxis-=2;
								}
						}
						$yaxis-=1;
				}
		}
		return $count;
}
$board = newBoard();
$startX=0;
$startY=0;
$board[$startY][$startX]=1;
printBoard($board);
$solution=solve($board, $startY, $startX, 2);
?>
