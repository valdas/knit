## -*- mode: Awk; -*-  vim: set filetype=awk : 
##
## This file is part of KNIT; copyright (C) 2010 by Tim Menzies
## tim@menzies.us.
##
## KNIT is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## KNIT is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with KNIT.  If not, see <http://www.gnu.org/licenses/>.

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

#Demo
#----

#(KNIT programmers can run this example using _cd quill; eg13_.)

#Input...

#  N=cat("etc/tests/eg13.in",All);
#  o(All,"cat",N)

#Output...

#  cat[ 1 ]  = [ The Pyramid Texts are a collection of ancient Egyptian ]
#  cat[ 2 ]  = [ religious texts from the time of the Old Kingdom. ]
#  cat[ 3 ]  = [ Written in Old Egyptian, the pyramid texts were carved ]
#  cat[ 4 ]  = [ on the walls and sarcophagi of the pyramids at Saqqara ]
#  cat[ 5 ]  = [ during the 5th and 6th Dynasties of the Old Kingdom. ]
#  cat[ 6 ]  = [ The oldest of the texts date to between 2400-2300 BC. ]
#  cat[ 7 ]  = [  ]
#  cat[ 8 ]  = [ Example: ]
#  cat[ 9 ]  = [  ]
#  cat[ 10 ] = [  Oho! Oho! Rise up, O Teti! ]
#  cat[ 11 ] = [  Take your head, collect your bones, ]
#  cat[ 12 ] = [  Gather your limbs, shake the earth from your flesh! ]
#  cat[ 13 ] = [  Take your bread that rots not, your beer that sours not, ]
#  cat[ 14 ] = [  Stand at the gates that bar the common people! ]
#  cat[ 15 ] = [  ]

#Uses
#----

#@uses slurp

#Main
#----

 function cat(file,all,sep) { 
    return slurp("cat " file,all,sep) 
 }

#Author
#======

#Tim Menzies

