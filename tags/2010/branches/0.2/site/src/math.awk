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

#math

#Standard maths stuff.

#Examples
#========

#(KNIT programmers can exercise these examples using _cd quill; make eg16_.)

#    2,432,902,008,176,640,000

#Code
#====

 BEGIN { Pi   = 3.14159265
         E    = 2.71828183
         Inf  = 10^16
         NInf = -1*Ninf
       }

 function oddp(x)  { return (x % 2) }
 function evenp(x) { return (! oddp(x)) }
 function abs(n)     { return n < 0 ? -1*n : n }
 function most(x,y)  { return x > y ? x    : y }
 function least(x,y) { return x > y ? y    : x }
 function round(x)   { return int( x<0 ? x-0.5 : x+0.5) }
 function mean(sum,n) {return sum/n}
 function between(min,max) { 
	if (max==min) 
            return min 
        return min+ ((max-min)*rand())
 }
 function within(n,min,max) {
	if (n < min) return min
	if (n > max) return max
    return n
 }

#Author
#======

#Tim Menzies

