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

#Factorial

#Example
#=======

#Input...

#    print  2 " " factorial(2) 
#    print  5 " " factorial(5) 
#    print 10 " " factorial(10) 
#    print 20 " " factorial(20) 
#    print 20 " " factorial(40) 

#Output...

#Code
#====

 function factorial(n,  out,i) {
     if (n < 1) 
         return 1;
     out = 1
     for(i=2;i<=n;i++) 
         out *= i
     return out
 }

