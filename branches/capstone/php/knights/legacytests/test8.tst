<?php
include ('knights.php');
$array=newBoard();
$array[1][0]=1;
$array[2][7]=2;
$array[5][5]=3;
$array[5][4]=4;
$array[4][0]=5;
$array[5][2]=6;
$array[2][3]=7;
$array[0][1]=8;
$array[3][4]=9;
$array[2][7]=0;
$array[6][5]=1;
$array[7][3]=2;
$array[4][0]=3;
$array[1][3]=4;
$array[2][2]=5;
$array[4][3]=6;
$array[5][1]=7;
$array[4][2]=8;
echo numOfMoves($array, 1,0)."\n";
echo numOfMoves($array, 2,3)."\n";
echo numOfMoves($array, 2,5)."\n";
echo numOfMoves($array, 0,2)."\n";
echo numOfMoves($array, 4,6)."\n";
echo numOfMoves($array, 3,2)."\n";
echo numOfMoves($array, 5,4)."\n";
echo numOfMoves($array, 2,6)."\n";
echo numOfMoves($array, 3,4)."\n";

?>

