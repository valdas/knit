	BEGIN {
		env = "none";
		text = "";
		Para = 1;
		Last = 2
	}
        /^[ t]*$/ { Para++ }
        Para == 1 { next }


	/^!\[.+\] *\(.+\)/ {
		split($0, a, /\] *\(/);
		split(a[1], b, /\[/);
		imgtext = b[2];
		split(a[2], b, /\)/);
		imgaddr = b[1];
		Body = Body "<p><img src=\"" imgaddr "\" alt=\"" imgtext "\" title=\"\" /></p>\n";
		text = "";
		next;
	}
	/\] *\(/ {
		do {
			na = split($0, a, /\] *\(/);
			split(a[1], b, "[");
			linktext = b[2];
			nc = split(a[2], c, ")");
			linkaddr = c[1];
			text = text b[1] "<a href=\"" linkaddr "\">" linktext "</a>" c[2];
			for(i = 3; i <= nc; i++)
				text = text ")" c[i];
			for(i = 3; i <= na; i++)
				text = text "](" a[i];
			$0 = text;;
			text = "";
		}
		while (na > 2);
	}  
        function closeHeaders(this,last) {  for(i=last;i> this; i--)   Contents = Contents "\n" "</ul>" }
        function openHeaders(this,last)  {  for(i=last;i< this; i++)  Contents = Contents "\n" "<ul>" }
	/^=+[ \t]*$/ {
		Headers++
		Body = Body "\n" "<a name=\""Headers"\"><h2>" text "</h2></a>\n";
		closeHeaders(2,Last)
                openHeaders(2,Last)
		Contents = Contents "\n" "<li><a href=\"#"Headers"\">" text "</a></li>" 
		Last = 2
		text = "";
		next;
	}
	/^-+[ \t]*$/ {
		Headers++
		Body = Body "\n" "<a name=\""Headers"\"><h3>" text "</h3></a>\n";
		closeHeaders(3,Last)
                openHeaders(3,Last)
		Contents = Contents "\n" "<li><a href=\"#"Headers"\">" text "</a></li>"
		Last=3
		text = "";
		next;
	}
	/^__+[ \t]*$/ {
		Headers++
		Body = Body "\n"  "<a name=\""Headers"\"><h4>" text "</h4></a>\n";
		closeHeaders(4,Last)
                openHeaders(4,Last)
		Contents = Contents "\n" "<li><a href=\"#"Headers"\">" text "</a></li>" 
		Last=4
		text = "";
		next;
	}	
    /^\.+[ \t]*$/ {
		Headers++
		Body = Body "\n"  "<a name=\""Headers"\"><h5>" text "</h5></a>\n";
		closeHeaders(5,Last)
                openHeaders(5,Last)
		Contents = Contents "\n" "<li><a href=\"#"Headers"\">" text "</a></li>" 
		Last=5;
		text = "";
		next;
	}
	/^#/ {
		match($0, /#+/);
		n = RLENGTH;
		if(n > 6)
			n = 6;
		Body = Body "\n"  "<h" n ">" substr($0, RLENGTH + 1) "</h" n ">\n";
		next;
	}
	/`/ {
		while (match($0, /`/) != 0) {
			if (env == "tt") {
				sub(/`/, "</tt>");
				env = pcenv;
			}
			else {
				sub(/`/, "<tt>");
				pcenv = env;
				env = "tt";
	}   }   }
	/_/ && text ~ /^[ \t]/  {
		while (match($0, /_/) != 0) {
			if (env == "em") {
				sub(/_/, "</em>");
				env = peenv;
			}
			else {
				sub(/_/, "<em>");
				peenv = env;
				env = "em";
	}   }   }
	/^[ \t]*[+].*:/ {
		if (env == "none") {
			env = "dl";
			Body = Body "\n"  "<dl>";
		}
		if (text) Body = Body "\n"  text "</dd>"
		sub(/^[ \t]*[+]/,"");
		sub(/:/,"</dt><dd>");
		Body = Body "\n"  "<dt>" $0  ;
		text = "";
		next;
	}
	/^[ \t]*[+]/ {
		if (env == "none") {
			env = "ul";
			Body = Body "\n"  "<ul>";
		}
		if (text) Body = Body "\n"  text 
		sub(/^[ \t]*[+]/,"");
		Body = Body "\n"  "<li>" $0  ;
		text = "";
		next;
	}
	/^[0-9]./ {
		if (env == "none") {
			env = "ol";
			Body = Body "\n"  "<ol>";
		}
		Body = Body "\n"  "<li>" substr($0, 3) "</li>";
		next;
	}
	/^[ \t]*$/ {
		if (env != "none") {
			if (text)
				Body = Body "\n"  text;
			text = "";
			Body = Body "\n"  "</" env ">\n";
			env = "none"; 
	} }
	/^[ \t]*$/ {
		paraOrPre()
		next;
	}
	// {
		text = (text ? text "\n" : "" ) $0;
	}
	END {
	        if (env != "none") {
	                if (text)
	                        Body = Body "\n"  text;
	                text = "";
	                Body = Body "\n"  "</" env ">\n";
	                env = "none";
	        }
		paraOrPre();
		text = "";
		closeHeaders(1,Last)
		print Top
		print "<ul>" Contents 
		print Body
	}
	function paraOrPre() {
	  if (text) {
	    if (Para==3) 
	      Top = "<h1><join>"text"</join></h1>\n";
	    else if (text ~ /^[ \t]/) {
	      gsub(/</,"\\&lt;",text);
	      Body = Body "\n"  "<pre>" text "</pre>\n";
	    } else 
	      Body = Body "\n"  "<p>" text "</p>\n";
	  }
	  text = "";
	}

