## -*- mode: Awk; -*-  vim: set filetype=awk : 

#barph

#Prints a string that exits with a non-zero status.

#Code
#====

#Uses
#----

#@uses warning

#Main
#----

 function barph(str) {
     warning(str)
     exit 1; 
 }

#Author
#======

#Tim Menzies

