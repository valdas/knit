<?php
include ('knights.php');
$array=newBoard();
$array[1][1]=1;
printBoard($array);
$array=solve($array,1,1,2);
printBoard($array);
?>
