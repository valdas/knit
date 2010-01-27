## -*- mode: Awk; -*-  vim: set filetype=awk : 

#A minimal CMS.

#@uses slots tags queryString myrss seed anyStrings barph

 function penny(config) {
     return penny1("http://" config,ENVIRON["QUERY_STRING"])
 }
 function penny1(slotsFile,query,     \
                 wget,sep,values,files,titles,tags,sgat,pages,file,url,content,content0,stem,out) {     
     seed()
     wget = "wget -qO - "
     sep="``"
     loadSlots(wget slotsFile,sep,values) # get all the short string values
     loadTags(wget values["Tags"],   files,titles,tags,sgat) # get all the page tags
     values["Header"]=queryString1(query,tags,files,titles,sgat,pages) # list pages
     values["Content"]="" 
     if (pages[0] == 0)
         push(pages,values["Default"])
     for(i=1;i<=pages[0];i++) {
         file     = values["File"] = pages[i]
         stem     = gensub(/.html/,"","g",file)
         url      = values["Url"]  = values["Site"] "/" file
         content0 = fillFrame2String(wget url,sep,values)
         content0 = gensub(/<h1>([^<]*)<\/h1>/,"<h1><a href=\"?"stem"\">\\1</a></h1>","g",content0)
         content  = content content0
     }
     values["Content"] = content
     fillFrame(wget values["Template"],sep,values)     
 }

 function slotsPlugIns(string,values,      tmp) {   
     split(string,tmp,";")
     if (tmp[1]=="rss")
         return  "<p id=\"rss\">" myrss(tmp[2],tmp[3],"<p id=\"rss\">")
     if (tmp[1]="any")
         return anyStrings(values[tmp[2]],tmp[3],1)
     barph("(" string ") ???") 
 }

