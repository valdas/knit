## -*- mode: Awk; -*-  vim: set filetype=awk : 
#@uses barph

#assert

#If some check fails, print an error message then die. 

#Code
#====

 function assert(check,str) {
     if (! check)
     	barph(str)
 }

#Notes
#=====

#The version shown here is very simple, uses no globals, and dies
#the _first_ time that any assert fails. Arnold Robbins has a
#[http://www.gnu.org/manual/gawk/gawk.html#Assert-Function more
#sophisticated version] that does not die when the first assert
#fails. Rather, the whole program runs and if any of his asserts
#sets the global flag '_assert_exit', then the program exits with
#a non-zero exit status.

#Author
#======

#Tim Menzies

