## -*- mode: Awk; -*-  vim: set filetype=awk : 

#wget     

#Synopsis   
#========

#  wget(url,array,seperator)

#Split the contents of _url_ into an _array_, divided by a _seperator_ 
#(defaults to new line). Returns the size of the array.

#Note that this code prepends "http://" onto the url.

#Example  
#=======

#  wget("menzies.us",contents,"\n") 

#Code
#====

#Uses
#----

#@uses slurp o

#Demo
#----

 function demoWget(   n,all,url) {
     url="knit.googlecode.com/svn/branches/0.2/quill/etc/tests/demoWget.rss"
     n=wget(url,all,">")
     o(all,"wget",n) 
 }

#Main
#----

 function wget(url,all,sep) { 
    return slurp("wget -q -O - http://" url,all,sep) 
 }

#Author
#======

#Tim Menzies

