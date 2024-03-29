## -*- mode: Awk; -*-  vim: set filetype=awk : 

#a2s

#Convert an array into a string. 

#Synopsis

#  a2s(a [,sep,start,stop])

#Generates a string starting from position _start_ (defaults to 1) to position _stop_ (defaults to length of array).

 function a2s(a,sep,  start, stop,  tmp, out,i) { 
     sep   = sep   ? sep   : ","
     start = start ? start : 1
     stop  = stop  ? stop  : a[0]
     out = a[start]
     for(i=start+1;i<=stop;i++)
	out = out sep a[i]     
     return out
 }

#by Tim Menzies

