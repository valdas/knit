## -*- mode: Awk; -*-  vim: set filetype=awk : 

#myrss

#Simple formatter of an RSS stream.

#Synopsis
#========

#    myrss(url,N  [,between])

#Returns the first _N_ items from an rss feed at _url_. 

#The functional optionally accepts a between string that is printed
#between each item. For example, the _demoRss_ function shown below
#prints a "&lt;li>" between each RSS item; i.e. it converts a text
#string into an HTML list.

#The code includes a generic loop for reading the stream and a set of
#_formatting functions_ that lets a programmer change the presentation
#of the stream.

#Tips
#====

#When formatting an RSS feed, it it useful to view its
#structure. The following command will show that structure. 

#  Url="somUrl";  wget -q -O - "http://$Url"  | tidy -xml -i 

#Note that _myRss_ imports the above into an array _all_, split on ">"
#(see the function _myRss1_).

#Code
#====

#Demo
#----

 function demoRss() {  
     print "<ul>"
     print  "<li>" myrss("lawker.blogspot.com/feeds/posts/default?alt=rss",
			 5,
			 "\n<li>")  
     print "</ul>"
 }

#Outputs:

#  <ul>
#  <li><a href="http://awk.info/poll/">Dec 26</a>
#    Arnold Robbins asks this community to comment on 
#    different methods to implement file inclusion in Gawk.
#  <li><a href="http://awk.info/?tools/server">Dec 26</a>
#    Michael Sanders implements a web server, in very few lines, using Gawk.
#  <li><a href="http://awk.info/?j">Dec 26</a>
#    Ed Morton and Kenny McCormack show us Awk's  equivalent to VI's "J" command.
#  <li><a href="http://awk.info/?wst">Dec 26</a>
#    Dan Nielsen shows us how to draw Sierpinski Triangles.
#  <li><a href="http://awk.info/?tools/adoc">Dec 26</a>
#    Peter Ivanyi and Roman Putanowicz generate Latex doco from program comments.
#  </ul>

#Uses 
#----

#@uses wget trim

#Main 
#----

 function myrss(feed,max,between,              \
                 date,url,author,link,txt,title,	\
                n,all,sep,out,seen,x,i) {
     n = wget(feed,all,">");
     for(i=1;i<=n; i++) {
	 x= all[i]= trim(all[i])
         # parse the items
	 if      (x ~ /^<pubDate/ )    date   = myDate(all,i)
	 else if (x ~ /^<description/) txt    = myText(all,i)
	 else if (x ~ /^<title/)       title  = myField(all,i)
	 else if (x ~ /^<author/)      author = myField(all,i)
	 else if (x ~ /^<link/)        link   = myField(all,i)
	 else if (x ~ /^<enclosure/)   url    = myEnclosure(all,i);
         # if we have everything, generate an output
	 if (date && txt && title && author && link && url) {
	     out = out sep myReport(url,date,title,author,link,txt);
	     sep = between ? between : "\n";
	     date = txt = title = author = link = url = ""
	     if (++seen >= max) 
		 return out;
	 }}
     return out;
 }

#Formatting
#-----------

#Modify the following formatting functions to change the appearance of
#each field.

#_MyField_ is the simplest formatter and will suffice for many fields.

 function myField(all,i,    str) {
     str = all[i+1] 
     sub(/<.*/,"",str);    
     return str 
 }

#The other formatters handle special kinds of fields.  Note that the
#folowing code handles the fields seen in the feed I was processing
#when I wrote this script.  You may need something else to handle the
#quirks of the feeds you are processing.

 function myDate(all,i, tmp) {
    split(all[i+1],tmp," ");   
    return trim(tmp[3]  " " tmp[2])
 } 
 function myText(all,i,    str) {
     str = all[i+1] 
     sub(/&lt;.*/,"",str); 
     return trim(str) 
 }
 function myEnclosure(all,i,   tmp) {
     split(all[i],tmp,/'/);
     return trim(tmp[4])
 }

#Reporter
#--------

#Modify the following reporting function to change the final output of
#the itenm. Note that every field found by _myrss1_ is passed to the function. 

#Feel free to ignore all the arguments except the ones you want to display.

 function myReport(url,date,title,author,link,txt) {
     return "<a href=\"" url "\">" date "</a>:\n " txt
 }

#Author
#======

#Tim Menzies

