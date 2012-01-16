#!/bin/sh

printf "Content-type: text/html\n\n\n";
 
date
echo "<pre>"
svn update
echo "</pre>"
chmod u+rx index.cgi
echo "<a href=index.cgi>Continue to site</a>."
