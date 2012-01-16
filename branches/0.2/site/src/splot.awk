## -*- mode: Awk; -*-  vim: set filetype=awk : 

#splot

#A variant of `split`. Divides a list. Adds size of list to the first item.

#Synposis
#========

#  splot(string,array [,sep])

#Splits `string` iinto `array`. divided on `sep` (defaults to FS). Stores size of
#`array` in `array\[0\]`. Returns the size of the array.

#Example
#=======

#(KNIT programmers can run this example using _cd quill; make eg2_).

#Input:

#  splot("a:b:c:d",A,":"); 
#  for(I=1;I<=A[0];I++) 
#     print I " " A[I] 

#Output:

#  1 a
#  2 b
#  3 c
#  4 d

#Code
#====

 function splot(string,array,   sep) {
    array[0]= split(string,array, sep)
 }

#Author
#======
#by Tim Menzies

