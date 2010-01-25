## -*- mode: Awk; -*-  vim: set filetype=awk : 

#o

#Print an array.

#Synopsis
#========

#   o(array [,string,control])

#* If _string_ is given,  print it before each item.
#* If _control_ is a positive integer, then print from 1 to _control_.
#* If _control_ is zero, the print in any order.
#* Else, if the size of the _array_ is stored at location _array[0]_ then print from one to size.
#* Else, if _control_ is a string, use it as  an  argument to a UNIX sort command (otherwise,
#  just sort numerically by the _array_ values.

#Code 
#====

#Main
#----

 function o(a, str,control,   i,com) {
     str = str ? str : "array"
     if (control ~ /^[0-9]/)  {
         if (control==0)
             o1(a,str)
	 else
             for(i=1;i<=control;i++)
                 print oprim(str,i,a)
     } else
	 if (0 in a)        # sometimes i store array size in a[0]
	     o(a,str,a[0])         
         else {
             com = control ? control : " -n -k 2" 
             com = "sort " com  " #" rand(); # ensure com is unique
             for(i in a)
                 print oprim(str,i,a) | com;
             close(com); }
 }

 function oprim(str,i,a,  j) {
     j=i
     gsub(SUBSEP,",",j) 
     return str "[ " j " ]\t=\t [ " a[i] " ]"
 }

#Simpler
#-------

#When "_o_" is too complicated, use "_oo_".

 function oo(a,str, i) {
     for(i in a)
         print oprim(str,i,a)
 }

#Many prints
#-----------

 function oos(a1,str1,a2,str2,a3,str3,a4,str4,a5,str5) {
     if(str1) oo(a1,str1);
     if(str2) oo(a2,str2);
     if(str3) oo(a3,str3);
     if(str4) oo(a4,str4);
     if(str5) oo(a5,str5)
 }

 function os(a1,str1,a2,str2,a3,str3,a4,str4,a5,str5) {
     if(str1) o(a1,str1);
     if(str2) o(a2,str2);
     if(str3) o(a3,str3);
     if(str4) o(a4,str4);
     if(str5) o(a5,str5)
 }

#Author
#======

#Tim Menzies

