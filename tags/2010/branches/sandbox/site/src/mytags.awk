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

 function mytags(file,files,titles,tags,sgat,     i,tmp,tag,n,uniqueTags,memo,all,max,j) {
     for(i in tags) {
         split(i,tmp,SUBSEP)
         tag       = tmp[1]
         uniqueTags[tag]  = tag
     }
     for(i in uniqueTags) {
         n = tags[uniqueTags[i],0] + rand()
         memo[n] = uniqueTags[i]
         all[n]=n
     }
     max=asort(all)
     for(i=max;i>=1;i--) {
         tag = memo[all[i]]
         n   = tags[tag,0]
         out = out "<tr class=row" (j=1-j) ">" \
                   "<td align=right>"  n "</td>"   \
                   "<td ><a href=\"?" tag "\">"tag"</a></td>" \
                   "</tr>\n"
     }
     return "<h1>Cross-Index</h1><table width=\"100%\" id=toc>"out"</table>"
 }

