# gawk -f blat.awk --source 'BEGIN {print myrss("rss;lawker.blogspot.com/feeds/posts/default?alt=rss;5","\n")'}
# wget -q -O - http://lawker.blogspot.com/feeds/posts/default?alt=rss
# <a href="http://lawker.blogspot.com/2009/12/awkinfo-now-top-20-website.html">Dec 02</a>Awk.info now a top-20 website.
# <a href="http://lawker.blogspot.com/2009/12/zork-in-awk.html">Dec 02</a>Praveen Puri offers a Zork-clone, in Awk.
# <a href="http://lawker.blogspot.com/2009/12/sorting-in-awk.html">Dec 01</a>Ed Morton sorts out everything (using Awk)
# <a href="http://lawker.blogspot.com/2009/12/smallest-formatter-ever.html">Dec 01</a>Is this the smartest (smallest) formatter ever written?
# <a href="http://lawker.blogspot.com/2009/11/norvigs-spell-checker-in-awk.html">Nov 30</a>Gregory Grefenstette implements Norvig's spell checker.

function myrss(rss, between, tmp) {
  split(rss,tmp,";");
  return myrss1(tmp[2],tmp[3],between);
}
function slurp(com,sep) { 
  RS=""; FS=(sep ? sep : Sep); com | getline; close(com) 
}
function myrss1(feed,max,  between,  sep,out,date,url,txt,seen) {
  slurp("wget -q -O - http://" feed,"[<>]");
  between = between ? between : "\n"
  for(i=1;i<=NF; i++) {
    if (seen >= max) 
      return out
    if ($i ~ /^pubDate/) {     
      date = $(i+1);
      split(date,tmp," ");
      date = tmp[3] " " tmp[2];
    }
    if ($i ~ /^description/) {
      	txt=$(i+1)
	sub(/\&lt;.*/,"",txt);
    }
    if ($i ~ /^enclosure/) {
        seen++
	url = $(i+3)
	out = out  sep "<a href=\"" url "\">" date "</a>" txt;
	sep = between ;
  }}
  return out
}
