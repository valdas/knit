## -*- mode: Awk; -*-  vim: set filetype=awk : 

#change

#Return a string, modified by a regular expression.

 function change(old,new,str) {
     return gensub(old,new,"g",str)
 }

#by Tim Menzies

