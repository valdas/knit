# search for woks. convert them to $HOME/lib/var

 BEGIN   { setup(Paths);
           Ext = Ext ? Ext : ".awk";
           Base=FILENAME }
         { uses($0)      } 
 END     { print FILENAME }

 function setup(paths, str,n) {
     str=ENVIRON["Knitting"];
     str = str ? ".:" str : ".";
     n=split(str,paths,/:/);
     paths[0] = n
 }
 function uses(line,  path,   file,x,a) {
     path = path ? path "/" : ""
     if ( line ~ /^@uses/ ) { 
	 split(line,a);
	 file=a[2];
	 gsub(/\"/,"",name);
         uses1(file);
	 print path line Ext
        }
 } 
 function uses1(file0,    i,x,found) {
    for(i=1;i<=paths[0];i++) {
	file = paths[i] "/" file0;
	while ((getline x < file) > 0)  {
	    found++;
	    uses(x, paths[i]);
	}
        close(file)
	if (found) 
	    return 0
    }
    return found
}
 function fname(f) {
     split(f,tmp,".");
     return Dir "/" tmp[1] "." Ext;
 }
