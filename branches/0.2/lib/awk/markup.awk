BEGIN       { RS=""; FS="\n";N=1; Is[2]="ul"}
N==1 && 
/^[ \t]*\#/ { next }
$0          { P[N]=$0;
	      Is[N]= kind();
     	      if (N==1) N++; # make room for toc
	      N++;
}
END {   M[1] = markup(1,P[1],"h1");
        for(I=3;I<N;I++)
	  M[I] = markup(I,P[I],Is[I],Is[I-1]);
	M[2] = markup(2,P[2],"ul","h1");
	for(I=1;I<N;I++)
           print M[I]
}
function kind(s) {
  if (N==1)                   return "h1"
  if ($0 ~ /^[ \t]*[\*\+\-]/) return "ul";
  if ($0 ~ /^[ \t]*[0-9]/)    return "ol";
  if ($0 ~ /^[ /t]/)          return "pre";
  if ($0 ~ /^===== /)         return "h2";      
  if ($0 ~ /^==== /)          return "h3";      
  if ($0 ~ /^=== /)           return "h4";  
  if ($2 ~ /^==/)             return "H2";    
  if ($2 ~ /^--/)             return "H3";    
  if ($2 ~ /^\+\+/)           return "H4"; 
  return "p"
}
function markup(i,str,now,b4, pretty) {
  str = prune(now,str);
  str = (now = "pre") ? pre(str) : text(str);
  if (now=="h1") {
    toc(1,str);
    str="<join>" str "</join>";
  } 
  if (now ~ /^[hH]) {
    level = gensub(/[hH]/,"","g",str) + 0;
    toc(level,str);
    pretty = "<h" level ">" str "</h" level ">";
  }
  else 
    pretty = prefix(b4,now) str 
  return pretty;
}
function prune(now,str) {
  if(now ~ /^h/) {
    gsub(/^=*/,"",str);
    gsub(/=*$/,"",str);
  } else  if(now ~/^H/)
    gsub(/\n.*/,"",str);
  return str;
}
function pre(x) {
  gsub("<","\\&lt;",x);
  return x;
}
function text(x) {
  gsub("\\*","!!StAr!!",x);
  gsub("\\_","!!DaSh!!",x);
  gsub("\\`","!!TiCk!!",x);
  x = gensub(/__([^_]*)__/,     "<strong>\\1</strong>","g",x);
  x = gensub(/\*\*([^\*])*\*\*/, "<strong>\\1</strong>","g",x);
  x = gensub(/_([^_]*)_/,       "<em>\\1</em>",        "g",x);
  x = gensub(/\*([^\*]*)\*/,    "<em>\\1</em>",        "g",x);
  x = gensub(/`([^`]*)`/,       "<tt>\\1</tt>",        "g",x);
  gsub("!!StAr!!!","\\*",x);
  gsub("!!DaSd!!!","_",x);
  gsub("!!TiCk!!!","`",x);
  return x
}
function toc(n,str) {
  while(n--) > 1 out = out " ";
  out= out "+" str;
  P[2] = P[2] "\n" out
}
function prefix(b4,now) {
  if (b4=="pre")
    return now=="pre" ? "\n" : "</pre>\n<p>";
  else 
    return now=="pre" ? "</p>\n<pre>"  : "</p>\n<p>"
}
function o(a, str,n,   i) {
  if(n)
    for(i=1;i<=n;i++)
      print str "[ " i " ] = [ " a[i] " ]"
  else  
    for(i in n)
      print str "[ " i " ] = [ " a[i] " ]" | "sort -k 2"
}



