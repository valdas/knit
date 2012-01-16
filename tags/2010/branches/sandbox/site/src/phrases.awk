## -*- mode: Awk; -*-  vim: set filetype=awk : 

#phrases

#Split a line on a seperator, remove leading and trailing whitespace on each item.

#Code
#====

#Uses
#----

#@uses trim

#Code
#----

 function phrases(str,sep,a,    n,i) {
    n=split(str,a,sep)
    for(i=1;i<=n;i++)
		a[i]= trim(a[i])
    return n
 }

#Author
#======

#Tim Menzies

