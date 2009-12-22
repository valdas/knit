# search for woks. convert them to $HOME/lib/var

 BEGIN   { setup(Paths) }
         { uses($0)      } 
 END     { print FILENAME }

 function setup(paths, str,n) {
     Base=FILENAME;
     str=ENVIRON["AWKPATH"];
     str = str ? ".:" str : ".";
     n=split(str,paths,/:/);
     paths[0] = n
 }
 function uses(line,    file,x,a) {
     #print FNR " " line;
     if ( line ~ /^@uses/ ) { 
	 split(line,a);
	 file=a[2];
	 gsub(/\"/,"",file);
         uses1(file);
	 print "{" file "," line "}"
        }
 } 
 function uses1(file0,    i,line,found) {
    for(i=1;i<=Paths[0];i++) {
	file = Paths[i] "/" file0;
	while ((getline line < file) > 0)  {
	    found++;
	    print found " [" line "]"
	    uses(line);
	}
        close(file)
	if (found) 
	    return 0
    }
    if (! found) 
	barph(file0 " not found")
}
 function barph(str) {
     print "# ERROR: " str  >> "/dev/stderr"
     fflush("/dev/stderr")
     exit 1
 }
