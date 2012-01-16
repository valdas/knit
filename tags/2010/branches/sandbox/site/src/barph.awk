## -*- mode: Awk; -*-  vim: set filetype=awk : 
#@uses warning

#barph

#Prints a string that exits with a non-zero status.

 function barph(str) {
     warning(str)
     exit 1; 
 }

#by Tim Menzies

