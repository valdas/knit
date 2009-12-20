 BEGIN { split("./:" ENVIRON["VPATH"],
         FNR==1  { if (Base) 
	     print fname(Base);
           Base=FILENAME }
         { uses($0)      } 
 END     { print fname(Base) }
 function paths(paths, str,n) {
     str=ENVIRON["VPATH"];
     str = str ? ".:" str : ".";
     n=split(str,paths,/:/);
     paths[0] = n
 }
 function uses(line,    file,x,a) {
     if ( line ~ /^@uses/ ) { 
	 split(line,a);
	 file=a[2];
	 gsub(/\"/,"",name);
         uses1(file);
	 printf("%s ", fname(file)) 
        }
 } 

function uses1(file0,    i,x,found) {
    for(i=1;i<=paths[0];i++) {
	file = paths[i] "/" file0;
	while ((getline x < file) > 0)  {
	    found++;
	    uses(x);
	}
        close(file)
	if (found) return 0
    }
    return found
}
 function fname(f) {
        split(f,tmp,".")
        return Dir "/" tmp[1] "." Ext
}
