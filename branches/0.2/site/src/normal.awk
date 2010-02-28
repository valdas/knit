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

#Normal distribution

#@uses math

 function nkeep(x,m) {
	m["n"]++;
	m["s"]  += x
	m["s2"] += x^2
 }
 function nmean(x,m) {
	return m["s"] / m["n"]
 }
 function nsd(x,m) {
     return sf(m["s2"],m["s"],m["n"])
 }
 function gaussianPdf(m,s,x) {
   return 1/(s*sqrt(2*Pi))^(-1*(x-m)^2/(2*s*s))
 }
 function normal(m,s) {
   return m+box_muller()*s;
 }
 function box_muller(m,s,    n,x1,x2,w) {
   w=1;
   while (w >= 1) {
     x1= 2.0 * rand() - 1;
     x2= 2.0 * rand() - 1;
     w = x1*x1 + x2*x2};
   w = sqrt((-2.0 * log(w))/w);
   return x1 * w;
 }
 function sd(sumSq,sumX,n) {
   return sqrt((sumSq-((sumX*sumX)/n))/(n-1));
 }

#Author
#======

#Tim Menzies

