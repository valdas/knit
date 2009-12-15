# tables
# numbered lists

BEGIN       { RS=""; FS="\n";N=1; Is[2]="ul"}
N==1 && 
/^[ \t]*\#/ { next }
$0          { P[N]=$0;
              Is[N]= kind($0,N);
     	      if (N==1) N++; # make room for toc
	      N++;
}
END {   M[1] = markup(1,P[1],"h1");
        for(I=3;I<N;I++)  
	    M[I] = markup(I,P[I],Is[I],Is[I-1]);
	M[N]= complete(Is[N-1])
	M[2] = markup(2,P[2],"ul","h1");
	for(I=1;I<=2;I++)
           print M[I]
}
function kind(s,n) {
  if (n==1)                  return "h1"
  if (s ~ /^ [\*\+\-]/)      return "ul";
  if (s ~ /^ [0-9]\./)       return "ol";
  if (s ~ /^[ /t]/)          return "pre";
  if (s ~ /^===== /)         return "h2";      
  if (s ~ /^==== /)          return "h3";      
  if (s ~ /^=== /)           return "h4";  
  if (s ~ /^==/)             return "H2";    
  if (s ~ /^--/)             return "H3";    
  if (s ~ /^\+\+/)           return "H4"; 
  return "p"
}
function complete(is) {
    return  (is ~ /hH/) ? "" : "</" is ">"
}
function markup(i,str,now,b4, pretty) {
  str = prune(now,str);
  if (now=="h1") 
    return "<h1><join>" str "</join></h1>"; 
  str = (now == "pre") ? pre(str) : text(str);
  if (now ~ /^[hH]/) {
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
  x = gensub(/__([^_]+)__/,     "<strong>\\1</strong>","g", x);
  x = gensub(/\*\*([^\*])+\*\*/,"<strong>\\1</strong>","g", x);
  x = gensub(/_([^_]+)_/,       "<em>\\1</em>",        "g", x);
  x = gensub(/\*([^\*]+)\*/,    "<em>\\1</em>",        "g", x);
  x = gensub(/`([^`]+)`/,       "<tt>\\1</tt>",        "g", x);
  x = gensub(/\[(http:[^ ]+(jpg|gif|png)) ([^\]]+)\]/,  "<img \\3 src=\\1>","g","x")
  x = gensub(/(http:[^ \n\t]+(jpg|gif|png))/,  "<img src=\\1>","g","x")
  x = gensub(/\[[^ ]+) ([^\]]+)\])/,  "<a href=\"\\1>\\2</a>", "g", x);
  gsub("!!StAr!!!","*",x);
  gsub("!!DaSh!!!","_",x);
  gsub("!!TiCk!!!","`",x);
  return x
}
function toc(n,str, pad) {
  if (P[2])
  	P[2] = P[2] "\n"
  while(n-- > 1) 
  	pad = pad " ";
  P[2] = P[2]  pad "+" str 
}
function prefix(b4,now) {
  if (b4 ~ /^[hH]/) return "<!" now ">"
  if (b4=="pre")    return now=="pre" ? "\n" : "</pre>\n<p>";
  return now=="pre" ? "</p>\n<pre>"  : "</p>\n<p>"
}
function lists(str,  line,n, i,b4,now,out,sep) {
    b4 = 1
    gsub(/\n[ \t]+$\n/,"<p>\n",str)
    n = split(str,line0,"\n");
    for(i=1;i<=n;i++) { 
	if (sub(/ [\+\*-][ \t]/,"",line0[i]))
	    j++;
	sep =  line[j] ? "\n" : "";
        line[j] = line[j] sep line0[i];
    }
    for(i=1;i<=j;j++) {
	now = gsub(/[ \t]/,"",line[i])
	for(i=b4;i>=now;i--)
	    out = out  "</ul>";
	for(i=1;i<=now;i++)
	    out = out "<ul>";
	out = out "\n" line[i]
	b4 = now
    }
    for(i=b4;i>=1;i--)
	out = out  "</ul>";
    return out;
}
function o(a, str,n,   i) {
  if(n)
    for(i=1;i<=n;i++)
      print str "[ " i " ] = [ " a[i] " ]"
  else  
    for(i in n)
      print str "[ " i " ] = [ " a[i] " ]" | "sort -k 2"
}



