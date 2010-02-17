# TINY TIM: a tiny web-site manager. 
# copyright (C) 2010 by Tim Menzies,  tim@menzies.us.
#
# TINY TIM is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# TINY TIM is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with TINY TIM.  If not, see <http://www.gnu.org/licenses/>.

BEGIN { RS="\r\r\n"; FS="\r\r\n";Sep="`""`" ;
    getline All
    N=split(All,Lines,/#12345/)
    loadSlots(Lines[1],Sep,Slots)
    for(I=2;I<=N;I++)
        if (Lines[I])
            read(Lines[I],Page,Tags,Title)
    print "Content-Type: text/html\n\n"
    print dump(Sep,Slots,Page,Tags,Title,ENVIRON["QUERY_STRING"]) 
}
function read(str,page,tags,title,  lines,name,tmp,i,n) {
    split(str,lines,"\n")
    name = lines[3]
    title[name]=lines[6]
    n=split(trim(lines[4]),tmp,/[ \t]/)
    for(i=1;i<=n;i++) {
        tags[tmp[i], ++tags[tmp[i],0]] = name
        tags[name, ++tags[name,0]] = tmp[i]
    }
    page[name]=str
}
function dump(sep,slots,page,tags,title,want,  between,i,template) {
    want = want ? want : "index"
    if (want ~ /^[A-Z].*/)   {
        slots["Title"]=  want
        for(i=1;i<=tags[want,0]; i++)  {
            slots["Content"] = slots["Content"] between dump1(tags[want,i],page,tags,slots)
            between="<br clear=all><hr>"
        }
    } else  {
        slots["Title"]=title[want]
        slots["Content"] = dump1(want,page,tags,slots) "<br clear=all>"
    }
    template = page["template"]
    sub(/^[^<]+</,"<",template)
    return fill(template,sep,slots) 
}
function loadSlots(string,sep,slots,   n,i,all) {
    n=split(string,all,sep)
    for(i=2; i<=n; i += 2) 
        slots[trim(all[i])] = trim(all[i+1]);
}
function fill(string,sep,slots,   all,n,i,str) {
    n=split(string,all,sep);
    for(i=1; i<=n; i++)  
        str = str sprintf("%s", i % 2 ? all[i] : fillSlot(slots[all[i]],slots))
    return str
} 
function fillSlot(str,slots) {
    return (str ~ /;/ ? slotsPlugIns(str,slots) : slots[str])
 }
function dump1(want,page,tags,slots) { 
    return want in page ? render(want,page,tags,slots) : render(404,page,tags,slots) 
}
function render(want,page,tags,slots) {
    return pageStart(want,tags) join2Page(want,markup(page[want],slots))
}
function pageStart(want,tags,   n,q,i,out,sep) {
    n   = tags[want,0]
    q="\""
    for(i=1;i<=tags[want,0];i++) {
        out = out sep "<a href=" q "?" tags[want,i] q ">" tags[want,i] "</a>"
        sep = ", " 
    }
    return  "<p class="q"tags"q" >tags: "out"</p>"        
}
function markup(str,slots,     com,line,out,tmp) {
    tmp= "/tmp/tmp" PROCINFO["pid"]
    com = "gawk -f " slots["formatter"] " > " tmp
    print str | com 
    close(com)
    while((getline line < tmp) > 0)
        out = out "\n" line
    close(tmp)
    system("rm " tmp)
    return out
}
function join2Page(want,str) {
    return gensub(/<h1>([^<]*)<\/h1>/,
                  "<h1><a href=\"?"want"\">\\1</a></h1>",
                  "g",str)
}
function trim(s)  { 
    sub(/^[ \t\r\n]*/,"",s); sub(/[ \t\r\n]*$/,"",s); return s 
} 
function o(a, str,n,   i,com) {
    com="sort -n -k 2"
    if(n)
        for(i=1;i<=n;i++)
            print str "[" i "] = [" a[i] "]"
    else { 
        for(i in a)
            print str "[ " i " ] = [ " a[i] " ]" | com
        close(com)
    }
}
