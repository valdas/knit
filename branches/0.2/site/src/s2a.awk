## -*- mode: Awk; -*-  vim: set filetype=awk : 
#@uses trim default

#s2a: string to array

#Synopsis
#========

#s2a(string, array [,seperator,blankp])

#Divides the input _string_ into the output _array_, seperated by
#_seperator_ (default: ',').  Uses the odd numbered elements as the
#keys and the even numbered elements as the values.  If _blankp_ is
#set, then the keys and values can contain leading and trailing blanks
#(otherwise, those blanks are deleted).

#Note that the _array_ is completely reset by this function.

#Code
#====

 function s2a(str,a,  sep,blankp,  tmp,n,i) {
    sep= default(sep,",")
    blankp = default(blankp,0)
    n= split(str,tmp,sep)
    for(i=1;i<=n;i+=2) 
        if (blankp)
            a[tmp[i]]= tmp[i+1]
        else
            a[trim(tmp[i])]= trim(tmp[i+1]);
    return n/2
 }

#Author
#======

#Tim Menzies

