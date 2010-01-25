## -*- mode: Awk; -*-  vim: set filetype=awk : 

#slots 

#About
#=====

#_Slots_ is  simple macro langauage- no recursive macros, no macro arguments.
#It processes two files: 

#+ A _slots_ file that defines a set of name/value pairs.
#+ A _frame_ file with a set of names slots. 

#At runtime, the slot values replace the slot names in the _frame_ file or
#from a set of plugins. 

#Sample
#------

#Here is a slots file:

#  ``name``   Tim Menzies
#  ``office`` 841a
#  ``phone``  28361

#And here is a frame file

#   Dear ``name``,

#   When the pizza arrives, I will call you on ``phone`` and send
#   it around to ``office``.  

#   Bon Appetit!

#   p.s. Fyi: here are the latest updates to our menu: ``rss;tinyurl/pizza.rss;5``

#About Plugins
#-------------

#Note that the last slot in the frame contains the _";"_ plug-in character. This
#slot will be filled in by passing the slot label to the _slotsPlugIns_ function.

#Code
#====

#Uses
#----

#@uses trim math

#Example
#-------

#+ [slotsDemo] is a  simple demo program for this code.

#Assumed Functions
#-----------------

#This code assumes that _slotsPlugIns_ has been defined.

#The _slotsPlugIns_ function accepts two arguments:

#1. For the slots string;
#2. For the set name name/value pairs that define the slots.

#_Slots_ prints whatever that function returns. That is,
#the above string gets replaced by:

#  print slotsPlugIns("rss;tinyurl/pizza.rss;5",values)

#Main
#----

 function slots(slotsFile,frameFile,      values,sep) {
     sep="``"
     loadSlots(slotsFile,sep,values)   
     fillFrame(frameFile,sep,values)
 }

#Workers
#-------

 function loadSlots(slots,sep,values,   n,i,all) {
     n=slurp(slots,all,sep)
     for(i=2; i<=n; i += 2) 
	 values[trim(all[i])] = trim(all[i+1]);
 }
 function fillFrame(frame,sep,values,   all,n,i) {
     print fillFrame2String(frame,sep,values)
 }
 function fillFrame2String(frame,sep,values,   all,n,i,str) {
     n=slurp(frame,all,sep);
     for(i=1; i<=n; i++)  
	 str = str sprintf("%s", (oddp(i) ? all[i] : fillSlot(all[i],values)))
     return str
 } 
 function fillSlot(str,values) {
     return (str ~ /;/ ? slotsPlugIns(str,values) : values[str])
}

#Author
#======

#Tim Menzies

