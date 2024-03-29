## -*- mode: Awk; -*-  vim: set filetype=awk : 

#queryString

#The URL of a Penny page contains a little language. This language allows for the
#convenient reference of web pages.

#* _?page_              : returns _page.html_. 
#* _?Tag_               : returns all pages with a certain _Tag_.
#* _?Tag1&Tag2&..._     : returns all pages with all off _Tag1_ and _Tag2_ and ...
#* _?page&Tag1&Tag2&tile=X... : returns page, then all the other pages tagged with 
#                         _Tag1_ etc. The title of this page is X.
#                         This is useful for generating a report
#			 with a header page on top, followed by pages of details.
#			 Note that if _page_ has _Tag1_ etc, then it is only 
#                         printed once.

#At a first approximation, _Tags_ start with upper case and everything is a _page_.
#However, there are exceptions:

#* anything containing _.html_ is a page.
#* anything containing a "_/"_ is a page.

#Code
#====

#Uses 
#----

#@uses deShell stack o

#Demo
#----

 function testQueryString(tagsFile,str,     files,titles,tags,sgat,out) {
     loadTags(tagsFile,files,titles,tags,sgat)
     print queryString1(str,tags,files,titles,sgat,out)
     o(out,"out")
 }

#Code 
#----

## stag to tags

 function queryString(tags,files,titles,sgat,out) {
     queryString(ENVIRON["QUERY_STRING"],tags,files,titles,sgat,out) 
 }
 function queryString1(query,tags,files,titles,sgat,out,   \
                       var,used,seen,cats,n,tmp,i,is,title) {
   n = split(query,tmp,"&");
   for(i=1;i<=n;i++) {
        tmp[i] = qprepVar(tmp[i])
        is[i] = qrecognizer(tmp[i])
        if (is[i] == "category") cats++
   }
   for(i=1; i<=n; i++) {
     var = tmp[i];
     if (is[i]=="title")     
         title = qtitle(var);
     if (is[i]=="file")     
         title = title " " qfile(var,tags,1,        seen,used,files,titles,sgat,out);
     if (is[i]=="shortcut") 
         title = title " " qshortcut(var,tags,1,    seen,used,files,titles,sgat,out);
     if (is[i]=="category") 
         title = title " " qcategory(var,tags,cats, seen,used,files,titles,sgat,out);
   } 
   return title; 
 }
 function qprepVar(var) { 
   var = trim(var);
   gsub(/_/,".",var);
   gsub(/\+/," ",var);
   return deShell(var);
 }
 function qrecognizer(var) {
   if (var ~ /^title=/) return "title";
   if (var ~ /^[a-z_0-9]/) {
     if (var ~ /\//     ) return "file";
     if (var ~ /\.html$/) return "file";
     return "shortcut";
   }
   return "category";
 }
 function qtitle(var,  tmp) {
     split(var,tmp,"=")
     return trim(tmp[2])
 }
 function qshortcut(var,tags,needs,seen,used,files,titles,sgat,out) { # shortcut to file 
   var=  (var in files) ? files[var] : tags["NotFound"];
   return qfile(var,tags,needs,seen,used,files,titles,sgat,out);
 }	
 function qfile(var,tags,needs,seen,used,files,titles,sgat,out,   title) { # add file
   title=" ";
   var = (var in titles) ? var : tags["default"];
   if (++used[var] == needs ) 
       if(++seen[var] ==  1) {
           push(out,var);
           title = " " titles[var]; }
   return title;
 }
 function qcategory(var,tags,needs,seen,used,files,titles,sgat,out,     i,n) {#add files from cats
     n =cards(sgat,var);
     for(i=1;i<=n;i++) 
         qfile(sgat[var,i],tags,needs,seen,used,files,titles,sgat,out);
     return var;
 }

#To do
#=====

#404 error

#Author
#======

#Tim Menzies

