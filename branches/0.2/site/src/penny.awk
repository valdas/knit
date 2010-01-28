## -*- mode: Awk; -*-  vim: set filetype=awk : 

#A minimal CMS. 

#@uses slots tags queryString myrss seed anyStrings barph toc

 function penny(config) {
     return penny1("http://" config,ENVIRON["QUERY_STRING"])
 }
 function penny1(slotsFile,query,     \
                 wget,sep,values,files,titles,tags,sgat,pages,file,url,content,stem,out) {     
     seed()
     wget = "wget -qO - "
     sep="`""`"
     loadSlots(wget slotsFile,sep,values) # get all the short string values
     loadTags(wget values["Tags"],   files,titles,tags,sgat) # get all the page tags
     values["Content"]=""   
     if (query=="sitemap") {
         values["Header"]  = "Contents"
         values["File"]    = "?sitemap" 
         values["Content"] = join2Page(toc(files,titles,tags,sgat),"sitemap")
     } else {
         values["Header"]=queryString1(query,tags,files,titles,sgat,pages) # list pages
         if (pages[0] == 0)
             push(pages,values["Default"])
         for(i=1;i<=pages[0];i++) {
             file     = values["File"] = pages[i]
             stem     = gensub(/.html/,"","g",file)
             url      = values["Url"]  = values["Site"] "/" file
             content = content join2Page(fillFrame2String(wget url,sep,values),stem)
         } 
         values["Content"] = content
     }
     fillFrame(wget values["Template"],sep,values)     
 }
 function join2Page(content,stem) {
     return gensub(/<h1>([^<]*)<\/h1>/,
                   "<h1><a href=\"?"stem"\">\\1</a></h1>",
                   "g",content)
 }
 function slotsPlugIns(string,values,      tmp) {   
     split(string,tmp,";")
     if (tmp[1]=="rss")
         return  "<p id=\"rss\">" myrss(tmp[2],tmp[3],"<p id=\"rss\">")
     if (tmp[1]="any")
         return anyStrings(values[tmp[2]],tmp[3],1)
     barph("(" string ") ???") 
 }

#by Tim Menzies

