 BEGIN   { setup(Paths,ENVIRON["AWKPATH"]) }
         { uses($0)      } 
 END     { print FILENAME }

 function setup(paths, str, sep,n) {
     Base=FILENAME;
     sep = str ? ":" : ""
     str = "." sep str 
     n=split(str,paths,/:/);
     paths[0] = n
 }
 function uses(line,    i,n,file,x,a) {
     if ( line ~ /^@uses/ ) { 
	 n=split(line,a,/[ \t]+/);
	 for(i=2;i<=n;i++) {
	     file=a[i];
	     gsub(/[\" \n\r\t]/,"",file);
	     if (file) {
		 file = file ~ /\.wak$/ ? file : file ".wak";
		 if  (++Seen[file] == 1)
		     uses1(file)
 }}}}
 function uses1(file0,    file,i,line,found) {
     for(i=1;i<=Paths[0];i++) {
	 file = Paths[i] "/" file0;
	 while ((getline line < file) > 0)  {
	     found++;
	     uses(line);
	 }
	 close(file)
	 if (found) { # if ever found, print, exit
	     print file0
	     Seen[file0]++
	     return 1
     }}
     # if never found, die screaming
     assert(found, file0 " not found")
 }
 function assert(check, str) { 
     if (! check) barph(str) 
 }
 function barph(str) {
     print "# ERROR: " str   >> "/dev/stderr";
     fflush("/dev/stderr");
     exit 1; 
 }
