## -*- mode: Awk; -*-  vim: set filetype=awk : 
#@uses trim

#s2a: string to array

#Synopsis
#========

#  s2a(string, array [,seperator])

#Divides the input _string_ into the output _array_, seperated by 
#_seperator_ (default: ','). Uses the odd numbered elements as 
#the keys and the even numbered elements as the values.

#Note that the _array_ is completely reset by this function.

#Code
#====

 function s2a(str,a,  sep,  tmp,n,i) {
     sep = sep ? sep : ","
     n= split(str,tmp,sep)
     for(i=1;i<=n;i+=2) 
	 	a[trim(tmp[i])]= trim(tmp[i+1])
     return n/2
 }

#Author
#======

#Tim Menzies

