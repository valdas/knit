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

#default

#Sets default values.

#Synopsis
#========

#`value = default(value,default)`

#Resets `value` to `default` if the `value` is currently the empty string.

#Motivation
#==========

#Sometimes, AWK functions called with fewer parameters than those
#defined in the function header. This lets the user of a function
#skip supplying standard default values.  Inside that function,
#`default` checks and resets these missing values to some standard
#defaults.

#Example
#=======

#Input:

#  print default("123","456");
#  print default("","789");
#  print default(0,"0ab"); 

#Output:

#  123     # No change the value.
#  789     # Value is the empty string; return the default.
#  0       # 0 is still a value. Return the default.

#Code
#====

 function default(value, d) {
	 return value=="" ? d: value
 }

#Author
#======
#Tim Menzies

