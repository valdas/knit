/^[ \t]*$/   { dump(); next; }
             { text = (text ? text "\n" : "" ) $0 }
END          { dump() }

function dump() {
      if (text) {
          if (text ~ /^[ \t][^ \t]/)
                 print text "\n"
          else  {
                gsub(/\n/,"\n" Comment,text)
                print Comment text "\n" } }
          text = "";
}  
