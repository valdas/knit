 FNR==1  { if (Base) print fname(Base) 
 		   Base=FILENAME }
         { uses($0)      } 
 END     { print fname(Base) }
 
 function uses(line,    file,x,a) {
     if ( line ~ /^@uses/ ) { 
       	split(line,a)
 	 	file=a[2]
 		gsub(/\"/,"",name)
    	while ((getline x < file) > 0) 
 			uses(x);
    	close(file) 
 		printf("%s ", fname(file)) 
 	}
 } 
 function fname(f) {
	split(f,tmp,".")
	return Dir "/" tmp[1] "." Ext
}
