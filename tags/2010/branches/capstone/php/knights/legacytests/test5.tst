<?php
include ('knights.php');
$array=newBoard();
$array[1][1]=1;
$array=solve($array,1,1,2);
?>
