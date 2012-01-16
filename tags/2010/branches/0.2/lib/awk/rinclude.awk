 {inc($0,0) }
 function inc(str,depth,   line) {
	 if (depth > 10) { 
		print "[" str "] too deep" 
	} else {
		if ( str ~ /^@include/ ) { 
			depth++
	 		while ((getline line < $2) > 0)  
	     		inc(line,depth);
	   		close(file)
		} else 
			print (depth > 0 ? "  " : "") str
	}
 }
