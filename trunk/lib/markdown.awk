	BEGIN {
		env = "none";
		text = "";
	}
	/^!\[.+\] *\(.+\)/ {
		split($0, a, /\] *\(/);
		split(a[1], b, /\[/);
		imgtext = b[2];
		split(a[2], b, /\)/);
		imgaddr = b[1];
		print "<p><img src=\"" imgaddr "\" alt=\"" imgtext "\" title=\"\" /></p>\n";
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
	/^=+[ \t]*$/ {
		Headers++
		print "<a name=\""Headers"\"><h1>" text "</h1></a>\n";
		Contents = Contents "\n" "<h1><a href=\"#"Headers"\">" text "</a></h1>" 
		text = "";
		next;
	}
	/^-+[ \t]*$/ {
		Headers++
		print "<a name=\""Headers"\"><h2>" text "</h2></a>\n";
		Contents = Contents "\n" "<h2><a href=\"#"Headers"\">" text "</a></h2>"
		text = "";
		next;
	}
	/^__+[ \t]*$/ {
		Headers++
		print "<a name=\""Headers"\"><h3>" text "</h3></a>\n";
		Contents = Contents "\n" "<h3><a href=\"#"Headers"\">" text "</a></h3>" 
		text = "";
		next;
	}	
    /^\.+[ \t]*$/ {
		Headers++
		print "<a name=\""Headers"\"><h4>" text "</h4></a>\n";
		Contents = Contents "\n" "<h4><a href=\"#"Headers"\">" text "</a></h4>" 
		text = "";
		next;
	}
	/^#/ {
		match($0, /#+/);
		n = RLENGTH;
		if(n > 6)
			n = 6;
		print "<h" n ">" substr($0, RLENGTH + 1) "</h" n ">\n";
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
	/_/ {
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
			print "<dl>";
		}
		if (text) print text "</dd>"
		sub(/^[ \t]*[+]/,"");
		sub(/:/,"</dt><dd>");
		print "<dt>" $0  ;
		text = "";
		next;
	}
	/^[ \t]*[+]/ {
		if (env == "none") {
			env = "ul";
			print "<ul>";
		}
		if (text) print text 
		sub(/^[ \t]*[+]/,"");
		print "<li>" $0  ;
		text = "";
		next;
	}
	/^[0-9]./ {
		if (env == "none") {
			env = "ol";
			print "<ol>";
		}
		print "<li>" substr($0, 3) "</li>";
		next;
	}
	/^[ \t]*$/ {
		if (env != "none") {
			if (text)
				print text;
			text = "";
			print "</" env ">\n";
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
	                        print text;
	                text = "";
	                print "</" env ">\n";
	                env = "none";
	        }
			paraOrPre()
	        text = "";
			if (Contents) 
				print "<div id=\"timtoc\">\n" Contents "\n</div>">Toc
	}
	function paraOrPre() {
		if (text) {
			if (text ~ /^[ \t]/)
				print "<pre>" text "</pre>\n"
			else 
				print "<p>" text "</p>\n"
		}
		text = "";
	}

