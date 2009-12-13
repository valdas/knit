# gawk -f blat.awk --source 'BEGIN {print myrss("rss;lawker.blogspot.com/feeds/posts/default?alt=rss;5","\n")'}
# wget -q -O - http://lawker.blogspot.com/feeds/posts/default?alt=rss
# <a href="http://lawker.blogspot.com/2009/12/awkinfo-now-top-20-website.html">Dec 02</a>Awk.info now a top-20 website.
# <a href="http://lawker.blogspot.com/2009/12/zork-in-awk.html">Dec 02</a>Praveen Puri offers a Zork-clone, in Awk.
# <a href="http://lawker.blogspot.com/2009/12/sorting-in-awk.html">Dec 01</a>Ed Morton sorts out everything (using Awk)
# <a href="http://lawker.blogspot.com/2009/12/smallest-formatter-ever.html">Dec 01</a>Is this the smartest (smallest) formatter ever written?
# <a href="http://lawker.blogspot.com/2009/11/norvigs-spell-checker-in-awk.html">Nov 30</a>Gregory Grefenstette implements Norvig's spell checker.

# note speed tricks: 
# reading from wget -O - is about twice as fast as wget -O file; cat file
# getline with FS="\n" is ten times faster than if you give a regualr expression
# split is 2-3 times faster on multi-char than single char (depending on the expression)
# the exact speed up is data set dependent but the above tricks reduced the time for
# this rss generation from 0.9 seconds to 0.088 seconds. which is pretty good
# since the wget fetch time is 0.08 seconds

function myrss(rss, between, tmp) {
  split(rss,tmp,";");
  return myrss1(tmp[2],tmp[3],between);
}

function myrss1(feed,max,  between,  n,all,sep,out,date,url,txt,seen) {
  n = slurp("wget -q -O - http://" feed,">",all);
  for(i=1;i<=n; i++) {
    if (all[i] ~ /^<pubDate/) 
      date = myDate(all[i+1])
    else if (all[i] ~ /^<description/) 
      txt = myText(all[i+1])
    else if (all[i] ~ /^<enclosure/) {
      url = myUrl(all[i]);
      out = out sep myReport(url,date,txt);
      sep = between ? between : "\n";
      if (++seen >= max) 
          return out;
    }}
  return out;
}

function slurp(com,sep,all) { slurp0(com); return split($0,all,sep)     }
function slurp0(com)        { RS=""; FS="\n"; com | getline; close(com) }

function myDate(str, tmp)       { split(str,tmp," ");   return tmp[3]  " " tmp[2] } 
function myText(str)            { sub(/&lt;.*/,"",str); return str }
function myUrl(str)             { sub(/<.*/,"",str);    return str }
function myReport(url,date,txt) { return "<a href=\"" url "\">" date "</a>" txt}
