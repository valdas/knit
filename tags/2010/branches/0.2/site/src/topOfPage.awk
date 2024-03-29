## -*- mode: Awk; -*-  vim: set filetype=awk : 
##
## This file is part of KNIT.
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

#topOfPage

#Adds tag lists top of page.

 function topOfPage(file,files,titles,tags,sgat,     sep,i,n,out,q) {
     n   = tags[file,0]
     out = ""
     q="\""
     if (n) {
         for(i=1;i<=tags[file,0];i++) {
             out = out sep "<a href=" q "?" tags[file,i] q ">" tags[file,i] "</a>"
             sep = ", " 
         }
         out = "<p class="q"categories"q" >categories: "out"</p>"        
     }
     return out
 }

#by Tim Menzies

