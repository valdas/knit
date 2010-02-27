## -*- mode: Awk; -*-  vim: set filetype=awk : 

#cat

#Synopsis
#========

#  cat(file,array,seperator)

#Split the contents of _file_ into an  _array_, divided by a _seperator_.

#Example
#=======

#  cat("config.txt",contents,"\n")

#Code
#====

#Uses
#----

#@uses slurp o

#Demo
#----

 function demoCat(   n,all) {
     n=cat("cat.wak",all)
     o(all,"cat",n)
 }

#Output:

#  cat[ 1 ]   =   [ # -*- mode: Awk; -*-  vim: set filetype=awk :  ]
#  cat[ 2 ]   =   [  ]
#  cat[ 3 ]   =   [ cat ]
#  cat[ 4 ]   =   [  ]
#  cat[ 5 ]   =   [ Synopsis ]
#  cat[ 6 ]   =   [ ======== ]
#  cat[ 7 ]   =   [   ]
#  cat[ 8 ]   =   [   cat(file,array,seperator) ]
#  cat[ 9 ]   =   [  ]
#  cat[ 10 ]  =   [ Split the contents of _file_ into an  _array_, divided by a _seperator_. ]
#  cat[ 11 ]  =   [  ]
#  cat[ 12 ]  =   [ Example ]
#  cat[ 13 ]  =   [ ======= ]
#  cat[ 14 ]  =   [  ]
#  cat[ 15 ]  =   [   cat("config.txt",contents,"\n") ]
#  cat[ 16 ]  =   [  ]
#  cat[ 17 ]  =   [ Code ]
#  cat[ 18 ]  =   [ ==== ]
#  cat[ 19 ]  =   [  ]
#  cat[ 20 ]  =   [ Uses ]
#  cat[ 21 ]  =   [ ---- ]
#  cat[ 22 ]  =   [  ]
#  cat[ 23 ]  =   [ @uses slurp o ]
#  cat[ 24 ]  =   [  ]
#  cat[ 25 ]  =   [ Demo ]
#  cat[ 26 ]  =   [ ---- ]
#  cat[ 27 ]  =   [  ]
#  cat[ 28 ]  =   [  function demoCat(   n,all) { ]
#  cat[ 29 ]  =   [      n=cat("cat.wak",all) ]
#  cat[ 30 ]  =   [      o(all,"cat",n) ]
#  cat[ 31 ]  =   [  } ]
#  cat[ 32 ]  =   [  ]
#  cat[ 33 ]  =   [ Main ]
#  cat[ 34 ]  =   [ ---- ]
#  cat[ 35 ]  =   [  ]
#  cat[ 36 ]  =   [  function cat(file,all,sep) {  ]
#  cat[ 37 ]  =   [     return slurp("cat " file,all,sep)  ]
#  cat[ 38 ]  =   [  } ]
#  cat[ 39 ]  =   [  ]
#  cat[ 40 ]  =   [ Author ]
#  cat[ 41 ]  =   [ ====== ]
#  cat[ 42 ]  =   [  ]
#  cat[ 43 ]  =   [ Tim Menzies ]
#  cat[ 44 ]  =   [  ]

#Main
#----

 function cat(file,all,sep) { 
    return slurp("cat " file,all,sep) 
 }

#Author
#======

#Tim Menzies

