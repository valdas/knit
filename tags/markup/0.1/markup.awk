# -*- mode: Awk; -*-  vim: set filetype=awk : 
#
# MARKUP = A MARKDOWN-based HTML generator, with extensions 
#          for KNIT. For more info on this file, see 
#          http://artofawk.net/?literate
#
# This file is part of KNIT; copyright (C) 2010 by Tim Menzies
# tim@menzies.us.
#
# KNIT is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# KNIT is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with KNIT.  If not, see <http://www.gnu.org/licenses/>.


BEGIN       { RS=""; FS="\n";N=1; Is[2]="ul"}
N==1 && 
/^[\@\#";]/ { next }
$0          { P[N]=$0;
              Is[N]= kind($0,N,$2);
     	      if (N==1) N++; # make room for toc
	      N++;
}
END { main(P,N,Is) }

function main(p,n,is,  m,i) {
    m[1] = markup(1,p[1],"h1");
    m[n] = complete(n-1)
    for(i=3;i<n;i++)   
		m[i] = markup(i,p[i],is[i],is[i-1]);
    m[2] = markup(2,p[2],"ul","h1");
    print m[1];
    for(i=2;i<=n;i++)  {
	if (m[i] && Is[i]) {
	    if (listp(i)) 
		m[i]= list(m[i]);
	    print prefix(is[i-1],is[i]);	
	    print m[i];
	}
    }
}
function listp(i)    { return Is[i] ~ /l$/ }
function headingp(i) { return Is[i] ~ /[hH]/ }
function kind(all,n,line2) {
  if (n==1)                      return "h1"
  if (all   ~ /^[ \t]/)          return "pre";
  if (all   ~ /^===== /)         return "h2";      
  if (all   ~ /^==== /)          return "h3";      
  if (all   ~ /^=== /)           return "h4";  
  if (all   ~ /^== /)            return "h5";  
  if (line2 ~ /^==/)             return "H2";    
  if (line2 ~ /^--/)             return "H3";    
  if (line2 ~ /^\+\+/)           return "H4"; 
  if (line2 ~ /^__/)             return "H5"; 
  if (all   ~ /^[\*\+\-]/)       return "ul";
  if (all   ~ /^[0-9]\./)        return "ol";
  return "p"
}
function complete(i) {
    return  headingp(i)  ? "" : "</" Is[i] ">"
}
function markup(i,str,now,b4) {
    str = prep(now,str);
    if (now=="h1") 
	return "<h1>" str "</h1>"; 
    str = (now == "pre") ? pre(str) : text(str);  
    if (headingp(i)) { 
	sub(/[hH]/,"",now)
	level = now + 0;
	toc(level,str,++L);
	return "<a name=\"" L "\"></a><h" level ">" str "</h" level ">";
    }
    else 
	return str 
}
function prep(now,str,   n,i,tmp) {
  if(now ~ /^h/) {
    gsub(/^=*/,"",str);
    gsub(/=*$/,"",str);
  } else if(now ~/^H/) {
      str = trim(str);
      gsub(/\n.*/,"",str);
  } else if (sub(/^@uses[ \t]/,"",str)) {
      n=split(str,tmp,/[ \t]+/);
      str=""
      for(i=1;i<=n;i++)
	  str = str "[?" tmp[i] " " tmp[i] "] "
  }
  return str;
}
function pre(x) {
  gsub("<","\\&lt;",x);
  return x;
}
function text(x,  n) {
    n += gsub(/\\\[/,"!!OpEn!!",x);
    n += gsub(/``/,"!!TickTiCk!!",x);
    n += gsub(/\\]/,"!!ClOsE!!",x);
    n += gsub(/\\\*/,"!!StAr!!",x);
    n += gsub(/\\_/,"!!DaSh!!",x);
    n += gsub(/\\`/,"!!TiCk!!",x);
    x = gensub(/_([^_]+)_/, "<em>\\1</em>", "g", x);
    x = gensub(/\*([^\*]+)\*/, "<strong>\\1</strong>", "g", x);
    x = gensub(/`([^`]+)`/, "<tt>\\1</tt>", "g", x);
    x = gensub(/\[([^ ]+(jpg|gif|png)) ([^\]]+)\]/,  "<img \\3 src=\"\\1\">","g",x)
    x = gensub(/\[([^ ]+(jpg|gif|png))\]/,  "<img src=\"\\1\">","g",x)
    x = gensub(/\[([^ ]+) ([^\]]+)\]/,"<a href=\"\\1\">\\2</a>", "g", x);
    x = gensub(/\[([^ ]+)\]/,"<a href=\"\\1\">\\1</a>", "g", x);
    if (n) {
        gsub(/!!OpEn!!/,"[",x);
        gsub("!!ClOsE!!","]",x);
        gsub(/!!StAr!!/,"*",x);
        gsub(/!!DaSh!!/,"_",x);
        gsub(/!!TiCk!!/,"`",x);
        gsub(/!!TickTiCk!!/,"``",x);
    }
    return x
}
function toc(n,str, l, pad) {
  if (P[2])
  	P[2] = P[2] "\n"
  while(n-- > 2) 
  	pad = pad " ";
  P[2] = P[2]  pad "+ <a href=\"#" l "\">" str "</a>"
}
function prefix(b4,now) {
    if (now ~ /(^[hH]|l$)/) 
	return  (b4 ~/(pre|p)/) ? "</" b4 ">" : ""
    if (b4 ~ /(l$|^[hH])/)
	return "<" now ">";
    if (b4=="pre")    
	return now=="pre" ? "\n" : "</pre>\n<" now ">";
    return now=="pre" ? "</" b4 ">\n<pre>"  : "</" b4 ">\n<p>"
}
function list(str,  line,n, i,b4,now,out,item,j,k,line0,tmp,what) { 
    #print "str " str
    b4 = 0
    what = (str ~ /^[ \t]*[0-9]/) ? "ol" : "ul"
    gsub(/\n[ \t]+$\n/,"<p>\n",str)
    n = split(str,line0,/\n/);
    for(i=1;i<=n;i++) {
	item     = line0[i]
	j       += item ~ /[ \t]*([0-9]*\.|[\+\*-])[ \t]/
        line[j]  = line[j]  item ;
    }
    for(i=1;i<=j;i++) {
	item = line[i]
	split(item,tmp,/([\+\*-]|[0-9])/)
	now = length(tmp[1]) + 1
	#print "i " i " item " item " tmp2 [" tmp[1] "] now " now
	sub(/^[ \t]*([0-9]*\.|[\+\*\-])/,"",item)
	for(k=b4;k>now;k--) 
	    out = out "</" what ">\n";
	for(k=b4;k<now;k++) 
	    out = out "<" what ">\n";
	out = out  "<li>" item "\n"
	b4 = now
    }
    for(i=b4;i>=1;i--) 
	out = out  "</" what ">";
    return out;
}
function trim(s) {
    gsub(/^[ \t]*/,"",s);
    gsub(/[ \t]*$/,"",s);
    return s
}
function o(a, str,n,   i) {
  if(n)
    for(i=1;i<=n;i++)
      print str "[" i "] = [" a[i] "]"
  else  
    for(i in a)
      print str "[ " i " ] = [ " a[i] " ]" | "sort -k 2"
}

