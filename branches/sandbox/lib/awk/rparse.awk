BEGIN { Max=10; RS=""; FS="[<>]"; }

{ for(i=1;i<=NF;i++)  {
  if (Seen > Max) exit
  if ($i=="title") title = $(i+1) 
  if ($i=="description") description = $(i+1) 
  if ($i ~ /^enclosure/) {
  	Seen++
    sub(/.*url=./,"",$i);
    sub(/. .*/,   "",$i);
    sub(/\&lt;div.*/,"",description);		     
    print "\n<p><a href=\"" $i "\">" title "</a>\n" description
}}}
