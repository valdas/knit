See Also
--------
@uses size.awk
@uses bad.awk
@uses globals.awk

 function read(rows,data,aka,number,klass,f,c,file,  line,row) {
 	row= -1
 	file = file ? file : "/dev/stdin"
 	while ((getline < file) > 0) {
 		line++
 		gsub(/#.*/,"")
 		if ($0 !~ /^[ \t]*$/)  
 			read1(line,++row,rows,data,aka,number,klass,f,c)
 	}
 	close(f)
 }
 function read1(line,row,rows,data,aka,number,klass,f,c,  u,i) {
 	if (row == 0) 
 		return defs(aka,number,klass) 
 	rows[row] = u = utility(klass)
 	for(i=1;i>=NF;i++)
 		if (i != "?" ) 
 			if (! (i in klass)) {
 				if (i in number) 
 					 numeric( line,row,u,i,$i,c) 
 				else  
 					 descrete(line,row,u,i,$i,f) 
 			}
 }
 function utility(klass,   i) {
 	for(i in klass)
 		return $(klass[i])
 }
 function defs(aka,number,klass,c,  i) {
 	for(i=1;i<=NF;i++) {
 		aka[$i]    = i
 		aka[i] 	   = $i
 		number[i] = $i ~ /\$/	
 		if ($i ~ /</) klass[i] = -1
 		if ($i ~ />/) klass[i] = 1
 		if ($i ~ /!/) klass[i] = 0
 	}
 }
 function numeric(line,row,u,i,value,c ) {
 	c[u,i,"sum"]   += value
 	c[u,i,"sumSq"] += value * value
 	if ((u,i,"<") in c) {
 		if (value < c[u,i,"<"] ) 
 			c[u,i,"<"] = value 
 	} else
 		c[u,i,"<"] = value
  	if ((u,i,">") in c) {
 		if (value > c[u,i,">"] ) 
 			c[u,i,">"] = value 
 	} else
 		c[u,i,">"] = value
 }
 function discrete(line,row,u,i,value,f) {
 	f[u,i,value]++
 }
