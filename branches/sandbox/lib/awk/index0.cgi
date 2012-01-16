#!/usr/bin/gawk -f 

BEGIN {
	print "Content-type: text/html"
	print ""
	print "<html>"
	print "<head><title>ENVIRON</title></head>"
	print "<body>"
	print "<ul>"
	for(I in ENVIRON) 
		print "<li>" I " = " ENVIRON[I]
	print "</ul>"
	print "</body></html>"
}
