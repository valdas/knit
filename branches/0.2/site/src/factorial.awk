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

#(KNIT programmers can  run this example using _cd quill; make eg09_.)

#Input... 

#  for(I=1;I<=20;I++) 
#     print I " " factorial(I)

#Output...

#    1 1
#   2 2
#   3 6
#   4 24
#   5 120
#   6 720
#   7 5040
#   8 40320
#   9 362880
#  10 3628800 
#  11 39916800
#  12 479001600
#  13 6227020800
#  14 87178291200
#  15 1307674368000
#  16 20922789888000
#  17 355687428096000
#  18 6402373705728000
#  19 121645100408832000
#  20 2432902008176640000

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

#Author
#======

#by Tim Menzies

